; REQUIRES: solver

; RUN: llvm-as -o %t %s
; RUN: %souper %solver -check %t

declare i32 @llvm.ctpop.i32(i32) nounwind readnone

define void @foo(i32 %x, i32 %y) {
entry:
  %pop1 = call i32 @llvm.ctpop.i32(i32 %x)
  %notx = xor i32 %x, -1
  %pop2 = call i32 @llvm.ctpop.i32(i32 %notx)
  %sum = add i32 %pop1, %pop2
  %cmp2 = icmp eq i32 %sum, 32, !expected !1
  %shift = lshr exact i32 %x, %y
  %pop3 = call i32 @llvm.ctpop.i32(i32 %shift)
  %cmp3 = icmp eq i32 %pop1, %pop3, !expected !1
  ret void

}

!1 = metadata !{ i1 1 }

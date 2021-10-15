Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321A342EC53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhJOIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhJOIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:30:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D147C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:28:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so7937312pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4vjriK4j7SYSPAYD2GgQajbIly7Gj9EsG6tWp6krCA=;
        b=eZJRBRDra2Q62ejO0XFkKL+i0Tfl5QOIwb+X9TyLRm5rDGyLmCrGLwyZhX6qc9jRQA
         1ry4qKMNcgFOBesaZAwI7xnln6QQSWDYE7AcxoenAzZMF3ge39ME/TdF9NLHM31KbKG9
         6RHfHAFJKGZGEDTsAapPQfCGaxbTex8tNql4wsMpx1tzujj2+4zUH8F1O/Wf4INftwra
         44pu7mVLo7Mm7xzORJdqxPQdg84IXdL0Y2nwm3+JnOOiadaA+ct+YQPR7uapPbgNAWqZ
         TRjwMIkQoU8UoUfJmPh7w7VVnHo9oZ1msnp97+lY2tY0QkpDGnoARrN0UCigvFeyJ/e2
         yBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4vjriK4j7SYSPAYD2GgQajbIly7Gj9EsG6tWp6krCA=;
        b=3S9OSKWTZnNVgWdfRQXQxd1jwxmaKpVoEqXkrZjm91OVKcnZDs0AicB/dDl3OgfJH5
         FLqmGq4luN1yEosHclxXy2qaWmZ31+msNVyqcAhKIOTOErp+uqSCZCcsIL65GWmaVjvu
         8Ap7TmIC5vUZmfIhbslZppFWgTtGIrOWG6Jp2AfBYecnhuQkYqAqmqFo9tMUD/EYEFMe
         Gp8hAvCQkBY591wghowRoyozFfZasxI17n18fR6hqwN/3dNSuz6TosTGZMumpGVoAAYN
         QQbzqI4e6moEtYnf/+IJ1IjDbQcS4/L/rb+TUiVEYfqsU667ezfXNFEjD2wGCcWFEdqH
         3BJw==
X-Gm-Message-State: AOAM533OOCrggKdD8DpD4jpQ7Qb0VSLbyn2nxY+dIvzHTyU0FffRif3c
        4ivDyp99jeUQHmKmP69WmVcK4g==
X-Google-Smtp-Source: ABdhPJxFfa/C8GuNOYma/TkgFrgfOOK9MGPdBgaCsOB/siD1CIPA+9Sw9jtI+jTGuGUU8QUafiHu/A==
X-Received: by 2002:a63:2c15:: with SMTP id s21mr2218708pgs.189.1634286500619;
        Fri, 15 Oct 2021 01:28:20 -0700 (PDT)
Received: from integral.. ([182.2.71.75])
        by smtp.gmail.com with ESMTPSA id d15sm4933832pfu.12.2021.10.15.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:28:19 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/2] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Fri, 15 Oct 2021 15:25:06 +0700
Message-Id: <69kbMOkWb6SB69o0ulPlhA-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
References: <20211013090339.622070-1-ammar.faizi@students.amikom.ac.id>
 <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").

  - rax for the return value.
  - rcx to save the return address.
  - r11 to save the rflags.

Other registers are preserved.

Having r8, r9 and r10 in the syscall clobber list is harmless, but this
results in a missed-optimization.

As the syscall doesn't clobber r8-r10, GCC should be allowed to reuse
their value after the syscall returns to userspace. But since they are
in the clobber list, GCC will always miss this opportunity.

Remove them from the x86-64 syscall clobber list to help GCC generate
better code and fix the comment.

See also the x86-64 ABI, section A.2 AMD64 Linux Kernel Conventions,
A.2.1 Calling Conventions [1].

Extra note:
Some people may think it does not really give a benefit to remove r8,
r9 and r10 from the syscall clobber list because the impression of
syscall is a C function call, and function call always clobbers those 3.

However, that is not the case for nolibc.h, because we have a potential
to inline the "syscall" instruction (which its opcode is "0f 05") to the
user functions.

All syscalls in the nolibc.h are written as a static function with inline
ASM and are likely always inline if we use optimization flag, so this is
a profit not to have r8, r9 and r10 in the clobber list.

Here is the example where this matters.

Consider the following C code:
```
  #include "tools/include/nolibc/nolibc.h"
  #define read_abc(a, b, c) __asm__ volatile("nop"::"r"(a),"r"(b),"r"(c))

  int main(void)
  {
  	int a = 0xaa;
  	int b = 0xbb;
  	int c = 0xcc;

  	read_abc(a, b, c);
  	write(1, "test\n", 5);
  	read_abc(a, b, c);

  	return 0;
  }
```

Compile with:
    gcc -Os test.c -o test -nostdlib

With r8, r9, r10 in the clobber list, GCC generates this:

0000000000001000 <main>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	41 54                	push   %r12
    1006:	41 bc cc 00 00 00    	mov    $0xcc,%r12d
    100c:	55                   	push   %rbp
    100d:	bd bb 00 00 00       	mov    $0xbb,%ebp
    1012:	53                   	push   %rbx
    1013:	bb aa 00 00 00       	mov    $0xaa,%ebx
    1018:	90                   	nop
    1019:	b8 01 00 00 00       	mov    $0x1,%eax
    101e:	bf 01 00 00 00       	mov    $0x1,%edi
    1023:	ba 05 00 00 00       	mov    $0x5,%edx
    1028:	48 8d 35 d1 0f 00 00 	lea    0xfd1(%rip),%rsi
    102f:	0f 05                	syscall
    1031:	90                   	nop
    1032:	31 c0                	xor    %eax,%eax
    1034:	5b                   	pop    %rbx
    1035:	5d                   	pop    %rbp
    1036:	41 5c                	pop    %r12
    1038:	c3                   	ret

GCC thinks that syscall will clobber r8, r9, r10. So it spills 0xaa,
0xbb and 0xcc to callee saved registers (r12, rbp and rbx). This is
clearly extra memory access and extra stack size for preserving them.

But syscall does not actually clobber them, so this is a missed
optimization.

Now without r8, r9, r10 in the clobber list, GCC generates better code:

0000000000001000 <main>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	41 b8 aa 00 00 00    	mov    $0xaa,%r8d
    100a:	41 b9 bb 00 00 00    	mov    $0xbb,%r9d
    1010:	41 ba cc 00 00 00    	mov    $0xcc,%r10d
    1016:	90                   	nop
    1017:	b8 01 00 00 00       	mov    $0x1,%eax
    101c:	bf 01 00 00 00       	mov    $0x1,%edi
    1021:	ba 05 00 00 00       	mov    $0x5,%edx
    1026:	48 8d 35 d3 0f 00 00 	lea    0xfd3(%rip),%rsi
    102d:	0f 05                	syscall
    102f:	90                   	nop
    1030:	31 c0                	xor    %eax,%eax
    1032:	c3                   	ret

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Link: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI [1]
---
 tools/include/nolibc/nolibc.h | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3430667b0d24..1483d95c8330 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -265,12 +265,17 @@ struct stat {
  *   - arguments are in rdi, rsi, rdx, r10, r8, r9 respectively
  *   - the system call is performed by calling the syscall instruction
  *   - syscall return comes in rax
- *   - rcx and r8..r11 may be clobbered, others are preserved.
+ *   - rcx and r11 are clobbered, others are preserved.
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
  *   - the syscall number is always specified last in order to allow to force
  *     some registers before (gcc refuses a %-register at the last position).
+ *   - see also x86-64 ABI section A.2 AMD64 Linux Kernel Conventions, A.2.1
+ *     Calling Conventions.
+ *
+ * Link x86-64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
+ *
  */
 
 #define my_syscall0(num)                                                      \
@@ -280,9 +285,9 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -295,10 +300,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1),                                                 \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -312,10 +317,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2),                                     \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -330,10 +335,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -349,10 +354,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4)                                    \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r11", "memory", "cc"                    \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -369,10 +374,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4), "=r"(_arg5)                       \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
 		  "0"(_num)                                                   \
-		: "rcx", "r9", "r11", "memory", "cc"                          \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -390,7 +395,7 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4), "=r"(_arg5)                       \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
 		  "r"(_arg6), "0"(_num)                                       \
 		: "rcx", "r11", "memory", "cc"                                \
-- 
2.30.2


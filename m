Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1800A42EC55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhJOIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbhJOIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:30:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2400C061755
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:28:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om14so6693051pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ircVxbTo3zV/e8wMUWogrrolZ8aOOcCFrNJJWVsUPWk=;
        b=HbInK23BwKdeR+ADSHdd26d3sDFXlvaLBYmlk8d2NmWEL0w8n67t13zK7IZCUUy6b6
         z/y2J2HenoqLwnM9oYvEKKFDONqmp/VpRSbJFHY6Gac94IsgsuxIHCEnZnL9Y2JtK/2+
         BaRIrLbyw9X2onkIJetJ/NO0Wt45bk9nChV11+ycpsppLcIdTKKCAe0cr7aLgwe+nJ4A
         BBjKvmScuV+eSmuj024WztBHdvjiIEEtlgTG74XhzycevoOApl2gVXeJcgNfMw8u+zSy
         TtXuC9nSnuRinUMz8LGzMRFtt21yxGstKHJkOyxbpBi18uyPb725FXaiPeWn8ssTD6aZ
         Wexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ircVxbTo3zV/e8wMUWogrrolZ8aOOcCFrNJJWVsUPWk=;
        b=1x+wpPGiahTwA3bG/JRfwKIXYNLShgQCrZwc5YxM9NcRkD4tK4/tMy/XCX8znsLaJe
         OsBv23EljRgR+bGyrfeuQQdZDG7iWZCWni55A1MCtrcebdMx3AZDN0okBgLpB96R0EeF
         WaMatvgu6Tv5z1j/XuFFslHP35pmD1GpoRgiFArXWSnHBC+dv7KhjuQ/ZxLf0xzg/0t5
         OiQZioOq0uidepZ1EPFITc2YVWa9UyTVShkIKa8/oC/D4fVHWscwrCLLB6z2lXI1cbhc
         hz+pHDrDJPx8cJ2bRsOHdIe7cebcJNU8Jsa66dazu1yzO6guHmNkf3TbCWlSYx4FtO0r
         K4Pg==
X-Gm-Message-State: AOAM5303tLWb27wiz98JAwNLYRGeRdXZdvmY7iJfNoGg+k/tMQZOvEj3
        osFLh2JkbFFOSZZPNIVegWpAoQ==
X-Google-Smtp-Source: ABdhPJwo4XWlfW4EJFl+UNe6SMYa2UjyjKFT4ibhhd774UkwPUgOihMXh4oDi22AQI+kFTys5jNg+A==
X-Received: by 2002:a17:90a:9406:: with SMTP id r6mr26512303pjo.206.1634286511376;
        Fri, 15 Oct 2021 01:28:31 -0700 (PDT)
Received: from integral.. ([182.2.71.75])
        by smtp.gmail.com with ESMTPSA id d15sm4933832pfu.12.2021.10.15.01.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:28:30 -0700 (PDT)
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
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Date:   Fri, 15 Oct 2021 15:25:07 +0700
Message-Id: <CtypPaXXhVINRV0090UVzA-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
References: <20211013090339.622070-1-ammar.faizi@students.amikom.ac.id>
 <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, the _start function looks like this:

0000000000001170 <_start>:
    1170:	pop    %rdi
    1171:	mov    %rsp,%rsi
    1174:	lea    0x8(%rsi,%rdi,8),%rdx
    1179:	and    $0xfffffffffffffff0,%rsp
    117d:	sub    $0x8,%rsp
    1181:	call   1000 <main>
    1186:	movzbq %al,%rdi
    118a:	mov    $0x3c,%rax
    1191:	syscall
    1193:	hlt
    1194:	data16 cs nopw 0x0(%rax,%rax,1)
    119f:	nop

Note the "and" to %rsp, it makes the %rsp be 16-byte aligned, but then
there is a "sub" with $0x8 which makes the %rsp no longer 16-byte
aligned, then it calls main. That's the bug!

Right before "call", the %rsp must be 16-byte aligned. So the "sub"
here breaks the alignment. Remove it.

Also the content of %rbp may be unspecified at process initialization
time. For example, if the _start gets called by an interpreter, the
interpreter may not zero the %rbp, so we should zero the %rbp on _start.

In this patch, we recode the _start function, and now it looks like
this:

0000000000001170 <_start>:
    1170:	pop    %rdi                       # argc
    1171:	mov    %rsp,%rsi                  # argv
    1174:	lea    0x8(%rsi,%rdi,8),%rdx      # envp
    1179:	xor    %ebp,%ebp                  # %rbp = 0
    117b:	and    $0xfffffffffffffff0,%rsp   # %rsp &= -16
    117f:	call   1000 <main>
    1184:	mov    %eax,%edi
    1186:	mov    $0xe7,%eax
    118b:	syscall                           # sys_exit_group(%rdi)
    118d:	hlt
    118e:	xchg   %ax,%ax

Extra fixes:
  - Use NR_exit_group instead of NR_exit.

  - Use `mov %eax,%edi` instead of `movzbq %al,%rdi`. This makes the
    exit code more observable from strace. While the exit code is
    only 8-bit, the kernel has taken care of that, so no need to
    worry about it.

Cc: Bedirhan KURT <windowz414@gnuweeb.org>
Cc: Louvian Lyndal <louvianlyndal@gmail.com>
Reported-by: Peter Cordes <peter@cordes.ca>
Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
---
 tools/include/nolibc/nolibc.h | 61 +++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 1483d95c8330..f502b645d363 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -403,21 +403,54 @@ struct stat {
 	_ret;                                                                 \
 })
 
+
 /* startup code */
-asm(".section .text\n"
-    ".global _start\n"
-    "_start:\n"
-    "pop %rdi\n"                // argc   (first arg, %rdi)
-    "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
-    "lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
-    "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned when
-    "sub $8, %rsp\n"            // entering the callee
-    "call main\n"               // main() returns the status code, we'll exit with it.
-    "movzb %al, %rdi\n"         // retrieve exit code from 8 lower bits
-    "mov $60, %rax\n"           // NR_exit == 60
-    "syscall\n"                 // really exit
-    "hlt\n"                     // ensure it does not return
-    "");
+asm(
+	".section .text\n"
+	".global _start\n"
+
+	"_start:\n\t"
+	"popq %rdi\n\t"			// argc   (first arg, %rdi)
+	"movq %rsp, %rsi\n\t"		// argv[] (second arg, %rsi)
+	"leaq 8(%rsi,%rdi,8), %rdx\n\t"	// then a NULL, then envp (third arg, %rdx)
+
+	/*
+	 * The System V ABI mandates the deepest stack frame should be zero.
+	 * Thus we zero the %rbp here.
+	 */
+	"xorl %ebp, %ebp\n\t"
+
+	/*
+	 * The System V ABI mandates the %rsp needs to be aligned at 16-byte
+	 * before performing a function call.
+	 */
+	"andq $-16, %rsp\n\t"
+
+	/*
+	 * main() returns the status code, we will exit with it.
+	 */
+	"callq main\n\t"
+
+	/*
+	 * Move the return value to the first argument of exit_group.
+	 */
+	"movl %eax, %edi\n\t"
+
+	/*
+	 * NR_exit_group == 231
+	 */
+	"movl $231, %eax\n\t"
+
+	/*
+	 * Really exit.
+	 */
+	"syscall\n\t"
+
+	/*
+	 * Ensure it does not return.
+	 */
+	"hlt\n\t"
+);
 
 /* fcntl / open */
 #define O_RDONLY            0
-- 
2.30.2


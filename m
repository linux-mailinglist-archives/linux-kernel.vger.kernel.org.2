Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEC3438653
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 04:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhJXCQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 22:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhJXCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 22:16:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036FBC061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 19:13:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id o133so7216058pfg.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qYda86rlWo9ywAsLOfId3JIvCAhvBBfWegTBxC6cD/w=;
        b=dZBIj+7ZNFc7SOd8P549SMR0tuomMeZdXHZ+H6LluSwYlw76EQA42L/ouYB4ccMgnv
         GZUGPdr0053aCLaBkY0tT2BMoM2tAAAs+Z9hdFvQ/yl2Uao7lVXKdS9L9wjAhG7/JRa4
         KRId2UoPnH8bRwyd4KLI4e4EXUi3KU9W+A/Iu5E/K/PI4+L4Au2lm8vvFNHo+HW77cwx
         +h6111EfUg8TJqmmWFKG9kyZj3vMf2fquRwDBdIW1ogos/Su6F8RWu4f92bHJSWkNsaj
         M6krfyWtyUYj4Cy+bMtkDNc2PK4omPDqzniWWKJBXELI6SvKcL0f3O1ZxqkLPv5yWlAQ
         Rvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qYda86rlWo9ywAsLOfId3JIvCAhvBBfWegTBxC6cD/w=;
        b=nrErlY0GANDptySd1MiMFT4gGyoM2BdGb6t1xwpsSZT9JOTqQaokAOdpTRfbnuKB2v
         RJykl2+FQbKvQV8hy+szkSWVlKByEx9QyPjMDOqRjIurrwNay3pzRab76vNM0Umu3I95
         hvGQwcqsEBq6GPzjJYvlXx9XXEUDnaainUaVeoqDjxFjTGJxr9YWx5ItSP27NpdNyOem
         ZhHrgqik2jx0W3c5ffNCw+x3312P8+YdvpbJkQPd2z4fBe1yeAF7v1ydSY9G8KJpI4Pg
         do3+223UWz/MgrJtOHWYXSKMPqM9JquuRH41KI86XzMVW5Mv3gSiTX4nuukZsw7BwCOu
         0EzA==
X-Gm-Message-State: AOAM533JCgrDuzKd67aYVXDJRf+fQ7/4IjTmT5q/opV5W/w3qRLE/r84
        DhRKdQ6QZgS0soKIATYNKx+ZWg==
X-Google-Smtp-Source: ABdhPJwQTNefd94KDcPS9OOIEY8PcgphT10yEARKOSrBGK0Si74rxxoFwB6QH/dieSTv945hK9GEAQ==
X-Received: by 2002:a05:6a00:1944:b0:438:d002:6e35 with SMTP id s4-20020a056a00194400b00438d0026e35mr9714859pfk.20.1635041636430;
        Sat, 23 Oct 2021 19:13:56 -0700 (PDT)
Received: from integral.. ([182.2.37.49])
        by smtp.gmail.com with ESMTPSA id d15sm16293137pfu.12.2021.10.23.19.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 19:13:56 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86-ml <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: [PATCH 1/2] tools/nolibc: x86-64: Fix startup code bug
Date:   Sun, 24 Oct 2021 09:11:31 +0700
Message-Id: <20211024015628.393550-1-ammarfaizi2@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211024020616.395038-1-ammarfaizi2@intel.com>
References: <20211023134323.GA5881@1wt.eu>
 <20211024020616.395038-1-ammarfaizi2@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before this patch, the `_start` function looks like this:
```
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
```
Note the "and" to %rsp with $-16, it makes the %rsp be 16-byte aligned,
but then there is a "sub" with $0x8 which makes the %rsp no longer
16-byte aligned, then it calls main. That's the bug!

What actually the x86-64 System V ABI mandates is that right before the
"call", the %rsp must be 16-byte aligned, not after the "call". So the
"sub" with $0x8 here breaks the alignment. Remove it.

An example where this rule matters is when the callee needs to align
its stack at 16-byte for aligned move instruction, like `movdqa` and
`movaps`. If the callee can't align its stack properly, it will result
in segmentation fault.

x86-64 System V ABI also mandates the deepest stack frame should be
zero. Just to be safe, let's zero the %rbp on startup as the content
of %rbp may be unspecified when the program starts. Now it looks like
this:
```
0000000000001170 <_start>:
    1170:	pop    %rdi
    1171:	mov    %rsp,%rsi
    1174:	lea    0x8(%rsi,%rdi,8),%rdx
    1179:	xor    %ebp,%ebp                # zero the %rbp
    117b:	and    $0xfffffffffffffff0,%rsp # align the %rsp
    117f:	call   1000 <main>
    1184:	movzbq %al,%rdi
    1188:	mov    $0x3c,%rax
    118f:	syscall
    1191:	hlt
    1192:	data16 cs nopw 0x0(%rax,%rax,1)
    119d:	nopl   (%rax)
```

Cc: Bedirhan KURT <windowz414@gnuweeb.org>
Cc: Louvian Lyndal <louvianlyndal@gmail.com>
Reported-by: Peter Cordes <peter@cordes.ca>
Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
---
 tools/include/nolibc/nolibc.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 1483d95c8330..ea38d6f356a1 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -404,14 +404,20 @@ struct stat {
 })
 
 /* startup code */
+/*
+ * x86-64 System V ABI mandates:
+ * 1) %rsp must be 16-byte aligned right before the function call.
+ * 2) The deepest stack frame should be zero (the %rbp).
+ *
+ */
 asm(".section .text\n"
     ".global _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
     "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
     "lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
-    "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned when
-    "sub $8, %rsp\n"            // entering the callee
+    "xor %ebp, %ebp\n"          // zero the stack frame
+    "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
     "call main\n"               // main() returns the status code, we'll exit with it.
     "movzb %al, %rdi\n"         // retrieve exit code from 8 lower bits
     "mov $60, %rax\n"           // NR_exit == 60
-- 
2.30.2


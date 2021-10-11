Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857434285A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 06:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJKEHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 00:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJKEHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 00:07:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10489C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 21:05:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k26so13724093pfi.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rut3y2eMweGFPwTE1ytr50E2Idnt4OaDC1LdOeMauB0=;
        b=WqYwd5u78KmaLfSv3wkNij1ipzJvTNvjwvN+oW99y1G8fgvTbUCkjWSSBhB9npzBDJ
         mFUqNeinhy5BSBP29Tom7FF3pur8v2k812ZMKF6LXrofqFlFWpGIt6OkRm+d6iHPdzv4
         T9PYcsywW8xSNmfLL48SOZ7L7ERl/gAxbfNwSd7d7GiHDjPXHtEUW2IThbVoz20lhjVj
         2cea8iMb2j8HLDtXrntSJQ8btEZkPBi+tXnTH8e3YxTi96qyQ5Ku4WhlmjYdpH1vCumJ
         I9NuZLQIpBX05DyYoEhVlLsvGz12tkaHft11GmhDAzEV/m56ieqf2Cx4dEmekfghOoGM
         rAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rut3y2eMweGFPwTE1ytr50E2Idnt4OaDC1LdOeMauB0=;
        b=rIeobGykrPMaTSXv4OYhwwiy7jbol8CMh7CCvrwP87kNhaW+vonBWtIFXmEaVyA65z
         UWQJGwYQhzmIXpQvYtHVaz5c8fTYIVTha/d/ABbUhYAjuBl2VINSl2kDnd8Tmt7C8uJq
         eokeZKmZ8WUZuGXalaGYAGhIjaVKCbtyxYDgT7L/qpebJzEUCLwjd55DUe3FaizxXeCU
         0Z/rHgn91MWISqBJTKuCX/ZT16wtzQgFzRtVjN5hm8AsXCej5HSI/rOPJxg9PJX3vwZ5
         2k2ImlwGVPXqT/A4/Lyyuvc/lKyfebVPd4MhhIRE6P9riRhX8J5zo691XsIQ37kfAVVP
         Ygeg==
X-Gm-Message-State: AOAM533O9erJOsNDSZCAYmkBsmrzAadTn1/sU1dOLT4yiEHscZ2ipEgd
        o+12tDfIpgujBeCIFKmcVtxmPw==
X-Google-Smtp-Source: ABdhPJzRbqW0yoTzc2Hoc95zuOU193ae+rgLI7MjN1C9RghVpMtukIO+oAkZmHilfs+uLdT9wrqDDg==
X-Received: by 2002:a65:64d7:: with SMTP id t23mr16279460pgv.237.1633925152389;
        Sun, 10 Oct 2021 21:05:52 -0700 (PDT)
Received: from integral.. ([182.2.41.40])
        by smtp.gmail.com with ESMTPSA id f30sm1524498pfq.142.2021.10.10.21.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 21:05:51 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Mon, 11 Oct 2021 11:03:44 +0700
Message-Id: <20211011040344.437264-1-ammar.faizi@students.amikom.ac.id>
X-Mailer: git-send-email 2.30.2
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

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
---
 tools/include/nolibc/nolibc.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3430667b0d24..8c9f2202d6b6 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -265,7 +265,7 @@ struct stat {
  *   - arguments are in rdi, rsi, rdx, r10, r8, r9 respectively
  *   - the system call is performed by calling the syscall instruction
  *   - syscall return comes in rax
- *   - rcx and r8..r11 may be clobbered, others are preserved.
+ *   - rcx and r11 are clobbered, others are preserved.
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
@@ -280,9 +280,9 @@ struct stat {
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
@@ -295,10 +295,10 @@ struct stat {
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
@@ -312,10 +312,10 @@ struct stat {
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
@@ -330,10 +330,10 @@ struct stat {
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
@@ -349,10 +349,10 @@ struct stat {
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
@@ -369,10 +369,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4), "=r"(_arg5)                       \
+		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
 		  "0"(_num)                                                   \
-		: "rcx", "r9", "r11", "memory", "cc"                          \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -390,7 +390,7 @@ struct stat {
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


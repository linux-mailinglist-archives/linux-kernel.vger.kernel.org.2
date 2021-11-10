Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959AE44C0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhKJMGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhKJMFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:05:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7D2C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:44 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so2841749plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=EySJvqn1OwzmqRdsz7WgvTfDdZuu2atHR7QsYNQvf/ZOaNb6YqDK5dyhhDJNP7fGki
         YJbXBNBiVQfvHF5d4SajIORxzExPt/EZdCg8xYsEYCRXtxWfSNN4FXGcC+rlslsMWnNP
         lCHVFPgtD6P41kpF+WYpXruhK4CmxXcyv8IHl/AJxvvEQ9MRZvEQsFaSXn4pzAcw5La3
         YDTOk/JqTygZ4gAhaEnOs8vxOjLmkdu+9N25uo5uzX9XddNJxTFElX1GeYxyjMK2LUTv
         2HjsSnW5tzEMDoF3kwQsR/u1KhauW134xqecjebeu02cKxdSct6FebOQ9VBbaL+gTlB/
         6e/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=quASVVqtNZLXiEHT8lyWlwnm9eDfYH0hEpvf7OHpxNyTlr9+9G8ykNRsum3vFYFgxv
         UJKR7bospNCUR+RMa1N9ufN425S3QVZj+AYMqMhvnfesLZqVGAqe6tC4rMRTYPJQk0Fr
         MUr1K6rlnWzpJ9dzII/Da5gK2oc43VI30cNSD8nNB2p3ZqCkq0yTbGKZQdm02aiMDw5n
         41C8ccXhP5qYLuLpTlQQAlHWIGslv3j3E9Y8yNcTQp/7FkGvCkFigf+MZVHqye54kkzT
         pJdMle/pb5wv4sXDiNxEmu2WUAm8351NdBYCBvSXy7G1SGw6uLku6FxXTUB/NGioW4Zb
         mwXg==
X-Gm-Message-State: AOAM531mjBurt7GARDulOfcLOvNS4iTKym0TQfqdi7xewhXdkQ1cpIwh
        uylllBnryEsLN2gFmAv9Bkah4U59w0I=
X-Google-Smtp-Source: ABdhPJzTZyd+QEREXf3WBDMcoB5F/gDOcWmqAT8xrscxyVJQzSEw9ocC5ekarOn8tGH9Fa7V7hqeEg==
X-Received: by 2002:a17:90b:38c9:: with SMTP id nn9mr15831058pjb.192.1636545763920;
        Wed, 10 Nov 2021 04:02:43 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id m15sm5617889pjf.49.2021.11.10.04.02.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:02:42 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 49/50] x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
Date:   Wed, 10 Nov 2021 19:57:35 +0800
Message-Id: <20211110115736.3776-50-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

PUSH_AND_CLEAR_REGS is never used with save_ret anymore.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index d42012fc694d..6f9de1c6da73 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -63,15 +63,9 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rax=%rax save_ret=0
-	.if \save_ret
-	pushq	%rsi		/* pt_regs->si */
-	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
-	movq	%rdi, 8(%rsp)	/* pt_regs->di (overwriting original return address) */
-	.else
+.macro PUSH_REGS rdx=%rdx rax=%rax
 	pushq   %rdi		/* pt_regs->di */
 	pushq   %rsi		/* pt_regs->si */
-	.endif
 	pushq	\rdx		/* pt_regs->dx */
 	pushq   %rcx		/* pt_regs->cx */
 	pushq   \rax		/* pt_regs->ax */
@@ -86,10 +80,6 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
 	UNWIND_HINT_REGS
-
-	.if \save_ret
-	pushq	%rsi		/* return address on top of stack */
-	.endif
 .endm
 
 .macro CLEAR_REGS
@@ -114,8 +104,8 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rax=\rax, save_ret=\save_ret
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax
+	PUSH_REGS rdx=\rdx, rax=\rax
 	CLEAR_REGS
 .endm
 
-- 
2.19.1.6.gb485710b


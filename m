Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E511943B472
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhJZOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhJZOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:41:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AA5C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:39:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h193so14353782pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=BVS+fz72pNF5Kts/q7bln90gWVZ1oqH5307+YsCsS33vh7L5el1hc92S7aR6ZNKF+G
         FuoED18izK4koA43Yo4uiiBIrAFUeLlwETOnGArXKRgdnqPSx//64RTxUKPUHLIu0/4R
         50hWMpPG2sHxS9QWqDfGWKi5J1ToZm4fWh25Da2vdjMKU5POz9IExe9+ag0eEjKH5Ijt
         XwaXgDhwGDXvLQ9ijxAzEnQ6xAypkr0nvX/MP8VTXtn7JMhjEPUeoCZSxnKF4QySjAZX
         FAotSh/Ac1ehAvxMOWCMXsIxAEuRgZ13IREFpuuduVtAF/EaD1fvc8DXgVul1ZOJciZ6
         OPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=yX04KFphAAhDTf/Zk74TAbhLEe8DzdrNxoHIjBreDCIn1Y/8gV3RI3Oi+Yvp9pjvMk
         N+PjFiz8xxINYEg1XFDEah4v+PcTkXpeXuq8CwvMJS5Iagt13psuQa+NeyOjRuSrSSYt
         GbCOqHVmTHZK217Iqsl7cSZDxxh21zah1t/sEtSK+tn6LkkWg461B1fA68qEIiPbcy6j
         31XtF2zldZTvHswNkcXydl3HEt6mqykKuZOndLkoUivF7OePUINQnme51c/RSE0EbxZ8
         lrZi1bzkL5tOMyCjyNCeJK074ZhmVNu0xfjE77NH6KCei6uDTKe/1Q8iK6BWZdcsGuR5
         +THQ==
X-Gm-Message-State: AOAM531p2rabnXFuxugC7kaFn1WhO4tfrxsxGai4GktxeKEKem4OYUTr
        U6kSh0NFlLv1ChAE/c/pNFUDNiUij8M=
X-Google-Smtp-Source: ABdhPJw4BcXvZaz2C3lS4AMIove4K2YwEHFA77OsHzxc2Z+Y3z1gaRqGWZ2TZplERWXzq+ru32BLow==
X-Received: by 2002:a62:1949:0:b0:47b:e527:cba2 with SMTP id 70-20020a621949000000b0047be527cba2mr17183570pfz.44.1635259150722;
        Tue, 26 Oct 2021 07:39:10 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id a19sm4877760pgh.24.2021.10.26.07.39.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:39:10 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 49/50] x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
Date:   Tue, 26 Oct 2021 22:38:47 +0800
Message-Id: <20211026143851.19481-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267E24189E4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhIZPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhIZPOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843EC061775
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w19so13372665pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=dHEaxe9hxbCFTr3jUp93Go2TjWe5Lq0D4AweecuFKpgvJC8/AUVxk2CD8O7CAxL0ZS
         VZNa33poBN3XYErSa04eWBX9hnLZP8z30jWQ/Nf5Cg3H9sU5pKPbIyBwJK4EMBF6o24p
         0pDZoKPjezx1YKH8itGnhN1HkUHALrbY3fjrw6oII1XbXv0VwkHolQLMla+oVaPIjE2Y
         pjkNcUs5uCPZPtJ3WUEX1/gy26wioPizQMB2PHVuv48L0aMfkX2Iy9TafDLvvx8LCgc5
         GU73zx5hiJOtmabpe845FYjD+HWQpn74EPLuFEb/fFzejhO+/m0BHrOi4Ezbl1rNE8/V
         6R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3k4gSJ33r79TSQiVuZoKLnQbBRVyUbIZwLYjfwd7qo=;
        b=XMKdfzbPaHy36+M61avWlPSCZ1da4eamYsIF7MHH+NU9dwe3Aafa+tsEvCsg3iW/XH
         t5JbEPlHZ9hvaODmqOsXBTC7Ilo7e6lwbCBxEs8aL51nBJW6eUgTN0B9h84imvKGTq6K
         kY93rcuSF1aP7qiF7Y6VbzV2U3PjbVZX9NvKJQ6PjSZKju1U8ICD8UnO1IfTlYRGpsgp
         cMJhE9QkjunflO31nqeMaumxNY8op4R9HLmhVybTik+TsSjW7ZVpYBHfkQb0tfwiHX5B
         c/yWv8QvIG6pmMOb9b1Olgrcv4u7AWRiHgOLleZSvfrvDE3/p4gKsrZ/etZ/kpMavOm7
         5EMg==
X-Gm-Message-State: AOAM531hrxzeD291ydqrh0mudOMwtdDQ3oHVKk3bS5Se7LHXhv7NcYkr
        lRJzmhY0F/y7fl3Q7yJ8LNf0hxPCudnCXQ==
X-Google-Smtp-Source: ABdhPJzP4tEMGHcchu92JvUPN7s9/k9xc7rxlrrNbL7v3vqSzLV/aJc7sxjFh9sfyGE7+RtJz3Xgdg==
X-Received: by 2002:a05:6a00:807:b0:44b:586b:8edb with SMTP id m7-20020a056a00080700b0044b586b8edbmr11781459pfk.9.1632669193008;
        Sun, 26 Sep 2021 08:13:13 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id i27sm14446305pfq.184.2021.09.26.08.13.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:13:12 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 40/41] x86/entry: Remove save_ret from PUSH_AND_CLEAR_REGS
Date:   Sun, 26 Sep 2021 23:08:37 +0800
Message-Id: <20210926150838.197719-41-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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


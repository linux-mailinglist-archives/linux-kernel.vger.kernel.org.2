Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3B44C07F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhKJMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhKJMCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:39 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5CC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t21so2797118plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlbhWc2FE3W9QoQHfc71QL2W1vcKYInOe38/OoopZVE=;
        b=ohM3wJni1ddQBvBTUMYXmT2lWGnd5HjP/55g+Amm0XWMnnn2QQ+YIMSiRxX5XpDniF
         KHEXzp27DJ7vq6YXkI14A8g8gDIeDvVVbuGlyORB84DYEDYfcSbBATWb/AsYpF37Hkn+
         whE3shR1qGIdyEZ9PCoijJluzGpy5/7/fqqlEK16yvXszpSys8ik39dhWU1RLcjHgrQS
         Y/UuWzkaapH9h9KajNUdnoLW2308MoWBjV0Zg40+9yBqlWVSiWAB5kEKxyeMfW4kT8ib
         DUi5SQQQOBeBEJ8SCn/Pi8xHcLdVvlzn2jvTy6AKQyn6rfHU12nqJIZuWfkm7ZqTOUQ6
         zg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlbhWc2FE3W9QoQHfc71QL2W1vcKYInOe38/OoopZVE=;
        b=Zc3UXEFa4Gxvyed3XGrKDkgCdYb/HqcRc2uzMZLUVDxcIbm/0Uk1Qbi4hGAw4kd29m
         SYIG/uO2PsKn6BsZALtO3QiM9+qTatK+8rZUq6HJyGcEvDtjQq9KnFXBBSi295D6JgnJ
         /jM4nRGD4H8s4yZkEm2QwNU7t/nY76Ds1wpMKUbYtT6HSNXoE1RVrRCXS7kLET+hrS21
         p/34cC4byOxL/l4b+4Fp/LZ7NIMF7AmAO6hQNLwDuT/zBup8CgXjIVdFxkvMl19heu7p
         DZQrGiubSvdthLcnjX00Y98OREIOEIWlnZ6Eddv5nqp1KplO6FFUQbSgEmg8CxZd3IZj
         fJkg==
X-Gm-Message-State: AOAM533UWAFU32wWgZ5M4/7hw7rQDTb1gzLUjb0myQi6H2RLp+dQFMuc
        RleWPEVU1OwhuQAh8MuK3rH0GAiTxqs=
X-Google-Smtp-Source: ABdhPJyXsbvvgOQSXv1U4tN5UMcQYxklmBeArD3FtgraTCgMVpZ8pf6HNI0SIdDbEyibbpkp8A9Lrw==
X-Received: by 2002:a17:90a:bb0d:: with SMTP id u13mr15763471pjr.158.1636545591647;
        Wed, 10 Nov 2021 03:59:51 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id g14sm17760613pgo.88.2021.11.10.03.59.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:51 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 23/50] x86/entry: Convert SWAPGS to swapgs in error_entry()
Date:   Wed, 10 Nov 2021 19:57:09 +0800
Message-Id: <20211110115736.3776-24-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

XENPV doesn't use error_entry() anymore, so the pv-aware SWAPGS can be
changed to native swapgs.

It is prepared for later patch to convert error_entry() to C code, which
uses native_swapgs() directly.  Converting SWAPGS to swapgs in ASM
error_entry first to ensure the later patch has zero semantic change.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2f3883d92536..ebc7419a0367 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -997,7 +997,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1029,7 +1029,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * The above code has no serializing instruction.  So do an lfence
@@ -1051,7 +1051,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
-- 
2.19.1.6.gb485710b


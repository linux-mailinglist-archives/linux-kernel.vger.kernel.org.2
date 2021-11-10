Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA744C065
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhKJMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:00:21 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D9C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r5so2849932pls.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=finSi+MPtGxxlMlxKjkaMxfH4zQwtdO76h4HuTO3OSU=;
        b=bfOecSWt4+rTMheurh362QHnL7n7nEnpswzKyG/PxzYzB68Frojl2jaFUmBC1faw6o
         1634p1rQVi39PruyrEzKdKoep5QUb2KCkDpsg7byVPPJN2kLroKBjh0Ws8kP8Y16tPoh
         3G1/wFu0yrsWpEi9rbjMHYcbjg3EIGCFQnTvLaIoRmaw95LhQEPLqU2dItoAi3+lGCQ/
         464x+qTaH6sq1oLQ7npqWAL1Ho14BuUHCBHby80Jyi4TfxTrw0vvuZtYc3nr9RHft1xv
         TODMPZDxg5MIWZ92z2vmnICPTbIpJqcb6KvS6YXkApjKxEb1WCEDlk3NYYmfqyP9Wep7
         lYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=finSi+MPtGxxlMlxKjkaMxfH4zQwtdO76h4HuTO3OSU=;
        b=6nfiDmLVceGYbY2/iYXgsGwOvTqq6lCbYCi5JlUJjlkKYQ2nsTnaAm7vWh/+OIu3RT
         aXmHCVAjpdJxRvpwT/a3Llb0bEBGuNNqhAqv+0LG87IAlTI2+6egzhsL7DKZ6awmnZWx
         rb9blthyRJcTGFaSuIbEFZsql8cU5C9uCxolAgYMT6W9MARqN3Nl0/ideDVOps53HKjd
         HSETdz29gq/+G/ibXIEorm3HgN6ba2jkU1NzRbtcOFe5atjEVQNiCFUzqI+qw7nVt2Ai
         9v8YmFNycoc/hAJFmXIksEzBAq/iMN2zJuqocGAp7PlZJ6f2k1Gn+oa9hvxuVMcRjZ7O
         +0aQ==
X-Gm-Message-State: AOAM530kDLZO4xGcOqH44LSyCH5Vpw2DzAJzzCzYTajxJuwSFnexQQvM
        T0ywIEaDsmicEoGcevMk/ei5NF99zB8=
X-Google-Smtp-Source: ABdhPJzSeNlTKlXPwpJm750XNByllB0Kai4vRvEhaJNTw4C0mh/He9BtcagShVshwIFEMItNZc4cYA==
X-Received: by 2002:a17:903:11cc:b0:13f:ecf7:22c7 with SMTP id q12-20020a17090311cc00b0013fecf722c7mr14864296plh.5.1636545453889;
        Wed, 10 Nov 2021 03:57:33 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id k1sm5332971pjj.54.2021.11.10.03.57.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:57:33 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 01/50] x86/entry: Add fence for kernel entry swapgs in paranoid_entry()
Date:   Wed, 10 Nov 2021 19:56:47 +0800
Message-Id: <20211110115736.3776-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Commit 18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre
v1 swapgs mitigations") adds FENCE_SWAPGS_{KERNEL|USER}_ENTRY
for conditional swapgs.  And in paranoid_entry(), it uses only
FENCE_SWAPGS_KERNEL_ENTRY for both branches.  It is because the fence
is required for both cases since the CR3 write is conditinal even PTI
is enabled.

But commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in
paranoid entry") switches the code order and changes the branches.
And it misses the needed FENCE_SWAPGS_KERNEL_ENTRY for user gsbase case.

Add it back by moving FENCE_SWAPGS_KERNEL_ENTRY up to cover both branches.

Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..14ffe12807ba 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -888,6 +888,13 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	ret
 
 .Lparanoid_entry_checkgs:
+	/*
+	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
+	 * unconditional CR3 write, even in the PTI case.  So do an lfence
+	 * to prevent GS speculation, regardless of whether PTI is enabled.
+	 */
+	FENCE_SWAPGS_KERNEL_ENTRY
+
 	/* EBX = 1 -> kernel GSBASE active, no restore required */
 	movl	$1, %ebx
 	/*
@@ -903,13 +910,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 .Lparanoid_entry_swapgs:
 	swapgs
 
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
-
 	/* EBX = 0 -> SWAPGS required on exit */
 	xorl	%ebx, %ebx
 	ret
-- 
2.19.1.6.gb485710b


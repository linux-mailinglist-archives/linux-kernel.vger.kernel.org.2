Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097EF45EB3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbhKZK0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKZKYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBCEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:08 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p18so6352585plf.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zx01fK1SLqQ1j4TsG58btBXdwyGveKzyqnLszlU1jmU=;
        b=lSsyccXWquWd/0zdEf/qLmNniz/iQDKEgTgeL1N4+8xhLjvEKphBSRk9GeP81YEtZ1
         wydZo5SwjMBX8KAdoLqbft8/VKs2zaJleQvkXli0rTGbwQoBDDpLgehUzwPEFI2B4A38
         1VvLk4Senco+DuM4H22rsRzv2vkGNp6LNHt1K+5oZAerBhqBnjzbYzAY3H2wgrGKpBg+
         25iVD1f05hDp8vftilKDQO2Fu2zlIzR3x6ae39bd3+8VbNjY11433eIEc/rmNFI53wlP
         hNSDju5/A65AJaWHfgIfkYTxdkPYMrfhJ/FjaVvT3wOIgEpH+U6QHlalVZDkDqlsoxHZ
         17OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zx01fK1SLqQ1j4TsG58btBXdwyGveKzyqnLszlU1jmU=;
        b=XWHJADCzhW/wp2/Up2hsIXdMSzncV6z0U0sFJpU7Z17yQIKjE5P88uFSpuoH+9uiFv
         QDsiKpB2W3CkFyFuda7zy5CTcOOv/KrcluKOFTwaZsXe2T7moHJXZi7bFWYAKlxVoDk3
         cE+twVUIDid37BFNxJ6UoHtcqAyeK6yMkpAqw2C3KzVSB0OVPYnJsm+PmxEgCW1YLYuu
         4vJJAYqFggst0/4+ezImPO1EGtMTyC8oj3gMGCUCQKYVYGrWwEBVexMIQFQCbUC+4zdp
         q+qerpdHqxVSnNsVN/P8yfdZ2dW44e9znUJb1bArpoKzZGN6wwDNLydyX0m3FpOpH7r8
         /VQg==
X-Gm-Message-State: AOAM532VJEsRlu2l9kaGUvHgCtCY5gH4HrD4tDDJ8YmAA/cIPPksRTIU
        G+BEcbIqpPa5q4qNz4BHKy7LWyRIEjg=
X-Google-Smtp-Source: ABdhPJw6xdeeZ7uUjopKyLHSKzVakylonjAvPQ8ZkD5TTUa4VukkswjO5wsXN7f8MQTf2VOQJ4Ui6A==
X-Received: by 2002:a17:90b:1b06:: with SMTP id nu6mr14385370pjb.155.1637921527584;
        Fri, 26 Nov 2021 02:12:07 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id mv22sm5089395pjb.36.2021.11.26.02.12.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:07 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 02/49] x86/entry: Use the correct fence macro after swapgs in kernel CR3
Date:   Fri, 26 Nov 2021 18:11:22 +0800
Message-Id: <20211126101209.8613-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit c75890700455 ("x86/entry/64: Remove unneeded kernel CR3
switching") removes a CR3 write in the faulting path of load_gs_index.

But the path's FENCE_SWAPGS_USER_ENTRY has no fence operation if PTI
is enabled.  Rahter, it depends on the CR3 write of SWITCH_TO_KERNEL_CR3.
So the path should use FENCE_SWAPGS_KERNEL_ENTRY if SWITCH_TO_KERNEL_CR3
is removed.

Fixes: c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8582709576bf..4967edded48d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -991,11 +991,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	pushq	%r12
 	ret
 
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-.Lerror_entry_done:
-	ret
-
 	/*
 	 * There are two places in the kernel that can potentially fault with
 	 * usergs. Handle them here.  B stepping K8s sometimes report a
@@ -1018,8 +1013,15 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
 	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	jmp .Lerror_entry_done
+
+	/*
+	 * The above code has no serializing instruction.  So do an lfence
+	 * to prevent GS speculation, regardless of whether it is kernel
+	 * gsbase or user gsbase.
+	 */
+.Lerror_entry_done_lfence:
+	FENCE_SWAPGS_KERNEL_ENTRY
+	ret
 
 .Lbstep_iret:
 	/* Fix truncated RIP */
-- 
2.19.1.6.gb485710b


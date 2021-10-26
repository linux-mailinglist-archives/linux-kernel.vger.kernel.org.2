Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6743B432
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhJZOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbhJZOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:33:13 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6AC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l186so7877265pge.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLvPDSjlXuC0odmXJ7mp0PxXfMTmsQLadPLQAXM53SE=;
        b=Dq+2cGcxpR4hHgPKwa3lXKppms4MJ1ABJQsR/c/LSTYeTLn031quUbtQfCYikWbSlO
         bhvydJL2l5UI9TyflxW+LAijacELclNc1P3X+IqC+IG8knSZGj53eKA2uioB7ZQXw93Y
         9O65vPVdxBb7u9YlYtWrhChqaQrBZVFLFjZtdu7uqBrlbuKTgWemqav6q8m8bbFb/zI1
         XqC9qTN6dGTDq8nmYsQQUM+/eejRbgDt6KNMb9B/V5tbR8WgvzA3ZOchp01SRfrB6MZR
         rE3pVRLzYtw5vgSOm/wQlezIB1Ja3yRmbgaxgJGe6JtWTWRVo1/xlJrqR2B/LsGfrJoe
         IdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLvPDSjlXuC0odmXJ7mp0PxXfMTmsQLadPLQAXM53SE=;
        b=V5ITGVoQUNkMrGEA3Pg/e9IxQBsl8eBc0HhtEJLkBvU+On4f5TT90r1XzDWSEsrypT
         KcXJT0Hi8fsEgtL86leKMyngIr6XSiMq7NU9B4wv8bCvfIpeCzti0IMAvdDF7aBOAz13
         8OpauLNOxMpxMKmZAEdsy+Q0G3f+ZNfERo95bTw3jiWgQXw9/6KwKpYg6zIj5c33Ax3K
         Y4o6Uo6/5M+EFBDObN+KUKw3CmIiQTUacwkuBWHu+neIEraw0cvMdKTlnOMHHBOn98hw
         qoCJ6EFIzyzDaagpPIGhCdMFP0v/8+0Nm4BTS5WfiSml7n6HGODKvsNasxecCg1DJXmj
         e+XA==
X-Gm-Message-State: AOAM5319VZ1lk1J4bBiIiDSwdFUtpSeDkwKoX+QStrtMvIo6hgyaQln6
        92blW51w8+f5YFy2TlMioNYpdHAYQo4=
X-Google-Smtp-Source: ABdhPJw8dEeHWMjJ2s+k5kIN+D1MQlPhhtWN2wS1XuAarz9OPNqeaJ2BbEV3lQGKwi+fM0qXMY9kaw==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr19461290pgn.409.1635258648970;
        Tue, 26 Oct 2021 07:30:48 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id lr3sm1297294pjb.3.2021.10.26.07.30.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:30:48 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 23/50] x86/entry: Convert SWAPGS to swapgs in error_entry()
Date:   Tue, 26 Oct 2021 22:30:05 +0800
Message-Id: <20211026143032.18624-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 9bad620553c8..b97ce4204f6d 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -996,7 +996,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1028,7 +1028,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * The above code has no serializing instruction.  So do an lfence
@@ -1050,7 +1050,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
-- 
2.19.1.6.gb485710b


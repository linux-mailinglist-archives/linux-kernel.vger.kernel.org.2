Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917B45EB3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376730AbhKZKZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbhKZKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:23:25 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA69C06179C
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:02 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t4so7732740pgn.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M3UKNrEx91WBeI8lYn0J//TzO9ozSiazAfZ70d95vTE=;
        b=abyefuVmw+F05LE3KY3ezhAuhW1nqIT7/ieu9/U5f6UDMaeNZsNtCOEQiaiA4bn31Q
         k5IWs0vLdEIrdj7T+E6WLG9flUzHm+gsvwOkl5V1bN/6IwR56AuSVKrWQXvxwZllHy6Z
         8MKimDphnCIf6flhWpjfOA9107/6km0lnQ3ByoiMKR/aihXK9811y8DChET9jbC4ST65
         UCwuwTeqk58HOqTt4vzXxKpXOk4WyQBcY45EYBwZWh1Sjs1iwnGty4pj5O1YPCB7lOoM
         Z5bbUeJ0GjuW7bMDLWbv3aaneL/R9YvNONdLKZNj0Ko1MiDRvX2HvSKYVgBVIXRHTOGO
         mHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3UKNrEx91WBeI8lYn0J//TzO9ozSiazAfZ70d95vTE=;
        b=dNUFceo6y50y5Gugr1a/4NEJDUqpTcaWbJxlW6HsDwZACS9oqKGuBWQD9wJflDbUZB
         hn+vixSJKwoYJ2+S4v+dn1zCVe+z9/sOSX6PNR8aBPZMqStqie4ieOSMsapG0Qs8H0PB
         nnSC9NeWG09l+auHLBOo0uXC9YWH7TXcm8AI7fGB3+Q5rZO7oCXxm0Jhsb7PO2O6EfUH
         TRG66sUgZwL7NmdVRv0nTBC5OEQGqCO3bTsqioS6TvSxmca8zkyGMyGybjhEZ+IkinTt
         stny8IAu7t24DLatV0eIfc569Ewf6Qo/COvh64capwMbQnfKuaU+WQQ69zNZEaBXK3Xe
         kk/A==
X-Gm-Message-State: AOAM530SwjKRqHBPv7wOd3oQ+bK1p7nmoeV14Eezm4yczA7b+0illnZq
        w1s7qwWo9dAMjjEIax2c9DOfJbbzYsY=
X-Google-Smtp-Source: ABdhPJwZ6RL1UbX3bx1drUZzuxLmnS9xjQYSP0gusd52ye2i6sRTUO4m8pF8HwfGnLW/dVe7O6g0Og==
X-Received: by 2002:a63:1622:: with SMTP id w34mr20857716pgl.148.1637921521745;
        Fri, 26 Nov 2021 02:12:01 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id lb4sm11404908pjb.18.2021.11.26.02.12.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:01 -0800 (PST)
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
Subject: [PATCH V6 01/49] x86/entry: Add fence for kernel entry swapgs in paranoid_entry()
Date:   Fri, 26 Nov 2021 18:11:21 +0800
Message-Id: <20211126101209.8613-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

Add it back by changing the branches so that FENCE_SWAPGS_KERNEL_ENTRY
can cover both branches.

Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..8582709576bf 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -897,11 +897,12 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
 	testl	%edx, %edx
-	jns	.Lparanoid_entry_swapgs
-	ret
+	js	.Lparanoid_kernel_gsbase
 
-.Lparanoid_entry_swapgs:
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	swapgs
+.Lparanoid_kernel_gsbase:
 
 	/*
 	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
@@ -909,9 +910,6 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * to prevent GS speculation, regardless of whether PTI is enabled.
 	 */
 	FENCE_SWAPGS_KERNEL_ENTRY
-
-	/* EBX = 0 -> SWAPGS required on exit */
-	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
-- 
2.19.1.6.gb485710b


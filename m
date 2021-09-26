Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963CA4189B2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhIZPKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhIZPKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBAFC061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so15240569pgr.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fwd0zJJmDXlQlZyD/U/+YkqWLTL1pwrLAqLG056xiPw=;
        b=qtrm8ciKyaw74XK/vPGH0RXUyFcKdMDrhtL/OKtbo+XVQ2oP5q7zAP7u9H9mAJKGmc
         TnK1zmOXC3IHHS502yQu84GuJoXJkwQ0Sb9U9UDBsYxwbExdNw510CRRkV1oB1xccdyu
         w4MSvF5cPSNAdc/vgaAjlgcZWDnFE1TWjwVESBBiaEKyV5Gr0HlBF/2fWiKfbOy31DqV
         JWpiBese+x4EykXJ1BmjpGvtVznKgzb1U9abAuqj98YN8Df/vM+nJKnvlIFPUeeffO24
         k1QbAn2iB/n7XNkrFwmj/EJN+71kdKET5mHB809qRbUls9/T02lJG0lt61AFFZN70ajv
         +5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fwd0zJJmDXlQlZyD/U/+YkqWLTL1pwrLAqLG056xiPw=;
        b=moounKOLidxYV2Pcw0Bbx7o7AIP1JGSgGz9eqrMKGXpJHPas8vHcS0Ca1THd2qGQTq
         gMy6x6+PAuNsi1gsOzAb7+VGLUEGsK1vk95TubYxK1po3nsfSUXf+7pdbXoFrHgP8Mw5
         RhRgwHMHMzto/cBCXNoWKGXA8ufP095wZDK5+VbRtYkfO/yv5g+pFpDiNBQjbqzbjy6s
         RG5L8bPNhKmWQ73chX2GRFUhPB6TmhTEnqxc7fidDxf8Npe9DS0/vGB4ErCoDq3ienTx
         PCr6c+9ttnCytj6KOAN2R/NrUWeJqGctuJt+yPHiVipi9n1k7Yi75AU7KlnZ1uuVgIjP
         yASg==
X-Gm-Message-State: AOAM5332Jp7xPPP/8wvfIpRuFLqKLTt/iYysVTdP/4L62FEQsLRcaue/
        xTQmg7Qt2myA3ejN8znfyYLrr8fUXyBgeA==
X-Google-Smtp-Source: ABdhPJzYLL/zaCTikgN83Wpc8jl+8wZpFVxMnBvMgxDGYABmWSdGxVCxacQNeRniQrW7bqGevWz6Cg==
X-Received: by 2002:a05:6a00:1586:b0:447:b30c:4a65 with SMTP id u6-20020a056a00158600b00447b30c4a65mr18823396pfk.0.1632668919971;
        Sun, 26 Sep 2021 08:08:39 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id e7sm14391005pfc.114.2021.09.26.08.08.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:08:39 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 01/41] x86/entry: Fix swapgs fence
Date:   Sun, 26 Sep 2021 23:07:58 +0800
Message-Id: <20210926150838.197719-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Commit 18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre
v1 swapgs mitigations") (commit1) added FENCE_SWAPGS_{KERNEL|USER}_ENTRY
for conditional swapgs.  And in paranoid_entry(), it uses only
FENCE_SWAPGS_KERNEL_ENTRY for both conditions/branches.  It is totally
correct because FENCE_SWAPGS_KERNEL_ENTRY implies FENCE_SWAPGS_USER_ENTRY
which can be seen in spectre_v1_select_mitigation() that if
X86_FEATURE_FENCE_SWAPGS_USER is set, X86_FEATURE_FENCE_SWAPGS_KERNEL
must be also set.

The commit1 also has a piece of comment saying why
FENCE_SWAPGS_KERNEL_ENTRY is needed since writing cr3 implies lfence:
writing cr3 is also conditionally.

But commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in
paranoid entry") (commit2) switches the code order and at least this piece
of comments is useless because there is no "writing cr3" in between the
conditional swaps and the fence.

Even worse, the commit2 does not use FENCE_SWAPGS_{KERNEL|USER}_ENTRY
in the corresponding branches.  It just uses FENCE_SWAPGS_KERNEL_ENTRY
in the user path and no FENCE_SWAPGS_KERNEL_ENTRY in the kernel path.
Possibly, it was because the commit1 which uses FENCE_SWAPGS_KERNEL_ENTRY
in both paths and shadowed the lfence requirement.

Fix it and remove the unneeded comment.

Fixes: Commit 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf795d9..95d85b16710b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -898,17 +898,12 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	rdmsr
 	testl	%edx, %edx
 	jns	.Lparanoid_entry_swapgs
+	FENCE_SWAPGS_KERNEL_ENTRY
 	ret
 
 .Lparanoid_entry_swapgs:
 	swapgs
-
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
+	FENCE_SWAPGS_USER_ENTRY
 
 	/* EBX = 0 -> SWAPGS required on exit */
 	xorl	%ebx, %ebx
-- 
2.19.1.6.gb485710b


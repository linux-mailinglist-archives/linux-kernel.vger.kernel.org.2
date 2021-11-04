Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC3445579
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhKDOna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhKDOnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:43:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35068C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 07:40:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f2b00bdd517953c60a78f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2b00:bdd5:1795:3c60:a78f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE3061EC0575;
        Thu,  4 Nov 2021 15:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636036845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2rlQuLOr/R9H1i3NP5YOWXFRReBbgZZyfEqTJiKSAQ=;
        b=Mem8YRtwi4SeIRLzD3M72EhSJdysJXQ7cOSGSp3dKrptCCfqYGn65c7y4iGzq9grp/D0Tw
        avQdwHm6GSjuwE/YSfdRkbRpRvmalSQmw9jAmMbLCdeERWkkJZwbjDLiKUuQ/zhRKQHol2
        sze4Mi2TRbOLyWPpIUfgwSMPWkCViFw=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 01/12] x86/mce: Do not use memset to clear the banks bitmaps
Date:   Thu,  4 Nov 2021 15:40:24 +0100
Message-Id: <20211104144035.20107-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211104144035.20107-1-bp@alien8.de>
References: <20211104144035.20107-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The bitmap is a single unsigned long so no need for the function call.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b..52d277c955f9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1340,8 +1340,8 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
 noinstr void do_machine_check(struct pt_regs *regs)
 {
 	int worst = 0, order, no_way_out, kill_current_task, lmce;
-	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
-	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
+	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
+	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
 	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
@@ -1385,7 +1385,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	final = this_cpu_ptr(&mces_seen);
 	*final = m;
 
-	memset(valid_banks, 0, sizeof(valid_banks));
 	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
 
 	barrier();
-- 
2.29.2


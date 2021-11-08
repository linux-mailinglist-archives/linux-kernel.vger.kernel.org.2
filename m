Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D24447DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbhKHKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238644AbhKHKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA9AC061210;
        Mon,  8 Nov 2021 02:12:34 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE7701EC0523;
        Mon,  8 Nov 2021 11:12:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/tC7FBtj/4kyDFqro541XOB2ueU0gzJogV2JsEIuOo=;
        b=LWtrjQklCK6JowN1I1zJ1D/4nNNuW35Wp1Hreeg/yaWk9i45+kBTx0x8K32o1jpGe/etw1
        17SAwHwIkDd0JwXxZZsWSnz07u27GVnJckyznRnnL9Q61IuP7Bvj/aR/28knnBawIeU+XD
        A1TzzEmWfUoBOqGF09jQWmq2a0z5bq8=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-parisc@vger.kernel.org
Subject: [PATCH v0 31/42] parisc: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:46 +0100
Message-Id: <20211108101157.15189-32-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/kernel/pdc_chassis.c | 5 +++--
 drivers/parisc/power.c           | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/pdc_chassis.c b/arch/parisc/kernel/pdc_chassis.c
index da154406d368..8bedc9faa791 100644
--- a/arch/parisc/kernel/pdc_chassis.c
+++ b/arch/parisc/kernel/pdc_chassis.c
@@ -135,8 +135,9 @@ void __init parisc_pdc_chassis_init(void)
 				PDC_CHASSIS_VER);
 
 		/* initialize panic notifier chain */
-		atomic_notifier_chain_register(&panic_notifier_list,
-				&pdc_chassis_panic_block);
+		if (atomic_notifier_chain_register(&panic_notifier_list,
+						   &pdc_chassis_panic_block))
+			printk(KERN_WARNING "Panic notifier already registered\n");
 
 		/* initialize reboot notifier chain */
 		register_reboot_notifier(&pdc_chassis_reboot_block);
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
index 456776bd8ee6..26dabaa1e5f8 100644
--- a/drivers/parisc/power.c
+++ b/drivers/parisc/power.c
@@ -230,8 +230,9 @@ static int __init power_init(void)
 	}
 
 	/* Register a call for panic conditions. */
-	atomic_notifier_chain_register(&panic_notifier_list,
-			&parisc_panic_block);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &parisc_panic_block))
+		pr_warn("Panic notifier already registered\n");
 
 	return 0;
 }
-- 
2.29.2


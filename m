Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEAA447D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhKHKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhKHKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC68C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:10 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9AD71EC04DF;
        Mon,  8 Nov 2021 11:12:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72AWzlK8aJv/EOeTk6BHY7p0KLuR3Mw+5F63bwb7Ros=;
        b=FIb8Y8A8RLehlZzj93AynaKTDHSb+/FOhBHnTt4SEEMX7PJT6IPQy3c3wJipxfcuabAIoR
        tEBrKMGtzT3gNFrMDcTBvWm080kpyzOPTekHVr+EaGTJG6rj4DWSKVnGs3yvqWHe2Qbuzc
        AaE2vV7osDc78PWRYixjDfmHJ0DNXTM=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [PATCH v0 01/42] x86: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:16 +0100
Message-Id: <20211108101157.15189-2-bp@alien8.de>
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
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/mce/core.c       | 3 ++-
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 3 ++-
 arch/x86/kernel/setup.c              | 7 +++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b..2c4a9ff49384 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -164,7 +164,8 @@ void mce_register_decode_chain(struct notifier_block *nb)
 		    nb->priority > MCE_PRIO_HIGHEST))
 		return;
 
-	blocking_notifier_chain_register(&x86_mce_decoder_chain, nb);
+	if (blocking_notifier_chain_register(&x86_mce_decoder_chain, nb))
+		pr_warn("MCE decoder chain notifier already registered\n");
 }
 EXPORT_SYMBOL_GPL(mce_register_decode_chain);
 
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 100fbeebdc72..efa503a512dd 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -281,7 +281,8 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 
 void mce_register_injector_chain(struct notifier_block *nb)
 {
-	blocking_notifier_chain_register(&mce_injector_chain, nb);
+	if (blocking_notifier_chain_register(&mce_injector_chain, nb))
+		pr_warn("MCE injector notifier already registered\n");
 }
 EXPORT_SYMBOL_GPL(mce_register_injector_chain);
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 40ed44ead063..e28cd4dd81c1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1245,8 +1245,11 @@ static struct notifier_block kernel_offset_notifier = {
 
 static int __init register_kernel_offset_dumper(void)
 {
-	atomic_notifier_chain_register(&panic_notifier_list,
-					&kernel_offset_notifier);
+	int ret = atomic_notifier_chain_register(&panic_notifier_list,
+						 &kernel_offset_notifier);
+	if (ret)
+		pr_warn("Kernel offset dumper notifier already registered\n");
+
 	return 0;
 }
 __initcall(register_kernel_offset_dumper);
-- 
2.29.2


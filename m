Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BA447DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhKHKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbhKHKPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF1C061764
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:36 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F41B1EC051F;
        Mon,  8 Nov 2021 11:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLe9ZSF1Lv1EDaI8nEzWPaF/7AwCYsNUrHmzLm4SFqw=;
        b=MS1gmIM/QZLStat+1JoM5V56E2GOIz67eGJ40UaPaEO4KIaLSUvw+9eQ3B4vtBNCUiGVcS
        GWo7m5k31XIfHESuFzbJUspmUZqG6WbTAzJlm9k82SgX+Cw63RISNUNx0yL+zSiqY0Luf2
        3w2gQcYwezEk6jRypH6qR5XU9wS0tV0=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v0 34/42] powerpc: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:49 +0100
Message-Id: <20211108101157.15189-35-bp@alien8.de>
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
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/setup-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1e43b69a559..32f9900cd4f4 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -725,14 +725,18 @@ static struct notifier_block kernel_offset_notifier = {
 
 void __init setup_panic(void)
 {
-	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0)
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &kernel_offset_notifier);
+	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0) {
+		if (atomic_notifier_chain_register(&panic_notifier_list,
+						   &kernel_offset_notifier))
+			pr_warn("Kernel offset notifier already registered\n");
+	}
 
 	/* PPC64 always does a hard irq disable in its panic handler */
 	if (!IS_ENABLED(CONFIG_PPC64) && !ppc_md.panic)
 		return;
-	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block))
+		pr_warn("Panic notifier already registered\n");
 }
 
 #ifdef CONFIG_CHECK_CACHE_COHERENCY
-- 
2.29.2


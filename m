Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31E8447DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhKHKTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbhKHKPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32DC06120E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:12:33 -0800 (PST)
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D75BA1EC0505;
        Mon,  8 Nov 2021 11:12:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxVkuZ7OCN+2Qh/i9u9CFGxXBKzX4XNLfCP+cKzNBSU=;
        b=HYqTuDfayfFhMePh1NuAWcHEaC35QLiw/g9ElxpLDZkg2QUfunvx9MC8p4ZJeafvfLNWo4
        Igshl3WJcA5rN57fUNLgaBn70TYfS5xLlvfAFGLVHzTIKaUYbYesyXTnw88tOVq2RRHzj6
        qhtUlMK9PJg9ERPSaAdZA0geNCcXRd0=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tegra@vger.kernel.or
Subject: [PATCH v0 30/42] soc/tegra: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:45 +0100
Message-Id: <20211108101157.15189-31-bp@alien8.de>
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
Cc: linux-tegra@vger.kernel.or
---
 drivers/soc/tegra/ari-tegra186.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/tegra/ari-tegra186.c b/drivers/soc/tegra/ari-tegra186.c
index 02577853ec49..a25e1b7497e0 100644
--- a/drivers/soc/tegra/ari-tegra186.c
+++ b/drivers/soc/tegra/ari-tegra186.c
@@ -72,8 +72,11 @@ static struct notifier_block tegra186_ari_panic_nb = {
 
 static int __init tegra186_ari_init(void)
 {
-	if (of_machine_is_compatible("nvidia,tegra186"))
-		atomic_notifier_chain_register(&panic_notifier_list, &tegra186_ari_panic_nb);
+	if (of_machine_is_compatible("nvidia,tegra186")) {
+		if (atomic_notifier_chain_register(&panic_notifier_list,
+						   &tegra186_ari_panic_nb))
+			pr_warn("Panic notifier already registered\n");
+	}
 
 	return 0;
 }
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05375447DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhKHKSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:18:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238582AbhKHKPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:14 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DE8D1EC0518;
        Mon,  8 Nov 2021 11:12:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/OtEsxs0FxuB+jHRrAJERIu8nw9X9+cQ1BcJG9NbZE=;
        b=Krn/4Bm2dw7+qlipiJWIVQpPsgQYg0iEVnvPxyc+cbreeQQe2hKjUKMimAHp/uQDHgS9ke
        ui6QcuxnVnCmsg2CY8dPtDgivjBQ13HlP2Mz4ld2rtsiz0dmd+Honw4EuYKkyzBXsqkKSF
        qgabt1OyhA2RmM4tplU8SDB0gkPUqR0=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v0 27/42] bus: brcmstb_gisb: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:42 +0100
Message-Id: <20211108101157.15189-28-bp@alien8.de>
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
Cc: bcm-kernel-feedback-list@broadcom.com
---
 drivers/bus/brcmstb_gisb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 4c2f7d61cb9b..1c0180ebe6a7 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -490,8 +490,10 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 
 	if (list_is_singular(&brcmstb_gisb_arb_device_list)) {
 		register_die_notifier(&gisb_die_notifier);
-		atomic_notifier_chain_register(&panic_notifier_list,
-					       &gisb_panic_notifier);
+
+		if (atomic_notifier_chain_register(&panic_notifier_list,
+						   &gisb_panic_notifier))
+			pr_warn("GISB Panic notifier already registered\n");
 	}
 
 	dev_info(&pdev->dev, "registered irqs: %d, %d\n",
-- 
2.29.2


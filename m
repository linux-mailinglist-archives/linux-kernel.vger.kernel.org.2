Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5E3D65AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhGZQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbhGZQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2609C07872C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:12:32 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1BanNpfrVmICmGvk+a61W7AFaDcHbuRNU9SMhaf0lk=;
        b=TZn2dqM7UhAalU3J8UM2EnPdtJyU2ROt8YyZtFY6wymnGOTtiuebqG5MRYJIGu4iuAzT1C
        48GS63Gh6k68RV7LexFe/ToF+06fRbaKwIN8VVWqaY9WbhvgPthSMTh19RSyQFjqlL/17g
        r97dMPoqK1JjCgNg5USwoNiBpdkiZAR6ofDUKhzAaXokS1bs1UikaJSmydFCb1F6biH3p7
        hwN+bWN7PCZaCTFCO6pOJPvbFjWjMn1J4i4XQZOHLT7gbZxlG+dKRdlnlgC3ngeHsy4hR8
        S27r1XVLyvkU+w4b2ciVcQfKPCJA8zDkey47N9wt4m8izSJRCnjmCDx3ys69PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319550;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1BanNpfrVmICmGvk+a61W7AFaDcHbuRNU9SMhaf0lk=;
        b=6rvh8PJwrNRN1kBdW82/Gj17oExwID8acMjeKn2Ss8e3TzLhFTm1SKWU2/N8e2xz4BcEma
        CfxY+Fxm7IW0hVBw==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/alpine-msi: Switch to bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-2-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731954972.395.4894923090543170959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3f1808f63f0458762403549b3d975ef6e971b6e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3f1808f63f0458762403549b3d975ef6e971b6e0
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:52 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:01:44 +01:00

irqchip/alpine-msi: Switch to bitmap_zalloc()

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-2-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-alpine-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index ede02dc..5ddb8e5 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -267,9 +267,7 @@ static int alpine_msix_init(struct device_node *node,
 		goto err_priv;
 	}
 
-	priv->msi_map = kcalloc(BITS_TO_LONGS(priv->num_spis),
-				sizeof(*priv->msi_map),
-				GFP_KERNEL);
+	priv->msi_map = bitmap_zalloc(priv->num_spis, GFP_KERNEL);
 	if (!priv->msi_map) {
 		ret = -ENOMEM;
 		goto err_priv;
@@ -285,7 +283,7 @@ static int alpine_msix_init(struct device_node *node,
 	return 0;
 
 err_map:
-	kfree(priv->msi_map);
+	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
 	return ret;

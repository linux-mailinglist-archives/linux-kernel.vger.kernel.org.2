Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02EE3D653C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbhGZQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:32:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43232 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbhGZQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:32:01 -0400
Date:   Mon, 26 Jul 2021 17:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjwFOzEvCpnIYax6TwvZF4n+douLNj2+deJp0qAc48w=;
        b=hOSlhHK86zUYLKVKJfR7tOK6nrRH/IPaN6FeUlcT/ireknTYrTqcqoOGh4KimnqZrdTsy6
        61lc18VjRz6lL+2lhz+SuTr4YhaiaHkQTpTAAWx90CQUYZVUkDMFLOvmQB2GBy+W9X6lR8
        8m1UrWzpwynMPf2QjpAc6UXqgG4gfBhQ/2Q0eVI27SogAtGic4xeCgrKMmhLbbJYsom+7k
        SX+l5AXsUkeieKPwOEDfizYgSx+9XNDlpTVrkzIkQay921+ZTYB4LNYJFY7yz5t0rH82jb
        fYvCUBSd9qzsMisXh6xKrOKqK9EWZ4x+82vnIrHczEJVEM65OewF6A/D1V5DYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319549;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjwFOzEvCpnIYax6TwvZF4n+douLNj2+deJp0qAc48w=;
        b=1NU7CoRseEOiyCvQsTUjPJlkYO4iVRVbHk+8vOs15cmUMX3LfCmUXY0eD6thw0Qu0ZbmvU
        4BEPrk+4TnjXWUCg==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Switch to bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-4-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731954862.395.11063210729777385233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ff5fe8867a5feaf90b1cb9b766f3de3a1caf9f33
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ff5fe8867a5feaf90b1cb9b766f3de3a1caf9f33
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:54 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:04:01 +01:00

irqchip/gic-v3: Switch to bitmap_zalloc()

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-4-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-gic-v3-its.c | 6 +++---
 drivers/irqchip/irq-gic-v3-mbi.c | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ba39668..7f40dca 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2140,7 +2140,7 @@ static unsigned long *its_lpi_alloc(int nr_irqs, u32 *base, int *nr_ids)
 	if (err)
 		goto out;
 
-	bitmap = kcalloc(BITS_TO_LONGS(nr_irqs), sizeof (long), GFP_ATOMIC);
+	bitmap = bitmap_zalloc(nr_irqs, GFP_ATOMIC);
 	if (!bitmap)
 		goto out;
 
@@ -2156,7 +2156,7 @@ out:
 static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 {
 	WARN_ON(free_lpi_range(base, nr_ids));
-	kfree(bitmap);
+	bitmap_free(bitmap);
 }
 
 static void gic_reset_prop_table(void *va)
@@ -3387,7 +3387,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	if (!dev || !itt ||  !col_map || (!lpi_map && alloc_lpis)) {
 		kfree(dev);
 		kfree(itt);
-		kfree(lpi_map);
+		bitmap_free(lpi_map);
 		kfree(col_map);
 		return NULL;
 	}
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e81e89a..b84c9c2 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -290,8 +290,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 		if (ret)
 			goto err_free_mbi;
 
-		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
-					   sizeof(long), GFP_KERNEL);
+		mbi_ranges[n].bm = bitmap_zalloc(mbi_ranges[n].nr_spis, GFP_KERNEL);
 		if (!mbi_ranges[n].bm) {
 			ret = -ENOMEM;
 			goto err_free_mbi;
@@ -329,7 +328,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 err_free_mbi:
 	if (mbi_ranges) {
 		for (n = 0; n < mbi_range_nr; n++)
-			kfree(mbi_ranges[n].bm);
+			bitmap_free(mbi_ranges[n].bm);
 		kfree(mbi_ranges);
 	}
 

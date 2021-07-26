Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F303D653E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbhGZQcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:32:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43220 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbhGZQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:32:01 -0400
Date:   Mon, 26 Jul 2021 17:12:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTU568eMFg95TCJD5/qloYKLPleA5Zv4nd251pwYRP4=;
        b=V2/GazBgVcdibe69vN8J9AYtRfCSlNAReUx/elOuyc4TBLYesKmETsEsOpkZfPxhODeQFp
        UAln8saLRRvMF7Kt+0FZ1HPm2ejm0xfu1ORgHPOMO7jaN11pjZEjDu4EIN3V7xTcavGJGc
        l3mPKSQ2BRFJ4MCB4cAh1PhyQ0zRwbwXLTrI4rU6d79b3v7darh3Zf0vdjYsnufWOdAp6O
        V6qgXxdrMHQD31FZsnEAl5SK1rfXUASphPB6GR+lX87qLKycAmQVxCC1XecRbXg/YSpdht
        tTUMiB6SdL3PLWwacRiG3lAtktJazLPHVb51G4/XLRkxcwzXS5mFY/l8gpcSPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fTU568eMFg95TCJD5/qloYKLPleA5Zv4nd251pwYRP4=;
        b=K8mB+drmY9rSpOJDkzbldDt9oVZrb+zGQZtQk1vUizjQ36aRIXgqxBi0HSCVtfrlsQvYCo
        kgQV/CpEQj2veZAg==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mvebu-gicp: Switch to
 devm_bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-6-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731954761.395.6848819484423689827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     3db3969f5375fe0a43c03cb4b55ed643585b140d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3db3969f5375fe0a43c03cb4b55ed643585b140d
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:56 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:04:10 +01:00

irqchip/mvebu-gicp: Switch to devm_bitmap_zalloc()

Switch to devm_bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-6-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-mvebu-gicp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 3be5c5d..fe88a78 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -210,9 +210,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		gicp->spi_cnt += gicp->spi_ranges[i].count;
 	}
 
-	gicp->spi_bitmap = devm_kcalloc(&pdev->dev,
-				BITS_TO_LONGS(gicp->spi_cnt), sizeof(long),
-				GFP_KERNEL);
+	gicp->spi_bitmap = devm_bitmap_zalloc(&pdev->dev, gicp->spi_cnt, GFP_KERNEL);
 	if (!gicp->spi_bitmap)
 		return -ENOMEM;
 

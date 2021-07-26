Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E1E3D65AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241213AbhGZQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241120AbhGZQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:45:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4440C078727
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:12:30 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:12:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627319548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1+SrEgVLQp4nZgzZelu8DV36Kq2T5LJUjei0VUdnF8=;
        b=lnAtpsAyNHZ1mVR+tWT4kZPDRrYxGRPrxKfWSy47rUd9HeppwSnLnOG2Uv1ZCiJDeNqIWQ
        Auowme3aoyGNIue+xUBic7JVMaZmnvFTNwGPMUsWRmJkZvcT4Hn2psdOQWtpppMWtj3nF6
        4+6pZOz7hsztAfNrs9Ve4J0wUUD3HDVpvtq9QvIEzfioYCC9JsHCfum4PkcZpUl/qNo+D4
        Mm1xmbbqfU76lmMW8kA00XS7zy54cxpcVmN8S+CDM/qpI+qmLnc9yUZ9Pog9cKpMVQwYKp
        QtdQVZAJyr8SB7qCf2GEjbIPQhrlo7tUjsma5I1em2FhB9rSysizH5h9bvEkbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627319548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w1+SrEgVLQp4nZgzZelu8DV36Kq2T5LJUjei0VUdnF8=;
        b=EjCinV1ZvkTZhVz6iNRmiWY2kXFGQGtne26ykzTmhJESPsHWgL/JpBdK07nRFYGGoeB5y6
        o6+tmHlDF8AzS6Dg==
From:   "irqchip-bot for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ls-scfg-msi: Switch to
 devm_bitmap_zalloc()
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210618151657.65305-5-andriy.shevchenko@linux.intel.com>
References: <20210618151657.65305-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162731954809.395.7737449415862389769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     43a1965fc5ae911c83a49ad793677aa6ba0e18e2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/43a1965fc5ae911c83a49ad793677aa6ba0e18e2
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 18 Jun 2021 18:16:55 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 26 Jul 2021 18:04:10 +01:00

irqchip/ls-scfg-msi: Switch to devm_bitmap_zalloc()

Switch to devm_bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210618151657.65305-5-andriy.shevchenko@linux.intel.com
---
 drivers/irqchip/irq-ls-scfg-msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 55322da..b4927e4 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -362,10 +362,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 
 	msi_data->irqs_num = MSI_IRQS_PER_MSIR *
 			     (1 << msi_data->cfg->ibs_shift);
-	msi_data->used = devm_kcalloc(&pdev->dev,
-				    BITS_TO_LONGS(msi_data->irqs_num),
-				    sizeof(*msi_data->used),
-				    GFP_KERNEL);
+	msi_data->used = devm_bitmap_zalloc(&pdev->dev, msi_data->irqs_num, GFP_KERNEL);
 	if (!msi_data->used)
 		return -ENOMEM;
 	/*

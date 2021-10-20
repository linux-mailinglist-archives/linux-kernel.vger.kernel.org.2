Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C664352F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhJTStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJTSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:30 -0400
Date:   Wed, 20 Oct 2021 18:47:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIPGep12lqpo6R/2wmBtnpgGiUzu3DLm9OoZK4A3/es=;
        b=p+U63rnaHZfdWziUDbceD9Nhb1Z68TYfA7oylcLnubu3O1a9tB/Owy4vqh9lCUa/NeiaUC
        ZDwQQyy36kE5PjDE5e6f9qvwvawgrmWxSu4S2wuZwpaH1wxiTy9gi90nKQUbC93IqCfMSs
        ryoeTFsxLeGMZs/PQ52nCFTFOnwpO0ZDfcw8V4n63QVPSNvvR7EjaYJKq49H02/8TI3MFw
        KbxAU/KB1PiMvS/rw7jyHL54Aet8WxUKbTh1x04RbWwFUDK1mxtKmKKqxtxgMpuACpsgG5
        EjCgpHzlS4BWA/YvroTGpCngr6FRGfPWyqYcIYdMr5O06aFcyjpp/qfvdVZ+3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIPGep12lqpo6R/2wmBtnpgGiUzu3DLm9OoZK4A3/es=;
        b=Pgn1W58lGibi5Ti4w5N0d++hgYKF/4lEjXPTKlvwurRBv6z49eWc+W4lIK97sHGkdODDbz
        nrziireSemPYO/Bg==
From:   "irqchip-bot for Cai Huoqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-mvebu-pic: Make use of the
 helper function devm_platform_ioremap_resource()
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Andrew Lunn <andrew@lunn.ch>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210908105701.1678-1-caihuoqing@baidu.com>
References: <20210908105701.1678-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Message-ID: <163475563474.25758.12905440311379570952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bacdbd710de553c9c998235231139f0921a5750c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bacdbd710de553c9c998235231139f0921a5750c
Author:        Cai Huoqing <caihuoqing@baidu.com>
AuthorDate:    Wed, 08 Sep 2021 18:57:00 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Oct 2021 11:22:59 +01:00

irqchip/irq-mvebu-pic: Make use of the helper function devm_platform_ioremap_resource()

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210908105701.1678-1-caihuoqing@baidu.com
---
 drivers/irqchip/irq-mvebu-pic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index dc1cee4..870f986 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -121,14 +121,12 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct mvebu_pic *pic;
 	struct irq_chip *irq_chip;
-	struct resource *res;
 
 	pic = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
 	if (!pic)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pic->base = devm_ioremap_resource(&pdev->dev, res);
+	pic->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pic->base))
 		return PTR_ERR(pic->base);
 

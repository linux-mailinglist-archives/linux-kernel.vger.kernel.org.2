Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF14352F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhJTStl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhJTSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFF2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 11:47:15 -0700 (PDT)
Date:   Wed, 20 Oct 2021 18:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+/ynjbOXkKK0NOkSimbbR3uZypj6yT0hmFj0ch18s8=;
        b=n68gGDqi7AQxtgdBmdePOuY/oVMyAcn4pTTWeXX+d2g73KCLGuPLxYwWrK3W78SpdSlZkA
        FFmdoOn7WG6TTbrIQirKvbbie8ybi4mwE2JRHTCv3gW43WQ8pDgbs+an+LhYIkn9kwc5y5
        2mkDOQxigoIYNpKOnSnN48DI+SJCuqv8Jy/CW3P6twUgTrdFKoipxWgzVldFhSbpISKMZ8
        NEEE1vAmxKe1zvXAPDeHM0Z9rKei0OhtjpfrujiFNp9qDw6ktDJN6b3vMFwW8jK432TiHV
        g44TVWFHOo276TjDnRwHQUgOjGVnItBpPK1NBeUAb56S6qbQOsq1HVgOh+xjnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+/ynjbOXkKK0NOkSimbbR3uZypj6yT0hmFj0ch18s8=;
        b=ZBMF5nj6Rggk43HKxK3T21ByznRXqlLH+fvsLVqNZmzRHlc22tHMZc/7u/chQfsQK/O97R
        9Q1IwcS/o6lS+vDA==
From:   "irqchip-bot for Cai Huoqing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32: Make use of the helper
 function devm_platform_ioremap_resource()
Cc:     Cai Huoqing <caihuoqing@baidu.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210908105715.1780-1-caihuoqing@baidu.com>
References: <20210908105715.1780-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Message-ID: <163475563339.25758.12009901571159968164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     fd9ac236c2536863800a7c9ecc73d2ea1bdfc128
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fd9ac236c2536863800a7c9ecc73d2ea1bdfc128
Author:        Cai Huoqing <caihuoqing@baidu.com>
AuthorDate:    Wed, 08 Sep 2021 18:57:15 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Oct 2021 11:24:05 +01:00

irqchip/stm32: Make use of the helper function devm_platform_ioremap_resource()

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210908105715.1780-1-caihuoqing@baidu.com
---
 drivers/irqchip/irq-stm32-exti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 33c7671..b7cb2da 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -850,7 +850,6 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	struct irq_domain *parent_domain, *domain;
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct resource *res;
 
 	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
 	if (!host_data)
@@ -888,8 +887,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	if (!host_data->chips_data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	host_data->base = devm_ioremap_resource(dev, res);
+	host_data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host_data->base))
 		return PTR_ERR(host_data->base);
 

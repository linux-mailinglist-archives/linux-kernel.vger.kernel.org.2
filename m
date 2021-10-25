Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE94B4390E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJYIOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhJYIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:14:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA357C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:11:52 -0700 (PDT)
Date:   Mon, 25 Oct 2021 08:11:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635149510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keZuxF5Wp9vaw+tvwEpRIqDthQf1RE4r+zeSft14Xus=;
        b=tzVUDGRXQi95lmRTc52cbHVlLM4E3xZIi7JKtTM/yUhbHMmA85kLVzVYki7tkwIM8oTB3F
        I+2OHKuXQ73ce61zR2GU14tAyoKn7srfuGFtAbbxkTe7g2a85XSTrCzjEE7vTH5VortGfU
        q0WGnzIWd6oK305N2YUbq3SxWRDHOk61ok2hsy6Zp1DIRjsig8yhapU/AjK3XW6unHuK1P
        VOpGzK+21U7hPcaUj4Imhfv78LPOXAHa6SaVqNjjiaLEixSmD2lBrZtgmiaZcglBJ2aH8G
        SOdyIQPqBknnp//DFnFZMSSv8rh+EtHpMsZkQ1kSznDkpsBKYECtfyFqvPBB0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635149510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keZuxF5Wp9vaw+tvwEpRIqDthQf1RE4r+zeSft14Xus=;
        b=PuwEXYzoIHqP7WLdo/KMZG4U9L0V/aPmuTDonLON/M69CZxfMRO3UTjI742MO3Z64WhuHA
        BzoztDcmBwzZDXAA==
From:   "irqchip-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mchp-eic: Fix return value check
 in mchp_eic_init()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211025050055.1129845-1-yangyingliang@huawei.com>
References: <20211025050055.1129845-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <163514950929.626.13647389495537279603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     68a6e0c63c76128d403e8ca016c0bcb732ff1b05
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/68a6e0c63c76128d403e8ca016c0bcb732ff1b05
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Mon, 25 Oct 2021 13:00:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 25 Oct 2021 09:02:18 +01:00

irqchip/mchp-eic: Fix return value check in mchp_eic_init()

In case of error, the function of_iomap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211025050055.1129845-1-yangyingliang@huawei.com
---
 drivers/irqchip/irq-mchp-eic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index 09b7a8c..c726a19 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -209,7 +209,7 @@ static int mchp_eic_init(struct device_node *node, struct device_node *parent)
 		return -ENOMEM;
 
 	eic->base = of_iomap(node, 0);
-	if (IS_ERR(eic->base)) {
+	if (!eic->base) {
 		ret = -ENOMEM;
 		goto free;
 	}

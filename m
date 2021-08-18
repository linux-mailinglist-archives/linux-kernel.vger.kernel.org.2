Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D43F0C33
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhHRT6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:58:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbhHRT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:39 -0400
Date:   Wed, 18 Aug 2021 19:57:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629316623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZI9KgqNm5AuDaZ59gE4Wl1VtkzBn4fxSrevb7Ow1NM=;
        b=L8H7cx026TUG7TKAZnGbItEYOut3s24Gu4zKiPo4YGM7Yp+mybT/HcnTROYGQ7qFeV3pfk
        PhXfw0r6h2Oa3fbkhWq3d27La4K0fzXggEGkYHYBNUgv5yu3Y9yQ8kzn9Is6J893MRriBe
        QJQgpIC3gJD6wGFPt4+l7Gp3yfrnq+ydd8sQxFYs15PcQ6FopA1eDIjo0ETIJjPZNsy2jP
        shB3LFe+939lbFcWeB0eal8DfnlVizgRg9ORtf7Hc+U7OMe5LyvtiU63EaF86o03QStq74
        yWbVt4kLrIugDS3JcsK1XgQes33CNR0B9YZAh6sX/NPJPJ+p4IihKKNpCeyAlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629316623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZI9KgqNm5AuDaZ59gE4Wl1VtkzBn4fxSrevb7Ow1NM=;
        b=gqVKKiJpWASX2/Lv5/uxv38/bJCRECtYe5VUup+2lN6sds69gEUasUseGMJcfmZiHcHk6c
        J6PRHJVXXM/upXDg==
From:   "irqchip-bot for Jianqun Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl/rockchip: add pinctrl device to
 gpio bank struct
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, maz@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20210816011948.1118959-4-jay.xu@rock-chips.com>
References: <20210816011948.1118959-4-jay.xu@rock-chips.com>
MIME-Version: 1.0
Message-ID: <162931662227.25758.18298427573896977614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5f82afd868a04f65630c22f75b40c60cba418b8e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5f82afd868a04f65630c22f75b40c60cba418b8e
Author:        Jianqun Xu <jay.xu@rock-chips.com>
AuthorDate:    Mon, 16 Aug 2021 09:19:42 +08:00
Committer:     Linus Walleij <linus.walleij@linaro.org>
CommitterDate: Tue, 17 Aug 2021 01:01:49 +02:00

pinctrl/rockchip: add pinctrl device to gpio bank struct

Store a pointer from the pinctrl device for the gpio bank.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Link: https://lore.kernel.org/r/20210816011948.1118959-4-jay.xu@rock-chips.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-rockchip.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index dba9e95..4aa3d2f 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -81,6 +81,7 @@ struct rockchip_drv {
 
 /**
  * struct rockchip_pin_bank
+ * @dev: the pinctrl device bind to the bank
  * @reg_base: register base of the gpio bank
  * @regmap_pull: optional separate register for additional pull settings
  * @clk: clock of the gpio bank
@@ -105,6 +106,7 @@ struct rockchip_drv {
  * @route_mask: bits describing the routing pins of per bank
  */
 struct rockchip_pin_bank {
+	struct device			*dev;
 	void __iomem			*reg_base;
 	struct regmap			*regmap_pull;
 	struct clk			*clk;

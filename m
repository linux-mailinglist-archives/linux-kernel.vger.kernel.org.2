Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406533F0C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhHRT5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:57:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42394 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhHRT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:36 -0400
Date:   Wed, 18 Aug 2021 19:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629316620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n97DgIAKSJU7LXWRTr2AfIBghnY/1OiG1Rinl6t+0kY=;
        b=p3FmjRCX0PxslJfmz2L4TuwrrqRZ2+NTdEjjqP3N4tSh/BvEQwD2l4ey++Ue7B7ITJuQdM
        PhJb17ftdfaUPOYlBCz9gGpWDj5YC9t4jgMCSIMNDsN5PJJcSivqTz1AZuPslwEN/nHg5c
        AQ8GW2chudjwMZpefr5IlT7+67ol3NWnqvOuAtu8BTRldDi0Vu7/Ebufn7hNfNqYD5q+pS
        D3z4IfNsmUy0Xh2ZdiLnomEGFTJbtFHqwXhDfBYr7JGVpTW1e5eUITLg/jmbg8mNIuw2f2
        D8/5Lj4NSTfyoYKMf6xeoZ/tZlD5lm7jgVvd2kp0mcbv3jZ7Y9FX99talxl5JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629316620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n97DgIAKSJU7LXWRTr2AfIBghnY/1OiG1Rinl6t+0kY=;
        b=yUhw4lCSidPPggxx5nIa6dnBpn0gLD7M0T2b+CcnsK1EiJ5r7bpc4W53t0aq9a0LvlTJ3o
        3sT0n7a0kS3uP6AQ==
From:   "irqchip-bot for Jianqun Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio/rockchip: drop
 irq_gc_lock/irq_gc_unlock for irq set type
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, maz@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20210816012135.1119234-1-jay.xu@rock-chips.com>
References: <20210816012135.1119234-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Message-ID: <162931661928.25758.9843149521008622364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     93103f6eb09ca5152ef9173ec8b91b78df1905e8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/93103f6eb09ca5152ef9173ec8b91b78df1905e8
Author:        Jianqun Xu <jay.xu@rock-chips.com>
AuthorDate:    Mon, 16 Aug 2021 09:21:35 +08:00
Committer:     Linus Walleij <linus.walleij@linaro.org>
CommitterDate: Tue, 17 Aug 2021 01:01:50 +02:00

gpio/rockchip: drop irq_gc_lock/irq_gc_unlock for irq set type

There has spin lock for irq set type already, so drop irq_gc_lock and
irq_gc_unlock.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Link: https://lore.kernel.org/r/20210816012135.1119234-1-jay.xu@rock-chips.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-rockchip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index b2be560..036b2d9 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -406,7 +406,6 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 		irq_set_handler_locked(d, handle_level_irq);
 
 	raw_spin_lock_irqsave(&bank->slock, flags);
-	irq_gc_lock(gc);
 
 	level = rockchip_gpio_readl(bank, bank->gpio_regs->int_type);
 	polarity = rockchip_gpio_readl(bank, bank->gpio_regs->int_polarity);
@@ -461,7 +460,6 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	rockchip_gpio_writel(bank, level, bank->gpio_regs->int_type);
 	rockchip_gpio_writel(bank, polarity, bank->gpio_regs->int_polarity);
 out:
-	irq_gc_unlock(gc);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
 
 	return ret;

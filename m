Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A43F0C36
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhHRT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:58:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhHRT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:57:40 -0400
Date:   Wed, 18 Aug 2021 19:57:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629316624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fl8zvt7Z4cmv2jKkVoCsAM0EtYL9+6fZsPmoIWiakoQ=;
        b=fspZZsglu6hnUB5ZadrS1gjXGvOcylLRfhoKqV+vUNfNUiZNj+FJMqkVlbOZIENjyl7MgM
        VmDvJy0Y3PhVdkOBGre5Z6uZEgNpD4/2MlRS7/+WpQXbldFb31466BS7c+qtVq74uGkJSP
        ZNMOgUitPYUcCoiMOkaQO2EbEB0Ykg/xqhNleEjHp8VfqwhebPL71kQYPgbZLJs+7nGUAj
        l5nHn+ori8g6SkPpLDWiEjPY4zoqL2gYv0yzkZsK3V1W0SGvfkwPw8dvERV/m3DGerO8w0
        Ckn38hPbnucs4qG1e95HJde0Vf32v+w/FFRdfaMexyohcAQIcF6vCC/PVzZ6sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629316624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fl8zvt7Z4cmv2jKkVoCsAM0EtYL9+6fZsPmoIWiakoQ=;
        b=B/eQIHER6HHhgraiFMtUJSe3Ff5HuoulpFYg3Pf4u86M2DfOEhwKl4A+2x7Vy0QjMaFVT8
        Sk41tdvlPxOyU8Aw==
From:   "irqchip-bot for Jianqun Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl/rockchip: always enable clock for
 gpio controller
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>, maz@kernel.org,
        tglx@linutronix.de
In-Reply-To: <20210816011948.1118959-2-jay.xu@rock-chips.com>
References: <20210816011948.1118959-2-jay.xu@rock-chips.com>
MIME-Version: 1.0
Message-ID: <162931662353.25758.9302145415252812324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     4b522bbf80f67ff17c0cc1fe66654202810b4482
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4b522bbf80f67ff17c0cc1fe66654202810b4482
Author:        Jianqun Xu <jay.xu@rock-chips.com>
AuthorDate:    Mon, 16 Aug 2021 09:19:40 +08:00
Committer:     Linus Walleij <linus.walleij@linaro.org>
CommitterDate: Tue, 17 Aug 2021 01:01:49 +02:00

pinctrl/rockchip: always enable clock for gpio controller

Since gate and ungate pclk of gpio has very litte benifit for system
power consumption, just keep it always ungate.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Link: https://lore.kernel.org/r/20210816011948.1118959-2-jay.xu@rock-chips.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinctrl-rockchip.c | 40 +-----------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 067fc42..650c71c 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2299,17 +2299,8 @@ static int rockchip_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	struct rockchip_pin_bank *bank = gpiochip_get_data(chip);
 	u32 data;
-	int ret;
 
-	ret = clk_enable(bank->clk);
-	if (ret < 0) {
-		dev_err(bank->drvdata->dev,
-			"failed to enable clock for bank %s\n", bank->name);
-		return ret;
-	}
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
-	clk_disable(bank->clk);
-
 	if (data & BIT(offset))
 		return GPIO_LINE_DIRECTION_OUT;
 
@@ -2335,7 +2326,6 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 	if (ret < 0)
 		return ret;
 
-	clk_enable(bank->clk);
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
@@ -2347,7 +2337,6 @@ static int _rockchip_pmx_gpio_set_direction(struct gpio_chip *chip,
 	writel_relaxed(data, bank->reg_base + GPIO_SWPORT_DDR);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
 
 	return 0;
 }
@@ -2798,7 +2787,6 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	unsigned long flags;
 	u32 data;
 
-	clk_enable(bank->clk);
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg);
@@ -2808,7 +2796,6 @@ static void rockchip_gpio_set(struct gpio_chip *gc, unsigned offset, int value)
 	writel(data, reg);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
 }
 
 /*
@@ -2820,9 +2807,7 @@ static int rockchip_gpio_get(struct gpio_chip *gc, unsigned offset)
 	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
 	u32 data;
 
-	clk_enable(bank->clk);
 	data = readl(bank->reg_base + GPIO_EXT_PORT);
-	clk_disable(bank->clk);
 	data >>= offset;
 	data &= 1;
 	return data;
@@ -2858,7 +2843,6 @@ static void rockchip_gpio_set_debounce(struct gpio_chip *gc,
 	unsigned long flags;
 	u32 data;
 
-	clk_enable(bank->clk);
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl(reg);
@@ -2869,7 +2853,6 @@ static void rockchip_gpio_set_debounce(struct gpio_chip *gc,
 	writel(data, reg);
 
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
 }
 
 /*
@@ -2914,9 +2897,7 @@ static int rockchip_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	if (!bank->domain)
 		return -ENXIO;
 
-	clk_enable(bank->clk);
 	virq = irq_create_mapping(bank->domain, offset);
-	clk_disable(bank->clk);
 
 	return (virq) ? : -ENXIO;
 }
@@ -3015,7 +2996,6 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	if (ret < 0)
 		return ret;
 
-	clk_enable(bank->clk);
 	raw_spin_lock_irqsave(&bank->slock, flags);
 
 	data = readl_relaxed(bank->reg_base + GPIO_SWPORT_DDR);
@@ -3073,7 +3053,6 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 	default:
 		irq_gc_unlock(gc);
 		raw_spin_unlock_irqrestore(&bank->slock, flags);
-		clk_disable(bank->clk);
 		return -EINVAL;
 	}
 
@@ -3082,7 +3061,6 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
 
 	irq_gc_unlock(gc);
 	raw_spin_unlock_irqrestore(&bank->slock, flags);
-	clk_disable(bank->clk);
 
 	return 0;
 }
@@ -3092,10 +3070,8 @@ static void rockchip_irq_suspend(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
-	clk_enable(bank->clk);
 	bank->saved_masks = irq_reg_readl(gc, GPIO_INTMASK);
 	irq_reg_writel(gc, ~gc->wake_active, GPIO_INTMASK);
-	clk_disable(bank->clk);
 }
 
 static void rockchip_irq_resume(struct irq_data *d)
@@ -3103,9 +3079,7 @@ static void rockchip_irq_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
-	clk_enable(bank->clk);
 	irq_reg_writel(gc, bank->saved_masks, GPIO_INTMASK);
-	clk_disable(bank->clk);
 }
 
 static void rockchip_irq_enable(struct irq_data *d)
@@ -3113,7 +3087,6 @@ static void rockchip_irq_enable(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct rockchip_pin_bank *bank = gc->private;
 
-	clk_enable(bank->clk);
 	irq_gc_mask_clr_bit(d);
 }
 
@@ -3123,7 +3096,6 @@ static void rockchip_irq_disable(struct irq_data *d)
 	struct rockchip_pin_bank *bank = gc->private;
 
 	irq_gc_mask_set_bit(d);
-	clk_disable(bank->clk);
 }
 
 static int rockchip_interrupts_register(struct platform_device *pdev,
@@ -3143,19 +3115,11 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 			continue;
 		}
 
-		ret = clk_enable(bank->clk);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to enable clock for bank %s\n",
-				bank->name);
-			continue;
-		}
-
 		bank->domain = irq_domain_add_linear(bank->of_node, 32,
 						&irq_generic_chip_ops, NULL);
 		if (!bank->domain) {
 			dev_warn(&pdev->dev, "could not initialize irq domain for bank %s\n",
 				 bank->name);
-			clk_disable(bank->clk);
 			continue;
 		}
 
@@ -3166,7 +3130,6 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 			dev_err(&pdev->dev, "could not alloc generic chips for bank %s\n",
 				bank->name);
 			irq_domain_remove(bank->domain);
-			clk_disable(bank->clk);
 			continue;
 		}
 
@@ -3198,7 +3161,6 @@ static int rockchip_interrupts_register(struct platform_device *pdev,
 
 		irq_set_chained_handler_and_data(bank->irq,
 						 rockchip_irq_demux, bank);
-		clk_disable(bank->clk);
 	}
 
 	return 0;
@@ -3317,7 +3279,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank,
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
-	return clk_prepare(bank->clk);
+	return clk_prepare_enable(bank->clk);
 }
 
 static const struct of_device_id rockchip_pinctrl_dt_match[];

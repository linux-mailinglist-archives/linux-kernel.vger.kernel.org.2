Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6694352EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhJTStb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 14:49:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJTSt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 14:49:27 -0400
Date:   Wed, 20 Oct 2021 18:47:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634755632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blm5eGnajTwqiwOXTDtpH6C0ZVCuqAkleL8NjuUNeIg=;
        b=KybHPIHuQ8/FgCekfXXUArU21KyTjajFGrmqhV6sjWYAq6QMqS7MTTcF5knKRJPsGyuTIn
        5DDkaoA0AqrsDA2+MNh0Oz2k6D2pXjz86hQYT6vGVwlXSK//W2JjOAjhIYvOra5SxZKAmw
        RhtrEpVuB5LqjvXFigoj3y0y3xIcHdwW5QzfNFYuRnnbbd7dMfDAXoxrBcN9zwRTepKJ6w
        cb0DDKKB7cqqi1WoCxH7/WBO6JViBmZsLDy3XF5uLD1FTpdogMt5I4Dfp5fCq/vuOf2o/H
        v1bMI1WNsZAyYAtSl4WYmBcva6K94OIeE/ULa20LHTfnpGz6hTSrZvk2g78Beg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634755632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blm5eGnajTwqiwOXTDtpH6C0ZVCuqAkleL8NjuUNeIg=;
        b=Cg5dgnODm5hxNiFA9jMxYDwg6v0oWz+6xbd6x5jg1CEzHYFCBaFiQiEIL4/KCHIy7bY7u/
        Fixed/uKuIH9W3CA==
From:   "irqchip-bot for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/meson-gpio: Make it possible to
 build as a module
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel test robot <lkp@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210902134914.176986-2-narmstrong@baylibre.com>
References: <20210902134914.176986-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Message-ID: <163475563139.25758.151100926730144613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     a947aa00edd4d465f89fdb6029ed40c00a344bc2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/a947aa00edd4d465f89fdb6029ed40c00a344bc2
Author:        Neil Armstrong <narmstrong@baylibre.com>
AuthorDate:    Thu, 02 Sep 2021 15:49:13 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Oct 2021 19:38:01 +01:00

irqchip/meson-gpio: Make it possible to build as a module

In order to reduce the kernel Image size on multi-platform distributions,
make it possible to build the Amlogic GPIO IRQ controller as a module
by switching it to a platform driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Saravana Kannan <saravanak@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210902134914.176986-2-narmstrong@baylibre.com
---
 drivers/irqchip/Kconfig          |  5 +++--
 drivers/irqchip/irq-meson-gpio.c | 15 +++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index aca7b59..6a4496f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -400,8 +400,9 @@ config IRQ_UNIPHIER_AIDET
 	  Support for the UniPhier AIDET (ARM Interrupt Detector).
 
 config MESON_IRQ_GPIO
-       bool "Meson GPIO Interrupt Multiplexer"
-       depends on ARCH_MESON
+       tristate "Meson GPIO Interrupt Multiplexer"
+       depends on ARCH_MESON || COMPILE_TEST
+       default ARCH_MESON
        select IRQ_DOMAIN_HIERARCHY
        help
          Support Meson SoC Family GPIO Interrupt Multiplexer
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index e50676c..d90ff0b 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -436,8 +436,7 @@ static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
 	.translate	= meson_gpio_irq_domain_translate,
 };
 
-static int __init meson_gpio_irq_parse_dt(struct device_node *node,
-					  struct meson_gpio_irq_controller *ctl)
+static int meson_gpio_irq_parse_dt(struct device_node *node, struct meson_gpio_irq_controller *ctl)
 {
 	const struct of_device_id *match;
 	int ret;
@@ -463,8 +462,7 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 	return 0;
 }
 
-static int __init meson_gpio_irq_of_init(struct device_node *node,
-					 struct device_node *parent)
+static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *domain, *parent_domain;
 	struct meson_gpio_irq_controller *ctl;
@@ -521,5 +519,10 @@ free_ctl:
 	return ret;
 }
 
-IRQCHIP_DECLARE(meson_gpio_intc, "amlogic,meson-gpio-intc",
-		meson_gpio_irq_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(meson_gpio_intc)
+IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
+
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:meson-gpio-intc");

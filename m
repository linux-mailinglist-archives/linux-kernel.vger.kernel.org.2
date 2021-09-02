Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA73FEEF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbhIBNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhIBNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:50:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01DC061764
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:49:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i3so1328245wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLgmGyyZR687J/+pz/15jDHEgQqNwXfrE8ZnHHXlyc0=;
        b=s/U4La0DHAO72mHstEVJYZkY+Sl7woZBWu2/XEKvQA/h0/NyZQgtqAVy6YFkciWELy
         BLlhmx6zU1FiaNui3lrD1MLthJ8gPlntghpwessbkeNeF02j6jAZco7aiwdOY+re/1P9
         Zvs3VLsRQ/MKY0yClEmoWHtJccGvCEf0gWcRYLsytWyeQkv9RfWkWuFTbKHAhw/JxL5t
         lYyrt4ehVxO2eVgLlPoGkivtvl2rTkXFZZy+jWG22na1torgU09GjAn9IRvkUFvsbgh5
         k6fFVhoDIR6f3tWrxK+4tLCodN362fO3zo/8SeA034wovZFaN6oLP6LdjMvmGUqyKc4Q
         lcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLgmGyyZR687J/+pz/15jDHEgQqNwXfrE8ZnHHXlyc0=;
        b=L0r8EfqxcqIHSS0UdRwTENLNfDwYXPPtN/pEH5rEmk5G/0glbgrqiFybP1g+I731BC
         t18GNOFok9b6PIIux27KUioZbQbF6wfsmzKl58yDrx4XI/HLVlsLJPth/ETH+KJeRuaK
         ZQ8AEgxseM2cATgjM95vva8Z1CVfZlckBaGWf7CY3FlDZwoEcWp2XAYpTuc5yAbnvfib
         vn/LImdOLbpfmgTGEs6c+ULaL9qG8E6ozHIMIjOCKfK7HUiF2A2h6IFywgCQr1YdvyhT
         puAxLH3/3Kxy7naSuQIR3MqGmItGGDv05hjrjg7a5rasa6qQQmScVfiOrInxa912WI9r
         +87Q==
X-Gm-Message-State: AOAM532BXjoOp0rKHQ8jPIXjrSoDUEKunPjgkTjd4pTV9i2YyPt+nEhz
        sESqMSwUjOp7NBoNCp35F3qMXg==
X-Google-Smtp-Source: ABdhPJzt3cDjV8c6FsOPHuS6R6atUfcX4eT5ztczkK88Xo6Hhj+gjFztXP1dtqAHQ9FlK6uHq+1DJQ==
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr3253429wme.119.1630590561228;
        Thu, 02 Sep 2021 06:49:21 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:98:6312:3c8:6531])
        by smtp.gmail.com with ESMTPSA id z5sm1710162wmp.26.2021.09.02.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:49:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     maz@kernel.org, tglx@linutronix.de, jbrunet@baylibre.com
Cc:     khilman@baylibre.com, lee.jones@linaro.org, saravanak@google.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build as a module
Date:   Thu,  2 Sep 2021 15:49:13 +0200
Message-Id: <20210902134914.176986-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902134914.176986-1-narmstrong@baylibre.com>
References: <20210902134914.176986-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2555; h=from:subject; bh=84C30OvZzmPYpljG1TMZKcBdjvYorCKoYX9ui2Be7/U=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhMNYUtoMMkoyUcXF9ZYgQAUMkwbshVYcbc9z33DvL HzLDCBeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYTDWFAAKCRB33NvayMhJ0SBJEA Ck48q8CPr4aBcPjUICsyNAEYVrQI8VMWI6rCkmXiIP6mEkUvAk4azsLGvQiVFU0nQu5S34ZxRS9L+2 pqmC9QBvoKKzCsmzg6taPKqCCv2VcDlvqzXp0MtWhFFE3iVH5vol79Ba5hbd0tAStFJFlOaYUSfM3N d0vrgVgIZ3vWkzW7zYhhd4Eai3WB6XoBqe1/B28HgBIlqlVwjTaXvezSxSlPFJ9alFrDLgZki+cemM 72ZdH86HUo/shgPXmMxFXrrLgG+YIAHLiUPjpwNJlVyu5Pbm8dZsZd9LFXUZ5k33Vml9aUGhVgEKLS 4siWzn/Zr/nYsdl50dJ7vhiU9qeCigqZXMleg8wgy0Rdq5OENMySo5VEqUu3UOCdFu4LaGDCIKkXPT dyZ5S/XSIeaXarvSa1R70NVKwL2zapZZ+nbqwtK5bXByDn9Mj6c7BhSGga+io0me9vvvG7uVD0DJyK hLFB+ZPS3TWeXTQ2QrKUca32yJejtoruckCGqhf3hqAXUwVM5i1iVlsslMN+nXJ8LQV06llssmtmgi ywJjwUF2RdWLXpTv1J7ZMwY9aq3NH5KQmlO6U9n3h4AL6Ex62hyQqjXGzgm7BsuCeSLzNlBUdSoJ7k iEbmAnzegWBfjT6YQrZHG/V9MAx1kf9wPmKPkgBaa4QHoFTGoEEqN5dIcnLw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the kernel Image size on multi-platform distributions,
make it possible to build the Amlogic GPIO IRQ controller as a module
by switching it to a platform driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/Kconfig          |  5 +++--
 drivers/irqchip/irq-meson-gpio.c | 15 +++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d5924e9f766..2aba485025fd 100644
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
index e50676ce2ec8..d90ff0b92480 100644
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
@@ -521,5 +519,10 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
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
-- 
2.25.1


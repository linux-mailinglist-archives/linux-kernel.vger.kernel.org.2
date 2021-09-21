Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C81412E39
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 07:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhIUFfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 01:35:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59190
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhIUFf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 01:35:27 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E53A3F331
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 05:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632202438;
        bh=4TlmOAh0qvfrJHzkziGZmFRzNpkDVdW1XKcgak45JvA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QWN94aAQgo3rr+u1rMCevkE+8cciJY+XPqCS1sUA9hI7sk36rUiH2AtuHtvHuXfyb
         HSwjIESwL76ja81jHDLqClkJ/NLVHgUirfzYSb+KIzTQYFqMTc/AwjKa9OOan49D12
         uenWaPGrW48nwkAmAJJD3tUrEX8CfV5K20/YO4up0LH4CK69whBdPPZK3T2kK3rZqo
         D3jwEDrxhulxZ6kOODheKEhSnWDEdb+HIMBMois8qM7cRjaXWxesvEW4dq2ACgGid0
         evUImPKdXuraX/sLlYAK+mqVE90uDAuInqhES1Omjlbh/jWIVlsqeyEs3MBMNPQsLJ
         uEaYSTzAo/lng==
Received: by mail-wr1-f72.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so7856358wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 22:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TlmOAh0qvfrJHzkziGZmFRzNpkDVdW1XKcgak45JvA=;
        b=nQszohOLJ6n01XsE6d/poXoVFsh/hTdPim3BNOwgrnA1ix24oMRIghsP6heaMvtibx
         4a/b1FH/PE4P0xaLbTTmBg8E/MSFwQX2TKPciAcTMgwnXpnjGSsxi2+td3MdOaoYZb19
         cDjDn5GkoOMB/eLWeuSBk4nWAWqIU8jw/Xz8WxxV6OyHb+X8kv7ZBGrGnN4hdeCHuaZ4
         34W/E4u7pN2R2kv7Ca9G+QV8eOdM8oidF+mt4IyfEI48326FMK+tifRm7J5ppp9H+WGG
         opzQML6Khq1wPcVHzLUuqK3ULN1SYdKsdbv4gFoMh0QRwpYL20j5WV/otiqzZPznqU6M
         N4tg==
X-Gm-Message-State: AOAM531uyQIsVG6JbFIOT4TZ2pKSNfqBHv5EXhpKDJoGdNfUACS1yoB4
        gLlYIkRUmYBxuqg6UszP7qHB5bdNufbzTEuqU1gHiP7x3FKr0KqCH/U0au5LuuVNmnL3PuuwUtt
        cGGp5Q3M2Riqe4hiNPJFGk48lNnTk6oKlJ6FdoaSgfw==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr32536362wrw.433.1632202438285;
        Mon, 20 Sep 2021 22:33:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF3PO09jHj58NiTJqHfOrLXT5jsJwmpB/B9bxrhespbIkwIBduu1BH34jEqXy490KPwWbh4g==
X-Received: by 2002:a5d:66d2:: with SMTP id k18mr32536349wrw.433.1632202438172;
        Mon, 20 Sep 2021 22:33:58 -0700 (PDT)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id j27sm1447809wms.6.2021.09.20.22.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 22:33:57 -0700 (PDT)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Date:   Tue, 21 Sep 2021 07:33:56 +0200
Message-Id: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SiFive Unmatched board uses the da9063 PMIC for reset: add a restart
notifier that will execute a small i2c sequence allowing to reset the
board.

The original implementation comes from Marcus Comstedt and Anders Montonen
(https://forums.sifive.com/t/reboot-command/4721/28).

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 drivers/mfd/da9063-core.c       | 25 +++++++++++++++++++++++++
 include/linux/mfd/da9063/core.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index df407c3afce3..c87b8d611f20 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/mfd/core.h>
 #include <linux/regmap.h>
+#include <linux/reboot.h>
 
 #include <linux/mfd/da9063/core.h>
 #include <linux/mfd/da9063/registers.h>
@@ -158,6 +159,18 @@ static int da9063_clear_fault_log(struct da9063 *da9063)
 	return ret;
 }
 
+static int da9063_restart_notify(struct notifier_block *this,
+				 unsigned long mode, void *cmd)
+{
+	struct da9063 *da9063 = container_of(this, struct da9063, restart_handler);
+
+	regmap_write(da9063->regmap, DA9063_REG_PAGE_CON, 0x00);
+	regmap_write(da9063->regmap, DA9063_REG_CONTROL_F, 0x04);
+	regmap_write(da9063->regmap, DA9063_REG_CONTROL_A, 0x68);
+
+	return NOTIFY_DONE;
+}
+
 int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
 	int ret;
@@ -197,6 +210,18 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 		}
 	}
 
+	da9063->restart_handler.notifier_call = da9063_restart_notify;
+	da9063->restart_handler.priority = 128;
+	ret = register_restart_handler(&da9063->restart_handler);
+	if (ret) {
+		dev_err(da9063->dev, "Failed to register restart handler\n");
+		return ret;
+	}
+
+	devm_add_action(da9063->dev,
+			(void (*)(void *))unregister_restart_handler,
+			&da9063->restart_handler);
+
 	return ret;
 }
 
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index fa7a43f02f27..1b20c498e340 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -85,6 +85,9 @@ struct da9063 {
 	int		chip_irq;
 	unsigned int	irq_base;
 	struct regmap_irq_chip_data *regmap_irq;
+
+	/* Restart */
+	struct notifier_block restart_handler;
 };
 
 int da9063_device_init(struct da9063 *da9063, unsigned int irq);
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC72240D39F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhIPHOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPHO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:14:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:13:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v24so13061251eda.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNUDSan1JdvyI7lP4B9fMSdyxgq2XhCs6SW5nNRT/IQ=;
        b=VuEhAJ9Xdyp0UbX5+otn7FTn7N52JZEJe1ecThl/PVC3thN6BMt3QY5uSYH7+rzv4v
         wRpPaYi5U+Z5FXJ2G22u8h66/qq7xixMomuqipFroJgn1meT0d5yokbLJoeFhSt1uhNy
         2cCfLIuHj8gASF+pdJvhXERSWO4koH71I/VxMZK/zmXObWhu6GH5rHI/vgetO7ZaklVF
         V/bwwCOWBe0tSVCqZzPqJ7iYZdW2NeuXfH67eYcooUXddCQRWt2K0bI+KpP9z0aLH1BU
         H/vB9or6KmfX/nW6KPUsB2ZREsh6W0Oko89rpj4EEgfwvya4NRWvzyQoA1jeddJAuHM2
         60Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNUDSan1JdvyI7lP4B9fMSdyxgq2XhCs6SW5nNRT/IQ=;
        b=rD0ii0CIwSa4RYKbtNI2/aitkMoaCg2Pmc+W9cT0lIRI29r3pVqqhk3EzPPFACuf1a
         pEJRyXR4QT2J1Akn11IeOssvnpsxCRgTI/85cQOVwxJwe1vsWLqsgjAGM7o2IQiJyICe
         XnwtgM9ft/uEa/LbpdEJimznJtaEyONF7h2xhO9Cy0X8cIjlXJ9/8btJHtO6E7HpKOIM
         cvk5eSNd/zpKisi9yqhcDkQ9SgD6MDAfIXtnbqWyBBIFEqb2iM+zdZ7KjmpUhrLbG7VH
         WDFI+r4uAb8io84oac3cX6yUHn7ejfkCmMWWy/O7ZxXLmcGPvqR6KDeLL0bOBeCOM4y1
         K31A==
X-Gm-Message-State: AOAM530CfZKTvWQRB8XiJjjHogqCUZ9CciuqUMiJYDnnpnEa0loTYZsU
        rZ4/dcVvi3LFz3QBYD/lu/g=
X-Google-Smtp-Source: ABdhPJypWGqlumZGFFWhvfTgl0p2Qo83wMEWbyu0Ih7TSI1jFmyLMah1zn1L9tUWpRWiUDzW7oEPLw==
X-Received: by 2002:a17:906:1bb1:: with SMTP id r17mr4633625ejg.533.1631776387050;
        Thu, 16 Sep 2021 00:13:07 -0700 (PDT)
Received: from agape ([5.171.81.56])
        by smtp.gmail.com with ESMTPSA id p11sm837809ejb.61.2021.09.16.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 00:13:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2] extcon: extcon-axp288: use P-Unit semaphore lock for register accesses
Date:   Thu, 16 Sep 2021 09:12:55 +0200
Message-Id: <20210916071255.2572-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use low level P-Unit semaphore lock for axp288 register
accesses directly and for more than one access a time,
to reduce the number of times this semaphore is locked
and released which is an expensive operation.

i2c-bus to the XPower is shared between the kernel and the
SoCs P-Unit. The P-Unit has a semaphore wich the kernel must
lock for axp288 register accesses. When the P-Unit semaphore
is locked CPU and GPU power states cannot change or the system
will freeze.

The P-Unit semaphore lock is already managed inside the regmap
access logic, but for each access the semaphore is locked and
released. So use directly iosf_mbi_(un)block_punit_i2c_access(),
we are safe in doing so because nested calls to the same
semaphore are turned to nops.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
Changes in v2:
	- shortened patch title within 75 char
	- added return value check in function
	  iosf_mbi_lock_punit_i2c_access() calls

 drivers/extcon/Kconfig         |  2 +-
 drivers/extcon/extcon-axp288.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index c69d40ae5619..aab87c9b35c8 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -23,7 +23,7 @@ config EXTCON_ADC_JACK
 
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
-	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
+	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI && IOSF_MBI
 	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral detection
diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index fdb31954cf2b..7c6d5857ff25 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -24,6 +24,7 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 
 /* Power source status register */
 #define PS_STAT_VBUS_TRIGGER		BIT(0)
@@ -215,6 +216,10 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	unsigned int cable = info->previous_cable;
 	bool vbus_attach = false;
 
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret < 0)
+		return ret;
+
 	vbus_attach = axp288_get_vbus_attach(info);
 	if (!vbus_attach)
 		goto no_vbus;
@@ -253,6 +258,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	}
 
 no_vbus:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	extcon_set_state_sync(info->edev, info->previous_cable, false);
 	if (info->previous_cable == EXTCON_CHG_USB_SDP)
 		extcon_set_state_sync(info->edev, EXTCON_USB, false);
@@ -275,6 +282,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	return 0;
 
 dev_det_ret:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	if (ret < 0)
 		dev_err(info->dev, "failed to detect BC Mod\n");
 
@@ -305,13 +314,23 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void axp288_extcon_enable(struct axp288_extcon_info *info)
+static int axp288_extcon_enable(struct axp288_extcon_info *info)
 {
+	int ret = 0;
+
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret < 0)
+		return ret;
+
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 						BC_GLOBAL_RUN, 0);
 	/* Enable the charger detection logic */
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
+
+	iosf_mbi_unblock_punit_i2c_access();
+
+	return ret;
 }
 
 static void axp288_put_role_sw(void *data)
@@ -384,10 +403,16 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = iosf_mbi_block_punit_i2c_access();
+	if (ret < 0)
+		return ret;
+
 	info->vbus_attach = axp288_get_vbus_attach(info);
 
 	axp288_extcon_log_rsi(info);
 
+	iosf_mbi_unblock_punit_i2c_access();
+
 	/* Initialize extcon device */
 	info->edev = devm_extcon_dev_allocate(&pdev->dev,
 					      axp288_extcon_cables);
@@ -441,7 +466,9 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 	}
 
 	/* Start charger cable type detection */
-	axp288_extcon_enable(info);
+	ret = axp288_extcon_enable(info);
+	if (ret < 0)
+		return ret;
 
 	device_init_wakeup(dev, true);
 	platform_set_drvdata(pdev, info);
-- 
2.20.1


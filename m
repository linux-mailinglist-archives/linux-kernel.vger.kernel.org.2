Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE214067C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhIJHhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhIJHhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:37:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088FBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:36:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x6so1241137wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HZmKmtxcm0GsfuqPkFJEc2EnxNM//HUsd/k54JVmgE=;
        b=ajvTfUPwwSZ48ka5hfzC40YBn3znfRomTWIV9PTrmCVoS6dHdETQeyvL3HFARD84dF
         Jy97q75Q89FJHjiLrfqjyL9qxVZYB9tPTBuy68hY1l0bs4+C/okUDefB7DcbdazrMODa
         ZfzJPv6VWuFtFF4kMmemHPvESTHbZSzFe9/AHfeS88CtECvUYYrqc/LWWjfO60a1cDQW
         sbWoH1l4pEYezj+P1KNVQm6FqWLUlhZDzZN6CMK71AC16H8b4fco3x1YLXOW0rkDFpzw
         3muujkoEq0zq/uibIaRK6H2KlZgsP3/FhynZoSWB5sgfYYEuQxFWulA2cKe+LHs5r3a/
         BsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+HZmKmtxcm0GsfuqPkFJEc2EnxNM//HUsd/k54JVmgE=;
        b=BbA8ZfoNUSP1KGoniz8ka8fDPHRgeHi4z3O7ZJNAP6cnz2GXG5gkCP6ZfdscfJph4/
         QYGVHcWo+/gBxPSDeh/kAYsfLnGF1iOs0I0uF40bNyspK0tLQ3gfP2wm1Ic0GqR27+u/
         ABdTvO+UO8WREohNZdWbG+f1MfsVqxa6Fn1lEBpb4vzJ/kbur7oZqYxO6pW/kcYXl65T
         5yZClY0H0ebBQ9PJaNV7E9hLYw6caXpeycH64jWSoXuNqTxUwJrt/0xQ7SXBM++L9S4F
         xwiXh/bH5hRtu9fb12qDCbLG31vbp5WvOPn3os1JAN+9F3CnHpMrb/GwfH6BYyLo46Hp
         +EGA==
X-Gm-Message-State: AOAM5301fGSOCrIbsy00KLtY+W/TCjOP5a4Xnhh9E0X+b/tXkWzwvumP
        rIRUDRikOpDJ5EmBeqKZVCc=
X-Google-Smtp-Source: ABdhPJwZilWIRSQMBpcE17Y7I3Zg5J5Bn8OH7PmIpULPL6aWmGwTommyFlOeG9665NF8YOL6tE5MXA==
X-Received: by 2002:a5d:6792:: with SMTP id v18mr5925833wru.416.1631259384318;
        Fri, 10 Sep 2021 00:36:24 -0700 (PDT)
Received: from agape ([5.171.81.87])
        by smtp.gmail.com with ESMTPSA id o7sm3405432wmc.46.2021.09.10.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 00:36:23 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2] extcon: extcon-axp288: use low level P-Unit semaphore lock for axp288 register accesses
Date:   Fri, 10 Sep 2021 09:34:40 +0200
Message-Id: <20210910073440.2190-1-fabioaiuto83@gmail.com>
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
	- add a new depends on in Kconfig
	- add Tested-by Reviewed-by tags
 
 drivers/extcon/Kconfig         |  2 +-
 drivers/extcon/extcon-axp288.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index fdb31954cf2b..460402b14ef2 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -24,6 +24,7 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 
 /* Power source status register */
 #define PS_STAT_VBUS_TRIGGER		BIT(0)
@@ -215,6 +216,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	unsigned int cable = info->previous_cable;
 	bool vbus_attach = false;
 
+	iosf_mbi_block_punit_i2c_access();
+
 	vbus_attach = axp288_get_vbus_attach(info);
 	if (!vbus_attach)
 		goto no_vbus;
@@ -253,6 +256,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	}
 
 no_vbus:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	extcon_set_state_sync(info->edev, info->previous_cable, false);
 	if (info->previous_cable == EXTCON_CHG_USB_SDP)
 		extcon_set_state_sync(info->edev, EXTCON_USB, false);
@@ -275,6 +280,8 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	return 0;
 
 dev_det_ret:
+	iosf_mbi_unblock_punit_i2c_access();
+
 	if (ret < 0)
 		dev_err(info->dev, "failed to detect BC Mod\n");
 
@@ -307,11 +314,14 @@ static irqreturn_t axp288_extcon_isr(int irq, void *data)
 
 static void axp288_extcon_enable(struct axp288_extcon_info *info)
 {
+	iosf_mbi_block_punit_i2c_access();
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 						BC_GLOBAL_RUN, 0);
 	/* Enable the charger detection logic */
 	regmap_update_bits(info->regmap, AXP288_BC_GLOBAL_REG,
 					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
+
+	iosf_mbi_unblock_punit_i2c_access();
 }
 
 static void axp288_put_role_sw(void *data)
@@ -384,10 +394,14 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		}
 	}
 
+	iosf_mbi_block_punit_i2c_access();
+
 	info->vbus_attach = axp288_get_vbus_attach(info);
 
 	axp288_extcon_log_rsi(info);
 
+	iosf_mbi_unblock_punit_i2c_access();
+
 	/* Initialize extcon device */
 	info->edev = devm_extcon_dev_allocate(&pdev->dev,
 					      axp288_extcon_cables);
-- 
2.20.1


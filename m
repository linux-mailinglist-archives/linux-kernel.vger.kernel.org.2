Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30D143F795
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhJ2HEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 03:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhJ2HEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 03:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A528C60F22;
        Fri, 29 Oct 2021 07:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635490935;
        bh=HUD22CJu2/7EA+CW0xppVEoR4ensKB8sBgNd3uOAMxw=;
        h=From:To:Cc:Subject:Date:From;
        b=DWMZOPIQcA0ua3sIprhBTZ8MdToPSfuvRNNMJV+bnqLsu0TTgW3jfSJqnUKiND1RJ
         +5u9pEQYBmhkLrntkEBDRjfHwTkoGc1j8UhM5DURPRPYNc0zOXQcwF0tBvb0fFZhz0
         8IlP9YZst2TVVDVzoQYrBRux3jNZ1p6mP6YtPqbvcyWV/i3FrUxfU06zqBprL2++2l
         ZUr7oKQiQsTPqUM6aEKSSISpAvIfJwTQLwOIC+i3Sj2hLd5A8XJX2DF4trnTIK6Zdo
         iekloAGSWswILZMevQ0oHhKuwuGqXwSgIqJUK1xvGX+3RJNIzmOHfbPobJb7CFm7fr
         xPwR+Aw6pleHw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mgLu0-002qIn-SC; Fri, 29 Oct 2021 08:02:12 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Date:   Fri, 29 Oct 2021 08:02:06 +0100
Message-Id: <f12ed3dea697e6fdcfcaf9b6cc862ffa7aac005b.1635490923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
loading the fbcon driver, as otherwise the i915 driver will
fail to configure pwm:

[   13.674287] fb0: switching to inteldrmfb from EFI VGA
[   13.682380] Console: switching to colour dummy device 80x25
[   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
[   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
[   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
[   13.739044] fbcon: i915drmfb (fb0) is primary device
[   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
...
[   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
[   24.630540] intel_pmic_install_opregion_handler: OpRegion registered

(some extra debug printk's were added to the above)

As suggested by Hans, this patch also addresses an issue with
the dependencies, as, for this driver to be a bool, it also
need the I2C core and the I2C_DESIGNWARE driver to be builtin.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ca0edab91aeb..f9092c79c4e8 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -632,7 +632,7 @@ config INTEL_SOC_PMIC_CHTWC
 config INTEL_SOC_PMIC_CHTDC_TI
 	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
 	depends on GPIOLIB
-	depends on I2C
+	depends on I2C = y && I2C_DESIGNWARE_PLATFORM=y
 	depends on ACPI
 	depends on X86
 	select MFD_CORE
@@ -642,6 +642,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
 	  Select this option for supporting Dollar Cove (TI version) PMIC
 	  device that is found on some Intel Cherry Trail systems.
 
+	  This option is a bool as it provides an ACPI OpRegion which must be
+	  available before any devices using it are probed. This option also
+	  needs the designware-i2c driver to be builtin for the same reason.
+
 config INTEL_SOC_PMIC_MRFLD
 	tristate "Support for Intel Merrifield Basin Cove PMIC"
 	depends on GPIOLIB
-- 
2.31.1


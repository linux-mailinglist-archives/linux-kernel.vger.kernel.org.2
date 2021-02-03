Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A830E3B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBCT71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:59:27 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:58216 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230218AbhBCT7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:59:21 -0500
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113JplZo028204;
        Wed, 3 Feb 2021 14:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=smtpout1;
 bh=FP1he4G3SrlfQMGRl5jJh4Ily68We8obweLk/0Dh0lI=;
 b=hXbEh9OIxNhs4Uf5HCRm9GTyeDDCFKhWKJAmS4L2fMK9UHjFc1W4SdGRjjssCveO529g
 VQubP2qjpqCwF1WiM9kDR85IKn8BfL4rr9cLCI3Ej1xF7l9jQf9M6dA8JS4bha1n/o2J
 GYz3sf8dsE833kBS2s9yrt0axZjXTMVPbcGzyCe/fs4NV98sqM9rayhI/UwZ4363y7sb
 ucVGzsJZfLn04W1OXKicrU5KcY0rqigUVJ9vOkfIgI4ZmP2CWKRl4D//KDC4+MQ33gpL
 3lSNy/FNL0c4x/jmmsDjS1kABqbJbW/Hz3JBvk2xofooL8YhL3c97vu2l35M5OKKtLZW RA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 36d3d8xbse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Feb 2021 14:58:39 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113Ju1p3009357;
        Wed, 3 Feb 2021 14:58:38 -0500
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 36ffuhyd1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 14:58:38 -0500
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.79,399,1602565200"; 
   d="scan'208";a="1662454287"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Hans De Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] platform/x86: Move all dell drivers to their own subdirectory
Date:   Wed,  3 Feb 2021 13:58:32 -0600
Message-Id: <20210203195832.2950605-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-03_07:2021-02-03,2021-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030117
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user without a Dell system doesn't need to pick any of these
drivers.

Users with a Dell system can enable this submenu and all drivers
behind it will be enabled.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
Changes from v1->v2:
 - Rename menu per Andy's suggestion
 - Move if/endif for menu into subdirectory
 - Set default for menu to "n" but individual modules to "m"
   Should be same defaults as previous, but allow an "easy" switch
 MAINTAINERS                                   |  22 +-
 drivers/platform/x86/Kconfig                  | 176 +--------------
 drivers/platform/x86/Makefile                 |  16 +-
 drivers/platform/x86/dell/Kconfig             | 207 ++++++++++++++++++
 drivers/platform/x86/dell/Makefile            |  21 ++
 .../platform/x86/{ => dell}/alienware-wmi.c   |   0
 drivers/platform/x86/{ => dell}/dcdbas.c      |   0
 drivers/platform/x86/{ => dell}/dcdbas.h      |   0
 drivers/platform/x86/{ => dell}/dell-laptop.c |   0
 drivers/platform/x86/{ => dell}/dell-rbtn.c   |   0
 drivers/platform/x86/{ => dell}/dell-rbtn.h   |   0
 .../x86/{ => dell}/dell-smbios-base.c         |   0
 .../platform/x86/{ => dell}/dell-smbios-smm.c |   0
 .../platform/x86/{ => dell}/dell-smbios-wmi.c |   0
 drivers/platform/x86/{ => dell}/dell-smbios.h |   0
 .../platform/x86/{ => dell}/dell-smo8800.c    |   0
 .../platform/x86/{ => dell}/dell-wmi-aio.c    |   0
 .../x86/{ => dell}/dell-wmi-descriptor.c      |   0
 .../x86/{ => dell}/dell-wmi-descriptor.h      |   0
 .../platform/x86/{ => dell}/dell-wmi-led.c    |   0
 .../x86/{ => dell}/dell-wmi-sysman/Makefile   |   0
 .../dell-wmi-sysman/biosattr-interface.c      |   0
 .../dell-wmi-sysman/dell-wmi-sysman.h         |   0
 .../dell-wmi-sysman/enum-attributes.c         |   0
 .../dell-wmi-sysman/int-attributes.c          |   0
 .../dell-wmi-sysman/passobj-attributes.c      |   0
 .../dell-wmi-sysman/passwordattr-interface.c  |   0
 .../dell-wmi-sysman/string-attributes.c       |   0
 .../x86/{ => dell}/dell-wmi-sysman/sysman.c   |   0
 drivers/platform/x86/{ => dell}/dell-wmi.c    |   0
 drivers/platform/x86/{ => dell}/dell_rbu.c    |   0
 31 files changed, 241 insertions(+), 201 deletions(-)
 create mode 100644 drivers/platform/x86/dell/Kconfig
 create mode 100644 drivers/platform/x86/dell/Makefile
 rename drivers/platform/x86/{ => dell}/alienware-wmi.c (100%)
 rename drivers/platform/x86/{ => dell}/dcdbas.c (100%)
 rename drivers/platform/x86/{ => dell}/dcdbas.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-laptop.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-rbtn.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-rbtn.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios-base.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios-smm.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios-wmi.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-smbios.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-smo8800.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-aio.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-descriptor.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-descriptor.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-led.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/Makefile (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/biosattr-interface.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/dell-wmi-sysman.h (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/enum-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/int-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/passobj-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/passwordattr-interface.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/string-attributes.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi-sysman/sysman.c (100%)
 rename drivers/platform/x86/{ => dell}/dell-wmi.c (100%)
 rename drivers/platform/x86/{ => dell}/dell_rbu.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d3e847f7f3dc..ae83c6cff843 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4970,17 +4970,17 @@ M:	Matthew Garrett <mjg59@srcf.ucam.org>
 M:	Pali Rohár <pali@kernel.org>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell-laptop.c
+F:	drivers/platform/x86/dell/dell-laptop.c
 
 DELL LAPTOP FREEFALL DRIVER
 M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
-F:	drivers/platform/x86/dell-smo8800.c
+F:	drivers/platform/x86/dell/dell-smo8800.c
 
 DELL LAPTOP RBTN DRIVER
 M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
-F:	drivers/platform/x86/dell-rbtn.*
+F:	drivers/platform/x86/dell/dell-rbtn.*
 
 DELL LAPTOP SMM DRIVER
 M:	Pali Rohár <pali@kernel.org>
@@ -4992,26 +4992,26 @@ DELL REMOTE BIOS UPDATE DRIVER
 M:	Stuart Hayes <stuart.w.hayes@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell_rbu.c
+F:	drivers/platform/x86/dell/dell_rbu.c
 
 DELL SMBIOS DRIVER
 M:	Pali Rohár <pali@kernel.org>
 M:	Mario Limonciello <mario.limonciello@dell.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell-smbios.*
+F:	drivers/platform/x86/dell/dell-smbios.*
 
 DELL SMBIOS SMM DRIVER
 M:	Mario Limonciello <mario.limonciello@dell.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell-smbios-smm.c
+F:	drivers/platform/x86/dell/dell-smbios-smm.c
 
 DELL SMBIOS WMI DRIVER
 M:	Mario Limonciello <mario.limonciello@dell.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/x86/dell-smbios-wmi.c
+F:	drivers/platform/x86/dell/dell-smbios-wmi.c
 F:	tools/wmi/dell-smbios-example.c
 
 DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
@@ -5019,12 +5019,12 @@ M:	Stuart Hayes <stuart.w.hayes@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/driver-api/dcdbas.rst
-F:	drivers/platform/x86/dcdbas.*
+F:	drivers/platform/x86/dell/dcdbas.*
 
 DELL WMI DESCRIPTOR DRIVER
 M:	Mario Limonciello <mario.limonciello@dell.com>
 S:	Maintained
-F:	drivers/platform/x86/dell-wmi-descriptor.c
+F:	drivers/platform/x86/dell/dell-wmi-descriptor.c
 
 DELL WMI SYSMAN DRIVER
 M:	Divya Bharathi <divya.bharathi@dell.com>
@@ -5033,13 +5033,13 @@ M:	Prasanth Ksr <prasanth.ksr@dell.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-firmware-attributes
-F:	drivers/platform/x86/dell-wmi-sysman/
+F:	drivers/platform/x86/dell/dell-wmi-sysman/
 
 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
 M:	Pali Rohár <pali@kernel.org>
 S:	Maintained
-F:	drivers/platform/x86/dell-wmi.c
+F:	drivers/platform/x86/dell/dell-wmi.c
 
 DELTA ST MEDIA DRIVER
 M:	Hugues Fruchet <hugues.fruchet@st.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 91e6176cdfbd..211cf907f041 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -49,18 +49,6 @@ config WMI_BMOF
 	  To compile this driver as a module, choose M here: the module will
 	  be called wmi-bmof.
 
-config ALIENWARE_WMI
-	tristate "Alienware Special feature control"
-	depends on ACPI
-	depends on LEDS_CLASS
-	depends on NEW_LEDS
-	depends on ACPI_WMI
-	help
-	 This is a driver for controlling Alienware BIOS driven
-	 features.  It exposes an interface for controlling the AlienFX
-	 zones on Alienware machines that don't contain a dedicated AlienFX
-	 USB MCU such as the X51 and X51-R2.
-
 config HUAWEI_WMI
 	tristate "Huawei WMI laptop extras driver"
 	depends on ACPI_BATTERY
@@ -327,169 +315,7 @@ config EEEPC_WMI
 	  If you have an ACPI-WMI compatible Eee PC laptop (>= 1000), say Y or M
 	  here.
 
-config DCDBAS
-	tristate "Dell Systems Management Base Driver"
-	depends on X86
-	help
-	  The Dell Systems Management Base Driver provides a sysfs interface
-	  for systems management software to perform System Management
-	  Interrupts (SMIs) and Host Control Actions (system power cycle or
-	  power off after OS shutdown) on certain Dell systems.
-
-	  See <file:Documentation/driver-api/dcdbas.rst> for more details on the driver
-	  and the Dell systems on which Dell systems management software makes
-	  use of this driver.
-
-	  Say Y or M here to enable the driver for use by Dell systems
-	  management software such as Dell OpenManage.
-
-#
-# The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
-# backends are selected. The "depends" line prevents a configuration
-# where DELL_SMBIOS=y while either of those dependencies =m.
-#
-config DELL_SMBIOS
-	tristate "Dell SMBIOS driver"
-	depends on DCDBAS || DCDBAS=n
-	depends on ACPI_WMI || ACPI_WMI=n
-	help
-	This provides support for the Dell SMBIOS calling interface.
-	If you have a Dell computer you should enable this option.
-
-	Be sure to select at least one backend for it to work properly.
-
-config DELL_SMBIOS_WMI
-	bool "Dell SMBIOS driver WMI backend"
-	default y
-	depends on ACPI_WMI
-	select DELL_WMI_DESCRIPTOR
-	depends on DELL_SMBIOS
-	help
-	This provides an implementation for the Dell SMBIOS calling interface
-	communicated over ACPI-WMI.
-
-	If you have a Dell computer from >2007 you should say Y here.
-	If you aren't sure and this module doesn't work for your computer
-	it just won't load.
-
-config DELL_SMBIOS_SMM
-	bool "Dell SMBIOS driver SMM backend"
-	default y
-	depends on DCDBAS
-	depends on DELL_SMBIOS
-	help
-	This provides an implementation for the Dell SMBIOS calling interface
-	communicated over SMI/SMM.
-
-	If you have a Dell computer from <=2017 you should say Y here.
-	If you aren't sure and this module doesn't work for your computer
-	it just won't load.
-
-config DELL_LAPTOP
-	tristate "Dell Laptop Extras"
-	depends on DMI
-	depends on BACKLIGHT_CLASS_DEVICE
-	depends on ACPI_VIDEO || ACPI_VIDEO = n
-	depends on RFKILL || RFKILL = n
-	depends on SERIO_I8042
-	depends on DELL_SMBIOS
-	select POWER_SUPPLY
-	select LEDS_CLASS
-	select NEW_LEDS
-	select LEDS_TRIGGERS
-	select LEDS_TRIGGER_AUDIO
-	help
-	This driver adds support for rfkill and backlight control to Dell
-	laptops (except for some models covered by the Compal driver).
-
-config DELL_RBTN
-	tristate "Dell Airplane Mode Switch driver"
-	depends on ACPI
-	depends on INPUT
-	depends on RFKILL
-	help
-	  Say Y here if you want to support Dell Airplane Mode Switch ACPI
-	  device on Dell laptops. Sometimes it has names: DELLABCE or DELRBTN.
-	  This driver register rfkill device or input hotkey device depending
-	  on hardware type (hw switch slider or keyboard toggle button). For
-	  rfkill devices it receive HW switch events and set correct hard
-	  rfkill state.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called dell-rbtn.
-
-config DELL_RBU
-	tristate "BIOS update support for DELL systems via sysfs"
-	depends on X86
-	select FW_LOADER
-	select FW_LOADER_USER_HELPER
-	help
-	 Say m if you want to have the option of updating the BIOS for your
-	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
-	 supporting application to communicate with the BIOS regarding the new
-	 image for the image update to take effect.
-	 See <file:Documentation/admin-guide/dell_rbu.rst> for more details on the driver.
-
-config DELL_SMO8800
-	tristate "Dell Latitude freefall driver (ACPI SMO88XX)"
-	depends on ACPI
-	help
-	  Say Y here if you want to support SMO88XX freefall devices
-	  on Dell Latitude laptops.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called dell-smo8800.
-
-config DELL_WMI
-	tristate "Dell WMI notifications"
-	depends on ACPI_WMI
-	depends on DMI
-	depends on INPUT
-	depends on ACPI_VIDEO || ACPI_VIDEO = n
-	depends on DELL_SMBIOS
-	select DELL_WMI_DESCRIPTOR
-	select INPUT_SPARSEKMAP
-	help
-	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called dell-wmi.
-
-config DELL_WMI_SYSMAN
-	tristate "Dell WMI-based Systems management driver"
-	depends on ACPI_WMI
-	depends on DMI
-	select NLS
-	help
-	  This driver allows changing BIOS settings on many Dell machines from
-	  2018 and newer without the use of any additional software.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called dell-wmi-sysman.
-
-config DELL_WMI_DESCRIPTOR
-	tristate
-	depends on ACPI_WMI
-
-config DELL_WMI_AIO
-	tristate "WMI Hotkeys for Dell All-In-One series"
-	depends on ACPI_WMI
-	depends on INPUT
-	select INPUT_SPARSEKMAP
-	help
-	  Say Y here if you want to support WMI-based hotkeys on Dell
-	  All-In-One machines.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called dell-wmi-aio.
-
-config DELL_WMI_LED
-	tristate "External LED on Dell Business Netbooks"
-	depends on LEDS_CLASS
-	depends on ACPI_WMI
-	help
-	  This adds support for the Latitude 2100 and similar
-	  notebooks that have an external LED.
+source "drivers/platform/x86/dell/Kconfig"
 
 config AMILO_RFKILL
 	tristate "Fujitsu-Siemens Amilo rfkill support"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 581475f59819..98ad9bcac293 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -9,7 +9,6 @@ obj-$(CONFIG_ACPI_WMI)		+= wmi.o
 obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # WMI drivers
-obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
 obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
 obj-$(CONFIG_INTEL_WMI_SBL_FW_UPDATE)	+= intel-wmi-sbl-fw-update.o
 obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)	+= intel-wmi-thunderbolt.o
@@ -37,20 +36,7 @@ obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
 obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
 
 # Dell
-obj-$(CONFIG_DCDBAS)			+= dcdbas.o
-obj-$(CONFIG_DELL_SMBIOS)		+= dell-smbios.o
-dell-smbios-objs			:= dell-smbios-base.o
-dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
-dell-smbios-$(CONFIG_DELL_SMBIOS_SMM)	+= dell-smbios-smm.o
-obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
-obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
-obj-$(CONFIG_DELL_RBU)			+= dell_rbu.o
-obj-$(CONFIG_DELL_SMO8800)		+= dell-smo8800.o
-obj-$(CONFIG_DELL_WMI)			+= dell-wmi.o
-obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
-obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
-obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
-obj-$(CONFIG_DELL_WMI_SYSMAN)		+= dell-wmi-sysman/
+obj-$(CONFIG_X86_PLATFORM_DRIVERS_DELL)		+= dell/
 
 # Fujitsu
 obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
new file mode 100644
index 000000000000..31601679d1cc
--- /dev/null
+++ b/drivers/platform/x86/dell/Kconfig
@@ -0,0 +1,207 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Dell X86 Platform Specific Drivers
+#
+
+menuconfig X86_PLATFORM_DRIVERS_DELL
+	bool "Dell X86 Platform Specific Device Drivers"
+	default n
+	depends on X86_PLATFORM_DEVICES
+	help
+	  Say Y here to get to see options for device drivers for various
+	  Dell x86 platforms, including vendor-specific laptop extension drivers.
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if X86_PLATFORM_DRIVERS_DELL
+
+config ALIENWARE_WMI
+	tristate "Alienware Special feature control"
+    default m
+	depends on ACPI
+	depends on LEDS_CLASS
+	depends on NEW_LEDS
+	depends on ACPI_WMI
+	help
+	 This is a driver for controlling Alienware BIOS driven
+	 features.  It exposes an interface for controlling the AlienFX
+	 zones on Alienware machines that don't contain a dedicated AlienFX
+	 USB MCU such as the X51 and X51-R2.
+
+config DCDBAS
+	tristate "Dell Systems Management Base Driver"
+    default m
+	depends on X86
+	help
+	  The Dell Systems Management Base Driver provides a sysfs interface
+	  for systems management software to perform System Management
+	  Interrupts (SMIs) and Host Control Actions (system power cycle or
+	  power off after OS shutdown) on certain Dell systems.
+
+	  See <file:Documentation/driver-api/dcdbas.rst> for more details on the driver
+	  and the Dell systems on which Dell systems management software makes
+	  use of this driver.
+
+	  Say Y or M here to enable the driver for use by Dell systems
+	  management software such as Dell OpenManage.
+
+config DELL_LAPTOP
+	tristate "Dell Laptop Extras"
+    default m
+	depends on DMI
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on RFKILL || RFKILL = n
+	depends on SERIO_I8042
+	depends on DELL_SMBIOS
+	select POWER_SUPPLY
+	select LEDS_CLASS
+	select NEW_LEDS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_AUDIO
+	help
+	This driver adds support for rfkill and backlight control to Dell
+	laptops (except for some models covered by the Compal driver).
+
+config DELL_RBU
+	tristate "BIOS update support for DELL systems via sysfs"
+    default m
+	depends on X86
+	select FW_LOADER
+	select FW_LOADER_USER_HELPER
+	help
+	 Say m if you want to have the option of updating the BIOS for your
+	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
+	 supporting application to communicate with the BIOS regarding the new
+	 image for the image update to take effect.
+	 See <file:Documentation/admin-guide/dell_rbu.rst> for more details on the driver.
+
+config DELL_RBTN
+	tristate "Dell Airplane Mode Switch driver"
+    default m
+	depends on ACPI
+	depends on INPUT
+	depends on RFKILL
+	help
+	  Say Y here if you want to support Dell Airplane Mode Switch ACPI
+	  device on Dell laptops. Sometimes it has names: DELLABCE or DELRBTN.
+	  This driver register rfkill device or input hotkey device depending
+	  on hardware type (hw switch slider or keyboard toggle button). For
+	  rfkill devices it receive HW switch events and set correct hard
+	  rfkill state.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called dell-rbtn.
+
+#
+# The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
+# backends are selected. The "depends" line prevents a configuration
+# where DELL_SMBIOS=y while either of those dependencies =m.
+#
+config DELL_SMBIOS
+	tristate "Dell SMBIOS driver"
+    default m
+	depends on DCDBAS || DCDBAS=n
+	depends on ACPI_WMI || ACPI_WMI=n
+	help
+	This provides support for the Dell SMBIOS calling interface.
+	If you have a Dell computer you should enable this option.
+
+	Be sure to select at least one backend for it to work properly.
+
+config DELL_SMBIOS_WMI
+	bool "Dell SMBIOS driver WMI backend"
+	default y
+	depends on ACPI_WMI
+	select DELL_WMI_DESCRIPTOR
+	depends on DELL_SMBIOS
+	help
+	This provides an implementation for the Dell SMBIOS calling interface
+	communicated over ACPI-WMI.
+
+	If you have a Dell computer from >2007 you should say Y here.
+	If you aren't sure and this module doesn't work for your computer
+	it just won't load.
+
+config DELL_SMBIOS_SMM
+	bool "Dell SMBIOS driver SMM backend"
+	default y
+	depends on DCDBAS
+	depends on DELL_SMBIOS
+	help
+	This provides an implementation for the Dell SMBIOS calling interface
+	communicated over SMI/SMM.
+
+	If you have a Dell computer from <=2017 you should say Y here.
+	If you aren't sure and this module doesn't work for your computer
+	it just won't load.
+
+config DELL_SMO8800
+	tristate "Dell Latitude freefall driver (ACPI SMO88XX)"
+    default m
+	depends on ACPI
+	help
+	  Say Y here if you want to support SMO88XX freefall devices
+	  on Dell Latitude laptops.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called dell-smo8800.
+
+config DELL_WMI
+	tristate "Dell WMI notifications"
+    default m
+	depends on ACPI_WMI
+	depends on DMI
+	depends on INPUT
+	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on DELL_SMBIOS
+	select DELL_WMI_DESCRIPTOR
+	select INPUT_SPARSEKMAP
+	help
+	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called dell-wmi.
+
+config DELL_WMI_AIO
+	tristate "WMI Hotkeys for Dell All-In-One series"
+    default m
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  Say Y here if you want to support WMI-based hotkeys on Dell
+	  All-In-One machines.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called dell-wmi-aio.
+
+config DELL_WMI_DESCRIPTOR
+	tristate
+    default m
+	depends on ACPI_WMI
+
+config DELL_WMI_LED
+	tristate "External LED on Dell Business Netbooks"
+    default m
+	depends on LEDS_CLASS
+	depends on ACPI_WMI
+	help
+	  This adds support for the Latitude 2100 and similar
+	  notebooks that have an external LED.
+
+config DELL_WMI_SYSMAN
+	tristate "Dell WMI-based Systems management driver"
+    default m
+	depends on ACPI_WMI
+	depends on DMI
+	select NLS
+	help
+	  This driver allows changing BIOS settings on many Dell machines from
+	  2018 and newer without the use of any additional software.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called dell-wmi-sysman.
+
+endif # X86_PLATFORM_DRIVERS_DELL
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
new file mode 100644
index 000000000000..d720a3e42ae3
--- /dev/null
+++ b/drivers/platform/x86/dell/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/x86/dell
+# Dell x86 Platform-Specific Drivers
+#
+
+obj-$(CONFIG_ALIENWARE_WMI)		+= alienware-wmi.o
+obj-$(CONFIG_DCDBAS)			+= dcdbas.o
+obj-$(CONFIG_DELL_LAPTOP)		+= dell-laptop.o
+obj-$(CONFIG_DELL_RBTN)			+= dell-rbtn.o
+obj-$(CONFIG_DELL_RBU)			+= dell_rbu.o
+obj-$(CONFIG_DELL_SMBIOS)		+= dell-smbios.o
+dell-smbios-objs			:= dell-smbios-base.o
+dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
+dell-smbios-$(CONFIG_DELL_SMBIOS_SMM)	+= dell-smbios-smm.o
+obj-$(CONFIG_DELL_SMO8800)		+= dell-smo8800.o
+obj-$(CONFIG_DELL_WMI)			+= dell-wmi.o
+obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
+obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
+obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
+obj-$(CONFIG_DELL_WMI_SYSMAN)		+= dell-wmi-sysman/
diff --git a/drivers/platform/x86/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
similarity index 100%
rename from drivers/platform/x86/alienware-wmi.c
rename to drivers/platform/x86/dell/alienware-wmi.c
diff --git a/drivers/platform/x86/dcdbas.c b/drivers/platform/x86/dell/dcdbas.c
similarity index 100%
rename from drivers/platform/x86/dcdbas.c
rename to drivers/platform/x86/dell/dcdbas.c
diff --git a/drivers/platform/x86/dcdbas.h b/drivers/platform/x86/dell/dcdbas.h
similarity index 100%
rename from drivers/platform/x86/dcdbas.h
rename to drivers/platform/x86/dell/dcdbas.h
diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
similarity index 100%
rename from drivers/platform/x86/dell-laptop.c
rename to drivers/platform/x86/dell/dell-laptop.c
diff --git a/drivers/platform/x86/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
similarity index 100%
rename from drivers/platform/x86/dell-rbtn.c
rename to drivers/platform/x86/dell/dell-rbtn.c
diff --git a/drivers/platform/x86/dell-rbtn.h b/drivers/platform/x86/dell/dell-rbtn.h
similarity index 100%
rename from drivers/platform/x86/dell-rbtn.h
rename to drivers/platform/x86/dell/dell-rbtn.h
diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
similarity index 100%
rename from drivers/platform/x86/dell-smbios-base.c
rename to drivers/platform/x86/dell/dell-smbios-base.c
diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell/dell-smbios-smm.c
similarity index 100%
rename from drivers/platform/x86/dell-smbios-smm.c
rename to drivers/platform/x86/dell/dell-smbios-smm.c
diff --git a/drivers/platform/x86/dell-smbios-wmi.c b/drivers/platform/x86/dell/dell-smbios-wmi.c
similarity index 100%
rename from drivers/platform/x86/dell-smbios-wmi.c
rename to drivers/platform/x86/dell/dell-smbios-wmi.c
diff --git a/drivers/platform/x86/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
similarity index 100%
rename from drivers/platform/x86/dell-smbios.h
rename to drivers/platform/x86/dell/dell-smbios.h
diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
similarity index 100%
rename from drivers/platform/x86/dell-smo8800.c
rename to drivers/platform/x86/dell/dell-smo8800.c
diff --git a/drivers/platform/x86/dell-wmi-aio.c b/drivers/platform/x86/dell/dell-wmi-aio.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-aio.c
rename to drivers/platform/x86/dell/dell-wmi-aio.c
diff --git a/drivers/platform/x86/dell-wmi-descriptor.c b/drivers/platform/x86/dell/dell-wmi-descriptor.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-descriptor.c
rename to drivers/platform/x86/dell/dell-wmi-descriptor.c
diff --git a/drivers/platform/x86/dell-wmi-descriptor.h b/drivers/platform/x86/dell/dell-wmi-descriptor.h
similarity index 100%
rename from drivers/platform/x86/dell-wmi-descriptor.h
rename to drivers/platform/x86/dell/dell-wmi-descriptor.h
diff --git a/drivers/platform/x86/dell-wmi-led.c b/drivers/platform/x86/dell/dell-wmi-led.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-led.c
rename to drivers/platform/x86/dell/dell-wmi-led.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/Makefile b/drivers/platform/x86/dell/dell-wmi-sysman/Makefile
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/Makefile
rename to drivers/platform/x86/dell/dell-wmi-sysman/Makefile
diff --git a/drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h b/drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
rename to drivers/platform/x86/dell/dell-wmi-sysman/dell-wmi-sysman.h
diff --git a/drivers/platform/x86/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/int-attributes.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/string-attributes.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
diff --git a/drivers/platform/x86/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi-sysman/sysman.c
rename to drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell/dell-wmi.c
similarity index 100%
rename from drivers/platform/x86/dell-wmi.c
rename to drivers/platform/x86/dell/dell-wmi.c
diff --git a/drivers/platform/x86/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
similarity index 100%
rename from drivers/platform/x86/dell_rbu.c
rename to drivers/platform/x86/dell/dell_rbu.c
-- 
2.25.1


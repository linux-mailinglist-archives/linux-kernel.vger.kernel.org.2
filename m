Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C5D3D43B8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhGWXb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 19:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhGWXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 19:30:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3B5C061764
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:11:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b128so1694081wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 17:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udzmKCyto34ZWKNhUlY/7an91eXsj5APQtqhjMQ5twk=;
        b=ogS6grBtTpM4bOr1l64UqpnihKsN/P1jRHkXbJs2f0FDh+C8dYuRrpuQoX0FEJRPg8
         rQOdg4yP/1AI+/MyDRb2SvaPh/yuEMd98h+WMKW57vWpasUoWYp/v8SmQm7OHiPZHrhk
         veOrHmvwITCq7lGwfJfWVDDCy9yNDJbP+B7zW6dXYDyeomY85N5rQYABxw4vxC6eFOB3
         xx0m288cen9LkshlWhqBSvyJjYGdm1dgawHfmm41oTFQkJsP/HAapy7c1JoC1YUaPTog
         dYRpIo+uTMHPqY9qEkIdCNabbjXYa4pXQzzBIZm0wJchB4eghIO6QgSffqgnQuSqEuI9
         k7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udzmKCyto34ZWKNhUlY/7an91eXsj5APQtqhjMQ5twk=;
        b=lxIvYBtnb6mLwzHgX8X3zBPc9Rw5UlEIx9UXI4zxwNVnZWsnb2xEaZ5LD+jpULTRgs
         rzJSElSwm8OGiBHv3A6GwieqgMZkqy7VuLjaeG3woxy+LF2FpvUoTxNnaBNjSRzqVcoy
         dQvAXQc+IBnCEjHJvN85eyHu1qrvuVgxEW6VnQM3dRiq6WJfS2RR8EmFJCfzNaP6TtDC
         NwSPY8jB0r1PgsB+NxbimuC03rcDCFEQ0nb5bCYvIqJsWM//mkFoLhVnVVd/wVHgg/rr
         IZAkIGGoKs2Qfkx5dIBaAONL+tfNmBZkG6GOAUWWXjtZRkvlKulTUquMnf/yrxbucI5S
         VX0A==
X-Gm-Message-State: AOAM532l06od7CaEIsGrO0FHQHp/kYCfvE8Id/9sMKMqc8SBkZroEjS6
        EjKorvA4rUHvxzGOMFj63G8r6A==
X-Google-Smtp-Source: ABdhPJx95oWCMfpA5QUuPBSXDir33y1ntM4ebhdAVgo76M9P0llY5xogWJT6TIPp/TnP5sI8BcxkCw==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr6616491wma.126.1627085472113;
        Fri, 23 Jul 2021 17:11:12 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id k24sm35491305wrh.30.2021.07.23.17.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 17:11:11 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com
Subject: [PATCH v3 6/7] staging: r8188eu: introduce new supporting files for RTL8188eu driver
Date:   Sat, 24 Jul 2021 01:10:54 +0100
Message-Id: <20210724001055.1613840-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210724001055.1613840-1-phil@philpotter.co.uk>
References: <20210724001055.1613840-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is split in order to keep the file sizes down. These
supporting files are part of the newer/better driver from GitHub modified by
Larry Finger. Import this as the basis for all future work going
forward. Also, modify Makefile so that driver has same module filename
as original rtl8188eu driver from staging, and rename config params to
fit the Kconfig file taken from the old driver.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/Kconfig  |  23 ++++++
 drivers/staging/r8188eu/Makefile | 129 +++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 drivers/staging/r8188eu/Kconfig
 create mode 100644 drivers/staging/r8188eu/Makefile

diff --git a/drivers/staging/r8188eu/Kconfig b/drivers/staging/r8188eu/Kconfig
new file mode 100644
index 000000000000..7ebbe43a7fbf
--- /dev/null
+++ b/drivers/staging/r8188eu/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+config R8188EU
+	tristate "Realtek RTL8188EU Wireless LAN NIC driver"
+	depends on WLAN && USB && CFG80211
+	select WIRELESS_EXT
+	select WEXT_PRIV
+	select LIB80211
+	select LIB80211_CRYPT_WEP
+	select LIB80211_CRYPT_CCMP
+	help
+	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
+	If built as a module, it will be called r8188eu.
+
+if R8188EU
+
+config 88EU_AP_MODE
+	bool "Realtek RTL8188EU AP mode"
+	help
+	This option enables Access Point mode. Unless you know that your system
+	will never be used as an AP, or the target system has limited memory,
+	"Y" should be selected.
+
+endif
diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
new file mode 100644
index 000000000000..6db1376e9768
--- /dev/null
+++ b/drivers/staging/r8188eu/Makefile
@@ -0,0 +1,129 @@
+SHELL := /bin/bash
+EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
+EXTRA_CFLAGS += -O1
+
+EXTRA_CFLAGS += -Wno-unused-variable
+EXTRA_CFLAGS += -Wno-unused-value
+EXTRA_CFLAGS += -Wno-unused-label
+EXTRA_CFLAGS += -Wno-unused-parameter
+EXTRA_CFLAGS += -Wno-unused-function
+EXTRA_CFLAGS += -Wno-unused
+
+EXTRA_CFLAGS += -Wno-uninitialized
+
+EXTRA_CFLAGS += -I$(src)/include
+
+ccflags-y += -D__CHECK_ENDIAN__
+
+CONFIG_AUTOCFG_CP = n
+
+CONFIG_R8188EU = m
+
+CONFIG_USB_HCI = y
+
+CONFIG_BT_COEXIST = n
+CONFIG_WOWLAN = n
+
+OUTSRC_FILES :=				\
+		hal/HalHWImg8188E_MAC.o	\
+		hal/HalHWImg8188E_BB.o	\
+		hal/HalHWImg8188E_RF.o	\
+		hal/HalPhyRf.o		\
+		hal/HalPhyRf_8188e.o	\
+		hal/HalPwrSeqCmd.o	\
+		hal/Hal8188EPwrSeq.o	\
+		hal/Hal8188ERateAdaptive.o\
+		hal/hal_intf.o		\
+		hal/hal_com.o		\
+		hal/odm.o		\
+		hal/odm_debug.o		\
+		hal/odm_interface.o	\
+		hal/odm_HWConfig.o	\
+		hal/odm_RegConfig8188E.o\
+		hal/odm_RTL8188E.o	\
+		hal/rtl8188e_cmd.o	\
+		hal/rtl8188e_dm.o	\
+		hal/rtl8188e_hal_init.o	\
+		hal/rtl8188e_mp.o	\
+		hal/rtl8188e_phycfg.o	\
+		hal/rtl8188e_rf6052.o	\
+		hal/rtl8188e_rxdesc.o	\
+		hal/rtl8188e_sreset.o	\
+		hal/rtl8188e_xmit.o	\
+		hal/rtl8188eu_led.o	\
+		hal/rtl8188eu_recv.o	\
+		hal/rtl8188eu_xmit.o	\
+		hal/usb_halinit.o	\
+		hal/usb_ops_linux.o
+
+RTL871X = rtl8188e
+
+HCI_NAME = usb
+
+_OS_INTFS_FILES :=				\
+			os_dep/ioctl_linux.o	\
+			os_dep/mlme_linux.o	\
+			os_dep/os_intfs.o	\
+			os_dep/osdep_service.o	\
+			os_dep/recv_linux.o	\
+			os_dep/rtw_android.o	\
+			os_dep/usb_intf.o	\
+			os_dep/usb_ops_linux.o	\
+			os_dep/xmit_linux.o
+
+_HAL_INTFS_FILES += $(OUTSRC_FILES)
+
+ifeq ($(CONFIG_AUTOCFG_CP), y)
+
+$(shell cp $(TopDIR)/autoconf_rtl8188e_usb_linux.h $(TopDIR)/include/autoconf.h)
+endif
+
+ifeq ($(CONFIG_BT_COEXIST), y)
+EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
+endif
+
+ifeq ($(CONFIG_WOWLAN), y)
+EXTRA_CFLAGS += -DCONFIG_WOWLAN
+endif
+
+SUBARCH := $(shell uname -m | sed -e "s/i.86/i386/; s/ppc.*/powerpc/; s/armv.l/arm/; s/aarch64/arm64/;")
+
+ARCH ?= $(SUBARCH)
+CROSS_COMPILE ?=
+KVER  ?= $(if $(KERNELRELEASE),$(KERNELRELEASE),$(shell uname -r))
+KSRC ?= $(if $(KERNEL_SRC),$(KERNEL_SRC),/lib/modules/$(KVER)/build)
+MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless
+INSTALL_PREFIX :=
+
+rtk_core :=				\
+		core/rtw_ap.o		\
+		core/rtw_br_ext.o	\
+		core/rtw_cmd.o		\
+		core/rtw_debug.o	\
+		core/rtw_efuse.o	\
+		core/rtw_ieee80211.o	\
+		core/rtw_io.o		\
+		core/rtw_ioctl_set.o	\
+		core/rtw_iol.o		\
+		core/rtw_led.o		\
+		core/rtw_mlme.o		\
+		core/rtw_mlme_ext.o	\
+		core/rtw_mp.o		\
+		core/rtw_mp_ioctl.o	\
+		core/rtw_pwrctrl.o	\
+		core/rtw_p2p.o		\
+		core/rtw_recv.o		\
+		core/rtw_rf.o		\
+		core/rtw_security.o	\
+		core/rtw_sreset.o	\
+		core/rtw_sta_mgt.o	\
+		core/rtw_wlan_util.o	\
+		core/rtw_xmit.o
+
+r8188eu-y += $(rtk_core)
+
+r8188eu-y += $(_HAL_INTFS_FILES)
+
+r8188eu-y += $(_OS_INTFS_FILES)
+
+obj-$(CONFIG_R8188EU) := r8188eu.o
-- 
2.31.1


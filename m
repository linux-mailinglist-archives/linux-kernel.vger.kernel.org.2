Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC04303FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244479AbhJPRix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbhJPRiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 13:38:23 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73E5C061768
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 10:36:11 -0700 (PDT)
Received: from ipservice-092-217-067-147.092.217.pools.vodafone-ip.de ([92.217.67.147] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mbnbL-0006dq-Dz; Sat, 16 Oct 2021 19:36:07 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/3] staging: r8188eu: Makefile: use one file list
Date:   Sat, 16 Oct 2021 19:35:44 +0200
Message-Id: <20211016173544.25376-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211016173544.25376-1-martin@kaiser.cx>
References: <20211016173544.25376-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's enough to have a single list of source files. There are no config
settings for this driver that change the list of source files that
we compile.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/Makefile | 122 ++++++++++++++-----------------
 1 file changed, 55 insertions(+), 67 deletions(-)

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index 8294fb69ecf9..a0a8e150da3f 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -1,71 +1,59 @@
 
-OUTSRC_FILES :=				\
-		hal/HalHWImg8188E_MAC.o	\
-		hal/HalHWImg8188E_BB.o	\
-		hal/HalHWImg8188E_RF.o	\
-		hal/HalPhyRf_8188e.o	\
-		hal/HalPwrSeqCmd.o	\
-		hal/Hal8188EPwrSeq.o	\
-		hal/Hal8188ERateAdaptive.o\
-		hal/hal_intf.o		\
-		hal/hal_com.o		\
-		hal/odm.o		\
-		hal/odm_debug.o		\
-		hal/odm_interface.o	\
-		hal/odm_HWConfig.o	\
-		hal/odm_RegConfig8188E.o\
-		hal/odm_RTL8188E.o	\
-		hal/rtl8188e_cmd.o	\
-		hal/rtl8188e_dm.o	\
-		hal/rtl8188e_hal_init.o	\
-		hal/rtl8188e_phycfg.o	\
-		hal/rtl8188e_rf6052.o	\
-		hal/rtl8188e_rxdesc.o	\
-		hal/rtl8188e_sreset.o	\
-		hal/rtl8188e_xmit.o	\
-		hal/rtl8188eu_led.o	\
-		hal/rtl8188eu_recv.o	\
-		hal/rtl8188eu_xmit.o	\
-		hal/usb_halinit.o	\
-		hal/usb_ops_linux.o
-
-_OS_INTFS_FILES :=				\
-			os_dep/ioctl_linux.o	\
-			os_dep/mlme_linux.o	\
-			os_dep/os_intfs.o	\
-			os_dep/osdep_service.o	\
-			os_dep/recv_linux.o	\
-			os_dep/usb_intf.o	\
-			os_dep/usb_ops_linux.o	\
-			os_dep/xmit_linux.o
-
-_HAL_INTFS_FILES += $(OUTSRC_FILES)
-
-rtk_core :=				\
-		core/rtw_ap.o		\
-		core/rtw_br_ext.o	\
-		core/rtw_cmd.o		\
-		core/rtw_efuse.o	\
-		core/rtw_ieee80211.o	\
-		core/rtw_ioctl_set.o	\
-		core/rtw_iol.o		\
-		core/rtw_led.o		\
-		core/rtw_mlme.o		\
-		core/rtw_mlme_ext.o	\
-		core/rtw_pwrctrl.o	\
-		core/rtw_p2p.o		\
-		core/rtw_recv.o		\
-		core/rtw_rf.o		\
-		core/rtw_security.o	\
-		core/rtw_sreset.o	\
-		core/rtw_sta_mgt.o	\
-		core/rtw_wlan_util.o	\
+r8188eu-y = \
+		hal/HalHWImg8188E_MAC.o \
+		hal/HalHWImg8188E_BB.o \
+		hal/HalHWImg8188E_RF.o \
+		hal/HalPhyRf_8188e.o \
+		hal/HalPwrSeqCmd.o \
+		hal/Hal8188EPwrSeq.o \
+		hal/Hal8188ERateAdaptive.o \
+		hal/hal_intf.o \
+		hal/hal_com.o \
+		hal/odm.o \
+		hal/odm_debug.o \
+		hal/odm_interface.o \
+		hal/odm_HWConfig.o \
+		hal/odm_RegConfig8188E.o \
+		hal/odm_RTL8188E.o \
+		hal/rtl8188e_cmd.o \
+		hal/rtl8188e_dm.o \
+		hal/rtl8188e_hal_init.o \
+		hal/rtl8188e_phycfg.o \
+		hal/rtl8188e_rf6052.o \
+		hal/rtl8188e_rxdesc.o \
+		hal/rtl8188e_sreset.o \
+		hal/rtl8188e_xmit.o \
+		hal/rtl8188eu_led.o \
+		hal/rtl8188eu_recv.o \
+		hal/rtl8188eu_xmit.o \
+		hal/usb_halinit.o \
+		hal/usb_ops_linux.o \
+		os_dep/ioctl_linux.o \
+		os_dep/mlme_linux.o \
+		os_dep/os_intfs.o \
+		os_dep/osdep_service.o \
+		os_dep/recv_linux.o \
+		os_dep/usb_intf.o \
+		os_dep/usb_ops_linux.o \
+		os_dep/xmit_linux.o \
+		core/rtw_ap.o \
+		core/rtw_br_ext.o \
+		core/rtw_cmd.o \
+		core/rtw_efuse.o \
+		core/rtw_ieee80211.o \
+		core/rtw_ioctl_set.o \
+		core/rtw_iol.o \
+		core/rtw_led.o \
+		core/rtw_mlme.o \
+		core/rtw_mlme_ext.o \
+		core/rtw_pwrctrl.o \
+		core/rtw_p2p.o \
+		core/rtw_recv.o \
+		core/rtw_rf.o \
+		core/rtw_security.o \
+		core/rtw_sreset.o \
+		core/rtw_sta_mgt.o \
+		core/rtw_wlan_util.o \
 		core/rtw_xmit.o
 
-r8188eu-y += $(rtk_core)
-
-r8188eu-y += $(_HAL_INTFS_FILES)
-
-r8188eu-y += $(_OS_INTFS_FILES)
-
 obj-$(CONFIG_R8188EU) := r8188eu.o
-- 
2.20.1


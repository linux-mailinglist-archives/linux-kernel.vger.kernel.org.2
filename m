Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35AE3D83E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhG0XW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhG0XWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:22:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B658C061764
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:22:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n11so218929wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rVGbtsohxnsZLSkCC+NtVhS0W/mBjpM2J3ktcwUxAw=;
        b=Ue4sxCL4KcuOxcFzeMqRFXQ412csI/t2PK/pdXKiL4bovCdivEdJxRqnHNllWOQRoK
         AI4laZipf8AvpyW0aEUwUJ4UdcAsU8AXdxQ7bnREbtWbKqMlxT3GBbIzzuYrYmIphwcj
         50fSJDoqYGS5gRN8Ue6DhidYnCRfh0C4Q53CdJn6wV8s7/OlakBP5Lv45IOhqPcpq6mg
         G41xgYjpTCDO5iTXNBZcBoanU82tlS3rFuJSNEwTazRtfpzxG7hXQIznX9a3th+rB7Bn
         Uv64tuXc2DOxFenmEkvFLkhHdwi16RgDPMWwgVEjVmQCvgmuJiWorqcKLDJD1OVfm+oH
         jqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rVGbtsohxnsZLSkCC+NtVhS0W/mBjpM2J3ktcwUxAw=;
        b=rQTcs2kwyXXmy1m0lMECDYyXLlrSF/EciQHVN/nQLt/5XjhDkElKowTuds9iDj5NqF
         N6mpyalERV2P26fS1gPJmekpIR0fLPor6/3edGMV/WbOrHoNVUZh811CCJgK7K8+Icv1
         VpwDiz1Kc9faDxj/YpNrcZqpOMKs/RuOgphlCu1NpI1p7YSfA0K23wD3sTE6IsCszAq8
         bS9B5C1Ton5BIRKW+UzFs6s33CRwu2GGn06nDNwQNr6T+WwgeiUK8i21t96z/HEPTBae
         p2qVGpQnX3KBc12uRpFJtJMHeT09XJpPzU/zzgnADPdOaOxDozaeImfQOptNIpHKl7K7
         9+Tw==
X-Gm-Message-State: AOAM533lHczEDKIEHI5OZAsW3XV0r+6kmxTj0E0i8dPU39XDJPjFq8vN
        8U6yME/f63/pAT77oOUCvJDihg==
X-Google-Smtp-Source: ABdhPJy+1NsDBZ6pKfRJ8vK8lirGgrLuywqxv6kogB/GIbb9RXdphDYYLqfKgFY+Rxsj6ojPTugf6A==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr24803279wmq.9.1627428151967;
        Tue, 27 Jul 2021 16:22:31 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m7sm3848367wmq.20.2021.07.27.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:22:30 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com, martin@kaiser.cx
Subject: [PATCH v4 4/6] staging: r8188eu: introduce new include dir for RTL8188eu driver
Date:   Wed, 28 Jul 2021 00:22:17 +0100
Message-Id: <20210727232219.2948-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210727232219.2948-1-phil@philpotter.co.uk>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is split in order to keep the file sizes down. This
include directory is part of the newer/better driver from GitHub
modified by Larry Finger. Import this as the basis for all future
work going forward.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  269 +++
 .../staging/r8188eu/include/Hal8188EPhyReg.h  | 1088 +++++++++++++
 .../staging/r8188eu/include/Hal8188EPwrSeq.h  |  173 ++
 .../r8188eu/include/Hal8188ERateAdaptive.h    |   75 +
 drivers/staging/r8188eu/include/Hal8188EReg.h |   44 +
 .../r8188eu/include/HalHWImg8188E_BB.h        |   44 +
 .../r8188eu/include/HalHWImg8188E_FW.h        |   33 +
 .../r8188eu/include/HalHWImg8188E_MAC.h       |   30 +
 .../r8188eu/include/HalHWImg8188E_RF.h        |   30 +
 drivers/staging/r8188eu/include/HalPhyRf.h    |   30 +
 .../staging/r8188eu/include/HalPhyRf_8188e.h  |   58 +
 .../staging/r8188eu/include/HalPwrSeqCmd.h    |  126 ++
 drivers/staging/r8188eu/include/HalVerDef.h   |  166 ++
 drivers/staging/r8188eu/include/autoconf.h    |   43 +
 drivers/staging/r8188eu/include/basic_types.h |  184 +++
 drivers/staging/r8188eu/include/cmd_osdep.h   |   32 +
 drivers/staging/r8188eu/include/drv_types.h   |  346 ++++
 .../staging/r8188eu/include/drv_types_linux.h |   23 +
 drivers/staging/r8188eu/include/ethernet.h    |   41 +
 drivers/staging/r8188eu/include/h2clbk.h      |   32 +
 drivers/staging/r8188eu/include/hal_com.h     |  172 ++
 drivers/staging/r8188eu/include/hal_intf.h    |  430 +++++
 drivers/staging/r8188eu/include/ieee80211.h   | 1261 +++++++++++++++
 .../staging/r8188eu/include/ieee80211_ext.h   |  287 ++++
 drivers/staging/r8188eu/include/if_ether.h    |  111 ++
 .../staging/r8188eu/include/ioctl_cfg80211.h  |  107 ++
 drivers/staging/r8188eu/include/ip.h          |  125 ++
 drivers/staging/r8188eu/include/mlme_osdep.h  |   35 +
 .../staging/r8188eu/include/mp_custom_oid.h   |  349 ++++
 drivers/staging/r8188eu/include/nic_spec.h    |   41 +
 drivers/staging/r8188eu/include/odm.h         | 1182 ++++++++++++++
 .../staging/r8188eu/include/odm_HWConfig.h    |  133 ++
 .../staging/r8188eu/include/odm_RTL8188E.h    |   56 +
 .../r8188eu/include/odm_RegConfig8188E.h      |   43 +
 .../r8188eu/include/odm_RegDefine11AC.h       |   46 +
 .../r8188eu/include/odm_RegDefine11N.h        |  160 ++
 drivers/staging/r8188eu/include/odm_debug.h   |  143 ++
 .../staging/r8188eu/include/odm_interface.h   |  164 ++
 drivers/staging/r8188eu/include/odm_precomp.h |  103 ++
 drivers/staging/r8188eu/include/odm_reg.h     |  116 ++
 drivers/staging/r8188eu/include/odm_types.h   |   61 +
 drivers/staging/r8188eu/include/osdep_intf.h  |   83 +
 .../staging/r8188eu/include/osdep_service.h   |  489 ++++++
 drivers/staging/r8188eu/include/recv_osdep.h  |   54 +
 .../staging/r8188eu/include/rtl8188e_cmd.h    |  122 ++
 drivers/staging/r8188eu/include/rtl8188e_dm.h |   62 +
 .../staging/r8188eu/include/rtl8188e_hal.h    |  471 ++++++
 .../staging/r8188eu/include/rtl8188e_led.h    |   34 +
 .../staging/r8188eu/include/rtl8188e_recv.h   |   69 +
 drivers/staging/r8188eu/include/rtl8188e_rf.h |   35 +
 .../staging/r8188eu/include/rtl8188e_spec.h   | 1438 +++++++++++++++++
 .../staging/r8188eu/include/rtl8188e_sreset.h |   31 +
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  177 ++
 drivers/staging/r8188eu/include/rtw_android.h |   64 +
 drivers/staging/r8188eu/include/rtw_ap.h      |   67 +
 drivers/staging/r8188eu/include/rtw_br_ext.h  |   66 +
 drivers/staging/r8188eu/include/rtw_cmd.h     |  991 ++++++++++++
 drivers/staging/r8188eu/include/rtw_debug.h   |  274 ++++
 drivers/staging/r8188eu/include/rtw_eeprom.h  |  130 ++
 drivers/staging/r8188eu/include/rtw_efuse.h   |  150 ++
 drivers/staging/r8188eu/include/rtw_event.h   |  113 ++
 drivers/staging/r8188eu/include/rtw_ht.h      |   44 +
 drivers/staging/r8188eu/include/rtw_io.h      |  387 +++++
 drivers/staging/r8188eu/include/rtw_ioctl.h   |  120 ++
 .../staging/r8188eu/include/rtw_ioctl_rtl.h   |   79 +
 .../staging/r8188eu/include/rtw_ioctl_set.h   |   49 +
 drivers/staging/r8188eu/include/rtw_iol.h     |   84 +
 drivers/staging/r8188eu/include/rtw_led.h     |  201 +++
 drivers/staging/r8188eu/include/rtw_mlme.h    |  649 ++++++++
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  874 ++++++++++
 drivers/staging/r8188eu/include/rtw_mp.h      |  492 ++++++
 .../staging/r8188eu/include/rtw_mp_ioctl.h    |  339 ++++
 .../r8188eu/include/rtw_mp_phy_regdef.h       | 1079 +++++++++++++
 drivers/staging/r8188eu/include/rtw_p2p.h     |  135 ++
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  282 ++++
 drivers/staging/r8188eu/include/rtw_qos.h     |   30 +
 drivers/staging/r8188eu/include/rtw_recv.h    |  473 ++++++
 drivers/staging/r8188eu/include/rtw_rf.h      |  145 ++
 .../staging/r8188eu/include/rtw_security.h    |  382 +++++
 drivers/staging/r8188eu/include/rtw_sreset.h  |   50 +
 drivers/staging/r8188eu/include/rtw_version.h |    1 +
 drivers/staging/r8188eu/include/rtw_xmit.h    |  383 +++++
 drivers/staging/r8188eu/include/sta_info.h    |  384 +++++
 drivers/staging/r8188eu/include/usb_hal.h     |   26 +
 drivers/staging/r8188eu/include/usb_ops.h     |  115 ++
 .../staging/r8188eu/include/usb_ops_linux.h   |   55 +
 drivers/staging/r8188eu/include/usb_osintf.h  |   45 +
 .../staging/r8188eu/include/usb_vendor_req.h  |   51 +
 drivers/staging/r8188eu/include/wifi.h        | 1105 +++++++++++++
 drivers/staging/r8188eu/include/wlan_bssdef.h |  343 ++++
 drivers/staging/r8188eu/include/xmit_osdep.h  |   67 +
 91 files changed, 21381 insertions(+)
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPhyReg.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
 create mode 100644 drivers/staging/r8188eu/include/Hal8188EReg.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
 create mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
 create mode 100644 drivers/staging/r8188eu/include/HalPhyRf.h
 create mode 100644 drivers/staging/r8188eu/include/HalPhyRf_8188e.h
 create mode 100644 drivers/staging/r8188eu/include/HalPwrSeqCmd.h
 create mode 100644 drivers/staging/r8188eu/include/HalVerDef.h
 create mode 100644 drivers/staging/r8188eu/include/autoconf.h
 create mode 100644 drivers/staging/r8188eu/include/basic_types.h
 create mode 100644 drivers/staging/r8188eu/include/cmd_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/drv_types.h
 create mode 100644 drivers/staging/r8188eu/include/drv_types_linux.h
 create mode 100644 drivers/staging/r8188eu/include/ethernet.h
 create mode 100644 drivers/staging/r8188eu/include/h2clbk.h
 create mode 100644 drivers/staging/r8188eu/include/hal_com.h
 create mode 100644 drivers/staging/r8188eu/include/hal_intf.h
 create mode 100644 drivers/staging/r8188eu/include/ieee80211.h
 create mode 100644 drivers/staging/r8188eu/include/ieee80211_ext.h
 create mode 100644 drivers/staging/r8188eu/include/if_ether.h
 create mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h
 create mode 100644 drivers/staging/r8188eu/include/ip.h
 create mode 100644 drivers/staging/r8188eu/include/mlme_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/mp_custom_oid.h
 create mode 100644 drivers/staging/r8188eu/include/nic_spec.h
 create mode 100644 drivers/staging/r8188eu/include/odm.h
 create mode 100644 drivers/staging/r8188eu/include/odm_HWConfig.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RTL8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h
 create mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11N.h
 create mode 100644 drivers/staging/r8188eu/include/odm_debug.h
 create mode 100644 drivers/staging/r8188eu/include/odm_interface.h
 create mode 100644 drivers/staging/r8188eu/include/odm_precomp.h
 create mode 100644 drivers/staging/r8188eu/include/odm_reg.h
 create mode 100644 drivers/staging/r8188eu/include/odm_types.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_intf.h
 create mode 100644 drivers/staging/r8188eu/include/osdep_service.h
 create mode 100644 drivers/staging/r8188eu/include/recv_osdep.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_cmd.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_dm.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_hal.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_recv.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_rf.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_spec.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_sreset.h
 create mode 100644 drivers/staging/r8188eu/include/rtl8188e_xmit.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_android.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ap.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_br_ext.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_cmd.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_debug.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_eeprom.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_efuse.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_event.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ht.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_io.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_set.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_iol.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_led.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mlme.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mlme_ext.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_ioctl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_p2p.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_pwrctrl.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_qos.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_recv.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_rf.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_security.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_sreset.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_version.h
 create mode 100644 drivers/staging/r8188eu/include/rtw_xmit.h
 create mode 100644 drivers/staging/r8188eu/include/sta_info.h
 create mode 100644 drivers/staging/r8188eu/include/usb_hal.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops.h
 create mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h
 create mode 100644 drivers/staging/r8188eu/include/usb_osintf.h
 create mode 100644 drivers/staging/r8188eu/include/usb_vendor_req.h
 create mode 100644 drivers/staging/r8188eu/include/wifi.h
 create mode 100644 drivers/staging/r8188eu/include/wlan_bssdef.h
 create mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
new file mode 100644
index 000000000000..6fb059576a67
--- /dev/null
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -0,0 +1,269 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __INC_HAL8188EPHYCFG_H__
+#define __INC_HAL8188EPHYCFG_H__
+
+/*--------------------------Define Parameters-------------------------------*/
+#define LOOP_LIMIT			5
+#define MAX_STALL_TIME			50		/* us */
+#define AntennaDiversityValue		0x80
+#define MAX_TXPWR_IDX_NMODE_92S		63
+#define Reset_Cnt_Limit			3
+
+#define IQK_MAC_REG_NUM			4
+#define IQK_ADDA_REG_NUM		16
+#define IQK_BB_REG_NUM			9
+#define HP_THERMAL_NUM			8
+
+#define MAX_AGGR_NUM			0x07
+
+/*--------------------------Define Parameters-------------------------------*/
+
+/*------------------------------Define structure----------------------------*/
+enum sw_chnl_cmd_id {
+	CmdID_End,
+	CmdID_SetTxPowerLevel,
+	CmdID_BBRegWrite10,
+	CmdID_WritePortUlong,
+	CmdID_WritePortUshort,
+	CmdID_WritePortUchar,
+	CmdID_RF_WriteReg,
+};
+
+/* 1. Switch channel related */
+struct sw_chnl_cmd {
+	enum sw_chnl_cmd_id CmdID;
+	u32 Para1;
+	u32 Para2;
+	u32 msDelay;
+};
+
+enum hw90_block {
+	HW90_BLOCK_MAC = 0,
+	HW90_BLOCK_PHY0 = 1,
+	HW90_BLOCK_PHY1 = 2,
+	HW90_BLOCK_RF = 3,
+	HW90_BLOCK_MAXIMUM = 4, /*  Never use this */
+};
+
+enum rf_radio_path {
+	RF_PATH_A = 0,			/* Radio Path A */
+	RF_PATH_B = 1,			/* Radio Path B */
+	RF_PATH_C = 2,			/* Radio Path C */
+	RF_PATH_D = 3,			/* Radio Path D */
+};
+
+#define MAX_PG_GROUP 13
+
+#define	RF_PATH_MAX			3
+#define		MAX_TX_COUNT		4 /* path numbers */
+
+#define CHANNEL_MAX_NUMBER		14	/*  14 is the max chnl number */
+#define MAX_CHNL_GROUP_24G		6	/*  ch1~2, ch3~5, ch6~8,
+						 *ch9~11, ch12~13, CH 14
+						 * total three groups */
+#define CHANNEL_GROUP_MAX_88E		6
+
+enum wireless_mode {
+	WIRELESS_MODE_UNKNOWN = 0x00,
+	WIRELESS_MODE_A			= BIT2,
+	WIRELESS_MODE_B			= BIT0,
+	WIRELESS_MODE_G			= BIT1,
+	WIRELESS_MODE_AUTO		= BIT5,
+	WIRELESS_MODE_N_24G		= BIT3,
+	WIRELESS_MODE_N_5G		= BIT4,
+	WIRELESS_MODE_AC		= BIT6
+};
+
+enum phy_rate_tx_offset_area {
+	RA_OFFSET_LEGACY_OFDM1,
+	RA_OFFSET_LEGACY_OFDM2,
+	RA_OFFSET_HT_OFDM1,
+	RA_OFFSET_HT_OFDM2,
+	RA_OFFSET_HT_OFDM3,
+	RA_OFFSET_HT_OFDM4,
+	RA_OFFSET_HT_CCK,
+};
+
+/* BB/RF related */
+enum RF_TYPE_8190P {
+	RF_TYPE_MIN,		/*  0 */
+	RF_8225 = 1,		/*  1 11b/g RF for verification only */
+	RF_8256 = 2,		/*  2 11b/g/n */
+	RF_8258 = 3,		/*  3 11a/b/g/n RF */
+	RF_6052 = 4,		/*  4 11b/g/n RF */
+	/*  TODO: We should remove this psudo PHY RF after we get new RF. */
+	RF_PSEUDO_11N = 5,	/*  5, It is a temporality RF. */
+};
+
+struct bb_reg_def {
+	u32 rfintfs;		/*  set software control: */
+				/*	0x870~0x877[8 bytes] */
+	u32 rfintfi;		/*  readback data: */
+				/*	0x8e0~0x8e7[8 bytes] */
+	u32 rfintfo;		/*  output data: */
+				/*	0x860~0x86f [16 bytes] */
+	u32 rfintfe;		/*  output enable: */
+				/*	0x860~0x86f [16 bytes] */
+	u32 rf3wireOffset;	/*  LSSI data: */
+				/*	0x840~0x84f [16 bytes] */
+	u32 rfLSSI_Select;	/*  BB Band Select: */
+				/*	0x878~0x87f [8 bytes] */
+	u32 rfTxGainStage;	/*  Tx gain stage: */
+				/*	0x80c~0x80f [4 bytes] */
+	u32 rfHSSIPara1;	/*  wire parameter control1 : */
+				/*	0x820~0x823,0x828~0x82b,
+				 *	0x830~0x833, 0x838~0x83b [16 bytes] */
+	u32 rfHSSIPara2;	/*  wire parameter control2 : */
+				/*	0x824~0x827,0x82c~0x82f, 0x834~0x837,
+				 *	0x83c~0x83f [16 bytes] */
+	u32 rfSwitchControl;	/* Tx Rx antenna control : */
+				/*	0x858~0x85f [16 bytes] */
+	u32 rfAGCControl1;	/* AGC parameter control1 : */
+				/*	0xc50~0xc53,0xc58~0xc5b, 0xc60~0xc63,
+				 * 0xc68~0xc6b [16 bytes] */
+	u32 rfAGCControl2;	/* AGC parameter control2 : */
+				/*	0xc54~0xc57,0xc5c~0xc5f, 0xc64~0xc67,
+				 *	0xc6c~0xc6f [16 bytes] */
+	u32 rfRxIQImbalance;	/* OFDM Rx IQ imbalance matrix : */
+				/*	0xc14~0xc17,0xc1c~0xc1f, 0xc24~0xc27,
+				 *	0xc2c~0xc2f [16 bytes] */
+	u32 rfRxAFE;		/* Rx IQ DC ofset and Rx digital filter,
+				 * Rx DC notch filter : */
+				/*	0xc10~0xc13,0xc18~0xc1b, 0xc20~0xc23,
+				 *	0xc28~0xc2b [16 bytes] */
+	u32 rfTxIQImbalance;	/* OFDM Tx IQ imbalance matrix */
+				/*	0xc80~0xc83,0xc88~0xc8b, 0xc90~0xc93,
+				 *	 0xc98~0xc9b [16 bytes] */
+	u32 rfTxAFE;		/* Tx IQ DC Offset and Tx DFIR type */
+				/*	0xc84~0xc87,0xc8c~0xc8f, 0xc94~0xc97,
+				 *	0xc9c~0xc9f [16 bytes] */
+	u32 rfLSSIReadBack;	/* LSSI RF readback data SI mode */
+				/*	0x8a0~0x8af [16 bytes] */
+	u32 rfLSSIReadBackPi;	/* LSSI RF readback data PI mode 0x8b8-8bc for
+				 * Path A and B */
+};
+
+struct ant_sel_ofdm {
+	u32 r_tx_antenna:4;
+	u32 r_ant_l:4;
+	u32 r_ant_non_ht:4;
+	u32 r_ant_ht1:4;
+	u32 r_ant_ht2:4;
+	u32 r_ant_ht_s1:4;
+	u32 r_ant_non_ht_s1:4;
+	u32 OFDM_TXSC:2;
+	u32 reserved:2;
+};
+
+struct ant_sel_cck {
+	u8 r_cckrx_enable_2:2;
+	u8 r_cckrx_enable:2;
+	u8 r_ccktx_enable:4;
+};
+
+/*------------------------------Define structure----------------------------*/
+
+/*------------------------Export global variable----------------------------*/
+/*------------------------Export global variable----------------------------*/
+
+/*------------------------Export Marco Definition---------------------------*/
+/*------------------------Export Marco Definition---------------------------*/
+
+/*--------------------------Exported Function prototype---------------------*/
+/*  */
+/*  BB and RF register read/write */
+/*  */
+u32 rtl8188e_PHY_QueryBBReg(struct adapter *adapter, u32 regaddr, u32 mask);
+void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr,
+			   u32 mask, u32 data);
+u32 rtl8188e_PHY_QueryRFReg(struct adapter *adapter, enum rf_radio_path rfpath,
+			    u32 regaddr, u32 mask);
+void rtl8188e_PHY_SetRFReg(struct adapter *adapter, enum rf_radio_path rfpath,
+			   u32 regaddr, u32 mask, u32 data);
+
+/*  Initialization related function */
+/* MAC/BB/RF HAL config */
+int PHY_MACConfig8188E(struct adapter *adapter);
+int PHY_BBConfig8188E(struct adapter *adapter);
+int PHY_RFConfig8188E(struct adapter *adapter);
+
+/* RF config */
+int rtl8188e_PHY_ConfigRFWithParaFile(struct adapter *adapter, u8 *filename,
+				      enum rf_radio_path rfpath);
+int rtl8188e_PHY_ConfigRFWithHeaderFile(struct adapter *adapter,
+					enum rf_radio_path rfpath);
+
+/* Read initi reg value for tx power setting. */
+void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
+
+/*  BB TX Power R/W */
+void PHY_GetTxPowerLevel8188E(struct adapter *adapter, u32 *powerlevel);
+void PHY_SetTxPowerLevel8188E(struct adapter *adapter, u8 channel);
+bool PHY_UpdateTxPowerDbm8188E(struct adapter *adapter, int power);
+
+void PHY_ScanOperationBackup8188E(struct adapter *Adapter, u8 Operation);
+
+/*  Switch bandwidth for 8192S */
+void PHY_SetBWMode8188E(struct adapter *adapter,
+			enum ht_channel_width chnlwidth, unsigned char offset);
+
+/*  channel switch related funciton */
+void PHY_SwChnl8188E(struct adapter *adapter, u8 channel);
+/*  Call after initialization */
+void ChkFwCmdIoDone(struct adapter *adapter);
+
+/*  BB/MAC/RF other monitor API */
+void PHY_SetRFPathSwitch_8188E(struct adapter *adapter,	bool main);
+
+void PHY_SwitchEphyParameter(struct adapter *adapter);
+
+void PHY_EnableHostClkReq(struct adapter *adapter);
+
+bool SetAntennaConfig92C(struct adapter *adapter, u8 defaultant);
+
+void storePwrIndexDiffRateOffset(struct adapter *adapter, u32 regaddr,
+				 u32 mask, u32 data);
+/*--------------------------Exported Function prototype---------------------*/
+
+#define PHY_QueryBBReg(adapt, regaddr, mask)			\
+	 rtl8188e_PHY_QueryBBReg((adapt), (regaddr), (mask))
+#define PHY_SetBBReg(adapt, regaddr, bitmask, data)		\
+	 rtl8188e_PHY_SetBBReg((adapt), (regaddr), (bitmask), (data))
+#define PHY_QueryRFReg(adapt, rfpath, regaddr, bitmask)	\
+	rtl8188e_PHY_QueryRFReg((adapt), (rfpath), (regaddr), (bitmask))
+#define PHY_SetRFReg(adapt, rfpath, regaddr, bitmask, data)	\
+	rtl8188e_PHY_SetRFReg((adapt), (rfpath), (regaddr), (bitmask), (data))
+
+#define PHY_SetMacReg	PHY_SetBBReg
+
+#define	SIC_HW_SUPPORT			0
+
+#define	SIC_MAX_POLL_CNT		5
+
+#define	SIC_CMD_READY			0
+#define	SIC_CMD_WRITE			1
+#define	SIC_CMD_READ			2
+
+#define	SIC_CMD_REG			0x1EB		/*  1byte */
+#define	SIC_ADDR_REG			0x1E8		/*  1b9~1ba, 2 bytes */
+#define	SIC_DATA_REG			0x1EC		/*  1bc~1bf */
+
+#endif	/*  __INC_HAL8192CPHYCFG_H */
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyReg.h b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
new file mode 100644
index 000000000000..c324970171cd
--- /dev/null
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyReg.h
@@ -0,0 +1,1088 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __INC_HAL8188EPHYREG_H__
+#define __INC_HAL8188EPHYREG_H__
+/*--------------------------Define Parameters-------------------------------*/
+/*  */
+/*  BB-PHY register PMAC 0x100 PHY 0x800 - 0xEFF */
+/*  1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L-STF */
+/*  2. 0x800/0x900/0xA00/0xC00/0xD00/0xE00 */
+/*  3. RF register 0x00-2E */
+/*  4. Bit Mask for BB/RF register */
+/*  5. Other definition for BB/RF R/W */
+/*  */
+
+/*  */
+/*  1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L-STF */
+/*  1. Page1(0x100) */
+/*  */
+#define	rPMAC_Reset		0x100
+#define	rPMAC_TxStart		0x104
+#define	rPMAC_TxLegacySIG	0x108
+#define	rPMAC_TxHTSIG1		0x10c
+#define	rPMAC_TxHTSIG2		0x110
+#define	rPMAC_PHYDebug		0x114
+#define	rPMAC_TxPacketNum	0x118
+#define	rPMAC_TxIdle		0x11c
+#define	rPMAC_TxMACHeader0	0x120
+#define	rPMAC_TxMACHeader1	0x124
+#define	rPMAC_TxMACHeader2	0x128
+#define	rPMAC_TxMACHeader3	0x12c
+#define	rPMAC_TxMACHeader4	0x130
+#define	rPMAC_TxMACHeader5	0x134
+#define	rPMAC_TxDataType	0x138
+#define	rPMAC_TxRandomSeed	0x13c
+#define	rPMAC_CCKPLCPPreamble	0x140
+#define	rPMAC_CCKPLCPHeader	0x144
+#define	rPMAC_CCKCRC16		0x148
+#define	rPMAC_OFDMRxCRC32OK	0x170
+#define	rPMAC_OFDMRxCRC32Er	0x174
+#define	rPMAC_OFDMRxParityEr	0x178
+#define	rPMAC_OFDMRxCRC8Er	0x17c
+#define	rPMAC_CCKCRxRC16Er	0x180
+#define	rPMAC_CCKCRxRC32Er	0x184
+#define	rPMAC_CCKCRxRC32OK	0x188
+#define	rPMAC_TxStatus		0x18c
+
+/*  2. Page2(0x200) */
+/*  The following two definition are only used for USB interface. */
+#define	RF_BB_CMD_ADDR		0x02c0	/*  RF/BB r/w cmd address. */
+#define	RF_BB_CMD_DATA		0x02c4	/*  RF/BB r/w cmd data. */
+
+/*  3. Page8(0x800) */
+#define	rFPGA0_RFMOD		0x800	/* RF mode & CCK TxSC RF BW Setting */
+
+#define	rFPGA0_TxInfo		0x804	/*  Status report?? */
+#define	rFPGA0_PSDFunction	0x808
+
+#define	rFPGA0_TxGainStage	0x80c	/*  Set TX PWR init gain? */
+
+#define	rFPGA0_RFTiming1	0x810	/*  Useless now */
+#define	rFPGA0_RFTiming2	0x814
+
+#define	rFPGA0_XA_HSSIParameter1	0x820	/*  RF 3 wire register */
+#define	rFPGA0_XA_HSSIParameter2	0x824
+#define	rFPGA0_XB_HSSIParameter1	0x828
+#define	rFPGA0_XB_HSSIParameter2	0x82c
+
+#define	rFPGA0_XA_LSSIParameter		0x840
+#define	rFPGA0_XB_LSSIParameter		0x844
+
+#define	rFPGA0_RFWakeUpParameter	0x850	/*  Useless now */
+#define	rFPGA0_RFSleepUpParameter	0x854
+
+#define	rFPGA0_XAB_SwitchControl	0x858	/*  RF Channel switch */
+#define	rFPGA0_XCD_SwitchControl	0x85c
+
+#define	rFPGA0_XA_RFInterfaceOE		0x860	/*  RF Channel switch */
+#define	rFPGA0_XB_RFInterfaceOE		0x864
+
+#define	rFPGA0_XAB_RFInterfaceSW	0x870	/*  RF Iface Software Control */
+#define	rFPGA0_XCD_RFInterfaceSW	0x874
+
+#define	rFPGA0_XAB_RFParameter		0x878	/*  RF Parameter */
+#define	rFPGA0_XCD_RFParameter		0x87c
+
+/* Crystal cap setting RF-R/W protection for parameter4?? */
+#define	rFPGA0_AnalogParameter1		0x880
+#define	rFPGA0_AnalogParameter2		0x884
+#define	rFPGA0_AnalogParameter3		0x888
+/*  enable ad/da clock1 for dual-phy */
+#define	rFPGA0_AdDaClockEn		0x888
+#define	rFPGA0_AnalogParameter4		0x88c
+
+#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Tranceiver LSSI Readback */
+#define	rFPGA0_XB_LSSIReadBack		0x8a4
+#define	rFPGA0_XC_LSSIReadBack		0x8a8
+#define	rFPGA0_XD_LSSIReadBack		0x8ac
+
+#define	rFPGA0_PSDReport		0x8b4	/*  Useless now */
+/*  Transceiver A HSPI Readback */
+#define	TransceiverA_HSPI_Readback	0x8b8
+/*  Transceiver B HSPI Readback */
+#define	TransceiverB_HSPI_Readback	0x8bc
+/*  Useless now RF Interface Readback Value */
+#define	rFPGA0_XAB_RFInterfaceRB	0x8e0
+#define	rFPGA0_XCD_RFInterfaceRB	0x8e4	/*  Useless now */
+
+/*  4. Page9(0x900) */
+/* RF mode & OFDM TxSC RF BW Setting?? */
+#define	rFPGA1_RFMOD			0x900
+
+#define	rFPGA1_TxBlock			0x904	/*  Useless now */
+#define	rFPGA1_DebugSelect		0x908	/*  Useless now */
+#define	rFPGA1_TxInfo			0x90c	/*  Useless now Status report */
+
+/*  5. PageA(0xA00) */
+/*  Set Control channel to upper or lower - required only for 40MHz */
+#define	rCCK0_System			0xa00
+
+/*  Disable init gain now Select RX path by RSSI */
+#define	rCCK0_AFESetting		0xa04
+/*  Disable init gain now Init gain */
+#define	rCCK0_CCA			0xa08
+
+/* AGC default value, saturation level Antenna Diversity, RX AGC, LNA Threshold,
+ * RX LNA Threshold useless now. Not the same as 90 series */
+#define	rCCK0_RxAGC1			0xa0c
+#define	rCCK0_RxAGC2			0xa10	/* AGC & DAGC */
+
+#define	rCCK0_RxHP			0xa14
+
+/* Timing recovery & Channel estimation threshold */
+#define	rCCK0_DSPParameter1		0xa18
+#define	rCCK0_DSPParameter2		0xa1c	/* SQ threshold */
+
+#define	rCCK0_TxFilter1			0xa20
+#define	rCCK0_TxFilter2			0xa24
+#define	rCCK0_DebugPort			0xa28	/* debug port and Tx filter3 */
+#define	rCCK0_FalseAlarmReport		0xa2c	/* 0xa2d useless now */
+#define	rCCK0_TRSSIReport		0xa50
+#define	rCCK0_RxReport			0xa54  /* 0xa57 */
+#define	rCCK0_FACounterLower		0xa5c  /* 0xa5b */
+#define	rCCK0_FACounterUpper		0xa58  /* 0xa5c */
+
+/*  */
+/*  PageB(0xB00) */
+/*  */
+#define	rPdp_AntA			0xb00
+#define	rPdp_AntA_4			0xb04
+#define	rConfig_Pmpd_AntA		0xb28
+#define	rConfig_AntA			0xb68
+#define	rConfig_AntB			0xb6c
+#define	rPdp_AntB			0xb70
+#define	rPdp_AntB_4			0xb74
+#define	rConfig_Pmpd_AntB		0xb98
+#define	rAPK				0xbd8
+
+/*  */
+/*  6. PageC(0xC00) */
+/*  */
+#define	rOFDM0_LSTF			0xc00
+
+#define	rOFDM0_TRxPathEnable		0xc04
+#define	rOFDM0_TRMuxPar			0xc08
+#define	rOFDM0_TRSWIsolation		0xc0c
+
+/* RxIQ DC offset, Rx digital filter, DC notch filter */
+#define	rOFDM0_XARxAFE			0xc10
+#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
+#define	rOFDM0_XBRxAFE			0xc18
+#define	rOFDM0_XBRxIQImbalance		0xc1c
+#define	rOFDM0_XCRxAFE			0xc20
+#define	rOFDM0_XCRxIQImbalance		0xc24
+#define	rOFDM0_XDRxAFE			0xc28
+#define	rOFDM0_XDRxIQImbalance		0xc2c
+
+#define	rOFDM0_RxDetector1		0xc30  /*PD,BW & SBD DM tune init gain*/
+#define	rOFDM0_RxDetector2		0xc34  /* SBD & Fame Sync. */
+#define	rOFDM0_RxDetector3		0xc38  /* Frame Sync. */
+#define	rOFDM0_RxDetector4		0xc3c  /* PD, SBD, Frame Sync & Short-GI */
+
+#define	rOFDM0_RxDSP			0xc40  /* Rx Sync Path */
+#define	rOFDM0_CFOandDAGC		0xc44  /* CFO & DAGC */
+#define	rOFDM0_CCADropThreshold		0xc48 /* CCA Drop threshold */
+#define	rOFDM0_ECCAThreshold		0xc4c /*  energy CCA */
+
+#define	rOFDM0_XAAGCCore1		0xc50	/*  DIG */
+#define	rOFDM0_XAAGCCore2		0xc54
+#define	rOFDM0_XBAGCCore1		0xc58
+#define	rOFDM0_XBAGCCore2		0xc5c
+#define	rOFDM0_XCAGCCore1		0xc60
+#define	rOFDM0_XCAGCCore2		0xc64
+#define	rOFDM0_XDAGCCore1		0xc68
+#define	rOFDM0_XDAGCCore2		0xc6c
+
+#define	rOFDM0_AGCParameter1		0xc70
+#define	rOFDM0_AGCParameter2		0xc74
+#define	rOFDM0_AGCRSSITable		0xc78
+#define	rOFDM0_HTSTFAGC			0xc7c
+
+#define	rOFDM0_XATxIQImbalance		0xc80	/*  TX PWR TRACK and DIG */
+#define	rOFDM0_XATxAFE			0xc84
+#define	rOFDM0_XBTxIQImbalance		0xc88
+#define	rOFDM0_XBTxAFE			0xc8c
+#define	rOFDM0_XCTxIQImbalance		0xc90
+#define	rOFDM0_XCTxAFE			0xc94
+#define	rOFDM0_XDTxIQImbalance		0xc98
+#define	rOFDM0_XDTxAFE			0xc9c
+
+#define	rOFDM0_RxIQExtAnta		0xca0
+#define	rOFDM0_TxCoeff1			0xca4
+#define	rOFDM0_TxCoeff2			0xca8
+#define	rOFDM0_TxCoeff3			0xcac
+#define	rOFDM0_TxCoeff4			0xcb0
+#define	rOFDM0_TxCoeff5			0xcb4
+#define	rOFDM0_TxCoeff6			0xcb8
+#define	rOFDM0_RxHPParameter		0xce0
+#define	rOFDM0_TxPseudoNoiseWgt		0xce4
+#define	rOFDM0_FrameSync		0xcf0
+#define	rOFDM0_DFSReport		0xcf4
+
+/*  */
+/*  7. PageD(0xD00) */
+/*  */
+#define	rOFDM1_LSTF			0xd00
+#define	rOFDM1_TRxPathEnable		0xd04
+
+#define	rOFDM1_CFO			0xd08	/*  No setting now */
+#define	rOFDM1_CSI1			0xd10
+#define	rOFDM1_SBD			0xd14
+#define	rOFDM1_CSI2			0xd18
+#define	rOFDM1_CFOTracking		0xd2c
+#define	rOFDM1_TRxMesaure1		0xd34
+#define	rOFDM1_IntfDet			0xd3c
+#define	rOFDM1_PseudoNoiseStateAB	0xd50
+#define	rOFDM1_PseudoNoiseStateCD	0xd54
+#define	rOFDM1_RxPseudoNoiseWgt		0xd58
+
+#define	rOFDM_PHYCounter1		0xda0  /* cca, parity fail */
+#define	rOFDM_PHYCounter2		0xda4  /* rate illegal, crc8 fail */
+#define	rOFDM_PHYCounter3		0xda8  /* MCS not support */
+
+#define	rOFDM_ShortCFOAB		0xdac	/*  No setting now */
+#define	rOFDM_ShortCFOCD		0xdb0
+#define	rOFDM_LongCFOAB			0xdb4
+#define	rOFDM_LongCFOCD			0xdb8
+#define	rOFDM_TailCFOAB			0xdbc
+#define	rOFDM_TailCFOCD			0xdc0
+#define	rOFDM_PWMeasure1		0xdc4
+#define	rOFDM_PWMeasure2		0xdc8
+#define	rOFDM_BWReport			0xdcc
+#define	rOFDM_AGCReport			0xdd0
+#define	rOFDM_RxSNR			0xdd4
+#define	rOFDM_RxEVMCSI			0xdd8
+#define	rOFDM_SIGReport			0xddc
+
+/*  */
+/*  8. PageE(0xE00) */
+/*  */
+#define	rTxAGC_A_Rate18_06		0xe00
+#define	rTxAGC_A_Rate54_24		0xe04
+#define	rTxAGC_A_CCK1_Mcs32		0xe08
+#define	rTxAGC_A_Mcs03_Mcs00		0xe10
+#define	rTxAGC_A_Mcs07_Mcs04		0xe14
+#define	rTxAGC_A_Mcs11_Mcs08		0xe18
+#define	rTxAGC_A_Mcs15_Mcs12		0xe1c
+
+#define	rTxAGC_B_Rate18_06		0x830
+#define	rTxAGC_B_Rate54_24		0x834
+#define	rTxAGC_B_CCK1_55_Mcs32		0x838
+#define	rTxAGC_B_Mcs03_Mcs00		0x83c
+#define	rTxAGC_B_Mcs07_Mcs04		0x848
+#define	rTxAGC_B_Mcs11_Mcs08		0x84c
+#define	rTxAGC_B_Mcs15_Mcs12		0x868
+#define	rTxAGC_B_CCK11_A_CCK2_11	0x86c
+
+#define	rFPGA0_IQK			0xe28
+#define	rTx_IQK_Tone_A			0xe30
+#define	rRx_IQK_Tone_A			0xe34
+#define	rTx_IQK_PI_A			0xe38
+#define	rRx_IQK_PI_A			0xe3c
+
+#define	rTx_IQK				0xe40
+#define	rRx_IQK				0xe44
+#define	rIQK_AGC_Pts			0xe48
+#define	rIQK_AGC_Rsp			0xe4c
+#define	rTx_IQK_Tone_B			0xe50
+#define	rRx_IQK_Tone_B			0xe54
+#define	rTx_IQK_PI_B			0xe58
+#define	rRx_IQK_PI_B			0xe5c
+#define	rIQK_AGC_Cont			0xe60
+
+#define	rBlue_Tooth			0xe6c
+#define	rRx_Wait_CCA			0xe70
+#define	rTx_CCK_RFON			0xe74
+#define	rTx_CCK_BBON			0xe78
+#define	rTx_OFDM_RFON			0xe7c
+#define	rTx_OFDM_BBON			0xe80
+#define	rTx_To_Rx			0xe84
+#define	rTx_To_Tx			0xe88
+#define	rRx_CCK				0xe8c
+
+#define	rTx_Power_Before_IQK_A		0xe94
+#define	rTx_Power_After_IQK_A		0xe9c
+
+#define	rRx_Power_Before_IQK_A		0xea0
+#define	rRx_Power_Before_IQK_A_2	0xea4
+#define	rRx_Power_After_IQK_A		0xea8
+#define	rRx_Power_After_IQK_A_2		0xeac
+
+#define	rTx_Power_Before_IQK_B		0xeb4
+#define	rTx_Power_After_IQK_B		0xebc
+
+#define	rRx_Power_Before_IQK_B		0xec0
+#define	rRx_Power_Before_IQK_B_2	0xec4
+#define	rRx_Power_After_IQK_B		0xec8
+#define	rRx_Power_After_IQK_B_2		0xecc
+
+#define	rRx_OFDM			0xed0
+#define	rRx_Wait_RIFS			0xed4
+#define	rRx_TO_Rx			0xed8
+#define	rStandby			0xedc
+#define	rSleep				0xee0
+#define	rPMPD_ANAEN			0xeec
+
+/*  */
+/*  7. RF Register 0x00-0x2E (RF 8256) */
+/*     RF-0222D 0x00-3F */
+/*  */
+/* Zebra1 */
+#define	rZebra1_HSSIEnable		0x0	/*  Useless now */
+#define	rZebra1_TRxEnable1		0x1
+#define	rZebra1_TRxEnable2		0x2
+#define	rZebra1_AGC			0x4
+#define	rZebra1_ChargePump		0x5
+#define	rZebra1_Channel			0x7	/*  RF channel switch */
+
+/* endif */
+#define	rZebra1_TxGain			0x8	/*  Useless now */
+#define	rZebra1_TxLPF			0x9
+#define	rZebra1_RxLPF			0xb
+#define	rZebra1_RxHPFCorner		0xc
+
+/* Zebra4 */
+#define	rGlobalCtrl		0	/*  Useless now */
+#define	rRTL8256_TxLPF		19
+#define	rRTL8256_RxLPF		11
+
+/* RTL8258 */
+#define	rRTL8258_TxLPF		0x11	/*  Useless now */
+#define	rRTL8258_RxLPF		0x13
+#define	rRTL8258_RSSILPF	0xa
+
+/*  */
+/*  RL6052 Register definition */
+/*  */
+#define	RF_AC			0x00	/*  */
+
+#define	RF_IQADJ_G1		0x01	/*  */
+#define	RF_IQADJ_G2		0x02	/*  */
+
+#define	RF_POW_TRSW		0x05	/*  */
+
+#define	RF_GAIN_RX		0x06	/*  */
+#define	RF_GAIN_TX		0x07	/*  */
+
+#define	RF_TXM_IDAC		0x08	/*  */
+#define	RF_IPA_G		0x09	/*  */
+#define	RF_TXBIAS_G		0x0A
+#define	RF_TXPA_AG		0x0B
+#define	RF_IPA_A		0x0C	/*  */
+#define	RF_TXBIAS_A		0x0D
+#define	RF_BS_PA_APSET_G9_G11	0x0E
+#define	RF_BS_IQGEN		0x0F	/*  */
+
+#define	RF_MODE1		0x10	/*  */
+#define	RF_MODE2		0x11	/*  */
+
+#define	RF_RX_AGC_HP		0x12	/*  */
+#define	RF_TX_AGC		0x13	/*  */
+#define	RF_BIAS			0x14	/*  */
+#define	RF_IPA			0x15	/*  */
+#define	RF_TXBIAS		0x16
+#define	RF_POW_ABILITY		0x17	/*  */
+#define	RF_CHNLBW		0x18	/*  RF channel and BW switch */
+#define	RF_TOP			0x19	/*  */
+
+#define	RF_RX_G1		0x1A	/*  */
+#define	RF_RX_G2		0x1B	/*  */
+
+#define	RF_RX_BB2		0x1C	/*  */
+#define	RF_RX_BB1		0x1D	/*  */
+
+#define	RF_RCK1			0x1E	/*  */
+#define	RF_RCK2			0x1F	/*  */
+
+#define	RF_TX_G1		0x20	/*  */
+#define	RF_TX_G2		0x21	/*  */
+#define	RF_TX_G3		0x22	/*  */
+
+#define	RF_TX_BB1		0x23	/*  */
+
+#define	RF_T_METER_92D		0x42	/*  */
+#define	RF_T_METER_88E		0x42	/*  */
+#define	RF_T_METER		0x24	/*  */
+
+#define	RF_SYN_G1		0x25	/*  RF TX Power control */
+#define	RF_SYN_G2		0x26	/*  RF TX Power control */
+#define	RF_SYN_G3		0x27	/*  RF TX Power control */
+#define	RF_SYN_G4		0x28	/*  RF TX Power control */
+#define	RF_SYN_G5		0x29	/*  RF TX Power control */
+#define	RF_SYN_G6		0x2A	/*  RF TX Power control */
+#define	RF_SYN_G7		0x2B	/*  RF TX Power control */
+#define	RF_SYN_G8		0x2C	/*  RF TX Power control */
+
+#define	RF_RCK_OS		0x30	/*  RF TX PA control */
+#define	RF_TXPA_G1		0x31	/*  RF TX PA control */
+#define	RF_TXPA_G2		0x32	/*  RF TX PA control */
+#define	RF_TXPA_G3		0x33	/*  RF TX PA control */
+#define	RF_TX_BIAS_A		0x35
+#define	RF_TX_BIAS_D		0x36
+#define	RF_LOBF_9		0x38
+#define	RF_RXRF_A3		0x3C	/*  */
+#define	RF_TRSW			0x3F
+
+#define	RF_TXRF_A2		0x41
+#define	RF_TXPA_G4		0x46
+#define	RF_TXPA_A4		0x4B
+#define	RF_0x52			0x52
+#define	RF_WE_LUT		0xEF
+
+/*  */
+/* Bit Mask */
+/*  */
+/*  1. Page1(0x100) */
+#define	bBBResetB		0x100	/*  Useless now? */
+#define	bGlobalResetB		0x200
+#define	bOFDMTxStart		0x4
+#define	bCCKTxStart		0x8
+#define	bCRC32Debug		0x100
+#define	bPMACLoopback		0x10
+#define	bTxLSIG			0xffffff
+#define	bOFDMTxRate		0xf
+#define	bOFDMTxReserved		0x10
+#define	bOFDMTxLength		0x1ffe0
+#define	bOFDMTxParity		0x20000
+#define	bTxHTSIG1		0xffffff
+#define	bTxHTMCSRate		0x7f
+#define	bTxHTBW			0x80
+#define	bTxHTLength		0xffff00
+#define	bTxHTSIG2		0xffffff
+#define	bTxHTSmoothing		0x1
+#define	bTxHTSounding		0x2
+#define	bTxHTReserved		0x4
+#define	bTxHTAggreation		0x8
+#define	bTxHTSTBC		0x30
+#define	bTxHTAdvanceCoding	0x40
+#define	bTxHTShortGI		0x80
+#define	bTxHTNumberHT_LTF	0x300
+#define	bTxHTCRC8		0x3fc00
+#define	bCounterReset		0x10000
+#define	bNumOfOFDMTx		0xffff
+#define	bNumOfCCKTx		0xffff0000
+#define	bTxIdleInterval		0xffff
+#define	bOFDMService		0xffff0000
+#define	bTxMACHeader		0xffffffff
+#define	bTxDataInit		0xff
+#define	bTxHTMode		0x100
+#define	bTxDataType		0x30000
+#define	bTxRandomSeed		0xffffffff
+#define	bCCKTxPreamble		0x1
+#define	bCCKTxSFD		0xffff0000
+#define	bCCKTxSIG		0xff
+#define	bCCKTxService		0xff00
+#define	bCCKLengthExt		0x8000
+#define	bCCKTxLength		0xffff0000
+#define	bCCKTxCRC16		0xffff
+#define	bCCKTxStatus		0x1
+#define	bOFDMTxStatus		0x2
+
+#define	IS_BB_REG_OFFSET_92S(_Offset)			\
+	((_Offset >= 0x800) && (_Offset <= 0xfff))
+
+/*  2. Page8(0x800) */
+#define	bRFMOD			0x1	/*  Reg 0x800 rFPGA0_RFMOD */
+#define	bJapanMode		0x2
+#define	bCCKTxSC		0x30
+#define	bCCKEn			0x1000000
+#define	bOFDMEn			0x2000000
+
+#define	bOFDMRxADCPhase		0x10000	/*  Useless now */
+#define	bOFDMTxDACPhase		0x40000
+#define	bXATxAGC		0x3f
+
+#define	bAntennaSelect		0x0300
+
+#define	bXBTxAGC		0xf00	/*  Reg 80c rFPGA0_TxGainStage */
+#define	bXCTxAGC		0xf000
+#define	bXDTxAGC		0xf0000
+
+#define	bPAStart		0xf0000000	/*  Useless now */
+#define	bTRStart		0x00f00000
+#define	bRFStart		0x0000f000
+#define	bBBStart		0x000000f0
+#define	bBBCCKStart		0x0000000f
+#define	bPAEnd			0xf          /* Reg0x814 */
+#define	bTREnd			0x0f000000
+#define	bRFEnd			0x000f0000
+#define	bCCAMask		0x000000f0   /* T2R */
+#define	bR2RCCAMask		0x00000f00
+#define	bHSSI_R2TDelay		0xf8000000
+#define	bHSSI_T2RDelay		0xf80000
+#define	bContTxHSSI		0x400     /* change gain at continue Tx */
+#define	bIGFromCCK		0x200
+#define	bAGCAddress		0x3f
+#define	bRxHPTx			0x7000
+#define	bRxHPT2R		0x38000
+#define	bRxHPCCKIni		0xc0000
+#define	bAGCTxCode		0xc00000
+#define	bAGCRxCode		0x300000
+
+/* Reg 0x820~84f rFPGA0_XA_HSSIParameter1 */
+#define	b3WireDataLength	0x800
+#define	b3WireAddressLength	0x400
+
+#define	b3WireRFPowerDown	0x1	/*  Useless now */
+#define	b5GPAPEPolarity		0x40000000
+#define	b2GPAPEPolarity		0x80000000
+#define	bRFSW_TxDefaultAnt	0x3
+#define	bRFSW_TxOptionAnt	0x30
+#define	bRFSW_RxDefaultAnt	0x300
+#define	bRFSW_RxOptionAnt	0x3000
+#define	bRFSI_3WireData		0x1
+#define	bRFSI_3WireClock	0x2
+#define	bRFSI_3WireLoad		0x4
+#define	bRFSI_3WireRW		0x8
+#define	bRFSI_3Wire		0xf
+
+#define	bRFSI_RFENV		0x10	/* Reg 0x870 rFPGA0_XAB_RFInterfaceSW */
+
+#define	bRFSI_TRSW		0x20	/*  Useless now */
+#define	bRFSI_TRSWB		0x40
+#define	bRFSI_ANTSW		0x100
+#define	bRFSI_ANTSWB		0x200
+#define	bRFSI_PAPE		0x400
+#define	bRFSI_PAPE5G		0x800
+#define	bBandSelect		0x1
+#define	bHTSIG2_GI		0x80
+#define	bHTSIG2_Smoothing	0x01
+#define	bHTSIG2_Sounding	0x02
+#define	bHTSIG2_Aggreaton	0x08
+#define	bHTSIG2_STBC		0x30
+#define	bHTSIG2_AdvCoding	0x40
+#define	bHTSIG2_NumOfHTLTF	0x300
+#define	bHTSIG2_CRC8		0x3fc
+#define	bHTSIG1_MCS		0x7f
+#define	bHTSIG1_BandWidth	0x80
+#define	bHTSIG1_HTLength	0xffff
+#define	bLSIG_Rate		0xf
+#define	bLSIG_Reserved		0x10
+#define	bLSIG_Length		0x1fffe
+#define	bLSIG_Parity		0x20
+#define	bCCKRxPhase		0x4
+
+#define	bLSSIReadAddress	0x7f800000   /*  T65 RF */
+
+#define	bLSSIReadEdge		0x80000000   /* LSSI "Read" edge signal */
+
+#define	bLSSIReadBackData	0xfffff		/*  T65 RF */
+
+#define	bLSSIReadOKFlag		0x1000	/*  Useless now */
+#define	bCCKSampleRate		0x8       /* 0: 44MHz, 1:88MHz */
+#define	bRegulator0Standby	0x1
+#define	bRegulatorPLLStandby	0x2
+#define	bRegulator1Standby	0x4
+#define	bPLLPowerUp		0x8
+#define	bDPLLPowerUp		0x10
+#define	bDA10PowerUp		0x20
+#define	bAD7PowerUp		0x200
+#define	bDA6PowerUp		0x2000
+#define	bXtalPowerUp		0x4000
+#define	b40MDClkPowerUP		0x8000
+#define	bDA6DebugMode		0x20000
+#define	bDA6Swing		0x380000
+
+/*  Reg 0x880 rFPGA0_AnalogParameter1 20/40 CCK support switch 40/80 BB MHZ */
+#define	bADClkPhase		0x4000000
+
+#define	b80MClkDelay		0x18000000	/*  Useless */
+#define	bAFEWatchDogEnable	0x20000000
+
+/*  Reg 0x884 rFPGA0_AnalogParameter2 Crystal cap */
+#define	bXtalCap01		0xc0000000
+#define	bXtalCap23		0x3
+#define	bXtalCap92x		0x0f000000
+#define	bXtalCap		0x0f000000
+
+#define	bIntDifClkEnable	0x400	/*  Useless */
+#define	bExtSigClkEnable	0x800
+#define	bBandgapMbiasPowerUp	0x10000
+#define	bAD11SHGain		0xc0000
+#define	bAD11InputRange		0x700000
+#define	bAD11OPCurrent		0x3800000
+#define	bIPathLoopback		0x4000000
+#define	bQPathLoopback		0x8000000
+#define	bAFELoopback		0x10000000
+#define	bDA10Swing		0x7e0
+#define	bDA10Reverse		0x800
+#define	bDAClkSource		0x1000
+#define	bAD7InputRange		0x6000
+#define	bAD7Gain		0x38000
+#define	bAD7OutputCMMode	0x40000
+#define	bAD7InputCMMode		0x380000
+#define	bAD7Current		0xc00000
+#define	bRegulatorAdjust	0x7000000
+#define	bAD11PowerUpAtTx	0x1
+#define	bDA10PSAtTx		0x10
+#define	bAD11PowerUpAtRx	0x100
+#define	bDA10PSAtRx		0x1000
+#define	bCCKRxAGCFormat		0x200
+#define	bPSDFFTSamplepPoint	0xc000
+#define	bPSDAverageNum		0x3000
+#define	bIQPathControl		0xc00
+#define	bPSDFreq		0x3ff
+#define	bPSDAntennaPath		0x30
+#define	bPSDIQSwitch		0x40
+#define	bPSDRxTrigger		0x400000
+#define	bPSDTxTrigger		0x80000000
+#define	bPSDSineToneScale	0x7f000000
+#define	bPSDReport		0xffff
+
+/*  3. Page9(0x900) */
+#define	bOFDMTxSC		0x30000000	/*  Useless */
+#define	bCCKTxOn		0x1
+#define	bOFDMTxOn		0x2
+#define	bDebugPage		0xfff  /* reset debug page and HWord, LWord */
+#define	bDebugItem		0xff   /* reset debug page and LWord */
+#define	bAntL			0x10
+#define	bAntNonHT		0x100
+#define	bAntHT1			0x1000
+#define	bAntHT2			0x10000
+#define	bAntHT1S1		0x100000
+#define	bAntNonHTS1		0x1000000
+
+/*  4. PageA(0xA00) */
+#define	bCCKBBMode		0x3	/*  Useless */
+#define	bCCKTxPowerSaving	0x80
+#define	bCCKRxPowerSaving	0x40
+
+#define	bCCKSideBand		0x10	/*  Reg 0xa00 rCCK0_System 20/40 */
+
+#define	bCCKScramble		0x8	/*  Useless */
+#define	bCCKAntDiversity	0x8000
+#define	bCCKCarrierRecovery	0x4000
+#define	bCCKTxRate		0x3000
+#define	bCCKDCCancel		0x0800
+#define	bCCKISICancel		0x0400
+#define	bCCKMatchFilter		0x0200
+#define	bCCKEqualizer		0x0100
+#define	bCCKPreambleDetect	0x800000
+#define	bCCKFastFalseCCA	0x400000
+#define	bCCKChEstStart		0x300000
+#define	bCCKCCACount		0x080000
+#define	bCCKcs_lim		0x070000
+#define	bCCKBistMode		0x80000000
+#define	bCCKCCAMask		0x40000000
+#define	bCCKTxDACPhase		0x4
+#define	bCCKRxADCPhase		0x20000000   /* r_rx_clk */
+#define	bCCKr_cp_mode0		0x0100
+#define	bCCKTxDCOffset		0xf0
+#define	bCCKRxDCOffset		0xf
+#define	bCCKCCAMode		0xc000
+#define	bCCKFalseCS_lim		0x3f00
+#define	bCCKCS_ratio		0xc00000
+#define	bCCKCorgBit_sel		0x300000
+#define	bCCKPD_lim		0x0f0000
+#define	bCCKNewCCA		0x80000000
+#define	bCCKRxHPofIG		0x8000
+#define	bCCKRxIG		0x7f00
+#define	bCCKLNAPolarity		0x800000
+#define	bCCKRx1stGain		0x7f0000
+#define	bCCKRFExtend		0x20000000 /* CCK Rx Iinital gain polarity */
+#define	bCCKRxAGCSatLevel	0x1f000000
+#define	bCCKRxAGCSatCount	0xe0
+#define	bCCKRxRFSettle		0x1f       /* AGCsamp_dly */
+#define	bCCKFixedRxAGC		0x8000
+#define	bCCKAntennaPolarity	0x2000
+#define	bCCKTxFilterType	0x0c00
+#define	bCCKRxAGCReportType	0x0300
+#define	bCCKRxDAGCEn		0x80000000
+#define	bCCKRxDAGCPeriod	0x20000000
+#define	bCCKRxDAGCSatLevel	0x1f000000
+#define	bCCKTimingRecovery	0x800000
+#define	bCCKTxC0		0x3f0000
+#define	bCCKTxC1		0x3f000000
+#define	bCCKTxC2		0x3f
+#define	bCCKTxC3		0x3f00
+#define	bCCKTxC4		0x3f0000
+#define	bCCKTxC5		0x3f000000
+#define	bCCKTxC6		0x3f
+#define	bCCKTxC7		0x3f00
+#define	bCCKDebugPort		0xff0000
+#define	bCCKDACDebug		0x0f000000
+#define	bCCKFalseAlarmEnable	0x8000
+#define	bCCKFalseAlarmRead	0x4000
+#define	bCCKTRSSI		0x7f
+#define	bCCKRxAGCReport		0xfe
+#define	bCCKRxReport_AntSel	0x80000000
+#define	bCCKRxReport_MFOff	0x40000000
+#define	bCCKRxRxReport_SQLoss	0x20000000
+#define	bCCKRxReport_Pktloss	0x10000000
+#define	bCCKRxReport_Lockedbit	0x08000000
+#define	bCCKRxReport_RateError	0x04000000
+#define	bCCKRxReport_RxRate	0x03000000
+#define	bCCKRxFACounterLower	0xff
+#define	bCCKRxFACounterUpper	0xff000000
+#define	bCCKRxHPAGCStart	0xe000
+#define	bCCKRxHPAGCFinal	0x1c00
+#define	bCCKRxFalseAlarmEnable	0x8000
+#define	bCCKFACounterFreeze	0x4000
+#define	bCCKTxPathSel		0x10000000
+#define	bCCKDefaultRxPath	0xc000000
+#define	bCCKOptionRxPath	0x3000000
+
+/*  5. PageC(0xC00) */
+#define	bNumOfSTF		0x3	/*  Useless */
+#define	bShift_L		0xc0
+#define	bGI_TH			0xc
+#define	bRxPathA		0x1
+#define	bRxPathB		0x2
+#define	bRxPathC		0x4
+#define	bRxPathD		0x8
+#define	bTxPathA		0x1
+#define	bTxPathB		0x2
+#define	bTxPathC		0x4
+#define	bTxPathD		0x8
+#define	bTRSSIFreq		0x200
+#define	bADCBackoff		0x3000
+#define	bDFIRBackoff		0xc000
+#define	bTRSSILatchPhase	0x10000
+#define	bRxIDCOffset		0xff
+#define	bRxQDCOffset		0xff00
+#define	bRxDFIRMode		0x1800000
+#define	bRxDCNFType		0xe000000
+#define	bRXIQImb_A		0x3ff
+#define	bRXIQImb_B		0xfc00
+#define	bRXIQImb_C		0x3f0000
+#define	bRXIQImb_D		0xffc00000
+#define	bDC_dc_Notch		0x60000
+#define	bRxNBINotch		0x1f000000
+#define	bPD_TH			0xf
+#define	bPD_TH_Opt2		0xc000
+#define	bPWED_TH		0x700
+#define	bIfMF_Win_L		0x800
+#define	bPD_Option		0x1000
+#define	bMF_Win_L		0xe000
+#define	bBW_Search_L		0x30000
+#define	bwin_enh_L		0xc0000
+#define	bBW_TH			0x700000
+#define	bED_TH2			0x3800000
+#define	bBW_option		0x4000000
+#define	bRatio_TH		0x18000000
+#define	bWindow_L		0xe0000000
+#define	bSBD_Option		0x1
+#define	bFrame_TH		0x1c
+#define	bFS_Option		0x60
+#define	bDC_Slope_check		0x80
+#define	bFGuard_Counter_DC_L	0xe00
+#define	bFrame_Weight_Short	0x7000
+#define	bSub_Tune		0xe00000
+#define	bFrame_DC_Length	0xe000000
+#define	bSBD_start_offset	0x30000000
+#define	bFrame_TH_2		0x7
+#define	bFrame_GI2_TH		0x38
+#define	bGI2_Sync_en		0x40
+#define	bSarch_Short_Early	0x300
+#define	bSarch_Short_Late	0xc00
+#define	bSarch_GI2_Late		0x70000
+#define	bCFOAntSum		0x1
+#define	bCFOAcc			0x2
+#define	bCFOStartOffset		0xc
+#define	bCFOLookBack		0x70
+#define	bCFOSumWeight		0x80
+#define	bDAGCEnable		0x10000
+#define	bTXIQImb_A		0x3ff
+#define	bTXIQImb_B		0xfc00
+#define	bTXIQImb_C		0x3f0000
+#define	bTXIQImb_D		0xffc00000
+#define	bTxIDCOffset		0xff
+#define	bTxQDCOffset		0xff00
+#define	bTxDFIRMode		0x10000
+#define	bTxPesudoNoiseOn	0x4000000
+#define	bTxPesudoNoise_A	0xff
+#define	bTxPesudoNoise_B	0xff00
+#define	bTxPesudoNoise_C	0xff0000
+#define	bTxPesudoNoise_D	0xff000000
+#define	bCCADropOption		0x20000
+#define	bCCADropThres		0xfff00000
+#define	bEDCCA_H		0xf
+#define	bEDCCA_L		0xf0
+#define	bLambda_ED		0x300
+#define	bRxInitialGain		0x7f
+#define	bRxAntDivEn		0x80
+#define	bRxAGCAddressForLNA	0x7f00
+#define	bRxHighPowerFlow	0x8000
+#define	bRxAGCFreezeThres	0xc0000
+#define	bRxFreezeStep_AGC1	0x300000
+#define	bRxFreezeStep_AGC2	0xc00000
+#define	bRxFreezeStep_AGC3	0x3000000
+#define	bRxFreezeStep_AGC0	0xc000000
+#define	bRxRssi_Cmp_En		0x10000000
+#define	bRxQuickAGCEn		0x20000000
+#define	bRxAGCFreezeThresMode	0x40000000
+#define	bRxOverFlowCheckType	0x80000000
+#define	bRxAGCShift		0x7f
+#define	bTRSW_Tri_Only		0x80
+#define	bPowerThres		0x300
+#define	bRxAGCEn		0x1
+#define	bRxAGCTogetherEn	0x2
+#define	bRxAGCMin		0x4
+#define	bRxHP_Ini		0x7
+#define	bRxHP_TRLNA		0x70
+#define	bRxHP_RSSI		0x700
+#define	bRxHP_BBP1		0x7000
+#define	bRxHP_BBP2		0x70000
+#define	bRxHP_BBP3		0x700000
+#define	bRSSI_H			0x7f0000     /* threshold for high power */
+#define	bRSSI_Gen		0x7f000000   /* threshold for ant diversity */
+#define	bRxSettle_TRSW		0x7
+#define	bRxSettle_LNA		0x38
+#define	bRxSettle_RSSI		0x1c0
+#define	bRxSettle_BBP		0xe00
+#define	bRxSettle_RxHP		0x7000
+#define	bRxSettle_AntSW_RSSI	0x38000
+#define	bRxSettle_AntSW		0xc0000
+#define	bRxProcessTime_DAGC	0x300000
+#define	bRxSettle_HSSI		0x400000
+#define	bRxProcessTime_BBPPW	0x800000
+#define	bRxAntennaPowerShift	0x3000000
+#define	bRSSITableSelect	0xc000000
+#define	bRxHP_Final		0x7000000
+#define	bRxHTSettle_BBP		0x7
+#define	bRxHTSettle_HSSI	0x8
+#define	bRxHTSettle_RxHP	0x70
+#define	bRxHTSettle_BBPPW	0x80
+#define	bRxHTSettle_Idle	0x300
+#define	bRxHTSettle_Reserved	0x1c00
+#define	bRxHTRxHPEn		0x8000
+#define	bRxHTAGCFreezeThres	0x30000
+#define	bRxHTAGCTogetherEn	0x40000
+#define	bRxHTAGCMin		0x80000
+#define	bRxHTAGCEn		0x100000
+#define	bRxHTDAGCEn		0x200000
+#define	bRxHTRxHP_BBP		0x1c00000
+#define	bRxHTRxHP_Final		0xe0000000
+#define	bRxPWRatioTH		0x3
+#define	bRxPWRatioEn		0x4
+#define	bRxMFHold		0x3800
+#define	bRxPD_Delay_TH1		0x38
+#define	bRxPD_Delay_TH2		0x1c0
+#define	bRxPD_DC_COUNT_MAX	0x600
+#define	bRxPD_Delay_TH		0x8000
+#define	bRxProcess_Delay	0xf0000
+#define	bRxSearchrange_GI2_Early	0x700000
+#define	bRxFrame_Guard_Counter_L	0x3800000
+#define	bRxSGI_Guard_L		0xc000000
+#define	bRxSGI_Search_L		0x30000000
+#define	bRxSGI_TH		0xc0000000
+#define	bDFSCnt0		0xff
+#define	bDFSCnt1		0xff00
+#define	bDFSFlag		0xf0000
+#define	bMFWeightSum		0x300000
+#define	bMinIdxTH		0x7f000000
+#define	bDAFormat		0x40000
+#define	bTxChEmuEnable		0x01000000
+#define	bTRSWIsolation_A	0x7f
+#define	bTRSWIsolation_B	0x7f00
+#define	bTRSWIsolation_C	0x7f0000
+#define	bTRSWIsolation_D	0x7f000000
+#define	bExtLNAGain		0x7c00
+
+/*  6. PageE(0xE00) */
+#define	bSTBCEn			0x4	/*  Useless */
+#define	bAntennaMapping		0x10
+#define	bNss			0x20
+#define	bCFOAntSumD		0x200
+#define	bPHYCounterReset	0x8000000
+#define	bCFOReportGet		0x4000000
+#define	bOFDMContinueTx		0x10000000
+#define	bOFDMSingleCarrier	0x20000000
+#define	bOFDMSingleTone		0x40000000
+#define	bHTDetect		0x100
+#define	bCFOEn			0x10000
+#define	bCFOValue		0xfff00000
+#define	bSigTone_Re		0x3f
+#define	bSigTone_Im		0x7f00
+#define	bCounter_CCA		0xffff
+#define	bCounter_ParityFail	0xffff0000
+#define	bCounter_RateIllegal	0xffff
+#define	bCounter_CRC8Fail	0xffff0000
+#define	bCounter_MCSNoSupport	0xffff
+#define	bCounter_FastSync	0xffff
+#define	bShortCFO		0xfff
+#define	bShortCFOTLength	12   /* total */
+#define	bShortCFOFLength	11   /* fraction */
+#define	bLongCFO		0x7ff
+#define	bLongCFOTLength		11
+#define	bLongCFOFLength		11
+#define	bTailCFO		0x1fff
+#define	bTailCFOTLength		13
+#define	bTailCFOFLength		12
+#define	bmax_en_pwdB		0xffff
+#define	bCC_power_dB		0xffff0000
+#define	bnoise_pwdB		0xffff
+#define	bPowerMeasTLength	10
+#define	bPowerMeasFLength	3
+#define	bRx_HT_BW		0x1
+#define	bRxSC			0x6
+#define	bRx_HT			0x8
+#define	bNB_intf_det_on		0x1
+#define	bIntf_win_len_cfg	0x30
+#define	bNB_Intf_TH_cfg		0x1c0
+#define	bRFGain			0x3f
+#define	bTableSel		0x40
+#define	bTRSW			0x80
+#define	bRxSNR_A		0xff
+#define	bRxSNR_B		0xff00
+#define	bRxSNR_C		0xff0000
+#define	bRxSNR_D		0xff000000
+#define	bSNREVMTLength		8
+#define	bSNREVMFLength		1
+#define	bCSI1st			0xff
+#define	bCSI2nd			0xff00
+#define	bRxEVM1st		0xff0000
+#define	bRxEVM2nd		0xff000000
+#define	bSIGEVM			0xff
+#define	bPWDB			0xff00
+#define	bSGIEN			0x10000
+
+#define	bSFactorQAM1		0xf	/*  Useless */
+#define	bSFactorQAM2		0xf0
+#define	bSFactorQAM3		0xf00
+#define	bSFactorQAM4		0xf000
+#define	bSFactorQAM5		0xf0000
+#define	bSFactorQAM6		0xf0000
+#define	bSFactorQAM7		0xf00000
+#define	bSFactorQAM8		0xf000000
+#define	bSFactorQAM9		0xf0000000
+#define	bCSIScheme		0x100000
+
+#define	bNoiseLvlTopSet		0x3	/*  Useless */
+#define	bChSmooth		0x4
+#define	bChSmoothCfg1		0x38
+#define	bChSmoothCfg2		0x1c0
+#define	bChSmoothCfg3		0xe00
+#define	bChSmoothCfg4		0x7000
+#define	bMRCMode		0x800000
+#define	bTHEVMCfg		0x7000000
+
+#define	bLoopFitType		0x1	/*  Useless */
+#define	bUpdCFO			0x40
+#define	bUpdCFOOffData		0x80
+#define	bAdvUpdCFO		0x100
+#define	bAdvTimeCtrl		0x800
+#define	bUpdClko		0x1000
+#define	bFC			0x6000
+#define	bTrackingMode		0x8000
+#define	bPhCmpEnable		0x10000
+#define	bUpdClkoLTF		0x20000
+#define	bComChCFO		0x40000
+#define	bCSIEstiMode		0x80000
+#define	bAdvUpdEqz		0x100000
+#define	bUChCfg			0x7000000
+#define	bUpdEqz			0x8000000
+
+/* Rx Pseduo noise */
+#define	bRxPesudoNoiseOn	0x20000000	/*  Useless */
+#define	bRxPesudoNoise_A	0xff
+#define	bRxPesudoNoise_B	0xff00
+#define	bRxPesudoNoise_C	0xff0000
+#define	bRxPesudoNoise_D	0xff000000
+#define	bPesudoNoiseState_A	0xffff
+#define	bPesudoNoiseState_B	0xffff0000
+#define	bPesudoNoiseState_C	0xffff
+#define	bPesudoNoiseState_D	0xffff0000
+
+/* 7. RF Register */
+/* Zebra1 */
+#define	bZebra1_HSSIEnable	0x8		/*  Useless */
+#define	bZebra1_TRxControl	0xc00
+#define	bZebra1_TRxGainSetting	0x07f
+#define	bZebra1_RxCorner	0xc00
+#define	bZebra1_TxChargePump	0x38
+#define	bZebra1_RxChargePump	0x7
+#define	bZebra1_ChannelNum	0xf80
+#define	bZebra1_TxLPFBW		0x400
+#define	bZebra1_RxLPFBW		0x600
+
+/* Zebra4 */
+#define	bRTL8256RegModeCtrl1	0x100	/*  Useless */
+#define	bRTL8256RegModeCtrl0	0x40
+#define	bRTL8256_TxLPFBW	0x18
+#define	bRTL8256_RxLPFBW	0x600
+
+/* RTL8258 */
+#define	bRTL8258_TxLPFBW	0xc	/*  Useless */
+#define	bRTL8258_RxLPFBW	0xc00
+#define	bRTL8258_RSSILPFBW	0xc0
+
+/*  */
+/*  Other Definition */
+/*  */
+
+/* byte endable for sb_write */
+#define	bByte0			0x1	/*  Useless */
+#define	bByte1			0x2
+#define	bByte2			0x4
+#define	bByte3			0x8
+#define	bWord0			0x3
+#define	bWord1			0xc
+#define	bDWord			0xf
+
+/* for PutRegsetting & GetRegSetting BitMask */
+#define	bMaskByte0		0xff	/*  Reg 0xc50 rOFDM0_XAAGCCore~0xC6f */
+#define	bMaskByte1		0xff00
+#define	bMaskByte2		0xff0000
+#define	bMaskByte3		0xff000000
+#define	bMaskHWord		0xffff0000
+#define	bMaskLWord		0x0000ffff
+#define	bMaskDWord		0xffffffff
+#define	bMask12Bits		0xfff
+#define	bMaskH4Bits		0xf0000000
+#define	bMaskOFDM_D		0xffc00000
+#define	bMaskCCK		0x3f3f3f3f
+
+/* for PutRFRegsetting & GetRFRegSetting BitMask */
+#define	bRFRegOffsetMask	0xfffff
+
+#define	bEnable                 0x1	/*  Useless */
+#define	bDisable                0x0
+
+#define	LeftAntenna		0x0	/*  Useless */
+#define	RightAntenna		0x1
+
+#define	tCheckTxStatus		500   /* 500ms Useless */
+#define	tUpdateRxCounter	100   /* 100ms */
+
+#define	rateCCK			0	/*  Useless */
+#define	rateOFDM		1
+#define	rateHT			2
+
+/* define Register-End */
+#define	bPMAC_End		0x1ff	/*  Useless */
+#define	bFPGAPHY0_End		0x8ff
+#define	bFPGAPHY1_End		0x9ff
+#define	bCCKPHY0_End		0xaff
+#define	bOFDMPHY0_End		0xcff
+#define	bOFDMPHY1_End		0xdff
+
+#define	bPMACControl		0x0	/*  Useless */
+#define	bWMACControl		0x1
+#define	bWNICControl		0x2
+
+#define	PathA			0x0	/*  Useless */
+#define	PathB			0x1
+#define	PathC			0x2
+#define	PathD			0x3
+
+/*--------------------------Define Parameters-------------------------------*/
+
+#endif
diff --git a/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
new file mode 100644
index 000000000000..df151b76f302
--- /dev/null
+++ b/drivers/staging/r8188eu/include/Hal8188EPwrSeq.h
@@ -0,0 +1,173 @@
+
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef __HAL8188EPWRSEQ_H__
+#define __HAL8188EPWRSEQ_H__
+
+#include "HalPwrSeqCmd.h"
+
+/*
+	Check document WM-20110607-Paul-RTL8188E_Power_Architecture-R02.vsd
+	There are 6 HW Power States:
+	0: POFF--Power Off
+	1: PDN--Power Down
+	2: CARDEMU--Card Emulation
+	3: ACT--Active Mode
+	4: LPS--Low Power State
+	5: SUS--Suspend
+
+	The transision from different states are defined below
+	TRANS_CARDEMU_TO_ACT
+	TRANS_ACT_TO_CARDEMU
+	TRANS_CARDEMU_TO_SUS
+	TRANS_SUS_TO_CARDEMU
+	TRANS_CARDEMU_TO_PDN
+	TRANS_ACT_TO_LPS
+	TRANS_LPS_TO_ACT
+
+	TRANS_END
+
+    PWR SEQ Version: rtl8188E_PwrSeq_V09.h
+*/
+#define	RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS	10
+#define	RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS	10
+#define	RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS	10
+#define	RTL8188E_TRANS_SUS_TO_CARDEMU_STEPS	10
+#define	RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS	10
+#define	RTL8188E_TRANS_PDN_TO_CARDEMU_STEPS	10
+#define	RTL8188E_TRANS_ACT_TO_LPS_STEPS		15
+#define	RTL8188E_TRANS_LPS_TO_ACT_STEPS		15
+#define	RTL8188E_TRANS_END_STEPS		1
+
+#define RTL8188E_TRANS_CARDEMU_TO_ACT														\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
+	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT1, BIT1},/* wait till 0x04[17] = 1    power ready*/	\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0|BIT1, 0}, /* 0x02[1:0] = 0	reset BB*/			\
+	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, 0}, /* 0x04[15] = 0 disable HWPDN (control by DRV)*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4|BIT3, 0}, /*0x04[12:11] = 2b'00 disable WL suspend*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, BIT0}, /*0x04[8] = 1 polling until return 0*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT0, 0}, /*wait till 0x04[8] = 0*/	\
+	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*LDO normal mode*/	\
+	{0x0074, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*SDIO Driving*/	\
+
+#define RTL8188E_TRANS_ACT_TO_CARDEMU													\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
+	{0x001F, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*0x1F[7:0] = 0 turn off RF*/	\
+	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*LDO Sleep mode*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1, BIT1}, /*0x04[9] = 1 turn off MAC by HW state machine*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT1, 0}, /*wait till 0x04[9] = 0 polling until return 0 to disable*/	\
+
+#define RTL8188E_TRANS_CARDEMU_TO_SUS													\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/				\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01enable WL suspend*/	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3|BIT4}, /*0x04[12:11] = 2b'11enable WL suspend for PCIe*/	\
+	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, BIT7}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
+	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
+
+#define RTL8188E_TRANS_SUS_TO_CARDEMU													\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/							\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/
+
+#define RTL8188E_TRANS_CARDEMU_TO_CARDDIS													\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/							\
+	{0x0026, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7}, /*0x24[23] = 2b'01 schmit trigger */	\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
+	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*  0x04[31:30] = 2b'10 enable enable bandgap mbias in suspend */	\
+	{0x0041, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*Clear SIC_EN register 0x40[12] = 1'b0 */	\
+	{0xfe10, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*Set USB suspend enable local register  0xfe10[4]=1 */	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
+
+#define RTL8188E_TRANS_CARDDIS_TO_CARDEMU													\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
+	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/
+
+#define RTL8188E_TRANS_CARDEMU_TO_PDN												\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/							\
+	{0x0006, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0},/* 0x04[16] = 0*/\
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, BIT7},/* 0x04[15] = 1*/
+
+#define RTL8188E_TRANS_PDN_TO_CARDEMU												\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here					 */ \
+	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT7, 0},/* 0x04[15] = 0*/
+
+/* This is used by driver for LPSRadioOff Procedure, not for FW LPS Step */
+#define RTL8188E_TRANS_ACT_TO_LPS														\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here				*/   \
+	{0x0522, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x7F},/*Tx Pause*/	\
+	{0x05F8, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05F9, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FA, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x05FB, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, 0xFF, 0},/*Should be zero if no packet is transmitting*/	\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0},/*CCK and OFDM are disabled,and clock are gated*/	\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_US},/*Delay 1us*/	\
+	{0x0100, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x3F},/*Reset MAC TRX*/	\
+	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1, 0},/*check if removed later*/	\
+	{0x0553, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT5, BIT5},/*Respond TxOK to scheduler*/	\
+
+#define RTL8188E_TRANS_LPS_TO_ACT															\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here				 */ \
+	{0x0080, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, 0xFF, 0x84}, /*SDIO RPWM*/\
+	{0xFE58, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x84}, /*USB RPWM*/\
+	{0x0361, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x84}, /*PCIe RPWM*/\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_DELAY, 0, PWRSEQ_DELAY_MS}, /*Delay*/\
+	{0x0008, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*.	0x08[4] = 0		 switch TSF to 40M*/\
+	{0x0109, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_POLLING, BIT7, 0}, /*Polling 0x109[7]=0  TSF in 40M*/\
+	{0x0029, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT6|BIT7, 0}, /*.	0x29[7:6] = 2b'00	 enable BB clock*/\
+	{0x0101, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1, BIT1}, /*.	0x101[1] = 1*/\
+	{0x0100, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0xFF}, /*.	0x100[7:0] = 0xFF	 enable WMAC TRX*/\
+	{0x0002, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT1|BIT0, BIT1|BIT0}, /*.	0x02[1:0] = 2b'11	 enable BB macro*/\
+	{0x0522, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0}, /*.	0x522 = 0*/
+
+#define RTL8188E_TRANS_END															\
+	/* format */																\
+	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value },  comments here*/					\
+	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK,0, PWR_CMD_END, 0, 0}, /*  */
+
+extern struct wl_pwr_cfg rtl8188E_power_on_flow[RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_radio_off_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_card_disable_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS+RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_card_enable_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS+RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_suspend_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS+RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_resume_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS+RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_hwpdn_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS+RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_enter_lps_flow[RTL8188E_TRANS_ACT_TO_LPS_STEPS+RTL8188E_TRANS_END_STEPS];
+extern struct wl_pwr_cfg rtl8188E_leave_lps_flow[RTL8188E_TRANS_LPS_TO_ACT_STEPS+RTL8188E_TRANS_END_STEPS];
+
+#endif /* __HAL8188EPWRSEQ_H__ */
diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
new file mode 100644
index 000000000000..21996a1173ef
--- /dev/null
+++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
@@ -0,0 +1,75 @@
+#ifndef __INC_RA_H
+#define __INC_RA_H
+/*++
+Copyright (c) Realtek Semiconductor Corp. All rights reserved.
+
+Module Name:
+	RateAdaptive.h
+
+Abstract:
+	Prototype of RA and related data structure.
+
+Major Change History:
+	When       Who               What
+	---------- ---------------   -------------------------------
+	2011-08-12 Page            Create.
+--*/
+
+/*  Rate adaptive define */
+#define	PERENTRY	23
+#define	RETRYSIZE	5
+#define	RATESIZE	28
+#define	TX_RPT2_ITEM_SIZE	8
+
+/*  */
+/*  TX report 2 format in Rx desc */
+/*  */
+#define GET_TX_RPT2_DESC_PKT_LEN_88E(__pRxStatusDesc)		\
+	LE_BITS_TO_4BYTE(__pRxStatusDesc, 0, 9)
+#define GET_TX_RPT2_DESC_MACID_VALID_1_88E(__pRxStatusDesc)	\
+	LE_BITS_TO_4BYTE(__pRxStatusDesc+16, 0, 32)
+#define GET_TX_RPT2_DESC_MACID_VALID_2_88E(__pRxStatusDesc)	\
+	LE_BITS_TO_4BYTE(__pRxStatusDesc+20, 0, 32)
+
+#define GET_TX_REPORT_TYPE1_RERTY_0(__pAddr)			\
+	LE_BITS_TO_4BYTE(__pAddr, 0, 16)
+#define GET_TX_REPORT_TYPE1_RERTY_1(__pAddr)			\
+	LE_BITS_TO_1BYTE(__pAddr+2, 0, 8)
+#define GET_TX_REPORT_TYPE1_RERTY_2(__pAddr)			\
+	LE_BITS_TO_1BYTE(__pAddr+3, 0, 8)
+#define GET_TX_REPORT_TYPE1_RERTY_3(__pAddr)			\
+	LE_BITS_TO_1BYTE(__pAddr+4, 0, 8)
+#define GET_TX_REPORT_TYPE1_RERTY_4(__pAddr)			\
+	LE_BITS_TO_1BYTE(__pAddr+4+1, 0, 8)
+#define GET_TX_REPORT_TYPE1_DROP_0(__pAddr)			\
+	LE_BITS_TO_1BYTE(__pAddr+4+2, 0, 8)
+#define GET_TX_REPORT_TYPE1_DROP_1(__pAddr)			\
+	LE_BITS_TO_1BYTE(__pAddr+4+3, 0, 8)
+
+/*  End rate adaptive define */
+
+void ODM_RASupport_Init(struct odm_dm_struct *dm_odm);
+
+int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm);
+
+int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 MacID);
+
+u8 ODM_RA_GetShortGI_8188E(struct odm_dm_struct *dm_odm, u8 MacID);
+
+u8 ODM_RA_GetDecisionRate_8188E(struct odm_dm_struct *dm_odm, u8 MacID);
+
+u8 ODM_RA_GetHwPwrStatus_8188E(struct odm_dm_struct *dm_odm, u8 MacID);
+void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 MacID,
+				 u8 RateID, u32 RateMask,
+				 u8 SGIEnable);
+
+void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid,
+			  u8 rssi);
+
+void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm,
+			       u8 *txrpt_buf, u16 txrpt_len,
+			       u32 validentry0, u32 validentry1);
+
+void ODM_RA_Set_TxRPT_Time(struct odm_dm_struct *dm_odm, u16 minRptTime);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/Hal8188EReg.h b/drivers/staging/r8188eu/include/Hal8188EReg.h
new file mode 100644
index 000000000000..06818ac6c330
--- /dev/null
+++ b/drivers/staging/r8188eu/include/Hal8188EReg.h
@@ -0,0 +1,44 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+/*  */
+/*  File Name: Hal8188EReg.h */
+/*  */
+/*  Description: */
+/*  */
+/*  This file is for RTL8188E register definition. */
+/*  */
+/*  */
+/*  */
+#ifndef	__HAL_8188E_REG_H__
+#define __HAL_8188E_REG_H__
+
+/*  */
+/*  Register Definition */
+/*  */
+#define TRX_ANTDIV_PATH             0x860
+#define RX_ANTDIV_PATH              0xb2c
+#define	ODM_R_A_AGC_CORE1_8188E		0xc50
+
+/*  */
+/*  Bitmap Definition */
+/*  */
+#define	BIT_FA_RESET_8188E			BIT0
+
+#endif
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h b/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
new file mode 100644
index 000000000000..e57452104bfb
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_BB.h
@@ -0,0 +1,44 @@
+/******************************************************************************
+*
+* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful, but WITHOUT
+* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+* more details.
+*
+* You should have received a copy of the GNU General Public License along with
+* this program; if not, write to the Free Software Foundation, Inc.,
+* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+*
+*
+******************************************************************************/
+
+#ifndef __INC_BB_8188E_HW_IMG_H
+#define __INC_BB_8188E_HW_IMG_H
+
+/* static bool CheckCondition(const u32 Condition, const u32 Hex); */
+
+/******************************************************************************
+*                           AGC_TAB_1T.TXT
+******************************************************************************/
+
+enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *odm);
+
+/******************************************************************************
+*                           PHY_REG_1T.TXT
+******************************************************************************/
+
+enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *odm);
+
+/******************************************************************************
+*                           PHY_REG_PG.TXT
+******************************************************************************/
+
+void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h b/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
new file mode 100644
index 000000000000..ce81fea401a1
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
@@ -0,0 +1,33 @@
+/******************************************************************************
+*
+* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful, but WITHOUT
+* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+* more details.
+*
+* You should have received a copy of the GNU General Public License along with
+* this program; if not, write to the Free Software Foundation, Inc.,
+* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+*
+*
+******************************************************************************/
+
+#ifndef __INC_FW_8188E_HW_IMG_H
+#define __INC_FW_8188E_HW_IMG_H
+
+/******************************************************************************
+*                           FW_AP.TXT
+******************************************************************************/
+/******************************************************************************
+*                           FW_WoWLAN.TXT
+******************************************************************************/
+#define ArrayLength_8188E_FW_WoWLAN 15764
+extern const u8 Array_8188E_FW_WoWLAN[ArrayLength_8188E_FW_WoWLAN];
+
+#endif
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h b/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
new file mode 100644
index 000000000000..acf78b94fddb
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_MAC.h
@@ -0,0 +1,30 @@
+/******************************************************************************
+*
+* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful, but WITHOUT
+* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+* more details.
+*
+* You should have received a copy of the GNU General Public License along with
+* this program; if not, write to the Free Software Foundation, Inc.,
+* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+*
+*
+******************************************************************************/
+
+#ifndef __INC_MAC_8188E_HW_IMG_H
+#define __INC_MAC_8188E_HW_IMG_H
+
+/******************************************************************************
+*                           MAC_REG.TXT
+******************************************************************************/
+
+enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *pDM_Odm);
+
+#endif /*  end of HWIMG_SUPPORT */
diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h b/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
new file mode 100644
index 000000000000..8ecb40d26c70
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalHWImg8188E_RF.h
@@ -0,0 +1,30 @@
+/******************************************************************************
+*
+* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful, but WITHOUT
+* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+* FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+* more details.
+*
+* You should have received a copy of the GNU General Public License along with
+* this program; if not, write to the Free Software Foundation, Inc.,
+* 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+*
+*
+******************************************************************************/
+
+#ifndef __INC_RF_8188E_HW_IMG_H
+#define __INC_RF_8188E_HW_IMG_H
+
+/******************************************************************************
+ *                           RadioA_1T.TXT
+ ******************************************************************************/
+
+enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *odm);
+
+#endif /*  end of HWIMG_SUPPORT */
diff --git a/drivers/staging/r8188eu/include/HalPhyRf.h b/drivers/staging/r8188eu/include/HalPhyRf.h
new file mode 100644
index 000000000000..1ec497100da1
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalPhyRf.h
@@ -0,0 +1,30 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+ #ifndef __HAL_PHY_RF_H__
+ #define __HAL_PHY_RF_H__
+
+#define ODM_TARGET_CHNL_NUM_2G_5G	59
+
+void ODM_ResetIQKResult(struct odm_dm_struct *pDM_Odm);
+
+u8 ODM_GetRightChnlPlaceforIQK(u8 chnl);
+
+#endif	/*  #ifndef __HAL_PHY_RF_H__ */
diff --git a/drivers/staging/r8188eu/include/HalPhyRf_8188e.h b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
new file mode 100644
index 000000000000..807c301a86e4
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalPhyRf_8188e.h
@@ -0,0 +1,58 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef __HAL_PHY_RF_8188E_H__
+#define __HAL_PHY_RF_8188E_H__
+
+/*--------------------------Define Parameters-------------------------------*/
+#define	IQK_DELAY_TIME_88E		10		/* ms */
+#define	index_mapping_NUM_88E	15
+#define AVG_THERMAL_NUM_88E	4
+
+void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *pDM_Odm,
+			     u8 Type,	/* 0 = OFDM, 1 = CCK */
+			     u8 *pDirection,/* 1 = +(incr) 2 = -(decr) */
+			     u32 *pOutWriteVal); /* Tx tracking CCK/OFDM BB
+						     * swing index adjust */
+
+void odm_TXPowerTrackingCallback_ThermalMeter_8188E(struct adapter *Adapter);
+
+/* 1 7.	IQK */
+
+void PHY_IQCalibrate_8188E(struct adapter *Adapter, bool ReCovery);
+
+/*  LC calibrate */
+void PHY_LCCalibrate_8188E(struct adapter *pAdapter);
+
+/*  AP calibrate */
+void PHY_DigitalPredistortion_8188E(struct adapter *pAdapter);
+
+void _PHY_SaveADDARegisters(struct adapter *pAdapter, u32 *ADDAReg,
+			    u32 *ADDABackup, u32 RegisterNum);
+
+void _PHY_PathADDAOn(struct adapter *pAdapter, u32 *ADDAReg,
+		     bool isPathAOn, bool is2T);
+
+void _PHY_MACSettingCalibration(struct adapter *pAdapter, u32 *MACReg,
+				u32 *MACBackup);
+
+void _PHY_PathAStandBy(struct adapter *pAdapter);
+
+#endif	/*  #ifndef __HAL_PHY_RF_8188E_H__ */
diff --git a/drivers/staging/r8188eu/include/HalPwrSeqCmd.h b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
new file mode 100644
index 000000000000..c591e9d1c23b
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalPwrSeqCmd.h
@@ -0,0 +1,126 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __HALPWRSEQCMD_H__
+#define __HALPWRSEQCMD_H__
+
+#include <drv_types.h>
+
+/*---------------------------------------------*/
+/* 3 The value of cmd: 4 bits */
+/*---------------------------------------------*/
+#define PWR_CMD_READ			0x00
+     /*  offset: the read register offset */
+     /*  msk: the mask of the read value */
+     /*  value: N/A, left by 0 */
+     /*  note: dirver shall implement this function by read & msk */
+
+#define PWR_CMD_WRITE			0x01
+     /*  offset: the read register offset */
+     /*  msk: the mask of the write bits */
+     /*  value: write value */
+     /*  note: driver shall implement this cmd by read & msk after write */
+
+#define PWR_CMD_POLLING			0x02
+     /*  offset: the read register offset */
+     /*  msk: the mask of the polled value */
+     /*  value: the value to be polled, masked by the msd field. */
+     /*  note: driver shall implement this cmd by */
+     /*  do{ */
+     /*  if ( (Read(offset) & msk) == (value & msk) ) */
+     /*  break; */
+     /*  } while (not timeout); */
+
+#define PWR_CMD_DELAY			0x03
+     /*  offset: the value to delay */
+     /*  msk: N/A */
+     /*  value: the unit of delay, 0: us, 1: ms */
+
+#define PWR_CMD_END			0x04
+     /*  offset: N/A */
+     /*  msk: N/A */
+     /*  value: N/A */
+
+/*---------------------------------------------*/
+/* 3 The value of base: 4 bits */
+/*---------------------------------------------*/
+   /*  define the base address of each block */
+#define PWR_BASEADDR_MAC		0x00
+#define PWR_BASEADDR_USB		0x01
+#define PWR_BASEADDR_PCIE		0x02
+#define PWR_BASEADDR_SDIO		0x03
+
+/*---------------------------------------------*/
+/* 3 The value of interface_msk: 4 bits */
+/*---------------------------------------------*/
+#define	PWR_INTF_SDIO_MSK		BIT(0)
+#define	PWR_INTF_USB_MSK		BIT(1)
+#define	PWR_INTF_PCI_MSK		BIT(2)
+#define	PWR_INTF_ALL_MSK		(BIT(0)|BIT(1)|BIT(2)|BIT(3))
+
+/*---------------------------------------------*/
+/* 3 The value of fab_msk: 4 bits */
+/*---------------------------------------------*/
+#define	PWR_FAB_TSMC_MSK		BIT(0)
+#define	PWR_FAB_UMC_MSK			BIT(1)
+#define	PWR_FAB_ALL_MSK			(BIT(0)|BIT(1)|BIT(2)|BIT(3))
+
+/*---------------------------------------------*/
+/* 3 The value of cut_msk: 8 bits */
+/*---------------------------------------------*/
+#define	PWR_CUT_TESTCHIP_MSK		BIT(0)
+#define	PWR_CUT_A_MSK			BIT(1)
+#define	PWR_CUT_B_MSK			BIT(2)
+#define	PWR_CUT_C_MSK			BIT(3)
+#define	PWR_CUT_D_MSK			BIT(4)
+#define	PWR_CUT_E_MSK			BIT(5)
+#define	PWR_CUT_F_MSK			BIT(6)
+#define	PWR_CUT_G_MSK			BIT(7)
+#define	PWR_CUT_ALL_MSK			0xFF
+
+enum pwrseq_cmd_delat_unit {
+	PWRSEQ_DELAY_US,
+	PWRSEQ_DELAY_MS,
+};
+
+struct wl_pwr_cfg {
+	u16 offset;
+	u8 cut_msk;
+	u8 fab_msk:4;
+	u8 interface_msk:4;
+	u8 base:4;
+	u8 cmd:4;
+	u8 msk;
+	u8 value;
+};
+
+#define GET_PWR_CFG_OFFSET(__PWR_CMD)		__PWR_CMD.offset
+#define GET_PWR_CFG_CUT_MASK(__PWR_CMD)		__PWR_CMD.cut_msk
+#define GET_PWR_CFG_FAB_MASK(__PWR_CMD)		__PWR_CMD.fab_msk
+#define GET_PWR_CFG_INTF_MASK(__PWR_CMD)	__PWR_CMD.interface_msk
+#define GET_PWR_CFG_BASE(__PWR_CMD)		__PWR_CMD.base
+#define GET_PWR_CFG_CMD(__PWR_CMD)		__PWR_CMD.cmd
+#define GET_PWR_CFG_MASK(__PWR_CMD)		__PWR_CMD.msk
+#define GET_PWR_CFG_VALUE(__PWR_CMD)		__PWR_CMD.value
+
+/*	Prototype of protected function. */
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 CutVersion, u8 FabVersion,
+		       u8 InterfaceType, struct wl_pwr_cfg PwrCfgCmd[]);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
new file mode 100644
index 000000000000..2a7dc28b8de7
--- /dev/null
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -0,0 +1,166 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __HAL_VERSION_DEF_H__
+#define __HAL_VERSION_DEF_H__
+
+enum HAL_IC_TYPE {
+	CHIP_8192S	=	0,
+	CHIP_8188C	=	1,
+	CHIP_8192C	=	2,
+	CHIP_8192D	=	3,
+	CHIP_8723A	=	4,
+	CHIP_8188E	=	5,
+	CHIP_8881A	=	6,
+	CHIP_8812A	=	7,
+	CHIP_8821A	=	8,
+	CHIP_8723B	=	9,
+	CHIP_8192E	=	10,
+};
+
+enum HAL_CHIP_TYPE {
+	TEST_CHIP	=	0,
+	NORMAL_CHIP	=	1,
+	FPGA		=	2,
+};
+
+enum HAL_CUT_VERSION {
+	A_CUT_VERSION	=	0,
+	B_CUT_VERSION	=	1,
+	C_CUT_VERSION	=	2,
+	D_CUT_VERSION	=	3,
+	E_CUT_VERSION	=	4,
+	F_CUT_VERSION	=	5,
+	G_CUT_VERSION	=	6,
+};
+
+enum HAL_VENDOR {
+	CHIP_VENDOR_TSMC	=	0,
+	CHIP_VENDOR_UMC		=	1,
+};
+
+enum HAL_RF_TYPE {
+	RF_TYPE_1T1R	=	0,
+	RF_TYPE_1T2R	=	1,
+	RF_TYPE_2T2R	=	2,
+	RF_TYPE_2T3R	=	3,
+	RF_TYPE_2T4R	=	4,
+	RF_TYPE_3T3R	=	5,
+	RF_TYPE_3T4R	=	6,
+	RF_TYPE_4T4R	=	7,
+};
+
+struct HAL_VERSION {
+	enum HAL_IC_TYPE	ICType;
+	enum HAL_CHIP_TYPE	ChipType;
+	enum HAL_CUT_VERSION	CUTVersion;
+	enum HAL_VENDOR		VendorType;
+	enum HAL_RF_TYPE	RFType;
+	u8			ROMVer;
+};
+
+/*  Get element */
+#define GET_CVID_IC_TYPE(version)	(((version).ICType))
+#define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
+#define GET_CVID_RF_TYPE(version)	(((version).RFType))
+#define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
+#define GET_CVID_CUT_VERSION(version)	(((version).CUTVersion))
+#define GET_CVID_ROM_VERSION(version)	(((version).ROMVer) & ROM_VERSION_MASK)
+
+/* Common Macro. -- */
+/* HAL_VERSION VersionID */
+
+/*  HAL_IC_TYPE_E */
+#define IS_81XXC(version)				\
+	(((GET_CVID_IC_TYPE(version) == CHIP_8192C) ||	\
+	 (GET_CVID_IC_TYPE(version) == CHIP_8188C)) ? true : false)
+#define IS_8723_SERIES(version)				\
+	((GET_CVID_IC_TYPE(version) == CHIP_8723A) ? true : false)
+#define IS_92D(version)					\
+	((GET_CVID_IC_TYPE(version) == CHIP_8192D) ? true : false)
+#define IS_8188E(version)				\
+	((GET_CVID_IC_TYPE(version) == CHIP_8188E) ? true : false)
+
+/* HAL_CHIP_TYPE_E */
+#define IS_TEST_CHIP(version)				\
+	((GET_CVID_CHIP_TYPE(version) == TEST_CHIP) ? true : false)
+#define IS_NORMAL_CHIP(version)				\
+	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false)
+
+/* HAL_CUT_VERSION_E */
+#define IS_A_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == A_CUT_VERSION) ? true : false)
+#define IS_B_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == B_CUT_VERSION) ? true : false)
+#define IS_C_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == C_CUT_VERSION) ? true : false)
+#define IS_D_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == D_CUT_VERSION) ? true : false)
+#define IS_E_CUT(version)				\
+	((GET_CVID_CUT_VERSION(version) == E_CUT_VERSION) ? true : false)
+
+/* HAL_VENDOR_E */
+#define IS_CHIP_VENDOR_TSMC(version)			\
+	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC) ? true : false)
+#define IS_CHIP_VENDOR_UMC(version)			\
+	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_UMC) ? true : false)
+
+/* HAL_RF_TYPE_E */
+#define IS_1T1R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_1T1R) ? true : false)
+#define IS_1T2R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_1T2R) ? true : false)
+#define IS_2T2R(version)				\
+	((GET_CVID_RF_TYPE(version) == RF_TYPE_2T2R) ? true : false)
+
+/* Chip version Macro. -- */
+#define IS_81XXC_TEST_CHIP(version)			\
+	((IS_81XXC(version) && (!IS_NORMAL_CHIP(version))) ? true : false)
+
+#define IS_92C_SERIAL(version)				\
+	((IS_81XXC(version) && IS_2T2R(version)) ? true : false)
+#define IS_81xxC_VENDOR_UMC_A_CUT(version)		\
+	(IS_81XXC(version) ? (IS_CHIP_VENDOR_UMC(version) ?	\
+	(IS_A_CUT(version) ? true : false) : false) : false)
+#define IS_81xxC_VENDOR_UMC_B_CUT(version)		\
+	(IS_81XXC(version) ? (IS_CHIP_VENDOR_UMC(version) ?	\
+	(IS_B_CUT(version) ? true : false) : false) : false)
+#define IS_81xxC_VENDOR_UMC_C_CUT(version)		\
+	(IS_81XXC(version) ? (IS_CHIP_VENDOR_UMC(version) ? \
+	 (IS_C_CUT(version) ? true : false) : false) : false)
+
+#define IS_NORMAL_CHIP92D(version)			\
+	((IS_92D(version)) ?				\
+	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false) : false)
+
+#define IS_92D_SINGLEPHY(version)			\
+	((IS_92D(version)) ? (IS_2T2R(version) ? true : false) : false)
+#define IS_92D_C_CUT(version)				\
+	((IS_92D(version)) ? (IS_C_CUT(version) ? true : false) : false)
+#define IS_92D_D_CUT(version)				\
+	((IS_92D(version)) ? (IS_D_CUT(version) ? true : false) : false)
+#define IS_92D_E_CUT(version)				\
+	((IS_92D(version)) ? (IS_E_CUT(version) ? true : false) : false)
+
+#define IS_8723A_A_CUT(version)				\
+	((IS_8723_SERIES(version)) ? (IS_A_CUT(version) ? true : false) : false)
+#define IS_8723A_B_CUT(version)				\
+	((IS_8723_SERIES(version)) ? (IS_B_CUT(version) ? true : false) : false)
+
+#endif
diff --git a/drivers/staging/r8188eu/include/autoconf.h b/drivers/staging/r8188eu/include/autoconf.h
new file mode 100644
index 000000000000..cfa790794fd3
--- /dev/null
+++ b/drivers/staging/r8188eu/include/autoconf.h
@@ -0,0 +1,43 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+/*  temporarily flag ******* */
+/*
+ * Public  General Config
+ */
+#define RTL871X_MODULE_NAME "88EU"
+#define DRV_NAME "rtl8188eu"
+
+/*
+ * Internal  General Config
+ */
+
+#define CONFIG_AP_MODE
+
+#define CONFIG_P2P
+
+#define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
+
+#define CONFIG_BR_EXT_BRNAME	"br0"
+
+/*
+ * Debug Related Config
+ */
+#define DBG	1
diff --git a/drivers/staging/r8188eu/include/basic_types.h b/drivers/staging/r8188eu/include/basic_types.h
new file mode 100644
index 000000000000..8a7ca992674a
--- /dev/null
+++ b/drivers/staging/r8188eu/include/basic_types.h
@@ -0,0 +1,184 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __BASIC_TYPES_H__
+#define __BASIC_TYPES_H__
+
+#define SUCCESS	0
+#define FAIL	(-1)
+
+#include <linux/types.h>
+#define NDIS_OID uint
+
+typedef void (*proc_t)(void *);
+
+#define FIELD_OFFSET(s, field)	((ssize_t)&((s *)(0))->field)
+
+#define MEM_ALIGNMENT_OFFSET	(sizeof(size_t))
+#define MEM_ALIGNMENT_PADDING	(sizeof(size_t) - 1)
+
+/* port from fw */
+/*  TODO: Macros Below are Sync from SD7-Driver. It is necessary
+ * to check correctness */
+
+/*
+ *	Call endian free function when
+ *		1. Read/write packet content.
+ *		2. Before write integer to IO.
+ *		3. After read integer from IO.
+*/
+
+/* Convert little data endian to host ordering */
+#define EF1BYTE(_val)		\
+	((u8)(_val))
+#define EF2BYTE(_val)		\
+	(le16_to_cpu(_val))
+#define EF4BYTE(_val)		\
+	(le32_to_cpu(_val))
+
+/* Read data from memory */
+#define READEF1BYTE(_ptr)	\
+	EF1BYTE(*((u8 *)(_ptr)))
+/* Read le16 data from memory and convert to host ordering */
+#define READEF2BYTE(_ptr)	\
+	EF2BYTE(*(_ptr))
+#define READEF4BYTE(_ptr)	\
+	EF4BYTE(*(_ptr))
+
+/* Write data to memory */
+#define WRITEEF1BYTE(_ptr, _val)			\
+	do {						\
+		(*((u8 *)(_ptr))) = EF1BYTE(_val)	\
+	} while (0)
+/* Write le data to memory in host ordering */
+#define WRITEEF2BYTE(_ptr, _val)			\
+	do {						\
+		(*((u16 *)(_ptr))) = EF2BYTE(_val)	\
+	} while (0)
+
+#define WRITEEF4BYTE(_ptr, _val)			\
+	do {						\
+		(*((u32 *)(_ptr))) = EF2BYTE(_val)	\
+	} while (0)
+
+/* Create a bit mask
+ * Examples:
+ * BIT_LEN_MASK_32(0) => 0x00000000
+ * BIT_LEN_MASK_32(1) => 0x00000001
+ * BIT_LEN_MASK_32(2) => 0x00000003
+ * BIT_LEN_MASK_32(32) => 0xFFFFFFFF
+ */
+#define BIT_LEN_MASK_32(__bitlen)	 \
+	(0xFFFFFFFF >> (32 - (__bitlen)))
+#define BIT_LEN_MASK_16(__bitlen)	 \
+	(0xFFFF >> (16 - (__bitlen)))
+#define BIT_LEN_MASK_8(__bitlen) \
+	(0xFF >> (8 - (__bitlen)))
+
+/* Create an offset bit mask
+ * Examples:
+ * BIT_OFFSET_LEN_MASK_32(0, 2) => 0x00000003
+ * BIT_OFFSET_LEN_MASK_32(16, 2) => 0x00030000
+ */
+#define BIT_OFFSET_LEN_MASK_32(__bitoffset, __bitlen) \
+	(BIT_LEN_MASK_32(__bitlen) << (__bitoffset))
+#define BIT_OFFSET_LEN_MASK_16(__bitoffset, __bitlen) \
+	(BIT_LEN_MASK_16(__bitlen) << (__bitoffset))
+#define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
+	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
+
+/*Description:
+ * Return 4-byte value in host byte ordering from
+ * 4-byte pointer in little-endian system.
+ */
+#define LE_P4BYTE_TO_HOST_4BYTE(__pstart) \
+	(EF4BYTE(*((__le32 *)(__pstart))))
+#define LE_P2BYTE_TO_HOST_2BYTE(__pstart) \
+	(EF2BYTE(*((__le16 *)(__pstart))))
+#define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
+	(EF1BYTE(*((u8 *)(__pstart))))
+
+/*Description:
+Translate subfield (continuous bits in little-endian) of 4-byte
+value to host byte ordering.*/
+#define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
+	( \
+		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
+		BIT_LEN_MASK_32(__bitlen) \
+	)
+#define LE_BITS_TO_2BYTE(__pstart, __bitoffset, __bitlen) \
+	( \
+		(LE_P2BYTE_TO_HOST_2BYTE(__pstart) >> (__bitoffset)) & \
+		BIT_LEN_MASK_16(__bitlen) \
+	)
+#define LE_BITS_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
+	( \
+		(LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
+		BIT_LEN_MASK_8(__bitlen) \
+	)
+
+/* Description:
+ * Mask subfield (continuous bits in little-endian) of 4-byte value
+ * and return the result in 4-byte value in host byte ordering.
+ */
+#define LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
+	( \
+		LE_P4BYTE_TO_HOST_4BYTE(__pstart)  & \
+		(~BIT_OFFSET_LEN_MASK_32(__bitoffset, __bitlen)) \
+	)
+#define LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) \
+	( \
+		LE_P2BYTE_TO_HOST_2BYTE(__pstart) & \
+		(~BIT_OFFSET_LEN_MASK_16(__bitoffset, __bitlen)) \
+	)
+#define LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
+	( \
+		LE_P1BYTE_TO_HOST_1BYTE(__pstart) & \
+		(~BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen)) \
+	)
+
+/* Description:
+ * Set subfield of little-endian 4-byte value to specified value.
+ */
+#define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
+		*((u32 *)(__pstart)) =				\
+		(							\
+		LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
+		((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
+		)
+
+#define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
+		*((u16 *)(__pstart)) =				\
+		(						\
+		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
+		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
+		);
+
+#define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
+		*((u8 *)(__pstart)) = EF1BYTE			\
+		(						\
+		LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) | \
+		((((u8)__val) & BIT_LEN_MASK_8(__bitlen)) << (__bitoffset)) \
+		)
+
+/*  Get the N-bytes aligment offset from the current length */
+#define	N_BYTE_ALIGMENT(__value, __aligment) ((__aligment == 1) ? \
+	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
+
+#endif /* __BASIC_TYPES_H__ */
diff --git a/drivers/staging/r8188eu/include/cmd_osdep.h b/drivers/staging/r8188eu/include/cmd_osdep.h
new file mode 100644
index 000000000000..5a8465e147b3
--- /dev/null
+++ b/drivers/staging/r8188eu/include/cmd_osdep.h
@@ -0,0 +1,32 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __CMD_OSDEP_H_
+#define __CMD_OSDEP_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+extern int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
+extern int _rtw_init_evt_priv(struct evt_priv *pevtpriv);
+extern void _rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
+extern int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj);
+extern struct cmd_obj	*_rtw_dequeue_cmd(struct __queue *queue);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
new file mode 100644
index 000000000000..9aa72a91d467
--- /dev/null
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -0,0 +1,346 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+/*-----------------------------------------------------------------------------
+
+	For type defines and data structure defines
+
+------------------------------------------------------------------------------*/
+
+#ifndef __DRV_TYPES_H__
+#define __DRV_TYPES_H__
+
+#define DRV_NAME "r8188eu"
+#define CONFIG_88EU_AP_MODE 1
+#define CONFIG_88EU_P2P 1
+
+#include <osdep_service.h>
+#include <wlan_bssdef.h>
+#include <drv_types_linux.h>
+#include <rtw_ht.h>
+#include <rtw_cmd.h>
+#include <rtw_xmit.h>
+#include <rtw_recv.h>
+#include <hal_intf.h>
+#include <hal_com.h>
+#include <rtw_qos.h>
+#include <rtw_security.h>
+#include <rtw_pwrctrl.h>
+#include <rtw_io.h>
+#include <rtw_eeprom.h>
+#include <sta_info.h>
+#include <rtw_mlme.h>
+#include <rtw_debug.h>
+#include <rtw_rf.h>
+#include <rtw_event.h>
+#include <rtw_led.h>
+#include <rtw_mlme_ext.h>
+#include <rtw_p2p.h>
+#include <rtw_ap.h>
+#include <rtw_mp.h>
+#include <rtw_br_ext.h>
+
+enum _NIC_VERSION {
+	RTL8711_NIC,
+	RTL8712_NIC,
+	RTL8713_NIC,
+	RTL8716_NIC
+};
+
+#define SPEC_DEV_ID_NONE		BIT(0)
+#define SPEC_DEV_ID_DISABLE_HT		BIT(1)
+#define SPEC_DEV_ID_ENABLE_PS		BIT(2)
+#define SPEC_DEV_ID_RF_CONFIG_1T1R	BIT(3)
+#define SPEC_DEV_ID_RF_CONFIG_2T2R	BIT(4)
+#define SPEC_DEV_ID_ASSIGN_IFNAME	BIT(5)
+
+struct specific_device_id {
+	u32		flags;
+	u16		idVendor;
+	u16		idProduct;
+};
+
+struct registry_priv {
+	u8	chip_version;
+	u8	rfintfs;
+	u8	lbkmode;
+	u8	hci;
+	struct ndis_802_11_ssid	ssid;
+	u8	network_mode;	/* infra, ad-hoc, auto */
+	u8	channel;/* ad-hoc support requirement */
+	u8	wireless_mode;/* A, B, G, auto */
+	u8	scan_mode;/* active, passive */
+	u8	radio_enable;
+	u8	preamble;/* long, short, auto */
+	u8	vrtl_carrier_sense;/* Enable, Disable, Auto */
+	u8	vcs_type;/* RTS/CTS, CTS-to-self */
+	u16	rts_thresh;
+	u16	frag_thresh;
+	u8	adhoc_tx_pwr;
+	u8	soft_ap;
+	u8	power_mgnt;
+	u8	ips_mode;
+	u8	smart_ps;
+	u8	long_retry_lmt;
+	u8	short_retry_lmt;
+	u16	busy_thresh;
+	u8	ack_policy;
+	u8	mp_mode;
+	u8	software_encrypt;
+	u8	software_decrypt;
+	u8	acm_method;
+	  /* UAPSD */
+	u8	wmm_enable;
+	u8	uapsd_enable;
+	u8	uapsd_max_sp;
+	u8	uapsd_acbk_en;
+	u8	uapsd_acbe_en;
+	u8	uapsd_acvi_en;
+	u8	uapsd_acvo_en;
+
+	u8	led_enable;
+
+	struct wlan_bssid_ex    dev_network;
+
+	u8	ht_enable;
+	u8	cbw40_enable;
+	u8	ampdu_enable;/* for tx */
+	u8	rx_stbc;
+	u8	ampdu_amsdu;/* A-MPDU Supports A-MSDU is permitted */
+	u8	lowrate_two_xmit;
+
+	u8	rf_config;
+	u8	low_power;
+
+	u8	wifi_spec;/*  !turbo_mode */
+
+	u8	channel_plan;
+	bool	bAcceptAddbaReq;
+
+	u8	antdiv_cfg;
+	u8	antdiv_type;
+
+	u8	usbss_enable;/* 0:disable,1:enable */
+	u8	hwpdn_mode;/* 0:disable,1:enable,2:decide by EFUSE config */
+	u8	hwpwrp_detect;/* 0:disable,1:enable */
+
+	u8	hw_wps_pbc;/* 0:disable,1:enable */
+
+	u8	max_roaming_times; /*  the max number driver will try */
+
+	u8	fw_iol; /* enable iol without other concern */
+
+	u8	enable80211d;
+
+	u8	ifname[16];
+	u8	if2name[16];
+
+	u8	notch_filter;
+};
+
+/* For registry parameters */
+#define RGTRY_OFT(field) ((u32)FIELD_OFFSET(struct registry_priv, field))
+#define RGTRY_SZ(field)   sizeof(((struct registry_priv *)0)->field)
+#define BSSID_OFT(field) ((u32)FIELD_OFFSET(struct wlan_bssid_ex, field))
+#define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *)0)->field)
+
+#define MAX_CONTINUAL_URB_ERR		4
+
+struct rt_firmware {
+	u8			*szFwBuffer;
+	u32			ulFwLength;
+};
+
+struct dvobj_priv {
+	struct adapter *if1;
+	struct adapter *if2;
+
+	/* For 92D, DMDP have 2 interface. */
+	u8	InterfaceNumber;
+	u8	NumInterfaces;
+
+	/* In /Out Pipe information */
+	int	RtInPipe[2];
+	int	RtOutPipe[3];
+	u8	Queue2Pipe[HW_QUEUE_ENTRY];/* for out pipe mapping */
+
+	u8	irq_alloc;
+
+	struct rt_firmware firmware;
+
+/*-------- below is for USB INTERFACE --------*/
+
+	u8	nr_endpoint;
+	u8	ishighspeed;
+	u8	RtNumInPipes;
+	u8	RtNumOutPipes;
+	int	ep_num[5]; /* endpoint number */
+	int	RegUsbSS;
+	struct semaphore usb_suspend_sema;
+	struct mutex  usb_vendor_req_mutex;
+
+	u8 *usb_alloc_vendor_req_buf;
+	u8 *usb_vendor_req_buf;
+
+	struct usb_interface *pusbintf;
+	struct usb_device *pusbdev;
+
+	ATOMIC_T continual_urb_error;
+	u8 signal_strength;
+};
+
+static inline struct device *dvobj_to_dev(struct dvobj_priv *dvobj)
+{
+	/* todo: get interface type from dvobj and the return
+	 * the dev accordingly */
+	return &dvobj->pusbintf->dev;
+};
+
+enum _IFACE_TYPE {
+	IFACE_PORT0, /* mapping to port0 for C/D series chips */
+	IFACE_PORT1, /* mapping to port1 for C/D series chip */
+	MAX_IFACE_PORT,
+};
+
+enum _ADAPTER_TYPE {
+	PRIMARY_ADAPTER,
+	SECONDARY_ADAPTER,
+	MAX_ADAPTER,
+};
+
+enum driver_state {
+	DRIVER_NORMAL = 0,
+	DRIVER_DISAPPEAR = 1,
+	DRIVER_REPLACE_DONGLE = 2,
+};
+
+struct adapter {
+	int	DriverState;/* for disable driver using module, use dongle toi
+			     * replace module. */
+	int	pid[3];/* process id from UI, 0:wps, 1:hostapd, 2:dhcpcd */
+	int	bDongle;/* build-in module or external dongle */
+	u16	chip_type;
+	u16	HardwareType;
+	u16	interface_type;/* USB,SDIO,SPI,PCI */
+
+	struct dvobj_priv *dvobj;
+	struct	mlme_priv mlmepriv;
+	struct	mlme_ext_priv mlmeextpriv;
+	struct	cmd_priv	cmdpriv;
+	struct	evt_priv	evtpriv;
+	struct	io_priv	iopriv;
+	struct	xmit_priv	xmitpriv;
+	struct	recv_priv	recvpriv;
+	struct	sta_priv	stapriv;
+	struct	security_priv	securitypriv;
+	struct	registry_priv	registrypriv;
+	struct	pwrctrl_priv	pwrctrlpriv;
+	struct	eeprom_priv eeprompriv;
+	struct	led_priv	ledpriv;
+	struct	mp_priv	mppriv;
+
+#ifdef CONFIG_88EU_AP_MODE
+	struct	hostapd_priv	*phostapdpriv;
+#endif
+
+	struct wifidirect_info	wdinfo;
+
+	void *HalData;
+	u32 hal_data_sz;
+	struct hal_ops	HalFunc;
+
+	s32	bDriverStopped;
+	s32	bSurpriseRemoved;
+	s32	bCardDisableWOHSM;
+
+	u32	IsrContent;
+	u32	ImrContent;
+
+	u8	EepromAddressSize;
+	u8	hw_init_completed;
+	u8	bDriverIsGoingToUnload;
+	u8	init_adpt_in_progress;
+	u8	bHaltInProgress;
+	s8	signal_strength;
+
+	void *cmdThread;
+	void *evtThread;
+	void *xmitThread;
+	void *recvThread;
+	void (*intf_start)(struct adapter *adapter);
+	void (*intf_stop)(struct adapter *adapter);
+	struct  net_device *pnetdev;
+
+	/*  used by rtw_rereg_nd_name related function */
+	struct rereg_nd_name_data {
+		struct  net_device *old_pnetdev;
+		char old_ifname[IFNAMSIZ];
+		u8 old_ips_mode;
+		u8 old_bRegUseLed;
+	} rereg_nd_name_priv;
+
+	int bup;
+	struct net_device_stats stats;
+	struct iw_statistics iwstats;
+	struct proc_dir_entry *dir_dev;/*  for proc directory */
+
+	int net_closed;
+	u8 bFWReady;
+	u8 bBTFWReady;
+	u8 bReadPortCancel;
+	u8 bWritePortCancel;
+	u8 bRxRSSIDisplay;
+	/* The driver will show up the desired channel number
+	 * when this flag is 1. */
+	u8 bNotifyChannelChange;
+#ifdef CONFIG_88EU_P2P
+	/* The driver will show the current P2P status when the
+	 * upper application reads it. */
+	u8 bShowGetP2PState;
+#endif
+	struct adapter *pbuddy_adapter;
+
+	struct mutex *hw_init_mutex;
+
+	spinlock_t br_ext_lock;
+	struct nat25_network_db_entry	*nethash[NAT25_HASH_SIZE];
+	int				pppoe_connection_in_progress;
+	unsigned char			pppoe_addr[MACADDRLEN];
+	unsigned char			scdb_mac[MACADDRLEN];
+	unsigned char			scdb_ip[4];
+	struct nat25_network_db_entry	*scdb_entry;
+	unsigned char			br_mac[MACADDRLEN];
+	unsigned char			br_ip[4];
+	struct br_ext_info		ethBrExtInfo;
+
+	u8	fix_rate;
+
+	unsigned char     in_cta_test;
+};
+
+#define adapter_to_dvobj(adapter) (adapter->dvobj)
+
+int rtw_handle_dualmac(struct adapter *adapter, bool init);
+
+static inline u8 *myid(struct eeprom_priv *peepriv)
+{
+	return peepriv->mac_addr;
+}
+
+#endif /* __DRV_TYPES_H__ */
diff --git a/drivers/staging/r8188eu/include/drv_types_linux.h b/drivers/staging/r8188eu/include/drv_types_linux.h
new file mode 100644
index 000000000000..f5db1dd14317
--- /dev/null
+++ b/drivers/staging/r8188eu/include/drv_types_linux.h
@@ -0,0 +1,23 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __DRV_TYPES_LINUX_H__
+#define __DRV_TYPES_LINUX_H__
+
+#endif
diff --git a/drivers/staging/r8188eu/include/ethernet.h b/drivers/staging/r8188eu/include/ethernet.h
new file mode 100644
index 000000000000..5b17dcf143a4
--- /dev/null
+++ b/drivers/staging/r8188eu/include/ethernet.h
@@ -0,0 +1,41 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+/*! \file */
+#ifndef __INC_ETHERNET_H
+#define __INC_ETHERNET_H
+
+#define ETHERNET_ADDRESS_LENGTH		6	/*  Ethernet Address Length */
+#define ETHERNET_HEADER_SIZE		14	/*  Ethernet Header Length */
+#define LLC_HEADER_SIZE			6	/*  LLC Header Length */
+#define TYPE_LENGTH_FIELD_SIZE		2	/*  Type/Length Size */
+#define MINIMUM_ETHERNET_PACKET_SIZE	60	/*  Min Ethernet Packet Size */
+#define MAXIMUM_ETHERNET_PACKET_SIZE	1514	/*  Max Ethernet Packet Size */
+
+/*  Is Multicast Address? */
+#define RT_ETH_IS_MULTICAST(_addr)	((((u8 *)(_addr))[0]&0x01) != 0)
+#define RT_ETH_IS_BROADCAST(_addr)	(			\
+		((u8 *)(_addr))[0] == 0xff &&		\
+		((u8 *)(_addr))[1] == 0xff &&		\
+		((u8 *)(_addr))[2] == 0xff &&		\
+		((u8 *)(_addr))[3] == 0xff &&		\
+		((u8 *)(_addr))[4] == 0xff &&		\
+		((u8 *)(_addr))[5] == 0xff)	/*  Is Broadcast Address? */
+
+#endif /*  #ifndef __INC_ETHERNET_H */
diff --git a/drivers/staging/r8188eu/include/h2clbk.h b/drivers/staging/r8188eu/include/h2clbk.h
new file mode 100644
index 000000000000..72b67827bc6e
--- /dev/null
+++ b/drivers/staging/r8188eu/include/h2clbk.h
@@ -0,0 +1,32 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#define _H2CLBK_H_
+
+#include <rtl8711_spec.h>
+#include <TypeDef.h>
+
+void _lbk_cmd(struct adapter *adapter);
+
+void _lbk_rsp(struct adapter *adapter);
+
+void _lbk_evt(IN struct adapter *adapter);
+
+void h2c_event_callback(unsigned char *dev, unsigned char *pbuf);
diff --git a/drivers/staging/r8188eu/include/hal_com.h b/drivers/staging/r8188eu/include/hal_com.h
new file mode 100644
index 000000000000..652f645d54ff
--- /dev/null
+++ b/drivers/staging/r8188eu/include/hal_com.h
@@ -0,0 +1,172 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __HAL_COMMON_H__
+#define __HAL_COMMON_H__
+
+/*  */
+/*        Rate Definition */
+/*  */
+/* CCK */
+#define	RATR_1M					0x00000001
+#define	RATR_2M					0x00000002
+#define	RATR_55M				0x00000004
+#define	RATR_11M				0x00000008
+/* OFDM */
+#define	RATR_6M					0x00000010
+#define	RATR_9M					0x00000020
+#define	RATR_12M				0x00000040
+#define	RATR_18M				0x00000080
+#define	RATR_24M				0x00000100
+#define	RATR_36M				0x00000200
+#define	RATR_48M				0x00000400
+#define	RATR_54M				0x00000800
+/* MCS 1 Spatial Stream */
+#define	RATR_MCS0				0x00001000
+#define	RATR_MCS1				0x00002000
+#define	RATR_MCS2				0x00004000
+#define	RATR_MCS3				0x00008000
+#define	RATR_MCS4				0x00010000
+#define	RATR_MCS5				0x00020000
+#define	RATR_MCS6				0x00040000
+#define	RATR_MCS7				0x00080000
+/* MCS 2 Spatial Stream */
+#define	RATR_MCS8				0x00100000
+#define	RATR_MCS9				0x00200000
+#define	RATR_MCS10				0x00400000
+#define	RATR_MCS11				0x00800000
+#define	RATR_MCS12				0x01000000
+#define	RATR_MCS13				0x02000000
+#define	RATR_MCS14				0x04000000
+#define	RATR_MCS15				0x08000000
+
+/* CCK */
+#define RATE_1M					BIT(0)
+#define RATE_2M					BIT(1)
+#define RATE_5_5M				BIT(2)
+#define RATE_11M				BIT(3)
+/* OFDM */
+#define RATE_6M					BIT(4)
+#define RATE_9M					BIT(5)
+#define RATE_12M				BIT(6)
+#define RATE_18M				BIT(7)
+#define RATE_24M				BIT(8)
+#define RATE_36M				BIT(9)
+#define RATE_48M				BIT(10)
+#define RATE_54M				BIT(11)
+/* MCS 1 Spatial Stream */
+#define RATE_MCS0				BIT(12)
+#define RATE_MCS1				BIT(13)
+#define RATE_MCS2				BIT(14)
+#define RATE_MCS3				BIT(15)
+#define RATE_MCS4				BIT(16)
+#define RATE_MCS5				BIT(17)
+#define RATE_MCS6				BIT(18)
+#define RATE_MCS7				BIT(19)
+/* MCS 2 Spatial Stream */
+#define RATE_MCS8				BIT(20)
+#define RATE_MCS9				BIT(21)
+#define RATE_MCS10				BIT(22)
+#define RATE_MCS11				BIT(23)
+#define RATE_MCS12				BIT(24)
+#define RATE_MCS13				BIT(25)
+#define RATE_MCS14				BIT(26)
+#define RATE_MCS15				BIT(27)
+
+/*  ALL CCK Rate */
+#define	RATE_ALL_CCK		(RATR_1M | RATR_2M | RATR_55M | RATR_11M)
+#define	RATE_ALL_OFDM_AG	(RATR_6M | RATR_9M | RATR_12M | RATR_18M | \
+				 RATR_24M | RATR_36M | RATR_48M | RATR_54M)
+#define	RATE_ALL_OFDM_1SS	(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 |	\
+				 RATR_MCS3 | RATR_MCS4 | RATR_MCS5|RATR_MCS6 | \
+				 RATR_MCS7)
+#define	RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | \
+				 RATR_MCS11 | RATR_MCS12 | RATR_MCS13 | \
+				 RATR_MCS14 | RATR_MCS15)
+
+/*------------------------------ Tx Desc definition Macro --------------------*/
+/* pragma mark -- Tx Desc related definition. -- */
+/*	Rate */
+/*  CCK Rates, TxHT = 0 */
+#define DESC_RATE1M				0x00
+#define DESC_RATE2M				0x01
+#define DESC_RATE5_5M				0x02
+#define DESC_RATE11M				0x03
+
+/*  OFDM Rates, TxHT = 0 */
+#define DESC_RATE6M				0x04
+#define DESC_RATE9M				0x05
+#define DESC_RATE12M				0x06
+#define DESC_RATE18M				0x07
+#define DESC_RATE24M				0x08
+#define DESC_RATE36M				0x09
+#define DESC_RATE48M				0x0a
+#define DESC_RATE54M				0x0b
+
+/*  MCS Rates, TxHT = 1 */
+#define DESC_RATEMCS0				0x0c
+#define DESC_RATEMCS1				0x0d
+#define DESC_RATEMCS2				0x0e
+#define DESC_RATEMCS3				0x0f
+#define DESC_RATEMCS4				0x10
+#define DESC_RATEMCS5				0x11
+#define DESC_RATEMCS6				0x12
+#define DESC_RATEMCS7				0x13
+#define DESC_RATEMCS8				0x14
+#define DESC_RATEMCS9				0x15
+#define DESC_RATEMCS10				0x16
+#define DESC_RATEMCS11				0x17
+#define DESC_RATEMCS12				0x18
+#define DESC_RATEMCS13				0x19
+#define DESC_RATEMCS14				0x1a
+#define DESC_RATEMCS15				0x1b
+#define DESC_RATEMCS15_SG			0x1c
+#define DESC_RATEMCS32				0x20
+
+/*  1 Byte long (in unit of TU) */
+#define REG_P2P_CTWIN				0x0572
+#define REG_NOA_DESC_SEL			0x05CF
+#define REG_NOA_DESC_DURATION			0x05E0
+#define REG_NOA_DESC_INTERVAL			0x05E4
+#define REG_NOA_DESC_START			0x05E8
+#define REG_NOA_DESC_COUNT			0x05EC
+
+#include "HalVerDef.h"
+void dump_chip_info(struct HAL_VERSION	ChipVersion);
+
+/* return the final channel plan decision */
+u8 hal_com_get_channel_plan(struct adapter *padapter,
+			    u8 hw_channel_plan,
+			    u8 sw_channel_plan,
+			    u8 def_channel_plan,
+			    bool AutoLoadFail
+);
+
+u8 MRateToHwRate(u8 rate);
+
+void HalSetBrateCfg(struct adapter *Adapter, u8 *mBratesOS, u16 *pBrateCfg);
+
+bool Hal_MappingOutPipe(struct adapter *pAdapter, u8 NumOutPipe);
+
+void hal_init_macaddr(struct adapter *adapter);
+
+void c2h_evt_clear(struct adapter *adapter);
+s32 c2h_evt_read(struct adapter *adapter, u8 *buf);
+
+#endif /* __HAL_COMMON_H__ */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
new file mode 100644
index 000000000000..49539b862863
--- /dev/null
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -0,0 +1,430 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __HAL_INTF_H__
+#define __HAL_INTF_H__
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <Hal8188EPhyCfg.h>
+
+enum RTL871X_HCI_TYPE {
+	RTW_PCIE	= BIT0,
+	RTW_USB		= BIT1,
+	RTW_SDIO	= BIT2,
+	RTW_GSPI	= BIT3,
+};
+
+enum _CHIP_TYPE {
+	NULL_CHIP_TYPE,
+	RTL8712_8188S_8191S_8192S,
+	RTL8188C_8192C,
+	RTL8192D,
+	RTL8723A,
+	RTL8188E,
+	MAX_CHIP_TYPE
+};
+
+enum hw_variables {
+	HW_VAR_MEDIA_STATUS,
+	HW_VAR_MEDIA_STATUS1,
+	HW_VAR_SET_OPMODE,
+	HW_VAR_MAC_ADDR,
+	HW_VAR_BSSID,
+	HW_VAR_INIT_RTS_RATE,
+	HW_VAR_BASIC_RATE,
+	HW_VAR_TXPAUSE,
+	HW_VAR_BCN_FUNC,
+	HW_VAR_CORRECT_TSF,
+	HW_VAR_CHECK_BSSID,
+	HW_VAR_MLME_DISCONNECT,
+	HW_VAR_MLME_SITESURVEY,
+	HW_VAR_MLME_JOIN,
+	HW_VAR_BEACON_INTERVAL,
+	HW_VAR_SLOT_TIME,
+	HW_VAR_RESP_SIFS,
+	HW_VAR_ACK_PREAMBLE,
+	HW_VAR_SEC_CFG,
+	HW_VAR_BCN_VALID,
+	HW_VAR_RF_TYPE,
+	HW_VAR_DM_FLAG,
+	HW_VAR_DM_FUNC_OP,
+	HW_VAR_DM_FUNC_SET,
+	HW_VAR_DM_FUNC_CLR,
+	HW_VAR_CAM_EMPTY_ENTRY,
+	HW_VAR_CAM_INVALID_ALL,
+	HW_VAR_CAM_WRITE,
+	HW_VAR_CAM_READ,
+	HW_VAR_AC_PARAM_VO,
+	HW_VAR_AC_PARAM_VI,
+	HW_VAR_AC_PARAM_BE,
+	HW_VAR_AC_PARAM_BK,
+	HW_VAR_ACM_CTRL,
+	HW_VAR_AMPDU_MIN_SPACE,
+	HW_VAR_AMPDU_FACTOR,
+	HW_VAR_RXDMA_AGG_PG_TH,
+	HW_VAR_SET_RPWM,
+	HW_VAR_H2C_FW_PWRMODE,
+	HW_VAR_H2C_FW_JOINBSSRPT,
+	HW_VAR_FWLPS_RF_ON,
+	HW_VAR_H2C_FW_P2P_PS_OFFLOAD,
+	HW_VAR_TDLS_WRCR,
+	HW_VAR_TDLS_INIT_CH_SEN,
+	HW_VAR_TDLS_RS_RCR,
+	HW_VAR_TDLS_DONE_CH_SEN,
+	HW_VAR_INITIAL_GAIN,
+	HW_VAR_TRIGGER_GPIO_0,
+	HW_VAR_BT_SET_COEXIST,
+	HW_VAR_BT_ISSUE_DELBA,
+	HW_VAR_CURRENT_ANTENNA,
+	HW_VAR_ANTENNA_DIVERSITY_LINK,
+	HW_VAR_ANTENNA_DIVERSITY_SELECT,
+	HW_VAR_SWITCH_EPHY_WoWLAN,
+	HW_VAR_EFUSE_USAGE,
+	HW_VAR_EFUSE_BYTES,
+	HW_VAR_EFUSE_BT_USAGE,
+	HW_VAR_EFUSE_BT_BYTES,
+	HW_VAR_FIFO_CLEARN_UP,
+	HW_VAR_CHECK_TXBUF,
+	HW_VAR_APFM_ON_MAC, /* Auto FSM to Turn On, include clock, isolation,
+			     * power control for MAC only */
+	/*  The valid upper nav range for the HW updating, if the true value is
+	 *  larger than the upper range, the HW won't update it. */
+	/*  Unit in microsecond. 0 means disable this function. */
+	HW_VAR_NAV_UPPER,
+	HW_VAR_RPT_TIMER_SETTING,
+	HW_VAR_TX_RPT_MAX_MACID,
+	HW_VAR_H2C_MEDIA_STATUS_RPT,
+	HW_VAR_CHK_HI_QUEUE_EMPTY,
+};
+
+enum hal_def_variable {
+	HAL_DEF_UNDERCORATEDSMOOTHEDPWDB,
+	HAL_DEF_IS_SUPPORT_ANT_DIV,
+	HAL_DEF_CURRENT_ANTENNA,
+	HAL_DEF_DRVINFO_SZ,
+	HAL_DEF_MAX_RECVBUF_SZ,
+	HAL_DEF_RX_PACKET_OFFSET,
+	HAL_DEF_DBG_DUMP_RXPKT,/* for dbg */
+	HAL_DEF_DBG_DM_FUNC,/* for dbg */
+	HAL_DEF_RA_DECISION_RATE,
+	HAL_DEF_RA_SGI,
+	HAL_DEF_PT_PWR_STATUS,
+	HW_VAR_MAX_RX_AMPDU_FACTOR,
+	HW_DEF_RA_INFO_DUMP,
+	HAL_DEF_DBG_DUMP_TXPKT,
+	HW_DEF_FA_CNT_DUMP,
+	HW_DEF_ODM_DBG_FLAG,
+};
+
+enum hal_odm_variable {
+	HAL_ODM_STA_INFO,
+	HAL_ODM_P2P_STATE,
+	HAL_ODM_WIFI_DISPLAY_STATE,
+};
+
+enum hal_intf_ps_func {
+	HAL_USB_SELECT_SUSPEND,
+	HAL_MAX_ID,
+};
+
+typedef s32 (*c2h_id_filter)(u8 id);
+
+struct hal_ops {
+	u32	(*hal_power_on)(struct adapter *padapter);
+	u32	(*hal_init)(struct adapter *padapter);
+	u32	(*hal_deinit)(struct adapter *padapter);
+
+	void	(*free_hal_data)(struct adapter *padapter);
+
+	u32	(*inirp_init)(struct adapter *padapter);
+	u32	(*inirp_deinit)(struct adapter *padapter);
+
+	s32	(*init_xmit_priv)(struct adapter *padapter);
+	void	(*free_xmit_priv)(struct adapter *padapter);
+
+	s32	(*init_recv_priv)(struct adapter *padapter);
+	void	(*free_recv_priv)(struct adapter *padapter);
+
+	void	(*InitSwLeds)(struct adapter *padapter);
+	void	(*DeInitSwLeds)(struct adapter *padapter);
+
+	void	(*dm_init)(struct adapter *padapter);
+	void	(*dm_deinit)(struct adapter *padapter);
+	void	(*read_chip_version)(struct adapter *padapter);
+
+	void	(*init_default_value)(struct adapter *padapter);
+
+	void	(*intf_chip_configure)(struct adapter *padapter);
+
+	void	(*read_adapter_info)(struct adapter *padapter);
+
+	void	(*enable_interrupt)(struct adapter *padapter);
+	void	(*disable_interrupt)(struct adapter *padapter);
+	s32	(*interrupt_handler)(struct adapter *padapter);
+
+	void	(*set_bwmode_handler)(struct adapter *padapter,
+				      enum ht_channel_width Bandwidth,
+				      u8 Offset);
+	void	(*set_channel_handler)(struct adapter *padapter, u8 channel);
+
+	void	(*hal_dm_watchdog)(struct adapter *padapter);
+
+	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
+				   u8 *val);
+	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
+				   u8 *val);
+
+	u8	(*GetHalDefVarHandler)(struct adapter *padapter,
+				       enum hal_def_variable eVariable,
+				       void *pValue);
+	u8	(*SetHalDefVarHandler)(struct adapter *padapter,
+				       enum hal_def_variable eVariable,
+				       void *pValue);
+
+	void	(*GetHalODMVarHandler)(struct adapter *padapter,
+				       enum hal_odm_variable eVariable,
+				       void *pValue1, bool bSet);
+	void	(*SetHalODMVarHandler)(struct adapter *padapter,
+				       enum hal_odm_variable eVariable,
+				       void *pValue1, bool bSet);
+
+	void	(*UpdateRAMaskHandler)(struct adapter *padapter,
+				       u32 mac_id, u8 rssi_level);
+	void	(*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
+
+	void	(*Add_RateATid)(struct adapter *adapter, u32 bitmap, u8 arg,
+				u8 rssi_level);
+	void	(*run_thread)(struct adapter *adapter);
+	void	(*cancel_thread)(struct adapter *adapter);
+
+	u8	(*AntDivBeforeLinkHandler)(struct adapter *adapter);
+	void	(*AntDivCompareHandler)(struct adapter *adapter,
+					struct wlan_bssid_ex *dst,
+					struct wlan_bssid_ex *src);
+	u8	(*interface_ps_func)(struct adapter *padapter,
+				     enum hal_intf_ps_func efunc_id, u8 *val);
+
+	s32	(*hal_xmit)(struct adapter *padapter,
+			    struct xmit_frame *pxmitframe);
+	s32 (*mgnt_xmit)(struct adapter *padapter,
+			 struct xmit_frame *pmgntframe);
+	s32 (*hal_xmitframe_enqueue)(struct adapter *padapter,
+				     struct xmit_frame *pxmitframe);
+
+	u32	(*read_bbreg)(struct adapter *padapter, u32 RegAddr,
+			      u32 BitMask);
+	void	(*write_bbreg)(struct adapter *padapter, u32 RegAddr,
+			       u32 BitMask, u32 Data);
+	u32	(*read_rfreg)(struct adapter *padapter,
+			      enum rf_radio_path eRFPath, u32 RegAddr,
+			      u32 BitMask);
+	void	(*write_rfreg)(struct adapter *padapter,
+			       enum rf_radio_path eRFPath, u32 RegAddr,
+			       u32 BitMask, u32 Data);
+
+	void (*EfusePowerSwitch)(struct adapter *padapter, u8 bWrite,
+				 u8 PwrState);
+	void (*ReadEFuse)(struct adapter *padapter, u8 efuseType, u16 _offset,
+			  u16 _size_byte, u8 *pbuf, bool bPseudoTest);
+	void (*EFUSEGetEfuseDefinition)(struct adapter *padapter, u8 efuseType,
+					u8 type, void *pOut, bool bPseudoTest);
+	u16	(*EfuseGetCurrentSize)(struct adapter *padapter, u8 efuseType,
+				       bool bPseudoTest);
+	int	(*Efuse_PgPacketRead)(struct adapter *adapter, u8 offset,
+				      u8 *data, bool bPseudoTest);
+	int	(*Efuse_PgPacketWrite)(struct adapter *padapter, u8 offset,
+				       u8 word_en, u8 *data, bool bPseudoTest);
+	u8	(*Efuse_WordEnableDataWrite)(struct adapter *padapter,
+					     u16 efuse_addr, u8 word_en,
+					     u8 *data, bool bPseudoTest);
+	bool	(*Efuse_PgPacketWrite_BT)(struct adapter *padapter, u8 offset,
+					  u8 word_en, u8 *data, bool test);
+
+	void (*sreset_init_value)(struct adapter *padapter);
+	void (*sreset_reset_value)(struct adapter *padapter);
+	void (*silentreset)(struct adapter *padapter);
+	void (*sreset_xmit_status_check)(struct adapter *padapter);
+	void (*sreset_linked_status_check) (struct adapter *padapter);
+	u8 (*sreset_get_wifi_status)(struct adapter *padapter);
+
+	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
+				  struct xmit_frame *frame, u32 max_wait,
+				  u32 bndy_cnt);
+
+	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
+	void (*hal_reset_security_engine)(struct adapter *adapter);
+	s32 (*c2h_handler)(struct adapter *padapter,
+			   struct c2h_evt_hdr *c2h_evt);
+	c2h_id_filter c2h_id_filter_ccx;
+};
+
+enum rt_eeprom_type {
+	EEPROM_93C46,
+	EEPROM_93C56,
+	EEPROM_BOOT_EFUSE,
+};
+
+#define RF_CHANGE_BY_INIT	0
+#define RF_CHANGE_BY_IPS	BIT28
+#define RF_CHANGE_BY_PS		BIT29
+#define RF_CHANGE_BY_HW		BIT30
+#define RF_CHANGE_BY_SW		BIT31
+
+enum hardware_type {
+	HARDWARE_TYPE_RTL8180,
+	HARDWARE_TYPE_RTL8185,
+	HARDWARE_TYPE_RTL8187,
+	HARDWARE_TYPE_RTL8188,
+	HARDWARE_TYPE_RTL8190P,
+	HARDWARE_TYPE_RTL8192E,
+	HARDWARE_TYPE_RTL819xU,
+	HARDWARE_TYPE_RTL8192SE,
+	HARDWARE_TYPE_RTL8192SU,
+	HARDWARE_TYPE_RTL8192CE,
+	HARDWARE_TYPE_RTL8192CU,
+	HARDWARE_TYPE_RTL8192DE,
+	HARDWARE_TYPE_RTL8192DU,
+	HARDWARE_TYPE_RTL8723AE,
+	HARDWARE_TYPE_RTL8723AU,
+	HARDWARE_TYPE_RTL8723AS,
+	HARDWARE_TYPE_RTL8188EE,
+	HARDWARE_TYPE_RTL8188EU,
+	HARDWARE_TYPE_RTL8188ES,
+	HARDWARE_TYPE_MAX,
+};
+
+/*  RTL8188E Series */
+#define IS_HARDWARE_TYPE_8188EE(_Adapter)			\
+(((struct adapter *)_Adapter)->HardwareType == HARDWARE_TYPE_RTL8188EE)
+#define IS_HARDWARE_TYPE_8188EU(_Adapter)			\
+(((struct adapter *)_Adapter)->HardwareType == HARDWARE_TYPE_RTL8188EU)
+#define IS_HARDWARE_TYPE_8188ES(_Adapter)			\
+(((struct adapter *)_Adapter)->HardwareType == HARDWARE_TYPE_RTL8188ES)
+#define	IS_HARDWARE_TYPE_8188E(_Adapter)	\
+(IS_HARDWARE_TYPE_8188EE(_Adapter) || IS_HARDWARE_TYPE_8188EU(_Adapter) || \
+ IS_HARDWARE_TYPE_8188ES(_Adapter))
+
+#define GET_EEPROM_EFUSE_PRIV(adapter) (&adapter->eeprompriv)
+
+#define is_boot_from_eeprom(adapter) (adapter->eeprompriv.EepromOrEfuse)
+
+void rtw_hal_def_value_init(struct adapter *padapter);
+
+void	rtw_hal_free_data(struct adapter *padapter);
+
+void rtw_hal_dm_init(struct adapter *padapter);
+void rtw_hal_dm_deinit(struct adapter *padapter);
+void rtw_hal_sw_led_init(struct adapter *padapter);
+void rtw_hal_sw_led_deinit(struct adapter *padapter);
+
+u32 rtw_hal_power_on(struct adapter *padapter);
+uint rtw_hal_init(struct adapter *padapter);
+uint rtw_hal_deinit(struct adapter *padapter);
+void rtw_hal_stop(struct adapter *padapter);
+void rtw_hal_set_hwreg(struct adapter *padapter, u8 variable, u8 *val);
+void rtw_hal_get_hwreg(struct adapter *padapter, u8 variable, u8 *val);
+
+void rtw_hal_chip_configure(struct adapter *padapter);
+void rtw_hal_read_chip_info(struct adapter *padapter);
+void rtw_hal_read_chip_version(struct adapter *padapter);
+
+u8 rtw_hal_set_def_var(struct adapter *padapter,
+		       enum hal_def_variable eVariable, void *pValue);
+u8 rtw_hal_get_def_var(struct adapter *padapter,
+		       enum hal_def_variable eVariable, void *pValue);
+
+void rtw_hal_set_odm_var(struct adapter *padapter,
+			 enum hal_odm_variable eVariable, void *pValue1,
+			 bool bSet);
+void rtw_hal_get_odm_var(struct adapter *padapter,
+			 enum hal_odm_variable eVariable,
+			 void *pValue1, bool bSet);
+
+void rtw_hal_enable_interrupt(struct adapter *padapter);
+void rtw_hal_disable_interrupt(struct adapter *padapter);
+
+u32	rtw_hal_inirp_init(struct adapter *padapter);
+u32	rtw_hal_inirp_deinit(struct adapter *padapter);
+
+u8	rtw_hal_intf_ps_func(struct adapter *padapter,
+			     enum hal_intf_ps_func efunc_id, u8 *val);
+s32 rtw_hal_xmitframe_enqueue(struct adapter *padapter,
+			      struct xmit_frame *pxmitframe);
+
+s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
+s32	rtw_hal_mgnt_xmit(struct adapter *padapter,
+			  struct xmit_frame *pmgntframe);
+
+s32	rtw_hal_init_xmit_priv(struct adapter *padapter);
+void	rtw_hal_free_xmit_priv(struct adapter *padapter);
+
+s32	rtw_hal_init_recv_priv(struct adapter *padapter);
+void	rtw_hal_free_recv_priv(struct adapter *padapter);
+
+void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
+void	rtw_hal_add_ra_tid(struct adapter *adapt, u32 bitmap, u8 arg, u8 level);
+void	rtw_hal_clone_data(struct adapter *dst_adapt,
+			   struct adapter *src_adapt);
+void	rtw_hal_start_thread(struct adapter *padapter);
+void	rtw_hal_stop_thread(struct adapter *padapter);
+
+void rtw_hal_bcn_related_reg_setting(struct adapter *padapter);
+
+u32	rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask);
+void	rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask,
+			    u32 Data);
+u32	rtw_hal_read_rfreg(struct adapter *padapter, enum rf_radio_path eRFPath,
+			   u32 RegAddr, u32 BitMask);
+void	rtw_hal_write_rfreg(struct adapter *padapter,
+			    enum rf_radio_path eRFPath, u32 RegAddr,
+			    u32 BitMask, u32 Data);
+
+s32	rtw_hal_interrupt_handler(struct adapter *padapter);
+
+void	rtw_hal_set_bwmode(struct adapter *padapter,
+			   enum ht_channel_width Bandwidth, u8 Offset);
+void	rtw_hal_set_chan(struct adapter *padapter, u8 channel);
+void	rtw_hal_dm_watchdog(struct adapter *padapter);
+
+u8	rtw_hal_antdiv_before_linked(struct adapter *padapter);
+void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
+				     struct wlan_bssid_ex *dst,
+				     struct wlan_bssid_ex *src);
+
+void rtw_hal_sreset_init(struct adapter *padapter);
+void rtw_hal_sreset_reset(struct adapter *padapter);
+void rtw_hal_sreset_reset_value(struct adapter *padapter);
+void rtw_hal_sreset_xmit_status_check(struct adapter *padapter);
+void rtw_hal_sreset_linked_status_check(struct adapter *padapter);
+u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
+
+int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
+		    u32 max_wating_ms, u32 bndy_cnt);
+
+void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
+void rtw_hal_reset_security_engine(struct adapter *adapter);
+
+s32 rtw_hal_c2h_handler(struct adapter *adapter,
+			struct c2h_evt_hdr *c2h_evt);
+c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter);
+void indicate_wx_scan_complete_event(struct adapter *padapter);
+u8 rtw_do_join(struct adapter *padapter);
+
+#endif /* __HAL_INTF_H__ */
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
new file mode 100644
index 000000000000..0e6beaebeb0f
--- /dev/null
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -0,0 +1,1261 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __IEEE80211_H
+#define __IEEE80211_H
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include "wifi.h"
+#include <linux/wireless.h>
+
+#define MGMT_QUEUE_NUM 5
+
+#define ETH_ALEN	6
+#define ETH_TYPE_LEN		2
+#define PAYLOAD_TYPE_LEN	1
+
+#ifdef CONFIG_88EU_AP_MODE
+
+#define RTL_IOCTL_HOSTAPD (SIOCIWFIRSTPRIV + 28)
+
+/* RTL871X_IOCTL_HOSTAPD ioctl() cmd: */
+enum {
+	RTL871X_HOSTAPD_FLUSH = 1,
+	RTL871X_HOSTAPD_ADD_STA = 2,
+	RTL871X_HOSTAPD_REMOVE_STA = 3,
+	RTL871X_HOSTAPD_GET_INFO_STA = 4,
+	/* REMOVED: PRISM2_HOSTAPD_RESET_TXEXC_STA = 5, */
+	RTL871X_HOSTAPD_GET_WPAIE_STA = 5,
+	RTL871X_SET_ENCRYPTION = 6,
+	RTL871X_GET_ENCRYPTION = 7,
+	RTL871X_HOSTAPD_SET_FLAGS_STA = 8,
+	RTL871X_HOSTAPD_GET_RID = 9,
+	RTL871X_HOSTAPD_SET_RID = 10,
+	RTL871X_HOSTAPD_SET_ASSOC_AP_ADDR = 11,
+	RTL871X_HOSTAPD_SET_GENERIC_ELEMENT = 12,
+	RTL871X_HOSTAPD_MLME = 13,
+	RTL871X_HOSTAPD_SCAN_REQ = 14,
+	RTL871X_HOSTAPD_STA_CLEAR_STATS = 15,
+	RTL871X_HOSTAPD_SET_BEACON = 16,
+	RTL871X_HOSTAPD_SET_WPS_BEACON = 17,
+	RTL871X_HOSTAPD_SET_WPS_PROBE_RESP = 18,
+	RTL871X_HOSTAPD_SET_WPS_ASSOC_RESP = 19,
+	RTL871X_HOSTAPD_SET_HIDDEN_SSID = 20,
+	RTL871X_HOSTAPD_SET_MACADDR_ACL = 21,
+	RTL871X_HOSTAPD_ACL_ADD_STA = 22,
+	RTL871X_HOSTAPD_ACL_REMOVE_STA = 23,
+};
+
+/* STA flags */
+#define WLAN_STA_AUTH BIT(0)
+#define WLAN_STA_ASSOC BIT(1)
+#define WLAN_STA_PS BIT(2)
+#define WLAN_STA_TIM BIT(3)
+#define WLAN_STA_PERM BIT(4)
+#define WLAN_STA_AUTHORIZED BIT(5)
+#define WLAN_STA_PENDING_POLL BIT(6) /* pending activity poll not ACKed */
+#define WLAN_STA_SHORT_PREAMBLE BIT(7)
+#define WLAN_STA_PREAUTH BIT(8)
+#define WLAN_STA_WME BIT(9)
+#define WLAN_STA_MFP BIT(10)
+#define WLAN_STA_HT BIT(11)
+#define WLAN_STA_WPS BIT(12)
+#define WLAN_STA_MAYBE_WPS BIT(13)
+#define WLAN_STA_NONERP BIT(31)
+
+#endif
+
+#define IEEE_CMD_SET_WPA_PARAM			1
+#define IEEE_CMD_SET_WPA_IE				2
+#define IEEE_CMD_SET_ENCRYPTION			3
+#define IEEE_CMD_MLME						4
+
+#define IEEE_PARAM_WPA_ENABLED				1
+#define IEEE_PARAM_TKIP_COUNTERMEASURES		2
+#define IEEE_PARAM_DROP_UNENCRYPTED			3
+#define IEEE_PARAM_PRIVACY_INVOKED			4
+#define IEEE_PARAM_AUTH_ALGS					5
+#define IEEE_PARAM_IEEE_802_1X				6
+#define IEEE_PARAM_WPAX_SELECT				7
+
+#define AUTH_ALG_OPEN_SYSTEM			0x1
+#define AUTH_ALG_SHARED_KEY			0x2
+#define AUTH_ALG_LEAP				0x00000004
+
+#define IEEE_MLME_STA_DEAUTH				1
+#define IEEE_MLME_STA_DISASSOC			2
+
+#define IEEE_CRYPT_ERR_UNKNOWN_ALG			2
+#define IEEE_CRYPT_ERR_UNKNOWN_ADDR			3
+#define IEEE_CRYPT_ERR_CRYPT_INIT_FAILED		4
+#define IEEE_CRYPT_ERR_KEY_SET_FAILED			5
+#define IEEE_CRYPT_ERR_TX_KEY_SET_FAILED		6
+#define IEEE_CRYPT_ERR_CARD_CONF_FAILED		7
+
+#define	IEEE_CRYPT_ALG_NAME_LEN			16
+
+#define WPA_CIPHER_NONE		BIT(0)
+#define WPA_CIPHER_WEP40	BIT(1)
+#define WPA_CIPHER_WEP104 BIT(2)
+#define WPA_CIPHER_TKIP		BIT(3)
+#define WPA_CIPHER_CCMP		BIT(4)
+
+
+#define WPA_SELECTOR_LEN 4
+extern u8 RTW_WPA_OUI_TYPE[];
+extern u16 RTW_WPA_VERSION;
+extern u8 WPA_AUTH_KEY_MGMT_NONE[];
+extern u8 WPA_AUTH_KEY_MGMT_UNSPEC_802_1X[];
+extern u8 WPA_AUTH_KEY_MGMT_PSK_OVER_802_1X[];
+extern u8 WPA_CIPHER_SUITE_NONE[];
+extern u8 WPA_CIPHER_SUITE_WEP40[];
+extern u8 WPA_CIPHER_SUITE_TKIP[];
+extern u8 WPA_CIPHER_SUITE_WRAP[];
+extern u8 WPA_CIPHER_SUITE_CCMP[];
+extern u8 WPA_CIPHER_SUITE_WEP104[];
+
+#define RSN_HEADER_LEN 4
+#define RSN_SELECTOR_LEN 4
+
+extern u16 RSN_VERSION_BSD;
+extern u8 RSN_AUTH_KEY_MGMT_UNSPEC_802_1X[];
+extern u8 RSN_AUTH_KEY_MGMT_PSK_OVER_802_1X[];
+extern u8 RSN_CIPHER_SUITE_NONE[];
+extern u8 RSN_CIPHER_SUITE_WEP40[];
+extern u8 RSN_CIPHER_SUITE_TKIP[];
+extern u8 RSN_CIPHER_SUITE_WRAP[];
+extern u8 RSN_CIPHER_SUITE_CCMP[];
+extern u8 RSN_CIPHER_SUITE_WEP104[];
+
+enum ratr_table_mode {
+	RATR_INX_WIRELESS_NGB = 0,	/*  BGN 40 Mhz 2SS 1SS */
+	RATR_INX_WIRELESS_NG = 1,	/*  GN or N */
+	RATR_INX_WIRELESS_NB = 2,	/*  BGN 20 Mhz 2SS 1SS  or BN */
+	RATR_INX_WIRELESS_N = 3,
+	RATR_INX_WIRELESS_GB = 4,
+	RATR_INX_WIRELESS_G = 5,
+	RATR_INX_WIRELESS_B = 6,
+	RATR_INX_WIRELESS_MC = 7,
+	RATR_INX_WIRELESS_AC_N = 8,
+};
+
+enum NETWORK_TYPE {
+	WIRELESS_INVALID = 0,
+	/* Sub-Element */
+	WIRELESS_11B = BIT(0), /* tx:cck only, rx:cck only, hw: cck */
+	WIRELESS_11G = BIT(1), /* tx:ofdm only, rx:ofdm & cck, hw:cck & ofdm*/
+	WIRELESS_11A = BIT(2), /* tx:ofdm only, rx: ofdm only, hw:ofdm only */
+	WIRELESS_11_24N = BIT(3), /* tx:MCS only, rx:MCS & cck, hw:MCS & cck */
+	WIRELESS_11_5N = BIT(4), /* tx:MCS only, rx:MCS & ofdm, hw:ofdm only */
+	WIRELESS_AC		= BIT(6),
+
+	/* Combination */
+	/*  tx: cck & ofdm, rx: cck & ofdm & MCS, hw: cck & ofdm */
+	WIRELESS_11BG = (WIRELESS_11B | WIRELESS_11G),
+	/*  tx: ofdm & MCS, rx: ofdm & cck & MCS, hw: cck & ofdm */
+	WIRELESS_11G_24N = (WIRELESS_11G | WIRELESS_11_24N),
+	/*  tx: ofdm & MCS, rx: ofdm & MCS, hw: ofdm only */
+	WIRELESS_11A_5N = (WIRELESS_11A | WIRELESS_11_5N),
+	/*  tx: ofdm & cck & MCS, rx: ofdm & cck & MCS, hw: ofdm & cck */
+	WIRELESS_11BG_24N = (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N),
+	/*  tx: ofdm & MCS, rx: ofdm & MCS, hw: ofdm only */
+	WIRELESS_11AGN = (WIRELESS_11A | WIRELESS_11G | WIRELESS_11_24N |
+			  WIRELESS_11_5N),
+	WIRELESS_11ABGN = (WIRELESS_11A | WIRELESS_11B | WIRELESS_11G |
+			   WIRELESS_11_24N | WIRELESS_11_5N),
+};
+
+#define SUPPORTED_24G_NETTYPE_MSK				\
+	 (WIRELESS_11B | WIRELESS_11G | WIRELESS_11_24N)
+#define SUPPORTED_5G_NETTYPE_MSK				\
+	 (WIRELESS_11A | WIRELESS_11_5N)
+
+#define IsSupported24G(NetType)					\
+	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
+#define IsSupported5G(NetType)					\
+	((NetType) & SUPPORTED_5G_NETTYPE_MSK ? true : false)
+
+#define IsEnableHWCCK(NetType)					\
+	IsSupported24G(NetType)
+#define IsEnableHWOFDM(NetType)					\
+	((NetType) & (WIRELESS_11G | WIRELESS_11_24N |		\
+	 SUPPORTED_5G_NETTYPE_MSK) ? true : false)
+
+#define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
+#define IsSupportedRxOFDM(NetType) IsEnableHWOFDM(NetType)
+#define IsSupportedRxMCS(NetType) IsEnableHWOFDM(NetType)
+
+#define IsSupportedTxCCK(NetType)				\
+	((NetType) & (WIRELESS_11B) ? true : false)
+#define IsSupportedTxOFDM(NetType)				\
+	((NetType) & (WIRELESS_11G|WIRELESS_11A) ? true : false)
+#define IsSupportedTxMCS(NetType)				\
+	((NetType) & (WIRELESS_11_24N|WIRELESS_11_5N) ? true : false)
+
+struct ieee_param {
+	u32 cmd;
+	u8 sta_addr[ETH_ALEN];
+	union {
+		struct {
+			u8 name;
+			u32 value;
+		} wpa_param;
+		struct {
+			u32 len;
+			u8 reserved[32];
+			u8 data[0];
+		} wpa_ie;
+		struct {
+			int command;
+			int reason_code;
+		} mlme;
+		struct {
+			u8 alg[IEEE_CRYPT_ALG_NAME_LEN];
+			u8 set_tx;
+			u32 err;
+			u8 idx;
+			u8 seq[8]; /* sequence counter (set: RX, get: TX) */
+			u16 key_len;
+			u8 key[0];
+		} crypt;
+#ifdef CONFIG_88EU_AP_MODE
+		struct {
+			u16 aid;
+			u16 capability;
+			int flags;
+			u8 tx_supp_rates[16];
+			struct ieee80211_ht_cap ht_cap;
+		} add_sta;
+		struct {
+			u8	reserved[2];/* for set max_num_sta */
+			u8	buf[0];
+		} bcn_ie;
+#endif
+
+	} u;
+};
+
+#ifdef CONFIG_88EU_AP_MODE
+struct ieee_param_ex {
+	u32 cmd;
+	u8 sta_addr[ETH_ALEN];
+	u8 data[0];
+};
+
+struct sta_data {
+	u16 aid;
+	u16 capability;
+	int flags;
+	u32 sta_set;
+	u8 tx_supp_rates[16];
+	u32 tx_supp_rates_len;
+	struct ieee80211_ht_cap ht_cap;
+	u64	rx_pkts;
+	u64	rx_bytes;
+	u64	rx_drops;
+	u64	tx_pkts;
+	u64	tx_bytes;
+	u64	tx_drops;
+};
+#endif
+
+#define IEEE80211_DATA_LEN		2304
+/* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
+   6.2.1.1.2.
+
+   The figure in section 7.1.2 suggests a body size of up to 2312
+   bytes is allowed, which is a bit confusing, I suspect this
+   represents the 2304 bytes of real data, plus a possible 8 bytes of
+   WEP IV and ICV. (this interpretation suggested by Ramiro Barreiro) */
+
+#define IEEE80211_HLEN			30
+#define IEEE80211_FRAME_LEN		(IEEE80211_DATA_LEN + IEEE80211_HLEN)
+
+/* this is stolen from ipw2200 driver */
+#define IEEE_IBSS_MAC_HASH_SIZE 31
+
+struct ieee_ibss_seq {
+	u8 mac[ETH_ALEN];
+	u16 seq_num;
+	u16 frag_num;
+	unsigned long packet_time;
+	struct list_head list;
+};
+
+struct rtw_ieee80211_hdr {
+	__le16 frame_ctl;
+	__le16 duration_id;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	u16 seq_ctl;
+	u8 addr4[ETH_ALEN];
+} __packed;
+
+struct rtw_ieee80211_hdr_3addr {
+	__le16 frame_ctl;
+	__le16 duration_id;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	u16 seq_ctl;
+} __packed;
+
+struct rtw_ieee80211_hdr_qos {
+	__le16 frame_ctl;
+	__le16 duration_id;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	u16 seq_ctl;
+	u8 addr4[ETH_ALEN];
+	u16	qc;
+}  __packed;
+
+struct rtw_ieee80211_hdr_3addr_qos {
+	__le16 frame_ctl;
+	__le16 duration_id;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	u16 seq_ctl;
+	u16     qc;
+}  __packed;
+
+struct eapol {
+	u8 snap[6];
+	u16 ethertype;
+	u8 version;
+	u8 type;
+	u16 length;
+} __packed;
+
+enum eap_type {
+	EAP_PACKET = 0,
+	EAPOL_START,
+	EAPOL_LOGOFF,
+	EAPOL_KEY,
+	EAPOL_ENCAP_ASF_ALERT
+};
+
+#define IEEE80211_3ADDR_LEN 24
+#define IEEE80211_4ADDR_LEN 30
+#define IEEE80211_FCS_LEN    4
+
+#define MIN_FRAG_THRESHOLD     256U
+#define	MAX_FRAG_THRESHOLD     2346U
+
+/* Frame control field constants */
+#define RTW_IEEE80211_FCTL_VERS		0x0003
+#define RTW_IEEE80211_FCTL_FTYPE	0x000c
+#define RTW_IEEE80211_FCTL_STYPE	0x00f0
+#define RTW_IEEE80211_FCTL_TODS		0x0100
+#define RTW_IEEE80211_FCTL_FROMDS	0x0200
+#define RTW_IEEE80211_FCTL_MOREFRAGS	0x0400
+#define RTW_IEEE80211_FCTL_RETRY	0x0800
+#define RTW_IEEE80211_FCTL_PM		0x1000
+#define RTW_IEEE80211_FCTL_MOREDATA	0x2000
+#define RTW_IEEE80211_FCTL_PROTECTED	0x4000
+#define RTW_IEEE80211_FCTL_ORDER	0x8000
+#define RTW_IEEE80211_FCTL_CTL_EXT	0x0f00
+
+#define RTW_IEEE80211_FTYPE_MGMT	0x0000
+#define RTW_IEEE80211_FTYPE_CTL		0x0004
+#define RTW_IEEE80211_FTYPE_DATA	0x0008
+#define RTW_IEEE80211_FTYPE_EXT		0x000c
+
+/* management */
+#define RTW_IEEE80211_STYPE_ASSOC_REQ	0x0000
+#define RTW_IEEE80211_STYPE_ASSOC_RESP	0x0010
+#define RTW_IEEE80211_STYPE_REASSOC_REQ	0x0020
+#define RTW_IEEE80211_STYPE_REASSOC_RESP	0x0030
+#define RTW_IEEE80211_STYPE_PROBE_REQ	0x0040
+#define RTW_IEEE80211_STYPE_PROBE_RESP	0x0050
+#define RTW_IEEE80211_STYPE_BEACON	0x0080
+#define RTW_IEEE80211_STYPE_ATIM	0x0090
+#define RTW_IEEE80211_STYPE_DISASSOC	0x00A0
+#define RTW_IEEE80211_STYPE_AUTH	0x00B0
+#define RTW_IEEE80211_STYPE_DEAUTH	0x00C0
+#define RTW_IEEE80211_STYPE_ACTION	0x00D0
+
+/* control */
+#define RTW_IEEE80211_STYPE_CTL_EXT	0x0060
+#define RTW_IEEE80211_STYPE_BACK_REQ	0x0080
+#define RTW_IEEE80211_STYPE_BACK	0x0090
+#define RTW_IEEE80211_STYPE_PSPOLL	0x00A0
+#define RTW_IEEE80211_STYPE_RTS		0x00B0
+#define RTW_IEEE80211_STYPE_CTS		0x00C0
+#define RTW_IEEE80211_STYPE_ACK		0x00D0
+#define RTW_IEEE80211_STYPE_CFEND	0x00E0
+#define RTW_IEEE80211_STYPE_CFENDACK	0x00F0
+
+/* data */
+#define RTW_IEEE80211_STYPE_DATA	0x0000
+#define RTW_IEEE80211_STYPE_DATA_CFACK	0x0010
+#define RTW_IEEE80211_STYPE_DATA_CFPOLL	0x0020
+#define RTW_IEEE80211_STYPE_DATA_CFACKPOLL	0x0030
+#define RTW_IEEE80211_STYPE_NULLFUNC	0x0040
+#define RTW_IEEE80211_STYPE_CFACK	0x0050
+#define RTW_IEEE80211_STYPE_CFPOLL	0x0060
+#define RTW_IEEE80211_STYPE_CFACKPOLL	0x0070
+#define RTW_IEEE80211_STYPE_QOS_DATA	0x0080
+#define RTW_IEEE80211_STYPE_QOS_DATA_CFACK	0x0090
+#define RTW_IEEE80211_STYPE_QOS_DATA_CFPOLL	0x00A0
+#define RTW_IEEE80211_STYPE_QOS_DATA_CFACKPOLL	0x00B0
+#define RTW_IEEE80211_STYPE_QOS_NULLFUNC	0x00C0
+#define RTW_IEEE80211_STYPE_QOS_CFACK		0x00D0
+#define RTW_IEEE80211_STYPE_QOS_CFPOLL		0x00E0
+#define RTW_IEEE80211_STYPE_QOS_CFACKPOLL	0x00F0
+
+/* sequence control field */
+#define RTW_IEEE80211_SCTL_FRAG	0x000F
+#define RTW_IEEE80211_SCTL_SEQ	0xFFF0
+
+#define RTW_ERP_INFO_NON_ERP_PRESENT BIT(0)
+#define RTW_ERP_INFO_USE_PROTECTION BIT(1)
+#define RTW_ERP_INFO_BARKER_PREAMBLE_MODE BIT(2)
+
+/* QoS, QOS */
+#define NORMAL_ACK			0
+#define NO_ACK				1
+#define NON_EXPLICIT_ACK		2
+#define BLOCK_ACK			3
+
+#ifndef ETH_P_PAE
+#define ETH_P_PAE 0x888E /* Port Access Entity (IEEE 802.1X) */
+#endif /* ETH_P_PAE */
+
+#define ETH_P_PREAUTH 0x88C7 /* IEEE 802.11i pre-authentication */
+
+#define ETH_P_ECONET	0x0018
+
+#ifndef ETH_P_80211_RAW
+#define ETH_P_80211_RAW (ETH_P_ECONET + 1)
+#endif
+
+/* IEEE 802.11 defines */
+
+#define P80211_OUI_LEN 3
+
+struct ieee80211_snap_hdr {
+	u8    dsap;   /* always 0xAA */
+	u8    ssap;   /* always 0xAA */
+	u8    ctrl;   /* always 0x03 */
+	u8    oui[P80211_OUI_LEN];    /* organizational universal id */
+} __packed;
+
+#define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
+
+#define WLAN_FC_GET_TYPE(fc) ((fc) & RTW_IEEE80211_FCTL_FTYPE)
+#define WLAN_FC_GET_STYPE(fc) ((fc) & RTW_IEEE80211_FCTL_STYPE)
+
+#define WLAN_QC_GET_TID(qc) ((qc) & 0x0f)
+
+#define WLAN_GET_SEQ_FRAG(seq) ((seq) & RTW_IEEE80211_SCTL_FRAG)
+#define WLAN_GET_SEQ_SEQ(seq)  ((seq) & RTW_IEEE80211_SCTL_SEQ)
+
+/* Authentication algorithms */
+#define WLAN_AUTH_OPEN 0
+#define WLAN_AUTH_SHARED_KEY 1
+
+#define WLAN_AUTH_CHALLENGE_LEN 128
+
+#define WLAN_CAPABILITY_BSS (1<<0)
+#define WLAN_CAPABILITY_IBSS (1<<1)
+#define WLAN_CAPABILITY_CF_POLLABLE (1<<2)
+#define WLAN_CAPABILITY_CF_POLL_REQUEST (1<<3)
+#define WLAN_CAPABILITY_PRIVACY (1<<4)
+#define WLAN_CAPABILITY_SHORT_PREAMBLE (1<<5)
+#define WLAN_CAPABILITY_PBCC (1<<6)
+#define WLAN_CAPABILITY_CHANNEL_AGILITY (1<<7)
+#define WLAN_CAPABILITY_SHORT_SLOT (1<<10)
+
+/* Status codes */
+#define WLAN_STATUS_SUCCESS 0
+#define WLAN_STATUS_UNSPECIFIED_FAILURE 1
+#define WLAN_STATUS_CAPS_UNSUPPORTED 10
+#define WLAN_STATUS_REASSOC_NO_ASSOC 11
+#define WLAN_STATUS_ASSOC_DENIED_UNSPEC 12
+#define WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG 13
+#define WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION 14
+#define WLAN_STATUS_CHALLENGE_FAIL 15
+#define WLAN_STATUS_AUTH_TIMEOUT 16
+#define WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA 17
+#define WLAN_STATUS_ASSOC_DENIED_RATES 18
+/* 802.11b */
+#define WLAN_STATUS_ASSOC_DENIED_NOSHORT 19
+#define WLAN_STATUS_ASSOC_DENIED_NOPBCC 20
+#define WLAN_STATUS_ASSOC_DENIED_NOAGILITY 21
+
+/* Reason codes */
+#define WLAN_REASON_UNSPECIFIED 1
+#define WLAN_REASON_PREV_AUTH_NOT_VALID 2
+#define WLAN_REASON_DEAUTH_LEAVING 3
+#define WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY 4
+#define WLAN_REASON_DISASSOC_AP_BUSY 5
+#define WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA 6
+#define WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA 7
+#define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
+#define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9
+#define WLAN_REASON_JOIN_WRONG_CHANNEL       65534
+#define WLAN_REASON_EXPIRATION_CHK 65535
+
+/* Information Element IDs */
+#define WLAN_EID_SSID 0
+#define WLAN_EID_SUPP_RATES 1
+#define WLAN_EID_FH_PARAMS 2
+#define WLAN_EID_DS_PARAMS 3
+#define WLAN_EID_CF_PARAMS 4
+#define WLAN_EID_TIM 5
+#define WLAN_EID_IBSS_PARAMS 6
+#define WLAN_EID_CHALLENGE 16
+/* EIDs defined by IEEE 802.11h - START */
+#define WLAN_EID_PWR_CONSTRAINT 32
+#define WLAN_EID_PWR_CAPABILITY 33
+#define WLAN_EID_TPC_REQUEST 34
+#define WLAN_EID_TPC_REPORT 35
+#define WLAN_EID_SUPPORTED_CHANNELS 36
+#define WLAN_EID_CHANNEL_SWITCH 37
+#define WLAN_EID_MEASURE_REQUEST 38
+#define WLAN_EID_MEASURE_REPORT 39
+#define WLAN_EID_QUITE 40
+#define WLAN_EID_IBSS_DFS 41
+/* EIDs defined by IEEE 802.11h - END */
+#define WLAN_EID_ERP_INFO 42
+#define WLAN_EID_HT_CAP 45
+#define WLAN_EID_RSN 48
+#define WLAN_EID_EXT_SUPP_RATES 50
+#define WLAN_EID_MOBILITY_DOMAIN 54
+#define WLAN_EID_FAST_BSS_TRANSITION 55
+#define WLAN_EID_TIMEOUT_INTERVAL 56
+#define WLAN_EID_RIC_DATA 57
+#define WLAN_EID_HT_OPERATION 61
+#define WLAN_EID_SECONDARY_CHANNEL_OFFSET 62
+#define WLAN_EID_20_40_BSS_COEXISTENCE 72
+#define WLAN_EID_20_40_BSS_INTOLERANT 73
+#define WLAN_EID_OVERLAPPING_BSS_SCAN_PARAMS 74
+#define WLAN_EID_MMIE 76
+#define WLAN_EID_VENDOR_SPECIFIC 221
+#define WLAN_EID_GENERIC (WLAN_EID_VENDOR_SPECIFIC)
+
+#define IEEE80211_MGMT_HDR_LEN 24
+#define IEEE80211_DATA_HDR3_LEN 24
+#define IEEE80211_DATA_HDR4_LEN 30
+
+#define IEEE80211_STATMASK_SIGNAL (1<<0)
+#define IEEE80211_STATMASK_RSSI (1<<1)
+#define IEEE80211_STATMASK_NOISE (1<<2)
+#define IEEE80211_STATMASK_RATE (1<<3)
+#define IEEE80211_STATMASK_WEMASK 0x7
+
+#define IEEE80211_CCK_MODULATION    (1<<0)
+#define IEEE80211_OFDM_MODULATION   (1<<1)
+
+#define IEEE80211_24GHZ_BAND     (1<<0)
+#define IEEE80211_52GHZ_BAND     (1<<1)
+
+#define IEEE80211_CCK_RATE_LEN			4
+#define IEEE80211_NUM_OFDM_RATESLEN	8
+
+#define IEEE80211_CCK_RATE_1MB			0x02
+#define IEEE80211_CCK_RATE_2MB			0x04
+#define IEEE80211_CCK_RATE_5MB			0x0B
+#define IEEE80211_CCK_RATE_11MB			0x16
+#define IEEE80211_OFDM_RATE_LEN			8
+#define IEEE80211_OFDM_RATE_6MB			0x0C
+#define IEEE80211_OFDM_RATE_9MB			0x12
+#define IEEE80211_OFDM_RATE_12MB		0x18
+#define IEEE80211_OFDM_RATE_18MB		0x24
+#define IEEE80211_OFDM_RATE_24MB		0x30
+#define IEEE80211_OFDM_RATE_36MB		0x48
+#define IEEE80211_OFDM_RATE_48MB		0x60
+#define IEEE80211_OFDM_RATE_54MB		0x6C
+#define IEEE80211_BASIC_RATE_MASK		0x80
+
+#define IEEE80211_CCK_RATE_1MB_MASK		(1<<0)
+#define IEEE80211_CCK_RATE_2MB_MASK		(1<<1)
+#define IEEE80211_CCK_RATE_5MB_MASK		(1<<2)
+#define IEEE80211_CCK_RATE_11MB_MASK		(1<<3)
+#define IEEE80211_OFDM_RATE_6MB_MASK		(1<<4)
+#define IEEE80211_OFDM_RATE_9MB_MASK		(1<<5)
+#define IEEE80211_OFDM_RATE_12MB_MASK		(1<<6)
+#define IEEE80211_OFDM_RATE_18MB_MASK		(1<<7)
+#define IEEE80211_OFDM_RATE_24MB_MASK		(1<<8)
+#define IEEE80211_OFDM_RATE_36MB_MASK		(1<<9)
+#define IEEE80211_OFDM_RATE_48MB_MASK		(1<<10)
+#define IEEE80211_OFDM_RATE_54MB_MASK		(1<<11)
+
+#define IEEE80211_CCK_RATES_MASK		0x0000000F
+#define IEEE80211_CCK_BASIC_RATES_MASK	(IEEE80211_CCK_RATE_1MB_MASK | \
+	IEEE80211_CCK_RATE_2MB_MASK)
+#define IEEE80211_CCK_DEFAULT_RATES_MASK				\
+	(IEEE80211_CCK_BASIC_RATES_MASK |				\
+	IEEE80211_CCK_RATE_5MB_MASK |					\
+	IEEE80211_CCK_RATE_11MB_MASK)
+
+#define IEEE80211_OFDM_RATES_MASK		0x00000FF0
+#define IEEE80211_OFDM_BASIC_RATES_MASK	(IEEE80211_OFDM_RATE_6MB_MASK | \
+	IEEE80211_OFDM_RATE_12MB_MASK |					\
+	IEEE80211_OFDM_RATE_24MB_MASK)
+#define IEEE80211_OFDM_DEFAULT_RATES_MASK				\
+	(IEEE80211_OFDM_BASIC_RATES_MASK |				\
+	IEEE80211_OFDM_RATE_9MB_MASK  |					\
+	IEEE80211_OFDM_RATE_18MB_MASK |					\
+	IEEE80211_OFDM_RATE_36MB_MASK |					\
+	IEEE80211_OFDM_RATE_48MB_MASK |					\
+	IEEE80211_OFDM_RATE_54MB_MASK)
+#define IEEE80211_DEFAULT_RATES_MASK					\
+	(IEEE80211_OFDM_DEFAULT_RATES_MASK |				\
+	 IEEE80211_CCK_DEFAULT_RATES_MASK)
+
+#define IEEE80211_NUM_OFDM_RATES	8
+#define IEEE80211_NUM_CCK_RATES		4
+#define IEEE80211_OFDM_SHIFT_MASK_A	4
+
+/* NOTE: This data is for statistical purposes; not all hardware provides this
+ *       information for frames received.  Not setting these will not cause
+ *       any adverse affects. */
+struct ieee80211_rx_stats {
+	/* u32 mac_time[2]; */
+	s8 rssi;
+	u8 signal;
+	u8 noise;
+	u8 received_channel;
+	u16 rate; /* in 100 kbps */
+	/* u8 control; */
+	u8 mask;
+	u8 freq;
+	u16 len;
+};
+
+/* IEEE 802.11 requires that STA supports concurrent reception of at least
+ * three fragmented frames. This define can be increased to support more
+ * concurrent frames, but it should be noted that each entry can consume about
+ * 2 kB of RAM and increasing cache size will slow down frame reassembly. */
+#define IEEE80211_FRAG_CACHE_LEN 4
+
+struct ieee80211_frag_entry {
+	u32 first_frag_time;
+	uint seq;
+	uint last_frag;
+	uint qos;   /* jackson */
+	uint tid;	/* jackson */
+	struct sk_buff *skb;
+	u8 src_addr[ETH_ALEN];
+	u8 dst_addr[ETH_ALEN];
+};
+
+struct ieee80211_stats {
+	uint tx_unicast_frames;
+	uint tx_multicast_frames;
+	uint tx_fragments;
+	uint tx_unicast_octets;
+	uint tx_multicast_octets;
+	uint tx_deferred_transmissions;
+	uint tx_single_retry_frames;
+	uint tx_multiple_retry_frames;
+	uint tx_retry_limit_exceeded;
+	uint tx_discards;
+	uint rx_unicast_frames;
+	uint rx_multicast_frames;
+	uint rx_fragments;
+	uint rx_unicast_octets;
+	uint rx_multicast_octets;
+	uint rx_fcs_errors;
+	uint rx_discards_no_buffer;
+	uint tx_discards_wrong_sa;
+	uint rx_discards_undecryptable;
+	uint rx_message_in_msg_fragments;
+	uint rx_message_in_bad_msg_fragments;
+};
+
+struct ieee80211_softmac_stats {
+	uint rx_ass_ok;
+	uint rx_ass_err;
+	uint rx_probe_rq;
+	uint tx_probe_rs;
+	uint tx_beacons;
+	uint rx_auth_rq;
+	uint rx_auth_rs_ok;
+	uint rx_auth_rs_err;
+	uint tx_auth_rq;
+	uint no_auth_rs;
+	uint no_ass_rs;
+	uint tx_ass_rq;
+	uint rx_ass_rq;
+	uint tx_probe_rq;
+	uint reassoc;
+	uint swtxstop;
+	uint swtxawake;
+};
+
+#define SEC_KEY_1	(1<<0)
+#define SEC_KEY_2	(1<<1)
+#define SEC_KEY_3	(1<<2)
+#define SEC_KEY_4	(1<<3)
+#define SEC_ACTIVE_KEY  (1<<4)
+#define SEC_AUTH_MODE   (1<<5)
+#define SEC_UNICAST_GROUP (1<<6)
+#define SEC_LEVEL	(1<<7)
+#define SEC_ENABLED     (1<<8)
+
+#define SEC_LEVEL_0      0 /* None */
+#define SEC_LEVEL_1      1 /* WEP 40 and 104 bit */
+#define SEC_LEVEL_2      2 /* Level 1 + TKIP */
+#define SEC_LEVEL_2_CKIP 3 /* Level 1 + CKIP */
+#define SEC_LEVEL_3      4 /* Level 2 + CCMP */
+
+#define WEP_KEYS 4
+#define WEP_KEY_LEN 13
+
+struct ieee80211_security {
+	u16 active_key:2,
+	enabled:1,
+	auth_mode:2,
+	auth_algo:4,
+	unicast_uses_group:1;
+	u8 key_sizes[WEP_KEYS];
+	u8 keys[WEP_KEYS][WEP_KEY_LEN];
+	u8 level;
+	u16 flags;
+} __packed;
+
+/*
+
+ 802.11 data frame from AP
+
+      ,-------------------------------------------------------------------.
+Bytes |  2   |  2   |    6    |    6    |    6    |  2   | 0..2312 |   4  |
+      |------|------|---------|---------|---------|------|---------|------|
+Desc. | ctrl | dura |  DA/RA  |   TA    |    SA   | Sequ |  frame  |  fcs |
+      |      | tion | (BSSID) |	 |	 | ence |  data   |      |
+      `-------------------------------------------------------------------'
+
+Total: 28-2340 bytes
+
+*/
+
+struct ieee80211_header_data {
+	u16 frame_ctl;
+	u16 duration_id;
+	u8 addr1[6];
+	u8 addr2[6];
+	u8 addr3[6];
+	u16 seq_ctrl;
+};
+
+#define BEACON_PROBE_SSID_ID_POSITION 12
+
+/* Management Frame Information Element Types */
+#define MFIE_TYPE_SSID		0
+#define MFIE_TYPE_RATES		1
+#define MFIE_TYPE_FH_SET	2
+#define MFIE_TYPE_DS_SET	3
+#define MFIE_TYPE_CF_SET	4
+#define MFIE_TYPE_TIM		5
+#define MFIE_TYPE_IBSS_SET	6
+#define MFIE_TYPE_CHALLENGE	16
+#define MFIE_TYPE_ERP		42
+#define MFIE_TYPE_RSN		48
+#define MFIE_TYPE_RATES_EX	50
+#define MFIE_TYPE_GENERIC	221
+
+struct ieee80211_info_element_hdr {
+	u8 id;
+	u8 len;
+} __packed;
+
+struct ieee80211_info_element {
+	u8 id;
+	u8 len;
+	u8 data[0];
+} __packed;
+
+/*
+ * These are the data types that can make up management packets
+ *
+	u16 auth_algorithm;
+	u16 auth_sequence;
+	u16 beacon_interval;
+	u16 capability;
+	u8 current_ap[ETH_ALEN];
+	u16 listen_interval;
+	struct {
+		u16 association_id:14, reserved:2;
+	} __packed;
+	u32 time_stamp[2];
+	u16 reason;
+	u16 status;
+*/
+
+#define IEEE80211_DEFAULT_TX_ESSID "Penguin"
+#define IEEE80211_DEFAULT_BASIC_RATE 10
+
+struct ieee80211_authentication {
+	struct ieee80211_header_data header;
+	u16 algorithm;
+	u16 transaction;
+	u16 status;
+	/* struct ieee80211_info_element_hdr info_element; */
+} __packed;
+
+struct ieee80211_probe_response {
+	struct ieee80211_header_data header;
+	u32 time_stamp[2];
+	u16 beacon_interval;
+	u16 capability;
+	struct ieee80211_info_element info_element;
+} __packed;
+
+struct ieee80211_probe_request {
+	struct ieee80211_header_data header;
+} __packed;
+
+struct ieee80211_assoc_request_frame {
+	struct rtw_ieee80211_hdr_3addr header;
+	u16 capability;
+	u16 listen_interval;
+	struct ieee80211_info_element_hdr info_element;
+} __packed;
+
+struct ieee80211_assoc_response_frame {
+	struct rtw_ieee80211_hdr_3addr header;
+	u16 capability;
+	u16 status;
+	u16 aid;
+} __packed;
+
+struct ieee80211_txb {
+	u8 nr_frags;
+	u8 encrypted;
+	u16 reserved;
+	u16 frag_size;
+	u16 payload_size;
+	struct sk_buff *fragments[0];
+};
+
+/* SWEEP TABLE ENTRIES NUMBER*/
+#define MAX_SWEEP_TAB_ENTRIES		  42
+#define MAX_SWEEP_TAB_ENTRIES_PER_PACKET  7
+/* MAX_RATES_LENGTH needs to be 12.  The spec says 8, and many APs
+ * only use 8, and then use extended rates for the remaining supported
+ * rates.  Other APs, however, stick all of their supported rates on the
+ * main rates information element... */
+#define MAX_RATES_LENGTH		((u8)12)
+#define MAX_RATES_EX_LENGTH		((u8)16)
+#define MAX_NETWORK_COUNT		128
+#define MAX_CHANNEL_NUMBER		161
+#define IEEE80211_SOFTMAC_SCAN_TIME	400
+/* HZ / 2) */
+#define IEEE80211_SOFTMAC_ASSOC_RETRY_TIME (HZ * 2)
+
+#define CRC_LENGTH		 4U
+
+#define MAX_WPA_IE_LEN (256)
+#define MAX_WPS_IE_LEN (512)
+#define MAX_P2P_IE_LEN (256)
+#define MAX_WFD_IE_LEN (128)
+
+#define NETWORK_EMPTY_ESSID (1<<0)
+#define NETWORK_HAS_OFDM    (1<<1)
+#define NETWORK_HAS_CCK     (1<<2)
+
+#define IEEE80211_DTIM_MBCAST 4
+#define IEEE80211_DTIM_UCAST 2
+#define IEEE80211_DTIM_VALID 1
+#define IEEE80211_DTIM_INVALID 0
+
+#define IEEE80211_PS_DISABLED 0
+#define IEEE80211_PS_UNICAST IEEE80211_DTIM_UCAST
+#define IEEE80211_PS_MBCAST IEEE80211_DTIM_MBCAST
+#define IW_ESSID_MAX_SIZE 32
+/*
+join_res:
+-1: authentication fail
+-2: association fail
+> 0: TID
+*/
+
+enum ieee80211_state {
+	/* the card is not linked at all */
+	IEEE80211_NOLINK = 0,
+
+	/* IEEE80211_ASSOCIATING* are for BSS client mode
+	 * the driver shall not perform RX filtering unless
+	 * the state is LINKED.
+	 * The driver shall just check for the state LINKED and
+	 * defaults to NOLINK for ALL the other states (including
+	 * LINKED_SCANNING)
+	 */
+
+	/* the association procedure will start (wq scheduling)*/
+	IEEE80211_ASSOCIATING,
+	IEEE80211_ASSOCIATING_RETRY,
+
+	/* the association procedure is sending AUTH request*/
+	IEEE80211_ASSOCIATING_AUTHENTICATING,
+
+	/* the association procedure has successfully authentcated
+	 * and is sending association request
+	 */
+	IEEE80211_ASSOCIATING_AUTHENTICATED,
+
+	/* the link is ok. the card associated to a BSS or linked
+	 * to a ibss cell or acting as an AP and creating the bss
+	 */
+	IEEE80211_LINKED,
+
+	/* same as LINKED, but the driver shall apply RX filter
+	 * rules as we are in NO_LINK mode. As the card is still
+	 * logically linked, but it is doing a syncro site survey
+	 * then it will be back to LINKED state.
+	 */
+	IEEE80211_LINKED_SCANNING,
+
+};
+
+#define DEFAULT_MAX_SCAN_AGE (15 * HZ)
+#define DEFAULT_FTS 2346
+
+static inline int is_multicast_mac_addr(const u8 *addr)
+{
+	return ((addr[0] != 0xff) && (0x01 & addr[0]));
+}
+
+static inline int is_broadcast_mac_addr(const u8 *addr)
+{
+	return (addr[0] == 0xff) && (addr[1] == 0xff) && (addr[2] == 0xff) &&
+	       (addr[3] == 0xff) && (addr[4] == 0xff) && (addr[5] == 0xff);
+}
+
+#define CFG_IEEE80211_RESERVE_FCS (1<<0)
+#define CFG_IEEE80211_COMPUTE_FCS (1<<1)
+
+struct tx_pending {
+	int frag;
+	struct ieee80211_txb *txb;
+};
+
+#define MAXTID	16
+
+#define IEEE_A	    (1<<0)
+#define IEEE_B	    (1<<1)
+#define IEEE_G	    (1<<2)
+#define IEEE_MODE_MASK    (IEEE_A|IEEE_B|IEEE_G)
+
+/* Baron move to ieee80211.c */
+int ieee80211_is_empty_essid(const char *essid, int essid_len);
+int ieee80211_get_hdrlen(u16 fc);
+
+/* Action category code */
+enum rtw_ieee80211_category {
+	RTW_WLAN_CATEGORY_SPECTRUM_MGMT = 0,
+	RTW_WLAN_CATEGORY_QOS = 1,
+	RTW_WLAN_CATEGORY_DLS = 2,
+	RTW_WLAN_CATEGORY_BACK = 3,
+	RTW_WLAN_CATEGORY_PUBLIC = 4, /* IEEE 802.11 public action frames */
+	RTW_WLAN_CATEGORY_RADIO_MEASUREMENT  = 5,
+	RTW_WLAN_CATEGORY_FT = 6,
+	RTW_WLAN_CATEGORY_HT = 7,
+	RTW_WLAN_CATEGORY_SA_QUERY = 8,
+	RTW_WLAN_CATEGORY_TDLS = 12,
+	RTW_WLAN_CATEGORY_WMM = 17,
+	RTW_WLAN_CATEGORY_P2P = 0x7f,/* P2P action frames */
+};
+
+/* SPECTRUM_MGMT action code */
+enum rtw_ieee80211_spectrum_mgmt_actioncode {
+	RTW_WLAN_ACTION_SPCT_MSR_REQ = 0,
+	RTW_WLAN_ACTION_SPCT_MSR_RPRT = 1,
+	RTW_WLAN_ACTION_SPCT_TPC_REQ = 2,
+	RTW_WLAN_ACTION_SPCT_TPC_RPRT = 3,
+	RTW_WLAN_ACTION_SPCT_CHL_SWITCH = 4,
+	RTW_WLAN_ACTION_SPCT_EXT_CHL_SWITCH = 5,
+};
+
+enum _PUBLIC_ACTION {
+	ACT_PUBLIC_BSSCOEXIST = 0, /*  20/40 BSS Coexistence */
+	ACT_PUBLIC_DSE_ENABLE = 1,
+	ACT_PUBLIC_DSE_DEENABLE = 2,
+	ACT_PUBLIC_DSE_REG_LOCATION = 3,
+	ACT_PUBLIC_EXT_CHL_SWITCH = 4,
+	ACT_PUBLIC_DSE_MSR_REQ = 5,
+	ACT_PUBLIC_DSE_MSR_RPRT = 6,
+	ACT_PUBLIC_MP = 7, /*  Measurement Pilot */
+	ACT_PUBLIC_DSE_PWR_CONSTRAINT = 8,
+	ACT_PUBLIC_VENDOR = 9, /*  for WIFI_DIRECT */
+	ACT_PUBLIC_GAS_INITIAL_REQ = 10,
+	ACT_PUBLIC_GAS_INITIAL_RSP = 11,
+	ACT_PUBLIC_GAS_COMEBACK_REQ = 12,
+	ACT_PUBLIC_GAS_COMEBACK_RSP = 13,
+	ACT_PUBLIC_TDLS_DISCOVERY_RSP = 14,
+	ACT_PUBLIC_LOCATION_TRACK = 15,
+	ACT_PUBLIC_MAX
+};
+
+/* BACK action code */
+enum rtw_ieee80211_back_actioncode {
+	RTW_WLAN_ACTION_ADDBA_REQ = 0,
+	RTW_WLAN_ACTION_ADDBA_RESP = 1,
+	RTW_WLAN_ACTION_DELBA = 2,
+};
+
+/* HT features action code */
+enum rtw_ieee80211_ht_actioncode {
+	RTW_WLAN_ACTION_NOTIFY_CH_WIDTH = 0,
+	RTW_WLAN_ACTION_SM_PS = 1,
+	RTW_WLAN_ACTION_PSPM = 2,
+	RTW_WLAN_ACTION_PCO_PHASE = 3,
+	RTW_WLAN_ACTION_MIMO_CSI_MX = 4,
+	RTW_WLAN_ACTION_MIMO_NONCP_BF = 5,
+	RTW_WLAN_ACTION_MIMP_CP_BF = 6,
+	RTW_WLAN_ACTION_ASEL_INDICATES_FB = 7,
+	RTW_WLAN_ACTION_HI_INFO_EXCHG = 8,
+};
+
+/* BACK (block-ack) parties */
+enum rtw_ieee80211_back_parties {
+	RTW_WLAN_BACK_RECIPIENT = 0,
+	RTW_WLAN_BACK_INITIATOR = 1,
+	RTW_WLAN_BACK_TIMER = 2,
+};
+
+#define OUI_MICROSOFT 0x0050f2 /* Microsoft (also used in Wi-Fi specs)
+				* 00:50:F2 */
+#define WME_OUI_TYPE 2
+#define WME_OUI_SUBTYPE_INFORMATION_ELEMENT 0
+#define WME_OUI_SUBTYPE_PARAMETER_ELEMENT 1
+#define WME_OUI_SUBTYPE_TSPEC_ELEMENT 2
+#define WME_VERSION 1
+
+#define WME_ACTION_CODE_SETUP_REQUEST 0
+#define WME_ACTION_CODE_SETUP_RESPONSE 1
+#define WME_ACTION_CODE_TEARDOWN 2
+
+#define WME_SETUP_RESPONSE_STATUS_ADMISSION_ACCEPTED 0
+#define WME_SETUP_RESPONSE_STATUS_INVALID_PARAMETERS 1
+#define WME_SETUP_RESPONSE_STATUS_REFUSED 3
+
+#define WME_TSPEC_DIRECTION_UPLINK 0
+#define WME_TSPEC_DIRECTION_DOWNLINK 1
+#define WME_TSPEC_DIRECTION_BI_DIRECTIONAL 3
+
+#define OUI_BROADCOM 0x00904c /* Broadcom (Epigram) */
+
+#define VENDOR_HT_CAPAB_OUI_TYPE 0x33 /* 00-90-4c:0x33 */
+
+/**
+ * enum rtw_ieee80211_channel_flags - channel flags
+ *
+ * Channel flags set by the regulatory control code.
+ *
+ * @RTW_IEEE80211_CHAN_DISABLED: This channel is disabled.
+ * @RTW_IEEE80211_CHAN_PASSIVE_SCAN: Only passive scanning is permitted
+ *      on this channel.
+ * @RTW_IEEE80211_CHAN_NO_IBSS: IBSS is not allowed on this channel.
+ * @RTW_IEEE80211_CHAN_RADAR: Radar detection is required on this channel.
+ * @RTW_IEEE80211_CHAN_NO_HT40PLUS: extension channel above this channel
+ *      is not permitted.
+ * @RTW_IEEE80211_CHAN_NO_HT40MINUS: extension channel below this channel
+ *      is not permitted.
+ */
+enum rtw_ieee80211_channel_flags {
+	RTW_IEEE80211_CHAN_DISABLED	 = 1<<0,
+	RTW_IEEE80211_CHAN_PASSIVE_SCAN     = 1<<1,
+	RTW_IEEE80211_CHAN_NO_IBSS	  = 1<<2,
+	RTW_IEEE80211_CHAN_RADAR	    = 1<<3,
+	RTW_IEEE80211_CHAN_NO_HT40PLUS      = 1<<4,
+	RTW_IEEE80211_CHAN_NO_HT40MINUS     = 1<<5,
+};
+
+#define RTW_IEEE80211_CHAN_NO_HT40 \
+	  (RTW_IEEE80211_CHAN_NO_HT40PLUS | RTW_IEEE80211_CHAN_NO_HT40MINUS)
+
+/* Represent channel details, subset of ieee80211_channel */
+struct rtw_ieee80211_channel {
+	u16 hw_value;
+	u32 flags;
+};
+
+#define CHAN_FMT \
+	"hw_value:%u, " \
+	"flags:0x%08x" \
+
+#define CHAN_ARG(channel) \
+	(channel)->hw_value \
+	, (channel)->flags \
+
+/* Parsed Information Elements */
+struct rtw_ieee802_11_elems {
+	u8 *ssid;
+	u8 ssid_len;
+	u8 *supp_rates;
+	u8 supp_rates_len;
+	u8 *fh_params;
+	u8 fh_params_len;
+	u8 *ds_params;
+	u8 ds_params_len;
+	u8 *cf_params;
+	u8 cf_params_len;
+	u8 *tim;
+	u8 tim_len;
+	u8 *ibss_params;
+	u8 ibss_params_len;
+	u8 *challenge;
+	u8 challenge_len;
+	u8 *erp_info;
+	u8 erp_info_len;
+	u8 *ext_supp_rates;
+	u8 ext_supp_rates_len;
+	u8 *wpa_ie;
+	u8 wpa_ie_len;
+	u8 *rsn_ie;
+	u8 rsn_ie_len;
+	u8 *wme;
+	u8 wme_len;
+	u8 *wme_tspec;
+	u8 wme_tspec_len;
+	u8 *wps_ie;
+	u8 wps_ie_len;
+	u8 *power_cap;
+	u8 power_cap_len;
+	u8 *supp_channels;
+	u8 supp_channels_len;
+	u8 *mdie;
+	u8 mdie_len;
+	u8 *ftie;
+	u8 ftie_len;
+	u8 *timeout_int;
+	u8 timeout_int_len;
+	u8 *ht_capabilities;
+	u8 ht_capabilities_len;
+	u8 *ht_operation;
+	u8 ht_operation_len;
+	u8 *vendor_ht_cap;
+	u8 vendor_ht_cap_len;
+};
+
+enum parse_res {
+	ParseOK = 0,
+	ParseUnknown = 1,
+	ParseFailed = -1
+};
+
+enum parse_res rtw_ieee802_11_parse_elems(u8 *start, uint len,
+					  struct rtw_ieee802_11_elems *elems,
+					  int show_errors);
+
+u8 *rtw_set_fixed_ie(unsigned char *pbuf, unsigned int len,
+		     unsigned char *source, unsigned int *frlen);
+u8 *rtw_set_ie(u8 *pbuf, int index, uint len, u8 *source, uint *frlen);
+
+enum secondary_ch_offset {
+	SCN = 0, /* no secondary channel */
+	SCA = 1, /* secondary channel above */
+	SCB = 3,  /* secondary channel below */
+};
+u8 secondary_ch_offset_to_hal_ch_offset(u8 ch_offset);
+u8 hal_ch_offset_to_secondary_ch_offset(u8 ch_offset);
+u8 *rtw_set_ie_ch_switch(u8 *buf, u32 *buf_len, u8 ch_switch_mode,
+			 u8 new_ch, u8 ch_switch_cnt);
+u8 *rtw_set_ie_secondary_ch_offset(u8 *buf, u32 *buf_len,
+				   u8 secondary_ch_offset);
+u8 *rtw_set_ie_mesh_ch_switch_parm(u8 *buf, u32 *buf_len, u8 ttl,
+				   u8 flags, u16 reason, u16 precedence);
+
+u8 *rtw_get_ie(u8 *pbuf, int index, int *len, int limit);
+u8 *rtw_get_ie_ex(u8 *in_ie, uint in_len, u8 eid, u8 *oui,
+		  u8 oui_len, u8 *ie, uint *ielen);
+int rtw_ies_remove_ie(u8 *ies, uint *ies_len, uint offset,
+		      u8 eid, u8 *oui, u8 oui_len);
+
+void rtw_set_supported_rate(u8 *SupportedRates, uint mode);
+
+unsigned char *rtw_get_wpa_ie(unsigned char *pie, int *wpa_ie_len, int limit);
+unsigned char *rtw_get_wpa2_ie(unsigned char *pie, int *rsn_ie_len, int limit);
+int rtw_get_wpa_cipher_suite(u8 *s);
+int rtw_get_wpa2_cipher_suite(u8 *s);
+int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len);
+int rtw_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher,
+		     int *pairwise_cipher, int *is_8021x);
+int rtw_parse_wpa2_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher,
+		      int *pairwise_cipher, int *is_8021x);
+
+int rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len,
+		   u8 *wpa_ie, u16 *wpa_len);
+
+u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen);
+u8 *rtw_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen);
+u8 *rtw_get_wps_attr(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
+		     u8 *buf_attr, u32 *len_attr);
+u8 *rtw_get_wps_attr_content(u8 *wps_ie, uint wps_ielen, u16 target_attr_id,
+			     u8 *buf_content, uint *len_content);
+
+/**
+ * for_each_ie - iterate over continuous IEs
+ * @ie:
+ * @buf:
+ * @buf_len:
+ */
+#define for_each_ie(ie, buf, buf_len) \
+	for (ie = (void *)buf; (((u8 *)ie) - ((u8 *)buf) + 1) < buf_len;	\
+		ie = (void *)(((u8 *)ie) + *(((u8 *)ie)+1) + 2))
+
+void dump_ies(u8 *buf, u32 buf_len);
+void dump_wps_ie(u8 *ie, u32 ie_len);
+
+#ifdef CONFIG_88EU_P2P
+void dump_p2p_ie(u8 *ie, u32 ie_len);
+u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen);
+u8 *rtw_get_p2p_attr(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id,
+		     u8 *buf_attr, u32 *len_attr);
+u8 *rtw_get_p2p_attr_content(u8 *p2p_ie, uint p2p_ielen, u8 target_attr_id,
+			     u8 *buf_content, uint *len_content);
+u32 rtw_set_p2p_attr_content(u8 *pbuf, u8 attr_id, u16 attr_len,
+			     u8 *pdata_attr);
+void rtw_wlan_bssid_ex_remove_p2p_attr(struct wlan_bssid_ex *bss_ex,
+				       u8 attr_id);
+#endif
+
+uint	rtw_get_rateset_len(u8	*rateset);
+
+struct registry_priv;
+int rtw_generate_ie(struct registry_priv *pregistrypriv);
+
+int rtw_get_bit_value_from_ieee_value(u8 val);
+
+uint	rtw_is_cckrates_included(u8 *rate);
+
+uint	rtw_is_cckratesonly_included(u8 *rate);
+
+int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
+
+void rtw_get_bcn_info(struct wlan_network *pnetwork);
+
+void rtw_macaddr_cfg(u8 *mac_addr);
+
+u16 rtw_mcs_rate(u8 rf_type, u8 bw_40MHz, u8 short_GI_20, u8 short_GI_40,
+		 unsigned char *MCS_rate);
+
+int rtw_action_frame_parse(const u8 *frame, u32 frame_len, u8 *category,
+			   u8 *action);
+const char *action_public_str(u8 action);
+
+#endif /* IEEE80211_H */
diff --git a/drivers/staging/r8188eu/include/ieee80211_ext.h b/drivers/staging/r8188eu/include/ieee80211_ext.h
new file mode 100644
index 000000000000..fa9e52572fe9
--- /dev/null
+++ b/drivers/staging/r8188eu/include/ieee80211_ext.h
@@ -0,0 +1,287 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __IEEE80211_EXT_H
+#define __IEEE80211_EXT_H
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define WMM_OUI_TYPE 2
+#define WMM_OUI_SUBTYPE_INFORMATION_ELEMENT 0
+#define WMM_OUI_SUBTYPE_PARAMETER_ELEMENT 1
+#define WMM_OUI_SUBTYPE_TSPEC_ELEMENT 2
+#define WMM_VERSION 1
+
+#define WPA_PROTO_WPA BIT(0)
+#define WPA_PROTO_RSN BIT(1)
+
+#define WPA_KEY_MGMT_IEEE8021X BIT(0)
+#define WPA_KEY_MGMT_PSK BIT(1)
+#define WPA_KEY_MGMT_NONE BIT(2)
+#define WPA_KEY_MGMT_IEEE8021X_NO_WPA BIT(3)
+#define WPA_KEY_MGMT_WPA_NONE BIT(4)
+
+#define WPA_CAPABILITY_PREAUTH BIT(0)
+#define WPA_CAPABILITY_MGMT_FRAME_PROTECTION BIT(6)
+#define WPA_CAPABILITY_PEERKEY_ENABLED BIT(9)
+
+#define PMKID_LEN 16
+
+struct wpa_ie_hdr {
+	u8 elem_id;
+	u8 len;
+	u8 oui[4]; /* 24-bit OUI followed by 8-bit OUI type */
+	u8 version[2]; /* little endian */
+} __packed;
+
+struct rsn_ie_hdr {
+	u8 elem_id; /* WLAN_EID_RSN */
+	u8 len;
+	u8 version[2]; /* little endian */
+} __packed;
+
+struct wme_ac_parameter {
+#if defined(__LITTLE_ENDIAN)
+	/* byte 1 */
+	u8	aifsn:4,
+		acm:1,
+		aci:2,
+		reserved:1;
+
+	/* byte 2 */
+	u8	eCWmin:4,
+		eCWmax:4;
+#elif defined(__BIG_ENDIAN)
+	/* byte 1 */
+	u8	reserved:1,
+		aci:2,
+		acm:1,
+		aifsn:4;
+
+	/* byte 2 */
+	u8	eCWmax:4,
+		eCWmin:4;
+#else
+#error	"Please fix <endian.h>"
+#endif
+
+	/* bytes 3 & 4 */
+	u16 txopLimit;
+} __packed;
+
+struct wme_parameter_element {
+	/* required fields for WME version 1 */
+	u8 oui[3];
+	u8 oui_type;
+	u8 oui_subtype;
+	u8 version;
+	u8 acInfo;
+	u8 reserved;
+	struct wme_ac_parameter ac[4];
+
+} __packed;
+
+#define WPA_PUT_LE16(a, val)			\
+	do {					\
+		(a)[1] = ((u16) (val)) >> 8;	\
+		(a)[0] = ((u16) (val)) & 0xff;	\
+	} while (0)
+
+#define WPA_PUT_BE32(a, val)					\
+	do {							\
+		(a)[0] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
+		(a)[1] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
+		(a)[2] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
+		(a)[3] = (u8) (((u32) (val)) & 0xff);		\
+	} while (0)
+
+#define WPA_PUT_LE32(a, val)					\
+	do {							\
+		(a)[3] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
+		(a)[2] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
+		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
+		(a)[0] = (u8) (((u32) (val)) & 0xff);		\
+	} while (0)
+
+#define RSN_SELECTOR_PUT(a, val) WPA_PUT_BE32((u8 *)(a), (val))
+
+/* Action category code */
+enum ieee80211_category {
+	WLAN_CATEGORY_SPECTRUM_MGMT = 0,
+	WLAN_CATEGORY_QOS = 1,
+	WLAN_CATEGORY_DLS = 2,
+	WLAN_CATEGORY_BACK = 3,
+	WLAN_CATEGORY_HT = 7,
+	WLAN_CATEGORY_WMM = 17,
+};
+
+/* SPECTRUM_MGMT action code */
+enum ieee80211_spectrum_mgmt_actioncode {
+	WLAN_ACTION_SPCT_MSR_REQ = 0,
+	WLAN_ACTION_SPCT_MSR_RPRT = 1,
+	WLAN_ACTION_SPCT_TPC_REQ = 2,
+	WLAN_ACTION_SPCT_TPC_RPRT = 3,
+	WLAN_ACTION_SPCT_CHL_SWITCH = 4,
+	WLAN_ACTION_SPCT_EXT_CHL_SWITCH = 5,
+};
+
+/* BACK action code */
+enum ieee80211_back_actioncode {
+	WLAN_ACTION_ADDBA_REQ = 0,
+	WLAN_ACTION_ADDBA_RESP = 1,
+	WLAN_ACTION_DELBA = 2,
+};
+
+/* HT features action code */
+enum ieee80211_ht_actioncode {
+	WLAN_ACTION_NOTIFY_CH_WIDTH = 0,
+	WLAN_ACTION_SM_PS = 1,
+	WLAN_ACTION_PSPM = 2,
+	WLAN_ACTION_PCO_PHASE = 3,
+	WLAN_ACTION_MIMO_CSI_MX = 4,
+	WLAN_ACTION_MIMO_NONCP_BF = 5,
+	WLAN_ACTION_MIMP_CP_BF = 6,
+	WLAN_ACTION_ASEL_INDICATES_FB = 7,
+	WLAN_ACTION_HI_INFO_EXCHG = 8,
+};
+
+/* BACK (block-ack) parties */
+enum ieee80211_back_parties {
+	WLAN_BACK_RECIPIENT = 0,
+	WLAN_BACK_INITIATOR = 1,
+	WLAN_BACK_TIMER = 2,
+};
+
+struct ieee80211_mgmt {
+	u16 frame_control;
+	u16 duration;
+	u8 da[6];
+	u8 sa[6];
+	u8 bssid[6];
+	u16 seq_ctrl;
+	union {
+		struct {
+			u16 auth_alg;
+			u16 auth_transaction;
+			u16 status_code;
+			/* possibly followed by Challenge text */
+			u8 variable[0];
+		}  __packed auth;
+		struct {
+			u16 reason_code;
+		}  __packed deauth;
+		struct {
+			u16 capab_info;
+			u16 listen_interval;
+			/* followed by SSID and Supported rates */
+			u8 variable[0];
+		}  __packed assoc_req;
+		struct {
+			u16 capab_info;
+			u16 status_code;
+			u16 aid;
+			/* followed by Supported rates */
+			u8 variable[0];
+		}  __packed assoc_resp, reassoc_resp;
+		struct {
+			u16 capab_info;
+			u16 listen_interval;
+			u8 current_ap[6];
+			/* followed by SSID and Supported rates */
+			u8 variable[0];
+		}  __packed reassoc_req;
+		struct {
+			u16 reason_code;
+		}  __packed disassoc;
+		struct {
+			__le64 timestamp;
+			u16 beacon_int;
+			u16 capab_info;
+			/* followed by some of SSID, Supported rates,
+			 * FH Params, DS Params, CF Params, IBSS Params, TIM */
+			u8 variable[0];
+		}  __packed beacon;
+		struct {
+			/* only variable items: SSID, Supported rates */
+			u8 variable[0];
+		}  __packed probe_req;
+		struct {
+			__le64 timestamp;
+			u16 beacon_int;
+			u16 capab_info;
+			/* followed by some of SSID, Supported rates,
+			 * FH Params, DS Params, CF Params, IBSS Params */
+			u8 variable[0];
+		}  __packed probe_resp;
+		struct {
+			u8 category;
+			union {
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u8 status_code;
+					u8 variable[0];
+				}  __packed wme_action;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u16 capab;
+					u16 timeout;
+					u16 start_seq_num;
+				}  __packed addba_req;
+				struct {
+					u8 action_code;
+					u8 dialog_token;
+					u16 status;
+					u16 capab;
+					u16 timeout;
+				}  __packed addba_resp;
+				struct {
+					u8 action_code;
+					u16 params;
+					u16 reason_code;
+				}  __packed delba;
+				structi {
+					u8 action_code;
+					/* capab_info for open and confirm,
+					 * reason for close
+					 */
+					u16 aux;
+					/* Followed in plink_confirm by status
+					 * code, AID and supported rates,
+					 * and directly by supported rates in
+					 * plink_open and plink_close
+					 */
+					u8 variable[0];
+				}  __packed plink_action;
+				struct{
+					u8 action_code;
+					u8 variable[0];
+				}  __packed mesh_action;
+			} __packed u;
+		}  __packed action;
+	} __packed u;
+} __packed;
+
+/* mgmt header + 1 byte category code */
+#define IEEE80211_MIN_ACTION_SIZE				\
+	 FIELD_OFFSET(struct ieee80211_mgmt, u.action.u)
+
+#endif
diff --git a/drivers/staging/r8188eu/include/if_ether.h b/drivers/staging/r8188eu/include/if_ether.h
new file mode 100644
index 000000000000..db157712a203
--- /dev/null
+++ b/drivers/staging/r8188eu/include/if_ether.h
@@ -0,0 +1,111 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef _LINUX_IF_ETHER_H
+#define _LINUX_IF_ETHER_H
+
+/*
+ *	IEEE 802.3 Ethernet magic constants.  The frame sizes omit the preamble
+ *	and FCS/CRC (frame check sequence).
+ */
+
+#define ETH_ALEN	6		/* Octets in one ethernet addr	 */
+#define ETH_HLEN	14		/* Total octets in header.	 */
+#define ETH_ZLEN	60		/* Min. octets in frame sans FCS */
+#define ETH_DATA_LEN	1500		/* Max. octets in payload	 */
+#define ETH_FRAME_LEN	1514		/* Max. octets in frame sans FCS */
+
+/*
+ *	These are the defined Ethernet Protocol ID's.
+ */
+
+#define ETH_P_LOOP	0x0060		/* Ethernet Loopback packet	*/
+#define ETH_P_PUP	0x0200		/* Xerox PUP packet		*/
+#define ETH_P_PUPAT	0x0201		/* Xerox PUP Addr Trans packet	*/
+#define ETH_P_IP	0x0800		/* Internet Protocol packet	*/
+#define ETH_P_X25	0x0805		/* CCITT X.25			*/
+#define ETH_P_ARP	0x0806		/* Address Resolution packet	*/
+#define	ETH_P_BPQ	0x08FF		/* G8BPQ AX.25 Ethernet Packet  */
+#define ETH_P_IEEEPUP	0x0a00		/* Xerox IEEE802.3 PUP packet   */
+#define ETH_P_IEEEPUPAT	0x0a01		/* Xerox IEEE802.3 PUP		*/
+#define ETH_P_DEC       0x6000          /* DEC Assigned proto           */
+#define ETH_P_DNA_DL    0x6001          /* DEC DNA Dump/Load            */
+#define ETH_P_DNA_RC    0x6002          /* DEC DNA Remote Console       */
+#define ETH_P_DNA_RT    0x6003          /* DEC DNA Routing              */
+#define ETH_P_LAT       0x6004          /* DEC LAT                      */
+#define ETH_P_DIAG      0x6005          /* DEC Diagnostics              */
+#define ETH_P_CUST      0x6006          /* DEC Customer use             */
+#define ETH_P_SCA       0x6007          /* DEC Systems Comms Arch       */
+#define ETH_P_RARP      0x8035		/* Reverse Addr Res packet	*/
+#define ETH_P_ATALK	0x809B		/* Appletalk DDP		*/
+#define ETH_P_AARP	0x80F3		/* Appletalk AARP		*/
+#define ETH_P_8021Q	0x8100          /* 802.1Q VLAN Extended Header  */
+#define ETH_P_IPX	0x8137		/* IPX over DIX			*/
+#define ETH_P_IPV6	0x86DD		/* IPv6 over bluebook		*/
+#define ETH_P_PPP_DISC	0x8863		/* PPPoE discovery messages     */
+#define ETH_P_PPP_SES	0x8864		/* PPPoE session messages	*/
+#define ETH_P_ATMMPOA	0x884c		/* MultiProtocol Over ATM	*/
+#define ETH_P_ATMFATE	0x8884		/* Frame-based ATM Transport
+					 * over Ethernet
+					 */
+
+/*
+ *	Non DIX types. Won't clash for 1500 types.
+ */
+
+#define ETH_P_802_3	0x0001		/* Dummy type for 802.3 frames  */
+#define ETH_P_AX25	0x0002		/* Dummy protocol id for AX.25  */
+#define ETH_P_ALL	0x0003		/* Every packet (be careful!!!) */
+#define ETH_P_802_2	0x0004		/* 802.2 frames			*/
+#define ETH_P_SNAP	0x0005		/* Internal only		*/
+#define ETH_P_DDCMP     0x0006          /* DEC DDCMP: Internal only     */
+#define ETH_P_WAN_PPP   0x0007          /* Dummy type for WAN PPP frames*/
+#define ETH_P_PPP_MP    0x0008          /* Dummy type for PPP MP frames */
+#define ETH_P_LOCALTALK 0x0009		/* Localtalk pseudo type	*/
+#define ETH_P_PPPTALK	0x0010		/* Dummy type for Atalk over PPP*/
+#define ETH_P_TR_802_2	0x0011		/* 802.2 frames			*/
+#define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
+#define ETH_P_CONTROL	0x0016		/* Card specific control frames */
+#define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
+#define ETH_P_ECONET	0x0018		/* Acorn Econet			*/
+
+/*
+ *	This is an Ethernet frame header.
+ */
+
+struct ethhdr {
+	unsigned char	h_dest[ETH_ALEN];	/* destination eth addr	*/
+	unsigned char	h_source[ETH_ALEN];	/* source ether addr	*/
+	unsigned short	h_proto;		/* packet type ID field	*/
+};
+
+struct _vlan {
+	unsigned short       h_vlan_TCI;	/*  Encap prio and VLAN ID */
+	unsigned short       h_vlan_encapsulated_proto;
+};
+
+#define get_vlan_id(pvlan)				\
+	((ntohs((unsigned short)pvlan->h_vlan_TCI)) & 0xfff)
+#define get_vlan_priority(pvlan)			\
+	((ntohs((unsigned short)pvlan->h_vlan_TCI))>>13)
+#define get_vlan_encap_proto(pvlan)			\
+	 (ntohs((unsigned short)pvlan->h_vlan_encapsulated_proto))
+
+#endif	/* _LINUX_IF_ETHER_H */
diff --git a/drivers/staging/r8188eu/include/ioctl_cfg80211.h b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
new file mode 100644
index 000000000000..037e9a5e5af9
--- /dev/null
+++ b/drivers/staging/r8188eu/include/ioctl_cfg80211.h
@@ -0,0 +1,107 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __IOCTL_CFG80211_H__
+#define __IOCTL_CFG80211_H__
+
+struct rtw_wdev_invit_info {
+	u8 token;
+	u8 flags;
+	u8 status;
+	u8 req_op_ch;
+	u8 rsp_op_ch;
+};
+
+#define rtw_wdev_invit_info_init(invit_info) \
+	do { \
+		(invit_info)->token = 0; \
+		(invit_info)->flags = 0x00; \
+		(invit_info)->status = 0xff; \
+		(invit_info)->req_op_ch = 0; \
+		(invit_info)->rsp_op_ch = 0; \
+	} while (0)
+
+struct rtw_wdev_priv {
+	struct wireless_dev *rtw_wdev;
+
+	struct adapter *padapter;
+
+	struct cfg80211_scan_request *scan_request;
+	spinlock_t scan_req_lock;
+
+	struct net_device *pmon_ndev;/* for monitor interface */
+	char ifname_mon[IFNAMSIZ + 1]; /* name of monitor interface */
+
+	u8 p2p_enabled;
+
+	u8 provdisc_req_issued;
+
+	struct rtw_wdev_invit_info invit_info;
+
+	u8 bandroid_scan;
+	bool block;
+	bool power_mgmt;
+};
+
+#define wdev_to_priv(w) ((struct rtw_wdev_priv *)(wdev_priv(w)))
+
+#define wiphy_to_wdev(x)				\
+((struct wireless_dev *)(((struct rtw_wdev_priv *)wiphy_priv(x))->rtw_wdev))
+
+int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);
+void rtw_wdev_free(struct wireless_dev *wdev);
+void rtw_wdev_unregister(struct wireless_dev *wdev);
+
+void rtw_cfg80211_init_wiphy(struct adapter *padapter);
+
+void rtw_cfg80211_surveydone_event_callback(struct adapter *padapter);
+
+void rtw_cfg80211_indicate_connect(struct adapter *padapter);
+void rtw_cfg80211_indicate_disconnect(struct adapter *padapter);
+void rtw_cfg80211_indicate_scan_done(struct rtw_wdev_priv *pwdev_priv,
+				     bool aborted);
+
+#ifdef CONFIG_88EU_AP_MODE
+void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter,
+				     u8 *pmgmt_frame, uint frame_len);
+void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter,
+					unsigned char *da,
+					unsigned short reason);
+#endif /* CONFIG_88EU_AP_MODE */
+
+void rtw_cfg80211_issue_p2p_provision_request(struct adapter *padapter,
+					      const u8 *buf, size_t len);
+void rtw_cfg80211_rx_p2p_action_public(struct adapter *padapter,
+				       u8 *pmgmt_frame, uint frame_len);
+void rtw_cfg80211_rx_action_p2p(struct adapter *padapter, u8 *pmgmt_frame,
+				uint frame_len);
+void rtw_cfg80211_rx_action(struct adapter *adapter, u8 *frame,
+			    uint frame_len, const char *msg);
+
+int rtw_cfg80211_set_mgnt_wpsp2pie(struct net_device *net,
+				   char *buf, int len, int type);
+
+bool rtw_cfg80211_pwr_mgmt(struct adapter *adapter);
+
+#define rtw_cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)		\
+	cfg80211_rx_mgmt(dev, freq, sig_dbm, buf, len, gfp)
+#define rtw_cfg80211_send_rx_assoc(dev, bss, buf, len)			\
+	cfg80211_send_rx_assoc(dev, bss, buf, len)
+
+#endif /* __IOCTL_CFG80211_H__ */
diff --git a/drivers/staging/r8188eu/include/ip.h b/drivers/staging/r8188eu/include/ip.h
new file mode 100644
index 000000000000..0107ac15c6ed
--- /dev/null
+++ b/drivers/staging/r8188eu/include/ip.h
@@ -0,0 +1,125 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _LINUX_IP_H
+#define _LINUX_IP_H
+
+/* SOL_IP socket options */
+
+#define IPTOS_TOS_MASK		0x1E
+#define IPTOS_TOS(tos)		((tos)&IPTOS_TOS_MASK)
+#define	IPTOS_LOWDELAY		0x10
+#define	IPTOS_THROUGHPUT	0x08
+#define	IPTOS_RELIABILITY	0x04
+#define	IPTOS_MINCOST		0x02
+
+#define IPTOS_PREC_MASK		0xE0
+#define IPTOS_PREC(tos)		((tos)&IPTOS_PREC_MASK)
+#define IPTOS_PREC_NETCONTROL           0xe0
+#define IPTOS_PREC_INTERNETCONTROL      0xc0
+#define IPTOS_PREC_CRITIC_ECP           0xa0
+#define IPTOS_PREC_FLASHOVERRIDE        0x80
+#define IPTOS_PREC_FLASH                0x60
+#define IPTOS_PREC_IMMEDIATE            0x40
+#define IPTOS_PREC_PRIORITY             0x20
+#define IPTOS_PREC_ROUTINE              0x00
+
+/* IP options */
+#define IPOPT_COPY		0x80
+#define IPOPT_CLASS_MASK	0x60
+#define IPOPT_NUMBER_MASK	0x1f
+
+#define	IPOPT_COPIED(o)		((o)&IPOPT_COPY)
+#define	IPOPT_CLASS(o)		((o)&IPOPT_CLASS_MASK)
+#define	IPOPT_NUMBER(o)		((o)&IPOPT_NUMBER_MASK)
+
+#define	IPOPT_CONTROL		0x00
+#define	IPOPT_RESERVED1		0x20
+#define	IPOPT_MEASUREMENT	0x40
+#define	IPOPT_RESERVED2		0x60
+
+#define IPOPT_END	(0 | IPOPT_CONTROL)
+#define IPOPT_NOOP	(1 | IPOPT_CONTROL)
+#define IPOPT_SEC	(2 | IPOPT_CONTROL | IPOPT_COPY)
+#define IPOPT_LSRR	(3 | IPOPT_CONTROL | IPOPT_COPY)
+#define IPOPT_TIMESTAMP	(4 | IPOPT_MEASUREMENT)
+#define IPOPT_RR	(7 | IPOPT_CONTROL)
+#define IPOPT_SID	(8 | IPOPT_CONTROL | IPOPT_COPY)
+#define IPOPT_SSRR	(9 | IPOPT_CONTROL | IPOPT_COPY)
+#define IPOPT_RA	(20 | IPOPT_CONTROL | IPOPT_COPY)
+
+#define IPVERSION	4
+#define MAXTTL		255
+#define IPDEFTTL	64
+#define IPOPT_OPTVAL 0
+#define IPOPT_OLEN   1
+#define IPOPT_OFFSET 2
+#define IPOPT_MINOFF 4
+#define MAX_IPOPTLEN 40
+#define IPOPT_NOP IPOPT_NOOP
+#define IPOPT_EOL IPOPT_END
+#define IPOPT_TS  IPOPT_TIMESTAMP
+
+#define	IPOPT_TS_TSONLY		0	/* timestamps only */
+#define	IPOPT_TS_TSANDADDR	1	/* timestamps and addresses */
+#define	IPOPT_TS_PRESPEC	3	/* specified modules only */
+
+struct ip_options {
+	__u32		faddr;			/* Saved first hop address */
+	unsigned char	optlen;
+	unsigned char srr;
+	unsigned char rr;
+	unsigned char ts;
+	unsigned char	is_setbyuser:1,	/* Set by setsockopt?		*/
+			is_data:1,	/* Options in __data, rather than skb*/
+			is_strictroute:1,/* Strict source route		*/
+			srr_is_hit:1,	/* Packet destn addr was ours */
+			is_changed:1,	/* IP checksum more not valid	*/
+			rr_needaddr:1,	/* Need to record addr of out dev*/
+			ts_needtime:1,	/* Need to record timestamp	*/
+			ts_needaddr:1;	/* Need to record addr of out dev  */
+	unsigned char router_alert;
+	unsigned char __pad1;
+	unsigned char __pad2;
+	unsigned char __data[0];
+};
+
+#define optlength(opt) (sizeof(struct ip_options) + opt->optlen)
+
+struct iphdr {
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	__u8	ihl:4,
+		version:4;
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	__u8	version:4,
+		ihl:4;
+#endif
+	__u8	tos;
+	__u16	tot_len;
+	__u16	id;
+	__u16	frag_off;
+	__u8	ttl;
+	__u8	protocol;
+	__u16	check;
+	__u32	saddr;
+	__u32	daddr;
+	/*The options start here. */
+};
+
+#endif	/* _LINUX_IP_H */
diff --git a/drivers/staging/r8188eu/include/mlme_osdep.h b/drivers/staging/r8188eu/include/mlme_osdep.h
new file mode 100644
index 000000000000..ae1722c67032
--- /dev/null
+++ b/drivers/staging/r8188eu/include/mlme_osdep.h
@@ -0,0 +1,35 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef	__MLME_OSDEP_H_
+#define __MLME_OSDEP_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+void rtw_init_mlme_timer(struct adapter *padapter);
+void rtw_os_indicate_disconnect(struct adapter *adapter);
+void rtw_os_indicate_connect(struct adapter *adapter);
+void rtw_os_indicate_scan_done(struct adapter *padapter, bool aborted);
+void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
+
+void rtw_reset_securitypriv(struct adapter *adapter);
+void indicate_wx_scan_complete_event(struct adapter *padapter);
+
+#endif	/* _MLME_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/include/mp_custom_oid.h b/drivers/staging/r8188eu/include/mp_custom_oid.h
new file mode 100644
index 000000000000..be4f11864f63
--- /dev/null
+++ b/drivers/staging/r8188eu/include/mp_custom_oid.h
@@ -0,0 +1,349 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef	__CUSTOM_OID_H
+#define __CUSTOM_OID_H
+
+/*  by Owen */
+/*  0xFF818000 - 0xFF81802F		RTL8180 Mass Production Kit */
+/*  0xFF818500 - 0xFF81850F		RTL8185 Setup Utility */
+/*  0xFF818580 - 0xFF81858F		RTL8185 Phy Status Utility */
+
+/*  */
+
+/*  by Owen for Production Kit */
+/*  For Production Kit with Agilent Equipments */
+/*  in order to make our custom oids hopefully somewhat unique */
+/*  we will use 0xFF (indicating implementation specific OID) */
+/*	81(first byte of non zero Realtek unique identifier) */
+/*	80 (second byte of non zero Realtek unique identifier) */
+/*	XX (the custom OID number - providing 255 possible custom oids) */
+
+#define OID_RT_PRO_RESET_DUT				0xFF818000
+#define OID_RT_PRO_SET_DATA_RATE			0xFF818001
+#define OID_RT_PRO_START_TEST				0xFF818002
+#define OID_RT_PRO_STOP_TEST				0xFF818003
+#define OID_RT_PRO_SET_PREAMBLE				0xFF818004
+#define OID_RT_PRO_SET_SCRAMBLER			0xFF818005
+#define OID_RT_PRO_SET_FILTER_BB			0xFF818006
+#define OID_RT_PRO_SET_MANUAL_DIVERSITY_BB		0xFF818007
+#define OID_RT_PRO_SET_CHANNEL_DIRECT_CALL		0xFF818008
+#define OID_RT_PRO_SET_SLEEP_MODE_DIRECT_CALL		0xFF818009
+#define OID_RT_PRO_SET_WAKE_MODE_DIRECT_CALL		0xFF81800A
+
+#define OID_RT_PRO_SET_TX_ANTENNA_BB			0xFF81800D
+#define OID_RT_PRO_SET_ANTENNA_BB			0xFF81800E
+#define OID_RT_PRO_SET_CR_SCRAMBLER			0xFF81800F
+#define OID_RT_PRO_SET_CR_NEW_FILTER			0xFF818010
+#define OID_RT_PRO_SET_TX_POWER_CONTROL			0xFF818011
+#define OID_RT_PRO_SET_CR_TX_CONFIG			0xFF818012
+#define OID_RT_PRO_GET_TX_POWER_CONTROL			0xFF818013
+#define OID_RT_PRO_GET_CR_SIGNAL_QUALITY		0xFF818014
+#define OID_RT_PRO_SET_CR_SETPOINT			0xFF818015
+#define OID_RT_PRO_SET_INTEGRATOR			0xFF818016
+#define OID_RT_PRO_SET_SIGNAL_QUALITY			0xFF818017
+#define OID_RT_PRO_GET_INTEGRATOR			0xFF818018
+#define OID_RT_PRO_GET_SIGNAL_QUALITY			0xFF818019
+#define OID_RT_PRO_QUERY_EEPROM_TYPE			0xFF81801A
+#define OID_RT_PRO_WRITE_MAC_ADDRESS			0xFF81801B
+#define OID_RT_PRO_READ_MAC_ADDRESS			0xFF81801C
+#define OID_RT_PRO_WRITE_CIS_DATA			0xFF81801D
+#define OID_RT_PRO_READ_CIS_DATA			0xFF81801E
+#define OID_RT_PRO_WRITE_POWER_CONTROL			0xFF81801F
+#define OID_RT_PRO_READ_POWER_CONTROL			0xFF818020
+#define OID_RT_PRO_WRITE_EEPROM				0xFF818021
+#define OID_RT_PRO_READ_EEPROM				0xFF818022
+#define OID_RT_PRO_RESET_TX_PACKET_SENT			0xFF818023
+#define OID_RT_PRO_QUERY_TX_PACKET_SENT			0xFF818024
+#define OID_RT_PRO_RESET_RX_PACKET_RECEIVED		0xFF818025
+#define OID_RT_PRO_QUERY_RX_PACKET_RECEIVED		0xFF818026
+#define OID_RT_PRO_QUERY_RX_PACKET_CRC32_ERROR		0xFF818027
+#define OID_RT_PRO_QUERY_CURRENT_ADDRESS		0xFF818028
+#define OID_RT_PRO_QUERY_PERMANENT_ADDRESS		0xFF818029
+#define OID_RT_PRO_SET_PHILIPS_RF_PARAMETERS		0xFF81802A
+#define OID_RT_PRO_RECEIVE_PACKET			0xFF81802C
+/*  added by Owen on 04/08/03 for Cameo's request */
+#define OID_RT_PRO_WRITE_EEPROM_BYTE			0xFF81802D
+#define OID_RT_PRO_READ_EEPROM_BYTE			0xFF81802E
+#define OID_RT_PRO_SET_MODULATION			0xFF81802F
+/*  */
+
+/* Sean */
+#define OID_RT_DRIVER_OPTION				0xFF818080
+#define OID_RT_RF_OFF					0xFF818081
+#define OID_RT_AUTH_STATUS				0xFF818082
+
+/*  */
+#define OID_RT_PRO_SET_CONTINUOUS_TX			0xFF81800B
+#define OID_RT_PRO_SET_SINGLE_CARRIER_TX		0xFF81800C
+#define OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX		0xFF81802B
+#define OID_RT_PRO_SET_SINGLE_TONE_TX			0xFF818043
+/*  */
+
+/*  by Owen for RTL8185 Phy Status Report Utility */
+#define OID_RT_UTILITY_false_ALARM_COUNTERS		0xFF818580
+#define OID_RT_UTILITY_SELECT_DEBUG_MODE		0xFF818581
+#define OID_RT_UTILITY_SELECT_SUBCARRIER_NUMBER		0xFF818582
+#define OID_RT_UTILITY_GET_RSSI_STATUS			0xFF818583
+#define OID_RT_UTILITY_GET_FRAME_DETECTION_STATUS	0xFF818584
+#define OID_RT_UTILITY_GET_AGC_AND_FREQUENCY_OFFSET_ESTIMATION_STATUS	\
+							0xFF818585
+#define OID_RT_UTILITY_GET_CHANNEL_ESTIMATION_STATUS	0xFF818586
+/*  */
+
+/*  by Owen on 03/09/19-03/09/22 for RTL8185 */
+#define OID_RT_WIRELESS_MODE				0xFF818500
+#define OID_RT_SUPPORTED_RATES				0xFF818501
+#define OID_RT_DESIRED_RATES				0xFF818502
+#define OID_RT_WIRELESS_MODE_STARTING_ADHOC		0xFF818503
+/*  */
+
+#define OID_RT_GET_CONNECT_STATE			0xFF030001
+#define OID_RT_RESCAN					0xFF030002
+#define OID_RT_SET_KEY_LENGTH				0xFF030003
+#define OID_RT_SET_DEFAULT_KEY_ID			0xFF030004
+
+#define OID_RT_SET_CHANNEL				0xFF010182
+#define OID_RT_SET_SNIFFER_MODE				0xFF010183
+#define OID_RT_GET_SIGNAL_QUALITY			0xFF010184
+#define OID_RT_GET_SMALL_PACKET_CRC			0xFF010185
+#define OID_RT_GET_MIDDLE_PACKET_CRC			0xFF010186
+#define OID_RT_GET_LARGE_PACKET_CRC			0xFF010187
+#define OID_RT_GET_TX_RETRY				0xFF010188
+#define OID_RT_GET_RX_RETRY				0xFF010189
+#define OID_RT_PRO_SET_FW_DIG_STATE			0xFF01018A/* S */
+#define OID_RT_PRO_SET_FW_RA_STATE			0xFF01018B/* S */
+
+#define OID_RT_GET_RX_TOTAL_PACKET			0xFF010190
+#define OID_RT_GET_TX_BEACON_OK				0xFF010191
+#define OID_RT_GET_TX_BEACON_ERR			0xFF010192
+#define OID_RT_GET_RX_ICV_ERR				0xFF010193
+#define OID_RT_SET_ENCRYPTION_ALGORITHM			0xFF010194
+#define OID_RT_SET_NO_AUTO_RESCAN			0xFF010195
+#define OID_RT_GET_PREAMBLE_MODE			0xFF010196
+#define OID_RT_GET_DRIVER_UP_DELTA_TIME			0xFF010197
+#define OID_RT_GET_AP_IP				0xFF010198
+#define OID_RT_GET_CHANNELPLAN				0xFF010199
+#define OID_RT_SET_PREAMBLE_MODE			0xFF01019A
+#define OID_RT_SET_BCN_INTVL				0xFF01019B
+#define OID_RT_GET_RF_VENDER				0xFF01019C
+#define OID_RT_DEDICATE_PROBE				0xFF01019D
+#define OID_RT_PRO_RX_FILTER_PATTERN			0xFF01019E
+
+#define OID_RT_GET_DCST_CURRENT_THRESHOLD		0xFF01019F
+
+#define OID_RT_GET_CCA_ERR				0xFF0101A0
+#define OID_RT_GET_CCA_UPGRADE_THRESHOLD		0xFF0101A1
+#define OID_RT_GET_CCA_FALLBACK_THRESHOLD		0xFF0101A2
+
+#define OID_RT_GET_CCA_UPGRADE_EVALUATE_TIMES		0xFF0101A3
+#define OID_RT_GET_CCA_FALLBACK_EVALUATE_TIMES		0xFF0101A4
+
+/*  by Owen on 03/31/03 for Cameo's request */
+#define OID_RT_SET_RATE_ADAPTIVE			0xFF0101A5
+/*  */
+#define OID_RT_GET_DCST_EVALUATE_PERIOD			0xFF0101A5
+#define OID_RT_GET_DCST_TIME_UNIT_INDEX			0xFF0101A6
+#define OID_RT_GET_TOTAL_TX_BYTES			0xFF0101A7
+#define OID_RT_GET_TOTAL_RX_BYTES			0xFF0101A8
+#define OID_RT_CURRENT_TX_POWER_LEVEL			0xFF0101A9
+#define OID_RT_GET_ENC_KEY_MISMATCH_COUNT		0xFF0101AA
+#define OID_RT_GET_ENC_KEY_MATCH_COUNT			0xFF0101AB
+#define OID_RT_GET_CHANNEL				0xFF0101AC
+
+#define OID_RT_SET_CHANNELPLAN				0xFF0101AD
+#define OID_RT_GET_HARDWARE_RADIO_OFF			0xFF0101AE
+#define OID_RT_CHANNELPLAN_BY_COUNTRY			0xFF0101AF
+#define OID_RT_SCAN_AVAILABLE_BSSID			0xFF0101B0
+#define OID_RT_GET_HARDWARE_VERSION			0xFF0101B1
+#define OID_RT_GET_IS_ROAMING				0xFF0101B2
+#define OID_RT_GET_IS_PRIVACY				0xFF0101B3
+#define OID_RT_GET_KEY_MISMATCH				0xFF0101B4
+#define OID_RT_SET_RSSI_ROAM_TRAFFIC_TH			0xFF0101B5
+#define OID_RT_SET_RSSI_ROAM_SIGNAL_TH			0xFF0101B6
+#define OID_RT_RESET_LOG				0xFF0101B7
+#define OID_RT_GET_LOG					0xFF0101B8
+#define OID_RT_SET_INDICATE_HIDDEN_AP			0xFF0101B9
+#define OID_RT_GET_HEADER_FAIL				0xFF0101BA
+#define OID_RT_SUPPORTED_WIRELESS_MODE			0xFF0101BB
+#define OID_RT_GET_CHANNEL_LIST				0xFF0101BC
+#define OID_RT_GET_SCAN_IN_PROGRESS			0xFF0101BD
+#define OID_RT_GET_TX_INFO				0xFF0101BE
+#define OID_RT_RF_READ_WRITE_OFFSET			0xFF0101BF
+#define OID_RT_RF_READ_WRITE				0xFF0101C0
+
+/*  For Netgear request. 2005.01.13, by rcnjko. */
+#define OID_RT_FORCED_DATA_RATE				0xFF0101C1
+#define OID_RT_WIRELESS_MODE_FOR_SCAN_LIST		0xFF0101C2
+/*  For Netgear request. 2005.02.17, by rcnjko. */
+#define OID_RT_GET_BSS_WIRELESS_MODE			0xFF0101C3
+/*  For AZ project. 2005.06.27, by rcnjko. */
+#define OID_RT_SCAN_WITH_MAGIC_PACKET			0xFF0101C4
+
+/*  Vincent 8185MP */
+#define OID_RT_PRO_RX_FILTER				0xFF0111C0
+
+#define OID_CE_USB_WRITE_REGISTRY			0xFF0111C1
+#define OID_CE_USB_READ_REGISTRY			0xFF0111C2
+
+#define OID_RT_PRO_SET_INITIAL_GA			0xFF0111C3
+#define OID_RT_PRO_SET_BB_RF_STANDBY_MODE		0xFF0111C4
+#define OID_RT_PRO_SET_BB_RF_SHUTDOWN_MODE		0xFF0111C5
+#define OID_RT_PRO_SET_TX_CHARGE_PUMP			0xFF0111C6
+#define OID_RT_PRO_SET_RX_CHARGE_PUMP			0xFF0111C7
+#define OID_RT_PRO_RF_WRITE_REGISTRY			0xFF0111C8
+#define OID_RT_PRO_RF_READ_REGISTRY			0xFF0111C9
+#define OID_RT_PRO_QUERY_RF_TYPE			0xFF0111CA
+
+/*  AP OID */
+#define OID_RT_AP_GET_ASSOCIATED_STATION_LIST		0xFF010300
+#define OID_RT_AP_GET_CURRENT_TIME_STAMP		0xFF010301
+#define OID_RT_AP_SWITCH_INTO_AP_MODE			0xFF010302
+#define OID_RT_AP_SET_DTIM_PERIOD			0xFF010303
+/*  Determine if driver supports AP mode. */
+#define OID_RT_AP_SUPPORTED				0xFF010304
+/*  Set WPA-PSK passphrase into authenticator. */
+#define OID_RT_AP_SET_PASSPHRASE			0xFF010305
+
+/*  8187MP. 2004.09.06, by rcnjko. */
+#define OID_RT_PRO8187_WI_POLL				0xFF818780
+#define OID_RT_PRO_WRITE_BB_REG				0xFF818781
+#define OID_RT_PRO_READ_BB_REG				0xFF818782
+#define OID_RT_PRO_WRITE_RF_REG				0xFF818783
+#define OID_RT_PRO_READ_RF_REG				0xFF818784
+
+/*  Meeting House. added by Annie, 2005-07-20. */
+#define OID_RT_MH_VENDER_ID				0xFFEDC100
+
+/* 8711 MP OID added 20051230. */
+#define OID_RT_PRO8711_JOIN_BSS				0xFF871100/* S */
+
+#define OID_RT_PRO_READ_REGISTER			0xFF871101 /* Q */
+#define OID_RT_PRO_WRITE_REGISTER			0xFF871102 /* S */
+
+#define OID_RT_PRO_BURST_READ_REGISTER			0xFF871103 /* Q */
+#define OID_RT_PRO_BURST_WRITE_REGISTER			0xFF871104 /* S */
+
+#define OID_RT_PRO_WRITE_TXCMD				0xFF871105 /* S */
+
+#define OID_RT_PRO_READ16_EEPROM			0xFF871106 /* Q */
+#define OID_RT_PRO_WRITE16_EEPROM			0xFF871107 /* S */
+
+#define OID_RT_PRO_H2C_SET_COMMAND			0xFF871108 /* S */
+#define OID_RT_PRO_H2C_QUERY_RESULT			0xFF871109 /* Q */
+
+#define OID_RT_PRO8711_WI_POLL				0xFF87110A /* Q */
+#define OID_RT_PRO8711_PKT_LOSS				0xFF87110B /* Q */
+#define OID_RT_RD_ATTRIB_MEM				0xFF87110C/* Q */
+#define OID_RT_WR_ATTRIB_MEM				0xFF87110D/* S */
+
+/* Method 2 for H2C/C2H */
+#define OID_RT_PRO_H2C_CMD_MODE				0xFF871110 /* S */
+#define OID_RT_PRO_H2C_CMD_RSP_MODE			0xFF871111 /* Q */
+#define OID_RT_PRO_H2C_CMD_EVENT_MODE			0xFF871112 /* S */
+#define OID_RT_PRO_WAIT_C2H_EVENT			0xFF871113 /* Q */
+#define OID_RT_PRO_RW_ACCESS_PROTOCOL_TEST		0xFF871114/* Q */
+
+#define OID_RT_PRO_SCSI_ACCESS_TEST			0xFF871115 /* Q, S */
+
+#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_OUT		0xFF871116 /* S */
+#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_IN			0xFF871117 /* Q,S */
+#define OID_RT_RRO_RX_PKT_VIA_IOCTRL			0xFF871118 /* Q */
+#define OID_RT_RRO_RX_PKTARRAY_VIA_IOCTRL		0xFF871119 /* Q */
+
+#define OID_RT_RPO_SET_PWRMGT_TEST			0xFF87111A /* S */
+#define OID_RT_PRO_QRY_PWRMGT_TEST			0XFF87111B /* Q */
+#define OID_RT_RPO_ASYNC_RWIO_TEST			0xFF87111C /* S */
+#define OID_RT_RPO_ASYNC_RWIO_POLL			0xFF87111D /* Q */
+#define OID_RT_PRO_SET_RF_INTFS				0xFF87111E /* S */
+#define OID_RT_POLL_RX_STATUS				0xFF87111F /* Q */
+
+#define OID_RT_PRO_CFG_DEBUG_MESSAGE			0xFF871120 /* Q,S */
+#define OID_RT_PRO_SET_DATA_RATE_EX			0xFF871121/* S */
+#define OID_RT_PRO_SET_BASIC_RATE			0xFF871122/* S */
+#define OID_RT_PRO_READ_TSSI				0xFF871123/* S */
+#define OID_RT_PRO_SET_POWER_TRACKING			0xFF871124/* S */
+
+#define OID_RT_PRO_QRY_PWRSTATE				0xFF871150 /* Q */
+#define OID_RT_PRO_SET_PWRSTATE				0xFF871151 /* S */
+
+/* Method 2 , using workitem */
+#define OID_RT_SET_READ_REG				0xFF871181 /* S */
+#define OID_RT_SET_WRITE_REG				0xFF871182 /* S */
+#define OID_RT_SET_BURST_READ_REG			0xFF871183 /* S */
+#define OID_RT_SET_BURST_WRITE_REG			0xFF871184 /* S */
+#define OID_RT_SET_WRITE_TXCMD				0xFF871185 /* S */
+#define OID_RT_SET_READ16_EEPROM			0xFF871186 /* S */
+#define OID_RT_SET_WRITE16_EEPROM			0xFF871187 /* S */
+#define OID_RT_QRY_POLL_WKITEM				0xFF871188 /* Q */
+
+/* For SDIO INTERFACE only */
+#define OID_RT_PRO_SYNCPAGERW_SRAM			0xFF8711A0 /* Q, S */
+#define OID_RT_PRO_871X_DRV_EXT				0xFF8711A1
+
+/* For USB INTERFACE only */
+#define OID_RT_PRO_USB_VENDOR_REQ			0xFF8711B0 /* Q, S */
+#define OID_RT_PRO_SCSI_AUTO_TEST			0xFF8711B1 /* S */
+#define OID_RT_PRO_USB_MAC_AC_FIFO_WRITE		0xFF8711B2 /* S */
+#define OID_RT_PRO_USB_MAC_RX_FIFO_READ			0xFF8711B3 /* Q */
+#define OID_RT_PRO_USB_MAC_RX_FIFO_POLLING		0xFF8711B4 /* Q */
+
+#define OID_RT_PRO_H2C_SET_RATE_TABLE			0xFF8711FB /* S */
+#define OID_RT_PRO_H2C_GET_RATE_TABLE			0xFF8711FC /* S */
+#define OID_RT_PRO_H2C_C2H_LBK_TEST			0xFF8711FE
+
+#define OID_RT_PRO_ENCRYPTION_CTRL			0xFF871200 /* Q, S */
+#define OID_RT_PRO_ADD_STA_INFO				0xFF871201 /* S */
+#define OID_RT_PRO_DELE_STA_INFO			0xFF871202 /* S */
+#define OID_RT_PRO_QUERY_DR_VARIABLE			0xFF871203 /* Q */
+
+#define OID_RT_PRO_RX_PACKET_TYPE			0xFF871204 /* Q, S */
+
+#define OID_RT_PRO_READ_EFUSE				0xFF871205 /* Q */
+#define OID_RT_PRO_WRITE_EFUSE				0xFF871206 /* S */
+#define OID_RT_PRO_RW_EFUSE_PGPKT			0xFF871207 /* Q, S */
+#define OID_RT_GET_EFUSE_CURRENT_SIZE			0xFF871208 /* Q */
+
+#define OID_RT_SET_BANDWIDTH				0xFF871209 /* S */
+#define OID_RT_SET_CRYSTAL_CAP				0xFF87120A /* S */
+
+#define OID_RT_SET_RX_PACKET_TYPE			0xFF87120B /* S */
+
+#define OID_RT_GET_EFUSE_MAX_SIZE			0xFF87120C /* Q */
+
+#define OID_RT_PRO_SET_TX_AGC_OFFSET			0xFF87120D /* S */
+
+#define OID_RT_PRO_SET_PKT_TEST_MODE			0xFF87120E /* S */
+
+#define OID_RT_PRO_FOR_EVM_TEST_SETTING			0xFF87120F /* S */
+
+#define OID_RT_PRO_GET_THERMAL_METER			0xFF871210 /* Q */
+
+#define OID_RT_RESET_PHY_RX_PACKET_COUNT		0xFF871211 /* S */
+#define OID_RT_GET_PHY_RX_PACKET_RECEIVED		0xFF871212 /* Q */
+#define OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR		0xFF871213 /* Q */
+
+#define OID_RT_SET_POWER_DOWN				0xFF871214 /* S */
+
+#define OID_RT_GET_POWER_MODE				0xFF871215 /* Q */
+
+#define OID_RT_PRO_EFUSE				0xFF871216 /* Q, S */
+#define OID_RT_PRO_EFUSE_MAP				0xFF871217 /* Q, S */
+
+#endif /* ifndef	__CUSTOM_OID_H */
diff --git a/drivers/staging/r8188eu/include/nic_spec.h b/drivers/staging/r8188eu/include/nic_spec.h
new file mode 100644
index 000000000000..cee6f06a4570
--- /dev/null
+++ b/drivers/staging/r8188eu/include/nic_spec.h
@@ -0,0 +1,41 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef __NIC_SPEC_H__
+#define __NIC_SPEC_H__
+
+#define RTL8711_MCTRL_		(0x20000)
+#define RTL8711_UART_		(0x30000)
+#define RTL8711_TIMER_		(0x40000)
+#define RTL8711_FINT_		(0x50000)
+#define RTL8711_HINT_		(0x50000)
+#define RTL8711_GPIO_		(0x60000)
+#define RTL8711_WLANCTRL_	(0x200000)
+#define RTL8711_WLANFF_		(0xe00000)
+#define RTL8711_HCICTRL_	(0x600000)
+#define RTL8711_SYSCFG_		(0x620000)
+#define RTL8711_SYSCTRL_	(0x620000)
+#define RTL8711_MCCTRL_		(0x020000)
+
+#include <rtl8711_regdef.h>
+
+#include <rtl8711_bitdef.h>
+
+#endif /*  __RTL8711_SPEC_H__ */
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
new file mode 100644
index 000000000000..61836c32123f
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -0,0 +1,1182 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__HALDMOUTSRC_H__
+#define __HALDMOUTSRC_H__
+
+/*  Definition */
+/*  Define all team support ability. */
+
+/*  Define for all teams. Please Define the constant in your precomp header. */
+
+/* define		DM_ODM_SUPPORT_AP			0 */
+/* define		DM_ODM_SUPPORT_ADSL			0 */
+/* define		DM_ODM_SUPPORT_CE			0 */
+/* define		DM_ODM_SUPPORT_MP			1 */
+
+/*  Define ODM SW team support flag. */
+
+/*  Antenna Switch Relative Definition. */
+
+/*  Add new function SwAntDivCheck8192C(). */
+/*  This is the main function of Antenna diversity function before link. */
+/*  Mainly, it just retains last scan result and scan again. */
+/*  After that, it compares the scan result to see which one gets better
+ *  RSSI. It selects antenna with better receiving power and returns better
+ *  scan result. */
+
+#define	TP_MODE			0
+#define	RSSI_MODE		1
+#define	TRAFFIC_LOW		0
+#define	TRAFFIC_HIGH		1
+
+/* 3 Tx Power Tracking */
+/* 3============================================================ */
+#define		DPK_DELTA_MAPPING_NUM	13
+#define		index_mapping_HP_NUM	15
+
+/*  */
+/* 3 PSD Handler */
+/* 3============================================================ */
+
+#define	AFH_PSD		1	/* 0:normal PSD scan, 1: only do 20 pts PSD */
+#define	MODE_40M	0	/* 0:20M, 1:40M */
+#define	PSD_TH2		3
+#define	PSD_CHM		20   /*  Minimum channel number for BT AFH */
+#define	SIR_STEP_SIZE	3
+#define Smooth_Size_1	5
+#define	Smooth_TH_1	3
+#define Smooth_Size_2	10
+#define	Smooth_TH_2	4
+#define Smooth_Size_3	20
+#define	Smooth_TH_3	4
+#define Smooth_Step_Size 5
+#define	Adaptive_SIR	1
+#define	PSD_RESCAN	4
+#define	PSD_SCAN_INTERVAL	700 /* ms */
+
+/* 8723A High Power IGI Setting */
+#define DM_DIG_HIGH_PWR_IGI_LOWER_BOUND	0x22
+#define DM_DIG_Gmode_HIGH_PWR_IGI_LOWER_BOUND 0x28
+#define DM_DIG_HIGH_PWR_THRESHOLD	0x3a
+
+/*  LPS define */
+#define DM_DIG_FA_TH0_LPS		4 /*  4 in lps */
+#define DM_DIG_FA_TH1_LPS		15 /*  15 lps */
+#define DM_DIG_FA_TH2_LPS		30 /*  30 lps */
+#define RSSI_OFFSET_DIG			0x05;
+
+/* ANT Test */
+#define ANTTESTALL		0x00	/* Ant A or B will be Testing */
+#define ANTTESTA		0x01	/* Ant A will be Testing */
+#define ANTTESTB		0x02	/* Ant B will be testing */
+
+/*  structure and define */
+
+/*  Add for AP/ADSLpseudo DM structuer requirement. */
+/*  We need to remove to other position??? */
+struct rtl8192cd_priv {
+	u8		temp;
+};
+
+struct rtw_dig {
+	u8		Dig_Enable_Flag;
+	u8		Dig_Ext_Port_Stage;
+
+	int		RssiLowThresh;
+	int		RssiHighThresh;
+
+	u32		FALowThresh;
+	u32		FAHighThresh;
+
+	u8		CurSTAConnectState;
+	u8		PreSTAConnectState;
+	u8		CurMultiSTAConnectState;
+
+	u8		PreIGValue;
+	u8		CurIGValue;
+	u8		BackupIGValue;
+
+	s8		BackoffVal;
+	s8		BackoffVal_range_max;
+	s8		BackoffVal_range_min;
+	u8		rx_gain_range_max;
+	u8		rx_gain_range_min;
+	u8		Rssi_val_min;
+
+	u8		PreCCK_CCAThres;
+	u8		CurCCK_CCAThres;
+	u8		PreCCKPDState;
+	u8		CurCCKPDState;
+
+	u8		LargeFAHit;
+	u8		ForbiddenIGI;
+	u32		Recover_cnt;
+
+	u8		DIG_Dynamic_MIN_0;
+	u8		DIG_Dynamic_MIN_1;
+	bool		bMediaConnect_0;
+	bool		bMediaConnect_1;
+
+	u32		AntDiv_RSSI_max;
+	u32		RSSI_max;
+};
+
+struct rtl_ps {
+	u8		PreCCAState;
+	u8		CurCCAState;
+
+	u8		PreRFState;
+	u8		CurRFState;
+
+	int		    Rssi_val_min;
+
+	u8		initialize;
+	u32		Reg874,RegC70,Reg85C,RegA74;
+
+};
+
+struct false_alarm_stats {
+	u32	Cnt_Parity_Fail;
+	u32	Cnt_Rate_Illegal;
+	u32	Cnt_Crc8_fail;
+	u32	Cnt_Mcs_fail;
+	u32	Cnt_Ofdm_fail;
+	u32	Cnt_Cck_fail;
+	u32	Cnt_all;
+	u32	Cnt_Fast_Fsync;
+	u32	Cnt_SB_Search_fail;
+	u32	Cnt_OFDM_CCA;
+	u32	Cnt_CCK_CCA;
+	u32	Cnt_CCA_all;
+	u32	Cnt_BW_USC;	/* Gary */
+	u32	Cnt_BW_LSC;	/* Gary */
+};
+
+struct dyn_primary_cca {
+	u8		PriCCA_flag;
+	u8		intf_flag;
+	u8		intf_type;
+	u8		DupRTS_flag;
+	u8		Monitor_flag;
+};
+
+struct rx_hpc {
+	u8		RXHP_flag;
+	u8		PSD_func_trigger;
+	u8		PSD_bitmap_RXHP[80];
+	u8		Pre_IGI;
+	u8		Cur_IGI;
+	u8		Pre_pw_th;
+	u8		Cur_pw_th;
+	bool		First_time_enter;
+	bool		RXHP_enable;
+	u8		TP_Mode;
+	struct timer_list PSDTimer;
+};
+
+#define ASSOCIATE_ENTRY_NUM	32 /*  Max size of AsocEntry[]. */
+#define	ODM_ASSOCIATE_ENTRY_NUM	ASSOCIATE_ENTRY_NUM
+
+/*  This indicates two different steps. */
+/*  In SWAW_STEP_PEAK, driver needs to switch antenna and listen to
+ *  the signal on the air. */
+/*  In SWAW_STEP_DETERMINE, driver just compares the signal captured in
+ *  SWAW_STEP_PEAK with original RSSI to determine if it is necessary to
+ *  switch antenna. */
+
+#define SWAW_STEP_PEAK		0
+#define SWAW_STEP_DETERMINE	1
+
+#define	TP_MODE			0
+#define	RSSI_MODE		1
+#define	TRAFFIC_LOW		0
+#define	TRAFFIC_HIGH		1
+
+struct sw_ant_switch {
+	u8	try_flag;
+	s32	PreRSSI;
+	u8	CurAntenna;
+	u8	PreAntenna;
+	u8	RSSI_Trying;
+	u8	TestMode;
+	u8	bTriggerAntennaSwitch;
+	u8	SelectAntennaMap;
+	u8	RSSI_target;
+
+	/*  Before link Antenna Switch check */
+	u8	SWAS_NoLink_State;
+	u32	SWAS_NoLink_BK_Reg860;
+	bool	ANTA_ON;	/* To indicate Ant A is or not */
+	bool	ANTB_ON;	/* To indicate Ant B is on or not */
+
+	s32	RSSI_sum_A;
+	s32	RSSI_sum_B;
+	s32	RSSI_cnt_A;
+	s32	RSSI_cnt_B;
+	u64	lastTxOkCnt;
+	u64	lastRxOkCnt;
+	u64	TXByteCnt_A;
+	u64	TXByteCnt_B;
+	u64	RXByteCnt_A;
+	u64	RXByteCnt_B;
+	u8	TrafficLoad;
+	struct timer_list SwAntennaSwitchTimer;
+	/* Hybrid Antenna Diversity */
+	u32	CCK_Ant1_Cnt[ASSOCIATE_ENTRY_NUM];
+	u32	CCK_Ant2_Cnt[ASSOCIATE_ENTRY_NUM];
+	u32	OFDM_Ant1_Cnt[ASSOCIATE_ENTRY_NUM];
+	u32	OFDM_Ant2_Cnt[ASSOCIATE_ENTRY_NUM];
+	u32	RSSI_Ant1_Sum[ASSOCIATE_ENTRY_NUM];
+	u32	RSSI_Ant2_Sum[ASSOCIATE_ENTRY_NUM];
+	u8	TxAnt[ASSOCIATE_ENTRY_NUM];
+	u8	TargetSTA;
+	u8	antsel;
+	u8	RxIdleAnt;
+};
+
+struct edca_turbo {
+	bool bCurrentTurboEDCA;
+	bool bIsCurRDLState;
+	u32	prv_traffic_idx; /*  edca turbo */
+};
+
+struct odm_rate_adapt {
+	u8	Type;		/*  DM_Type_ByFW/DM_Type_ByDriver */
+	u8	HighRSSIThresh;	/*  if RSSI > HighRSSIThresh	=> RATRState is DM_RATR_STA_HIGH */
+	u8	LowRSSIThresh;	/*  if RSSI <= LowRSSIThresh	=> RATRState is DM_RATR_STA_LOW */
+	u8	RATRState;	/*  Current RSSI level, DM_RATR_STA_HIGH/DM_RATR_STA_MIDDLE/DM_RATR_STA_LOW */
+	u32	LastRATR;	/*  RATR Register Content */
+};
+
+#define IQK_MAC_REG_NUM		4
+#define IQK_ADDA_REG_NUM	16
+#define IQK_BB_REG_NUM_MAX	10
+#define IQK_BB_REG_NUM		9
+#define HP_THERMAL_NUM		8
+
+#define AVG_THERMAL_NUM		8
+#define IQK_Matrix_REG_NUM	8
+#define IQK_Matrix_Settings_NUM	1+24+21
+
+#define	DM_Type_ByFWi		0
+#define	DM_Type_ByDriver	1
+
+/*  Declare for common info */
+
+struct odm_phy_status_info {
+	u8	RxPWDBAll;
+	u8	SignalQuality;	 /*  in 0-100 index. */
+	u8	RxMIMOSignalQuality[MAX_PATH_NUM_92CS]; /* EVM */
+	u8	RxMIMOSignalStrength[MAX_PATH_NUM_92CS];/*  in 0~100 index */
+	s8	RxPower; /*  in dBm Translate from PWdB */
+	s8	RecvSignalPower;/*  Real power in dBm for this packet, no
+				 * beautification and aggregation. Keep this raw
+				 * info to be used for the other procedures. */
+	u8	BTRxRSSIPercentage;
+	u8	SignalStrength; /*  in 0-100 index. */
+	u8	RxPwr[MAX_PATH_NUM_92CS];/* per-path's pwdb */
+	u8	RxSNR[MAX_PATH_NUM_92CS];/* per-path's SNR */
+};
+
+struct odm_phy_dbg_info {
+	/* ODM Write,debug info */
+	s8	RxSNRdB[MAX_PATH_NUM_92CS];
+	u64	NumQryPhyStatus;
+	u64	NumQryPhyStatusCCK;
+	u64	NumQryPhyStatusOFDM;
+	/* Others */
+	s32	RxEVM[MAX_PATH_NUM_92CS];
+};
+
+struct odm_per_pkt_info {
+	s8	Rate;
+	u8	StationID;
+	bool	bPacketMatchBSSID;
+	bool	bPacketToSelf;
+	bool	bPacketBeacon;
+};
+
+struct odm_mac_status_info {
+	u8	test;
+};
+
+enum odm_ability {
+	/*  BB Team */
+	ODM_DIG			= 0x00000001,
+	ODM_HIGH_POWER		= 0x00000002,
+	ODM_CCK_CCA_TH		= 0x00000004,
+	ODM_FA_STATISTICS	= 0x00000008,
+	ODM_RAMASK		= 0x00000010,
+	ODM_RSSI_MONITOR	= 0x00000020,
+	ODM_SW_ANTDIV		= 0x00000040,
+	ODM_HW_ANTDIV		= 0x00000080,
+	ODM_BB_PWRSV		= 0x00000100,
+	ODM_2TPATHDIV		= 0x00000200,
+	ODM_1TPATHDIV		= 0x00000400,
+	ODM_PSD2AFH		= 0x00000800
+};
+
+/*  2011/20/20 MH For MP driver RT_WLAN_STA =  struct sta_info */
+/*  Please declare below ODM relative info in your STA info structure. */
+
+struct odm_sta_info {
+	/*  Driver Write */
+	bool	bUsed;		/*  record the sta status link or not? */
+	u8	IOTPeer;	/*  Enum value.	HT_IOT_PEER_E */
+
+	/*  ODM Write */
+	/* 1 PHY_STATUS_INFO */
+	u8	RSSI_Path[4];		/*  */
+	u8	RSSI_Ave;
+	u8	RXEVM[4];
+	u8	RXSNR[4];
+};
+
+/*  2011/10/20 MH Define Common info enum for all team. */
+
+enum odm_common_info_def {
+	/*  Fixed value: */
+
+	/* HOOK BEFORE REG INIT----------- */
+	ODM_CMNINFO_PLATFORM = 0,
+	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
+	ODM_CMNINFO_INTERFACE,		/* ODM_INTERFACE_E */
+	ODM_CMNINFO_MP_TEST_CHIP,
+	ODM_CMNINFO_IC_TYPE,		/* ODM_IC_TYPE_E */
+	ODM_CMNINFO_CUT_VER,		/* ODM_CUT_VERSION_E */
+	ODM_CMNINFO_FAB_VER,		/* ODM_FAB_E */
+	ODM_CMNINFO_RF_TYPE,		/* RF_PATH_E or ODM_RF_TYPE_E? */
+	ODM_CMNINFO_BOARD_TYPE,		/* ODM_BOARD_TYPE_E */
+	ODM_CMNINFO_EXT_LNA,		/* true */
+	ODM_CMNINFO_EXT_PA,
+	ODM_CMNINFO_EXT_TRSW,
+	ODM_CMNINFO_PATCH_ID,		/* CUSTOMER ID */
+	ODM_CMNINFO_BINHCT_TEST,
+	ODM_CMNINFO_BWIFI_TEST,
+	ODM_CMNINFO_SMART_CONCURRENT,
+	/* HOOK BEFORE REG INIT-----------  */
+
+	/*  Dynamic value: */
+/*  POINTER REFERENCE-----------  */
+	ODM_CMNINFO_MAC_PHY_MODE,	/*  ODM_MAC_PHY_MODE_E */
+	ODM_CMNINFO_TX_UNI,
+	ODM_CMNINFO_RX_UNI,
+	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
+	ODM_CMNINFO_BAND,		/*  ODM_BAND_TYPE_E */
+	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
+	ODM_CMNINFO_SEC_MODE,		/*  ODM_SECURITY_E */
+	ODM_CMNINFO_BW,			/*  ODM_BW_E */
+	ODM_CMNINFO_CHNL,
+
+	ODM_CMNINFO_DMSP_GET_VALUE,
+	ODM_CMNINFO_BUDDY_ADAPTOR,
+	ODM_CMNINFO_DMSP_IS_MASTER,
+	ODM_CMNINFO_SCAN,
+	ODM_CMNINFO_POWER_SAVING,
+	ODM_CMNINFO_ONE_PATH_CCA,	/*  ODM_CCA_PATH_E */
+	ODM_CMNINFO_DRV_STOP,
+	ODM_CMNINFO_PNP_IN,
+	ODM_CMNINFO_INIT_ON,
+	ODM_CMNINFO_ANT_TEST,
+	ODM_CMNINFO_NET_CLOSED,
+	ODM_CMNINFO_MP_MODE,
+/*  POINTER REFERENCE----------- */
+
+/* CALL BY VALUE------------- */
+	ODM_CMNINFO_WIFI_DIRECT,
+	ODM_CMNINFO_WIFI_DISPLAY,
+	ODM_CMNINFO_LINK,
+	ODM_CMNINFO_RSSI_MIN,
+	ODM_CMNINFO_DBG_COMP,			/*  u64 */
+	ODM_CMNINFO_DBG_LEVEL,			/*  u32 */
+	ODM_CMNINFO_RA_THRESHOLD_HIGH,		/*  u8 */
+	ODM_CMNINFO_RA_THRESHOLD_LOW,		/*  u8 */
+	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
+	ODM_CMNINFO_BT_DISABLED,
+	ODM_CMNINFO_BT_OPERATION,
+	ODM_CMNINFO_BT_DIG,
+	ODM_CMNINFO_BT_BUSY,			/* Check Bt is using or not */
+	ODM_CMNINFO_BT_DISABLE_EDCA,
+/* CALL BY VALUE-------------*/
+
+	/*  Dynamic ptr array hook itms. */
+	ODM_CMNINFO_STA_STATUS,
+	ODM_CMNINFO_PHY_STATUS,
+	ODM_CMNINFO_MAC_STATUS,
+	ODM_CMNINFO_MAX,
+};
+
+/*  2011/10/20 MH Define ODM support ability.  ODM_CMNINFO_ABILITY */
+
+enum odm_ability_def {
+	/*  BB ODM section BIT 0-15 */
+	ODM_BB_DIG			= BIT0,
+	ODM_BB_RA_MASK			= BIT1,
+	ODM_BB_DYNAMIC_TXPWR		= BIT2,
+	ODM_BB_FA_CNT			= BIT3,
+	ODM_BB_RSSI_MONITOR		= BIT4,
+	ODM_BB_CCK_PD			= BIT5,
+	ODM_BB_ANT_DIV			= BIT6,
+	ODM_BB_PWR_SAVE			= BIT7,
+	ODM_BB_PWR_TRA			= BIT8,
+	ODM_BB_RATE_ADAPTIVE		= BIT9,
+	ODM_BB_PATH_DIV			= BIT10,
+	ODM_BB_PSD			= BIT11,
+	ODM_BB_RXHP			= BIT12,
+
+	/*  MAC DM section BIT 16-23 */
+	ODM_MAC_EDCA_TURBO		= BIT16,
+	ODM_MAC_EARLY_MODE		= BIT17,
+
+	/*  RF ODM section BIT 24-31 */
+	ODM_RF_TX_PWR_TRACK		= BIT24,
+	ODM_RF_RX_GAIN_TRACK		= BIT25,
+	ODM_RF_CALIBRATION		= BIT26,
+};
+
+/* 	ODM_CMNINFO_INTERFACE */
+enum odm_interface_def {
+	ODM_ITRF_PCIE	=	0x1,
+	ODM_ITRF_USB	=	0x2,
+	ODM_ITRF_SDIO	=	0x4,
+	ODM_ITRF_ALL	=	0x7,
+};
+
+/*  ODM_CMNINFO_IC_TYPE */
+enum odm_ic_type {
+	ODM_RTL8192S	=	BIT0,
+	ODM_RTL8192C	=	BIT1,
+	ODM_RTL8192D	=	BIT2,
+	ODM_RTL8723A	=	BIT3,
+	ODM_RTL8188E	=	BIT4,
+	ODM_RTL8812	=	BIT5,
+	ODM_RTL8821	=	BIT6,
+};
+
+#define ODM_IC_11N_SERIES						\
+	(ODM_RTL8192S | ODM_RTL8192C | ODM_RTL8192D |			\
+	 ODM_RTL8723A | ODM_RTL8188E)
+#define ODM_IC_11AC_SERIES		(ODM_RTL8812)
+
+/* ODM_CMNINFO_CUT_VER */
+enum odm_cut_version {
+	ODM_CUT_A	=	1,
+	ODM_CUT_B	=	2,
+	ODM_CUT_C	=	3,
+	ODM_CUT_D	=	4,
+	ODM_CUT_E	=	5,
+	ODM_CUT_F	=	6,
+	ODM_CUT_TEST	=	7,
+};
+
+/*  ODM_CMNINFO_FAB_VER */
+enum odm_fab_Version {
+	ODM_TSMC	=	0,
+	ODM_UMC		=	1,
+};
+
+/*  ODM_CMNINFO_RF_TYPE */
+/*  For example 1T2R (A+AB = BIT0|BIT4|BIT5) */
+enum odm_rf_path {
+	ODM_RF_TX_A	=	BIT0,
+	ODM_RF_TX_B	=	BIT1,
+	ODM_RF_TX_C	=	BIT2,
+	ODM_RF_TX_D	=	BIT3,
+	ODM_RF_RX_A	=	BIT4,
+	ODM_RF_RX_B	=	BIT5,
+	ODM_RF_RX_C	=	BIT6,
+	ODM_RF_RX_D	=	BIT7,
+};
+
+enum odm_rf_type {
+	ODM_1T1R	=	0,
+	ODM_1T2R	=	1,
+	ODM_2T2R	=	2,
+	ODM_2T3R	=	3,
+	ODM_2T4R	=	4,
+	ODM_3T3R	=	5,
+	ODM_3T4R	=	6,
+	ODM_4T4R	=	7,
+};
+
+/*  ODM Dynamic common info value definition */
+
+enum odm_mac_phy_mode {
+	ODM_SMSP	= 0,
+	ODM_DMSP	= 1,
+	ODM_DMDP	= 2,
+};
+
+enum odm_bt_coexist {
+	ODM_BT_BUSY		= 1,
+	ODM_BT_ON		= 2,
+	ODM_BT_OFF		= 3,
+	ODM_BT_NONE		= 4,
+};
+
+/*  ODM_CMNINFO_OP_MODE */
+enum odm_operation_mode {
+	ODM_NO_LINK		= BIT0,
+	ODM_LINK		= BIT1,
+	ODM_SCAN		= BIT2,
+	ODM_POWERSAVE		= BIT3,
+	ODM_AP_MODE		= BIT4,
+	ODM_CLIENT_MODE		= BIT5,
+	ODM_AD_HOC		= BIT6,
+	ODM_WIFI_DIRECT		= BIT7,
+	ODM_WIFI_DISPLAY	= BIT8,
+};
+
+/*  ODM_CMNINFO_WM_MODE */
+enum odm_wireless_mode {
+	ODM_WM_UNKNOW	= 0x0,
+	ODM_WM_B	= BIT0,
+	ODM_WM_G	= BIT1,
+	ODM_WM_A	= BIT2,
+	ODM_WM_N24G	= BIT3,
+	ODM_WM_N5G	= BIT4,
+	ODM_WM_AUTO	= BIT5,
+	ODM_WM_AC	= BIT6,
+};
+
+/*  ODM_CMNINFO_BAND */
+enum odm_band_type {
+	ODM_BAND_2_4G	= BIT0,
+	ODM_BAND_5G	= BIT1,
+};
+
+/*  ODM_CMNINFO_SEC_CHNL_OFFSET */
+enum odm_sec_chnl_offset {
+	ODM_DONT_CARE	= 0,
+	ODM_BELOW	= 1,
+	ODM_ABOVE	= 2
+};
+
+/*  ODM_CMNINFO_SEC_MODE */
+enum odm_security {
+	ODM_SEC_OPEN		= 0,
+	ODM_SEC_WEP40		= 1,
+	ODM_SEC_TKIP		= 2,
+	ODM_SEC_RESERVE		= 3,
+	ODM_SEC_AESCCMP		= 4,
+	ODM_SEC_WEP104		= 5,
+	ODM_WEP_WPA_MIXED   	= 6, /*  WEP + WPA */
+	ODM_SEC_SMS4		= 7,
+};
+
+/*  ODM_CMNINFO_BW */
+enum odm_bw {
+	ODM_BW20M		= 0,
+	ODM_BW40M		= 1,
+	ODM_BW80M		= 2,
+	ODM_BW160M		= 3,
+	ODM_BW10M		= 4,
+};
+
+/*  ODM_CMNINFO_BOARD_TYPE */
+enum odm_board_type {
+	ODM_BOARD_NORMAL	= 0,
+	ODM_BOARD_HIGHPWR	= 1,
+	ODM_BOARD_MINICARD	= 2,
+	ODM_BOARD_SLIM		= 3,
+	ODM_BOARD_COMBO		= 4,
+};
+
+/*  ODM_CMNINFO_ONE_PATH_CCA */
+enum odm_cca_path {
+	ODM_CCA_2R		= 0,
+	ODM_CCA_1R_A		= 1,
+	ODM_CCA_1R_B		= 2,
+};
+
+struct odm_ra_info {
+	u8 RateID;
+	u32 RateMask;
+	u32 RAUseRate;
+	u8 RateSGI;
+	u8 RssiStaRA;
+	u8 PreRssiStaRA;
+	u8 SGIEnable;
+	u8 DecisionRate;
+	u8 PreRate;
+	u8 HighestRate;
+	u8 LowestRate;
+	u32 NscUp;
+	u32 NscDown;
+	u16 RTY[5];
+	u32 TOTAL;
+	u16 DROP;
+	u8 Active;
+	u16 RptTime;
+	u8 RAWaitingCounter;
+	u8 RAPendingCounter;
+	u8 PTActive;	/*  on or off */
+	u8 PTTryState;	/*  0 trying state, 1 for decision state */
+	u8 PTStage;	/*  0~6 */
+	u8 PTStopCount;	/* Stop PT counter */
+	u8 PTPreRate;	/*  if rate change do PT */
+	u8 PTPreRssi;	/*  if RSSI change 5% do PT */
+	u8 PTModeSS;	/*  decide whitch rate should do PT */
+	u8 RAstage;	/*  StageRA, decide how many times RA will be done
+			 * between PT */
+	u8 PTSmoothFactor;
+};
+
+struct ijk_matrix_regs_set {
+	bool	bIQKDone;
+	s32	Value[1][IQK_Matrix_REG_NUM];
+};
+
+struct odm_rf_cal {
+	/* for tx power tracking */
+	u32	RegA24; /*  for TempCCK */
+	s32	RegE94;
+	s32	RegE9C;
+	s32	RegEB4;
+	s32	RegEBC;
+
+	u8	TXPowercount;
+	bool	bTXPowerTrackingInit;
+	bool	bTXPowerTracking;
+	u8	TxPowerTrackControl; /* for mp mode, turn off txpwrtracking
+				      * as default */
+	u8	TM_Trigger;
+	u8	InternalPA5G[2];	/* pathA / pathB */
+
+	u8	ThermalMeter[2];    /* ThermalMeter, index 0 for RFIC0,
+				     * and 1 for RFIC1 */
+	u8	ThermalValue;
+	u8	ThermalValue_LCK;
+	u8	ThermalValue_IQK;
+	u8	ThermalValue_DPK;
+	u8	ThermalValue_AVG[AVG_THERMAL_NUM];
+	u8	ThermalValue_AVG_index;
+	u8	ThermalValue_RxGain;
+	u8	ThermalValue_Crystal;
+	u8	ThermalValue_DPKstore;
+	u8	ThermalValue_DPKtrack;
+	bool	TxPowerTrackingInProgress;
+	bool	bDPKenable;
+
+	bool	bReloadtxpowerindex;
+	u8	bRfPiEnable;
+	u32	TXPowerTrackingCallbackCnt; /* cosa add for debug */
+
+	u8	bCCKinCH14;
+	u8	CCK_index;
+	u8	OFDM_index[2];
+	bool bDoneTxpower;
+
+	u8	ThermalValue_HP[HP_THERMAL_NUM];
+	u8	ThermalValue_HP_index;
+	struct ijk_matrix_regs_set IQKMatrixRegSetting[IQK_Matrix_Settings_NUM];
+
+	u8	Delta_IQK;
+	u8	Delta_LCK;
+
+	/* for IQK */
+	u32	RegC04;
+	u32	Reg874;
+	u32	RegC08;
+	u32	RegB68;
+	u32	RegB6C;
+	u32	Reg870;
+	u32	Reg860;
+	u32	Reg864;
+
+	bool	bIQKInitialized;
+	bool	bLCKInProgress;
+	bool	bAntennaDetected;
+	u32	ADDA_backup[IQK_ADDA_REG_NUM];
+	u32	IQK_MAC_backup[IQK_MAC_REG_NUM];
+	u32	IQK_BB_backup_recover[9];
+	u32	IQK_BB_backup[IQK_BB_REG_NUM];
+
+	/* for APK */
+	u32	APKoutput[2][2]; /* path A/B; output1_1a/output1_2a */
+	u8	bAPKdone;
+	u8	bAPKThermalMeterIgnore;
+	u8	bDPdone;
+	u8	bDPPathAOK;
+	u8	bDPPathBOK;
+};
+
+/*  ODM Dynamic common info value definition */
+
+struct fast_ant_train {
+	u8	Bssid[6];
+	u8	antsel_rx_keep_0;
+	u8	antsel_rx_keep_1;
+	u8	antsel_rx_keep_2;
+	u32	antSumRSSI[7];
+	u32	antRSSIcnt[7];
+	u32	antAveRSSI[7];
+	u8	FAT_State;
+	u32	TrainIdx;
+	u8	antsel_a[ODM_ASSOCIATE_ENTRY_NUM];
+	u8	antsel_b[ODM_ASSOCIATE_ENTRY_NUM];
+	u8	antsel_c[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	MainAnt_Sum[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	AuxAnt_Sum[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	MainAnt_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
+	u32	AuxAnt_Cnt[ODM_ASSOCIATE_ENTRY_NUM];
+	u8	RxIdleAnt;
+	bool	bBecomeLinked;
+};
+
+enum fat_state {
+	FAT_NORMAL_STATE		= 0,
+	FAT_TRAINING_STATE		= 1,
+};
+
+enum ant_div_type {
+	NO_ANTDIV			= 0xFF,
+	CG_TRX_HW_ANTDIV		= 0x01,
+	CGCS_RX_HW_ANTDIV		= 0x02,
+	FIXED_HW_ANTDIV			= 0x03,
+	CG_TRX_SMART_ANTDIV		= 0x04,
+	CGCS_RX_SW_ANTDIV		= 0x05,
+};
+
+/* Copy from SD4 defined structure. We use to support PHY DM integration. */
+struct odm_dm_struct {
+	/* 	Add for different team use temporarily */
+	struct adapter *Adapter;	/*  For CE/NIC team */
+	struct rtl8192cd_priv *priv;	/*  For AP/ADSL team */
+	/*  WHen you use above pointers, they must be initialized. */
+	bool	odm_ready;
+
+	struct rtl8192cd_priv *fake_priv;
+	u64	DebugComponents;
+	u32	DebugLevel;
+
+/*  ODM HANDLE, DRIVER NEEDS NOT TO HOOK------ */
+	bool	bCckHighPower;
+	u8	RFPathRxEnable;		/*  ODM_CMNINFO_RFPATH_ENABLE */
+	u8	ControlChannel;
+/*  ODM HANDLE, DRIVER NEEDS NOT TO HOOK------ */
+
+/* 1  COMMON INFORMATION */
+	/*  Init Value */
+/* HOOK BEFORE REG INIT----------- */
+	/*  ODM Platform info AP/ADSL/CE/MP = 1/2/3/4 */
+	u8	SupportPlatform;
+	/*  ODM Support Ability DIG/RATR/TX_PWR_TRACK/ ¡K¡K = 1/2/3/¡K */
+	u32	SupportAbility;
+	/*  ODM PCIE/USB/SDIO/GSPI = 0/1/2/3 */
+	u8	SupportInterface;
+	/*  ODM composite or independent. Bit oriented/ 92C+92D+ .... or any
+	 *  other type = 1/2/3/... */
+	u32	SupportICType;
+	/*  Cut Version TestChip/A-cut/B-cut... = 0/1/2/3/... */
+	u8	CutVersion;
+	/*  Fab Version TSMC/UMC = 0/1 */
+	u8	FabVersion;
+	/*  RF Type 4T4R/3T3R/2T2R/1T2R/1T1R/... */
+	u8	RFType;
+	/*  Board Type Normal/HighPower/MiniCard/SLIM/Combo/. = 0/1/2/3/4/. */
+	u8	BoardType;
+	/*  with external LNA  NO/Yes = 0/1 */
+	u8	ExtLNA;
+	/*  with external PA  NO/Yes = 0/1 */
+	u8	ExtPA;
+	/*  with external TRSW  NO/Yes = 0/1 */
+	u8	ExtTRSW;
+	u8	PatchID; /* Customer ID */
+	bool	bInHctTest;
+	bool	bWIFITest;
+
+	bool	bDualMacSmartConcurrent;
+	u32	BK_SupportAbility;
+	u8	AntDivType;
+/* HOOK BEFORE REG INIT----------- */
+
+	/*  Dynamic Value */
+/*  POINTER REFERENCE----------- */
+
+	u8	u8_temp;
+	bool	bool_temp;
+	struct adapter *adapter_temp;
+
+	/*  MAC PHY Mode SMSP/DMSP/DMDP = 0/1/2 */
+	u8	*pMacPhyMode;
+	/* TX Unicast byte count */
+	u64	*pNumTxBytesUnicast;
+	/* RX Unicast byte count */
+	u64	*pNumRxBytesUnicast;
+	/*  Wireless mode B/G/A/N = BIT0/BIT1/BIT2/BIT3 */
+	u8	*pWirelessMode; /* ODM_WIRELESS_MODE_E */
+	/*  Frequence band 2.4G/5G = 0/1 */
+	u8	*pBandType;
+	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
+	u8	*pSecChOffset;
+	/*  Security mode Open/WEP/AES/TKIP = 0/1/2/3 */
+	u8	*pSecurity;
+	/*  BW info 20M/40M/80M = 0/1/2 */
+	u8	*pBandWidth;
+	/*  Central channel location Ch1/Ch2/.... */
+	u8	*pChannel;	/* central channel number */
+	/*  Common info for 92D DMSP */
+
+	bool	*pbGetValueFromOtherMac;
+	struct adapter **pBuddyAdapter;
+	bool	*pbMasterOfDMSP; /* MAC0: master, MAC1: slave */
+	/*  Common info for Status */
+	bool	*pbScanInProcess;
+	bool	*pbPowerSaving;
+	/*  CCA Path 2-path/path-A/path-B = 0/1/2; using ODM_CCA_PATH_E. */
+	u8	*pOnePathCCA;
+	/* pMgntInfo->AntennaTest */
+	u8	*pAntennaTest;
+	bool	*pbNet_closed;
+/*  POINTER REFERENCE----------- */
+	/*  */
+/* CALL BY VALUE------------- */
+	bool	bWIFI_Direct;
+	bool	bWIFI_Display;
+	bool	bLinked;
+	u8	RSSI_Min;
+	u8	InterfaceIndex; /*  Add for 92D  dual MAC: 0--Mac0 1--Mac1 */
+	bool	bIsMPChip;
+	bool	bOneEntryOnly;
+	/*  Common info for BTDM */
+	bool	bBtDisabled;	/*  BT is disabled */
+	bool	bBtHsOperation;	/*  BT HS mode is under progress */
+	u8	btHsDigVal;	/*  use BT rssi to decide the DIG value */
+	bool	bBtDisableEdcaTurbo;/* Under some condition, don't enable the
+				     * EDCA Turbo */
+	bool	bBtBusy;			/*  BT is busy. */
+/* CALL BY VALUE------------- */
+
+	/* 2 Define STA info. */
+	/*  _ODM_STA_INFO */
+	/*  For MP, we need to reduce one array pointer for default port.?? */
+	struct sta_info *pODM_StaInfo[ODM_ASSOCIATE_ENTRY_NUM];
+
+	u16	CurrminRptTime;
+	struct odm_ra_info RAInfo[ODM_ASSOCIATE_ENTRY_NUM]; /* Use MacID as
+			* array index. STA MacID=0,
+			* VWiFi Client MacID={1, ODM_ASSOCIATE_ENTRY_NUM-1} */
+	/*  */
+	/*  2012/02/14 MH Add to share 88E ra with other SW team. */
+	/*  We need to colelct all support abilit to a proper area. */
+	/*  */
+	bool	RaSupport88E;
+
+	/*  Define ........... */
+
+	/*  Latest packet phy info (ODM write) */
+	struct odm_phy_dbg_info PhyDbgInfo;
+
+	/*  Latest packet phy info (ODM write) */
+	struct odm_mac_status_info *pMacInfo;
+
+	/*  Different Team independt structure?? */
+
+	/* ODM Structure */
+	struct fast_ant_train DM_FatTable;
+	struct rtw_dig	DM_DigTable;
+	struct rtl_ps	DM_PSTable;
+	struct dyn_primary_cca DM_PriCCA;
+	struct rx_hpc	DM_RXHP_Table;
+	struct false_alarm_stats FalseAlmCnt;
+	struct false_alarm_stats FlaseAlmCntBuddyAdapter;
+	struct sw_ant_switch DM_SWAT_Table;
+	bool		RSSI_test;
+
+	struct edca_turbo DM_EDCA_Table;
+	u32		WMMEDCA_BE;
+	/*  Copy from SD4 structure */
+	/*  */
+	/*  ================================================== */
+	/*  */
+
+	bool	*pbDriverStopped;
+	bool	*pbDriverIsGoingToPnpSetPowerSleep;
+	bool	*pinit_adpt_in_progress;
+
+	/* PSD */
+	bool	bUserAssignLevel;
+	struct timer_list PSDTimer;
+	u8	RSSI_BT;			/* come from BT */
+	bool	bPSDinProcess;
+	bool	bDMInitialGainEnable;
+
+	/* for rate adaptive, in fact,  88c/92c fw will handle this */
+	u8	bUseRAMask;
+
+	struct odm_rate_adapt RateAdaptive;
+
+	struct odm_rf_cal RFCalibrateInfo;
+
+	/*  TX power tracking */
+	u8	BbSwingIdxOfdm;
+	u8	BbSwingIdxOfdmCurrent;
+	u8	BbSwingIdxOfdmBase;
+	bool	BbSwingFlagOfdm;
+	u8	BbSwingIdxCck;
+	u8	BbSwingIdxCckCurrent;
+	u8	BbSwingIdxCckBase;
+	bool	BbSwingFlagCck;
+	u8	*mp_mode;
+	/*  ODM system resource. */
+
+	/*  ODM relative time. */
+	struct timer_list PathDivSwitchTimer;
+	/* 2011.09.27 add for Path Diversity */
+	struct timer_list CCKPathDiversityTimer;
+	struct timer_list FastAntTrainingTimer;
+};		/*  DM_Dynamic_Mechanism_Structure */
+
+enum ODM_RF_CONTENT {
+	odm_radioa_txt = 0x1000,
+	odm_radiob_txt = 0x1001,
+	odm_radioc_txt = 0x1002,
+	odm_radiod_txt = 0x1003
+};
+
+enum odm_bb_config_type {
+    CONFIG_BB_PHY_REG,
+    CONFIG_BB_AGC_TAB,
+    CONFIG_BB_AGC_TAB_2G,
+    CONFIG_BB_AGC_TAB_5G,
+    CONFIG_BB_PHY_REG_PG,
+};
+
+/*  Status code */
+enum rt_status {
+	RT_STATUS_SUCCESS,
+	RT_STATUS_FAILURE,
+	RT_STATUS_PENDING,
+	RT_STATUS_RESOURCE,
+	RT_STATUS_INVALID_CONTEXT,
+	RT_STATUS_INVALID_PARAMETER,
+	RT_STATUS_NOT_SUPPORT,
+	RT_STATUS_OS_API_FAILED,
+};
+
+/* 3=========================================================== */
+/* 3 DIG */
+/* 3=========================================================== */
+
+enum dm_dig_op {
+	RT_TYPE_THRESH_HIGH	= 0,
+	RT_TYPE_THRESH_LOW	= 1,
+	RT_TYPE_BACKOFF		= 2,
+	RT_TYPE_RX_GAIN_MIN	= 3,
+	RT_TYPE_RX_GAIN_MAX	= 4,
+	RT_TYPE_ENABLE		= 5,
+	RT_TYPE_DISABLE		= 6,
+	DIG_OP_TYPE_MAX
+};
+
+#define		DM_DIG_THRESH_HIGH	40
+#define		DM_DIG_THRESH_LOW	35
+
+#define		DM_SCAN_RSSI_TH		0x14 /* scan return issue for LC */
+
+#define		DM_false_ALARM_THRESH_LOW	400
+#define		DM_false_ALARM_THRESH_HIGH	1000
+
+#define		DM_DIG_MAX_NIC			0x4e
+#define		DM_DIG_MIN_NIC			0x1e /* 0x22/0x1c */
+
+#define		DM_DIG_MAX_AP			0x32
+#define		DM_DIG_MIN_AP			0x20
+
+#define		DM_DIG_MAX_NIC_HP		0x46
+#define		DM_DIG_MIN_NIC_HP		0x2e
+
+#define		DM_DIG_MAX_AP_HP		0x42
+#define		DM_DIG_MIN_AP_HP		0x30
+
+/* vivi 92c&92d has different definition, 20110504 */
+/* this is for 92c */
+#define		DM_DIG_FA_TH0			0x200/* 0x20 */
+#define		DM_DIG_FA_TH1			0x300/* 0x100 */
+#define		DM_DIG_FA_TH2			0x400/* 0x200 */
+/* this is for 92d */
+#define		DM_DIG_FA_TH0_92D		0x100
+#define		DM_DIG_FA_TH1_92D		0x400
+#define		DM_DIG_FA_TH2_92D		0x600
+
+#define		DM_DIG_BACKOFF_MAX		12
+#define		DM_DIG_BACKOFF_MIN		-4
+#define		DM_DIG_BACKOFF_DEFAULT		10
+
+/* 3=========================================================== */
+/* 3 AGC RX High Power Mode */
+/* 3=========================================================== */
+#define	  LNA_Low_Gain_1		0x64
+#define	  LNA_Low_Gain_2		0x5A
+#define	  LNA_Low_Gain_3		0x58
+
+#define	  FA_RXHP_TH1			5000
+#define	  FA_RXHP_TH2			1500
+#define	  FA_RXHP_TH3			800
+#define	  FA_RXHP_TH4			600
+#define	  FA_RXHP_TH5			500
+
+/* 3=========================================================== */
+/* 3 EDCA */
+/* 3=========================================================== */
+
+/* 3=========================================================== */
+/* 3 Dynamic Tx Power */
+/* 3=========================================================== */
+/* Dynamic Tx Power Control Threshold */
+#define		TX_POWER_NEAR_FIELD_THRESH_LVL2	74
+#define		TX_POWER_NEAR_FIELD_THRESH_LVL1	67
+#define		TX_POWER_NEAR_FIELD_THRESH_AP		0x3F
+
+#define		TxHighPwrLevel_Normal		0
+#define		TxHighPwrLevel_Level1		1
+#define		TxHighPwrLevel_Level2		2
+#define		TxHighPwrLevel_BT1		3
+#define		TxHighPwrLevel_BT2		4
+#define		TxHighPwrLevel_15		5
+#define		TxHighPwrLevel_35		6
+#define		TxHighPwrLevel_50		7
+#define		TxHighPwrLevel_70		8
+#define		TxHighPwrLevel_100		9
+
+/* 3=========================================================== */
+/* 3 Rate Adaptive */
+/* 3=========================================================== */
+#define		DM_RATR_STA_INIT		0
+#define		DM_RATR_STA_HIGH		1
+#define		DM_RATR_STA_MIDDLE		2
+#define		DM_RATR_STA_LOW			3
+
+/* 3=========================================================== */
+/* 3 BB Power Save */
+/* 3=========================================================== */
+
+enum dm_1r_cca {
+	CCA_1R = 0,
+	CCA_2R = 1,
+	CCA_MAX = 2,
+};
+
+enum dm_rf {
+	RF_Save = 0,
+	RF_Normal = 1,
+	RF_MAX = 2,
+};
+
+/* 3=========================================================== */
+/* 3 Antenna Diversity */
+/* 3=========================================================== */
+enum dm_swas {
+	Antenna_A = 1,
+	Antenna_B = 2,
+	Antenna_MAX = 3,
+};
+
+/*  Maximal number of antenna detection mechanism needs to perform. */
+#define	MAX_ANTENNA_DETECTION_CNT	10
+
+/*  Extern Global Variables. */
+#define	OFDM_TABLE_SIZE_92C	37
+#define	OFDM_TABLE_SIZE_92D	43
+#define	CCK_TABLE_SIZE		33
+
+extern	u32 OFDMSwingTable[OFDM_TABLE_SIZE_92D];
+extern	u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8];
+extern	u8 CCKSwingTable_Ch14 [CCK_TABLE_SIZE][8];
+
+/*  check Sta pointer valid or not */
+#define IS_STA_VALID(pSta)		(pSta)
+/*  20100514 Joseph: Add definition for antenna switching test after link. */
+/*  This indicates two different the steps. */
+/*  In SWAW_STEP_PEAK, driver needs to switch antenna and listen to the
+ *  signal on the air. */
+/*  In SWAW_STEP_DETERMINE, driver just compares the signal captured in
+ *  SWAW_STEP_PEAK */
+/*  with original RSSI to determine if it is necessary to switch antenna. */
+#define SWAW_STEP_PEAK		0
+#define SWAW_STEP_DETERMINE	1
+
+void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI);
+void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres);
+
+void ODM_SetAntenna(struct odm_dm_struct *pDM_Odm, u8 Antenna);
+
+#define dm_RF_Saving	ODM_RF_Saving
+void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal);
+
+#define SwAntDivRestAfterLink	ODM_SwAntDivRestAfterLink
+void ODM_SwAntDivRestAfterLink(struct odm_dm_struct *pDM_Odm);
+
+#define dm_CheckTXPowerTracking ODM_TXPowerTrackingCheck
+void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm);
+
+bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI,
+		      bool bForceUpdate, u8 *pRATRState);
+
+#define dm_SWAW_RSSI_Check	ODM_SwAntDivChkPerPktRssi
+void ODM_SwAntDivChkPerPktRssi(struct odm_dm_struct *pDM_Odm, u8 StationID,
+			       struct odm_phy_status_info *pPhyInfo);
+
+u32 ConvertTo_dB(u32 Value);
+
+u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point,
+	       u8 initial_gain_psd);
+
+void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm);
+
+u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid,
+			u32 ra_mask, u8 rssi_level);
+
+void ODM_DMInit(struct odm_dm_struct *pDM_Odm);
+
+void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm);
+
+void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm,
+		     enum odm_common_info_def CmnInfo, u32 Value);
+
+void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm,
+		     enum odm_common_info_def CmnInfo, void *pValue);
+
+void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm,
+			     enum odm_common_info_def CmnInfo,
+			     u16 Index, void *pValue);
+
+void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
+
+void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm);
+
+void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm);
+
+void ODM_ReleaseAllTimers(struct odm_dm_struct *pDM_Odm);
+
+void ODM_ResetIQKResult(struct odm_dm_struct *pDM_Odm);
+
+void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId,
+			      u32 PWDBAll, bool isCCKrate);
+
+void ODM_SingleDualAntennaDefaultSetting(struct odm_dm_struct *pDM_Odm);
+
+bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode);
+
+void odm_dtc(struct odm_dm_struct *pDM_Odm);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_HWConfig.h b/drivers/staging/r8188eu/include/odm_HWConfig.h
new file mode 100644
index 000000000000..80f549f196e2
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_HWConfig.h
@@ -0,0 +1,133 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__HALHWOUTSRC_H__
+#define __HALHWOUTSRC_H__
+
+/*  Definition */
+/*  CCK Rates, TxHT = 0 */
+#define DESC92C_RATE1M				0x00
+#define DESC92C_RATE2M				0x01
+#define DESC92C_RATE5_5M			0x02
+#define DESC92C_RATE11M				0x03
+
+/*  OFDM Rates, TxHT = 0 */
+#define DESC92C_RATE6M				0x04
+#define DESC92C_RATE9M				0x05
+#define DESC92C_RATE12M				0x06
+#define DESC92C_RATE18M				0x07
+#define DESC92C_RATE24M				0x08
+#define DESC92C_RATE36M				0x09
+#define DESC92C_RATE48M				0x0a
+#define DESC92C_RATE54M				0x0b
+
+/*  MCS Rates, TxHT = 1 */
+#define DESC92C_RATEMCS0			0x0c
+#define DESC92C_RATEMCS1			0x0d
+#define DESC92C_RATEMCS2			0x0e
+#define DESC92C_RATEMCS3			0x0f
+#define DESC92C_RATEMCS4			0x10
+#define DESC92C_RATEMCS5			0x11
+#define DESC92C_RATEMCS6			0x12
+#define DESC92C_RATEMCS7			0x13
+#define DESC92C_RATEMCS8			0x14
+#define DESC92C_RATEMCS9			0x15
+#define DESC92C_RATEMCS10			0x16
+#define DESC92C_RATEMCS11			0x17
+#define DESC92C_RATEMCS12			0x18
+#define DESC92C_RATEMCS13			0x19
+#define DESC92C_RATEMCS14			0x1a
+#define DESC92C_RATEMCS15			0x1b
+#define DESC92C_RATEMCS15_SG			0x1c
+#define DESC92C_RATEMCS32			0x20
+
+/*  structure and define */
+
+struct phy_rx_agc_info {
+	#ifdef __LITTLE_ENDIAN
+		u8	gain:7, trsw:1;
+	#else
+		u8	trsw:1, gain:7;
+	#endif
+};
+
+struct phy_status_rpt {
+	struct phy_rx_agc_info path_agc[3];
+	u8	ch_corr[2];
+	u8	cck_sig_qual_ofdm_pwdb_all;
+	u8	cck_agc_rpt_ofdm_cfosho_a;
+	u8	cck_rpt_b_ofdm_cfosho_b;
+	u8	rsvd_1;/* ch_corr_msb; */
+	u8	noise_power_db_msb;
+	u8	path_cfotail[2];
+	u8	pcts_mask[2];
+	s8	stream_rxevm[2];
+	u8	path_rxsnr[3];
+	u8	noise_power_db_lsb;
+	u8	rsvd_2[3];
+	u8	stream_csi[2];
+	u8	stream_target_csi[2];
+	s8	sig_evm;
+	u8	rsvd_3;
+
+#ifdef __LITTLE_ENDIAN
+	u8	antsel_rx_keep_2:1;	/* ex_intf_flg:1; */
+	u8	sgi_en:1;
+	u8	rxsc:2;
+	u8	idle_long:1;
+	u8	r_ant_train_en:1;
+	u8	ant_sel_b:1;
+	u8	ant_sel:1;
+#else	/*  _BIG_ENDIAN_ */
+	u8	ant_sel:1;
+	u8	ant_sel_b:1;
+	u8	r_ant_train_en:1;
+	u8	idle_long:1;
+	u8	rxsc:2;
+	u8	sgi_en:1;
+	u8	antsel_rx_keep_2:1;	/* ex_intf_flg:1; */
+#endif
+};
+
+void odm_Init_RSSIForDM(struct odm_dm_struct *pDM_Odm);
+
+void ODM_PhyStatusQuery(struct odm_dm_struct *pDM_Odm,
+			struct odm_phy_status_info *pPhyInfo,
+			u8 *pPhyStatus,
+			struct odm_per_pkt_info *pPktinfo,
+			struct adapter *adapt);
+
+void ODM_MacStatusQuery(struct odm_dm_struct *pDM_Odm,
+			u8 *pMacStatus,
+			u8	MacID,
+			bool	bPacketMatchBSSID,
+			bool	bPacketToSelf,
+			bool	bPacketBeacon);
+
+enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *pDM_Odm,
+					   enum rf_radio_path Content,
+					   enum rf_radio_path eRFPath);
+
+enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *pDM_Odm,
+					   enum odm_bb_config_type ConfigType);
+
+enum HAL_STATUS ODM_ConfigMACWithHeaderFile(struct odm_dm_struct *pDM_Odm);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
new file mode 100644
index 000000000000..f96ad5af4bd5
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -0,0 +1,56 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef	__ODM_RTL8188E_H__
+#define __ODM_RTL8188E_H__
+
+#define	MAIN_ANT	0
+#define	AUX_ANT	1
+#define	MAIN_ANT_CG_TRX	1
+#define	AUX_ANT_CG_TRX	0
+#define	MAIN_ANT_CGCS_RX	0
+#define	AUX_ANT_CGCS_RX	1
+
+void ODM_DIG_LowerBound_88E(struct odm_dm_struct *pDM_Odm);
+
+void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *pDM_Odm);
+
+void ODM_AntennaDiversity_88E(struct odm_dm_struct *pDM_Odm);
+
+void ODM_SetTxAntByTxInfo_88E(struct odm_dm_struct *pDM_Odm, u8 *pDesc,
+			      u8 macId);
+
+void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *pDM_Odm, u8 Ant);
+
+void ODM_AntselStatistics_88E(struct odm_dm_struct *pDM_Odm, u8	antsel_tr_mux,
+			      u32 MacId, u8 RxPWDBAll);
+
+void odm_FastAntTraining(struct odm_dm_struct *pDM_Odm);
+
+void odm_FastAntTrainingCallback(struct odm_dm_struct *pDM_Odm);
+
+void odm_FastAntTrainingWorkItemCallback(struct odm_dm_struct *pDM_Odm);
+
+void odm_PrimaryCCA_Init(struct odm_dm_struct *pDM_Odm);
+
+bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *pDM_Odm);
+
+void odm_DynamicPrimaryCCA(struct odm_dm_struct *pDM_Odm);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_RegConfig8188E.h b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
new file mode 100644
index 000000000000..f2bf7a0d9867
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_RegConfig8188E.h
@@ -0,0 +1,43 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __INC_ODM_REGCONFIG_H_8188E
+#define __INC_ODM_REGCONFIG_H_8188E
+
+void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data,
+			   enum rf_radio_path  RF_PATH, u32 RegAddr);
+
+void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm,
+			       u32 Addr, u32 Data);
+
+void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm,
+			       u32 Addr, u32 Data);
+
+void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data);
+
+void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+			    u32 Bitmask, u32 Data);
+
+void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+				   u32 Bitmask, u32 Data);
+
+void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+			    u32 Bitmask, u32 Data);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11AC.h b/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
new file mode 100644
index 000000000000..01425f36634c
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_RegDefine11AC.h
@@ -0,0 +1,46 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__ODM_REGDEFINE11AC_H__
+#define __ODM_REGDEFINE11AC_H__
+
+/* 2 RF REG LIST */
+
+/* 2 BB REG LIST */
+/* PAGE 8 */
+/* PAGE 9 */
+#define	ODM_REG_OFDM_FA_RST_11AC		0x9A4
+/* PAGE A */
+#define	ODM_REG_CCK_CCA_11AC				0xA0A
+#define	ODM_REG_CCK_FA_RST_11AC			0xA2C
+#define	ODM_REG_CCK_FA_11AC				0xA5C
+/* PAGE C */
+#define	ODM_REG_IGI_A_11AC				0xC50
+/* PAGE E */
+#define	ODM_REG_IGI_B_11AC				0xE50
+/* PAGE F */
+#define	ODM_REG_OFDM_FA_11AC			0xF48
+
+/* 2 MAC REG LIST */
+
+/* DIG Related */
+#define	ODM_BIT_IGI_11AC				0xFFFFFFFF
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_RegDefine11N.h b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
new file mode 100644
index 000000000000..2b888dee3dd5
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_RegDefine11N.h
@@ -0,0 +1,160 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__ODM_REGDEFINE11N_H__
+#define __ODM_REGDEFINE11N_H__
+
+/* 2 RF REG LIST */
+#define	ODM_REG_RF_MODE_11N				0x00
+#define	ODM_REG_RF_0B_11N				0x0B
+#define	ODM_REG_CHNBW_11N				0x18
+#define	ODM_REG_T_METER_11N				0x24
+#define	ODM_REG_RF_25_11N				0x25
+#define	ODM_REG_RF_26_11N				0x26
+#define	ODM_REG_RF_27_11N				0x27
+#define	ODM_REG_RF_2B_11N				0x2B
+#define	ODM_REG_RF_2C_11N				0x2C
+#define	ODM_REG_RXRF_A3_11N				0x3C
+#define	ODM_REG_T_METER_92D_11N			0x42
+#define	ODM_REG_T_METER_88E_11N			0x42
+
+/* 2 BB REG LIST */
+/* PAGE 8 */
+#define	ODM_REG_BB_CTRL_11N				0x800
+#define	ODM_REG_RF_PIN_11N				0x804
+#define	ODM_REG_PSD_CTRL_11N				0x808
+#define	ODM_REG_TX_ANT_CTRL_11N			0x80C
+#define	ODM_REG_BB_PWR_SAV5_11N			0x818
+#define	ODM_REG_CCK_RPT_FORMAT_11N		0x824
+#define	ODM_REG_RX_DEFUALT_A_11N		0x858
+#define	ODM_REG_RX_DEFUALT_B_11N		0x85A
+#define	ODM_REG_BB_PWR_SAV3_11N			0x85C
+#define	ODM_REG_ANTSEL_CTRL_11N			0x860
+#define	ODM_REG_RX_ANT_CTRL_11N			0x864
+#define	ODM_REG_PIN_CTRL_11N				0x870
+#define	ODM_REG_BB_PWR_SAV1_11N			0x874
+#define	ODM_REG_ANTSEL_PATH_11N			0x878
+#define	ODM_REG_BB_3WIRE_11N			0x88C
+#define	ODM_REG_SC_CNT_11N				0x8C4
+#define	ODM_REG_PSD_DATA_11N			0x8B4
+/* PAGE 9 */
+#define	ODM_REG_ANT_MAPPING1_11N		0x914
+#define	ODM_REG_ANT_MAPPING2_11N		0x918
+/* PAGE A */
+#define	ODM_REG_CCK_ANTDIV_PARA1_11N	0xA00
+#define	ODM_REG_CCK_CCA_11N				0xA0A
+#define	ODM_REG_CCK_ANTDIV_PARA2_11N	0xA0C
+#define	ODM_REG_CCK_ANTDIV_PARA3_11N	0xA10
+#define	ODM_REG_CCK_ANTDIV_PARA4_11N	0xA14
+#define	ODM_REG_CCK_FILTER_PARA1_11N	0xA22
+#define	ODM_REG_CCK_FILTER_PARA2_11N	0xA23
+#define	ODM_REG_CCK_FILTER_PARA3_11N	0xA24
+#define	ODM_REG_CCK_FILTER_PARA4_11N	0xA25
+#define	ODM_REG_CCK_FILTER_PARA5_11N	0xA26
+#define	ODM_REG_CCK_FILTER_PARA6_11N	0xA27
+#define	ODM_REG_CCK_FILTER_PARA7_11N	0xA28
+#define	ODM_REG_CCK_FILTER_PARA8_11N	0xA29
+#define	ODM_REG_CCK_FA_RST_11N			0xA2C
+#define	ODM_REG_CCK_FA_MSB_11N			0xA58
+#define	ODM_REG_CCK_FA_LSB_11N			0xA5C
+#define	ODM_REG_CCK_CCA_CNT_11N			0xA60
+#define	ODM_REG_BB_PWR_SAV4_11N			0xA74
+/* PAGE B */
+#define	ODM_REG_LNA_SWITCH_11N			0xB2C
+#define	ODM_REG_PATH_SWITCH_11N			0xB30
+#define	ODM_REG_RSSI_CTRL_11N			0xB38
+#define	ODM_REG_CONFIG_ANTA_11N			0xB68
+#define	ODM_REG_RSSI_BT_11N				0xB9C
+/* PAGE C */
+#define	ODM_REG_OFDM_FA_HOLDC_11N		0xC00
+#define	ODM_REG_RX_PATH_11N				0xC04
+#define	ODM_REG_TRMUX_11N				0xC08
+#define	ODM_REG_OFDM_FA_RSTC_11N		0xC0C
+#define	ODM_REG_RXIQI_MATRIX_11N		0xC14
+#define	ODM_REG_TXIQK_MATRIX_LSB1_11N	0xC4C
+#define	ODM_REG_IGI_A_11N				0xC50
+#define	ODM_REG_ANTDIV_PARA2_11N		0xC54
+#define	ODM_REG_IGI_B_11N					0xC58
+#define	ODM_REG_ANTDIV_PARA3_11N		0xC5C
+#define	ODM_REG_BB_PWR_SAV2_11N			0xC70
+#define	ODM_REG_RX_OFF_11N				0xC7C
+#define	ODM_REG_TXIQK_MATRIXA_11N		0xC80
+#define	ODM_REG_TXIQK_MATRIXB_11N		0xC88
+#define	ODM_REG_TXIQK_MATRIXA_LSB2_11N	0xC94
+#define	ODM_REG_TXIQK_MATRIXB_LSB2_11N	0xC9C
+#define	ODM_REG_RXIQK_MATRIX_LSB_11N	0xCA0
+#define	ODM_REG_ANTDIV_PARA1_11N		0xCA4
+#define	ODM_REG_OFDM_FA_TYPE1_11N		0xCF0
+/* PAGE D */
+#define	ODM_REG_OFDM_FA_RSTD_11N		0xD00
+#define	ODM_REG_OFDM_FA_TYPE2_11N		0xDA0
+#define	ODM_REG_OFDM_FA_TYPE3_11N		0xDA4
+#define	ODM_REG_OFDM_FA_TYPE4_11N		0xDA8
+/* PAGE E */
+#define	ODM_REG_TXAGC_A_6_18_11N		0xE00
+#define	ODM_REG_TXAGC_A_24_54_11N		0xE04
+#define	ODM_REG_TXAGC_A_1_MCS32_11N	0xE08
+#define	ODM_REG_TXAGC_A_MCS0_3_11N		0xE10
+#define	ODM_REG_TXAGC_A_MCS4_7_11N		0xE14
+#define	ODM_REG_TXAGC_A_MCS8_11_11N	0xE18
+#define	ODM_REG_TXAGC_A_MCS12_15_11N	0xE1C
+#define	ODM_REG_FPGA0_IQK_11N			0xE28
+#define	ODM_REG_TXIQK_TONE_A_11N		0xE30
+#define	ODM_REG_RXIQK_TONE_A_11N		0xE34
+#define	ODM_REG_TXIQK_PI_A_11N			0xE38
+#define	ODM_REG_RXIQK_PI_A_11N			0xE3C
+#define	ODM_REG_TXIQK_11N				0xE40
+#define	ODM_REG_RXIQK_11N				0xE44
+#define	ODM_REG_IQK_AGC_PTS_11N			0xE48
+#define	ODM_REG_IQK_AGC_RSP_11N			0xE4C
+#define	ODM_REG_BLUETOOTH_11N			0xE6C
+#define	ODM_REG_RX_WAIT_CCA_11N			0xE70
+#define	ODM_REG_TX_CCK_RFON_11N			0xE74
+#define	ODM_REG_TX_CCK_BBON_11N			0xE78
+#define	ODM_REG_OFDM_RFON_11N			0xE7C
+#define	ODM_REG_OFDM_BBON_11N			0xE80
+#define		ODM_REG_TX2RX_11N				0xE84
+#define	ODM_REG_TX2TX_11N				0xE88
+#define	ODM_REG_RX_CCK_11N				0xE8C
+#define	ODM_REG_RX_OFDM_11N				0xED0
+#define	ODM_REG_RX_WAIT_RIFS_11N		0xED4
+#define	ODM_REG_RX2RX_11N				0xED8
+#define	ODM_REG_STANDBY_11N				0xEDC
+#define	ODM_REG_SLEEP_11N				0xEE0
+#define	ODM_REG_PMPD_ANAEN_11N			0xEEC
+
+/* 2 MAC REG LIST */
+#define	ODM_REG_BB_RST_11N				0x02
+#define	ODM_REG_ANTSEL_PIN_11N			0x4C
+#define	ODM_REG_EARLY_MODE_11N			0x4D0
+#define	ODM_REG_RSSI_MONITOR_11N		0x4FE
+#define	ODM_REG_EDCA_VO_11N				0x500
+#define	ODM_REG_EDCA_VI_11N				0x504
+#define	ODM_REG_EDCA_BE_11N				0x508
+#define	ODM_REG_EDCA_BK_11N				0x50C
+#define	ODM_REG_TXPAUSE_11N				0x522
+#define	ODM_REG_RESP_TX_11N				0x6D8
+#define	ODM_REG_ANT_TRAIN_PARA1_11N	0x7b0
+#define	ODM_REG_ANT_TRAIN_PARA2_11N	0x7b4
+
+/* DIG Related */
+#define	ODM_BIT_IGI_11N					0x0000007F
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_debug.h b/drivers/staging/r8188eu/include/odm_debug.h
new file mode 100644
index 000000000000..5e58b603d6ac
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_debug.h
@@ -0,0 +1,143 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__ODM_DBG_H__
+#define __ODM_DBG_H__
+
+/*  */
+/*	Define the debug levels */
+/*  */
+/*	1. DBG_TRACE and DBG_LOUD are used for normal cases. */
+/*	They can help SW engineer to develop or trace states changed */
+/*	and also help HW enginner to trace every operation to and from HW, */
+/*	e.g IO, Tx, Rx. */
+/*  */
+/*	2. DBG_WARNNING and DBG_SERIOUS are used for unusual or error cases, */
+/*	which help us to debug SW or HW. */
+
+/*	Never used in a call to ODM_RT_TRACE()! */
+#define ODM_DBG_OFF				1
+
+/*	Fatal bug. */
+/*	For example, Tx/Rx/IO locked up, OS hangs, memory access violation, */
+/*	resource allocation failed, unexpected HW behavior, HW BUG and so on. */
+#define ODM_DBG_SERIOUS				2
+
+/*	Abnormal, rare, or unexpeted cases. */
+/*	For example, IRP/Packet/OID canceled, device suprisely unremoved and so on. */
+#define ODM_DBG_WARNING				3
+
+/*	Normal case with useful information about current SW or HW state. */
+/*	For example, Tx/Rx descriptor to fill, Tx/Rx descr. completed status, */
+/*	SW protocol state change, dynamic mechanism state change and so on. */
+/*  */
+#define ODM_DBG_LOUD					4
+
+/*	Normal case with detail execution flow or information. */
+#define ODM_DBG_TRACE					5
+
+/*  Define the tracing components */
+/* BB Functions */
+#define ODM_COMP_DIG					BIT0
+#define ODM_COMP_RA_MASK				BIT1
+#define ODM_COMP_DYNAMIC_TXPWR				BIT2
+#define ODM_COMP_FA_CNT					BIT3
+#define ODM_COMP_RSSI_MONITOR				BIT4
+#define ODM_COMP_CCK_PD					BIT5
+#define ODM_COMP_ANT_DIV				BIT6
+#define ODM_COMP_PWR_SAVE				BIT7
+#define ODM_COMP_PWR_TRA				BIT8
+#define ODM_COMP_RATE_ADAPTIVE				BIT9
+#define ODM_COMP_PATH_DIV				BIT10
+#define ODM_COMP_PSD					BIT11
+#define ODM_COMP_DYNAMIC_PRICCA				BIT12
+#define ODM_COMP_RXHP					BIT13
+/* MAC Functions */
+#define ODM_COMP_EDCA_TURBO				BIT16
+#define ODM_COMP_EARLY_MODE				BIT17
+/* RF Functions */
+#define ODM_COMP_TX_PWR_TRACK				BIT24
+#define ODM_COMP_RX_GAIN_TRACK				BIT25
+#define ODM_COMP_CALIBRATION				BIT26
+/* Common Functions */
+#define ODM_COMP_COMMON					BIT30
+#define ODM_COMP_INIT					BIT31
+
+/*------------------------Export Marco Definition---------------------------*/
+#define DbgPrint	pr_info
+#define RT_PRINTK(fmt, args...)				\
+	DbgPrint( "%s(): " fmt, __func__, ## args);
+
+#ifndef ASSERT
+	#define ASSERT(expr)
+#endif
+
+#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
+	if (((comp) & pDM_Odm->DebugComponents) &&			\
+	    (level <= pDM_Odm->DebugLevel)) {				\
+		if (pDM_Odm->SupportICType == ODM_RTL8192C)		\
+			DbgPrint("[ODM-92C] ");				\
+		else if (pDM_Odm->SupportICType == ODM_RTL8192D)	\
+			DbgPrint("[ODM-92D] ");				\
+		else if (pDM_Odm->SupportICType == ODM_RTL8723A)	\
+			DbgPrint("[ODM-8723A] ");			\
+		else if (pDM_Odm->SupportICType == ODM_RTL8188E)	\
+			DbgPrint("[ODM-8188E] ");			\
+		else if (pDM_Odm->SupportICType == ODM_RTL8812)		\
+			DbgPrint("[ODM-8812] ");			\
+		else if (pDM_Odm->SupportICType == ODM_RTL8821)		\
+			DbgPrint("[ODM-8821] ");			\
+		RT_PRINTK fmt;						\
+	}
+
+#define ODM_RT_TRACE_F(pDM_Odm, comp, level, fmt)			\
+	if (((comp) & pDM_Odm->DebugComponents) &&			\
+	    (level <= pDM_Odm->DebugLevel)) {				\
+		RT_PRINTK fmt;						\
+	}
+
+#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)				\
+	if (!(expr)) {							\
+		DbgPrint( "Assertion failed! %s at ......\n", #expr);	\
+		DbgPrint( "      ......%s,%s,line=%d\n", __FILE__,	\
+			__func__, __LINE__);				\
+		RT_PRINTK fmt;						\
+		ASSERT(false);						\
+	}
+#define ODM_dbg_enter() { DbgPrint("==> %s\n", __func__); }
+#define ODM_dbg_exit() { DbgPrint("<== %s\n", __func__); }
+#define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
+
+#define ODM_PRINT_ADDR(pDM_Odm, comp, level, title_str, ptr)		\
+	if (((comp) & pDM_Odm->DebugComponents) &&			\
+	    (level <= pDM_Odm->DebugLevel)) {				\
+		int __i;						\
+		u8 *__ptr = (u8 *)ptr;					\
+		DbgPrint("[ODM] ");					\
+		DbgPrint(title_str);					\
+		DbgPrint(" ");						\
+		for (__i = 0; __i < 6; __i++)				\
+			DbgPrint("%02X%s", __ptr[__i], (__i==5)?"":"-");\
+		DbgPrint("\n");						\
+	}
+
+void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
+
+#endif	/*  __ODM_DBG_H__ */
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
new file mode 100644
index 000000000000..0abfa6febb7e
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -0,0 +1,164 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__ODM_INTERFACE_H__
+#define __ODM_INTERFACE_H__
+
+/*  */
+/*  =========== Constant/Structure/Enum/... Define */
+/*  */
+
+/*  */
+/*  =========== Macro Define */
+/*  */
+
+#define _reg_all(_name)			ODM_##_name
+#define _reg_ic(_name, _ic)		ODM_##_name##_ic
+#define _bit_all(_name)			BIT_##_name
+#define _bit_ic(_name, _ic)		BIT_##_name##_ic
+
+/*  _cat: implemented by Token-Pasting Operator. */
+
+/*===================================
+
+#define ODM_REG_DIG_11N		0xC50
+#define ODM_REG_DIG_11AC	0xDDD
+
+ODM_REG(DIG,_pDM_Odm)
+=====================================*/
+
+#define _reg_11N(_name)			ODM_REG_##_name##_11N
+#define _reg_11AC(_name)		ODM_REG_##_name##_11AC
+#define _bit_11N(_name)			ODM_BIT_##_name##_11N
+#define _bit_11AC(_name)		ODM_BIT_##_name##_11AC
+
+#define _cat(_name, _ic_type, _func)					\
+	(								\
+		((_ic_type) & ODM_IC_11N_SERIES) ? _func##_11N(_name) :	\
+		_func##_11AC(_name)					\
+	)
+
+/*  _name: name of register or bit. */
+/*  Example: "ODM_REG(R_A_AGC_CORE1, pDM_Odm)" */
+/*         gets "ODM_R_A_AGC_CORE1" or "ODM_R_A_AGC_CORE1_8192C",
+ *	   depends on SupportICType. */
+#define ODM_REG(_name, _pDM_Odm) _cat(_name, _pDM_Odm->SupportICType, _reg)
+#define ODM_BIT(_name, _pDM_Odm) _cat(_name, _pDM_Odm->SupportICType, _bit)
+
+enum odm_h2c_cmd {
+	ODM_H2C_RSSI_REPORT = 0,
+	ODM_H2C_PSD_RESULT= 1,
+	ODM_H2C_PathDiv = 2,
+	ODM_MAX_H2CCMD
+};
+
+/*  2012/02/17 MH For non-MP compile pass only. Linux does not support workitem. */
+/*  Suggest HW team to use thread instead of workitem. Windows also support the feature. */
+typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
+
+/*  =========== Extern Variable ??? It should be forbidden. */
+
+/*  =========== EXtern Function Prototype */
+
+u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
+
+u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
+
+u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
+
+void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data);
+
+void ODM_Write2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 Data);
+
+void ODM_Write4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 Data);
+
+void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
+		   u32 BitMask, u32 Data);
+
+u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
+
+void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
+		  u32 BitMask, u32 Data);
+
+u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
+
+void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
+		  u32 RegAddr, u32 BitMask, u32 Data);
+
+u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
+		 u32 RegAddr, u32 BitMask);
+
+/*  Memory Relative Function. */
+void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length);
+void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length);
+
+s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
+		      u32 length);
+
+/*  ODM MISC-spin lock relative API. */
+void ODM_AcquireSpinLock(struct odm_dm_struct *pDM_Odm,
+			 enum RT_SPINLOCK_TYPE type);
+
+void ODM_ReleaseSpinLock(struct odm_dm_struct *pDM_Odm,
+			 enum RT_SPINLOCK_TYPE type);
+
+/*  ODM MISC-workitem relative API. */
+void ODM_InitializeWorkItem(struct odm_dm_struct *pDM_Odm, void *pRtWorkItem,
+			    RT_WORKITEM_CALL_BACK RtWorkItemCallback,
+			    void *pContext, const char *szID);
+
+void ODM_StartWorkItem(void *pRtWorkItem);
+
+void ODM_StopWorkItem(void *pRtWorkItem);
+
+void ODM_FreeWorkItem(void *pRtWorkItem);
+
+void ODM_ScheduleWorkItem(void *pRtWorkItem);
+
+void ODM_IsWorkItemScheduled(void *pRtWorkItem);
+
+/*  ODM Timer relative API. */
+void ODM_StallExecution(u32 usDelay);
+
+void ODM_delay_ms(u32 ms);
+
+void ODM_delay_us(u32 us);
+
+void ODM_sleep_ms(u32 ms);
+
+void ODM_sleep_us(u32 us);
+
+void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer,
+		  u32 msDelay);
+
+void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm,
+			 struct timer_list *pTimer, void *CallBackFunc,
+			 void *pContext, const char *szID);
+
+void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
+
+void ODM_ReleaseTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer);
+
+/*  ODM FW relative API. */
+u32 ODM_FillH2CCmd(u8 *pH2CBuffer, u32 H2CBufferLen, u32 CmdNum,
+		   u32 *pElementID, u32 *pCmdLen, u8 **pCmbBuffer,
+		   u8 *CmdStartSeq);
+
+#endif	/*  __ODM_INTERFACE_H__ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
new file mode 100644
index 000000000000..b2fbb5d5ea77
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -0,0 +1,103 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef	__ODM_PRECOMP_H__
+#define __ODM_PRECOMP_H__
+
+#include "odm_types.h"
+
+#define		TEST_FALG___		1
+
+/* 2 Config Flags and Structs - defined by each ODM Type */
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <hal_intf.h>
+
+/* 2 OutSrc Header Files */
+
+#include "odm.h"
+#include "odm_HWConfig.h"
+#include "odm_debug.h"
+#include "odm_RegDefine11AC.h"
+#include "odm_RegDefine11N.h"
+
+#include "HalPhyRf.h"
+#include "HalPhyRf_8188e.h"/* for IQK,LCK,Power-tracking */
+#include "Hal8188ERateAdaptive.h"/* for  RA,Power training */
+#include "rtl8188e_hal.h"
+
+#include "odm_interface.h"
+#include "odm_reg.h"
+
+#include "HalHWImg8188E_MAC.h"
+#include "HalHWImg8188E_RF.h"
+#include "HalHWImg8188E_BB.h"
+#include "Hal8188EReg.h"
+
+#include "odm_RegConfig8188E.h"
+#include "odm_RTL8188E.h"
+
+void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm);
+void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm);
+void odm_DIGInit(struct odm_dm_struct *pDM_Odm);
+void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
+void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
+void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm);
+void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
+void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
+void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
+void odm_GlobalAdapterCheck(void);
+void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm);
+void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
+void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
+void odm_DIG(struct odm_dm_struct *pDM_Odm);
+void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
+void odm_RefreshRateAdaptiveMaskMP(struct odm_dm_struct *pDM_Odm);
+void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm);
+void odm_SwAntDivChkAntSwitch(struct odm_dm_struct *pDM_Odm, u8 Step);
+void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
+void odm_DynamicTxPower(struct odm_dm_struct *pDM_Odm);
+void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm);
+void odm_SwAntDivInit(struct odm_dm_struct *pDM_Odm);
+void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
+void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm);
+void odm_1R_CCA(struct odm_dm_struct *pDM_Odm);
+void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm);
+void odm_RefreshRateAdaptiveMaskAPADSL(struct odm_dm_struct *pDM_Odm);
+void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm);
+void odm_DynamicTxPowerAP(struct odm_dm_struct *pDM_Odm);
+void odm_RSSIMonitorCheckMP(struct odm_dm_struct *pDM_Odm);
+void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm);
+void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm);
+void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
+void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm);
+void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm);
+void odm_TXPowerTrackingCheckMP(struct odm_dm_struct *pDM_Odm);
+void odm_TXPowerTrackingCheckAP(struct odm_dm_struct *pDM_Odm);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext);
+#else
+void odm_SwAntDivChkAntSwitchCallback(struct timer_list *t);
+#endif
+void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
+void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
+
+#endif	/*  __ODM_PRECOMP_H__ */
diff --git a/drivers/staging/r8188eu/include/odm_reg.h b/drivers/staging/r8188eu/include/odm_reg.h
new file mode 100644
index 000000000000..4221855e333c
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_reg.h
@@ -0,0 +1,116 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+/*  */
+/*  File Name: odm_reg.h */
+/*  */
+/*  Description: */
+/*  */
+/*  This file is for general register definition. */
+/*  */
+/*  */
+/*  */
+#ifndef	__HAL_ODM_REG_H__
+#define __HAL_ODM_REG_H__
+
+/*  */
+/*  Register Definition */
+/*  */
+
+/* MAC REG */
+#define	ODM_BB_RESET					0x002
+#define	ODM_DUMMY						0x4fe
+#define	ODM_EDCA_VO_PARAM			0x500
+#define	ODM_EDCA_VI_PARAM			0x504
+#define	ODM_EDCA_BE_PARAM			0x508
+#define	ODM_EDCA_BK_PARAM			0x50C
+#define	ODM_TXPAUSE					0x522
+
+/* BB REG */
+#define	ODM_FPGA_PHY0_PAGE8			0x800
+#define	ODM_PSD_SETTING				0x808
+#define	ODM_AFE_SETTING				0x818
+#define	ODM_TXAGC_B_6_18				0x830
+#define	ODM_TXAGC_B_24_54			0x834
+#define	ODM_TXAGC_B_MCS32_5			0x838
+#define	ODM_TXAGC_B_MCS0_MCS3		0x83c
+#define	ODM_TXAGC_B_MCS4_MCS7		0x848
+#define	ODM_TXAGC_B_MCS8_MCS11		0x84c
+#define	ODM_ANALOG_REGISTER			0x85c
+#define	ODM_RF_INTERFACE_OUTPUT		0x860
+#define	ODM_TXAGC_B_MCS12_MCS15	0x868
+#define	ODM_TXAGC_B_11_A_2_11		0x86c
+#define	ODM_AD_DA_LSB_MASK			0x874
+#define	ODM_ENABLE_3_WIRE			0x88c
+#define	ODM_PSD_REPORT				0x8b4
+#define	ODM_R_ANT_SELECT				0x90c
+#define	ODM_CCK_ANT_SELECT			0xa07
+#define	ODM_CCK_PD_THRESH			0xa0a
+#define	ODM_CCK_RF_REG1				0xa11
+#define	ODM_CCK_MATCH_FILTER			0xa20
+#define	ODM_CCK_RAKE_MAC				0xa2e
+#define	ODM_CCK_CNT_RESET			0xa2d
+#define	ODM_CCK_TX_DIVERSITY			0xa2f
+#define	ODM_CCK_FA_CNT_MSB			0xa5b
+#define	ODM_CCK_FA_CNT_LSB			0xa5c
+#define	ODM_CCK_NEW_FUNCTION		0xa75
+#define	ODM_OFDM_PHY0_PAGE_C		0xc00
+#define	ODM_OFDM_RX_ANT				0xc04
+#define	ODM_R_A_RXIQI					0xc14
+#define	ODM_R_A_AGC_CORE1			0xc50
+#define	ODM_R_A_AGC_CORE2			0xc54
+#define	ODM_R_B_AGC_CORE1			0xc58
+#define	ODM_R_AGC_PAR					0xc70
+#define	ODM_R_HTSTF_AGC_PAR			0xc7c
+#define	ODM_TX_PWR_TRAINING_A		0xc90
+#define	ODM_TX_PWR_TRAINING_B		0xc98
+#define	ODM_OFDM_FA_CNT1				0xcf0
+#define	ODM_OFDM_PHY0_PAGE_D		0xd00
+#define	ODM_OFDM_FA_CNT2				0xda0
+#define	ODM_OFDM_FA_CNT3				0xda4
+#define	ODM_OFDM_FA_CNT4				0xda8
+#define	ODM_TXAGC_A_6_18				0xe00
+#define	ODM_TXAGC_A_24_54			0xe04
+#define	ODM_TXAGC_A_1_MCS32			0xe08
+#define	ODM_TXAGC_A_MCS0_MCS3		0xe10
+#define	ODM_TXAGC_A_MCS4_MCS7		0xe14
+#define	ODM_TXAGC_A_MCS8_MCS11		0xe18
+#define	ODM_TXAGC_A_MCS12_MCS15		0xe1c
+
+/* RF REG */
+#define	ODM_GAIN_SETTING				0x00
+#define	ODM_CHANNEL					0x18
+
+/* Ant Detect Reg */
+#define	ODM_DPDT						0x300
+
+/* PSD Init */
+#define	ODM_PSDREG					0x808
+
+/* 92D Path Div */
+#define	PATHDIV_REG					0xB30
+#define	PATHDIV_TRI					0xBA0
+
+/*  */
+/*  Bitmap Definition */
+/*  */
+
+#define	BIT_FA_RESET					BIT0
+
+#endif
diff --git a/drivers/staging/r8188eu/include/odm_types.h b/drivers/staging/r8188eu/include/odm_types.h
new file mode 100644
index 000000000000..f62d8b486a28
--- /dev/null
+++ b/drivers/staging/r8188eu/include/odm_types.h
@@ -0,0 +1,61 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __ODM_TYPES_H__
+#define __ODM_TYPES_H__
+
+/*  */
+/*  Define Different SW team support */
+/*  */
+#define	ODM_AP			0x01	 /* BIT0 */
+#define	ODM_ADSL		0x02	/* BIT1 */
+#define	ODM_CE			0x04	/* BIT2 */
+#define	ODM_MP			0x08	/* BIT3 */
+
+#define		RT_PCI_INTERFACE				1
+#define		RT_USB_INTERFACE				2
+#define		RT_SDIO_INTERFACE				3
+
+enum HAL_STATUS {
+	HAL_STATUS_SUCCESS,
+	HAL_STATUS_FAILURE,
+};
+
+enum RT_SPINLOCK_TYPE {
+	RT_TEMP = 1,
+};
+
+#include <basic_types.h>
+
+#define DEV_BUS_TYPE	RT_USB_INTERFACE
+
+#define SET_TX_DESC_ANTSEL_A_88E(__pTxDesc, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pTxDesc+8, 24, 1, __Value)
+#define SET_TX_DESC_ANTSEL_B_88E(__pTxDesc, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pTxDesc+8, 25, 1, __Value)
+#define SET_TX_DESC_ANTSEL_C_88E(__pTxDesc, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pTxDesc+28, 29, 1, __Value)
+
+/* define useless flag to avoid compile warning */
+#define	USE_WORKITEM			0
+#define		FOR_BRAZIL_PRETEST	0
+#define	BT_30_SUPPORT			0
+#define   FPGA_TWO_MAC_VERIFICATION	0
+
+#endif /*  __ODM_TYPES_H__ */
diff --git a/drivers/staging/r8188eu/include/osdep_intf.h b/drivers/staging/r8188eu/include/osdep_intf.h
new file mode 100644
index 000000000000..c4599c583b59
--- /dev/null
+++ b/drivers/staging/r8188eu/include/osdep_intf.h
@@ -0,0 +1,83 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef __OSDEP_INTF_H_
+#define __OSDEP_INTF_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+struct intf_priv {
+	u8 *intf_dev;
+	u32	max_iosz;	/* USB2.0: 128, USB1.1: 64, SDIO:64 */
+	u32	max_xmitsz; /* USB2.0: unlimited, SDIO:512 */
+	u32	max_recvsz; /* USB2.0: unlimited, SDIO:512 */
+
+	u8 *io_rwmem;
+	u8 *allocated_io_rwmem;
+	u32	io_wsz; /* unit: 4bytes */
+	u32	io_rsz;/* unit: 4bytes */
+	u8 intf_status;
+
+	void (*_bus_io)(u8 *priv);
+
+/*
+Under Sync. IRP (SDIO/USB)
+A protection mechanism is necessary for the io_rwmem(read/write protocol)
+
+Under Async. IRP (SDIO/USB)
+The protection mechanism is through the pending queue.
+*/
+	struct mutex ioctl_mutex;
+	/*  when in USB, IO is through interrupt in/out endpoints */
+	struct usb_device	*udev;
+	struct urb *piorw_urb;
+	u8 io_irp_cnt;
+	u8 bio_irp_pending;
+	struct semaphore  io_retevt;
+	struct timer_list io_timer;
+	u8 bio_irp_timeout;
+	u8 bio_timer_cancel;
+};
+
+u8 rtw_init_drv_sw(struct adapter *padapter);
+u8 rtw_free_drv_sw(struct adapter *padapter);
+u8 rtw_reset_drv_sw(struct adapter *padapter);
+
+u32 rtw_start_drv_threads(struct adapter *padapter);
+void rtw_stop_drv_threads (struct adapter *padapter);
+void rtw_cancel_all_timer(struct adapter *padapter);
+
+int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
+
+int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname);
+struct net_device *rtw_init_netdev(struct adapter *padapter);
+u16 rtw_recv_select_queue(struct sk_buff *skb);
+void rtw_proc_init_one(struct net_device *dev);
+void rtw_proc_remove_one(struct net_device *dev);
+
+void rtw_ips_dev_unload(struct adapter *padapter);
+
+int rtw_ips_pwr_up(struct adapter *padapter);
+void rtw_ips_pwr_down(struct adapter *padapter);
+int rtw_hw_suspend(struct adapter *padapter);
+int rtw_hw_resume(struct adapter *padapter);
+
+#endif	/* _OSDEP_INTF_H_ */
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
new file mode 100644
index 000000000000..ce76a2c99bbd
--- /dev/null
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -0,0 +1,489 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __OSDEP_SERVICE_H_
+#define __OSDEP_SERVICE_H_
+
+#include <linux/version.h>
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 11, 0)
+#include <linux/sched/signal.h>
+#endif
+#include <basic_types.h>
+
+#define _FAIL		0
+#define _SUCCESS	1
+#define RTW_RX_HANDLED 2
+
+#include <linux/spinlock.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kref.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/circ_buf.h>
+#include <linux/uaccess.h>
+#include <asm/byteorder.h>
+#include <asm/atomic.h>
+#include <linux/io.h>
+#include <linux/semaphore.h>
+#include <linux/sem.h>
+#include <linux/sched.h>
+#include <linux/etherdevice.h>
+#include <linux/wireless.h>
+#include <net/iw_handler.h>
+#include <linux/if_arp.h>
+#include <linux/rtnetlink.h>
+#include <linux/delay.h>
+#include <linux/proc_fs.h>	/*  Necessary because we use the proc fs */
+#include <linux/interrupt.h>	/*  for struct tasklet_struct */
+#include <linux/ip.h>
+#include <linux/kthread.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+
+struct	__queue	{
+	struct	list_head	queue;
+	spinlock_t lock;
+};
+
+#define thread_exit() complete_and_exit(NULL, 0)
+
+static inline struct list_head *get_list_head(struct __queue *queue)
+{
+	return (&(queue->queue));
+}
+
+static inline int _enter_critical_mutex(struct mutex *pmutex, unsigned long *pirqL)
+{
+	int ret;
+
+	ret = mutex_lock_interruptible(pmutex);
+	return ret;
+}
+
+static inline void _exit_critical_mutex(struct mutex *pmutex, unsigned long *pirqL)
+{
+		mutex_unlock(pmutex);
+}
+
+static inline void rtw_list_delete(struct list_head *plist)
+{
+	list_del_init(plist);
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+static inline void _init_timer(struct timer_list *ptimer,struct  net_device *nic_hdl,void *pfunc,void* cntx)
+{
+	ptimer->function = pfunc;
+	ptimer->data = (unsigned long)cntx;
+	init_timer(ptimer);
+}
+#endif
+
+static inline void _set_timer(struct timer_list *ptimer,u32 delay_time)
+{
+	mod_timer(ptimer , (jiffies+(delay_time*HZ/1000)));
+}
+
+static inline void _cancel_timer(struct timer_list *ptimer,u8 *bcancelled)
+{
+	del_timer_sync(ptimer);
+	*bcancelled=  true;/* true ==1; false==0 */
+}
+
+#define RTW_TIMER_HDL_ARGS void *FunctionContext
+#define RTW_TIMER_HDL_NAME(name) rtw_##name##_timer_hdl
+#define RTW_DECLARE_TIMER_HDL(name) void RTW_TIMER_HDL_NAME(name)(RTW_TIMER_HDL_ARGS)
+
+static inline void _init_workitem(struct work_struct *pwork, void *pfunc, void * cntx)
+{
+	INIT_WORK(pwork, pfunc);
+}
+
+static inline void _set_workitem(struct work_struct *pwork)
+{
+	schedule_work(pwork);
+}
+
+static inline void _cancel_workitem_sync(struct work_struct *pwork)
+{
+	cancel_work_sync(pwork);
+}
+/*  */
+/*  Global Mutex: can only be used at PASSIVE level. */
+/*  */
+
+#define ACQUIRE_GLOBAL_MUTEX(_MutexCounter)                              \
+{                                                               \
+	while (atomic_inc_return((atomic_t *)&(_MutexCounter)) != 1)\
+	{                                                           \
+		atomic_dec((atomic_t *)&(_MutexCounter));        \
+		msleep(10);                          \
+	}                                                           \
+}
+
+#define RELEASE_GLOBAL_MUTEX(_MutexCounter)                              \
+{                                                               \
+	atomic_dec((atomic_t *)&(_MutexCounter));        \
+}
+
+static inline int rtw_netif_queue_stopped(struct net_device *pnetdev)
+{
+	return  netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 0)) &&
+		netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 1)) &&
+		netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 2)) &&
+		netif_tx_queue_stopped(netdev_get_tx_queue(pnetdev, 3));
+}
+
+static inline void rtw_netif_wake_queue(struct net_device *pnetdev)
+{
+	netif_tx_wake_all_queues(pnetdev);
+}
+
+static inline void rtw_netif_start_queue(struct net_device *pnetdev)
+{
+	netif_tx_start_all_queues(pnetdev);
+}
+
+static inline void rtw_netif_stop_queue(struct net_device *pnetdev)
+{
+	netif_tx_stop_all_queues(pnetdev);
+}
+
+#ifndef BIT
+	#define BIT(x)	( 1 << (x))
+#endif
+
+#define BIT0	0x00000001
+#define BIT1	0x00000002
+#define BIT2	0x00000004
+#define BIT3	0x00000008
+#define BIT4	0x00000010
+#define BIT5	0x00000020
+#define BIT6	0x00000040
+#define BIT7	0x00000080
+#define BIT8	0x00000100
+#define BIT9	0x00000200
+#define BIT10	0x00000400
+#define BIT11	0x00000800
+#define BIT12	0x00001000
+#define BIT13	0x00002000
+#define BIT14	0x00004000
+#define BIT15	0x00008000
+#define BIT16	0x00010000
+#define BIT17	0x00020000
+#define BIT18	0x00040000
+#define BIT19	0x00080000
+#define BIT20	0x00100000
+#define BIT21	0x00200000
+#define BIT22	0x00400000
+#define BIT23	0x00800000
+#define BIT24	0x01000000
+#define BIT25	0x02000000
+#define BIT26	0x04000000
+#define BIT27	0x08000000
+#define BIT28	0x10000000
+#define BIT29	0x20000000
+#define BIT30	0x40000000
+#define BIT31	0x80000000
+#define BIT32	0x0100000000
+#define BIT33	0x0200000000
+#define BIT34	0x0400000000
+#define BIT35	0x0800000000
+#define BIT36	0x1000000000
+
+extern int RTW_STATUS_CODE(int error_code);
+
+/* flags used for rtw_update_mem_stat() */
+enum {
+	MEM_STAT_VIR_ALLOC_SUCCESS,
+	MEM_STAT_VIR_ALLOC_FAIL,
+	MEM_STAT_VIR_FREE,
+	MEM_STAT_PHY_ALLOC_SUCCESS,
+	MEM_STAT_PHY_ALLOC_FAIL,
+	MEM_STAT_PHY_FREE,
+	MEM_STAT_TX, /* used to distinguish TX/RX, asigned from caller */
+	MEM_STAT_TX_ALLOC_SUCCESS,
+	MEM_STAT_TX_ALLOC_FAIL,
+	MEM_STAT_TX_FREE,
+	MEM_STAT_RX, /* used to distinguish TX/RX, asigned from caller */
+	MEM_STAT_RX_ALLOC_SUCCESS,
+	MEM_STAT_RX_ALLOC_FAIL,
+	MEM_STAT_RX_FREE
+};
+
+extern unsigned char MCS_rate_2R[16];
+extern unsigned char MCS_rate_1R[16];
+extern unsigned char RTW_WPA_OUI[];
+extern unsigned char WPA_TKIP_CIPHER[4];
+extern unsigned char RSN_TKIP_CIPHER[4];
+
+#define rtw_update_mem_stat(flag, sz) do {} while (0)
+u8 *_rtw_vmalloc(u32 sz);
+u8 *_rtw_zvmalloc(u32 sz);
+void _rtw_vmfree(u8 *pbuf, u32 sz);
+u8 *_rtw_zmalloc(u32 sz);
+u8 *_rtw_malloc(u32 sz);
+void _rtw_mfree(u8 *pbuf, u32 sz);
+#define rtw_vmalloc(sz)			_rtw_vmalloc((sz))
+#define rtw_zvmalloc(sz)			_rtw_zvmalloc((sz))
+#define rtw_vmfree(pbuf, sz)		_rtw_vmfree((pbuf), (sz))
+#define rtw_malloc(sz)			_rtw_malloc((sz))
+#define rtw_zmalloc(sz)			_rtw_zmalloc((sz))
+#define rtw_mfree(pbuf, sz)		_rtw_mfree((pbuf), (sz))
+
+void *rtw_malloc2d(int h, int w, int size);
+void rtw_mfree2d(void *pbuf, int h, int w, int size);
+
+u32  _rtw_down_sema(struct semaphore *sema);
+void _rtw_mutex_init(struct mutex *pmutex);
+void _rtw_mutex_free(struct mutex *pmutex);
+void _rtw_spinlock_free(spinlock_t *plock);
+
+void _rtw_init_queue(struct __queue *pqueue);
+
+u32  rtw_systime_to_ms(u32 systime);
+u32  rtw_ms_to_systime(u32 ms);
+s32  rtw_get_passing_time_ms(u32 start);
+s32  rtw_get_time_interval_ms(u32 start, u32 end);
+
+void rtw_sleep_schedulable(int ms);
+
+void rtw_msleep_os(int ms);
+void rtw_usleep_os(int us);
+
+u32  rtw_atoi(u8 *s);
+
+void rtw_mdelay_os(int ms);
+void rtw_udelay_os(int us);
+
+void rtw_yield_os(void);
+
+static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
+{
+	return del_timer_sync(ptimer);
+}
+
+static __inline void thread_enter(char *name)
+{
+#ifdef daemonize
+	daemonize("%s", name);
+#endif
+	allow_signal(SIGTERM);
+}
+
+static inline void flush_signals_thread(void)
+{
+	if (signal_pending (current))
+		flush_signals(current);
+}
+
+static inline int res_to_status(int res)
+{
+	return res;
+}
+
+#define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
+#define RND4(x)	(((x >> 2) + (((x & 3) == 0) ?  0: 1)) << 2)
+
+static inline u32 _RND4(u32 sz)
+{
+	u32	val;
+
+	val = ((sz >> 2) + ((sz & 3) ? 1: 0)) << 2;
+	return val;
+}
+
+static inline u32 _RND8(u32 sz)
+{
+	u32	val;
+
+	val = ((sz >> 3) + ((sz & 7) ? 1: 0)) << 3;
+	return val;
+}
+
+static inline u32 _RND128(u32 sz)
+{
+	u32	val;
+
+	val = ((sz >> 7) + ((sz & 127) ? 1: 0)) << 7;
+	return val;
+}
+
+static inline u32 _RND256(u32 sz)
+{
+	u32	val;
+
+	val = ((sz >> 8) + ((sz & 255) ? 1: 0)) << 8;
+	return val;
+}
+
+static inline u32 _RND512(u32 sz)
+{
+	u32	val;
+
+	val = ((sz >> 9) + ((sz & 511) ? 1: 0)) << 9;
+	return val;
+}
+
+static inline u32 bitshift(u32 bitmask)
+{
+	u32 i;
+
+	for (i = 0; i <= 31; i++)
+		if (((bitmask>>i) &  0x1) == 1) break;
+	return i;
+}
+
+/*  limitation of path length */
+#define PATH_LENGTH_MAX PATH_MAX
+
+void rtw_suspend_lock_init(void);
+void rtw_suspend_lock_uninit(void);
+void rtw_lock_suspend(void);
+void rtw_unlock_suspend(void);
+
+/* Atomic integer operations */
+#define ATOMIC_T atomic_t
+
+void ATOMIC_SET(ATOMIC_T *v, int i);
+int ATOMIC_READ(ATOMIC_T *v);
+void ATOMIC_ADD(ATOMIC_T *v, int i);
+void ATOMIC_SUB(ATOMIC_T *v, int i);
+void ATOMIC_INC(ATOMIC_T *v);
+void ATOMIC_DEC(ATOMIC_T *v);
+int ATOMIC_ADD_RETURN(ATOMIC_T *v, int i);
+int ATOMIC_SUB_RETURN(ATOMIC_T *v, int i);
+int ATOMIC_INC_RETURN(ATOMIC_T *v);
+int ATOMIC_DEC_RETURN(ATOMIC_T *v);
+
+struct rtw_netdev_priv_indicator {
+	void *priv;
+	u32 sizeof_priv;
+};
+struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv,
+						    void *old_priv);
+struct net_device *rtw_alloc_etherdev(int sizeof_priv);
+
+#define rtw_netdev_priv(netdev)					\
+	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
+void rtw_free_netdev(struct net_device *netdev);
+
+#define NDEV_FMT "%s"
+#define NDEV_ARG(ndev) ndev->name
+#define ADPT_FMT "%s"
+#define ADPT_ARG(adapter) adapter->pnetdev->name
+#define FUNC_NDEV_FMT "%s(%s)"
+#define FUNC_NDEV_ARG(ndev) __func__, ndev->name
+#define FUNC_ADPT_FMT "%s(%s)"
+#define FUNC_ADPT_ARG(adapter) __func__, adapter->pnetdev->name
+
+#define rtw_signal_process(pid, sig) kill_pid(find_vpid((pid)),(sig), 1)
+
+u64 rtw_modular64(u64 x, u64 y);
+u64 rtw_division64(u64 x, u64 y);
+
+/* Macros for handling unaligned memory accesses */
+
+#define RTW_GET_BE16(a) ((u16) (((a)[0] << 8) | (a)[1]))
+#define RTW_PUT_BE16(a, val)			\
+	do {					\
+		(a)[0] = ((u16) (val)) >> 8;	\
+		(a)[1] = ((u16) (val)) & 0xff;	\
+	} while (0)
+
+#define RTW_PUT_LE16(a, val)			\
+	do {					\
+		(a)[1] = ((u16) (val)) >> 8;	\
+		(a)[0] = ((u16) (val)) & 0xff;	\
+	} while (0)
+
+#define RTW_GET_BE24(a) ((((u32) (a)[0]) << 16) | (((u32) (a)[1]) << 8) | \
+			 ((u32) (a)[2]))
+#define RTW_PUT_BE24(a, val)					\
+	do {							\
+		(a)[0] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
+		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
+		(a)[2] = (u8) (((u32) (val)) & 0xff);		\
+	} while (0)
+
+#define RTW_GET_BE32(a) ((((u32) (a)[0]) << 24) | (((u32) (a)[1]) << 16) | \
+			 (((u32) (a)[2]) << 8) | ((u32) (a)[3]))
+#define RTW_PUT_BE32(a, val)					\
+	do {							\
+		(a)[0] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
+		(a)[1] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
+		(a)[2] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
+		(a)[3] = (u8) (((u32) (val)) & 0xff);		\
+	} while (0)
+
+#define RTW_GET_LE32(a) ((((u32) (a)[3]) << 24) | (((u32) (a)[2]) << 16) | \
+			 (((u32) (a)[1]) << 8) | ((u32) (a)[0]))
+#define RTW_PUT_LE32(a, val)					\
+	do {							\
+		(a)[3] = (u8) ((((u32) (val)) >> 24) & 0xff);	\
+		(a)[2] = (u8) ((((u32) (val)) >> 16) & 0xff);	\
+		(a)[1] = (u8) ((((u32) (val)) >> 8) & 0xff);	\
+		(a)[0] = (u8) (((u32) (val)) & 0xff);		\
+	} while (0)
+
+#define RTW_GET_BE64(a) ((((u64) (a)[0]) << 56) | (((u64) (a)[1]) << 48) | \
+			 (((u64) (a)[2]) << 40) | (((u64) (a)[3]) << 32) | \
+			 (((u64) (a)[4]) << 24) | (((u64) (a)[5]) << 16) | \
+			 (((u64) (a)[6]) << 8) | ((u64) (a)[7]))
+#define RTW_PUT_BE64(a, val)				\
+	do {						\
+		(a)[0] = (u8) (((u64) (val)) >> 56);	\
+		(a)[1] = (u8) (((u64) (val)) >> 48);	\
+		(a)[2] = (u8) (((u64) (val)) >> 40);	\
+		(a)[3] = (u8) (((u64) (val)) >> 32);	\
+		(a)[4] = (u8) (((u64) (val)) >> 24);	\
+		(a)[5] = (u8) (((u64) (val)) >> 16);	\
+		(a)[6] = (u8) (((u64) (val)) >> 8);	\
+		(a)[7] = (u8) (((u64) (val)) & 0xff);	\
+	} while (0)
+
+#define RTW_GET_LE64(a) ((((u64) (a)[7]) << 56) | (((u64) (a)[6]) << 48) | \
+			 (((u64) (a)[5]) << 40) | (((u64) (a)[4]) << 32) | \
+			 (((u64) (a)[3]) << 24) | (((u64) (a)[2]) << 16) | \
+			 (((u64) (a)[1]) << 8) | ((u64) (a)[0]))
+
+void rtw_buf_free(u8 **buf, u32 *buf_len);
+void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len);
+
+struct rtw_cbuf {
+	u32 write;
+	u32 read;
+	u32 size;
+	void *bufs[0];
+};
+
+bool rtw_cbuf_full(struct rtw_cbuf *cbuf);
+bool rtw_cbuf_empty(struct rtw_cbuf *cbuf);
+bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf);
+void *rtw_cbuf_pop(struct rtw_cbuf *cbuf);
+struct rtw_cbuf *rtw_cbuf_alloc(u32 size);
+int wifirate2_ratetbl_inx(unsigned char rate);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
new file mode 100644
index 000000000000..b6ddf0ba2dde
--- /dev/null
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -0,0 +1,54 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RECV_OSDEP_H_
+#define __RECV_OSDEP_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
+void _rtw_free_recv_priv(struct recv_priv *precvpriv);
+
+s32  rtw_recv_entry(struct recv_frame *precv_frame);
+int rtw_recv_indicatepkt(struct adapter *adapter, struct recv_frame *recv_frame);
+void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
+
+void rtw_hostapd_mlme_rx(struct adapter *padapter, struct recv_frame *recv_fr);
+void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
+
+int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
+void rtw_free_recv_priv(struct recv_priv *precvpriv);
+
+int rtw_os_recv_resource_init(struct recv_priv *recvpr, struct adapter *adapt);
+int rtw_os_recv_resource_alloc(struct adapter *adapt, struct recv_frame *recvfr);
+void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
+
+int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
+int rtw_os_recvbuf_resource_free(struct adapter *adapt, struct recv_buf *buf);
+
+void rtw_os_read_port(struct adapter *padapter, struct recv_buf *precvbuf);
+
+void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
+int nat25_handle_frame(struct adapter *priv, struct sk_buff *skb);
+int _netdev_open(struct net_device *pnetdev);
+int netdev_open(struct net_device *pnetdev);
+int netdev_close(struct net_device *pnetdev);
+
+#endif /*  */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_cmd.h b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
new file mode 100644
index 000000000000..b32bc28503d0
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_cmd.h
@@ -0,0 +1,122 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_CMD_H__
+#define __RTL8188E_CMD_H__
+
+enum RTL8188E_H2C_CMD_ID {
+	/* Class Common */
+	H2C_COM_RSVD_PAGE		= 0x00,
+	H2C_COM_MEDIA_STATUS_RPT	= 0x01,
+	H2C_COM_SCAN			= 0x02,
+	H2C_COM_KEEP_ALIVE		= 0x03,
+	H2C_COM_DISCNT_DECISION		= 0x04,
+	H2C_COM_INIT_OFFLOAD		= 0x06,
+	H2C_COM_REMOTE_WAKE_CTL		= 0x07,
+	H2C_COM_AP_OFFLOAD		= 0x08,
+	H2C_COM_BCN_RSVD_PAGE		= 0x09,
+	H2C_COM_PROB_RSP_RSVD_PAGE	= 0x0A,
+
+	/* Class PS */
+	H2C_PS_PWR_MODE			= 0x20,
+	H2C_PS_TUNE_PARA		= 0x21,
+	H2C_PS_TUNE_PARA_2		= 0x22,
+	H2C_PS_LPS_PARA			= 0x23,
+	H2C_PS_P2P_OFFLOAD		= 0x24,
+
+	/* Class DM */
+	H2C_DM_MACID_CFG		= 0x40,
+	H2C_DM_TXBF			= 0x41,
+
+	/* Class BT */
+	H2C_BT_COEX_MASK		= 0x60,
+	H2C_BT_COEX_GPIO_MODE		= 0x61,
+	H2C_BT_DAC_SWING_VAL		= 0x62,
+	H2C_BT_PSD_RST			= 0x63,
+
+	/* Class */
+	 H2C_RESET_TSF			= 0xc0,
+};
+
+struct cmd_msg_parm {
+	u8 eid; /* element id */
+	u8 sz; /*  sz */
+	u8 buf[6];
+};
+
+enum {
+	PWRS
+};
+
+struct setpwrmode_parm {
+	u8 Mode;/* 0:Active,1:LPS,2:WMMPS */
+	u8 SmartPS_RLBM;/* LPS= 0:PS_Poll,1:PS_Poll,2:NullData,WMM= 0:PS_Poll,1:NullData */
+	u8 AwakeInterval;	/*  unit: beacon interval */
+	u8 bAllQueueUAPSD;
+	u8 PwrState;/* AllON(0x0c),RFON(0x04),RFOFF(0x00) */
+};
+
+struct H2C_SS_RFOFF_PARAM {
+	u8 ROFOn; /*  1: on, 0:off */
+	u16 gpio_period; /*  unit: 1024 us */
+} __packed;
+
+struct joinbssrpt_parm {
+	u8 OpMode;	/*  RT_MEDIA_STATUS */
+};
+
+struct rsvdpage_loc {
+	u8 LocProbeRsp;
+	u8 LocPsPoll;
+	u8 LocNullData;
+	u8 LocQosNull;
+	u8 LocBTQosNull;
+};
+
+struct P2P_PS_Offload_t {
+	u8 Offload_En:1;
+	u8 role:1; /*  1: Owner, 0: Client */
+	u8 CTWindow_En:1;
+	u8 NoA0_En:1;
+	u8 NoA1_En:1;
+	u8 AllStaSleep:1; /*  Only valid in Owner */
+	u8 discovery:1;
+	u8 rsvd:1;
+};
+
+struct P2P_PS_CTWPeriod_t {
+	u8 CTWPeriod;	/* TU */
+};
+
+/*  host message to firmware cmd */
+void rtl8188e_set_FwPwrMode_cmd(struct adapter *padapter, u8 Mode);
+void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *padapter, u8 mstatus);
+u8 rtl8188e_set_rssi_cmd(struct adapter *padapter, u8 *param);
+u8 rtl8188e_set_raid_cmd(struct adapter *padapter, u32 mask);
+void rtl8188e_Add_RateATid(struct adapter *padapter, u32 bitmap, u8 arg,
+			   u8 rssi_level);
+
+#ifdef CONFIG_88EU_P2P
+void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state);
+#endif /* CONFIG_88EU_P2P */
+
+void CheckFwRsvdPageContent(struct adapter *adapt);
+void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt);
+
+#endif/* __RTL8188E_CMD_H__ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
new file mode 100644
index 000000000000..97a3175250ef
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -0,0 +1,62 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_DM_H__
+#define __RTL8188E_DM_H__
+enum{
+	UP_LINK,
+	DOWN_LINK,
+};
+/*  duplicate code,will move to ODM ######### */
+#define IQK_MAC_REG_NUM		4
+#define IQK_ADDA_REG_NUM		16
+#define IQK_BB_REG_NUM			9
+#define HP_THERMAL_NUM		8
+/*  duplicate code,will move to ODM ######### */
+struct	dm_priv {
+	u8	DM_Type;
+	u8	DMFlag;
+	u8	InitDMFlag;
+	u32	InitODMFlag;
+
+	/*  Upper and Lower Signal threshold for Rate Adaptive*/
+	int	UndecoratedSmoothedPWDB;
+	int	UndecoratedSmoothedCCK;
+	int	EntryMinUndecoratedSmoothedPWDB;
+	int	EntryMaxUndecoratedSmoothedPWDB;
+	int	MinUndecoratedPWDBForDM;
+	int	LastMinUndecoratedPWDBForDM;
+
+	/* for High Power */
+	u8 bDynamicTxPowerEnable;
+	u8 LastDTPLvl;
+	u8 DynamicTxHighPowerLvl;/* Tx Power Control for Near/Far Range */
+	u8	PowerIndex_backup[6];
+};
+
+void rtl8188e_init_dm_priv(struct adapter *adapt);
+void rtl8188e_deinit_dm_priv(struct adapter *adapt);
+void rtl8188e_InitHalDm(struct adapter *adapt);
+void rtl8188e_HalDmWatchDog(struct adapter *adapt);
+
+void AntDivCompare8188E(struct adapter *adapt, struct wlan_bssid_ex *dst,
+			struct wlan_bssid_ex *src);
+u8 AntDivBeforeLink8188E(struct adapter *adapt);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
new file mode 100644
index 000000000000..09368a5cd6e8
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -0,0 +1,471 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_HAL_H__
+#define __RTL8188E_HAL_H__
+
+/* include HAL Related header after HAL Related compiling flags */
+#include "rtl8188e_spec.h"
+#include "Hal8188EPhyReg.h"
+#include "Hal8188EPhyCfg.h"
+#include "rtl8188e_rf.h"
+#include "rtl8188e_dm.h"
+#include "rtl8188e_recv.h"
+#include "rtl8188e_xmit.h"
+#include "rtl8188e_cmd.h"
+#include "Hal8188EPwrSeq.h"
+#include "rtl8188e_sreset.h"
+#include "rtw_efuse.h"
+
+#include "odm_precomp.h"
+
+/*  Fw Array */
+#define Rtl8188E_FwImageArray		Rtl8188EFwImgArray
+#define Rtl8188E_FWImgArrayLength	Rtl8188EFWImgArrayLength
+
+#define RTL8188E_FW_UMC_IMG			"rtl8188E\\rtl8188efw.bin"
+#define RTL8188E_PHY_REG			"rtl8188E\\PHY_REG_1T.txt"
+#define RTL8188E_PHY_RADIO_A			"rtl8188E\\radio_a_1T.txt"
+#define RTL8188E_PHY_RADIO_B			"rtl8188E\\radio_b_1T.txt"
+#define RTL8188E_AGC_TAB			"rtl8188E\\AGC_TAB_1T.txt"
+#define RTL8188E_PHY_MACREG			"rtl8188E\\MAC_REG.txt"
+#define RTL8188E_PHY_REG_PG			"rtl8188E\\PHY_REG_PG.txt"
+#define RTL8188E_PHY_REG_MP			"rtl8188E\\PHY_REG_MP.txt"
+
+/* 		RTL8188E Power Configuration CMDs for USB/SDIO interfaces */
+#define Rtl8188E_NIC_PWR_ON_FLOW		rtl8188E_power_on_flow
+#define Rtl8188E_NIC_RF_OFF_FLOW		rtl8188E_radio_off_flow
+#define Rtl8188E_NIC_DISABLE_FLOW		rtl8188E_card_disable_flow
+#define Rtl8188E_NIC_ENABLE_FLOW		rtl8188E_card_enable_flow
+#define Rtl8188E_NIC_SUSPEND_FLOW		rtl8188E_suspend_flow
+#define Rtl8188E_NIC_RESUME_FLOW		rtl8188E_resume_flow
+#define Rtl8188E_NIC_PDN_FLOW			rtl8188E_hwpdn_flow
+#define Rtl8188E_NIC_LPS_ENTER_FLOW		rtl8188E_enter_lps_flow
+#define Rtl8188E_NIC_LPS_LEAVE_FLOW		rtl8188E_leave_lps_flow
+
+#define DRVINFO_SZ	4 /*  unit is 8bytes */
+#define PageNum_128(_Len)	(u32)(((_Len)>>7) + ((_Len) & 0x7F ? 1 : 0))
+
+/*  download firmware related data structure */
+#define FW_8188E_SIZE			0x4000 /* 16384,16k */
+#define FW_8188E_START_ADDRESS		0x1000
+#define FW_8188E_END_ADDRESS		0x1FFF /* 0x5FFF */
+
+#define MAX_PAGE_SIZE			4096	/*  @ page : 4k bytes */
+
+#define IS_FW_HEADER_EXIST(_pFwHdr)				\
+	((le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x92C0 ||	\
+	(le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x88C0 ||	\
+	(le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x2300 ||	\
+	(le16_to_cpu(_pFwHdr->Signature)&0xFFF0) == 0x88E0)
+
+/*  This structure must be careful with byte-ordering */
+
+struct rt_firmware_hdr {
+	/*  8-byte alinment required */
+	/*  LONG WORD 0 ---- */
+	__le16		Signature;	/* 92C0: test chip; 92C,
+					 * 88C0: test chip; 88C1: MP A-cut;
+					 * 92C1: MP A-cut */
+	u8		Category;	/*  AP/NIC and USB/PCI */
+	u8		Function;	/*  Reserved for different FW function
+					 *  indcation, for further use when
+					 *  driver needs to download different
+					 *  FW for different conditions */
+	__le16		Version;	/*  FW Version */
+	u8		Subversion;	/*  FW Subversion, default 0x00 */
+	u16		Rsvd1;
+
+	/*  LONG WORD 1 ---- */
+	u8		Month;	/*  Release time Month field */
+	u8		Date;	/*  Release time Date field */
+	u8		Hour;	/*  Release time Hour field */
+	u8		Minute;	/*  Release time Minute field */
+	__le16		RamCodeSize;	/*  The size of RAM code */
+	u8		Foundry;
+	u8		Rsvd2;
+
+	/*  LONG WORD 2 ---- */
+	__le32		SvnIdx;	/*  The SVN entry index */
+	u32		Rsvd3;
+
+	/*  LONG WORD 3 ---- */
+	u32		Rsvd4;
+	u32		Rsvd5;
+};
+
+#define DRIVER_EARLY_INT_TIME		0x05
+#define BCN_DMA_ATIME_INT_TIME		0x02
+
+enum usb_rx_agg_mode {
+	USB_RX_AGG_DISABLE,
+	USB_RX_AGG_DMA,
+	USB_RX_AGG_USB,
+	USB_RX_AGG_MIX
+};
+
+#define MAX_RX_DMA_BUFFER_SIZE_88E				\
+      0x2400 /* 9k for 88E nornal chip , MaxRxBuff=10k-max(TxReportSize(64*8),
+	      * WOLPattern(16*24)) */
+
+#define MAX_TX_REPORT_BUFFER_SIZE		0x0400 /*  1k */
+
+/*  BK, BE, VI, VO, HCCA, MANAGEMENT, COMMAND, HIGH, BEACON. */
+#define MAX_TX_QUEUE			9
+
+#define TX_SELE_HQ			BIT(0)		/*  High Queue */
+#define TX_SELE_LQ			BIT(1)		/*  Low Queue */
+#define TX_SELE_NQ			BIT(2)		/*  Normal Queue */
+
+/*  Note: We will divide number of page equally for each queue other
+ *  than public queue! */
+/*  22k = 22528 bytes = 176 pages (@page =  128 bytes) */
+/*  must reserved about 7 pages for LPS =>  176-7 = 169 (0xA9) */
+/*  2*BCN / 1*ps-poll / 1*null-data /1*prob_rsp /1*QOS null-data /1*BT QOS
+ *  null-data */
+
+#define TX_TOTAL_PAGE_NUMBER_88E		0xA9/*   169 (21632=> 21k) */
+
+#define TX_PAGE_BOUNDARY_88E (TX_TOTAL_PAGE_NUMBER_88E + 1)
+
+/* Note: For Normal Chip Setting ,modify later */
+#define WMM_NORMAL_TX_TOTAL_PAGE_NUMBER			\
+	TX_TOTAL_PAGE_NUMBER_88E  /* 0xA9 , 0xb0=>176=>22k */
+#define WMM_NORMAL_TX_PAGE_BOUNDARY_88E			\
+	(WMM_NORMAL_TX_TOTAL_PAGE_NUMBER + 1) /* 0xA9 */
+
+/* 	Chip specific */
+#define CHIP_BONDING_IDENTIFIER(_value)	(((_value)>>22)&0x3)
+#define CHIP_BONDING_92C_1T2R	0x1
+#define CHIP_BONDING_88C_USB_MCARD	0x2
+#define CHIP_BONDING_88C_USB_HP	0x1
+#include "HalVerDef.h"
+#include "hal_com.h"
+
+/* 	Channel Plan */
+enum ChannelPlan {
+	CHPL_FCC	= 0,
+	CHPL_IC		= 1,
+	CHPL_ETSI	= 2,
+	CHPL_SPA	= 3,
+	CHPL_FRANCE	= 4,
+	CHPL_MKK	= 5,
+	CHPL_MKK1	= 6,
+	CHPL_ISRAEL	= 7,
+	CHPL_TELEC	= 8,
+	CHPL_GLOBAL	= 9,
+	CHPL_WORLD	= 10,
+};
+
+struct txpowerinfo24g {
+	u8 IndexCCK_Base[RF_PATH_MAX][MAX_CHNL_GROUP_24G];
+	u8 IndexBW40_Base[RF_PATH_MAX][MAX_CHNL_GROUP_24G];
+	/* If only one tx, only BW20 and OFDM are used. */
+	s8 CCK_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8 OFDM_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8 BW20_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8 BW40_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+};
+
+#define EFUSE_REAL_CONTENT_LEN		512
+#define EFUSE_MAX_SECTION		16
+#define EFUSE_IC_ID_OFFSET		506 /* For some inferior IC purpose*/
+#define AVAILABLE_EFUSE_ADDR(addr)	(addr < EFUSE_REAL_CONTENT_LEN)
+/*  To prevent out of boundary programming case, */
+/*  leave 1byte and program full section */
+/*  9bytes + 1byt + 5bytes and pre 1byte. */
+/*  For worst case: */
+/*  | 1byte|----8bytes----|1byte|--5bytes--| */
+/*  |         |            Reserved(14bytes)	      | */
+
+/*  PG data exclude header, dummy 6 bytes frome CP test and reserved 1byte. */
+#define EFUSE_OOB_PROTECT_BYTES			15
+
+#define		HWSET_MAX_SIZE_88E		512
+
+#define		EFUSE_REAL_CONTENT_LEN_88E	256
+#define		EFUSE_MAP_LEN_88E		512
+#define EFUSE_MAP_LEN			EFUSE_MAP_LEN_88E
+#define		EFUSE_MAX_SECTION_88E		64
+#define		EFUSE_MAX_WORD_UNIT_88E		4
+#define		EFUSE_IC_ID_OFFSET_88E		506
+#define		AVAILABLE_EFUSE_ADDR_88E(addr)			\
+	(addr < EFUSE_REAL_CONTENT_LEN_88E)
+/*  To prevent out of boundary programming case, leave 1byte and program
+ *  full section */
+/*  9bytes + 1byt + 5bytes and pre 1byte. */
+/*  For worst case: */
+/*  | 2byte|----8bytes----|1byte|--7bytes--| 92D */
+/*  PG data exclude header, dummy 7 bytes frome CP test and reserved 1byte. */
+#define		EFUSE_OOB_PROTECT_BYTES_88E	18
+#define		EFUSE_PROTECT_BYTES_BANK_88E	16
+
+/* 			EFUSE for BT definition */
+#define EFUSE_BT_REAL_CONTENT_LEN	1536	/*  512*3 */
+#define EFUSE_BT_MAP_LEN		1024	/*  1k bytes */
+#define EFUSE_BT_MAX_SECTION		128	/*  1024/8 */
+
+#define EFUSE_PROTECT_BYTES_BANK	16
+
+/*  For RTL8723 WiFi/BT/GPS multi-function configuration. */
+enum rt_multi_func {
+	RT_MULTI_FUNC_NONE = 0x00,
+	RT_MULTI_FUNC_WIFI = 0x01,
+	RT_MULTI_FUNC_BT = 0x02,
+	RT_MULTI_FUNC_GPS = 0x04,
+};
+
+/*  For RTL8723 regulator mode. */
+enum rt_regulator_mode {
+	RT_SWITCHING_REGULATOR = 0,
+	RT_LDO_REGULATOR = 1,
+};
+
+struct hal_data_8188e {
+	struct HAL_VERSION	VersionID;
+	enum rt_multi_func MultiFunc; /*  For multi-function consideration. */
+	enum rt_regulator_mode RegulatorMode; /*  switching regulator or LDO */
+	u16	CustomerID;
+
+	u16	FirmwareVersion;
+	u16	FirmwareVersionRev;
+	u16	FirmwareSubVersion;
+	u16	FirmwareSignature;
+	u8	PGMaxGroup;
+	/* current WIFI_PHY values */
+	u32	ReceiveConfig;
+	enum wireless_mode CurrentWirelessMode;
+	enum ht_channel_width CurrentChannelBW;
+	u8	CurrentChannel;
+	u8	nCur40MhzPrimeSC;/*  Control channel sub-carrier */
+
+	u16	BasicRateSet;
+
+	/* rf_ctrl */
+	u8	rf_chip;
+	u8	rf_type;
+	u8	NumTotalRFPath;
+
+	u8	BoardType;
+
+	/*  EEPROM setting. */
+	u16	EEPROMVID;
+	u16	EEPROMPID;
+	u16	EEPROMSVID;
+	u16	EEPROMSDID;
+	u8	EEPROMCustomerID;
+	u8	EEPROMSubCustomerID;
+	u8	EEPROMVersion;
+	u8	EEPROMRegulatory;
+
+	u8	bTXPowerDataReadFromEEPORM;
+	u8	EEPROMThermalMeter;
+	u8	bAPKThermalMeterIgnore;
+
+	bool	EepromOrEfuse;
+	/* 92C:256bytes, 88E:512bytes, we use union set (512bytes) */
+	u8	EfuseMap[2][HWSET_MAX_SIZE_512];
+	u8	EfuseUsedPercentage;
+	struct efuse_hal	EfuseHal;
+
+	u8	Index24G_CCK_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	u8	Index24G_BW40_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	/* If only one tx, only BW20 and OFDM are used. */
+	s8	CCK_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8	OFDM_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8	BW20_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+	s8	BW40_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
+
+	u8	TxPwrLevelCck[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	/*  For HT 40MHZ pwr */
+	u8	TxPwrLevelHT40_1S[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	/*  For HT 40MHZ pwr */
+	u8	TxPwrLevelHT40_2S[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	/*  HT 20<->40 Pwr diff */
+	u8	TxPwrHt20Diff[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	/*  For HT<->legacy pwr diff */
+	u8	TxPwrLegacyHtDiff[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	/*  For power group */
+	u8	PwrGroupHT20[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+	u8	PwrGroupHT40[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
+
+	u8	LegacyHTTxPowerDiff;/*  Legacy to HT rate power diff */
+	/*  The current Tx Power Level */
+	u8	CurrentCckTxPwrIdx;
+	u8	CurrentOfdm24GTxPwrIdx;
+	u8	CurrentBW2024GTxPwrIdx;
+	u8	CurrentBW4024GTxPwrIdx;
+
+	/*  Read/write are allow for following hardware information variables */
+	u8	framesync;
+	u32	framesyncC34;
+	u8	framesyncMonitor;
+	u8	DefaultInitialGain[4];
+	u8	pwrGroupCnt;
+	u32	MCSTxPowerLevelOriginalOffset[MAX_PG_GROUP][16];
+	u32	CCKTxPowerLevelOriginalOffset;
+
+	u8	CrystalCap;
+	u32	AntennaTxPath;			/*  Antenna path Tx */
+	u32	AntennaRxPath;			/*  Antenna path Rx */
+	u8	BluetoothCoexist;
+	u8	ExternalPA;
+
+	u8	bLedOpenDrain; /* Open-drain support for controlling the LED.*/
+
+	u8	b1x1RecvCombine;	/*  for 1T1R receive combining */
+
+	u32	AcParam_BE; /* Original parameter for BE, use for EDCA turbo. */
+
+	struct bb_reg_def PHYRegDef[4];	/* Radio A/B/C/D */
+
+	u32	RfRegChnlVal[2];
+
+	/* RDG enable */
+	bool	 bRDGEnable;
+
+	/* for host message to fw */
+	u8	LastHMEBoxNum;
+
+	u8	fw_ractrl;
+	u8	RegTxPause;
+	/*  Beacon function related global variable. */
+	u32	RegBcnCtrlVal;
+	u8	RegFwHwTxQCtrl;
+	u8	RegReg542;
+	u8	RegCR_1;
+
+	struct dm_priv	dmpriv;
+	struct odm_dm_struct odmpriv;
+	struct sreset_priv srestpriv;
+
+	u8	CurAntenna;
+	u8	AntDivCfg;
+	u8	TRxAntDivType;
+
+	u8	bDumpRxPkt;/* for debug */
+	u8	bDumpTxPkt;/* for debug */
+	u8	FwRsvdPageStartOffset; /* Reserve page start offset except
+					*  beacon in TxQ. */
+
+	/*  2010/08/09 MH Add CU power down mode. */
+	bool		pwrdown;
+
+	/*  Add for dual MAC  0--Mac0 1--Mac1 */
+	u32	interfaceIndex;
+
+	u8	OutEpQueueSel;
+	u8	OutEpNumber;
+
+	/*  Add for USB aggreation mode dynamic shceme. */
+	bool		UsbRxHighSpeedMode;
+
+	/*  2010/11/22 MH Add for slim combo debug mode selective. */
+	/*  This is used for fix the drawback of CU TSMC-A/UMC-A cut.
+	 * HW auto suspend ability. Close BT clock. */
+	bool		SlimComboDbg;
+
+	u16	EfuseUsedBytes;
+
+#ifdef CONFIG_88EU_P2P
+	struct P2P_PS_Offload_t	p2p_ps_offload;
+#endif
+
+	/*  Auto FSM to Turn On, include clock, isolation, power control
+	 *  for MAC only */
+	u8	bMacPwrCtrlOn;
+
+	u32	UsbBulkOutSize;
+
+	/*  Interrupt relatd register information. */
+	u32	IntArray[3];/* HISR0,HISR1,HSISR */
+	u32	IntrMask[3];
+	u8	C2hArray[16];
+	u8	UsbTxAggMode;
+	u8	UsbTxAggDescNum;
+	u16	HwRxPageSize;		/*  Hardware setting */
+	u32	MaxUsbRxAggBlock;
+
+	enum usb_rx_agg_mode UsbRxAggMode;
+	u8	UsbRxAggBlockCount;	/*  USB Block count. Block size is
+					 * 512-byte in high speed and 64-byte
+					 * in full speed */
+	u8	UsbRxAggBlockTimeout;
+	u8	UsbRxAggPageCount;	/*  8192C DMA page count */
+	u8	UsbRxAggPageTimeout;
+};
+
+#define GET_HAL_DATA(__pAdapter)				\
+	((struct hal_data_8188e *)((__pAdapter)->HalData))
+#define GET_RF_TYPE(priv)		(GET_HAL_DATA(priv)->rf_type)
+
+#define INCLUDE_MULTI_FUNC_BT(_Adapter)				\
+	(GET_HAL_DATA(_Adapter)->MultiFunc & RT_MULTI_FUNC_BT)
+#define INCLUDE_MULTI_FUNC_GPS(_Adapter)			\
+	(GET_HAL_DATA(_Adapter)->MultiFunc & RT_MULTI_FUNC_GPS)
+
+/*  rtl8188e_hal_init.c */
+s32 rtl8188e_FirmwareDownload(struct adapter *padapter);
+void _8051Reset88E(struct adapter *padapter);
+void rtl8188e_InitializeFirmwareVars(struct adapter *padapter);
+
+s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
+
+/*  EFuse */
+u8 GetEEPROMSize8188E(struct adapter *padapter);
+void Hal_InitPGData88E(struct adapter *padapter);
+void Hal_EfuseParseIDCode88E(struct adapter *padapter, u8 *hwinfo);
+void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *hwinfo,
+			    bool AutoLoadFail);
+
+void Hal_EfuseParseEEPROMVer88E(struct adapter *padapter, u8 *hwinfo,
+				bool AutoLoadFail);
+void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo,
+				 bool AutoLoadFail);
+void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo,
+				 bool AutoLoadFail);
+void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter,u8 *PROMContent,
+				 bool AutoLoadFail);
+void Hal_ReadThermalMeter_88E(struct adapter *	dapter, u8 *PROMContent,
+			      bool AutoloadFail);
+void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo,
+			      bool AutoLoadFail);
+void Hal_EfuseParseBoardType88E(struct adapter *pAdapter, u8 *hwinfo,
+				bool AutoLoadFail);
+void Hal_ReadPowerSavingMode88E(struct adapter *pAdapter, u8 *hwinfo,
+				bool AutoLoadFail);
+
+bool HalDetectPwrDownMode88E(struct adapter *Adapter);
+
+void Hal_InitChannelPlan(struct adapter *padapter);
+void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc);
+
+/*  register */
+void SetBcnCtrlReg(struct adapter *padapter, u8 SetBits, u8 ClearBits);
+
+void rtl8188e_clone_haldata(struct adapter *dst, struct adapter *src);
+void rtl8188e_start_thread(struct adapter *padapter);
+void rtl8188e_stop_thread(struct adapter *padapter);
+
+void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter  *Adapter, int len);
+s32 rtl8188e_iol_efuse_patch(struct adapter *padapter);
+void rtw_cancel_all_timer(struct adapter *padapter);
+void _ps_open_RF(struct adapter *adapt);
+
+#endif /* __RTL8188E_HAL_H__ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_led.h b/drivers/staging/r8188eu/include/rtl8188e_led.h
new file mode 100644
index 000000000000..9cb03d6565d3
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_led.h
@@ -0,0 +1,34 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_LED_H__
+#define __RTL8188E_LED_H__
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+/*  */
+/*  Interface to manipulate LED objects. */
+/*  */
+void rtl8188eu_InitSwLeds(struct adapter *padapter);
+void rtl8188eu_DeInitSwLeds(struct adapter *padapter);
+void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
+void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
new file mode 100644
index 000000000000..e2ef281c2c44
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -0,0 +1,69 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_RECV_H__
+#define __RTL8188E_RECV_H__
+
+#define TX_RPT1_PKT_LEN 8
+
+#define RECV_BLK_SZ 512
+#define RECV_BLK_CNT 16
+#define RECV_BLK_TH RECV_BLK_CNT
+#define RECV_BULK_IN_ADDR		0x80
+#define RECV_INT_IN_ADDR		0x81
+
+#define NR_PREALLOC_RECV_SKB (8)
+
+#define NR_RECVBUFF (4)
+
+#define MAX_RECVBUF_SZ (15360) /*  15k < 16k */
+
+struct phy_stat {
+	unsigned int phydw0;
+	unsigned int phydw1;
+	unsigned int phydw2;
+	unsigned int phydw3;
+	unsigned int phydw4;
+	unsigned int phydw5;
+	unsigned int phydw6;
+	unsigned int phydw7;
+};
+
+/*  Rx smooth factor */
+#define	Rx_Smooth_Factor (20)
+
+enum rx_packet_type {
+	NORMAL_RX,/* Normal rx packet */
+	TX_REPORT1,/* CCX */
+	TX_REPORT2,/* TX RPT */
+	HIS_REPORT,/*  USB HISR RPT */
+};
+
+#define INTERRUPT_MSG_FORMAT_LEN 60
+void rtl8188eu_init_recvbuf(struct adapter *padapter, struct recv_buf *buf);
+s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
+void rtl8188eu_free_recv_priv(struct adapter * padapter);
+void rtl8188eu_recv_hdl(struct adapter * padapter, struct recv_buf *precvbuf);
+void rtl8188eu_recv_tasklet(void *priv);
+void rtl8188e_query_rx_phy_status(struct recv_frame *fr, struct phy_stat *phy);
+void rtl8188e_process_phy_info(struct adapter * padapter, void *prframe);
+void update_recvframe_phyinfo_88e(struct recv_frame *fra, struct phy_stat *phy);
+void update_recvframe_attrib_88e(struct recv_frame *fra, struct recv_stat *stat);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtl8188e_rf.h b/drivers/staging/r8188eu/include/rtl8188e_rf.h
new file mode 100644
index 000000000000..0ebdc369b542
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_rf.h
@@ -0,0 +1,35 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_RF_H__
+#define __RTL8188E_RF_H__
+
+#define		RF6052_MAX_TX_PWR		0x3F
+#define		RF6052_MAX_REG			0x3F
+#define		RF6052_MAX_PATH			2
+
+int	PHY_RF6052_Config8188E(struct adapter *Adapter);
+void rtl8188e_RF_ChangeTxPath(struct adapter *Adapter, u16 DataRate);
+void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
+				     enum ht_channel_width Bandwidth);
+void	rtl8188e_PHY_RF6052SetCckTxPower(struct adapter *Adapter, u8 *level);
+void	rtl8188e_PHY_RF6052SetOFDMTxPower(struct adapter *Adapter, u8 *ofdm,
+					  u8 *pwrbw20, u8 *pwrbw40, u8 channel);
+
+#endif/* __RTL8188E_RF_H__ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
new file mode 100644
index 000000000000..3956f770a951
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -0,0 +1,1438 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *******************************************************************************/
+#ifndef __RTL8188E_SPEC_H__
+#define __RTL8188E_SPEC_H__
+
+#ifndef BIT
+#define BIT(x)		(1 << (x))
+#endif
+
+#define BIT0	0x00000001
+#define BIT1	0x00000002
+#define BIT2	0x00000004
+#define BIT3	0x00000008
+#define BIT4	0x00000010
+#define BIT5	0x00000020
+#define BIT6	0x00000040
+#define BIT7	0x00000080
+#define BIT8	0x00000100
+#define BIT9	0x00000200
+#define BIT10	0x00000400
+#define BIT11	0x00000800
+#define BIT12	0x00001000
+#define BIT13	0x00002000
+#define BIT14	0x00004000
+#define BIT15	0x00008000
+#define BIT16	0x00010000
+#define BIT17	0x00020000
+#define BIT18	0x00040000
+#define BIT19	0x00080000
+#define BIT20	0x00100000
+#define BIT21	0x00200000
+#define BIT22	0x00400000
+#define BIT23	0x00800000
+#define BIT24	0x01000000
+#define BIT25	0x02000000
+#define BIT26	0x04000000
+#define BIT27	0x08000000
+#define BIT28	0x10000000
+#define BIT29	0x20000000
+#define BIT30	0x40000000
+#define BIT31	0x80000000
+
+/*        8192C Regsiter offset definition */
+
+#define		HAL_PS_TIMER_INT_DELAY	50	/*   50 microseconds */
+#define		HAL_92C_NAV_UPPER_UNIT	128	/*  micro-second */
+
+#define MAC_ADDR_LEN			6
+/*  8188E PKT_BUFF_ACCESS_CTRL value */
+#define TXPKT_BUF_SELECT		0x69
+#define RXPKT_BUF_SELECT		0xA5
+#define DISABLE_TRXPKT_BUF_ACCESS	0x0
+
+/* 	0x0000h ~ 0x00FFh	System Configuration */
+#define REG_SYS_ISO_CTRL		0x0000
+#define REG_SYS_FUNC_EN			0x0002
+#define REG_APS_FSMCO			0x0004
+#define REG_SYS_CLKR			0x0008
+#define REG_9346CR			0x000A
+#define REG_EE_VPD			0x000C
+#define REG_AFE_MISC			0x0010
+#define REG_SPS0_CTRL			0x0011
+#define REG_SPS_OCP_CFG			0x0018
+#define REG_RSV_CTRL			0x001C
+#define REG_RF_CTRL			0x001F
+#define REG_LDOA15_CTRL			0x0020
+#define REG_LDOV12D_CTRL		0x0021
+#define REG_LDOHCI12_CTRL		0x0022
+#define REG_LPLDO_CTRL			0x0023
+#define REG_AFE_XTAL_CTRL		0x0024
+#define REG_AFE_PLL_CTRL		0x0028
+#define REG_APE_PLL_CTRL_EXT		0x002c
+#define REG_EFUSE_CTRL			0x0030
+#define REG_EFUSE_TEST			0x0034
+#define REG_GPIO_MUXCFG			0x0040
+#define REG_GPIO_IO_SEL			0x0042
+#define REG_MAC_PINMUX_CFG		0x0043
+#define REG_GPIO_PIN_CTRL		0x0044
+#define REG_GPIO_INTM			0x0048
+#define REG_LEDCFG0			0x004C
+#define REG_LEDCFG1			0x004D
+#define REG_LEDCFG2			0x004E
+#define REG_LEDCFG3			0x004F
+#define REG_FSIMR			0x0050
+#define REG_FSISR			0x0054
+#define REG_HSIMR			0x0058
+#define REG_HSISR			0x005c
+#define REG_GPIO_PIN_CTRL_2		0x0060 /*  RTL8723 WIFI/BT/GPS
+				 * Multi-Function GPIO Pin Control. */
+#define REG_GPIO_IO_SEL_2		0x0062 /*  RTL8723 WIFI/BT/GPS
+				 * Multi-Function GPIO Select. */
+#define REG_BB_PAD_CTRL			0x0064
+#define REG_MULTI_FUNC_CTRL		0x0068 /*  RTL8723 WIFI/BT/GPS
+				 * Multi-Function control source. */
+#define REG_GPIO_OUTPUT			0x006c
+#define REG_AFE_XTAL_CTRL_EXT		0x0078 /* RTL8188E */
+#define REG_XCK_OUT_CTRL		0x007c /* RTL8188E */
+#define REG_MCUFWDL			0x0080
+#define REG_WOL_EVENT			0x0081 /* RTL8188E */
+#define REG_MCUTSTCFG			0x0084
+#define REG_HMEBOX_E0			0x0088
+#define REG_HMEBOX_E1			0x008A
+#define REG_HMEBOX_E2			0x008C
+#define REG_HMEBOX_E3			0x008E
+#define REG_HMEBOX_EXT_0		0x01F0
+#define REG_HMEBOX_EXT_1		0x01F4
+#define REG_HMEBOX_EXT_2		0x01F8
+#define REG_HMEBOX_EXT_3		0x01FC
+#define REG_HIMR_88E			0x00B0
+#define REG_HISR_88E			0x00B4
+#define REG_HIMRE_88E			0x00B8
+#define REG_HISRE_88E			0x00BC
+#define REG_EFUSE_ACCESS		0x00CF	/*  Efuse access protection
+						 * for RTL8723 */
+#define REG_BIST_SCAN			0x00D0
+#define REG_BIST_RPT			0x00D4
+#define REG_BIST_ROM_RPT		0x00D8
+#define REG_USB_SIE_INTF		0x00E0
+#define REG_PCIE_MIO_INTF		0x00E4
+#define REG_PCIE_MIO_INTD		0x00E8
+#define REG_HPON_FSM			0x00EC
+#define REG_SYS_CFG			0x00F0
+#define REG_GPIO_OUTSTS			0x00F4	/*  For RTL8723 only. */
+#define REG_TYPE_ID			0x00FC
+
+#define REG_MAC_PHY_CTRL_NORMAL		0x00f8
+
+/* 	0x0100h ~ 0x01FFh	MACTOP General Configuration */
+#define REG_CR				0x0100
+#define REG_PBP				0x0104
+#define REG_PKT_BUFF_ACCESS_CTRL	0x0106
+#define REG_TRXDMA_CTRL			0x010C
+#define REG_TRXFF_BNDY			0x0114
+#define REG_TRXFF_STATUS		0x0118
+#define REG_RXFF_PTR			0x011C
+/* define REG_HIMR			0x0120 */
+/* define REG_HISR			0x0124 */
+#define REG_HIMRE			0x0128
+#define REG_HISRE			0x012C
+#define REG_CPWM			0x012F
+#define REG_FWIMR			0x0130
+#define REG_FTIMR			0x0138
+#define REG_FWISR			0x0134
+#define REG_PKTBUF_DBG_CTRL		0x0140
+#define REG_PKTBUF_DBG_ADDR		(REG_PKTBUF_DBG_CTRL)
+#define REG_RXPKTBUF_DBG		(REG_PKTBUF_DBG_CTRL+2)
+#define REG_TXPKTBUF_DBG		(REG_PKTBUF_DBG_CTRL+3)
+#define REG_RXPKTBUF_CTRL		(REG_PKTBUF_DBG_CTRL+2)
+#define REG_PKTBUF_DBG_DATA_L		0x0144
+#define REG_PKTBUF_DBG_DATA_H		0x0148
+
+#define REG_TC0_CTRL			0x0150
+#define REG_TC1_CTRL			0x0154
+#define REG_TC2_CTRL			0x0158
+#define REG_TC3_CTRL			0x015C
+#define REG_TC4_CTRL			0x0160
+#define REG_TCUNIT_BASE			0x0164
+#define REG_MBIST_START			0x0174
+#define REG_MBIST_DONE			0x0178
+#define REG_MBIST_FAIL			0x017C
+#define REG_32K_CTRL			0x0194 /* RTL8188E */
+#define REG_C2HEVT_MSG_NORMAL		0x01A0
+#define REG_C2HEVT_CLEAR		0x01AF
+#define REG_MCUTST_1			0x01c0
+#define REG_FMETHR			0x01C8
+#define REG_HMETFR			0x01CC
+#define REG_HMEBOX_0			0x01D0
+#define REG_HMEBOX_1			0x01D4
+#define REG_HMEBOX_2			0x01D8
+#define REG_HMEBOX_3			0x01DC
+
+#define REG_LLT_INIT			0x01E0
+
+/* 	0x0200h ~ 0x027Fh	TXDMA Configuration */
+#define REG_RQPN			0x0200
+#define REG_FIFOPAGE			0x0204
+#define REG_TDECTRL			0x0208
+#define REG_TXDMA_OFFSET_CHK		0x020C
+#define REG_TXDMA_STATUS		0x0210
+#define REG_RQPN_NPQ			0x0214
+
+/* 	0x0280h ~ 0x02FFh	RXDMA Configuration */
+#define		REG_RXDMA_AGG_PG_TH	0x0280
+#define	REG_RXPKT_NUM			0x0284
+#define		REG_RXDMA_STATUS	0x0288
+
+/* 	0x0300h ~ 0x03FFh	PCIe */
+#define	REG_PCIE_CTRL_REG		0x0300
+#define	REG_INT_MIG			0x0304	/*  Interrupt Migration */
+#define	REG_BCNQ_DESA			0x0308	/*  TX Beacon Descr Address */
+#define	REG_HQ_DESA			0x0310	/*  TX High Queue Descr Addr */
+#define	REG_MGQ_DESA			0x0318	/*  TX Manage Queue Descr Addr*/
+#define	REG_VOQ_DESA			0x0320	/*  TX VO Queue Descr Addr */
+#define	REG_VIQ_DESA			0x0328	/*  TX VI Queue Descr Addr */
+#define	REG_BEQ_DESA			0x0330	/*  TX BE Queue Descr Addr */
+#define	REG_BKQ_DESA			0x0338	/*  TX BK Queue Descr Addr */
+#define	REG_RX_DESA			0x0340	/*  RX Queue Descr Addr */
+#define	REG_MDIO			0x0354	/*  MDIO for Access PCIE PHY */
+#define	REG_DBG_SEL			0x0360	/*  Debug Selection Register */
+#define	REG_PCIE_HRPWM			0x0361	/* PCIe RPWM */
+#define	REG_PCIE_HCPWM			0x0363	/* PCIe CPWM */
+#define	REG_WATCH_DOG			0x0368
+
+/*  RTL8723 series ------------------------------ */
+#define	REG_PCIE_HISR			0x03A0
+
+/*  spec version 11 */
+/* 	0x0400h ~ 0x047Fh	Protocol Configuration */
+#define REG_VOQ_INFORMATION		0x0400
+#define REG_VIQ_INFORMATION		0x0404
+#define REG_BEQ_INFORMATION		0x0408
+#define REG_BKQ_INFORMATION		0x040C
+#define REG_MGQ_INFORMATION		0x0410
+#define REG_HGQ_INFORMATION		0x0414
+#define REG_BCNQ_INFORMATION		0x0418
+#define REG_TXPKT_EMPTY			0x041A
+
+#define REG_CPU_MGQ_INFORMATION		0x041C
+#define REG_FWHW_TXQ_CTRL		0x0420
+#define REG_HWSEQ_CTRL			0x0423
+#define REG_TXPKTBUF_BCNQ_BDNY		0x0424
+#define REG_TXPKTBUF_MGQ_BDNY		0x0425
+#define REG_LIFETIME_EN			0x0426
+#define REG_MULTI_BCNQ_OFFSET		0x0427
+#define REG_SPEC_SIFS			0x0428
+#define REG_RL				0x042A
+#define REG_DARFRC			0x0430
+#define REG_RARFRC			0x0438
+#define REG_RRSR			0x0440
+#define REG_ARFR0			0x0444
+#define REG_ARFR1			0x0448
+#define REG_ARFR2			0x044C
+#define REG_ARFR3			0x0450
+#define REG_AGGLEN_LMT			0x0458
+#define REG_AMPDU_MIN_SPACE		0x045C
+#define REG_TXPKTBUF_WMAC_LBK_BF_HD	0x045D
+#define REG_FAST_EDCA_CTRL		0x0460
+#define REG_RD_RESP_PKT_TH		0x0463
+#define REG_INIRTS_RATE_SEL		0x0480
+/* define REG_INIDATA_RATE_SEL		0x0484 */
+#define REG_POWER_STATUS		0x04A4
+#define REG_POWER_STAGE1		0x04B4
+#define REG_POWER_STAGE2		0x04B8
+#define REG_PKT_VO_VI_LIFE_TIME		0x04C0
+#define REG_PKT_BE_BK_LIFE_TIME		0x04C2
+#define REG_STBC_SETTING		0x04C4
+#define REG_PROT_MODE_CTRL		0x04C8
+#define REG_MAX_AGGR_NUM		0x04CA
+#define REG_RTS_MAX_AGGR_NUM		0x04CB
+#define REG_BAR_MODE_CTRL		0x04CC
+#define REG_RA_TRY_RATE_AGG_LMT		0x04CF
+#define REG_EARLY_MODE_CONTROL		0x4D0
+#define REG_NQOS_SEQ			0x04DC
+#define REG_QOS_SEQ			0x04DE
+#define REG_NEED_CPU_HANDLE		0x04E0
+#define REG_PKT_LOSE_RPT		0x04E1
+#define REG_PTCL_ERR_STATUS		0x04E2
+#define REG_TX_RPT_CTRL			0x04EC
+#define REG_TX_RPT_TIME			0x04F0	/*  2 byte */
+#define REG_DUMMY			0x04FC
+
+/* 	0x0500h ~ 0x05FFh	EDCA Configuration */
+#define REG_EDCA_VO_PARAM		0x0500
+#define REG_EDCA_VI_PARAM		0x0504
+#define REG_EDCA_BE_PARAM		0x0508
+#define REG_EDCA_BK_PARAM		0x050C
+#define REG_BCNTCFG			0x0510
+#define REG_PIFS			0x0512
+#define REG_RDG_PIFS			0x0513
+#define REG_SIFS_CTX			0x0514
+#define REG_SIFS_TRX			0x0516
+#define REG_TSFTR_SYN_OFFSET		0x0518
+#define REG_AGGR_BREAK_TIME		0x051A
+#define REG_SLOT			0x051B
+#define REG_TX_PTCL_CTRL		0x0520
+#define REG_TXPAUSE			0x0522
+#define REG_DIS_TXREQ_CLR		0x0523
+#define REG_RD_CTRL			0x0524
+/*  Format for offset 540h-542h: */
+/* 	[3:0]:   TBTT prohibit setup in unit of 32us. The time for HW getting
+ *		 beacon content before TBTT. */
+/* 	[7:4]:   Reserved. */
+/* 	[19:8]:  TBTT prohibit hold in unit of 32us. The time for HW holding
+ *		 to send the beacon packet. */
+/* 	[23:20]: Reserved */
+/*  Description: */
+/* 	              | */
+/*      |<--Setup--|--Hold------------>| */
+/* 	--------------|---------------------- */
+/*                 | */
+/*                TBTT */
+/*  Note: We cannot update beacon content to HW or send any AC packets during
+ *	  the time between Setup and Hold. */
+#define REG_TBTT_PROHIBIT		0x0540
+#define REG_RD_NAV_NXT			0x0544
+#define REG_NAV_PROT_LEN		0x0546
+#define REG_BCN_CTRL			0x0550
+#define REG_BCN_CTRL_1			0x0551
+#define REG_MBID_NUM			0x0552
+#define REG_DUAL_TSF_RST		0x0553
+#define REG_BCN_INTERVAL		0x0554
+#define REG_DRVERLYINT			0x0558
+#define REG_BCNDMATIM			0x0559
+#define REG_ATIMWND			0x055A
+#define REG_BCN_MAX_ERR			0x055D
+#define REG_RXTSF_OFFSET_CCK		0x055E
+#define REG_RXTSF_OFFSET_OFDM		0x055F
+#define REG_TSFTR			0x0560
+#define REG_TSFTR1			0x0568
+#define REG_ATIMWND_1			0x0570
+#define REG_PSTIMER			0x0580
+#define REG_TIMER0			0x0584
+#define REG_TIMER1			0x0588
+#define REG_ACMHWCTRL			0x05C0
+
+/* define REG_FW_TSF_SYNC_CNT		0x04A0 */
+#define REG_FW_RESET_TSF_CNT_1		0x05FC
+#define REG_FW_RESET_TSF_CNT_0		0x05FD
+#define REG_FW_BCN_DIS_CNT		0x05FE
+
+/* 	0x0600h ~ 0x07FFh	WMAC Configuration */
+#define REG_APSD_CTRL			0x0600
+#define REG_BWOPMODE			0x0603
+#define REG_TCR				0x0604
+#define REG_RCR				0x0608
+#define REG_RX_PKT_LIMIT		0x060C
+#define REG_RX_DLK_TIME			0x060D
+#define REG_RX_DRVINFO_SZ		0x060F
+
+#define REG_MACID			0x0610
+#define REG_BSSID			0x0618
+#define REG_MAR				0x0620
+#define REG_MBIDCAMCFG			0x0628
+
+#define REG_USTIME_EDCA			0x0638
+#define REG_MAC_SPEC_SIFS		0x063A
+
+/*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */
+/*  [15:8]SIFS_R2T_OFDM, [7:0]SIFS_R2T_CCK */
+#define REG_R2T_SIFS			0x063C
+/*  [15:8]SIFS_T2T_OFDM, [7:0]SIFS_T2T_CCK */
+#define REG_T2T_SIFS			0x063E
+#define REG_ACKTO			0x0640
+#define REG_CTS2TO			0x0641
+#define REG_EIFS			0x0642
+
+/* RXERR_RPT */
+#define RXERR_TYPE_OFDM_PPDU		0
+#define RXERR_TYPE_OFDM_false_ALARM	1
+#define RXERR_TYPE_OFDM_MPDU_OK		2
+#define RXERR_TYPE_OFDM_MPDU_FAIL	3
+#define RXERR_TYPE_CCK_PPDU		4
+#define RXERR_TYPE_CCK_false_ALARM	5
+#define RXERR_TYPE_CCK_MPDU_OK		6
+#define RXERR_TYPE_CCK_MPDU_FAIL	7
+#define RXERR_TYPE_HT_PPDU		8
+#define RXERR_TYPE_HT_false_ALARM	9
+#define RXERR_TYPE_HT_MPDU_TOTAL	10
+#define RXERR_TYPE_HT_MPDU_OK		11
+#define RXERR_TYPE_HT_MPDU_FAIL		12
+#define RXERR_TYPE_RX_FULL_DROP		15
+
+#define RXERR_COUNTER_MASK		0xFFFFF
+#define RXERR_RPT_RST			BIT(27)
+#define _RXERR_RPT_SEL(type)		((type) << 28)
+
+/*  Note: */
+/* 	The NAV upper value is very important to WiFi 11n 5.2.3 NAV test.
+ *	The default value is always too small, but the WiFi TestPlan test
+ *	by 25,000 microseconds of NAV through sending CTS in the air.
+ *	We must update this value greater than 25,000 microseconds to pass
+ *	the item. The offset of NAV_UPPER in 8192C Spec is incorrect, and
+ *	the offset should be 0x0652. */
+#define REG_NAV_UPPER			0x0652	/*  unit of 128 */
+
+/* WMA, BA, CCX */
+/* define REG_NAV_CTRL			0x0650 */
+#define REG_BACAMCMD			0x0654
+#define REG_BACAMCONTENT		0x0658
+#define REG_LBDLY			0x0660
+#define REG_FWDLY			0x0661
+#define REG_RXERR_RPT			0x0664
+#define REG_WMAC_TRXPTCL_CTL		0x0668
+
+/*  Security */
+#define REG_CAMCMD			0x0670
+#define REG_CAMWRITE			0x0674
+#define REG_CAMREAD			0x0678
+#define REG_CAMDBG			0x067C
+#define REG_SECCFG			0x0680
+
+/*  Power */
+#define REG_WOW_CTRL			0x0690
+#define REG_PS_RX_INFO			0x0692
+#define REG_UAPSD_TID			0x0693
+#define REG_WKFMCAM_CMD			0x0698
+#define REG_WKFMCAM_NUM_88E		0x698
+#define REG_RXFLTMAP0			0x06A0
+#define REG_RXFLTMAP1			0x06A2
+#define REG_RXFLTMAP2			0x06A4
+#define REG_BCN_PSR_RPT			0x06A8
+#define REG_BT_COEX_TABLE		0x06C0
+
+/*  Hardware Port 2 */
+#define REG_MACID1			0x0700
+#define REG_BSSID1			0x0708
+
+/* 	0xFE00h ~ 0xFE55h	USB Configuration */
+#define REG_USB_INFO			0xFE17
+#define REG_USB_SPECIAL_OPTION		0xFE55
+#define REG_USB_DMA_AGG_TO		0xFE5B
+#define REG_USB_AGG_TO			0xFE5C
+#define REG_USB_AGG_TH			0xFE5D
+
+/*  For normal chip */
+#define REG_NORMAL_SIE_VID		0xFE60		/*  0xFE60~0xFE61 */
+#define REG_NORMAL_SIE_PID		0xFE62		/*  0xFE62~0xFE63 */
+#define REG_NORMAL_SIE_OPTIONAL		0xFE64
+#define REG_NORMAL_SIE_EP		0xFE65		/*  0xFE65~0xFE67 */
+#define REG_NORMAL_SIE_PHY		0xFE68		/*  0xFE68~0xFE6B */
+#define REG_NORMAL_SIE_OPTIONAL2	0xFE6C
+#define REG_NORMAL_SIE_GPS_EP		0xFE6D	/*  0xFE6D, for RTL8723 only. */
+#define REG_NORMAL_SIE_MAC_ADDR		0xFE70		/*  0xFE70~0xFE75 */
+#define REG_NORMAL_SIE_STRING		0xFE80		/*  0xFE80~0xFEDF */
+
+/*  TODO: use these definition when using REG_xxx naming rule. */
+/*  NOTE: DO NOT Remove these definition. Use later. */
+
+#define	EFUSE_CTRL			REG_EFUSE_CTRL	/*  E-Fuse Control. */
+#define	EFUSE_TEST			REG_EFUSE_TEST	/*  E-Fuse Test. */
+#define	MSR				(REG_CR + 2)	/*  Media Status reg */
+#define	ISR				REG_HISR_88E
+/*  Timing Sync Function Timer Register. */
+#define	TSFR				REG_TSFTR
+
+#define		PBP			REG_PBP
+
+/*  Redifine MACID register, to compatible prior ICs. */
+/*  MAC ID Register, Offset 0x0050-0x0053 */
+#define	IDR0				REG_MACID
+/*  MAC ID Register, Offset 0x0054-0x0055 */
+#define	IDR4				(REG_MACID + 4)
+
+/*  9. Security Control Registers	(Offset: ) */
+/* IN 8190 Data Sheet is called CAMcmd */
+#define	RWCAM				REG_CAMCMD
+/*  Software write CAM input content */
+#define	WCAMI				REG_CAMWRITE
+/*  Software read/write CAM config */
+#define	RCAMO				REG_CAMREAD
+#define	CAMDBG				REG_CAMDBG
+/* Security Configuration Register */
+#define	SECR				REG_SECCFG
+
+/*  Unused register */
+#define	UnusedRegister			0x1BF
+#define	DCAM				UnusedRegister
+#define	PSR				UnusedRegister
+#define	BBAddr				UnusedRegister
+#define	PhyDataR			UnusedRegister
+
+/*  Min Spacing related settings. */
+#define	MAX_MSS_DENSITY_2T		0x13
+#define	MAX_MSS_DENSITY_1T		0x0A
+
+/*  EEPROM enable when set 1 */
+#define	CmdEEPROM_En			BIT5
+/*  System EEPROM select, 0: boot from E-FUSE, 1: The EEPROM used is 9346 */
+#define	CmdEERPOMSEL			BIT4
+#define	Cmd9346CR_9356SEL		BIT4
+
+/*        8192C GPIO MUX Configuration Register (offset 0x40, 4 byte) */
+#define	GPIOSEL_GPIO			0
+#define	GPIOSEL_ENBT			BIT5
+
+/*        8192C GPIO PIN Control Register (offset 0x44, 4 byte) */
+/*  GPIO pins input value */
+#define	GPIO_IN				REG_GPIO_PIN_CTRL
+/*  GPIO pins output value */
+#define	GPIO_OUT			(REG_GPIO_PIN_CTRL+1)
+/*  GPIO pins output enable when a bit is set to "1"; otherwise,
+ *  input is configured. */
+#define	GPIO_IO_SEL			(REG_GPIO_PIN_CTRL+2)
+#define	GPIO_MOD			(REG_GPIO_PIN_CTRL+3)
+
+/* 8723/8188E Host System Interrupt Mask Register (offset 0x58, 32 byte) */
+#define	HSIMR_GPIO12_0_INT_EN		BIT0
+#define	HSIMR_SPS_OCP_INT_EN		BIT5
+#define	HSIMR_RON_INT_EN		BIT6
+#define	HSIMR_PDN_INT_EN		BIT7
+#define	HSIMR_GPIO9_INT_EN		BIT25
+
+/* 8723/8188E Host System Interrupt Status Register (offset 0x5C, 32 byte) */
+#define	HSISR_GPIO12_0_INT		BIT0
+#define	HSISR_SPS_OCP_INT		BIT5
+#define	HSISR_RON_INT_EN		BIT6
+#define	HSISR_PDNINT			BIT7
+#define	HSISR_GPIO9_INT			BIT25
+
+/*   8192C (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
+/*
+Network Type
+00: No link
+01: Link in ad hoc network
+10: Link in infrastructure network
+11: AP mode
+Default: 00b.
+*/
+#define	MSR_NOLINK			0x00
+#define	MSR_ADHOC			0x01
+#define	MSR_INFRA			0x02
+#define	MSR_AP				0x03
+
+/*   88EU (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
+#define	USB_INTR_CONTENT_C2H_OFFSET	0
+#define	USB_INTR_CONTENT_CPWM1_OFFSET	16
+#define	USB_INTR_CONTENT_CPWM2_OFFSET	20
+#define	USB_INTR_CONTENT_HISR_OFFSET	48
+#define	USB_INTR_CONTENT_HISRE_OFFSET	52
+
+/*  88E Driver Initialization Offload REG_FDHM0(Offset 0x88, 8 bits) */
+/* IOL config for REG_FDHM0(Reg0x88) */
+#define CMD_INIT_LLT			BIT0
+#define CMD_READ_EFUSE_MAP		BIT1
+#define CMD_EFUSE_PATCH			BIT2
+#define CMD_IOCONFIG			BIT3
+#define CMD_INIT_LLT_ERR		BIT4
+#define CMD_READ_EFUSE_MAP_ERR		BIT5
+#define CMD_EFUSE_PATCH_ERR		BIT6
+#define CMD_IOCONFIG_ERR		BIT7
+
+/*  6. Adaptive Control Registers  (Offset: 0x0160 - 0x01CF) */
+/*  8192C Response Rate Set Register	(offset 0x181, 24bits) */
+#define	RRSR_1M				BIT0
+#define	RRSR_2M				BIT1
+#define	RRSR_5_5M			BIT2
+#define	RRSR_11M			BIT3
+#define	RRSR_6M				BIT4
+#define	RRSR_9M				BIT5
+#define	RRSR_12M			BIT6
+#define	RRSR_18M			BIT7
+#define	RRSR_24M			BIT8
+#define	RRSR_36M			BIT9
+#define	RRSR_48M			BIT10
+#define	RRSR_54M			BIT11
+#define	RRSR_MCS0			BIT12
+#define	RRSR_MCS1			BIT13
+#define	RRSR_MCS2			BIT14
+#define	RRSR_MCS3			BIT15
+#define	RRSR_MCS4			BIT16
+#define	RRSR_MCS5			BIT17
+#define	RRSR_MCS6			BIT18
+#define	RRSR_MCS7			BIT19
+
+/*  8192C Response Rate Set Register	(offset 0x1BF, 8bits) */
+/*  WOL bit information */
+#define	HAL92C_WOL_PTK_UPDATE_EVENT	BIT0
+#define	HAL92C_WOL_GTK_UPDATE_EVENT	BIT1
+
+/*        8192C BW_OPMODE bits		(Offset 0x203, 8bit) */
+#define	BW_OPMODE_20MHZ			BIT2
+#define	BW_OPMODE_5G			BIT1
+
+/*        8192C CAM Config Setting (offset 0x250, 1 byte) */
+#define	CAM_VALID			BIT15
+#define	CAM_NOTVALID			0x0000
+#define	CAM_USEDK			BIT5
+
+#define	CAM_CONTENT_COUNT		8
+
+#define	CAM_NONE			0x0
+#define	CAM_WEP40			0x01
+#define	CAM_TKIP			0x02
+#define	CAM_AES				0x04
+#define	CAM_WEP104			0x05
+#define	CAM_SMS4			0x6
+
+#define	TOTAL_CAM_ENTRY			32
+#define	HALF_CAM_ENTRY			16
+
+#define	CAM_CONFIG_USEDK		true
+#define	CAM_CONFIG_NO_USEDK		false
+
+#define	CAM_WRITE			BIT16
+#define	CAM_READ			0x00000000
+#define	CAM_POLLINIG			BIT31
+
+#define	SCR_UseDK			0x01
+#define	SCR_TxSecEnable			0x02
+#define	SCR_RxSecEnable			0x04
+
+/*  10. Power Save Control Registers	 (Offset: 0x0260 - 0x02DF) */
+#define	WOW_PMEN			BIT0 /*  Power management Enable. */
+#define	WOW_WOMEN			BIT1 /*  WoW function on or off. */
+#define	WOW_MAGIC			BIT2 /*  Magic packet */
+#define	WOW_UWF				BIT3 /*  Unicast Wakeup frame. */
+
+/*  12. Host Interrupt Status Registers	 (Offset: 0x0300 - 0x030F) */
+/*        8188 IMR/ISR bits */
+#define	IMR_DISABLED_88E		0x0
+/*  IMR DW0(0x0060-0063) Bit 0-31 */
+#define	IMR_TXCCK_88E			BIT30	/*  TXRPT interrupt when CCX bit of the packet is set */
+#define	IMR_PSTIMEOUT_88E		BIT29	/*  Power Save Time Out Interrupt */
+#define	IMR_GTINT4_88E			BIT28	/*  When GTIMER4 expires, this bit is set to 1 */
+#define	IMR_GTINT3_88E			BIT27	/*  When GTIMER3 expires, this bit is set to 1 */
+#define	IMR_TBDER_88E			BIT26	/*  Transmit Beacon0 Error */
+#define	IMR_TBDOK_88E			BIT25	/*  Transmit Beacon0 OK */
+#define	IMR_TSF_BIT32_TOGGLE_88E	BIT24	/*  TSF Timer BIT32 toggle indication interrupt */
+#define	IMR_BCNDMAINT0_88E		BIT20	/*  Beacon DMA Interrupt 0 */
+#define	IMR_BCNDERR0_88E		BIT16	/*  Beacon Queue DMA Error 0 */
+#define	IMR_HSISR_IND_ON_INT_88E	BIT15	/*  HSISR Indicator (HSIMR & HSISR is true, this bit is set to 1) */
+#define	IMR_BCNDMAINT_E_88E		BIT14	/*  Beacon DMA Interrupt Extension for Win7 */
+#define	IMR_ATIMEND_88E			BIT12	/*  CTWidnow End or ATIM Window End */
+#define	IMR_HISR1_IND_INT_88E		BIT11	/*  HISR1 Indicator (HISR1 & HIMR1 is true, this bit is set to 1) */
+#define	IMR_C2HCMD_88E			BIT10	/*  CPU to Host Command INT Status, Write 1 clear */
+#define	IMR_CPWM2_88E			BIT9	/*  CPU power Mode exchange INT Status, Write 1 clear */
+#define	IMR_CPWM_88E			BIT8	/*  CPU power Mode exchange INT Status, Write 1 clear */
+#define	IMR_HIGHDOK_88E			BIT7	/*  High Queue DMA OK */
+#define	IMR_MGNTDOK_88E			BIT6	/*  Management Queue DMA OK */
+#define	IMR_BKDOK_88E			BIT5	/*  AC_BK DMA OK */
+#define	IMR_BEDOK_88E			BIT4	/*  AC_BE DMA OK */
+#define	IMR_VIDOK_88E			BIT3	/*  AC_VI DMA OK */
+#define	IMR_VODOK_88E			BIT2	/*  AC_VO DMA OK */
+#define	IMR_RDU_88E			BIT1	/*  Rx Descriptor Unavailable */
+#define	IMR_ROK_88E			BIT0	/*  Receive DMA OK */
+
+/*  IMR DW1(0x00B4-00B7) Bit 0-31 */
+#define	IMR_BCNDMAINT7_88E		BIT27	/*  Beacon DMA Interrupt 7 */
+#define	IMR_BCNDMAINT6_88E		BIT26	/*  Beacon DMA Interrupt 6 */
+#define	IMR_BCNDMAINT5_88E		BIT25	/*  Beacon DMA Interrupt 5 */
+#define	IMR_BCNDMAINT4_88E		BIT24	/*  Beacon DMA Interrupt 4 */
+#define	IMR_BCNDMAINT3_88E		BIT23	/*  Beacon DMA Interrupt 3 */
+#define	IMR_BCNDMAINT2_88E		BIT22	/*  Beacon DMA Interrupt 2 */
+#define	IMR_BCNDMAINT1_88E		BIT21	/*  Beacon DMA Interrupt 1 */
+#define	IMR_BCNDERR7_88E		BIT20	/*  Beacon DMA Error Int 7 */
+#define	IMR_BCNDERR6_88E		BIT19	/*  Beacon DMA Error Int 6 */
+#define	IMR_BCNDERR5_88E		BIT18	/*  Beacon DMA Error Int 5 */
+#define	IMR_BCNDERR4_88E		BIT17	/*  Beacon DMA Error Int 4 */
+#define	IMR_BCNDERR3_88E		BIT16	/*  Beacon DMA Error Int 3 */
+#define	IMR_BCNDERR2_88E		BIT15	/*  Beacon DMA Error Int 2 */
+#define	IMR_BCNDERR1_88E		BIT14	/*  Beacon DMA Error Int 1 */
+#define	IMR_ATIMEND_E_88E		BIT13	/*  ATIM Window End Ext for Win7 */
+#define	IMR_TXERR_88E			BIT11	/*  Tx Err Flag Int Status, write 1 clear. */
+#define	IMR_RXERR_88E			BIT10	/*  Rx Err Flag INT Status, Write 1 clear */
+#define	IMR_TXFOVW_88E			BIT9	/*  Transmit FIFO Overflow */
+#define	IMR_RXFOVW_88E			BIT8	/*  Receive FIFO Overflow */
+
+#define	HAL_NIC_UNPLUG_ISR		0xFFFFFFFF	/*  The value when the NIC is unplugged for PCI. */
+
+/*  8192C EFUSE */
+#define		HWSET_MAX_SIZE			256
+#define		HWSET_MAX_SIZE_88E		512
+
+/*===================================================================
+=====================================================================
+Here the register defines are for 92C. When the define is as same with 92C,
+we will use the 92C's define for the consistency
+So the following defines for 92C is not entire!!!!!!
+=====================================================================
+=====================================================================*/
+/*
+Based on Datasheet V33---090401
+Register Summary
+Current IOREG MAP
+0x0000h ~ 0x00FFh   System Configuration (256 Bytes)
+0x0100h ~ 0x01FFh   MACTOP General Configuration (256 Bytes)
+0x0200h ~ 0x027Fh   TXDMA Configuration (128 Bytes)
+0x0280h ~ 0x02FFh   RXDMA Configuration (128 Bytes)
+0x0300h ~ 0x03FFh   PCIE EMAC Reserved Region (256 Bytes)
+0x0400h ~ 0x04FFh   Protocol Configuration (256 Bytes)
+0x0500h ~ 0x05FFh   EDCA Configuration (256 Bytes)
+0x0600h ~ 0x07FFh   WMAC Configuration (512 Bytes)
+0x2000h ~ 0x3FFFh   8051 FW Download Region (8196 Bytes)
+*/
+/* 		 8192C (TXPAUSE) transmission pause (Offset 0x522, 8 bits) */
+/*  Note: */
+/* 	The bits of stopping AC(VO/VI/BE/BK) queue in datasheet
+ *	RTL8192S/RTL8192C are wrong, */
+/* 	the correct arragement is VO - Bit0, VI - Bit1, BE - Bit2,
+ *	and BK - Bit3. */
+/* 	8723 and 88E may be not correct either in the earlier version. */
+#define		StopBecon			BIT6
+#define		StopHigh			BIT5
+#define		StopMgt				BIT4
+#define		StopBK				BIT3
+#define		StopBE				BIT2
+#define		StopVI				BIT1
+#define		StopVO				BIT0
+
+/*        8192C (RCR) Receive Configuration Register(Offset 0x608, 32 bits) */
+#define	RCR_APPFCS		BIT31	/* WMAC append FCS after payload */
+#define	RCR_APP_MIC		BIT30
+#define	RCR_APP_PHYSTS		BIT28
+#define	RCR_APP_ICV		BIT29
+#define	RCR_APP_PHYST_RXFF	BIT28
+#define	RCR_APP_BA_SSN		BIT27	/* Accept BA SSN */
+#define	RCR_ENMBID		BIT24	/* Enable Multiple BssId. */
+#define	RCR_LSIGEN		BIT23
+#define	RCR_MFBEN		BIT22
+#define	RCR_HTC_LOC_CTRL	BIT14   /* MFC<--HTC=1 MFC-->HTC=0 */
+#define	RCR_AMF			BIT13	/* Accept management type frame */
+#define	RCR_ACF			BIT12	/* Accept control type frame */
+#define	RCR_ADF			BIT11	/* Accept data type frame */
+#define	RCR_AICV		BIT9	/* Accept ICV error packet */
+#define	RCR_ACRC32		BIT8	/* Accept CRC32 error packet */
+#define	RCR_CBSSID_BCN		BIT7	/* Accept BSSID match packet
+					 * (Rx beacon, probe rsp) */
+#define	RCR_CBSSID_DATA		BIT6	/* Accept BSSID match (Data)*/
+#define	RCR_CBSSID		RCR_CBSSID_DATA	/* Accept BSSID match */
+#define	RCR_APWRMGT		BIT5	/* Accept power management pkt*/
+#define	RCR_ADD3		BIT4	/* Accept address 3 match pkt */
+#define	RCR_AB			BIT3	/* Accept broadcast packet */
+#define	RCR_AM			BIT2	/* Accept multicast packet */
+#define	RCR_APM			BIT1	/* Accept physical match pkt */
+#define	RCR_AAP			BIT0	/* Accept all unicast packet */
+#define	RCR_MXDMA_OFFSET	8
+#define	RCR_FIFO_OFFSET		13
+
+/* 	0xFE00h ~ 0xFE55h	USB Configuration */
+#define REG_USB_INFO			0xFE17
+#define REG_USB_SPECIAL_OPTION		0xFE55
+#define REG_USB_DMA_AGG_TO		0xFE5B
+#define REG_USB_AGG_TO			0xFE5C
+#define REG_USB_AGG_TH			0xFE5D
+
+#define REG_USB_HRPWM			0xFE58
+#define REG_USB_HCPWM			0xFE57
+/*        8192C Regsiter Bit and Content definition */
+/* 	0x0000h ~ 0x00FFh	System Configuration */
+
+/* 2 SYS_ISO_CTRL */
+#define ISO_MD2PP			BIT(0)
+#define ISO_UA2USB			BIT(1)
+#define ISO_UD2CORE			BIT(2)
+#define ISO_PA2PCIE			BIT(3)
+#define ISO_PD2CORE			BIT(4)
+#define ISO_IP2MAC			BIT(5)
+#define ISO_DIOP			BIT(6)
+#define ISO_DIOE			BIT(7)
+#define ISO_EB2CORE			BIT(8)
+#define ISO_DIOR			BIT(9)
+#define PWC_EV12V			BIT(15)
+
+/* 2 SYS_FUNC_EN */
+#define FEN_BBRSTB			BIT(0)
+#define FEN_BB_GLB_RSTn			BIT(1)
+#define FEN_USBA			BIT(2)
+#define FEN_UPLL			BIT(3)
+#define FEN_USBD			BIT(4)
+#define FEN_DIO_PCIE			BIT(5)
+#define FEN_PCIEA			BIT(6)
+#define FEN_PPLL			BIT(7)
+#define FEN_PCIED			BIT(8)
+#define FEN_DIOE			BIT(9)
+#define FEN_CPUEN			BIT(10)
+#define FEN_DCORE			BIT(11)
+#define FEN_ELDR			BIT(12)
+#define FEN_DIO_RF			BIT(13)
+#define FEN_HWPDN			BIT(14)
+#define FEN_MREGEN			BIT(15)
+
+/* 2 APS_FSMCO */
+#define PFM_LDALL			BIT(0)
+#define PFM_ALDN			BIT(1)
+#define PFM_LDKP			BIT(2)
+#define PFM_WOWL			BIT(3)
+#define EnPDN				BIT(4)
+#define PDN_PL				BIT(5)
+#define APFM_ONMAC			BIT(8)
+#define APFM_OFF			BIT(9)
+#define APFM_RSM			BIT(10)
+#define AFSM_HSUS			BIT(11)
+#define AFSM_PCIE			BIT(12)
+#define APDM_MAC			BIT(13)
+#define APDM_HOST			BIT(14)
+#define APDM_HPDN			BIT(15)
+#define RDY_MACON			BIT(16)
+#define SUS_HOST			BIT(17)
+#define ROP_ALD				BIT(20)
+#define ROP_PWR				BIT(21)
+#define ROP_SPS				BIT(22)
+#define SOP_MRST			BIT(25)
+#define SOP_FUSE			BIT(26)
+#define SOP_ABG				BIT(27)
+#define SOP_AMB				BIT(28)
+#define SOP_RCK				BIT(29)
+#define SOP_A8M				BIT(30)
+#define XOP_BTCK			BIT(31)
+
+/* 2 SYS_CLKR */
+#define ANAD16V_EN			BIT(0)
+#define ANA8M				BIT(1)
+#define MACSLP				BIT(4)
+#define LOADER_CLK_EN			BIT(5)
+
+/* 2 9346CR */
+
+#define		BOOT_FROM_EEPROM	BIT(4)
+#define		EEPROM_EN		BIT(5)
+
+/* 2 SPS0_CTRL */
+
+/* 2 SPS_OCP_CFG */
+
+/* 2 RF_CTRL */
+#define RF_EN				BIT(0)
+#define RF_RSTB				BIT(1)
+#define RF_SDMRSTB			BIT(2)
+
+/* 2 LDOV12D_CTRL */
+#define LDV12_EN			BIT(0)
+#define LDV12_SDBY			BIT(1)
+#define LPLDO_HSM			BIT(2)
+#define LPLDO_LSM_DIS			BIT(3)
+#define _LDV12_VADJ(x)			(((x) & 0xF) << 4)
+
+/* 2EFUSE_CTRL */
+#define ALD_EN				BIT(18)
+#define EF_PD				BIT(19)
+#define EF_FLAG				BIT(31)
+
+/* 2 EFUSE_TEST (For RTL8723 partially) */
+#define EF_TRPT				BIT(7)
+/*  00: Wifi Efuse, 01: BT Efuse0, 10: BT Efuse1, 11: BT Efuse2 */
+#define EF_CELL_SEL			(BIT(8)|BIT(9))
+#define LDOE25_EN			BIT(31)
+#define EFUSE_SEL(x)			(((x) & 0x3) << 8)
+#define EFUSE_SEL_MASK			0x300
+#define EFUSE_WIFI_SEL_0		0x0
+#define EFUSE_BT_SEL_0			0x1
+#define EFUSE_BT_SEL_1			0x2
+#define EFUSE_BT_SEL_2			0x3
+
+#define EFUSE_ACCESS_ON			0x69	/*  For RTL8723 only. */
+#define EFUSE_ACCESS_OFF		0x00	/*  For RTL8723 only. */
+
+/* 2 8051FWDL */
+/* 2 MCUFWDL */
+#define MCUFWDL_EN			BIT(0)
+#define MCUFWDL_RDY			BIT(1)
+#define FWDL_ChkSum_rpt			BIT(2)
+#define MACINI_RDY			BIT(3)
+#define BBINI_RDY			BIT(4)
+#define RFINI_RDY			BIT(5)
+#define WINTINI_RDY			BIT(6)
+#define RAM_DL_SEL			BIT(7) /*  1:RAM, 0:ROM */
+#define ROM_DLEN			BIT(19)
+#define CPRST				BIT(23)
+
+/* 2 REG_SYS_CFG */
+#define XCLK_VLD			BIT(0)
+#define ACLK_VLD			BIT(1)
+#define UCLK_VLD			BIT(2)
+#define PCLK_VLD			BIT(3)
+#define PCIRSTB				BIT(4)
+#define V15_VLD				BIT(5)
+#define SW_OFFLOAD_EN			BIT(7)
+#define SIC_IDLE			BIT(8)
+#define BD_MAC2				BIT(9)
+#define BD_MAC1				BIT(10)
+#define IC_MACPHY_MODE			BIT(11)
+#define CHIP_VER			(BIT(12)|BIT(13)|BIT(14)|BIT(15))
+#define BT_FUNC				BIT(16)
+#define VENDOR_ID			BIT(19)
+#define PAD_HWPD_IDN			BIT(22)
+#define TRP_VAUX_EN			BIT(23)	/*  RTL ID */
+#define TRP_BT_EN			BIT(24)
+#define BD_PKG_SEL			BIT(25)
+#define BD_HCI_SEL			BIT(26)
+#define TYPE_ID				BIT(27)
+
+#define CHIP_VER_RTL_MASK		0xF000	/* Bit 12 ~ 15 */
+#define CHIP_VER_RTL_SHIFT		12
+
+/* 2REG_GPIO_OUTSTS (For RTL8723 only) */
+#define	EFS_HCI_SEL			(BIT(0)|BIT(1))
+#define	PAD_HCI_SEL			(BIT(2)|BIT(3))
+#define	HCI_SEL				(BIT(4)|BIT(5))
+#define	PKG_SEL_HCI			BIT(6)
+#define	FEN_GPS				BIT(7)
+#define	FEN_BT				BIT(8)
+#define	FEN_WL				BIT(9)
+#define	FEN_PCI				BIT(10)
+#define	FEN_USB				BIT(11)
+#define	BTRF_HWPDN_N			BIT(12)
+#define	WLRF_HWPDN_N			BIT(13)
+#define	PDN_BT_N			BIT(14)
+#define	PDN_GPS_N			BIT(15)
+#define	BT_CTL_HWPDN			BIT(16)
+#define	GPS_CTL_HWPDN			BIT(17)
+#define	PPHY_SUSB			BIT(20)
+#define	UPHY_SUSB			BIT(21)
+#define	PCI_SUSEN			BIT(22)
+#define	USB_SUSEN			BIT(23)
+#define	RF_RL_ID			(BIT(31)|BIT(30)|BIT(29)|BIT(28))
+
+/* 2SYS_CFG */
+#define RTL_ID				BIT(23)	/*  TestChip ID, 1:Test(RLE); 0:MP(RL) */
+
+/* 	0x0100h ~ 0x01FFh	MACTOP General Configuration */
+
+/* 2 Function Enable Registers */
+/* 2 CR */
+
+#define HCI_TXDMA_EN			BIT(0)
+#define HCI_RXDMA_EN			BIT(1)
+#define TXDMA_EN			BIT(2)
+#define RXDMA_EN			BIT(3)
+#define PROTOCOL_EN			BIT(4)
+#define SCHEDULE_EN			BIT(5)
+#define MACTXEN				BIT(6)
+#define MACRXEN				BIT(7)
+#define ENSWBCN				BIT(8)
+#define ENSEC				BIT(9)
+#define CALTMR_EN			BIT(10)	/*  32k CAL TMR enable */
+
+/*  Network type */
+#define _NETTYPE(x)			(((x) & 0x3) << 16)
+#define MASK_NETTYPE			0x30000
+#define NT_NO_LINK			0x0
+#define NT_LINK_AD_HOC			0x1
+#define NT_LINK_AP			0x2
+#define NT_AS_AP			0x3
+
+/* 2 PBP - Page Size Register */
+#define GET_RX_PAGE_SIZE(value)		((value) & 0xF)
+#define GET_TX_PAGE_SIZE(value)		(((value) & 0xF0) >> 4)
+#define _PSRX_MASK			0xF
+#define _PSTX_MASK			0xF0
+#define _PSRX(x)			(x)
+#define _PSTX(x)			((x) << 4)
+
+#define PBP_64				0x0
+#define PBP_128				0x1
+#define PBP_256				0x2
+#define PBP_512				0x3
+#define PBP_1024			0x4
+
+/* 2 TX/RXDMA */
+#define RXDMA_ARBBW_EN			BIT(0)
+#define RXSHFT_EN			BIT(1)
+#define RXDMA_AGG_EN			BIT(2)
+#define QS_VO_QUEUE			BIT(8)
+#define QS_VI_QUEUE			BIT(9)
+#define QS_BE_QUEUE			BIT(10)
+#define QS_BK_QUEUE			BIT(11)
+#define QS_MANAGER_QUEUE		BIT(12)
+#define QS_HIGH_QUEUE			BIT(13)
+
+#define HQSEL_VOQ			BIT(0)
+#define HQSEL_VIQ			BIT(1)
+#define HQSEL_BEQ			BIT(2)
+#define HQSEL_BKQ			BIT(3)
+#define HQSEL_MGTQ			BIT(4)
+#define HQSEL_HIQ			BIT(5)
+
+/*  For normal driver, 0x10C */
+#define _TXDMA_HIQ_MAP(x)		(((x)&0x3) << 14)
+#define _TXDMA_MGQ_MAP(x)		(((x)&0x3) << 12)
+#define _TXDMA_BKQ_MAP(x)		(((x)&0x3) << 10)
+#define _TXDMA_BEQ_MAP(x)		(((x)&0x3) << 8 )
+#define _TXDMA_VIQ_MAP(x)		(((x)&0x3) << 6 )
+#define _TXDMA_VOQ_MAP(x)		(((x)&0x3) << 4 )
+
+#define QUEUE_LOW			1
+#define QUEUE_NORMAL			2
+#define QUEUE_HIGH			3
+
+/* 2 TRXFF_BNDY */
+
+/* 2 LLT_INIT */
+#define _LLT_NO_ACTIVE			0x0
+#define _LLT_WRITE_ACCESS		0x1
+#define _LLT_READ_ACCESS		0x2
+
+#define _LLT_INIT_DATA(x)		((x) & 0xFF)
+#define _LLT_INIT_ADDR(x)		(((x) & 0xFF) << 8)
+#define _LLT_OP(x)			(((x) & 0x3) << 30)
+#define _LLT_OP_VALUE(x)		(((x) >> 30) & 0x3)
+
+/* 	0x0200h ~ 0x027Fh	TXDMA Configuration */
+/* 2RQPN */
+#define _HPQ(x)				((x) & 0xFF)
+#define _LPQ(x)				(((x) & 0xFF) << 8)
+#define _PUBQ(x)			(((x) & 0xFF) << 16)
+/*  NOTE: in RQPN_NPQ register */
+#define _NPQ(x)				((x) & 0xFF)
+
+#define HPQ_PUBLIC_DIS			BIT(24)
+#define LPQ_PUBLIC_DIS			BIT(25)
+#define LD_RQPN				BIT(31)
+
+/* 2TDECTRL */
+#define BCN_VALID			BIT(16)
+#define BCN_HEAD(x)			(((x) & 0xFF) << 8)
+#define	BCN_HEAD_MASK			0xFF00
+
+/* 2 TDECTL */
+#define BLK_DESC_NUM_SHIFT		4
+#define BLK_DESC_NUM_MASK		0xF
+
+/* 2 TXDMA_OFFSET_CHK */
+#define DROP_DATA_EN			BIT(9)
+
+/* 	0x0280h ~ 0x028Bh	RX DMA Configuration */
+
+/*     REG_RXDMA_CONTROL, 0x0286h */
+
+/* 2 REG_RXPKT_NUM, 0x0284 */
+#define		RXPKT_RELEASE_POLL	BIT(16)
+#define	RXDMA_IDLE			BIT(17)
+#define	RW_RELEASE_EN			BIT(18)
+
+/* 	0x0400h ~ 0x047Fh	Protocol Configuration */
+/* 2 FWHW_TXQ_CTRL */
+#define EN_AMPDU_RTY_NEW		BIT(7)
+
+/* 2 SPEC SIFS */
+#define _SPEC_SIFS_CCK(x)		((x) & 0xFF)
+#define _SPEC_SIFS_OFDM(x)		(((x) & 0xFF) << 8)
+
+/* 2 RL */
+#define	RETRY_LIMIT_SHORT_SHIFT		8
+#define	RETRY_LIMIT_LONG_SHIFT		0
+
+/* 	0x0500h ~ 0x05FFh	EDCA Configuration */
+
+/* 2 EDCA setting */
+#define AC_PARAM_TXOP_LIMIT_OFFSET	16
+#define AC_PARAM_ECW_MAX_OFFSET		12
+#define AC_PARAM_ECW_MIN_OFFSET		8
+#define AC_PARAM_AIFS_OFFSET		0
+
+#define _LRL(x)			((x) & 0x3F)
+#define _SRL(x)			(((x) & 0x3F) << 8)
+
+/* 2 BCN_CTRL */
+#define EN_MBSSID		BIT(1)
+#define EN_TXBCN_RPT		BIT(2)
+#define EN_BCN_FUNCTION		BIT(3)
+#define DIS_TSF_UPDATE		BIT(3)
+
+/*  The same function but different bit field. */
+#define DIS_TSF_UDT0_NORMAL_CHIP	BIT(4)
+#define DIS_TSF_UDT0_TEST_CHIP	BIT(5)
+#define STOP_BCNQ		BIT(6)
+
+/* 2 ACMHWCTRL */
+#define	AcmHw_HwEn		BIT(0)
+#define	AcmHw_BeqEn		BIT(1)
+#define	AcmHw_ViqEn		BIT(2)
+#define	AcmHw_VoqEn		BIT(3)
+#define	AcmHw_BeqStatus		BIT(4)
+#define	AcmHw_ViqStatus		BIT(5)
+#define	AcmHw_VoqStatus		BIT(6)
+
+/* 	0x0600h ~ 0x07FFh	WMAC Configuration */
+/* 2APSD_CTRL */
+#define APSDOFF			BIT(6)
+#define APSDOFF_STATUS		BIT(7)
+
+#define RATE_BITMAP_ALL		0xFFFFF
+
+/*  Only use CCK 1M rate for ACK */
+#define RATE_RRSR_CCK_ONLY_1M	0xFFFF1
+
+/* 2 TCR */
+#define TSFRST			BIT(0)
+#define DIS_GCLK		BIT(1)
+#define PAD_SEL			BIT(2)
+#define PWR_ST			BIT(6)
+#define PWRBIT_OW_EN		BIT(7)
+#define ACRC			BIT(8)
+#define CFENDFORM		BIT(9)
+#define ICV			BIT(10)
+
+/* 2 RCR */
+#define AAP			BIT(0)
+#define APM			BIT(1)
+#define AM			BIT(2)
+#define AB			BIT(3)
+#define ADD3			BIT(4)
+#define APWRMGT			BIT(5)
+#define CBSSID			BIT(6)
+#define CBSSID_DATA		BIT(6)
+#define CBSSID_BCN		BIT(7)
+#define ACRC32			BIT(8)
+#define AICV			BIT(9)
+#define ADF			BIT(11)
+#define ACF			BIT(12)
+#define AMF			BIT(13)
+#define HTC_LOC_CTRL		BIT(14)
+#define UC_DATA_EN		BIT(16)
+#define BM_DATA_EN		BIT(17)
+#define MFBEN			BIT(22)
+#define LSIGEN			BIT(23)
+#define EnMBID			BIT(24)
+#define APP_BASSN		BIT(27)
+#define APP_PHYSTS		BIT(28)
+#define APP_ICV			BIT(29)
+#define APP_MIC			BIT(30)
+#define APP_FCS			BIT(31)
+
+/* 2 SECCFG */
+#define	SCR_TxUseDK		BIT(0)	/* Force Tx Use Default Key */
+#define	SCR_RxUseDK		BIT(1)	/* Force Rx Use Default Key */
+#define	SCR_TxEncEnable		BIT(2)	/* Enable Tx Encryption */
+#define	SCR_RxDecEnable		BIT(3)	/* Enable Rx Decryption */
+#define	SCR_SKByA2		BIT(4)	/* Search kEY BY A2 */
+#define	SCR_NoSKMC		BIT(5)	/* No Key Search Multicast */
+#define SCR_TXBCUSEDK		BIT(6)	/* Force Tx Bcast pkt Use Default Key */
+#define SCR_RXBCUSEDK		BIT(7)	/* Force Rx Bcast pkt Use Default Key */
+
+/* 	RTL8188E SDIO Configuration */
+
+/*  I/O bus domain address mapping */
+#define SDIO_LOCAL_BASE			0x10250000
+#define WLAN_IOREG_BASE			0x10260000
+#define FIRMWARE_FIFO_BASE		0x10270000
+#define TX_HIQ_BASE			0x10310000
+#define TX_MIQ_BASE			0x10320000
+#define TX_LOQ_BASE			0x10330000
+#define RX_RX0FF_BASE			0x10340000
+
+/*  SDIO host local register space mapping. */
+#define SDIO_LOCAL_MSK			0x0FFF
+#define WLAN_IOREG_MSK			0x7FFF
+#define WLAN_FIFO_MSK			0x1FFF	/*  Aggregation Length[12:0] */
+#define WLAN_RX0FF_MSK			0x0003
+
+/*  Without ref to the SDIO Device ID */
+#define SDIO_WITHOUT_REF_DEVICE_ID	0
+#define SDIO_LOCAL_DEVICE_ID		0	/*  0b[16], 000b[15:13] */
+#define WLAN_TX_HIQ_DEVICE_ID		4	/*  0b[16], 100b[15:13] */
+#define WLAN_TX_MIQ_DEVICE_ID		5	/*  0b[16], 101b[15:13] */
+#define WLAN_TX_LOQ_DEVICE_ID		6	/*  0b[16], 110b[15:13] */
+#define WLAN_RX0FF_DEVICE_ID		7	/*  0b[16], 111b[15:13] */
+#define WLAN_IOREG_DEVICE_ID		8	/*  1b[16] */
+
+/*  SDIO Tx Free Page Index */
+#define HI_QUEUE_IDX			0
+#define MID_QUEUE_IDX			1
+#define LOW_QUEUE_IDX			2
+#define PUBLIC_QUEUE_IDX		3
+
+#define SDIO_MAX_TX_QUEUE		3	/*  HIQ, MIQ and LOQ */
+#define SDIO_MAX_RX_QUEUE		1
+
+/*  SDIO Tx Control */
+#define SDIO_REG_TX_CTRL		0x0000
+/*  SDIO Host Interrupt Mask */
+#define SDIO_REG_HIMR			0x0014
+/*  SDIO Host Interrupt Service Routine */
+#define SDIO_REG_HISR			0x0018
+/*  HCI Current Power Mode */
+#define SDIO_REG_HCPWM			0x0019
+/*  RXDMA Request Length */
+#define SDIO_REG_RX0_REQ_LEN		0x001C
+/*  Free Tx Buffer Page */
+#define SDIO_REG_FREE_TXPG		0x0020
+/*  HCI Current Power Mode 1 */
+#define SDIO_REG_HCPWM1			0x0024
+/*  HCI Current Power Mode 2 */
+#define SDIO_REG_HCPWM2			0x0026
+/*  HTSF Informaion */
+#define SDIO_REG_HTSFR_INFO		0x0030
+/*  HCI Request Power Mode 1 */
+#define SDIO_REG_HRPWM1			0x0080
+/*  HCI Request Power Mode 2 */
+#define SDIO_REG_HRPWM2			0x0082
+/*  HCI Power Save Clock */
+#define SDIO_REG_HPS_CLKR		0x0084
+/*  SDIO HCI Suspend Control */
+#define SDIO_REG_HSUS_CTRL		0x0086
+/*  SDIO Host Extension Interrupt Mask Always */
+#define SDIO_REG_HIMR_ON		0x0090
+/*  SDIO Host Extension Interrupt Status Always */
+#define SDIO_REG_HISR_ON		0x0091
+
+#define SDIO_HIMR_DISABLED			0
+
+/*  RTL8188E SDIO Host Interrupt Mask Register */
+#define SDIO_HIMR_RX_REQUEST_MSK		BIT0
+#define SDIO_HIMR_AVAL_MSK			BIT1
+#define SDIO_HIMR_TXERR_MSK			BIT2
+#define SDIO_HIMR_RXERR_MSK			BIT3
+#define SDIO_HIMR_TXFOVW_MSK			BIT4
+#define SDIO_HIMR_RXFOVW_MSK			BIT5
+#define SDIO_HIMR_TXBCNOK_MSK			BIT6
+#define SDIO_HIMR_TXBCNERR_MSK			BIT7
+#define SDIO_HIMR_BCNERLY_INT_MSK		BIT16
+#define SDIO_HIMR_C2HCMD_MSK			BIT17
+#define SDIO_HIMR_CPWM1_MSK			BIT18
+#define SDIO_HIMR_CPWM2_MSK			BIT19
+#define SDIO_HIMR_HSISR_IND_MSK			BIT20
+#define SDIO_HIMR_GTINT3_IND_MSK		BIT21
+#define SDIO_HIMR_GTINT4_IND_MSK		BIT22
+#define SDIO_HIMR_PSTIMEOUT_MSK			BIT23
+#define SDIO_HIMR_OCPINT_MSK			BIT24
+#define SDIO_HIMR_ATIMEND_MSK			BIT25
+#define SDIO_HIMR_ATIMEND_E_MSK			BIT26
+#define SDIO_HIMR_CTWEND_MSK			BIT27
+
+/* RTL8188E SDIO Specific */
+#define	SDIO_HIMR_MCU_ERR_MSK			BIT28
+#define	SDIO_HIMR_TSF_BIT32_TOGGLE_MSK		BIT29
+
+/*  SDIO Host Interrupt Service Routine */
+#define SDIO_HISR_RX_REQUEST			BIT0
+#define SDIO_HISR_AVAL				BIT1
+#define SDIO_HISR_TXERR				BIT2
+#define SDIO_HISR_RXERR				BIT3
+#define SDIO_HISR_TXFOVW			BIT4
+#define SDIO_HISR_RXFOVW			BIT5
+#define SDIO_HISR_TXBCNOK			BIT6
+#define SDIO_HISR_TXBCNERR			BIT7
+#define SDIO_HISR_BCNERLY_INT			BIT16
+#define SDIO_HISR_C2HCMD			BIT17
+#define SDIO_HISR_CPWM1				BIT18
+#define SDIO_HISR_CPWM2				BIT19
+#define SDIO_HISR_HSISR_IND			BIT20
+#define SDIO_HISR_GTINT3_IND			BIT21
+#define SDIO_HISR_GTINT4_IND			BIT22
+#define SDIO_HISR_PSTIME			BIT23
+#define SDIO_HISR_OCPINT			BIT24
+#define SDIO_HISR_ATIMEND			BIT25
+#define SDIO_HISR_ATIMEND_E			BIT26
+#define SDIO_HISR_CTWEND			BIT27
+
+/* RTL8188E SDIO Specific */
+#define	SDIO_HISR_MCU_ERR			BIT28
+#define	SDIO_HISR_TSF_BIT32_TOGGLE		BIT29
+
+#define MASK_SDIO_HISR_CLEAR				\
+	(SDIO_HISR_TXERR | SDIO_HISR_RXERR | SDIO_HISR_TXFOVW |\
+	 SDIO_HISR_RXFOVW | SDIO_HISR_TXBCNOK | SDIO_HISR_TXBCNERR |\
+	 SDIO_HISR_C2HCMD | SDIO_HISR_CPWM1 | SDIO_HISR_CPWM2 |\
+	 SDIO_HISR_HSISR_IND | SDIO_HISR_GTINT3_IND | SDIO_HISR_GTINT4_IND |\
+	 SDIO_HISR_PSTIMEOUT | SDIO_HISR_OCPINT)
+
+/*  SDIO HCI Suspend Control Register */
+#define HCI_RESUME_PWR_RDY		BIT1
+#define HCI_SUS_CTRL			BIT0
+
+/*  SDIO Tx FIFO related */
+/*  The number of Tx FIFO free page */
+#define SDIO_TX_FREE_PG_QUEUE			4
+#define SDIO_TX_FIFO_PAGE_SZ			128
+
+/* 	0xFE00h ~ 0xFE55h	USB Configuration */
+
+/* 2 USB Information (0xFE17) */
+#define USB_IS_HIGH_SPEED			0
+#define USB_IS_FULL_SPEED			1
+#define USB_SPEED_MASK				BIT(5)
+
+#define USB_NORMAL_SIE_EP_MASK			0xF
+#define USB_NORMAL_SIE_EP_SHIFT			4
+
+/* 2 Special Option */
+#define USB_AGG_EN				BIT(3)
+
+/*  0; Use interrupt endpoint to upload interrupt pkt */
+/*  1; Use bulk endpoint to upload interrupt pkt, */
+#define INT_BULK_SEL				BIT(4)
+
+/* 2REG_C2HEVT_CLEAR */
+/*  Set by driver and notify FW that the driver has read
+ *  the C2H command message */
+#define	C2H_EVT_HOST_CLOSE	0x00
+/*  Set by FW indicating that FW had set the C2H command
+ *  message and it's not yet read by driver. */
+#define C2H_EVT_FW_CLOSE	0xFF
+
+/* 2REG_MULTI_FUNC_CTRL(For RTL8723 Only) */
+/*  Enable GPIO[9] as WiFi HW PDn source */
+#define	WL_HWPDN_EN				BIT0
+/*  WiFi HW PDn polarity control */
+#define	WL_HWPDN_SL				BIT1
+/*  WiFi function enable */
+#define	WL_FUNC_EN				BIT2
+/*  Enable GPIO[9] as WiFi RF HW PDn source */
+#define	WL_HWROF_EN				BIT3
+/*  Enable GPIO[11] as BT HW PDn source */
+#define	BT_HWPDN_EN				BIT16
+/*  BT HW PDn polarity control */
+#define	BT_HWPDN_SL				BIT17
+/*  BT function enable */
+#define	BT_FUNC_EN				BIT18
+/*  Enable GPIO[11] as BT/GPS RF HW PDn source */
+#define	BT_HWROF_EN				BIT19
+/*  Enable GPIO[10] as GPS HW PDn source */
+#define	GPS_HWPDN_EN				BIT20
+/*  GPS HW PDn polarity control */
+#define	GPS_HWPDN_SL				BIT21
+/*  GPS function enable */
+#define	GPS_FUNC_EN				BIT22
+
+/* 3 REG_LIFECTRL_CTRL */
+#define	HAL92C_EN_PKT_LIFE_TIME_BK		BIT3
+#define	HAL92C_EN_PKT_LIFE_TIME_BE		BIT2
+#define	HAL92C_EN_PKT_LIFE_TIME_VI		BIT1
+#define	HAL92C_EN_PKT_LIFE_TIME_VO		BIT0
+
+#define	HAL92C_MSDU_LIFE_TIME_UNIT		128	/*  in us */
+
+/*  General definitions */
+#define LAST_ENTRY_OF_TX_PKT_BUFFER		176 /*  22k 22528 bytes */
+
+#define POLLING_LLT_THRESHOLD			20
+#define POLLING_READY_TIMEOUT_COUNT		1000
+/*  GPIO BIT */
+#define	HAL_8192C_HW_GPIO_WPS_BIT		BIT2
+
+/*	8192C EEPROM/EFUSE share register definition. */
+
+/* 	EEPROM/Efuse PG Offset for 88EE/88EU/88ES */
+#define	EEPROM_TX_PWR_INX_88E			0x10
+
+#define	EEPROM_ChannelPlan_88E			0xB8
+#define	EEPROM_XTAL_88E				0xB9
+#define	EEPROM_THERMAL_METER_88E		0xBA
+#define	EEPROM_IQK_LCK_88E			0xBB
+
+#define	EEPROM_RF_BOARD_OPTION_88E		0xC1
+#define	EEPROM_RF_FEATURE_OPTION_88E		0xC2
+#define	EEPROM_RF_BT_SETTING_88E		0xC3
+#define	EEPROM_VERSION_88E			0xC4
+#define	EEPROM_CUSTOMERID_88E			0xC5
+#define	EEPROM_RF_ANTENNA_OPT_88E		0xC9
+
+/*  RTL88EE */
+#define	EEPROM_MAC_ADDR_88EE			0xD0
+#define	EEPROM_VID_88EE				0xD6
+#define	EEPROM_DID_88EE				0xD8
+#define	EEPROM_SVID_88EE			0xDA
+#define	EEPROM_SMID_88EE			0xDC
+
+/* RTL88EU */
+#define	EEPROM_MAC_ADDR_88EU			0xD7
+#define	EEPROM_VID_88EU				0xD0
+#define	EEPROM_PID_88EU				0xD2
+#define EEPROM_USB_OPTIONAL_FUNCTION0		0xD4
+
+/*  RTL88ES */
+#define	EEPROM_MAC_ADDR_88ES			0x11A
+
+/* 		EEPROM/Efuse Value Type */
+#define EETYPE_TX_PWR				0x0
+
+/*  Default Value for EEPROM or EFUSE!!! */
+#define EEPROM_Default_TSSI			0x0
+#define EEPROM_Default_TxPowerDiff		0x0
+#define EEPROM_Default_CrystalCap		0x5
+/*  Default: 2X2, RTL8192CE(QFPN68) */
+#define EEPROM_Default_BoardType		0x02
+#define EEPROM_Default_TxPower			0x1010
+#define EEPROM_Default_HT2T_TxPwr		0x10
+
+#define EEPROM_Default_LegacyHTTxPowerDiff	0x3
+#define EEPROM_Default_ThermalMeter		0x12
+
+#define EEPROM_Default_AntTxPowerDiff		0x0
+#define EEPROM_Default_TxPwDiff_CrystalCap	0x5
+#define EEPROM_Default_TxPowerLevel		0x2A
+
+#define EEPROM_Default_HT40_2SDiff		0x0
+/*  HT20<->40 default Tx Power Index Difference */
+#define EEPROM_Default_HT20_Diff		2
+#define EEPROM_Default_LegacyHTTxPowerDiff	0x3
+#define EEPROM_Default_HT40_PwrMaxOffset	0
+#define EEPROM_Default_HT20_PwrMaxOffset	0
+
+#define EEPROM_Default_CrystalCap_88E		0x20
+#define	EEPROM_Default_ThermalMeter_88E		0x18
+
+/* New EFUSE deafult value */
+#define		EEPROM_DEFAULT_24G_INDEX	0x2D
+#define		EEPROM_DEFAULT_24G_HT20_DIFF	0X02
+#define		EEPROM_DEFAULT_24G_OFDM_DIFF	0X04
+
+#define		EEPROM_DEFAULT_5G_INDEX		0X2A
+#define		EEPROM_DEFAULT_5G_HT20_DIFF	0X00
+#define		EEPROM_DEFAULT_5G_OFDM_DIFF	0X04
+
+#define		EEPROM_DEFAULT_DIFF		0XFE
+#define	EEPROM_DEFAULT_CHANNEL_PLAN		0x7F
+#define	EEPROM_DEFAULT_BOARD_OPTION		0x00
+#define	EEPROM_DEFAULT_FEATURE_OPTION		0x00
+#define	EEPROM_DEFAULT_BT_OPTION		0x10
+
+/*  For debug */
+#define EEPROM_Default_PID			0x1234
+#define EEPROM_Default_VID			0x5678
+#define EEPROM_Default_CustomerID		0xAB
+#define	EEPROM_Default_CustomerID_8188E		0x00
+#define EEPROM_Default_SubCustomerID		0xCD
+#define EEPROM_Default_Version			0
+
+#define EEPROM_CHANNEL_PLAN_FCC			0x0
+#define EEPROM_CHANNEL_PLAN_IC			0x1
+#define EEPROM_CHANNEL_PLAN_ETSI		0x2
+#define EEPROM_CHANNEL_PLAN_SPA			0x3
+#define EEPROM_CHANNEL_PLAN_FRANCE		0x4
+#define EEPROM_CHANNEL_PLAN_MKK			0x5
+#define EEPROM_CHANNEL_PLAN_MKK1		0x6
+#define EEPROM_CHANNEL_PLAN_ISRAEL		0x7
+#define EEPROM_CHANNEL_PLAN_TELEC		0x8
+#define EEPROM_CHANNEL_PLAN_GLOBAL_DOMA		0x9
+#define EEPROM_CHANNEL_PLAN_WORLD_WIDE_13	0xA
+#define EEPROM_CHANNEL_PLAN_NCC			0xB
+#define EEPROM_USB_OPTIONAL1			0xE
+#define EEPROM_CHANNEL_PLAN_BY_HW_MASK		0x80
+
+#define EEPROM_CID_DEFAULT		0x0
+#define EEPROM_CID_TOSHIBA		0x4
+#define EEPROM_CID_CCX			0x10 /*  CCX test. */
+#define EEPROM_CID_QMI			0x0D
+#define EEPROM_CID_WHQL			0xFE
+#define	RTL_EEPROM_ID			0x8129
+
+#endif /* __RTL8188E_SPEC_H__ */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_sreset.h b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
new file mode 100644
index 000000000000..a29e69519794
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_sreset.h
@@ -0,0 +1,31 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTL8188E_SRESET_H_
+#define _RTL8188E_SRESET_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <rtw_sreset.h>
+
+void rtl8188e_silentreset_for_specific_platform(struct adapter *padapter);
+void rtl8188e_sreset_xmit_status_check(struct adapter *padapter);
+void rtl8188e_sreset_linked_status_check(struct adapter *padapter);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
new file mode 100644
index 000000000000..5e586058826d
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -0,0 +1,177 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTL8188E_XMIT_H__
+#define __RTL8188E_XMIT_H__
+
+#define		MAX_TX_AGG_PACKET_NUMBER	0xFF
+/*  */
+/*  Queue Select Value in TxDesc */
+/*  */
+#define QSLT_BK							0x2/* 0x01 */
+#define QSLT_BE							0x0
+#define QSLT_VI							0x5/* 0x4 */
+#define QSLT_VO							0x7/* 0x6 */
+#define QSLT_BEACON						0x10
+#define QSLT_HIGH						0x11
+#define QSLT_MGNT						0x12
+#define QSLT_CMD						0x13
+
+/* For 88e early mode */
+#define SET_EARLYMODE_PKTNUM(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr, 0, 3, __Value)
+#define SET_EARLYMODE_LEN0(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr, 4, 12, __Value)
+#define SET_EARLYMODE_LEN1(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr, 16, 12, __Value)
+#define SET_EARLYMODE_LEN2_1(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr, 28, 4, __Value)
+#define SET_EARLYMODE_LEN2_2(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr+4, 0, 8, __Value)
+#define SET_EARLYMODE_LEN3(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr+4, 8, 12, __Value)
+#define SET_EARLYMODE_LEN4(__pAddr, __Value)			\
+	SET_BITS_TO_LE_4BYTE(__pAddr+4, 20, 12, __Value)
+
+/*  */
+/* defined for TX DESC Operation */
+/*  */
+
+#define MAX_TID (15)
+
+/* OFFSET 0 */
+#define OFFSET_SZ	0
+#define OFFSET_SHT	16
+#define BMC		BIT(24)
+#define LSG		BIT(26)
+#define FSG		BIT(27)
+#define OWN		BIT(31)
+
+/* OFFSET 4 */
+#define PKT_OFFSET_SZ		0
+#define QSEL_SHT		8
+#define RATE_ID_SHT		16
+#define NAVUSEHDR		BIT(20)
+#define SEC_TYPE_SHT		22
+#define PKT_OFFSET_SHT		26
+
+/* OFFSET 8 */
+#define AGG_EN			BIT(12)
+#define AGG_BK			BIT(16)
+#define AMPDU_DENSITY_SHT	20
+#define ANTSEL_A		BIT(24)
+#define ANTSEL_B		BIT(25)
+#define TX_ANT_CCK_SHT		26
+#define TX_ANTL_SHT		28
+#define TX_ANT_HT_SHT		30
+
+/* OFFSET 12 */
+#define SEQ_SHT			16
+#define EN_HWSEQ		BIT(31)
+
+/* OFFSET 16 */
+#define QOS			BIT(6)
+#define	HW_SSN			BIT(7)
+#define USERATE			BIT(8)
+#define DISDATAFB		BIT(10)
+#define CTS_2_SELF		BIT(11)
+#define	RTS_EN			BIT(12)
+#define	HW_RTS_EN		BIT(13)
+#define DATA_SHORT		BIT(24)
+#define PWR_STATUS_SHT		15
+#define DATA_SC_SHT		20
+#define DATA_BW			BIT(25)
+
+/* OFFSET 20 */
+#define	RTY_LMT_EN		BIT(17)
+
+enum TXDESC_SC {
+	SC_DONT_CARE = 0x00,
+	SC_UPPER = 0x01,
+	SC_LOWER = 0x02,
+	SC_DUPLICATE = 0x03
+};
+/* OFFSET 20 */
+#define SGI			BIT(6)
+#define USB_TXAGG_NUM_SHT	24
+
+#define txdesc_set_ccx_sw_88e(txdesc, value) \
+	do { \
+		((struct txdesc_88e *)(txdesc))->sw1 = (((value)>>8) & 0x0f); \
+		((struct txdesc_88e *)(txdesc))->sw0 = ((value) & 0xff); \
+	} while (0)
+
+struct txrpt_ccx_88e {
+	/* offset 0 */
+	u8 tag1:1;
+	u8 pkt_num:3;
+	u8 txdma_underflow:1;
+	u8 int_bt:1;
+	u8 int_tri:1;
+	u8 int_ccx:1;
+
+	/* offset 1 */
+	u8 mac_id:6;
+	u8 pkt_ok:1;
+	u8 bmc:1;
+
+	/* offset 2 */
+	u8 retry_cnt:6;
+	u8 lifetime_over:1;
+	u8 retry_over:1;
+
+	/* offset 3 */
+	u8 ccx_qtime0;
+	u8 ccx_qtime1;
+
+	/* offset 5 */
+	u8 final_data_rate;
+
+	/* offset 6 */
+	u8 sw1:4;
+	u8 qsel:4;
+
+	/* offset 7 */
+	u8 sw0;
+};
+
+#define txrpt_ccx_sw_88e(txrpt_ccx) ((txrpt_ccx)->sw0 + ((txrpt_ccx)->sw1<<8))
+#define txrpt_ccx_qtime_88e(txrpt_ccx)			\
+	((txrpt_ccx)->ccx_qtime0+((txrpt_ccx)->ccx_qtime1<<8))
+
+void rtl8188e_fill_fake_txdesc(struct adapter *padapter, u8 *pDesc,
+			       u32 BufferLen, u8 IsPsPoll, u8 IsBTQosNull);
+s32 rtl8188eu_init_xmit_priv(struct adapter *padapter);
+void rtl8188eu_free_xmit_priv(struct adapter *padapter);
+s32 rtl8188eu_hal_xmit(struct adapter *padapter, struct xmit_frame *frame);
+s32 rtl8188eu_mgnt_xmit(struct adapter *padapter, struct xmit_frame *frame);
+s32 rtl8188eu_xmit_buf_handler(struct adapter *padapter);
+#define hal_xmit_handler rtl8188eu_xmit_buf_handler
+void rtl8188eu_xmit_tasklet(void *priv);
+s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
+				 struct xmit_priv *pxmitpriv,
+				 struct xmit_buf *pxmitbuf);
+
+void dump_txrpt_ccx_88e(void *buf);
+void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
+
+void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
+		       struct tx_desc *ptxdesc);
+
+#endif /* __RTL8188E_XMIT_H__ */
diff --git a/drivers/staging/r8188eu/include/rtw_android.h b/drivers/staging/r8188eu/include/rtw_android.h
new file mode 100644
index 000000000000..e85bf1ff01f8
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_android.h
@@ -0,0 +1,64 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef __RTW_ANDROID_H__
+#define __RTW_ANDROID_H__
+
+#include <linux/module.h>
+#include <linux/netdevice.h>
+
+enum ANDROID_WIFI_CMD {
+	ANDROID_WIFI_CMD_START,
+	ANDROID_WIFI_CMD_STOP,
+	ANDROID_WIFI_CMD_SCAN_ACTIVE,
+	ANDROID_WIFI_CMD_SCAN_PASSIVE,
+	ANDROID_WIFI_CMD_RSSI,
+	ANDROID_WIFI_CMD_LINKSPEED,
+	ANDROID_WIFI_CMD_RXFILTER_START,
+	ANDROID_WIFI_CMD_RXFILTER_STOP,
+	ANDROID_WIFI_CMD_RXFILTER_ADD,
+	ANDROID_WIFI_CMD_RXFILTER_REMOVE,
+	ANDROID_WIFI_CMD_BTCOEXSCAN_START,
+	ANDROID_WIFI_CMD_BTCOEXSCAN_STOP,
+	ANDROID_WIFI_CMD_BTCOEXMODE,
+	ANDROID_WIFI_CMD_SETSUSPENDOPT,
+	ANDROID_WIFI_CMD_P2P_DEV_ADDR,
+	ANDROID_WIFI_CMD_SETFWPATH,
+	ANDROID_WIFI_CMD_SETBAND,
+	ANDROID_WIFI_CMD_GETBAND,
+	ANDROID_WIFI_CMD_COUNTRY,
+	ANDROID_WIFI_CMD_P2P_SET_NOA,
+	ANDROID_WIFI_CMD_P2P_GET_NOA,
+	ANDROID_WIFI_CMD_P2P_SET_PS,
+	ANDROID_WIFI_CMD_SET_AP_WPS_P2P_IE,
+	ANDROID_WIFI_CMD_MACADDR,
+	ANDROID_WIFI_CMD_BLOCK,
+	ANDROID_WIFI_CMD_WFD_ENABLE,
+	ANDROID_WIFI_CMD_WFD_DISABLE,
+	ANDROID_WIFI_CMD_WFD_SET_TCPPORT,
+	ANDROID_WIFI_CMD_WFD_SET_MAX_TPUT,
+	ANDROID_WIFI_CMD_WFD_SET_DEVTYPE,
+	ANDROID_WIFI_CMD_MAX
+};
+
+int rtw_android_cmdstr_to_num(char *cmdstr);
+int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd);
+
+#endif /* __RTW_ANDROID_H__ */
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
new file mode 100644
index 000000000000..bf3c9fb60153
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -0,0 +1,67 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_AP_H_
+#define __RTW_AP_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#ifdef CONFIG_88EU_AP_MODE
+
+/* external function */
+void rtw_indicate_sta_assoc_event(struct adapter *padapter,
+				  struct sta_info *psta);
+void rtw_indicate_sta_disassoc_event(struct adapter *padapter,
+				     struct sta_info *psta);
+void init_mlme_ap_info(struct adapter *padapter);
+void free_mlme_ap_info(struct adapter *padapter);
+void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
+		    u8 index, u8 *data, u8 len);
+void rtw_remove_bcn_ie(struct adapter *padapter,
+		       struct wlan_bssid_ex *pnetwork, u8 index);
+void update_beacon(struct adapter *padapter, u8 ie_id,
+		   u8 *oui, u8 tx);
+void add_RATid(struct adapter *padapter, struct sta_info *psta,
+	       u8 rssi_level);
+void expire_timeout_chk(struct adapter *padapter);
+void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta);
+int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len);
+void rtw_ap_restore_network(struct adapter *padapter);
+void rtw_set_macaddr_acl(struct adapter *padapter, int mode);
+int rtw_acl_add_sta(struct adapter *padapter, u8 *addr);
+int rtw_acl_remove_sta(struct adapter *padapter, u8 *addr);
+
+#ifdef CONFIG_88EU_AP_MODE
+void associated_clients_update(struct adapter *padapter, u8 updated);
+void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta);
+u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta);
+void sta_info_update(struct adapter *padapter, struct sta_info *psta);
+void ap_sta_info_defer_update(struct adapter *padapter, struct sta_info *psta);
+u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
+	       bool active, u16 reason);
+int rtw_sta_flush(struct adapter *padapter);
+int rtw_ap_inform_ch_switch(struct adapter *padapter, u8 new_ch, u8 ch_offset);
+void start_ap_mode(struct adapter *padapter);
+void stop_ap_mode(struct adapter *padapter);
+#endif
+#endif /* end of CONFIG_88EU_AP_MODE */
+void update_bmc_sta(struct adapter *padapter);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_br_ext.h b/drivers/staging/r8188eu/include/rtw_br_ext.h
new file mode 100644
index 000000000000..f21e7a4515d0
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_br_ext.h
@@ -0,0 +1,66 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_BR_EXT_H_
+#define _RTW_BR_EXT_H_
+
+#define MACADDRLEN		6
+#define _DEBUG_ERR		DBG_88E
+#define _DEBUG_INFO		DBG_88E
+#define DEBUG_WARN		DBG_88E
+#define DEBUG_INFO		DBG_88E
+#define DEBUG_ERR		DBG_88E
+#define GET_MY_HWADDR(padapter)		((padapter)->eeprompriv.mac_addr)
+
+#define NAT25_HASH_BITS		4
+#define NAT25_HASH_SIZE		(1 << NAT25_HASH_BITS)
+#define NAT25_AGEING_TIME	300
+
+#define MAX_NETWORK_ADDR_LEN	17
+
+struct nat25_network_db_entry {
+	struct nat25_network_db_entry	*next_hash;
+	struct nat25_network_db_entry	**pprev_hash;
+	atomic_t	use_count;
+	unsigned char	macAddr[6];
+	unsigned long	ageing_timer;
+	unsigned char	networkAddr[MAX_NETWORK_ADDR_LEN];
+};
+
+enum NAT25_METHOD {
+	NAT25_MIN,
+	NAT25_CHECK,
+	NAT25_INSERT,
+	NAT25_LOOKUP,
+	NAT25_PARSE,
+	NAT25_MAX
+};
+
+struct br_ext_info {
+	unsigned int	nat25_disable;
+	unsigned int	macclone_enable;
+	unsigned int	dhcp_bcst_disable;
+	int	addPPPoETag;		/* 1: Add PPPoE relay-SID, 0: disable */
+	unsigned char	nat25_dmzMac[MACADDRLEN];
+	unsigned int	nat25sc_disable;
+};
+
+void nat25_db_cleanup(struct adapter *priv);
+
+#endif /*  _RTW_BR_EXT_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_cmd.h b/drivers/staging/r8188eu/include/rtw_cmd.h
new file mode 100644
index 000000000000..357e732ac046
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_cmd.h
@@ -0,0 +1,991 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_CMD_H_
+#define __RTW_CMD_H_
+
+#include <wlan_bssdef.h>
+#include <rtw_rf.h>
+#include <rtw_led.h>
+
+#define C2H_MEM_SZ (16*1024)
+
+#include <osdep_service.h>
+#include <ieee80211.h> /*  <ieee80211/ieee80211.h> */
+
+#define FREE_CMDOBJ_SZ	128
+
+#define MAX_CMDSZ	1024
+#define MAX_RSPSZ	512
+#define MAX_EVTSZ	1024
+
+#define CMDBUFF_ALIGN_SZ 512
+
+struct cmd_obj {
+	struct adapter *padapter;
+	u16	cmdcode;
+	u8	res;
+	u8	*parmbuf;
+	u32	cmdsz;
+	u8	*rsp;
+	u32	rspsz;
+	struct list_head list;
+};
+
+struct cmd_priv {
+	struct semaphore cmd_queue_sema;
+	struct semaphore terminate_cmdthread_sema;
+	struct __queue cmd_queue;
+	u8	cmd_seq;
+	u8	*cmd_buf;	/* shall be non-paged, and 4 bytes aligned */
+	u8	*cmd_allocated_buf;
+	u8	*rsp_buf;	/* shall be non-paged, and 4 bytes aligned */
+	u8	*rsp_allocated_buf;
+	u32	cmd_issued_cnt;
+	u32	cmd_done_cnt;
+	u32	rsp_cnt;
+	u8 cmdthd_running;
+	struct adapter *padapter;
+};
+
+struct	evt_priv {
+	struct work_struct c2h_wk;
+	bool c2h_wk_alive;
+	struct rtw_cbuf *c2h_queue;
+	#define C2H_QUEUE_MAX_LEN 10
+	ATOMIC_T event_seq;
+	u8	*evt_buf;	/* shall be non-paged, and 4 bytes aligned */
+	u8	*evt_allocated_buf;
+	u32	evt_done_cnt;
+};
+
+#define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
+do {\
+	INIT_LIST_HEAD(&pcmd->list);\
+	pcmd->cmdcode = code;\
+	pcmd->parmbuf = (u8 *)(pparm);\
+	pcmd->cmdsz = sizeof(*pparm);\
+	pcmd->rsp = NULL;\
+	pcmd->rspsz = 0;\
+} while (0)
+
+struct c2h_evt_hdr {
+	u8 id:4;
+	u8 plen:4;
+	u8 seq;
+	u8 payload[0];
+};
+
+#define c2h_evt_exist(c2h_evt) ((c2h_evt)->id || (c2h_evt)->plen)
+
+u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj);
+struct cmd_obj *rtw_dequeue_cmd(struct cmd_priv *pcmdpriv);
+void rtw_free_cmd_obj(struct cmd_obj *pcmd);
+
+int rtw_cmd_thread(void *context);
+
+u32 rtw_init_cmd_priv(struct cmd_priv *pcmdpriv);
+void rtw_free_cmd_priv(struct cmd_priv *pcmdpriv);
+
+u32 rtw_init_evt_priv(struct evt_priv *pevtpriv);
+void rtw_free_evt_priv(struct evt_priv *pevtpriv);
+void rtw_cmd_clr_isr(struct cmd_priv *pcmdpriv);
+void rtw_evt_notify_isr(struct evt_priv *pevtpriv);
+#ifdef CONFIG_88EU_P2P
+u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType);
+#endif /* CONFIG_88EU_P2P */
+
+enum rtw_drvextra_cmd_id {
+	NONE_WK_CID,
+	DYNAMIC_CHK_WK_CID,
+	DM_CTRL_WK_CID,
+	PBC_POLLING_WK_CID,
+	POWER_SAVING_CTRL_WK_CID,/* IPS,AUTOSuspend */
+	LPS_CTRL_WK_CID,
+	ANT_SELECT_WK_CID,
+	P2P_PS_WK_CID,
+	P2P_PROTO_WK_CID,
+	CHECK_HIQ_WK_CID,/* for softap mode, check hi queue if empty */
+	INTEl_WIDI_WK_CID,
+	C2H_WK_CID,
+	RTP_TIMER_CFG_WK_CID,
+	MAX_WK_CID
+};
+
+enum LPS_CTRL_TYPE {
+	LPS_CTRL_SCAN = 0,
+	LPS_CTRL_JOINBSS = 1,
+	LPS_CTRL_CONNECT = 2,
+	LPS_CTRL_DISCONNECT = 3,
+	LPS_CTRL_SPECIAL_PACKET = 4,
+	LPS_CTRL_LEAVE = 5,
+};
+
+enum RFINTFS {
+	SWSI,
+	HWSI,
+	HWPI,
+};
+
+/*
+Caller Mode: Infra, Ad-HoC(C)
+
+Notes: To enter USB suspend mode
+
+Command Mode
+
+*/
+struct usb_suspend_parm {
+	u32 action;/*  1: sleep, 0:resume */
+};
+
+/*
+Caller Mode: Infra, Ad-HoC
+
+Notes: To join a known BSS.
+
+Command-Event Mode
+
+*/
+
+/*
+Caller Mode: Infra, Ad-Hoc
+
+Notes: To join the specified bss
+
+Command Event Mode
+
+*/
+struct joinbss_parm {
+	struct wlan_bssid_ex network;
+};
+
+/*
+Caller Mode: Infra, Ad-HoC(C)
+
+Notes: To disconnect the current associated BSS
+
+Command Mode
+
+*/
+struct disconnect_parm {
+	u32 deauth_timeout_ms;
+};
+
+/*
+Caller Mode: AP, Ad-HoC(M)
+
+Notes: To create a BSS
+
+Command Mode
+*/
+struct createbss_parm {
+	struct wlan_bssid_ex network;
+};
+
+struct	setopmode_parm {
+	u8	mode;
+	u8	rsvd[3];
+};
+
+/*
+Caller Mode: AP, Ad-HoC, Infra
+
+Notes: To ask RTL8711 performing site-survey
+
+Command-Event Mode
+
+*/
+
+#define RTW_SSID_SCAN_AMOUNT 9 /*  for WEXT_CSCAN_AMOUNT 9 */
+#define RTW_CHANNEL_SCAN_AMOUNT (14+37)
+struct sitesurvey_parm {
+	int scan_mode;	/* active: 1, passive: 0 */
+	u8 ssid_num;
+	u8 ch_num;
+	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
+	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
+};
+
+/*
+Caller Mode: Any
+
+Notes: To set the auth type of RTL8711. open/shared/802.1x
+
+Command Mode
+
+*/
+struct setauth_parm {
+	u8 mode;  /* 0: legacy open, 1: legacy shared 2: 802.1x */
+	u8 _1x;   /* 0: PSK, 1: TLS */
+	u8 rsvd[2];
+};
+
+/*
+Caller Mode: Infra
+
+a. algorithm: wep40, wep104, tkip & aes
+b. keytype: grp key/unicast key
+c. key contents
+
+when shared key ==> keyid is the camid
+when 802.1x ==> keyid [0:1] ==> grp key
+when 802.1x ==> keyid > 2 ==> unicast key
+
+*/
+struct setkey_parm {
+	u8	algorithm;	/* could be none, wep40, TKIP, CCMP, wep104 */
+	u8	keyid;
+	u8	grpkey;		/* 1: this is the grpkey for 802.1x.
+				 * 0: this is the unicast key for 802.1x */
+	u8	set_tx;		/* 1: main tx key for wep. 0: other key. */
+	u8	key[16];	/* this could be 40 or 104 */
+};
+
+/*
+When in AP or Ad-Hoc mode, this is used to
+allocate an sw/hw entry for a newly associated sta.
+
+Command
+
+when shared key ==> algorithm/keyid
+
+*/
+struct set_stakey_parm {
+	u8	addr[ETH_ALEN];
+	u8	algorithm;
+	u8	id;/* currently for erasing cam entry if
+		    * algorithm == _NO_PRIVACY_ */
+	u8	key[16];
+};
+
+struct set_stakey_rsp {
+	u8	addr[ETH_ALEN];
+	u8	keyid;
+	u8	rsvd;
+};
+
+/*
+Caller Ad-Hoc/AP
+
+Command -Rsp(AID == CAMID) mode
+
+This is to force fw to add an sta_data entry per driver's request.
+
+FW will write an cam entry associated with it.
+
+*/
+struct set_assocsta_parm {
+	u8	addr[ETH_ALEN];
+};
+
+struct set_assocsta_rsp {
+	u8	cam_id;
+	u8	rsvd[3];
+};
+
+/*
+	Caller Ad-Hoc/AP
+
+	Command mode
+
+	This is to force fw to del an sta_data entry per driver's request
+
+	FW will invalidate the cam entry associated with it.
+
+*/
+struct del_assocsta_parm {
+	u8	addr[ETH_ALEN];
+};
+
+/*
+Caller Mode: AP/Ad-HoC(M)
+
+Notes: To notify fw that given staid has changed its power state
+
+Command Mode
+
+*/
+struct setstapwrstate_parm {
+	u8	staid;
+	u8	status;
+	u8	hwaddr[6];
+};
+
+/*
+Caller Mode: Any
+
+Notes: To setup the basic rate of RTL8711
+
+Command Mode
+
+*/
+struct	setbasicrate_parm {
+	u8	basicrates[NumRates];
+};
+
+/*
+Caller Mode: Any
+
+Notes: To read the current basic rate
+
+Command-Rsp Mode
+
+*/
+struct getbasicrate_parm {
+	u32 rsvd;
+};
+
+struct getbasicrate_rsp {
+	u8 basicrates[NumRates];
+};
+
+/*
+Caller Mode: Any
+
+Notes: To setup the data rate of RTL8711
+
+Command Mode
+
+*/
+struct setdatarate_parm {
+	u8	mac_id;
+	u8	datarates[NumRates];
+};
+
+/*
+Caller Mode: Any
+
+Notes: To read the current data rate
+
+Command-Rsp Mode
+
+*/
+struct getdatarate_parm {
+	u32 rsvd;
+
+};
+struct getdatarate_rsp {
+	u8 datarates[NumRates];
+};
+
+/*
+Caller Mode: Any
+AP: AP can use the info for the contents of beacon frame
+Infra: STA can use the info when sitesurveying
+Ad-HoC(M): Like AP
+Ad-HoC(C): Like STA
+
+Notes: To set the phy capability of the NIC
+
+Command Mode
+
+*/
+
+struct	setphyinfo_parm {
+	struct regulatory_class class_sets[NUM_REGULATORYS];
+	u8	status;
+};
+
+struct	getphyinfo_parm {
+	u32 rsvd;
+};
+
+struct	getphyinfo_rsp {
+	struct regulatory_class class_sets[NUM_REGULATORYS];
+	u8	status;
+};
+
+/*
+Caller Mode: Any
+
+Notes: To set the channel/modem/band
+This command will be used when channel/modem/band is changed.
+
+Command Mode
+
+*/
+struct	setphy_parm {
+	u8	rfchannel;
+	u8	modem;
+};
+
+/*
+Caller Mode: Any
+
+Notes: To get the current setting of channel/modem/band
+
+Command-Rsp Mode
+
+*/
+struct	getphy_parm {
+	u32 rsvd;
+
+};
+struct	getphy_rsp {
+	u8	rfchannel;
+	u8	modem;
+};
+
+struct readBB_parm {
+	u8	offset;
+};
+struct readBB_rsp {
+	u8	value;
+};
+
+struct readTSSI_parm {
+	u8	offset;
+};
+struct readTSSI_rsp {
+	u8	value;
+};
+
+struct writeBB_parm {
+	u8	offset;
+	u8	value;
+};
+
+struct readRF_parm {
+	u8	offset;
+};
+struct readRF_rsp {
+	u32	value;
+};
+
+struct writeRF_parm {
+	u32	offset;
+	u32	value;
+};
+
+struct getrfintfs_parm {
+	u8	rfintfs;
+};
+
+struct Tx_Beacon_param
+{
+	struct wlan_bssid_ex network;
+};
+
+/*
+	Notes: This command is used for H2C/C2H loopback testing
+
+	mac[0] == 0
+	==> CMD mode, return H2C_SUCCESS.
+	The following condition must be ture under CMD mode
+		mac[1] == mac[4], mac[2] == mac[3], mac[0]=mac[5]= 0;
+		s0 == 0x1234, s1 == 0xabcd, w0 == 0x78563412, w1 == 0x5aa5def7;
+		s2 == (b1 << 8 | b0);
+
+	mac[0] == 1
+	==> CMD_RSP mode, return H2C_SUCCESS_RSP
+
+	The rsp layout shall be:
+	rsp:			parm:
+		mac[0]  =   mac[5];
+		mac[1]  =   mac[4];
+		mac[2]  =   mac[3];
+		mac[3]  =   mac[2];
+		mac[4]  =   mac[1];
+		mac[5]  =   mac[0];
+		s0		=   s1;
+		s1		=   swap16(s0);
+		w0		=	swap32(w1);
+		b0		=	b1
+		s2		=	s0 + s1
+		b1		=	b0
+		w1		=	w0
+
+	mac[0] ==	2
+	==> CMD_EVENT mode, return	H2C_SUCCESS
+	The event layout shall be:
+	event:			parm:
+		mac[0]  =   mac[5];
+		mac[1]  =   mac[4];
+		mac[2]  =   event's seq no, starting from 1 to parm's marc[3]
+		mac[3]  =   mac[2];
+		mac[4]  =   mac[1];
+		mac[5]  =   mac[0];
+		s0		=   swap16(s0) - event.mac[2];
+		s1		=   s1 + event.mac[2];
+		w0		=	swap32(w0);
+		b0		=	b1
+		s2		=	s0 + event.mac[2]
+		b1		=	b0
+		w1		=	swap32(w1) - event.mac[2];
+
+		parm->mac[3] is the total event counts that host requested.
+	event will be the same with the cmd's param.
+*/
+
+/*  CMD param Format for driver extra cmd handler */
+struct drvextra_cmd_parm {
+	int ec_id; /* extra cmd id */
+	int type_size; /*  Can use this field as the type id or command size */
+	unsigned char *pbuf;
+};
+
+/*------------------- Below are used for RF/BB tunning ---------------------*/
+
+struct	setantenna_parm {
+	u8	tx_antset;
+	u8	rx_antset;
+	u8	tx_antenna;
+	u8	rx_antenna;
+};
+
+struct	enrateadaptive_parm {
+	u32	en;
+};
+
+struct settxagctbl_parm {
+	u32	txagc[MAX_RATES_LENGTH];
+};
+
+struct gettxagctbl_parm {
+	u32 rsvd;
+};
+struct gettxagctbl_rsp {
+	u32	txagc[MAX_RATES_LENGTH];
+};
+
+struct setagcctrl_parm {
+	u32	agcctrl;		/*  0: pure hw, 1: fw */
+};
+
+struct setssup_parm	{
+	u32	ss_ForceUp[MAX_RATES_LENGTH];
+};
+
+struct getssup_parm	{
+	u32 rsvd;
+};
+
+struct getssup_rsp	{
+	u8	ss_ForceUp[MAX_RATES_LENGTH];
+};
+
+struct setssdlevel_parm	{
+	u8	ss_DLevel[MAX_RATES_LENGTH];
+};
+
+struct getssdlevel_parm	{
+	u32 rsvd;
+};
+
+struct getssdlevel_rsp	{
+	u8	ss_DLevel[MAX_RATES_LENGTH];
+};
+
+struct setssulevel_parm	{
+	u8	ss_ULevel[MAX_RATES_LENGTH];
+};
+
+struct getssulevel_parm	{
+	u32 rsvd;
+};
+
+struct getssulevel_rsp	{
+	u8	ss_ULevel[MAX_RATES_LENGTH];
+};
+
+struct	setcountjudge_parm {
+	u8	count_judge[MAX_RATES_LENGTH];
+};
+
+struct	getcountjudge_parm {
+	u32 rsvd;
+};
+
+struct	getcountjudge_rsp {
+	u8	count_judge[MAX_RATES_LENGTH];
+};
+
+struct setratable_parm {
+	u8 ss_ForceUp[NumRates];
+	u8 ss_ULevel[NumRates];
+	u8 ss_DLevel[NumRates];
+	u8 count_judge[NumRates];
+};
+
+struct getratable_parm {
+                uint rsvd;
+};
+
+struct getratable_rsp {
+        u8 ss_ForceUp[NumRates];
+        u8 ss_ULevel[NumRates];
+        u8 ss_DLevel[NumRates];
+        u8 count_judge[NumRates];
+};
+
+/* to get TX,RX retry count */
+
+struct gettxretrycnt_parm {
+	unsigned int rsvd;
+};
+
+struct gettxretrycnt_rsp {
+	unsigned long tx_retrycnt;
+};
+
+struct getrxretrycnt_parm {
+	unsigned int rsvd;
+};
+
+struct getrxretrycnt_rsp {
+	unsigned long rx_retrycnt;
+};
+
+/* to get BCNOK,BCNERR count */
+struct getbcnokcnt_parm {
+	unsigned int rsvd;
+};
+
+struct getbcnokcnt_rsp {
+	unsigned long  bcnokcnt;
+};
+
+struct getbcnerrcnt_parm {
+	unsigned int rsvd;
+};
+
+struct getbcnerrcnt_rsp {
+	unsigned long bcnerrcnt;
+};
+
+/*  to get current TX power level */
+struct getcurtxpwrlevel_parm {
+	unsigned int rsvd;
+};
+struct getcurtxpwrlevel_rspi {
+	unsigned short tx_power;
+};
+
+struct setprobereqextraie_parm {
+	unsigned char e_id;
+	unsigned char ie_len;
+	unsigned char ie[0];
+};
+
+struct setassocreqextraie_parm {
+	unsigned char e_id;
+	unsigned char ie_len;
+	unsigned char ie[0];
+};
+
+struct setproberspextraie_parm {
+	unsigned char e_id;
+	unsigned char ie_len;
+	unsigned char ie[0];
+};
+
+struct setassocrspextraie_parm {
+	unsigned char e_id;
+	unsigned char ie_len;
+	unsigned char ie[0];
+};
+
+struct addBaReq_parm {
+	unsigned int tid;
+	u8	addr[ETH_ALEN];
+};
+
+/*H2C Handler index: 46 */
+struct set_ch_parm {
+	u8 ch;
+	u8 bw;
+	u8 ch_offset;
+};
+
+/*H2C Handler index: 59 */
+struct SetChannelPlan_param
+{
+	u8 channel_plan;
+};
+
+/*H2C Handler index: 60 */
+struct LedBlink_param
+{
+	struct LED_871x *pLed;
+};
+
+/*H2C Handler index: 61 */
+struct SetChannelSwitch_param
+{
+	u8 new_ch_no;
+};
+
+/*H2C Handler index: 62 */
+struct TDLSoption_param
+{
+	u8 addr[ETH_ALEN];
+	u8 option;
+};
+
+#define GEN_CMD_CODE(cmd)	cmd ## _CMD_
+
+/*
+
+Result:
+0x00: success
+0x01: success, and check Response.
+0x02: cmd ignored due to duplicated sequcne number
+0x03: cmd dropped due to invalid cmd code
+0x04: reserved.
+
+*/
+
+#define H2C_RSP_OFFSET		512
+
+#define H2C_SUCCESS		0x00
+#define H2C_SUCCESS_RSP		0x01
+#define H2C_DUPLICATED		0x02
+#define H2C_DROPPED		0x03
+#define H2C_PARAMETERS_ERROR	0x04
+#define H2C_REJECTED		0x05
+#define H2C_CMD_OVERFLOW	0x06
+#define H2C_RESERVED		0x07
+
+u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr);
+u8 rtw_setstandby_cmd(struct adapter *padapter, uint action);
+u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
+		      int ssid_num, struct rtw_ieee80211_channel *ch,
+		      int ch_num);
+u8 rtw_createbss_cmd(struct adapter  *padapter);
+u8 rtw_createbss_cmd_ex(struct adapter  *padapter, unsigned char *pbss,
+			       unsigned int sz);
+u8 rtw_setphy_cmd(struct adapter  *padapter, u8 modem, u8 ch);
+u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key);
+u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue);
+u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network* pnetwork);
+u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueue);
+u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra networktype);
+u8 rtw_setdatarate_cmd(struct adapter  *padapter, u8 *rateset);
+u8 rtw_setbasicrate_cmd(struct adapter  *padapter, u8 *rateset);
+u8 rtw_setbbreg_cmd(struct adapter * padapter, u8 offset, u8 val);
+u8 rtw_setrfreg_cmd(struct adapter * padapter, u8 offset, u32 val);
+u8 rtw_getbbreg_cmd(struct adapter * padapter, u8 offset, u8 * pval);
+u8 rtw_getrfreg_cmd(struct adapter * padapter, u8 offset, u8 * pval);
+u8 rtw_setrfintfs_cmd(struct adapter  *padapter, u8 mode);
+u8 rtw_setrttbl_cmd(struct adapter  *padapter, struct setratable_parm *prate_table);
+u8 rtw_getrttbl_cmd(struct adapter  *padapter, struct getratable_rsp *pval);
+
+u8 rtw_gettssi_cmd(struct adapter  *padapter, u8 offset,u8 *pval);
+u8 rtw_setfwdig_cmd(struct adapter*padapter, u8 type);
+u8 rtw_setfwra_cmd(struct adapter*padapter, u8 type);
+
+u8 rtw_addbareq_cmd(struct adapter*padapter, u8 tid, u8 *addr);
+
+u8 rtw_dynamic_chk_wk_cmd(struct adapter *adapter);
+
+u8 rtw_lps_ctrl_wk_cmd(struct adapter*padapter, u8 lps_ctrl_type, u8 enqueue);
+u8 rtw_rpt_timer_cfg_cmd(struct adapter*padapter, u16 minRptTime);
+
+ u8 rtw_antenna_select_cmd(struct adapter*padapter, u8 antenna,u8 enqueue);
+u8 rtw_ps_cmd(struct adapter*padapter);
+
+#ifdef CONFIG_88EU_AP_MODE
+u8 rtw_chk_hi_queue_cmd(struct adapter*padapter);
+#endif
+
+u8 rtw_set_ch_cmd(struct adapter*padapter, u8 ch, u8 bw, u8 ch_offset, u8 enqueue);
+u8 rtw_set_chplan_cmd(struct adapter*padapter, u8 chplan, u8 enqueue);
+u8 rtw_led_blink_cmd(struct adapter*padapter, struct LED_871x * pLed);
+u8 rtw_set_csa_cmd(struct adapter*padapter, u8 new_ch_no);
+u8 rtw_tdls_cmd(struct adapter *padapter, u8 *addr, u8 option);
+
+u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt);
+
+u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf);
+
+void rtw_survey_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd);
+void rtw_disassoc_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd);
+void rtw_joinbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd);
+void rtw_createbss_cmd_callback(struct adapter *adapt, struct cmd_obj *pcmd);
+void rtw_getbbrfreg_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
+void rtw_readtssi_cmdrsp_callback(struct adapter *adapt,  struct cmd_obj *cmd);
+
+void rtw_setstaKey_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
+void rtw_setassocsta_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cm);
+void rtw_getrttbl_cmdrsp_callback(struct adapter *adapt, struct cmd_obj *cmd);
+
+struct _cmd_callback {
+	u32	cmd_code;
+	void (*callback)(struct adapter  *padapter, struct cmd_obj *cmd);
+};
+
+enum rtw_h2c_cmd {
+	GEN_CMD_CODE(_Read_MACREG),	/*0*/
+	GEN_CMD_CODE(_Write_MACREG),
+	GEN_CMD_CODE(_Read_BBREG),
+	GEN_CMD_CODE(_Write_BBREG),
+	GEN_CMD_CODE(_Read_RFREG),
+	GEN_CMD_CODE(_Write_RFREG), /*5*/
+	GEN_CMD_CODE(_Read_EEPROM),
+	GEN_CMD_CODE(_Write_EEPROM),
+	GEN_CMD_CODE(_Read_EFUSE),
+	GEN_CMD_CODE(_Write_EFUSE),
+
+	GEN_CMD_CODE(_Read_CAM),	/*10*/
+	GEN_CMD_CODE(_Write_CAM),
+	GEN_CMD_CODE(_setBCNITV),
+	GEN_CMD_CODE(_setMBIDCFG),
+	GEN_CMD_CODE(_JoinBss),   /*14*/
+	GEN_CMD_CODE(_DisConnect), /*15*/
+	GEN_CMD_CODE(_CreateBss),
+	GEN_CMD_CODE(_SetOpMode),
+	GEN_CMD_CODE(_SiteSurvey),  /*18*/
+	GEN_CMD_CODE(_SetAuth),
+
+	GEN_CMD_CODE(_SetKey),	/*20*/
+	GEN_CMD_CODE(_SetStaKey),
+	GEN_CMD_CODE(_SetAssocSta),
+	GEN_CMD_CODE(_DelAssocSta),
+	GEN_CMD_CODE(_SetStaPwrState),
+	GEN_CMD_CODE(_SetBasicRate), /*25*/
+	GEN_CMD_CODE(_GetBasicRate),
+	GEN_CMD_CODE(_SetDataRate),
+	GEN_CMD_CODE(_GetDataRate),
+	GEN_CMD_CODE(_SetPhyInfo),
+
+	GEN_CMD_CODE(_GetPhyInfo),	/*30*/
+	GEN_CMD_CODE(_SetPhy),
+	GEN_CMD_CODE(_GetPhy),
+	GEN_CMD_CODE(_readRssi),
+	GEN_CMD_CODE(_readGain),
+	GEN_CMD_CODE(_SetAtim), /*35*/
+	GEN_CMD_CODE(_SetPwrMode),
+	GEN_CMD_CODE(_JoinbssRpt),
+	GEN_CMD_CODE(_SetRaTable),
+	GEN_CMD_CODE(_GetRaTable),
+
+	GEN_CMD_CODE(_GetCCXReport), /*40*/
+	GEN_CMD_CODE(_GetDTMReport),
+	GEN_CMD_CODE(_GetTXRateStatistics),
+	GEN_CMD_CODE(_SetUsbSuspend),
+	GEN_CMD_CODE(_SetH2cLbk),
+	GEN_CMD_CODE(_AddBAReq), /*45*/
+	GEN_CMD_CODE(_SetChannel), /*46*/
+	GEN_CMD_CODE(_SetTxPower),
+	GEN_CMD_CODE(_SwitchAntenna),
+	GEN_CMD_CODE(_SetCrystalCap),
+	GEN_CMD_CODE(_SetSingleCarrierTx), /*50*/
+
+	GEN_CMD_CODE(_SetSingleToneTx),/*51*/
+	GEN_CMD_CODE(_SetCarrierSuppressionTx),
+	GEN_CMD_CODE(_SetContinuousTx),
+	GEN_CMD_CODE(_SwitchBandwidth), /*54*/
+	GEN_CMD_CODE(_TX_Beacon), /*55*/
+
+	GEN_CMD_CODE(_Set_MLME_EVT), /*56*/
+	GEN_CMD_CODE(_Set_Drv_Extra), /*57*/
+	GEN_CMD_CODE(_Set_H2C_MSG), /*58*/
+
+	GEN_CMD_CODE(_SetChannelPlan), /*59*/
+	GEN_CMD_CODE(_LedBlink), /*60*/
+
+	GEN_CMD_CODE(_SetChannelSwitch), /*61*/
+	GEN_CMD_CODE(_TDLS), /*62*/
+
+	MAX_H2CCMD
+};
+
+#define _GetBBReg_CMD_		_Read_BBREG_CMD_
+#define _SetBBReg_CMD_		_Write_BBREG_CMD_
+#define _GetRFReg_CMD_		_Read_RFREG_CMD_
+#define _SetRFReg_CMD_		_Write_RFREG_CMD_
+
+#ifdef _RTW_CMD_C_
+static struct _cmd_callback	rtw_cmd_callback[] =
+{
+	{GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
+	{GEN_CMD_CODE(_Write_MACREG), NULL},
+	{GEN_CMD_CODE(_Read_BBREG), &rtw_getbbrfreg_cmdrsp_callback},
+	{GEN_CMD_CODE(_Write_BBREG), NULL},
+	{GEN_CMD_CODE(_Read_RFREG), &rtw_getbbrfreg_cmdrsp_callback},
+	{GEN_CMD_CODE(_Write_RFREG), NULL}, /*5*/
+	{GEN_CMD_CODE(_Read_EEPROM), NULL},
+	{GEN_CMD_CODE(_Write_EEPROM), NULL},
+	{GEN_CMD_CODE(_Read_EFUSE), NULL},
+	{GEN_CMD_CODE(_Write_EFUSE), NULL},
+
+	{GEN_CMD_CODE(_Read_CAM),	NULL},	/*10*/
+	{GEN_CMD_CODE(_Write_CAM),	 NULL},
+	{GEN_CMD_CODE(_setBCNITV), NULL},
+	{GEN_CMD_CODE(_setMBIDCFG), NULL},
+	{GEN_CMD_CODE(_JoinBss), &rtw_joinbss_cmd_callback},  /*14*/
+	{GEN_CMD_CODE(_DisConnect), &rtw_disassoc_cmd_callback}, /*15*/
+	{GEN_CMD_CODE(_CreateBss), &rtw_createbss_cmd_callback},
+	{GEN_CMD_CODE(_SetOpMode), NULL},
+	{GEN_CMD_CODE(_SiteSurvey), &rtw_survey_cmd_callback}, /*18*/
+	{GEN_CMD_CODE(_SetAuth), NULL},
+
+	{GEN_CMD_CODE(_SetKey), NULL},	/*20*/
+	{GEN_CMD_CODE(_SetStaKey), &rtw_setstaKey_cmdrsp_callback},
+	{GEN_CMD_CODE(_SetAssocSta), &rtw_setassocsta_cmdrsp_callback},
+	{GEN_CMD_CODE(_DelAssocSta), NULL},
+	{GEN_CMD_CODE(_SetStaPwrState), NULL},
+	{GEN_CMD_CODE(_SetBasicRate), NULL}, /*25*/
+	{GEN_CMD_CODE(_GetBasicRate), NULL},
+	{GEN_CMD_CODE(_SetDataRate), NULL},
+	{GEN_CMD_CODE(_GetDataRate), NULL},
+	{GEN_CMD_CODE(_SetPhyInfo), NULL},
+
+	{GEN_CMD_CODE(_GetPhyInfo), NULL}, /*30*/
+	{GEN_CMD_CODE(_SetPhy), NULL},
+	{GEN_CMD_CODE(_GetPhy), NULL},
+	{GEN_CMD_CODE(_readRssi), NULL},
+	{GEN_CMD_CODE(_readGain), NULL},
+	{GEN_CMD_CODE(_SetAtim), NULL}, /*35*/
+	{GEN_CMD_CODE(_SetPwrMode), NULL},
+	{GEN_CMD_CODE(_JoinbssRpt), NULL},
+	{GEN_CMD_CODE(_SetRaTable), NULL},
+	{GEN_CMD_CODE(_GetRaTable), NULL},
+
+	{GEN_CMD_CODE(_GetCCXReport), NULL}, /*40*/
+	{GEN_CMD_CODE(_GetDTMReport),	NULL},
+	{GEN_CMD_CODE(_GetTXRateStatistics), NULL},
+	{GEN_CMD_CODE(_SetUsbSuspend), NULL},
+	{GEN_CMD_CODE(_SetH2cLbk), NULL},
+	{GEN_CMD_CODE(_AddBAReq), NULL}, /*45*/
+	{GEN_CMD_CODE(_SetChannel), NULL},		/*46*/
+	{GEN_CMD_CODE(_SetTxPower), NULL},
+	{GEN_CMD_CODE(_SwitchAntenna), NULL},
+	{GEN_CMD_CODE(_SetCrystalCap), NULL},
+	{GEN_CMD_CODE(_SetSingleCarrierTx), NULL},	/*50*/
+
+	{GEN_CMD_CODE(_SetSingleToneTx), NULL}, /*51*/
+	{GEN_CMD_CODE(_SetCarrierSuppressionTx), NULL},
+	{GEN_CMD_CODE(_SetContinuousTx), NULL},
+	{GEN_CMD_CODE(_SwitchBandwidth), NULL},		/*54*/
+	{GEN_CMD_CODE(_TX_Beacon), NULL},/*55*/
+
+	{GEN_CMD_CODE(_Set_MLME_EVT), NULL},/*56*/
+	{GEN_CMD_CODE(_Set_Drv_Extra), NULL},/*57*/
+	{GEN_CMD_CODE(_Set_H2C_MSG), NULL},/*58*/
+	{GEN_CMD_CODE(_SetChannelPlan), NULL},/*59*/
+	{GEN_CMD_CODE(_LedBlink), NULL},/*60*/
+
+	{GEN_CMD_CODE(_SetChannelSwitch), NULL},/*61*/
+	{GEN_CMD_CODE(_TDLS), NULL},/*62*/
+};
+#endif
+
+#endif /*  _CMD_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
new file mode 100644
index 000000000000..d94639a8dc63
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -0,0 +1,274 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_DEBUG_H__
+#define __RTW_DEBUG_H__
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define _drv_always_			1
+#define _drv_emerg_			2
+#define _drv_alert_			3
+#define _drv_crit_			4
+#define _drv_err_			5
+#define	_drv_warning_			6
+#define _drv_notice_			7
+#define _drv_info_			8
+#define	_drv_debug_			9
+
+#define _module_rtl871x_xmit_c_		BIT(0)
+#define _module_xmit_osdep_c_		BIT(1)
+#define _module_rtl871x_recv_c_		BIT(2)
+#define _module_recv_osdep_c_		BIT(3)
+#define _module_rtl871x_mlme_c_		BIT(4)
+#define _module_mlme_osdep_c_		BIT(5)
+#define _module_rtl871x_sta_mgt_c_	BIT(6)
+#define _module_rtl871x_cmd_c_		BIT(7)
+#define _module_cmd_osdep_c_		BIT(8)
+#define _module_rtl871x_io_c_		BIT(9)
+#define _module_io_osdep_c_		BIT(10)
+#define _module_os_intfs_c_		BIT(11)
+#define _module_rtl871x_security_c_	BIT(12)
+#define _module_rtl871x_eeprom_c_	BIT(13)
+#define _module_hal_init_c_		BIT(14)
+#define _module_hci_hal_init_c_		BIT(15)
+#define _module_rtl871x_ioctl_c_	BIT(16)
+#define _module_rtl871x_ioctl_set_c_	BIT(17)
+#define _module_rtl871x_ioctl_query_c_	BIT(18)
+#define _module_rtl871x_pwrctrl_c_	BIT(19)
+#define _module_hci_intfs_c_		BIT(20)
+#define _module_hci_ops_c_		BIT(21)
+#define _module_osdep_service_c_	BIT(22)
+#define _module_mp_			BIT(23)
+#define _module_hci_ops_os_c_		BIT(24)
+#define _module_rtl871x_ioctl_os_c	BIT(25)
+#define _module_rtl8712_cmd_c_		BIT(26)
+#define	_module_rtl8192c_xmit_c_	BIT(27)
+#define _module_hal_xmit_c_		BIT(28)
+#define _module_efuse_			BIT(29)
+#define _module_rtl8712_recv_c_		BIT(30)
+#define _module_rtl8712_led_c_		BIT(31)
+
+#define DRIVER_PREFIX	"R8188EU: "
+
+extern u32 GlobalDebugLevel;
+
+#define DBG_88E_LEVEL(_level, fmt, arg...)				\
+	do {								\
+		if (_level <= GlobalDebugLevel)				\
+			pr_info(DRIVER_PREFIX"INFO " fmt, ##arg);	\
+	} while (0)
+
+#define DBG_88E(...)							\
+	do {								\
+		if (_drv_err_ <= GlobalDebugLevel)			\
+			pr_info(DRIVER_PREFIX __VA_ARGS__);		\
+	} while (0)
+
+#define MSG_88E(...)							\
+	do {								\
+		if (_drv_err_ <= GlobalDebugLevel)			\
+			pr_info(DRIVER_PREFIX __VA_ARGS__);			\
+	} while (0)
+
+#define RT_TRACE(_comp, _level, fmt)					\
+	do {								\
+		if (_level <= GlobalDebugLevel) {			\
+			pr_info("%s [0x%08x,%d]", DRIVER_PREFIX,	\
+				 (unsigned int)_comp, _level);		\
+			pr_info fmt;					\
+		}							\
+	} while (0)
+
+#define RT_PRINT_DATA(_comp, _level, _titlestring, _hexdata, _hexdatalen)\
+	do {								\
+		if (_level <= GlobalDebugLevel) {			\
+			int __i;					\
+			u8	*ptr = (u8 *)_hexdata;			\
+			pr_info("%s", DRIVER_PREFIX);			\
+			pr_info(_titlestring);				\
+			for (__i = 0; __i < (int)_hexdatalen; __i++ ) {	\
+				pr_info("%02X%s", ptr[__i],		\
+					 (((__i + 1) % 4) == 0) ?	\
+					 "  " : " ");	\
+				if (((__i + 1) % 16) == 0)		\
+					printk("\n");			\
+			}						\
+			printk("\n");					\
+		}							\
+	} while (0)
+
+int proc_get_drv_version(char *page, char **start,
+			 off_t offset, int count,
+			 int *eof, void *data);
+
+int proc_get_write_reg(char *page, char **start,
+		       off_t offset, int count,
+		       int *eof, void *data);
+
+int proc_set_write_reg(struct file *file, const char __user *buffer,
+		       unsigned long count, void *data);
+int proc_get_read_reg(char *page, char **start,
+		      off_t offset, int count,
+		      int *eof, void *data);
+
+int proc_set_read_reg(struct file *file, const char __user *buffer,
+		      unsigned long count, void *data);
+
+int proc_get_fwstate(char *page, char **start,
+		     off_t offset, int count,
+		     int *eof, void *data);
+int proc_get_sec_info(char *page, char **start,
+		      off_t offset, int count,
+		      int *eof, void *data);
+int proc_get_mlmext_state(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_qos_option(char *page, char **start,
+			off_t offset, int count,
+			int *eof, void *data);
+int proc_get_ht_option(char *page, char **start,
+		       off_t offset, int count,
+		       int *eof, void *data);
+int proc_get_rf_info(char *page, char **start,
+		     off_t offset, int count,
+		     int *eof, void *data);
+int proc_get_ap_info(char *page, char **start,
+		     off_t offset, int count,
+		     int *eof, void *data);
+
+int proc_get_adapter_state(char *page, char **start,
+			   off_t offset, int count,
+			   int *eof, void *data);
+
+int proc_get_trx_info(char *page, char **start,
+		      off_t offset, int count,
+		      int *eof, void *data);
+
+int proc_get_mac_reg_dump1(char *page, char **start,
+			   off_t offset, int count,
+			   int *eof, void *data);
+
+int proc_get_mac_reg_dump2(char *page, char **start,
+			   off_t offset, int count,
+			   int *eof, void *data);
+
+int proc_get_mac_reg_dump3(char *page, char **start,
+			   off_t offset, int count,
+			   int *eof, void *data);
+
+int proc_get_bb_reg_dump1(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_bb_reg_dump2(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_bb_reg_dump3(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_rf_reg_dump1(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_rf_reg_dump2(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_rf_reg_dump3(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_rf_reg_dump4(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+#ifdef CONFIG_88EU_AP_MODE
+
+int proc_get_all_sta_info(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+#endif
+
+int proc_get_best_channel(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_get_rx_signal(char *page, char **start,
+		       off_t offset, int count,
+		       int *eof, void *data);
+
+int proc_set_rx_signal(struct file *file, const char __user *buffer,
+		       unsigned long count, void *data);
+
+int proc_get_ht_enable(char *page, char **start,
+		       off_t offset, int count,
+		       int *eof, void *data);
+
+int proc_set_ht_enable(struct file *file, const char __user *buffer,
+		       unsigned long count, void *data);
+
+int proc_get_cbw40_enable(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_set_cbw40_enable(struct file *file, const char __user *buffer,
+			  unsigned long count, void *data);
+
+int proc_get_ampdu_enable(char *page, char **start,
+			  off_t offset, int count,
+			  int *eof, void *data);
+
+int proc_set_ampdu_enable(struct file *file, const char __user *buffer,
+			  unsigned long count, void *data);
+
+int proc_get_rx_stbc(char *page, char **start,
+		     off_t offset, int count,
+		     int *eof, void *data);
+
+int proc_set_rx_stbc(struct file *file, const char __user *buffer,
+		     unsigned long count, void *data);
+
+int proc_get_two_path_rssi(char *page, char **start,
+			   off_t offset, int count,
+			   int *eof, void *data);
+
+int proc_get_rssi_disp(char *page, char **start,
+		       off_t offset, int count,
+		       int *eof, void *data);
+
+int proc_set_rssi_disp(struct file *file, const char __user *buffer,
+		       unsigned long count, void *data);
+
+#ifdef CONFIG_BT_COEXIST
+int proc_get_btcoex_dbg(char *page, char **start,
+			off_t offset, int count,
+			int *eof, void *data);
+
+int proc_set_btcoex_dbg(struct file *file, const char *buffer,
+			signed long count, void *data);
+
+#endif /* CONFIG_BT_COEXIST */
+
+#endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
new file mode 100644
index 000000000000..0b27eb7325c5
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -0,0 +1,130 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_EEPROM_H__
+#define __RTW_EEPROM_H__
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define	RTL8712_EEPROM_ID		0x8712
+
+#define	HWSET_MAX_SIZE_512		512
+#define	EEPROM_MAX_SIZE			HWSET_MAX_SIZE_512
+
+#define	CLOCK_RATE			50	/* 100us */
+
+/*  EEPROM opcodes */
+#define EEPROM_READ_OPCODE		06
+#define EEPROM_WRITE_OPCODE		05
+#define EEPROM_ERASE_OPCODE		07
+#define EEPROM_EWEN_OPCODE		19      /*  Erase/write enable */
+#define EEPROM_EWDS_OPCODE		16      /*  Erase/write disable */
+
+/* Country codes */
+#define USA				0x555320
+#define EUROPE				0x1 /* temp, should be provided later */
+#define JAPAN				0x2 /* temp, should be provided later */
+
+#define	EEPROM_CID_DEFAULT		0x0
+#define	EEPROM_CID_ALPHA		0x1
+#define	EEPROM_CID_Senao		0x3
+#define	EEPROM_CID_NetCore		0x5
+#define	EEPROM_CID_CAMEO		0X8
+#define	EEPROM_CID_SITECOM		0x9
+#define	EEPROM_CID_COREGA		0xB
+#define	EEPROM_CID_EDIMAX_BELK		0xC
+#define	EEPROM_CID_SERCOMM_BELK		0xE
+#define	EEPROM_CID_CAMEO1		0xF
+#define	EEPROM_CID_WNC_COREGA		0x12
+#define	EEPROM_CID_CLEVO		0x13
+#define	EEPROM_CID_WHQL			0xFE
+
+/*  Customer ID, note that: */
+/*  This variable is initiailzed through EEPROM or registry, */
+/*  however, its definition may be different with that in EEPROM for */
+/*  EEPROM size consideration. So, we have to perform proper translation
+ *  between them. */
+/*  Besides, CustomerID of registry has precedence of that of EEPROM. */
+/*  defined below. 060703, by rcnjko. */
+enum RT_CUSTOMER_ID {
+	RT_CID_DEFAULT = 0,
+	RT_CID_8187_ALPHA0 = 1,
+	RT_CID_8187_SERCOMM_PS = 2,
+	RT_CID_8187_HW_LED = 3,
+	RT_CID_8187_NETGEAR = 4,
+	RT_CID_WHQL = 5,
+	RT_CID_819x_CAMEO  = 6,
+	RT_CID_819x_RUNTOP = 7,
+	RT_CID_819x_Senao = 8,
+	RT_CID_TOSHIBA = 9,	/*  Merge by Jacken, 2008/01/31. */
+	RT_CID_819x_Netcore = 10,
+	RT_CID_Nettronix = 11,
+	RT_CID_DLINK = 12,
+	RT_CID_PRONET = 13,
+	RT_CID_COREGA = 14,
+	RT_CID_CHINA_MOBILE = 15,
+	RT_CID_819x_ALPHA = 16,
+	RT_CID_819x_Sitecom = 17,
+	RT_CID_CCX = 18, /*  It's set under CCX logo test and isn't demanded
+			  * for CCX functions, but for test behavior like retry
+			  * limit and tx report. By Bruce, 2009-02-17. */
+	RT_CID_819x_Lenovo = 19,
+	RT_CID_819x_QMI = 20,
+	RT_CID_819x_Edimax_Belkin = 21,
+	RT_CID_819x_Sercomm_Belkin = 22,
+	RT_CID_819x_CAMEO1 = 23,
+	RT_CID_819x_MSI = 24,
+	RT_CID_819x_Acer = 25,
+	RT_CID_819x_AzWave_ASUS = 26,
+	RT_CID_819x_AzWave = 27, /*  For AzWave in PCIe,i
+				  * The ID is AzWave use and not only Asus */
+	RT_CID_819x_HP = 28,
+	RT_CID_819x_WNC_COREGA = 29,
+	RT_CID_819x_Arcadyan_Belkin = 30,
+	RT_CID_819x_SAMSUNG = 31,
+	RT_CID_819x_CLEVO = 32,
+	RT_CID_819x_DELL = 33,
+	RT_CID_819x_PRONETS = 34,
+	RT_CID_819x_Edimax_ASUS = 35,
+	RT_CID_819x_CAMEO_NETGEAR = 36,
+	RT_CID_PLANEX = 37,
+	RT_CID_CC_C = 38,
+	RT_CID_819x_Xavi = 39,
+	RT_CID_819x_FUNAI_TV = 40,
+	RT_CID_819x_ALPHA_WD=41,
+};
+
+struct eeprom_priv {
+	u8		bautoload_fail_flag;
+	u8		bloadfile_fail_flag;
+	u8		bloadmac_fail_flag;
+	u8		mac_addr[6];	/* PermanentAddress */
+	u16		channel_plan;
+	u8		EepromOrEfuse;
+	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
+};
+
+void eeprom_write16(struct adapter *padapter, u16 reg, u16 data);
+u16 eeprom_read16(struct adapter *padapter, u16 reg);
+void read_eeprom_content(struct adapter *padapter);
+void eeprom_read_sz(struct adapter *adapt, u16 reg, u8 *data, u32 sz);
+void read_eeprom_content_by_attrib(struct adapter *padapter);
+
+#endif  /* __RTL871X_EEPROM_H__ */
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
new file mode 100644
index 000000000000..cee6b5e8b070
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -0,0 +1,150 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_EFUSE_H__
+#define __RTW_EFUSE_H__
+
+#include <osdep_service.h>
+
+#define	EFUSE_ERROE_HANDLE		1
+
+#define	PG_STATE_HEADER			0x01
+#define	PG_STATE_WORD_0		0x02
+#define	PG_STATE_WORD_1		0x04
+#define	PG_STATE_WORD_2		0x08
+#define	PG_STATE_WORD_3		0x10
+#define	PG_STATE_DATA			0x20
+
+#define	PG_SWBYTE_H			0x01
+#define	PG_SWBYTE_L			0x02
+
+#define	PGPKT_DATA_SIZE		8
+
+#define	EFUSE_WIFI				0
+#define	EFUSE_BT				1
+
+enum _EFUSE_DEF_TYPE {
+	TYPE_EFUSE_MAX_SECTION				= 0,
+	TYPE_EFUSE_REAL_CONTENT_LEN			= 1,
+	TYPE_AVAILABLE_EFUSE_BYTES_BANK		= 2,
+	TYPE_AVAILABLE_EFUSE_BYTES_TOTAL	= 3,
+	TYPE_EFUSE_MAP_LEN					= 4,
+	TYPE_EFUSE_PROTECT_BYTES_BANK		= 5,
+	TYPE_EFUSE_CONTENT_LEN_BANK			= 6,
+};
+
+/* E-Fuse */
+#define EFUSE_MAP_SIZE      512
+#define EFUSE_MAX_SIZE      256
+/* end of E-Fuse */
+
+#define		EFUSE_MAX_MAP_LEN		512
+#define		EFUSE_MAX_HW_SIZE		512
+#define		EFUSE_MAX_SECTION_BASE	16
+
+#define EXT_HEADER(header) ((header & 0x1F) == 0x0F)
+#define ALL_WORDS_DISABLED(wde)	((wde & 0x0F) == 0x0F)
+#define GET_HDR_OFFSET_2_0(header) ((header & 0xE0) >> 5)
+
+#define		EFUSE_REPEAT_THRESHOLD_			3
+
+/*	The following is for BT Efuse definition */
+#define		EFUSE_BT_MAX_MAP_LEN		1024
+#define		EFUSE_MAX_BANK			4
+#define		EFUSE_MAX_BT_BANK		(EFUSE_MAX_BANK-1)
+/*--------------------------Define Parameters-------------------------------*/
+#define		EFUSE_MAX_WORD_UNIT			4
+
+/*------------------------------Define structure----------------------------*/
+struct pgpkt {
+	u8 offset;
+	u8 word_en;
+	u8 data[8];
+	u8 word_cnts;
+};
+
+/*------------------------------Define structure----------------------------*/
+struct efuse_hal {
+	u8 fakeEfuseBank;
+	u32	fakeEfuseUsedBytes;
+	u8 fakeEfuseContent[EFUSE_MAX_HW_SIZE];
+	u8 fakeEfuseInitMap[EFUSE_MAX_MAP_LEN];
+	u8 fakeEfuseModifiedMap[EFUSE_MAX_MAP_LEN];
+
+	u16 BTEfuseUsedBytes;
+	u8 BTEfuseUsedPercentage;
+	u8 BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
+	u8 BTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN];
+	u8 BTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN];
+
+	u16 fakeBTEfuseUsedBytes;
+	u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
+	u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN];
+	u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN];
+};
+
+/*------------------------Export global variable----------------------------*/
+extern u8 fakeEfuseBank;
+extern u32 fakeEfuseUsedBytes;
+extern u8 fakeEfuseContent[];
+extern u8 fakeEfuseInitMap[];
+extern u8 fakeEfuseModifiedMap[];
+
+extern u32 BTEfuseUsedBytes;
+extern u8 BTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
+extern u8 BTEfuseInitMap[];
+extern u8 BTEfuseModifiedMap[];
+
+extern u32 fakeBTEfuseUsedBytes;
+extern u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
+extern u8 fakeBTEfuseInitMap[];
+extern u8 fakeBTEfuseModifiedMap[];
+/*------------------------Export global variable----------------------------*/
+
+u8 efuse_GetCurrentSize(struct adapter *adapter, u16 *size);
+u16 efuse_GetMaxSize(struct adapter *adapter);
+u8 rtw_efuse_access(struct adapter *adapter, u8 read, u16 start_addr,
+		    u16 cnts, u8 *data);
+u8 rtw_efuse_map_read(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
+u8 rtw_efuse_map_write(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
+u8 rtw_BT_efuse_map_read(struct adapter *adapter, u16 addr,
+			 u16 cnts, u8 *data);
+u8 rtw_BT_efuse_map_write(struct adapter *adapter, u16 addr,
+			  u16 cnts, u8 *data);
+u16 Efuse_GetCurrentSize(struct adapter *adapter, u8 efusetype, bool test);
+u8 Efuse_CalculateWordCnts(u8 word_en);
+void ReadEFuseByte(struct adapter *adapter, u16 _offset, u8 *pbuf, bool test);
+void EFUSE_GetEfuseDefinition(struct adapter *adapt, u8 type, u8 type1,
+			      void *out, bool bPseudoTest);
+u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
+u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
+
+void Efuse_PowerSwitch(struct adapter *adapt,u8 bWrite,u8  PwrState);
+int Efuse_PgPacketRead(struct adapter *adapt, u8 offset, u8 *data, bool test);
+int Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data,
+			bool test);
+void efuse_WordEnableDataRead(u8 word_en, u8 *sourdata, u8 *targetdata);
+u8 Efuse_WordEnableDataWrite(struct adapter *adapter, u16 efuse_addr,
+			     u8 word_en, u8 *data, bool test);
+
+u8 EFUSE_Read1Byte(struct adapter *adapter, u16 address);
+void EFUSE_ShadowMapUpdate(struct adapter *adapter, u8 efusetype, bool test);
+void EFUSE_ShadowRead(struct adapter *adapt, u8 type, u16 offset, u32 *val);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_event.h b/drivers/staging/r8188eu/include/rtw_event.h
new file mode 100644
index 000000000000..f7004d6a3bbb
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_event.h
@@ -0,0 +1,113 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_EVENT_H_
+#define _RTW_EVENT_H_
+
+#include <osdep_service.h>
+
+#include <wlan_bssdef.h>
+#include <linux/semaphore.h>
+#include <linux/sem.h>
+
+/*
+Used to report a bss has been scanned
+*/
+struct survey_event	{
+	struct wlan_bssid_ex bss;
+};
+
+/*
+Used to report that the requested site survey has been done.
+
+bss_cnt indicates the number of bss that has been reported.
+
+*/
+struct surveydone_event {
+	unsigned int	bss_cnt;
+
+};
+
+/*
+Used to report the link result of joinning the given bss
+
+join_res:
+-1: authentication fail
+-2: association fail
+> 0: TID
+
+*/
+struct joinbss_event {
+	struct	wlan_network	network;
+};
+
+/*
+Used to report a given STA has joinned the created BSS.
+It is used in AP/Ad-HoC(M) mode.
+*/
+
+struct stassoc_event {
+	unsigned char macaddr[6];
+	unsigned char rsvd[2];
+	int    cam_id;
+};
+
+struct stadel_event {
+	unsigned char macaddr[6];
+	unsigned char rsvd[2]; /* for reason */
+	int mac_id;
+};
+
+struct addba_event {
+	unsigned int tid;
+};
+
+#define GEN_EVT_CODE(event)	event ## _EVT_
+
+struct fwevent {
+	u32	parmsize;
+	void (*event_callback)(struct adapter *dev, u8 *pbuf);
+};
+
+#define C2HEVENT_SZ			32
+
+struct event_node {
+	unsigned char *node;
+	unsigned char evt_code;
+	unsigned short evt_sz;
+	int	*caller_ff_tail;
+	int	caller_ff_sz;
+};
+
+struct c2hevent_queue {
+	int	head;
+	int	tail;
+	struct	event_node	nodes[C2HEVENT_SZ];
+	unsigned char	seq;
+};
+
+#define NETWORK_QUEUE_SZ	4
+
+struct network_queue {
+	int	head;
+	int	tail;
+	struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
+};
+
+#endif /*  _WLANEVENT_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_ht.h b/drivers/staging/r8188eu/include/rtw_ht.h
new file mode 100644
index 000000000000..80154224af92
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_ht.h
@@ -0,0 +1,44 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_HT_H_
+#define _RTW_HT_H_
+
+#include <osdep_service.h>
+#include "wifi.h"
+
+struct ht_priv {
+	u32	ht_option;
+	u32	ampdu_enable;/* for enable Tx A-MPDU */
+	u32	tx_amsdu_enable;/* for enable Tx A-MSDU */
+	u32	tx_amdsu_maxlen; /*  1: 8k, 0:4k ; default:8k, for tx */
+	u32	rx_ampdu_maxlen; /* for rx reordering ctrl win_sz,
+				  * updated when join_callback. */
+	u8	bwmode;/*  */
+	u8	ch_offset;/* PRIME_CHNL_OFFSET */
+	u8	sgi;/* short GI */
+
+	/* for processing Tx A-MPDU */
+	u8	agg_enable_bitmap;
+	u8	candidate_tid_bitmap;
+
+	struct ieee80211_ht_cap ht_cap;
+};
+
+#endif	/* _RTL871X_HT_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
new file mode 100644
index 000000000000..d7dee537c252
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -0,0 +1,387 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+
+#ifndef _RTW_IO_H_
+#define _RTW_IO_H_
+
+#include <osdep_service.h>
+#include <osdep_intf.h>
+
+#include <asm/byteorder.h>
+#include <linux/semaphore.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+
+#define rtw_usb_buffer_alloc(dev, size, dma)				\
+	usb_alloc_coherent((dev), (size), (in_interrupt() ?		\
+			   GFP_ATOMIC : GFP_KERNEL), (dma))
+#define rtw_usb_buffer_free(dev, size, addr, dma)			\
+	usb_free_coherent((dev), (size), (addr), (dma))
+
+#define NUM_IOREQ		8
+
+#define MAX_PROT_SZ	(64-16)
+
+#define _IOREADY		0
+#define _IO_WAIT_COMPLETE	1
+#define _IO_WAIT_RSP		2
+
+/*  IO COMMAND TYPE */
+#define _IOSZ_MASK_		(0x7F)
+#define _IO_WRITE_		BIT(7)
+#define _IO_FIXED_		BIT(8)
+#define _IO_BURST_		BIT(9)
+#define _IO_BYTE_		BIT(10)
+#define _IO_HW_			BIT(11)
+#define _IO_WORD_		BIT(12)
+#define _IO_SYNC_		BIT(13)
+#define _IO_CMDMASK_		(0x1F80)
+
+/*
+	For prompt mode accessing, caller shall free io_req
+	Otherwise, io_handler will free io_req
+*/
+
+/*  IO STATUS TYPE */
+#define _IO_ERR_		BIT(2)
+#define _IO_SUCCESS_		BIT(1)
+#define _IO_DONE_		BIT(0)
+
+#define IO_RD32			(_IO_SYNC_ | _IO_WORD_)
+#define IO_RD16			(_IO_SYNC_ | _IO_HW_)
+#define IO_RD8			(_IO_SYNC_ | _IO_BYTE_)
+
+#define IO_RD32_ASYNC		(_IO_WORD_)
+#define IO_RD16_ASYNC		(_IO_HW_)
+#define IO_RD8_ASYNC		(_IO_BYTE_)
+
+#define IO_WR32			(_IO_WRITE_ | _IO_SYNC_ | _IO_WORD_)
+#define IO_WR16			(_IO_WRITE_ | _IO_SYNC_ | _IO_HW_)
+#define IO_WR8			(_IO_WRITE_ | _IO_SYNC_ | _IO_BYTE_)
+
+#define IO_WR32_ASYNC		(_IO_WRITE_ | _IO_WORD_)
+#define IO_WR16_ASYNC		(_IO_WRITE_ | _IO_HW_)
+#define IO_WR8_ASYNC		(_IO_WRITE_ | _IO_BYTE_)
+
+/*
+	Only Sync. burst accessing is provided.
+*/
+
+#define IO_WR_BURST(x)						\
+	(_IO_WRITE_ | _IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
+#define IO_RD_BURST(x)						\
+	(_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
+
+/* below is for the intf_option bit defition... */
+
+#define _INTF_ASYNC_	BIT(0)	/* support async io */
+
+struct intf_priv;
+struct intf_hdl;
+struct io_queue;
+
+struct _io_ops {
+	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
+	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
+	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
+	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
+	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
+	int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
+	int (*_writeN)(struct intf_hdl *pintfhdl, u32 addr, u32 length,
+		       u8 *pdata);
+	int (*_write8_async)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
+	int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
+	int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
+	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
+			  u8 *pmem);
+	void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
+			   u8 *pmem);
+	void (*_sync_irp_protocol_rw)(struct io_queue *pio_q);
+	u32 (*_read_interrupt)(struct intf_hdl *pintfhdl, u32 addr);
+	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
+			  u8 *pmem);
+	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
+			   u8 *pmem);
+	u32 (*_write_scsi)(struct intf_hdl *pintfhdl,u32 cnt, u8 *pmem);
+	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
+	void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
+};
+
+struct io_req {
+	struct list_head list;
+	u32	addr;
+	u32	val;
+	u32	command;
+	u32	status;
+	u8	*pbuf;
+	struct semaphore sema;
+
+	void (*_async_io_callback)(struct adapter *padater,
+				   struct io_req *pio_req, u8 *cnxt);
+	u8 *cnxt;
+};
+
+struct	intf_hdl {
+	struct adapter *padapter;
+	struct dvobj_priv *pintf_dev;
+	struct _io_ops	io_ops;
+};
+
+struct reg_protocol_rd {
+#ifdef __LITTLE_ENDIAN
+	/* DW1 */
+	u32		NumOfTrans:4;
+	u32		Reserved1:4;
+	u32		Reserved2:24;
+	/* DW2 */
+	u32		ByteCount:7;
+	u32		WriteEnable:1;		/* 0:read, 1:write */
+	u32		FixOrContinuous:1;	/* 0:continuous, 1: Fix */
+	u32		BurstMode:1;
+	u32		Byte1Access:1;
+	u32		Byte2Access:1;
+	u32		Byte4Access:1;
+	u32		Reserved3:3;
+	u32		Reserved4:16;
+	/* DW3 */
+	u32		BusAddress;
+	/* DW4 */
+	/* u32		Value; */
+#else
+/* DW1 */
+	u32 Reserved1:4;
+	u32 NumOfTrans:4;
+	u32 Reserved2:24;
+	/* DW2 */
+	u32 WriteEnable:1;
+	u32 ByteCount:7;
+	u32 Reserved3:3;
+	u32 Byte4Access:1;
+
+	u32 Byte2Access:1;
+	u32 Byte1Access:1;
+	u32 BurstMode:1;
+	u32 FixOrContinuous:1;
+	u32 Reserved4:16;
+	/* DW3 */
+	u32	BusAddress;
+
+	/* DW4 */
+#endif
+};
+
+struct reg_protocol_wt {
+#ifdef __LITTLE_ENDIAN
+	/* DW1 */
+	u32	NumOfTrans:4;
+	u32	Reserved1:4;
+	u32	Reserved2:24;
+	/* DW2 */
+	u32	ByteCount:7;
+	u32	WriteEnable:1;		/* 0:read, 1:write */
+	u32	FixOrContinuous:1;	/* 0:continuous, 1: Fix */
+	u32	BurstMode:1;
+	u32	Byte1Access:1;
+	u32	Byte2Access:1;
+	u32	Byte4Access:1;
+	u32	Reserved3:3;
+	u32	Reserved4:16;
+	/* DW3 */
+	u32	BusAddress;
+	/* DW4 */
+	u32	Value;
+#else
+	/* DW1 */
+	u32 Reserved1 :4;
+	u32 NumOfTrans:4;
+	u32 Reserved2:24;
+	/* DW2 */
+	u32 WriteEnable:1;
+	u32 ByteCount:7;
+	u32 Reserved3:3;
+	u32 Byte4Access:1;
+	u32 Byte2Access:1;
+	u32 Byte1Access:1;
+	u32 BurstMode:1;
+	u32 FixOrContinuous:1;
+	u32 Reserved4:16;
+	/* DW3 */
+	u32	BusAddress;
+	/* DW4 */
+	u32	Value;
+#endif
+};
+
+/*
+Below is the data structure used by _io_handler
+*/
+
+struct io_queue {
+	spinlock_t lock;
+	struct list_head free_ioreqs;
+	struct list_head pending;	/* The io_req list that will be served
+					 * in the single protocol read/write.*/
+	struct list_head processing;
+	u8	*free_ioreqs_buf; /*  4-byte aligned */
+	u8	*pallocated_free_ioreqs_buf;
+	struct	intf_hdl	intf;
+};
+
+struct io_priv {
+	struct adapter *padapter;
+	struct intf_hdl intf;
+};
+
+uint ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
+void sync_ioreq_enqueue(struct io_req *preq,struct io_queue *ioqueue);
+uint sync_ioreq_flush(struct adapter *adapter, struct io_queue *ioqueue);
+uint free_ioreq(struct io_req *preq, struct io_queue *pio_queue);
+struct io_req *alloc_ioreq(struct io_queue *pio_q);
+
+uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl);
+void unregister_intf_hdl(struct intf_hdl *pintfhdl);
+
+void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+
+u8 _rtw_read8(struct adapter *adapter, u32 addr);
+u16 _rtw_read16(struct adapter *adapter, u32 addr);
+u32 _rtw_read32(struct adapter *adapter, u32 addr);
+void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+void _rtw_read_port_cancel(struct adapter *adapter);
+
+int _rtw_write8(struct adapter *adapter, u32 addr, u8 val);
+int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
+int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);
+int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
+
+int _rtw_write8_async(struct adapter *adapter, u32 addr, u8 val);
+int _rtw_write16_async(struct adapter *adapter, u32 addr, u16 val);
+int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val);
+
+void _rtw_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+u32 _rtw_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
+			     u8 *pmem, int timeout_ms);
+void _rtw_write_port_cancel(struct adapter *adapter);
+
+#define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
+#define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
+#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
+#define rtw_read_mem(adapter, addr, cnt, mem)				\
+	_rtw_read_mem((adapter), (addr), (cnt), (mem))
+#define rtw_read_port(adapter, addr, cnt, mem)				\
+	_rtw_read_port((adapter), (addr), (cnt), (mem))
+#define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
+
+#define  rtw_write8(adapter, addr, val)					\
+	_rtw_write8((adapter), (addr), (val))
+#define  rtw_write16(adapter, addr, val)				\
+	_rtw_write16((adapter), (addr), (val))
+#define  rtw_write32(adapter, addr, val)				\
+	_rtw_write32((adapter), (addr), (val))
+#define  rtw_writeN(adapter, addr, length, data)			\
+	_rtw_writeN((adapter), (addr), (length), (data))
+#define rtw_write8_async(adapter, addr, val)				\
+	_rtw_write8_async((adapter), (addr), (val))
+#define rtw_write16_async(adapter, addr, val)				\
+	_rtw_write16_async((adapter), (addr), (val))
+#define rtw_write32_async(adapter, addr, val)				\
+	_rtw_write32_async((adapter), (addr), (val))
+#define rtw_write_mem(adapter, addr, cnt, mem)				\
+	_rtw_write_mem((adapter), (addr), (cnt), (mem))
+#define rtw_write_port(adapter, addr, cnt, mem)				\
+	_rtw_write_port((adapter), (addr), (cnt), (mem))
+#define rtw_write_port_and_wait(adapter, addr, cnt, mem, timeout_ms)	\
+	_rtw_write_port_and_wait((adapter), (addr), (cnt), (mem), (timeout_ms))
+#define rtw_write_port_cancel(adapter) _rtw_write_port_cancel((adapter))
+
+void rtw_write_scsi(struct adapter *adapter, u32 cnt, u8 *pmem);
+
+/* ioreq */
+void ioreq_read8(struct adapter *adapter, u32 addr, u8 *pval);
+void ioreq_read16(struct adapter *adapter, u32 addr, u16 *pval);
+void ioreq_read32(struct adapter *adapter, u32 addr, u32 *pval);
+void ioreq_write8(struct adapter *adapter, u32 addr, u8 val);
+void ioreq_write16(struct adapter *adapter, u32 addr, u16 val);
+void ioreq_write32(struct adapter *adapter, u32 addr, u32 val);
+
+uint async_read8(struct adapter *adapter, u32 addr, u8 *pbuff,
+		 void (*_async_io_callback)(struct adapter *padater,
+					    struct io_req *pio_req,
+					    u8 *cnxt), u8 *cnxt);
+uint async_read16(struct adapter *adapter, u32 addr,  u8 *pbuff,
+		  void (*_async_io_callback)(struct adapter *padater,
+					     struct io_req *pio_req,
+					     u8 *cnxt), u8 *cnxt);
+uint async_read32(struct adapter *adapter, u32 addr,  u8 *pbuff,
+		  void (*_async_io_callback)(struct adapter *padater,
+					     struct io_req *pio_req,
+					     u8 *cnxt), u8 *cnxt);
+
+void async_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+void async_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+
+void async_write8(struct adapter *adapter, u32 addr, u8 val,
+		  void (*_async_io_callback)(struct adapter *padater,
+					     struct io_req *pio_req,
+					     u8 *cnxt), u8 *cnxt);
+void async_write16(struct adapter *adapter, u32 addr, u16 val,
+		   void (*_async_io_callback)(struct adapter *padater,
+					      struct io_req *pio_req,
+					      u8 *cnxt), u8 *cnxt);
+void async_write32(struct adapter *adapter, u32 addr, u32 val,
+		   void (*_async_io_callback)(struct adapter *padater,
+					      struct io_req *pio_req,
+					      u8 *cnxt), u8 *cnxt);
+
+void async_write_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+void async_write_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
+
+int rtw_init_io_priv(struct adapter *padapter,
+		     void (*set_intf_ops)(struct _io_ops *pops));
+
+uint alloc_io_queue(struct adapter *adapter);
+void free_io_queue(struct adapter *adapter);
+void async_bus_io(struct io_queue *pio_q);
+void bus_sync_io(struct io_queue *pio_q);
+u32 _ioreq2rwmem(struct io_queue *pio_q);
+void dev_power_down(struct adapter * Adapter, u8 bpwrup);
+
+#define PlatformEFIOWrite1Byte(_a,_b,_c)		\
+	rtw_write8(_a,_b,_c)
+#define PlatformEFIOWrite2Byte(_a,_b,_c)		\
+	rtw_write16(_a,_b,_c)
+#define PlatformEFIOWrite4Byte(_a,_b,_c)		\
+	rtw_write32(_a,_b,_c)
+
+#define PlatformEFIORead1Byte(_a,_b)		\
+		rtw_read8(_a,_b)
+#define PlatformEFIORead2Byte(_a,_b)		\
+		rtw_read16(_a,_b)
+#define PlatformEFIORead4Byte(_a,_b)		\
+		rtw_read32(_a,_b)
+
+#endif	/* _RTL8711_IO_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl.h b/drivers/staging/r8188eu/include/rtw_ioctl.h
new file mode 100644
index 000000000000..8ffa73239819
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_ioctl.h
@@ -0,0 +1,120 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_IOCTL_H_
+#define _RTW_IOCTL_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#ifndef OID_802_11_CAPABILITY
+	#define OID_802_11_CAPABILITY	0x0d010122
+#endif
+
+#ifndef OID_802_11_PMKID
+	#define OID_802_11_PMKID	0x0d010123
+#endif
+
+/*  For DDK-defined OIDs */
+#define OID_NDIS_SEG1	0x00010100
+#define OID_NDIS_SEG2	0x00010200
+#define OID_NDIS_SEG3	0x00020100
+#define OID_NDIS_SEG4	0x01010100
+#define OID_NDIS_SEG5	0x01020100
+#define OID_NDIS_SEG6	0x01020200
+#define OID_NDIS_SEG7	0xFD010100
+#define OID_NDIS_SEG8	0x0D010100
+#define OID_NDIS_SEG9	0x0D010200
+#define OID_NDIS_SEG10	0x0D020200
+
+#define SZ_OID_NDIS_SEG1	23
+#define SZ_OID_NDIS_SEG2	3
+#define SZ_OID_NDIS_SEG3	6
+#define SZ_OID_NDIS_SEG4	6
+#define SZ_OID_NDIS_SEG5	4
+#define SZ_OID_NDIS_SEG6	8
+#define SZ_OID_NDIS_SEG7	7
+#define SZ_OID_NDIS_SEG8	36
+#define SZ_OID_NDIS_SEG9	24
+#define SZ_OID_NDIS_SEG10	19
+
+/*  For Realtek-defined OIDs */
+#define OID_MP_SEG1		0xFF871100
+#define OID_MP_SEG2		0xFF818000
+
+#define OID_MP_SEG3		0xFF818700
+#define OID_MP_SEG4		0xFF011100
+
+#define DEBUG_OID(dbg, str)						\
+	if ((!dbg)) {							\
+		RT_TRACE(_module_rtl871x_ioctl_c_, _drv_info_,		\
+			 ("%s(%d): %s", __func__, __line__, str));	\
+	}
+
+enum oid_type {
+	QUERY_OID,
+	SET_OID
+};
+
+struct oid_funs_node {
+	unsigned int oid_start; /* the starting number for OID */
+	unsigned int oid_end; /* the ending number for OID */
+	struct oid_obj_priv *node_array;
+	unsigned int array_sz; /* the size of node_array */
+	int query_counter; /* count the number of query hits for this segment */
+	int set_counter; /* count the number of set hits for this segment */
+};
+
+struct oid_par_priv {
+	void		*adapter_context;
+	NDIS_OID	oid;
+	void		*information_buf;
+	u32		information_buf_len;
+	u32		*bytes_rw;
+	u32		*bytes_needed;
+	enum oid_type	type_of_oid;
+	u32		dbg;
+};
+
+struct oid_obj_priv {
+	unsigned char	dbg; /*  0: without OID debug message
+			      *  1: with OID debug message */
+	int (*oidfuns)(struct oid_par_priv *poid_par_priv);
+};
+
+#if defined(_RTW_MP_IOCTL_C_)
+static int oid_null_function(struct oid_par_priv *poid_par_priv) {
+	return NDIS_STATUS_SUCCESS;
+}
+#endif
+
+extern struct iw_handler_def  rtw_handlers_def;
+
+int drv_query_info(struct  net_device *miniportadaptercontext, NDIS_OID oid,
+		   void *informationbuffer, u32 informationbufferlength,
+		   u32 *byteswritten, u32 *bytesneeded);
+
+int drv_set_info(struct  net_device *MiniportAdapterContext,
+		 NDIS_OID oid, void *informationbuffer,
+		 u32 informationbufferlength, u32 *bytesread,
+		 u32 *bytesneeded);
+
+extern int ui_pid[3];
+
+#endif /*  #ifndef __INC_CEINFO_ */
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h b/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
new file mode 100644
index 000000000000..8fa3858cb776
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_rtl.h
@@ -0,0 +1,79 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_IOCTL_RTL_H_
+#define _RTW_IOCTL_RTL_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+/*  oid_rtl_seg_01_01 ************** */
+int oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv);/* 84 */
+int oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_tx_retry_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_rx_retry_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_tx_beacon_ok_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_tx_beacon_err_hdl(struct oid_par_priv *poid_par_priv);
+
+int oid_rt_pro_set_fw_dig_state_hdl(struct oid_par_priv *poid_par_priv);/* 8a */
+int oid_rt_pro_set_fw_ra_state_hdl(struct oid_par_priv *poid_par_priv);	/* 8b */
+
+int oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv);/* 93 */
+int oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_ap_ip_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_set_channelplan_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_set_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_dedicate_probe_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_current_tx_power_level_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_supported_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_channel_list_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv *poid_par_priv);
+
+/*   oid_rtl_seg_01_03 section start ************** */
+int oid_rt_ap_get_associated_station_list_hdl(struct oid_par_priv *priv);
+int oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_ap_supported_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv);
+
+/*  oid_rtl_seg_01_11 */
+int oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv);
+
+/*   oid_rtl_seg_03_00 section start ************** */
+int oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv);
+int oid_rt_set_default_key_id_hdl(struct oid_par_priv *poid_par_priv);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
new file mode 100644
index 000000000000..794f98167c3c
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -0,0 +1,49 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_IOCTL_SET_H_
+#define __RTW_IOCTL_SET_H_
+
+#include <drv_types.h>
+
+typedef u8 NDIS_802_11_PMKID_VALUE[16];
+
+u8 rtw_set_802_11_add_key(struct adapter *adapt, struct ndis_802_11_key *key);
+u8 rtw_set_802_11_authentication_mode(struct adapter *adapt,
+				      enum ndis_802_11_auth_mode authmode);
+u8 rtw_set_802_11_bssid(struct adapter*adapter, u8 *bssid);
+u8 rtw_set_802_11_add_wep(struct adapter *adapter, struct ndis_802_11_wep *wep);
+u8 rtw_set_802_11_disassociate(struct adapter *adapter);
+u8 rtw_set_802_11_bssid_list_scan(struct adapter*adapter,
+				  struct ndis_802_11_ssid *pssid,
+				  int ssid_max_num);
+u8 rtw_set_802_11_infrastructure_mode(struct adapter *adapter,
+				      enum ndis_802_11_network_infra type);
+u8 rtw_set_802_11_remove_wep(struct adapter *adapter, u32 keyindex);
+u8 rtw_set_802_11_ssid(struct adapter *adapt, struct ndis_802_11_ssid *ssid);
+u8 rtw_set_802_11_remove_key(struct adapter *adapt,
+			     struct ndis_802_11_remove_key *key);
+u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
+u16 rtw_get_cur_max_rate(struct adapter *adapter);
+int rtw_set_scan_mode(struct adapter *adapter, enum rt_scan_type scan_mode);
+int rtw_set_channel_plan(struct adapter *adapter, u8 channel_plan);
+int rtw_set_country(struct adapter *adapter, const char *country_code);
+int rtw_change_ifname(struct adapter *padapter, const char *ifname);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
new file mode 100644
index 000000000000..6949922baa65
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -0,0 +1,84 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_IOL_H_
+#define __RTW_IOL_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define IOREG_CMD_END_LEN	4
+
+struct ioreg_cfg {
+	u8	length;
+	u8	cmd_id;
+	__le16	address;
+	__le32	data;
+	__le32  mask;
+};
+
+enum ioreg_cmd {
+	IOREG_CMD_LLT		= 0x01,
+	IOREG_CMD_REFUSE	= 0x02,
+	IOREG_CMD_EFUSE_PATH	= 0x03,
+	IOREG_CMD_WB_REG	= 0x04,
+	IOREG_CMD_WW_REG	= 0x05,
+	IOREG_CMD_WD_REG	= 0x06,
+	IOREG_CMD_W_RF		= 0x07,
+	IOREG_CMD_DELAY_US	= 0x10,
+	IOREG_CMD_DELAY_MS	= 0x11,
+	IOREG_CMD_END		= 0xFF,
+};
+
+struct xmit_frame *rtw_IOL_accquire_xmit_frame(struct adapter *adapter);
+int rtw_IOL_append_cmds(struct xmit_frame *xmit_frame, u8 *IOL_cmds,
+			u32 cmd_len);
+int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary);
+int rtw_IOL_exec_cmds_sync(struct adapter  *adapter,
+			   struct xmit_frame *xmit_frame, u32 max_wating_ms,
+			   u32 bndy_cnt);
+bool rtw_IOL_applied(struct adapter  *adapter);
+int rtw_IOL_append_DELAY_US_cmd(struct xmit_frame *xmit_frame, u16 us);
+int rtw_IOL_append_DELAY_MS_cmd(struct xmit_frame *xmit_frame, u16 ms);
+int rtw_IOL_append_END_cmd(struct xmit_frame *xmit_frame);
+
+void read_efuse_from_txpktbuf(struct adapter *adapter, int bcnhead,
+			      u8 *content, u16 *size);
+
+int _rtw_IOL_append_WB_cmd(struct xmit_frame *xmit_frame, u16 addr,
+			   u8 value, u8 mask);
+int _rtw_IOL_append_WW_cmd(struct xmit_frame *xmit_frame, u16 addr,
+			   u16 value, u16 mask);
+int _rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
+			   u32 value, u32 mask);
+int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
+			    u16 addr, u32 value, u32 mask);
+#define rtw_IOL_append_WB_cmd(xmit_frame, addr, value, mask)		\
+	_rtw_IOL_append_WB_cmd((xmit_frame), (addr), (value) ,(mask))
+#define rtw_IOL_append_WW_cmd(xmit_frame, addr, value, mask)		\
+	_rtw_IOL_append_WW_cmd((xmit_frame), (addr), (value),(mask))
+#define rtw_IOL_append_WD_cmd(xmit_frame, addr, value, mask)		\
+	_rtw_IOL_append_WD_cmd((xmit_frame), (addr), (value), (mask))
+#define rtw_IOL_append_WRF_cmd(xmit_frame, rf_path, addr, value, mask)	\
+	_rtw_IOL_append_WRF_cmd((xmit_frame),(rf_path), (addr), (value), (mask))
+
+u8 rtw_IOL_cmd_boundary_handle(struct xmit_frame *pxmit_frame);
+void  rtw_IOL_cmd_buf_dump(struct adapter  *Adapter,int buf_len,u8 *pbuf);
+
+#endif /* __RTW_IOL_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
new file mode 100644
index 000000000000..1e6a8090a753
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -0,0 +1,201 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_LED_H_
+#define __RTW_LED_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define MSECS(t)        (HZ * ((t) / 1000) + (HZ * ((t) % 1000)) / 1000)
+
+#define LED_BLINK_NORMAL_INTERVAL		100
+#define LED_BLINK_SLOWLY_INTERVAL		200
+#define LED_BLINK_LONG_INTERVAL			400
+
+#define LED_BLINK_NO_LINK_INTERVAL_ALPHA	1000
+#define LED_BLINK_LINK_INTERVAL_ALPHA		500	/* 500 */
+#define LED_BLINK_SCAN_INTERVAL_ALPHA		180	/* 150 */
+#define LED_BLINK_FASTER_INTERVAL_ALPHA		50
+#define LED_BLINK_WPS_SUCESS_INTERVAL_ALPHA	5000
+
+#define LED_BLINK_NORMAL_INTERVAL_NETTRONIX	100
+#define LED_BLINK_SLOWLY_INTERVAL_NETTRONIX	2000
+
+#define LED_BLINK_SLOWLY_INTERVAL_PORNET	1000
+#define LED_BLINK_NORMAL_INTERVAL_PORNET	100
+
+#define LED_BLINK_FAST_INTERVAL_BITLAND		30
+
+/*  060403, rcnjko: Customized for AzWave. */
+#define LED_CM2_BLINK_ON_INTERVAL		250
+#define LED_CM2_BLINK_OFF_INTERVAL		4750
+
+#define LED_CM8_BLINK_INTERVAL			500	/* for QMI */
+#define LED_CM8_BLINK_OFF_INTERVAL		3750	/* for QMI */
+
+/*  080124, lanhsin: Customized for RunTop */
+#define LED_RunTop_BLINK_INTERVAL		300
+
+/*  060421, rcnjko: Customized for Sercomm Printer Server case. */
+#define LED_CM3_BLINK_INTERVAL			1500
+
+enum LED_CTL_MODE {
+	LED_CTL_POWER_ON = 1,
+	LED_CTL_LINK = 2,
+	LED_CTL_NO_LINK = 3,
+	LED_CTL_TX = 4,
+	LED_CTL_RX = 5,
+	LED_CTL_SITE_SURVEY = 6,
+	LED_CTL_POWER_OFF = 7,
+	LED_CTL_START_TO_LINK = 8,
+	LED_CTL_START_WPS = 9,
+	LED_CTL_STOP_WPS = 10,
+	LED_CTL_START_WPS_BOTTON = 11, /* added for runtop */
+	LED_CTL_STOP_WPS_FAIL = 12, /* added for ALPHA */
+	LED_CTL_STOP_WPS_FAIL_OVERLAP = 13, /* added for BELKIN */
+	LED_CTL_CONNECTION_NO_TRANSFER = 14,
+};
+
+enum LED_STATE_871x {
+	LED_UNKNOWN = 0,
+	RTW_LED_ON = 1,
+	RTW_LED_OFF = 2,
+	LED_BLINK_NORMAL = 3,
+	LED_BLINK_SLOWLY = 4,
+	LED_BLINK_POWER_ON = 5,
+	LED_BLINK_SCAN = 6, /*  LED is blinking during scanning period,
+			     * the # of times to blink is depend on time
+			     * for scanning. */
+	LED_BLINK_NO_LINK = 7, /*  LED is blinking during no link state. */
+	LED_BLINK_StartToBlink = 8,/*  Customzied for Sercomm Printer
+				    * Server case */
+	LED_BLINK_TXRX = 9,
+	LED_BLINK_WPS = 10,	/*  LED is blinkg during WPS communication */
+	LED_BLINK_WPS_STOP = 11,	/* for ALPHA */
+	LED_BLINK_WPS_STOP_OVERLAP = 12,	/* for BELKIN */
+	LED_BLINK_RUNTOP = 13, /*  Customized for RunTop */
+	LED_BLINK_CAMEO = 14,
+	LED_BLINK_XAVI = 15,
+	LED_BLINK_ALWAYS_ON = 16,
+};
+
+enum LED_PIN_871x {
+	LED_PIN_NULL = 0,
+	LED_PIN_LED0 = 1,
+	LED_PIN_LED1 = 2,
+	LED_PIN_LED2 = 3,
+	LED_PIN_GPIO0 = 4,
+};
+
+struct LED_871x {
+	struct adapter *padapter;
+
+	enum LED_PIN_871x	LedPin;	/* Identify how to implement this
+					 * SW led. */
+	enum LED_STATE_871x	CurrLedState; /*  Current LED state. */
+	enum LED_STATE_871x	BlinkingLedState; /*  Next state for blinking,
+				   * either RTW_LED_ON or RTW_LED_OFF are. */
+
+	u8 bLedOn; /*  true if LED is ON, false if LED is OFF. */
+
+	u8 bLedBlinkInProgress; /*  true if it is blinking, false o.w.. */
+
+	u8 bLedWPSBlinkInProgress;
+
+	u32 BlinkTimes; /*  Number of times to toggle led state for blinking. */
+
+	struct timer_list BlinkTimer; /*  Timer object for led blinking. */
+
+	u8 bSWLedCtrl;
+
+	/*  ALPHA, added by chiyoko, 20090106 */
+	u8 bLedNoLinkBlinkInProgress;
+	u8 bLedLinkBlinkInProgress;
+	u8 bLedStartToLinkBlinkInProgress;
+	u8 bLedScanBlinkInProgress;
+	struct work_struct BlinkWorkItem; /* Workitem used by BlinkTimer to
+					   * manipulate H/W to blink LED. */
+};
+
+#define IS_LED_WPS_BLINKING(_LED_871x)					\
+	(((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS || \
+	((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS_STOP || \
+	((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress)
+
+#define IS_LED_BLINKING(_LED_871x)					\
+	(((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress	||	\
+	((struct LED_871x *)_LED_871x)->bLedScanBlinkInProgress)
+
+/*  LED customization. */
+
+enum LED_STRATEGY_871x {
+	SW_LED_MODE0 = 0, /* SW control 1 LED via GPIO0. It is default option.*/
+	SW_LED_MODE1= 1, /*  2 LEDs, through LED0 and LED1. For ALPHA. */
+	SW_LED_MODE2 = 2, /*  SW control 1 LED via GPIO0, customized for AzWave
+			   * 8187 minicard. */
+	SW_LED_MODE3 = 3, /*  SW control 1 LED via GPIO0, customized for Sercomm
+			   * Printer Server case. */
+	SW_LED_MODE4 = 4, /* for Edimax / Belkin */
+	SW_LED_MODE5 = 5, /* for Sercomm / Belkin */
+	SW_LED_MODE6 = 6, /* for 88CU minicard, porting from ce SW_LED_MODE7 */
+	HW_LED = 50, /*  HW control 2 LEDs, LED0 and LED1 (there are 4
+		      * different control modes, see MAC.CONFIG1 for details.)*/
+	LED_ST_NONE = 99,
+};
+
+void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE	LedAction);
+
+struct led_priv{
+	/* add for led control */
+	struct LED_871x			SwLed0;
+	struct LED_871x			SwLed1;
+	enum LED_STRATEGY_871x	LedStrategy;
+	u8	bRegUseLed;
+	void (*LedControlHandler)(struct adapter *padapter,
+				  enum LED_CTL_MODE LedAction);
+	/* add for led control */
+};
+
+#define rtw_led_control(adapt, action) \
+	do { \
+		if ((adapt)->ledpriv.LedControlHandler) \
+			(adapt)->ledpriv.LedControlHandler((adapt), (action)); \
+	} while (0)
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 15, 0)
+void BlinkTimerCallback(struct timer_list *t);
+#else
+void BlinkTimerCallback(void *data);
+#endif
+void BlinkWorkItemCallback(struct work_struct *work);
+
+void ResetLedStatus(struct LED_871x * pLed);
+
+void InitLed871x(struct adapter *padapter, struct LED_871x *pLed,
+		 enum LED_PIN_871x LedPin);
+
+void DeInitLed871x(struct LED_871x *pLed);
+
+/* hal... */
+void BlinkHandler(struct LED_871x * pLed);
+void SwLedOn(struct adapter *padapter, struct LED_871x *pLed);
+void SwLedOff(struct adapter *padapter, struct LED_871x *pLed);
+
+#endif /* __RTW_LED_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
new file mode 100644
index 000000000000..a53a567b2960
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -0,0 +1,649 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_MLME_H_
+#define __RTW_MLME_H_
+
+#include <osdep_service.h>
+#include <mlme_osdep.h>
+#include <drv_types.h>
+#include <wlan_bssdef.h>
+
+#define	MAX_BSS_CNT	128
+#define   MAX_JOIN_TIMEOUT	6500
+
+/* Increase the scanning timeout because of increasing the SURVEY_TO value. */
+
+#define		SCANNING_TIMEOUT	8000
+
+#define	SCAN_INTERVAL	(30) /*  unit:2sec, 30*2=60sec */
+
+#define	SCANQUEUE_LIFETIME 20 /*  unit:sec */
+
+#define	WIFI_NULL_STATE			0x00000000
+
+#define	WIFI_ASOC_STATE			0x00000001	/* Under Linked state */
+#define	WIFI_REASOC_STATE		0x00000002
+#define	WIFI_SLEEP_STATE		0x00000004
+#define	WIFI_STATION_STATE		0x00000008
+
+#define	WIFI_AP_STATE			0x00000010
+#define	WIFI_ADHOC_STATE		0x00000020
+#define WIFI_ADHOC_MASTER_STATE		0x00000040
+#define WIFI_UNDER_LINKING		0x00000080
+
+#define	WIFI_UNDER_WPS			0x00000100
+#define	WIFI_STA_ALIVE_CHK_STATE	0x00000400
+#define	WIFI_SITE_MONITOR		0x00000800	/* to indicate the station is under site surveying */
+
+#define	WIFI_MP_STATE			0x00010000
+#define	WIFI_MP_CTX_BACKGROUND		0x00020000	/*  in continuous tx background */
+#define	WIFI_MP_CTX_ST			0x00040000	/*  in continuous tx with single-tone */
+#define	WIFI_MP_CTX_BACKGROUND_PENDING	0x00080000	/*  pending in continuous tx background due to out of skb */
+#define	WIFI_MP_CTX_CCK_HW		0x00100000	/*  in continuous tx */
+#define	WIFI_MP_CTX_CCK_CS		0x00200000	/*  in continuous tx with carrier suppression */
+#define WIFI_MP_LPBK_STATE		0x00400000
+
+#define _FW_UNDER_LINKING	WIFI_UNDER_LINKING
+#define _FW_LINKED			WIFI_ASOC_STATE
+#define _FW_UNDER_SURVEY	WIFI_SITE_MONITOR
+
+enum dot11AuthAlgrthmNum {
+	dot11AuthAlgrthm_Open = 0,
+	dot11AuthAlgrthm_Shared,
+	dot11AuthAlgrthm_8021X,
+	dot11AuthAlgrthm_Auto,
+	dot11AuthAlgrthm_WAPI,
+	dot11AuthAlgrthm_MaxNum
+};
+
+/*  Scan type including active and passive scan. */
+enum rt_scan_type {
+	SCAN_PASSIVE,
+	SCAN_ACTIVE,
+	SCAN_MIX,
+};
+
+enum SCAN_RESULT_TYPE {
+	SCAN_RESULT_P2P_ONLY = 0,	/* Will return all the P2P devices. */
+	SCAN_RESULT_ALL = 1,		/* Will return all the scanned device,
+					 * include AP. */
+	SCAN_RESULT_WFD_TYPE = 2	/* Will just return the correct WFD
+					 * device. */
+					/* If this device is Miracast sink
+					 * device, it will just return all the
+					 * Miracast source devices. */
+};
+
+/*
+there are several "locks" in mlme_priv,
+since mlme_priv is a shared resource between many threads,
+like ISR/Call-Back functions, the OID handlers, and even timer functions.
+
+Each _queue has its own locks, already.
+Other items are protected by mlme_priv.lock.
+
+To avoid possible dead lock, any thread trying to modifiying mlme_priv
+SHALL not lock up more than one lock at a time!
+*/
+
+#define traffic_threshold	10
+#define	traffic_scan_period	500
+
+struct sitesurvey_ctrl {
+	u64	last_tx_pkts;
+	uint	last_rx_pkts;
+	int	traffic_busy;
+	struct timer_list sitesurvey_ctrl_timer;
+};
+
+struct rt_link_detect {
+	u32	NumTxOkInPeriod;
+	u32	NumRxOkInPeriod;
+	u32	NumRxUnicastOkInPeriod;
+	bool	bBusyTraffic;
+	bool	bTxBusyTraffic;
+	bool	bRxBusyTraffic;
+	bool	bHigherBusyTraffic; /*  For interrupt migration purpose. */
+	bool	bHigherBusyRxTraffic; /* We may disable Tx interrupt according
+				       * to Rx traffic. */
+	bool	bHigherBusyTxTraffic; /* We may disable Tx interrupt according
+				       * to Tx traffic. */
+};
+
+struct profile_info {
+	u8	ssidlen;
+	u8	ssid[ WLAN_SSID_MAXLEN ];
+	u8	peermac[ ETH_ALEN ];
+};
+
+struct tx_invite_req_info {
+	u8	token;
+	u8	benable;
+	u8	go_ssid[ WLAN_SSID_MAXLEN ];
+	u8	ssidlen;
+	u8	go_bssid[ ETH_ALEN ];
+	u8	peer_macaddr[ ETH_ALEN ];
+	u8	operating_ch;	/* This information will be set by using the
+				 * p2p_set op_ch=x */
+	u8	peer_ch;	/* The listen channel for peer P2P device */
+};
+
+struct tx_invite_resp_info {
+	u8	token;	/* Used to record the dialog token of p2p invitation
+			 * request frame. */
+};
+
+struct tx_provdisc_req_info {
+	u16	wps_config_method_request;	/* Used when sending the
+						 * provisioning request frame*/
+	u16	peer_channel_num[2];		/* The channel number which the
+						 * receiver stands. */
+	struct ndis_802_11_ssid	ssid;
+	u8	peerDevAddr[ETH_ALEN];		/* Peer device address */
+	u8	peerIFAddr[ETH_ALEN];		/* Peer interface address */
+	u8	benable;			/* This provision discovery
+						 * request frame is trigger
+						 * to send or not */
+};
+
+/* When peer device issue prov_disc_req first, we should store the following
+ * information */
+/* The UI must know this information to know which config method the
+ * remote p2p device needs. */
+struct rx_provdisc_req_info {
+	u8	peerDevAddr[ETH_ALEN];		/* Peer device address */
+	u8	strconfig_method_desc_of_prov_disc_req[4];	/* description
+			* for the config method located in the provisioning
+			* discovery request frame. */
+};
+
+struct tx_nego_req_info {
+	u16	peer_channel_num[2];	/* The channel number. */
+	u8	peerDevAddr[ETH_ALEN];	/* Peer device address */
+	u8	benable;		/* This negotiation request frame is
+					 * trigger to send or not */
+};
+
+struct group_id_info {
+	u8	go_device_addr[ ETH_ALEN ];	/* The GO's device address of
+						 * this P2P group */
+	u8	ssid[ WLAN_SSID_MAXLEN ];	/* The SSID of this P2P group */
+};
+
+struct scan_limit_info {
+	u8	scan_op_ch_only;	/* When this flag is set, the driver
+					 * should only scan the op. channel */
+	u8	operation_ch[2];	/* Store the op. chan of invitation */
+};
+
+struct wifidirect_info {
+	struct adapter *padapter;
+	struct timer_list find_phase_timer;
+	struct timer_list restore_p2p_state_timer;
+
+	/* Used to do the scanning. After confirming the peer is availalble,
+	 * the driver transmits the P2P frame to peer. */
+	struct timer_list pre_tx_scan_timer;
+	struct timer_list reset_ch_sitesurvey;
+	struct timer_list reset_ch_sitesurvey2;	/* Just for resetting the scan
+					 * limit function by using p2p nego */
+	struct tx_provdisc_req_info	tx_prov_disc_info;
+	struct rx_provdisc_req_info rx_prov_disc_info;
+	struct tx_invite_req_info	invitereq_info;
+	/* Store the profile information of persistent group */
+	struct profile_info profileinfo[P2P_MAX_PERSISTENT_GROUP_NUM];
+	struct tx_invite_resp_info	inviteresp_info;
+	struct tx_nego_req_info	nego_req_info;
+	/* Store the group id info when doing the group negot handshake. */
+	struct group_id_info groupid_info;
+	/* Used for get the limit scan channel from the Invitation procedure */
+	struct scan_limit_info rx_invitereq_info;
+	/* Used for get the limit scan chan from the P2P negotiation handshake*/
+	struct scan_limit_info p2p_info;
+	enum P2P_ROLE role;
+	enum P2P_STATE pre_p2p_state;
+	enum P2P_STATE p2p_state;
+	/* The device address should be the mac address of this device. */
+	u8 device_addr[ETH_ALEN];
+	u8 interface_addr[ETH_ALEN];
+	u8 social_chan[4];
+	u8 listen_channel;
+	u8 operating_channel;
+	u8 listen_dwell;	/* This value should be between 1 and 3 */
+	u8 support_rate[8];
+	u8 p2p_wildcard_ssid[P2P_WILDCARD_SSID_LEN];
+	u8 intent;	/* should only include the intent value. */
+	u8 p2p_peer_interface_addr[ETH_ALEN];
+	u8 p2p_peer_device_addr[ETH_ALEN];
+	u8 peer_intent;	/* Included the intent value and tie breaker value. */
+	/* Device name for displaying on searching device screen */
+	u8 device_name[WPS_MAX_DEVICE_NAME_LEN];
+	u8 device_name_len;
+	u8 profileindex; /* Used to point to the index of profileinfo array */
+	u8 peer_operating_ch;
+	u8 find_phase_state_exchange_cnt;
+	/* The device password ID for group negotiation */
+	u16 device_password_id_for_nego;
+	u8 negotiation_dialog_token;
+	/* SSID information for group negotitation */
+	u8 nego_ssid[WLAN_SSID_MAXLEN];
+	u8 nego_ssidlen;
+	u8 p2p_group_ssid[WLAN_SSID_MAXLEN];
+	u8 p2p_group_ssid_len;
+	/* Flag to know if the persistent function should be supported or not.*/
+	u8 persistent_supported;
+	/* In the Sigma test, the Sigma will provide this enable from the
+	 * sta_set_p2p CAPI. */
+	/*	0: disable */
+	/*	1: enable */
+	u8 session_available;	/* Flag to set the WFD session available to
+				 * enable or disable "by Sigma" */
+	/* In the Sigma test, the Sigma will disable the session available
+	 * by using the sta_preset CAPI. */
+	/*	0: disable */
+	/*	1: enable */
+	u8 wfd_tdls_enable; /* Flag to enable or disable the TDLS by WFD Sigma*/
+			    /* 0: disable */
+			    /*	1: enable */
+	u8 wfd_tdls_weaksec; /* Flag to enable or disable the weak security
+			      * function for TDLS by WFD Sigma */
+			     /* 0: disable */
+			     /* In this case, the driver can't issue the tdsl
+			      * setup request frame. */
+			     /*	1: enable */
+			     /* In this case, the driver can issue the tdls
+			      * setup request frame */
+			     /*	even the current security is weak security. */
+
+	/* This field will store the WPS value (PIN value or PBC) that UI had
+	 * got from the user. */
+	enum	P2P_WPSINFO ui_got_wps_info;
+	u16 supported_wps_cm;	/* This field describes the WPS config method
+				 * which this driver supported. */
+				/* The value should be the combination of config
+				 * method defined in page104 of WPS v2.0 spec.*/
+	/* This field will contain the length of body of P2P Channel List
+	 * attribute of group negotiation response frame. */
+	uint channel_list_attr_len;
+	/* This field will contain the body of P2P Channel List attribute of
+	 * group negotitation response frame. */
+	/* We will use the channel_cnt and channel_list fields when constructing
+	 * the group negotiation confirm frame. */
+	u8 channel_list_attr[100];
+	enum P2P_PS_MODE p2p_ps_mode; /*  indicate p2p ps mode */
+	enum P2P_PS_STATE p2p_ps_state; /*  indicate p2p ps state */
+	u8 noa_index; /*  Identifies and instance of Notice of Absence timing. */
+	u8 ctwindow; /*  Client traffic window. A period of time in TU after TBTT. */
+	u8 opp_ps; /*  opportunistic power save. */
+	u8 noa_num; /*  number of NoA descriptor in P2P IE. */
+	u8 noa_count[P2P_MAX_NOA_NUM]; /*  Count for owner, Type of client. */
+	/* Max duration for owner, preferred or min acceptable duration for
+	 * client. */
+	u32 noa_duration[P2P_MAX_NOA_NUM];
+	/* Length of interval for owner, preferred or max acceptable interval
+	 * of client. */
+	u32 noa_interval[P2P_MAX_NOA_NUM];
+	/* schedule expressed in terms of the lower 4 bytes of the TSF timer. */
+	u32 noa_start_time[P2P_MAX_NOA_NUM];
+};
+
+struct tdls_ss_record {	/* signal strength record */
+	u8 macaddr[ETH_ALEN];
+	u8 RxPWDBAll;
+	u8 is_tdls_sta;	/*  true: direct link sta, false: else */
+};
+
+struct tdls_info {
+	u8 ap_prohibited;
+	uint setup_state;
+	u8 sta_cnt;
+	u8 sta_maximum;	/*  1:tdls sta is equal (NUM_STA-1), reach max direct link number; 0: else; */
+	struct tdls_ss_record	ss_record;
+	u8 macid_index;	/* macid entry that is ready to write */
+	u8 clear_cam;	/* cam entry that is trying to clear, using it in direct link teardown */
+	u8 ch_sensing;
+	u8 cur_channel;
+	u8 candidate_ch;
+	u8 collect_pkt_num[MAX_CHANNEL_NUM];
+	spinlock_t cmd_lock;
+	spinlock_t hdl_lock;
+	u8 watchdog_count;
+	u8 dev_discovered;		/* WFD_TDLS: for sigma test */
+	u8 enable;
+};
+
+struct mlme_priv {
+	spinlock_t lock;
+	int fw_state;	/* shall we protect this variable? maybe not necessarily... */
+	u8 bScanInProcess;
+	u8 to_join; /* flag */
+	u8 to_roaming; /*  roaming trying times */
+
+	u8 *nic_hdl;
+
+	u8 not_indic_disco;
+	struct list_head *pscanned;
+	struct __queue free_bss_pool;
+	struct __queue scanned_queue;
+	u8 *free_bss_buf;
+	u8	key_mask; /* use to restore wep key after hal_init */
+	u32	num_of_scanned;
+
+	struct ndis_802_11_ssid	assoc_ssid;
+	u8	assoc_bssid[6];
+
+	struct wlan_network	cur_network;
+	struct wlan_network *cur_network_scanned;
+
+	u32	scan_interval;
+
+	struct timer_list assoc_timer;
+
+	uint assoc_by_bssid;
+	uint assoc_by_rssi;
+
+	struct timer_list scan_to_timer; /*  driver itself handles scan_timeout status. */
+	u32 scan_start_time; /*  used to evaluate the time spent in scanning */
+
+	struct qos_priv qospriv;
+
+	/* Number of non-HT AP/stations */
+	int num_sta_no_ht;
+
+	/* Number of HT AP/stations 20 MHz */
+	/* int num_sta_ht_20mhz; */
+
+	int num_FortyMHzIntolerant;
+	struct ht_priv	htpriv;
+	struct rt_link_detect LinkDetectInfo;
+	struct timer_list dynamic_chk_timer; /* dynamic/periodic check timer */
+
+	u8	acm_mask; /*  for wmm acm mask */
+	u8	ChannelPlan;
+	enum rt_scan_type scan_mode; /*  active: 1, passive: 0 */
+
+	/* u8 probereq_wpsie[MAX_WPS_IE_LEN];added in probe req */
+	/* int probereq_wpsie_len; */
+	u8 *wps_probe_req_ie;
+	u32 wps_probe_req_ie_len;
+
+	u8 *assoc_req;
+	u32 assoc_req_len;
+	u8 *assoc_rsp;
+	u32 assoc_rsp_len;
+
+#if defined (CONFIG_88EU_AP_MODE)
+	/* Number of associated Non-ERP stations (i.e., stations using 802.11b
+	 * in 802.11g BSS) */
+	int num_sta_non_erp;
+
+	/* Number of associated stations that do not support Short Slot Time */
+	int num_sta_no_short_slot_time;
+
+	/* Number of associated stations that do not support Short Preamble */
+	int num_sta_no_short_preamble;
+
+	int olbc; /* Overlapping Legacy BSS Condition */
+
+	/* Number of HT assoc sta that do not support greenfield */
+	int num_sta_ht_no_gf;
+
+	/* Number of associated non-HT stations */
+	/* int num_sta_no_ht; */
+
+	/* Number of HT associated stations 20 MHz */
+	int num_sta_ht_20mhz;
+
+	/* Overlapping BSS information */
+	int olbc_ht;
+
+	u16 ht_op_mode;
+
+	u8 *wps_beacon_ie;
+	/* u8 *wps_probe_req_ie; */
+	u8 *wps_probe_resp_ie;
+	u8 *wps_assoc_resp_ie;
+
+	u32 wps_beacon_ie_len;
+	u32 wps_probe_resp_ie_len;
+	u32 wps_assoc_resp_ie_len;
+
+	u8 *p2p_beacon_ie;
+	u8 *p2p_probe_req_ie;
+	u8 *p2p_probe_resp_ie;
+	u8 *p2p_go_probe_resp_ie; /* for GO */
+	u8 *p2p_assoc_req_ie;
+
+	u32 p2p_beacon_ie_len;
+	u32 p2p_probe_req_ie_len;
+	u32 p2p_probe_resp_ie_len;
+	u32 p2p_go_probe_resp_ie_len; /* for GO */
+	u32 p2p_assoc_req_ie_len;
+	spinlock_t bcn_update_lock;
+	u8		update_bcn;
+#endif /* if defined (CONFIG_88EU_AP_MODE) */
+};
+
+#ifdef CONFIG_88EU_AP_MODE
+
+struct hostapd_priv {
+	struct adapter *padapter;
+};
+
+int hostapd_mode_init(struct adapter *padapter);
+void hostapd_mode_unload(struct adapter *padapter);
+#endif
+
+extern unsigned char WPA_TKIP_CIPHER[4];
+extern unsigned char RSN_TKIP_CIPHER[4];
+extern unsigned char REALTEK_96B_IE[];
+extern unsigned char	MCS_rate_2R[16];
+extern unsigned char	MCS_rate_1R[16];
+
+void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf);
+void rtw_survey_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_surveydone_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_joinbss_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_atimdone_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_cpwm_event_callback(struct adapter *adapter, u8 *pbuf);
+void indicate_wx_scan_complete_event(struct adapter *padapter);
+void rtw_indicate_wx_assoc_event(struct adapter *padapter);
+void rtw_indicate_wx_disassoc_event(struct adapter *padapter);
+int event_thread(void *context);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+void rtw_join_timeout_handler (void *FunctionContext);
+void _rtw_scan_timeout_handler(void *FunctionContext);
+#else
+void rtw_join_timeout_handler (struct timer_list *t);
+void _rtw_scan_timeout_handler (struct timer_list *t);
+#endif
+void rtw_free_network_queue(struct adapter *adapter, u8 isfreeall);
+int rtw_init_mlme_priv(struct adapter *adapter);
+void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv);
+int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv);
+int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv,
+		int keyid, u8 set_tx);
+int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv);
+
+static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
+{	/* if sta_mode:pmlmepriv->cur_network.network.MacAddress=> bssid */
+	/*  if adhoc_mode:pmlmepriv->cur_network.network.MacAddress=> ibss mac address */
+	return pmlmepriv->cur_network.network.MacAddress;
+}
+
+static inline int check_fwstate(struct mlme_priv *pmlmepriv, int state)
+{
+	if (pmlmepriv->fw_state & state)
+		return true;
+
+	return false;
+}
+
+static inline int get_fwstate(struct mlme_priv *pmlmepriv)
+{
+	return pmlmepriv->fw_state;
+}
+
+/*
+ * No Limit on the calling context,
+ * therefore set it to be the critical section...
+ *
+ * ### NOTE:#### (!!!!)
+ * MUST TAKE CARE THAT BEFORE CALLING THIS FUNC, YOU SHOULD HAVE LOCKED pmlmepriv->lock
+ */
+static inline void set_fwstate(struct mlme_priv *pmlmepriv, int state)
+{
+	pmlmepriv->fw_state |= state;
+	/* FOR HW integration */
+	if (_FW_UNDER_SURVEY==state)
+		pmlmepriv->bScanInProcess = true;
+}
+
+static inline void _clr_fwstate_(struct mlme_priv *pmlmepriv, int state)
+{
+	pmlmepriv->fw_state &= ~state;
+	/* FOR HW integration */
+	if (_FW_UNDER_SURVEY==state)
+		pmlmepriv->bScanInProcess = false;
+}
+
+/*
+ * No Limit on the calling context,
+ * therefore set it to be the critical section...
+ */
+static inline void clr_fwstate(struct mlme_priv *pmlmepriv, int state)
+{
+	spin_lock_bh(&pmlmepriv->lock);
+	if (check_fwstate(pmlmepriv, state) == true)
+		pmlmepriv->fw_state ^= state;
+	spin_unlock_bh(&pmlmepriv->lock);
+}
+
+static inline void clr_fwstate_ex(struct mlme_priv *pmlmepriv, int state)
+{
+	spin_lock_bh(&pmlmepriv->lock);
+	_clr_fwstate_(pmlmepriv, state);
+	spin_unlock_bh(&pmlmepriv->lock);
+}
+
+static inline void up_scanned_network(struct mlme_priv *pmlmepriv)
+{
+	spin_lock_bh(&pmlmepriv->lock);
+	pmlmepriv->num_of_scanned++;
+	spin_unlock_bh(&pmlmepriv->lock);
+}
+
+static inline void down_scanned_network(struct mlme_priv *pmlmepriv)
+{
+	spin_lock_bh(&pmlmepriv->lock);
+	pmlmepriv->num_of_scanned--;
+	spin_unlock_bh(&pmlmepriv->lock);
+}
+
+static inline void set_scanned_network_val(struct mlme_priv *pmlmepriv, int val)
+{
+	spin_lock_bh(&pmlmepriv->lock);
+	pmlmepriv->num_of_scanned = val;
+	spin_unlock_bh(&pmlmepriv->lock);
+}
+
+u16 rtw_get_capability(struct wlan_bssid_ex *bss);
+void rtw_update_scanned_network(struct adapter *adapter,
+				struct wlan_bssid_ex *target);
+void rtw_disconnect_hdl_under_linked(struct adapter *adapter,
+				     struct sta_info *psta, u8 free_assoc);
+void rtw_generate_random_ibss(u8 *pibss);
+struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr);
+struct wlan_network *rtw_get_oldest_wlan_network(struct __queue *scanned_queue);
+
+void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue);
+void rtw_indicate_disconnect(struct adapter *adapter);
+void rtw_indicate_connect(struct adapter *adapter);
+void rtw_indicate_scan_done( struct adapter *padapter, bool aborted);
+void rtw_scan_abort(struct adapter *adapter);
+
+int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
+			uint in_len);
+int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
+		        uint in_len, uint initial_out_len);
+void rtw_init_registrypriv_dev_network(struct adapter *adapter);
+
+void rtw_update_registrypriv_dev_network(struct adapter *adapter);
+
+void rtw_get_encrypt_decrypt_from_registrypriv(struct adapter *adapter);
+
+void _rtw_join_timeout_handler(struct adapter *adapter);
+void rtw_scan_timeout_handler(struct adapter *adapter);
+
+ void rtw_dynamic_check_timer_handlder(struct adapter *adapter);
+#define rtw_is_scan_deny(adapter) false
+#define rtw_clear_scan_deny(adapter) do {} while (0)
+#define rtw_set_scan_deny_timer_hdl(adapter) do {} while (0)
+#define rtw_set_scan_deny(adapter, ms) do {} while (0)
+
+int _rtw_init_mlme_priv(struct adapter *padapter);
+
+void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
+
+void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv);
+
+int _rtw_enqueue_network(struct __queue *queue, struct wlan_network *pnetwork);
+
+struct wlan_network *_rtw_dequeue_network(struct __queue *queue);
+
+ struct wlan_network *_rtw_alloc_network(struct mlme_priv *pmlmepriv);
+
+void _rtw_free_network(struct mlme_priv *pmlmepriv,
+		       struct wlan_network *pnetwork, u8 isfreeall);
+void _rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
+			      struct wlan_network *pnetwork);
+
+struct wlan_network* _rtw_find_network(struct __queue *scanned_queue, u8 *addr);
+
+void _rtw_free_network_queue(struct adapter *padapter, u8 isfreeall);
+
+int rtw_if_up(struct adapter *padapter);
+
+u8 *rtw_get_capability_from_ie(u8 *ie);
+u8 *rtw_get_timestampe_from_ie(u8 *ie);
+u8 *rtw_get_beacon_interval_from_ie(u8 *ie);
+
+void rtw_joinbss_reset(struct adapter *padapter);
+
+unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie,
+				   u8 *out_ie, uint in_len, uint *pout_len);
+void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len);
+void rtw_issue_addbareq_cmd(struct adapter *padapter,
+			    struct xmit_frame *pxmitframe);
+
+int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork);
+int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst);
+
+void rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network);
+void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network);
+void rtw_set_roaming(struct adapter *adapter, u8 to_roaming);
+u8 rtw_to_roaming(struct adapter *adapter);
+
+void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
+			      u32 mstatus);
+
+#endif /* __RTL871X_MLME_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
new file mode 100644
index 000000000000..fdb79587762e
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -0,0 +1,874 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_MLME_EXT_H_
+#define __RTW_MLME_EXT_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <wlan_bssdef.h>
+
+/*	Commented by Albert 20101105 */
+/*	Increase the SURVEY_TO value from 100 to 150  ( 100ms to 150ms ) */
+/*	The Realtek 8188CE SoftAP will spend around 100ms to send the probe response after receiving the probe request. */
+/*	So, this driver tried to extend the dwell time for each scanning channel. */
+/*	This will increase the chance to receive the probe response from SoftAP. */
+
+#define SURVEY_TO		(100)
+#define REAUTH_TO		(300) /* 50) */
+#define REASSOC_TO		(300) /* 50) */
+/* define DISCONNECT_TO	(3000) */
+#define ADDBA_TO			(2000)
+
+#define LINKED_TO (1) /* unit:2 sec, 1x2=2 sec */
+
+#define REAUTH_LIMIT	(4)
+#define REASSOC_LIMIT	(4)
+#define READDBA_LIMIT	(2)
+
+#define ROAMING_LIMIT	8
+
+#define	DYNAMIC_FUNC_DISABLE			(0x0)
+
+/*  ====== ODM_ABILITY_E ======== */
+/*  BB ODM section BIT 0-15 */
+#define	DYNAMIC_BB_DIG				BIT(0)
+#define	DYNAMIC_BB_RA_MASK			BIT(1)
+#define	DYNAMIC_BB_DYNAMIC_TXPWR	BIT(2)
+#define	DYNAMIC_BB_BB_FA_CNT			BIT(3)
+
+#define		DYNAMIC_BB_RSSI_MONITOR		BIT(4)
+#define		DYNAMIC_BB_CCK_PD			BIT(5)
+#define		DYNAMIC_BB_ANT_DIV			BIT(6)
+#define		DYNAMIC_BB_PWR_SAVE			BIT(7)
+#define		DYNAMIC_BB_PWR_TRA			BIT(8)
+#define		DYNAMIC_BB_RATE_ADAPTIVE		BIT(9)
+#define		DYNAMIC_BB_PATH_DIV			BIT(10)
+#define		DYNAMIC_BB_PSD				BIT(11)
+
+/*  MAC DM section BIT 16-23 */
+#define		DYNAMIC_MAC_EDCA_TURBO		BIT(16)
+#define		DYNAMIC_MAC_EARLY_MODE		BIT(17)
+
+/*  RF ODM section BIT 24-31 */
+#define		DYNAMIC_RF_TX_PWR_TRACK		BIT(24)
+#define		DYNAMIC_RF_RX_GAIN_TRACK		BIT(25)
+#define		DYNAMIC_RF_CALIBRATION		BIT(26)
+
+#define		DYNAMIC_ALL_FUNC_ENABLE		0xFFFFFFF
+
+#define _HW_STATE_NOLINK_		0x00
+#define _HW_STATE_ADHOC_		0x01
+#define _HW_STATE_STATION_	0x02
+#define _HW_STATE_AP_			0x03
+
+#define		_1M_RATE_	0
+#define		_2M_RATE_	1
+#define		_5M_RATE_	2
+#define		_11M_RATE_	3
+#define		_6M_RATE_	4
+#define		_9M_RATE_	5
+#define		_12M_RATE_	6
+#define		_18M_RATE_	7
+#define		_24M_RATE_	8
+#define		_36M_RATE_	9
+#define		_48M_RATE_	10
+#define		_54M_RATE_	11
+
+extern unsigned char RTW_WPA_OUI[];
+extern unsigned char WMM_OUI[];
+extern unsigned char WPS_OUI[];
+extern unsigned char WFD_OUI[];
+extern unsigned char P2P_OUI[];
+
+extern unsigned char WMM_INFO_OUI[];
+extern unsigned char WMM_PARA_OUI[];
+
+/*  Channel Plan Type. */
+/*  Note: */
+/*	We just add new channel plan when the new channel plan is different
+ *      from any of the following channel plan. */
+/*	If you just want to customize the actions(scan period or join actions)
+ *      about one of the channel plan, */
+/*	customize them in struct rt_channel_info in the RT_CHANNEL_LIST. */
+enum RT_CHANNEL_DOMAIN {
+	/*  old channel plan mapping =====  */
+	RT_CHANNEL_DOMAIN_FCC = 0x00,
+	RT_CHANNEL_DOMAIN_IC = 0x01,
+	RT_CHANNEL_DOMAIN_ETSI = 0x02,
+	RT_CHANNEL_DOMAIN_SPAIN = 0x03,
+	RT_CHANNEL_DOMAIN_FRANCE = 0x04,
+	RT_CHANNEL_DOMAIN_MKK = 0x05,
+	RT_CHANNEL_DOMAIN_MKK1 = 0x06,
+	RT_CHANNEL_DOMAIN_ISRAEL = 0x07,
+	RT_CHANNEL_DOMAIN_TELEC = 0x08,
+	RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN = 0x09,
+	RT_CHANNEL_DOMAIN_WORLD_WIDE_13 = 0x0A,
+	RT_CHANNEL_DOMAIN_TAIWAN = 0x0B,
+	RT_CHANNEL_DOMAIN_CHINA = 0x0C,
+	RT_CHANNEL_DOMAIN_SINGAPORE_INDIA_MEXICO = 0x0D,
+	RT_CHANNEL_DOMAIN_KOREA = 0x0E,
+	RT_CHANNEL_DOMAIN_TURKEY = 0x0F,
+	RT_CHANNEL_DOMAIN_JAPAN = 0x10,
+	RT_CHANNEL_DOMAIN_FCC_NO_DFS = 0x11,
+	RT_CHANNEL_DOMAIN_JAPAN_NO_DFS = 0x12,
+	RT_CHANNEL_DOMAIN_WORLD_WIDE_5G = 0x13,
+	RT_CHANNEL_DOMAIN_TAIWAN_NO_DFS = 0x14,
+
+	/*  new channel plan mapping, (2GDOMAIN_5GDOMAIN) ===== */
+	RT_CHANNEL_DOMAIN_WORLD_NULL = 0x20,
+	RT_CHANNEL_DOMAIN_ETSI1_NULL = 0x21,
+	RT_CHANNEL_DOMAIN_FCC1_NULL = 0x22,
+	RT_CHANNEL_DOMAIN_MKK1_NULL = 0x23,
+	RT_CHANNEL_DOMAIN_ETSI2_NULL = 0x24,
+	RT_CHANNEL_DOMAIN_FCC1_FCC1 = 0x25,
+	RT_CHANNEL_DOMAIN_WORLD_ETSI1 = 0x26,
+	RT_CHANNEL_DOMAIN_MKK1_MKK1 = 0x27,
+	RT_CHANNEL_DOMAIN_WORLD_KCC1 = 0x28,
+	RT_CHANNEL_DOMAIN_WORLD_FCC2 = 0x29,
+	RT_CHANNEL_DOMAIN_WORLD_FCC3 = 0x30,
+	RT_CHANNEL_DOMAIN_WORLD_FCC4 = 0x31,
+	RT_CHANNEL_DOMAIN_WORLD_FCC5 = 0x32,
+	RT_CHANNEL_DOMAIN_WORLD_FCC6 = 0x33,
+	RT_CHANNEL_DOMAIN_FCC1_FCC7 = 0x34,
+	RT_CHANNEL_DOMAIN_WORLD_ETSI2 = 0x35,
+	RT_CHANNEL_DOMAIN_WORLD_ETSI3 = 0x36,
+	RT_CHANNEL_DOMAIN_MKK1_MKK2 = 0x37,
+	RT_CHANNEL_DOMAIN_MKK1_MKK3 = 0x38,
+	RT_CHANNEL_DOMAIN_FCC1_NCC1 = 0x39,
+	RT_CHANNEL_DOMAIN_FCC1_NCC2 = 0x40,
+	RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN_2G = 0x41,
+	/*  Add new channel plan above this line=============== */
+	RT_CHANNEL_DOMAIN_MAX,
+	RT_CHANNEL_DOMAIN_REALTEK_DEFINE = 0x7F,
+};
+
+enum RT_CHANNEL_DOMAIN_2G {
+	RT_CHANNEL_DOMAIN_2G_WORLD = 0x00,		/* Worldwide 13 */
+	RT_CHANNEL_DOMAIN_2G_ETSI1 = 0x01,		/* Europe */
+	RT_CHANNEL_DOMAIN_2G_FCC1 = 0x02,		/* US */
+	RT_CHANNEL_DOMAIN_2G_MKK1 = 0x03,		/* Japan */
+	RT_CHANNEL_DOMAIN_2G_ETSI2 = 0x04,		/* France */
+	RT_CHANNEL_DOMAIN_2G_NULL = 0x05,
+	/*  Add new channel plan above this line=============== */
+	RT_CHANNEL_DOMAIN_2G_MAX,
+};
+
+#define rtw_is_channel_plan_valid(chplan)			\
+	(chplan < RT_CHANNEL_DOMAIN_MAX ||			\
+	 chplan == RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
+
+struct rt_channel_plan {
+	unsigned char	Channel[MAX_CHANNEL_NUM];
+	unsigned char	Len;
+};
+
+struct rt_channel_plan_2g {
+	unsigned char	Channel[MAX_CHANNEL_NUM_2G];
+	unsigned char	Len;
+};
+
+struct rt_channel_plan_map {
+	unsigned char	Index2G;
+};
+
+enum Associated_AP {
+	atherosAP	= 0,
+	broadcomAP	= 1,
+	ciscoAP		= 2,
+	marvellAP	= 3,
+	ralinkAP	= 4,
+	realtekAP	= 5,
+	airgocapAP	= 6,
+	unknownAP	= 7,
+	maxAP,
+};
+
+enum HT_IOT_PEER {
+	HT_IOT_PEER_UNKNOWN		= 0,
+	HT_IOT_PEER_REALTEK		= 1,
+	HT_IOT_PEER_REALTEK_92SE	= 2,
+	HT_IOT_PEER_BROADCOM		= 3,
+	HT_IOT_PEER_RALINK		= 4,
+	HT_IOT_PEER_ATHEROS		= 5,
+	HT_IOT_PEER_CISCO		= 6,
+	HT_IOT_PEER_MERU		= 7,
+	HT_IOT_PEER_MARVELL		= 8,
+	HT_IOT_PEER_REALTEK_SOFTAP	= 9,/*  peer is RealTek SOFT_AP */
+	HT_IOT_PEER_SELF_SOFTAP		= 10, /*  Self is SoftAP */
+	HT_IOT_PEER_AIRGO		= 11,
+	HT_IOT_PEER_INTEL		= 12,
+	HT_IOT_PEER_RTK_APCLIENT	= 13,
+	HT_IOT_PEER_REALTEK_81XX	= 14,
+	HT_IOT_PEER_REALTEK_WOW		= 15,
+	HT_IOT_PEER_TENDA		= 16,
+	HT_IOT_PEER_MAX			= 17
+};
+
+enum SCAN_STATE {
+	SCAN_DISABLE = 0,
+	SCAN_START = 1,
+	SCAN_TXNULL = 2,
+	SCAN_PROCESS = 3,
+	SCAN_COMPLETE = 4,
+	SCAN_STATE_MAX,
+};
+
+struct mlme_handler {
+	unsigned int   num;
+	char *str;
+	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
+};
+
+struct action_handler {
+	unsigned int   num;
+	char* str;
+	unsigned int (*func)(struct adapter *adapt, struct recv_frame *frame);
+};
+
+struct	ss_res {
+	int	state;
+	int	bss_cnt;
+	int	channel_idx;
+	int	scan_mode;
+	u8 ssid_num;
+	u8 ch_num;
+	struct ndis_802_11_ssid ssid[RTW_SSID_SCAN_AMOUNT];
+	struct rtw_ieee80211_channel ch[RTW_CHANNEL_SCAN_AMOUNT];
+};
+
+/* define AP_MODE				0x0C */
+/* define STATION_MODE	0x08 */
+/* define AD_HOC_MODE		0x04 */
+/* define NO_LINK_MODE	0x00 */
+
+#define WIFI_FW_NULL_STATE		_HW_STATE_NOLINK_
+#define	WIFI_FW_STATION_STATE		_HW_STATE_STATION_
+#define	WIFI_FW_AP_STATE		_HW_STATE_AP_
+#define	WIFI_FW_ADHOC_STATE		_HW_STATE_ADHOC_
+
+#define	WIFI_FW_AUTH_NULL		0x00000100
+#define	WIFI_FW_AUTH_STATE		0x00000200
+#define	WIFI_FW_AUTH_SUCCESS		0x00000400
+
+#define	WIFI_FW_ASSOC_STATE		0x00002000
+#define	WIFI_FW_ASSOC_SUCCESS		0x00004000
+
+#define	WIFI_FW_LINKING_STATE		(WIFI_FW_AUTH_NULL |		\
+					WIFI_FW_AUTH_STATE |		\
+					WIFI_FW_AUTH_SUCCESS |		\
+					WIFI_FW_ASSOC_STATE)
+
+struct FW_Sta_Info {
+	struct sta_info	*psta;
+	u32	status;
+	u32	rx_pkt;
+	u32	retry;
+	unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
+};
+
+/*
+ * Usage:
+ * When one iface acted as AP mode and the other iface is STA mode and scanning,
+ * it should switch back to AP's operating channel periodically.
+ * Parameters info:
+ * When the driver scanned RTW_SCAN_NUM_OF_CH channels, it would switch back to
+ * AP's operating channel for
+ * RTW_STAY_AP_CH_MILLISECOND * SURVEY_TO milliseconds.
+ * Example:
+ * For chip supports 2.4G + 5GHz and AP mode is operating in channel 1,
+ * RTW_SCAN_NUM_OF_CH is 8, RTW_STAY_AP_CH_MS is 3 and SURVEY_TO is 100.
+ * When it's STA mode gets set_scan command,
+ * it would
+ * 1. Doing the scan on channel 1.2.3.4.5.6.7.8
+ * 2. Back to channel 1 for 300 milliseconds
+ * 3. Go through doing site survey on channel 9.10.11.36.40.44.48.52
+ * 4. Back to channel 1 for 300 milliseconds
+ * 5. ... and so on, till survey done.
+ */
+
+struct mlme_ext_info {
+	u32	state;
+	u32	reauth_count;
+	u32	reassoc_count;
+	u32	link_count;
+	u32	auth_seq;
+	u32	auth_algo;	/*  802.11 auth, could be open, shared, auto */
+	u32	authModeToggle;
+	u32	enc_algo;/* encrypt algorithm; */
+	u32	key_index;	/*  this is only valid for legacy wep,
+				 *  0~3 for key id. */
+	u32	iv;
+	u8	chg_txt[128];
+	u16	aid;
+	u16	bcn_interval;
+	u16	capability;
+	u8	assoc_AP_vendor;
+	u8	slotTime;
+	u8	preamble_mode;
+	u8	WMM_enable;
+	u8	ERP_enable;
+	u8	ERP_IE;
+	u8	HT_enable;
+	u8	HT_caps_enable;
+	u8	HT_info_enable;
+	u8	HT_protection;
+	u8	turboMode_cts2self;
+	u8	turboMode_rtsen;
+	u8	SM_PS;
+	u8	agg_enable_bitmap;
+	u8	ADDBA_retry_count;
+	u8	candidate_tid_bitmap;
+	u8	dialogToken;
+	/*  Accept ADDBA Request */
+	bool bAcceptAddbaReq;
+	u8	bwmode_updated;
+	u8	hidden_ssid_mode;
+
+	struct ADDBA_request	ADDBA_req;
+	struct WMM_para_element	WMM_param;
+	struct HT_caps_element	HT_caps;
+	struct HT_info_element	HT_info;
+	struct wlan_bssid_ex	network;/* join network or bss_network,
+					 * if in ap mode, it is the same
+					 * as cur_network.network */
+	struct FW_Sta_Info	FW_sta_info[NUM_STA];
+};
+
+/*  The channel information about this channel including joining,
+ *  scanning, and power constraints. */
+struct rt_channel_info {
+	u8	ChannelNum;	/*  The channel number. */
+	enum rt_scan_type ScanType;	/*  Scan type such as passive
+					 *  or active scan. */
+	u32	rx_count;
+};
+
+int rtw_ch_set_search_ch(struct rt_channel_info *ch_set, const u32 ch);
+
+/*  P2P_MAX_REG_CLASSES - Maximum number of regulatory classes */
+#define P2P_MAX_REG_CLASSES 10
+
+/*  P2P_MAX_REG_CLASS_CHANNELS - Maximum number of chan per regulatory class */
+#define P2P_MAX_REG_CLASS_CHANNELS 20
+
+/*   struct p2p_channels - List of supported channels */
+struct p2p_channels {
+	/*  struct p2p_reg_class - Supported regulatory class */
+	struct p2p_reg_class {
+		/*  reg_class - Regulatory class (IEEE 802.11-2007, Annex J) */
+		u8 reg_class;
+
+		/*  channel - Supported channels */
+		u8 channel[P2P_MAX_REG_CLASS_CHANNELS];
+
+		/*  channels - Number of channel entries in use */
+		size_t channels;
+	} reg_class[P2P_MAX_REG_CLASSES];
+
+	/*  reg_classes - Number of reg_class entries in use */
+	size_t reg_classes;
+};
+
+struct p2p_oper_class_map {
+	enum hw_mode {IEEE80211G} mode;
+	u8 op_class;
+	u8 min_chan;
+	u8 max_chan;
+	u8 inc;
+	enum {BW20, BW40PLUS, BW40MINUS} bw;
+};
+
+struct mlme_ext_priv {
+	struct adapter	*padapter;
+	u8	mlmeext_init;
+	ATOMIC_T	event_seq;
+	u16	mgnt_seq;
+
+	unsigned char	cur_channel;
+	unsigned char	cur_bwmode;
+	unsigned char	cur_ch_offset;/* PRIME_CHNL_OFFSET */
+	unsigned char	cur_wireless_mode;	/*  NETWORK_TYPE */
+
+	unsigned char	oper_channel; /* saved chan info when call
+				       * set_channel_bw */
+	unsigned char	oper_bwmode;
+	unsigned char	oper_ch_offset;/* PRIME_CHNL_OFFSET */
+
+	unsigned char	max_chan_nums;
+	struct rt_channel_info channel_set[MAX_CHANNEL_NUM];
+	struct p2p_channels channel_list;
+	unsigned char	basicrate[NumRates];
+	unsigned char	datarate[NumRates];
+
+	struct ss_res		sitesurvey_res;
+	struct mlme_ext_info	mlmext_info;/* for sta/adhoc mode, including
+					     * current scan/connecting/connected
+					     * related info. For ap mode,
+					     * network includes ap's cap_info*/
+	struct timer_list survey_timer;
+	struct timer_list link_timer;
+	u16	chan_scan_time;
+
+	u8	scan_abort;
+	u8	tx_rate; /*  TXRATE when USERATE is set. */
+
+	u32	retry; /* retry for issue probereq */
+
+	u64 TSFValue;
+
+#ifdef CONFIG_88EU_AP_MODE
+	unsigned char bstart_bss;
+#endif
+	u8 update_channel_plan_by_ap_done;
+	/* recv_decache check for Action_public frame */
+	u8 action_public_dialog_token;
+	u16	 action_public_rxseq;
+	u8 active_keep_alive_check;
+};
+
+int init_mlme_ext_priv(struct adapter *adapter);
+int init_hw_mlme_ext(struct adapter *padapter);
+void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
+extern void init_mlme_ext_timer(struct adapter *padapter);
+extern void init_addba_retry_timer(struct adapter *adapt, struct sta_info *sta);
+extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
+
+unsigned char networktype_to_raid(unsigned char network_type);
+u8 judge_network_type(struct adapter *padapter, unsigned char *rate, int len);
+void get_rate_set(struct adapter *padapter, unsigned char *pbssrate, int *len);
+void UpdateBrateTbl(struct adapter *padapter, u8 *mBratesOS);
+void UpdateBrateTblForSoftAP(u8 *bssrateset, u32 bssratelen);
+
+void Save_DM_Func_Flag(struct adapter *padapter);
+void Restore_DM_Func_Flag(struct adapter *padapter);
+void Switch_DM_Func(struct adapter *padapter, u32 mode, u8 enable);
+
+void Set_MSR(struct adapter *padapter, u8 type);
+
+u8 rtw_get_oper_ch(struct adapter *adapter);
+void rtw_set_oper_ch(struct adapter *adapter, u8 ch);
+u8 rtw_get_oper_bw(struct adapter *adapter);
+void rtw_set_oper_bw(struct adapter *adapter, u8 bw);
+u8 rtw_get_oper_choffset(struct adapter *adapter);
+void rtw_set_oper_choffset(struct adapter *adapter, u8 offset);
+
+void set_channel_bwmode(struct adapter *padapter, unsigned char channel,
+			unsigned char channel_offset, unsigned short bwmode);
+void SelectChannel(struct adapter *padapter, unsigned char channel);
+void SetBWMode(struct adapter *padapter, unsigned short bwmode,
+	       unsigned char channel_offset);
+
+unsigned int decide_wait_for_beacon_timeout(unsigned int bcn_interval);
+
+void write_cam(struct adapter *padapter, u8 entry, u16 ctrl, u8 *mac, u8 *key);
+void clear_cam_entry(struct adapter *padapter, u8 entry);
+
+void invalidate_cam_all(struct adapter *padapter);
+void CAM_empty_entry(struct adapter * Adapter, u8 ucIndex);
+
+int allocate_fw_sta_entry(struct adapter *padapter);
+void flush_all_cam_entry(struct adapter *padapter);
+
+void site_survey(struct adapter *padapter);
+u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame,
+		    struct wlan_bssid_ex *bssid);
+void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
+		    struct adapter *adapter, bool update_ie);
+
+int get_bsstype(unsigned short capability);
+u8 *get_my_bssid(struct wlan_bssid_ex *pnetwork);
+u16 get_beacon_interval(struct wlan_bssid_ex *bss);
+
+int is_client_associated_to_ap(struct adapter *padapter);
+int is_client_associated_to_ibss(struct adapter *padapter);
+int is_IBSS_empty(struct adapter *padapter);
+
+unsigned char check_assoc_AP(u8 *pframe, uint len);
+
+int WMM_param_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
+void WMMOnAssocRsp(struct adapter *padapter);
+
+void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
+void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
+void HTOnAssocRsp(struct adapter *padapter);
+
+void ERP_IE_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE);
+void VCS_update(struct adapter *padapter, struct sta_info *psta);
+
+void update_beacon_info(struct adapter *padapter, u8 *pframe, uint len,
+		        struct sta_info *psta);
+int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len);
+void update_IOT_info(struct adapter *padapter);
+void update_capinfo(struct adapter *adapter, u16 updatecap);
+void update_wireless_mode(struct adapter *padapter);
+void update_tx_basic_rate(struct adapter *padapter, u8 modulation);
+void update_bmc_sta_support_rate(struct adapter *padapter, u32 mac_id);
+int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie,
+			    uint var_ie_len, int cam_idx);
+
+/* for sta/adhoc mode */
+void update_sta_info(struct adapter *padapter, struct sta_info *psta);
+unsigned int update_basic_rate(unsigned char *ptn, unsigned int ptn_sz);
+unsigned int update_supported_rate(unsigned char *ptn, unsigned int ptn_sz);
+unsigned int update_MSC_rate(struct HT_caps_element *pHT_caps);
+void Update_RA_Entry(struct adapter *padapter, u32 mac_id);
+void set_sta_rate(struct adapter *padapter, struct sta_info *psta);
+
+unsigned int receive_disconnect(struct adapter *padapter,
+				unsigned char *macaddr, unsigned short reason);
+
+unsigned char get_highest_rate_idx(u32 mask);
+int support_short_GI(struct adapter *padapter, struct HT_caps_element *caps);
+unsigned int is_ap_in_tkip(struct adapter *padapter);
+unsigned int is_ap_in_wep(struct adapter *padapter);
+unsigned int should_forbid_n_rate(struct adapter *padapter);
+
+void report_join_res(struct adapter *padapter, int res);
+void report_survey_event(struct adapter *padapter, struct recv_frame *precv_frame);
+void report_surveydone_event(struct adapter *padapter);
+void report_del_sta_event(struct adapter *padapter,
+			  unsigned char *addr, unsigned short reason);
+void report_add_sta_event(struct adapter *padapter, unsigned char* addr,
+			  int cam_idx);
+
+void beacon_timing_control(struct adapter *padapter);
+extern u8 set_tx_beacon_cmd(struct adapter*padapter);
+unsigned int setup_beacon_frame(struct adapter *padapter,
+				unsigned char *beacon_frame);
+void update_mgnt_tx_rate(struct adapter *padapter, u8 rate);
+void update_mgntframe_attrib(struct adapter *padapter,
+			     struct pkt_attrib *pattrib);
+void dump_mgntframe(struct adapter *padapter, struct xmit_frame *pmgntframe);
+s32 dump_mgntframe_and_wait(struct adapter *padapter,
+			    struct xmit_frame *pmgntframe, int timeout_ms);
+s32 dump_mgntframe_and_wait_ack(struct adapter *padapter,
+				struct xmit_frame *pmgntframe);
+
+#ifdef CONFIG_88EU_P2P
+void issue_probersp_p2p(struct adapter *padapter, unsigned char *da);
+void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid,
+				 u8 ussidlen, u8 *pdev_raddr);
+void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr);
+void issue_probereq_p2p(struct adapter *padapter, u8 *da);
+int issue_probereq_p2p_ex(struct adapter *adapter, u8 *da, int try_cnt,
+			  int wait_ms);
+void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr,
+				   u8 dialogToken, u8 success);
+void issue_p2p_invitation_request(struct adapter *padapter, u8* raddr);
+#endif /* CONFIG_88EU_P2P */
+void issue_beacon(struct adapter *padapter, int timeout_ms);
+void issue_probersp(struct adapter *padapter, unsigned char *da,
+		    u8 is_valid_p2p_probereq);
+void issue_assocreq(struct adapter *padapter);
+void issue_asocrsp(struct adapter *padapter, unsigned short status,
+		   struct sta_info *pstat, int pkt_type);
+void issue_auth(struct adapter *padapter, struct sta_info *psta,
+		unsigned short status);
+void issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *pssid,
+		    u8 *da);
+s32 issue_probereq_ex(struct adapter *adapter, struct ndis_802_11_ssid *pssid,
+		      u8* da, int try_cnt, int wait_ms);
+int issue_nulldata(struct adapter *padapter, unsigned char *da,
+		   unsigned int power_mode, int try_cnt, int wait_ms);
+int issue_qos_nulldata(struct adapter *padapter, unsigned char *da,
+		       u16 tid, int try_cnt, int wait_ms);
+int issue_deauth(struct adapter *padapter, unsigned char *da,
+		 unsigned short reason);
+int issue_deauth_ex(struct adapter *padapter, u8 *da, unsigned short reason,
+		    int try_cnt, int wait_ms);
+void issue_action_spct_ch_switch(struct adapter *padapter, u8 *ra, u8 new_ch,
+				 u8 ch_offset);
+void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
+		     unsigned char action, unsigned short status);
+unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr);
+unsigned int send_beacon(struct adapter *padapter);
+
+void start_clnt_assoc(struct adapter *padapter);
+void start_clnt_auth(struct adapter *padapter);
+void start_clnt_join(struct adapter *padapter);
+void start_create_ibss(struct adapter *padapter);
+
+unsigned int OnAssocReq(struct adapter *padapter,
+			struct recv_frame *precv_frame);
+unsigned int OnAssocRsp(struct adapter *padapter,
+			struct recv_frame *precv_frame);
+unsigned int OnProbeReq(struct adapter *padapter,
+			struct recv_frame *precv_frame);
+unsigned int OnProbeRsp(struct adapter *padapter,
+			struct recv_frame *precv_frame);
+unsigned int DoReserved(struct adapter *padapter,
+			struct recv_frame *precv_frame);
+unsigned int OnBeacon(struct adapter *padapter,
+		      struct recv_frame *precv_frame);
+unsigned int OnAtim(struct adapter *padapter,
+		    struct recv_frame *precv_frame);
+unsigned int OnDisassoc(struct adapter *padapter,
+			struct recv_frame *precv_frame);
+unsigned int OnAuth(struct adapter *padapter,
+		    struct recv_frame *precv_frame);
+unsigned int OnAuthClient(struct adapter *padapter,
+			  struct recv_frame *precv_frame);
+unsigned int OnDeAuth(struct adapter *padapter,
+		      struct recv_frame *precv_frame);
+unsigned int OnAction(struct adapter *padapter,
+		      struct recv_frame *precv_frame);
+
+unsigned int on_action_spct(struct adapter *padapter,
+			    struct recv_frame *precv_frame);
+unsigned int OnAction_qos(struct adapter *padapter,
+			  struct recv_frame *precv_frame);
+unsigned int OnAction_dls(struct adapter *padapter,
+			  struct recv_frame *precv_frame);
+unsigned int OnAction_back(struct adapter *padapter,
+			   struct recv_frame *precv_frame);
+unsigned int on_action_public(struct adapter *padapter,
+			      struct recv_frame *precv_frame);
+unsigned int OnAction_ht(struct adapter *padapter,
+			 struct recv_frame *precv_frame);
+unsigned int OnAction_wmm(struct adapter *padapter,
+			  struct recv_frame *precv_frame);
+unsigned int OnAction_p2p(struct adapter *padapter,
+			  struct recv_frame *precv_frame);
+
+void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res);
+void mlmeext_sta_del_event_callback(struct adapter *padapter);
+void mlmeext_sta_add_event_callback(struct adapter *padapter,
+				    struct sta_info *psta);
+
+void linked_status_chk(struct adapter *padapter);
+
+void survey_timer_hdl (struct adapter *padapter);
+void link_timer_hdl (struct adapter *padapter);
+void addba_timer_hdl(struct sta_info *psta);
+
+#define set_survey_timer(mlmeext, ms) \
+	do { \
+		_set_timer(&(mlmeext)->survey_timer, (ms)); \
+	} while (0)
+
+#define set_link_timer(mlmeext, ms) \
+	do { \
+		_set_timer(&(mlmeext)->link_timer, (ms)); \
+	} while (0)
+
+int cckrates_included(unsigned char *rate, int ratelen);
+int cckratesonly_included(unsigned char *rate, int ratelen);
+
+void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
+
+void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len);
+void correct_TSF(struct adapter *padapter, struct mlme_ext_priv *pmlmeext);
+
+struct cmd_hdl {
+	uint	parmsize;
+	u8 (*h2cfuns)(struct adapter  *padapter, u8 *pbuf);
+};
+
+u8 read_macreg_hdl(struct adapter *padapter, u8 *pbuf);
+u8 write_macreg_hdl(struct adapter *padapter, u8 *pbuf);
+u8 read_bbreg_hdl(struct adapter *padapter, u8 *pbuf);
+u8 write_bbreg_hdl(struct adapter *padapter, u8 *pbuf);
+u8 read_rfreg_hdl(struct adapter *padapter, u8 *pbuf);
+u8 write_rfreg_hdl(struct adapter *padapter, u8 *pbuf);
+u8 NULL_hdl(struct adapter *padapter, u8 *pbuf);
+u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf);
+u8 disconnect_hdl(struct adapter *padapter, u8 *pbuf);
+u8 createbss_hdl(struct adapter *padapter, u8 *pbuf);
+u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf);
+u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf);
+u8 setauth_hdl(struct adapter *padapter, u8 *pbuf);
+u8 setkey_hdl(struct adapter *padapter, u8 *pbuf);
+u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf);
+u8 set_assocsta_hdl(struct adapter *padapter, u8 *pbuf);
+u8 del_assocsta_hdl(struct adapter *padapter, u8 *pbuf);
+u8 add_ba_hdl(struct adapter *padapter, unsigned char *pbuf);
+
+u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf);
+u8 h2c_msg_hdl(struct adapter *padapter, unsigned char *pbuf);
+u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
+u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
+u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
+u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
+/* Handling DFS channel switch announcement ie. */
+u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);
+u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
+
+#define GEN_DRV_CMD_HANDLER(size, cmd)	{size, &cmd ## _hdl},
+#define GEN_MLME_EXT_HANDLER(size, cmd)	{size, cmd},
+
+#ifdef _RTW_CMD_C_
+
+static struct cmd_hdl wlancmds[] = {
+	GEN_DRV_CMD_HANDLER(0, NULL) /*0*/
+	GEN_DRV_CMD_HANDLER(0, NULL)
+	GEN_DRV_CMD_HANDLER(0, NULL)
+	GEN_DRV_CMD_HANDLER(0, NULL)
+	GEN_DRV_CMD_HANDLER(0, NULL)
+	GEN_DRV_CMD_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL) /*10*/
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct joinbss_parm), join_cmd_hdl) /*14*/
+	GEN_MLME_EXT_HANDLER(sizeof (struct disconnect_parm), disconnect_hdl)
+	GEN_MLME_EXT_HANDLER(sizeof (struct createbss_parm), createbss_hdl)
+	GEN_MLME_EXT_HANDLER(sizeof (struct setopmode_parm), setopmode_hdl)
+	GEN_MLME_EXT_HANDLER(sizeof (struct sitesurvey_parm),
+			     sitesurvey_cmd_hdl) /*18*/
+	GEN_MLME_EXT_HANDLER(sizeof (struct setauth_parm), setauth_hdl)
+	GEN_MLME_EXT_HANDLER(sizeof (struct setkey_parm), setkey_hdl) /*20*/
+	GEN_MLME_EXT_HANDLER(sizeof (struct set_stakey_parm), set_stakey_hdl)
+	GEN_MLME_EXT_HANDLER(sizeof (struct set_assocsta_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct del_assocsta_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct setstapwrstate_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct setbasicrate_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct getbasicrate_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct setdatarate_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct getdatarate_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct setphyinfo_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct getphyinfo_parm), NULL)  /*30*/
+	GEN_MLME_EXT_HANDLER(sizeof (struct setphy_parm), NULL)
+	GEN_MLME_EXT_HANDLER(sizeof (struct getphy_parm), NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)	/*40*/
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(sizeof(struct addBaReq_parm), add_ba_hdl)
+	GEN_MLME_EXT_HANDLER(sizeof(struct set_ch_parm), set_ch_hdl) /* 46 */
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL) /*50*/
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(0, NULL)
+	GEN_MLME_EXT_HANDLER(sizeof(struct Tx_Beacon_param),
+			     tx_beacon_hdl) /*55*/
+
+	GEN_MLME_EXT_HANDLER(0, mlme_evt_hdl) /*56*/
+	GEN_MLME_EXT_HANDLER(0, rtw_drvextra_cmd_hdl) /*57*/
+
+	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param),
+			     set_chplan_hdl) /*59*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param),
+			     led_blink_hdl) /*60*/
+
+	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param),
+			     set_csa_hdl) /*61*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param),
+			     tdls_hdl) /*62*/
+};
+
+#endif
+
+struct C2HEvent_Header {
+#ifdef __LITTLE_ENDIAN
+	unsigned int len:16;
+	unsigned int ID:8;
+	unsigned int seq:8;
+#elif defined(__BIG_ENDIAN)
+	unsigned int seq:8;
+	unsigned int ID:8;
+	unsigned int len:16;
+#endif
+	unsigned int rsvd;
+};
+
+void rtw_dummy_event_callback(struct adapter *adapter, u8 *pbuf);
+void rtw_fwdbg_event_callback(struct adapter *adapter, u8 *pbuf);
+
+enum rtw_c2h_event {
+	GEN_EVT_CODE(_Read_MACREG) = 0, /*0*/
+	GEN_EVT_CODE(_Read_BBREG),
+	GEN_EVT_CODE(_Read_RFREG),
+	GEN_EVT_CODE(_Read_EEPROM),
+	GEN_EVT_CODE(_Read_EFUSE),
+	GEN_EVT_CODE(_Read_CAM),	/*5*/
+	GEN_EVT_CODE(_Get_BasicRate),
+	GEN_EVT_CODE(_Get_DataRate),
+	GEN_EVT_CODE(_Survey),	 /*8*/
+	GEN_EVT_CODE(_SurveyDone),	 /*9*/
+
+	GEN_EVT_CODE(_JoinBss) , /*10*/
+	GEN_EVT_CODE(_AddSTA),
+	GEN_EVT_CODE(_DelSTA),
+	GEN_EVT_CODE(_AtimDone),
+	GEN_EVT_CODE(_TX_Report),
+	GEN_EVT_CODE(_CCX_Report),		/*15*/
+	GEN_EVT_CODE(_DTM_Report),
+	GEN_EVT_CODE(_TX_Rate_Statistics),
+	GEN_EVT_CODE(_C2HLBK),
+	GEN_EVT_CODE(_FWDBG),
+	GEN_EVT_CODE(_C2HFEEDBACK),             /*20*/
+	GEN_EVT_CODE(_ADDBA),
+	GEN_EVT_CODE(_C2HBCN),
+	GEN_EVT_CODE(_ReportPwrState),	/* filen: only for PCIE, USB */
+	GEN_EVT_CODE(_CloseRF),		/* filen: only for PCIE,
+					 * work around ASPM */
+	MAX_C2HEVT
+};
+
+#ifdef _RTW_MLME_EXT_C_
+
+static struct fwevent wlanevents[] = {
+	{0, rtw_dummy_event_callback},	/*0*/
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, &rtw_survey_event_callback},		/*8*/
+	{sizeof (struct surveydone_event), &rtw_surveydone_event_callback},/*9*/
+	{0, &rtw_joinbss_event_callback},		/*10*/
+	{sizeof(struct stassoc_event), &rtw_stassoc_event_callback},
+	{sizeof(struct stadel_event), &rtw_stadel_event_callback},
+	{0, &rtw_atimdone_event_callback},
+	{0, rtw_dummy_event_callback},
+	{0, NULL},	/*15*/
+	{0, NULL},
+	{0, NULL},
+	{0, NULL},
+	{0, rtw_fwdbg_event_callback},
+	{0, NULL},	 /*20*/
+	{0, NULL},
+	{0, NULL},
+	{0, &rtw_cpwm_event_callback},
+	{0, NULL},
+};
+
+#endif/* _RTL_MLME_EXT_C_ */
+
+#endif /* __RTW_MLME_EXT_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_mp.h b/drivers/staging/r8188eu/include/rtw_mp.h
new file mode 100644
index 000000000000..9111e58e0598
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_mp.h
@@ -0,0 +1,492 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_MP_H_
+#define _RTW_MP_H_
+
+/*	00 - Success */
+/*	11 - Error */
+#define STATUS_SUCCESS				(0x00000000L)
+#define STATUS_PENDING				(0x00000103L)
+
+#define STATUS_UNSUCCESSFUL			(0xC0000001L)
+#define STATUS_INSUFFICIENT_RESOURCES		(0xC000009AL)
+#define STATUS_NOT_SUPPORTED			(0xC00000BBL)
+
+#define NDIS_STATUS_SUCCESS			((int)STATUS_SUCCESS)
+#define NDIS_STATUS_PENDING			((int)STATUS_PENDING)
+#define NDIS_STATUS_NOT_RECOGNIZED		((int)0x00010001L)
+#define NDIS_STATUS_NOT_COPIED			((int)0x00010002L)
+#define NDIS_STATUS_NOT_ACCEPTED		((int)0x00010003L)
+#define NDIS_STATUS_CALL_ACTIVE			((int)0x00010007L)
+
+#define NDIS_STATUS_FAILURE			((int)STATUS_UNSUCCESSFUL)
+#define NDIS_STATUS_RESOURCES		((int)STATUS_INSUFFICIENT_RESOURCES)
+#define NDIS_STATUS_CLOSING			((int)0xC0010002L)
+#define NDIS_STATUS_BAD_VERSION			((int)0xC0010004L)
+#define NDIS_STATUS_BAD_CHARACTERISTICS		((int)0xC0010005L)
+#define NDIS_STATUS_ADAPTER_NOT_FOUND		((int)0xC0010006L)
+#define NDIS_STATUS_OPEN_FAILED			((int)0xC0010007L)
+#define NDIS_STATUS_DEVICE_FAILED		((int)0xC0010008L)
+#define NDIS_STATUS_MULTICAST_FULL		((int)0xC0010009L)
+#define NDIS_STATUS_MULTICAST_EXISTS		((int)0xC001000AL)
+#define NDIS_STATUS_MULTICAST_NOT_FOUND		((int)0xC001000BL)
+#define NDIS_STATUS_REQUEST_ABORTED		((int)0xC001000CL)
+#define NDIS_STATUS_RESET_IN_PROGRESS		((int)0xC001000DL)
+#define NDIS_STATUS_CLOSING_INDICATING		((int)0xC001000EL)
+#define NDIS_STATUS_NOT_SUPPORTED		((int)STATUS_NOT_SUPPORTED)
+#define NDIS_STATUS_INVALID_PACKET		((int)0xC001000FL)
+#define NDIS_STATUS_OPEN_LIST_FULL		((int)0xC0010010L)
+#define NDIS_STATUS_ADAPTER_NOT_READY		((int)0xC0010011L)
+#define NDIS_STATUS_ADAPTER_NOT_OPEN		((int)0xC0010012L)
+#define NDIS_STATUS_NOT_INDICATING		((int)0xC0010013L)
+#define NDIS_STATUS_INVALID_LENGTH		((int)0xC0010014L)
+#define NDIS_STATUS_INVALID_DATA		((int)0xC0010015L)
+#define NDIS_STATUS_BUFFER_TOO_SHORT		((int)0xC0010016L)
+#define NDIS_STATUS_INVALID_OID			((int)0xC0010017L)
+#define NDIS_STATUS_ADAPTER_REMOVED		((int)0xC0010018L)
+#define NDIS_STATUS_UNSUPPORTED_MEDIA		((int)0xC0010019L)
+#define NDIS_STATUS_GROUP_ADDRESS_IN_USE	((int)0xC001001AL)
+#define NDIS_STATUS_FILE_NOT_FOUND		((int)0xC001001BL)
+#define NDIS_STATUS_ERROR_READING_FILE		((int)0xC001001CL)
+#define NDIS_STATUS_ALREADY_MAPPED		((int)0xC001001DL)
+#define NDIS_STATUS_RESOURCE_CONFLICT		((int)0xC001001EL)
+#define NDIS_STATUS_NO_CABLE			((int)0xC001001FL)
+
+#define NDIS_STATUS_INVALID_SAP			((int)0xC0010020L)
+#define NDIS_STATUS_SAP_IN_USE			((int)0xC0010021L)
+#define NDIS_STATUS_INVALID_ADDRESS		((int)0xC0010022L)
+#define NDIS_STATUS_VC_NOT_ACTIVATED		((int)0xC0010023L)
+#define NDIS_STATUS_DEST_OUT_OF_ORDER		((int)0xC0010024L)  /*cause 27*/
+#define NDIS_STATUS_VC_NOT_AVAILABLE		((int)0xC0010025L)  /*cause 35,45 */
+#define NDIS_STATUS_CELLRATE_NOT_AVAILABLE	((int)0xC0010026L)  /*cause 37*/
+#define NDIS_STATUS_INCOMPATABLE_QOS		((int)0xC0010027L)  /*cause 49*/
+#define NDIS_STATUS_AAL_PARAMS_UNSUPPORTED	((int)0xC0010028L)  /*cause 93*/
+#define NDIS_STATUS_NO_ROUTE_TO_DESTINATION	((int)0xC0010029L)  /*cause 3 */
+
+enum antenna_path {
+	ANTENNA_NONE = 0x00,
+	ANTENNA_D,
+	ANTENNA_C,
+	ANTENNA_CD,
+	ANTENNA_B,
+	ANTENNA_BD,
+	ANTENNA_BC,
+	ANTENNA_BCD,
+	ANTENNA_A,
+	ANTENNA_AD,
+	ANTENNA_AC,
+	ANTENNA_ACD,
+	ANTENNA_AB,
+	ANTENNA_ABD,
+	ANTENNA_ABC,
+	ANTENNA_ABCD
+};
+
+#define MAX_MP_XMITBUF_SZ	2048
+#define NR_MP_XMITFRAME		8
+
+struct mp_xmit_frame {
+	struct list_head list;
+	struct pkt_attrib attrib;
+	struct sk_buff *pkt;
+	int frame_tag;
+	struct adapter *padapter;
+	struct urb *pxmit_urb[8];
+	/* insert urb, irp, and irpcnt info below... */
+	u8 *mem_addr;
+	u32 sz[8];
+	u8 bpending[8];
+	int ac_tag[8];
+	int last[8];
+	uint irpcnt;
+	uint fragcnt;
+	uint mem[(MAX_MP_XMITBUF_SZ >> 2)];
+};
+
+struct mp_wiparam {
+	u32 bcompleted;
+	u32 act_type;
+	u32 io_offset;
+	u32 io_value;
+};
+
+typedef void(*wi_act_func)(void *padapter);
+
+struct mp_tx {
+	u8 stop;
+	u32 count, sended;
+	u8 payload;
+	struct pkt_attrib attrib;
+	struct tx_desc desc;
+	u8 *pallocated_buf;
+	u8 *buf;
+	u32 buf_size, write_size;
+	void *PktTxThread;
+};
+
+#include <Hal8188EPhyCfg.h>
+
+#define MP_MAX_LINES		1000
+#define MP_MAX_LINES_BYTES	256
+
+typedef void (*MPT_WORK_ITEM_HANDLER)(void *Adapter);
+
+struct mpt_context {
+	/*  Indicate if we have started Mass Production Test. */
+	bool			bMassProdTest;
+
+	/*  Indicate if the driver is unloading or unloaded. */
+	bool			bMptDrvUnload;
+
+	struct semaphore MPh2c_Sema;
+	struct timer_list MPh2c_timeout_timer;
+/*  Event used to sync H2c for BT control */
+
+	bool		MptH2cRspEvent;
+	bool		MptBtC2hEvent;
+	bool		bMPh2c_timeout;
+
+	/* 8190 PCI does not support NDIS_WORK_ITEM. */
+	/*  Work Item for Mass Production Test. */
+	/*  Event used to sync the case unloading driver and MptWorkItem
+	 *  is still in progress. */
+	/*  Indicate a MptWorkItem is scheduled and not yet finished. */
+	bool			bMptWorkItemInProgress;
+	/*  An instance which implements function and context of MptWorkItem. */
+	MPT_WORK_ITEM_HANDLER	CurrMptAct;
+
+	/*  1=Start, 0=Stop from UI. */
+	u32	MptTestStart;
+	/*  _TEST_MODE, defined in MPT_Req2.h */
+	u32	MptTestItem;
+	/*  Variable needed in each implementation of CurrMptAct. */
+	u32	MptActType;	/*  Type of action performed in CurrMptAct. */
+	/*  The Offset of IO operation is depend of MptActType. */
+	u32	MptIoOffset;
+	/*  The Value of IO operation is depend of MptActType. */
+	u32	MptIoValue;
+	/*  The RfPath of IO operation is depend of MptActType. */
+	u32	MptRfPath;
+
+	enum wireless_mode MptWirelessModeToSw;	/*  Wireless mode to switch. */
+	u8	MptChannelToSw;		/*  Channel to switch. */
+	u8	MptInitGainToSet;	/*  Initial gain to set. */
+	u32	MptBandWidth;		/*  bandwidth to switch. */
+	u32	MptRateIndex;		/*  rate index. */
+	/*  Register value kept for Single Carrier Tx test. */
+	u8	btMpCckTxPower;
+	/*  Register value kept for Single Carrier Tx test. */
+	u8	btMpOfdmTxPower;
+	/*  For MP Tx Power index */
+	u8	TxPwrLevel[2];	/*  rf-A, rf-B */
+
+	/*  Content of RCR Regsiter for Mass Production Test. */
+	u32	MptRCR;
+	/*  true if we only receive packets with specific pattern. */
+	bool	bMptFilterPattern;
+	/*  Rx OK count, statistics used in Mass Production Test. */
+	u32	MptRxOkCnt;
+	/*  Rx CRC32 error count, statistics used in Mass Production Test. */
+	u32	MptRxCrcErrCnt;
+
+	bool	bCckContTx;	/*  true if we are in CCK Continuous Tx test. */
+	bool	bOfdmContTx;	/*  true if we are in OFDM Continuous Tx test. */
+	bool	bStartContTx;	/*  true if we have start Continuous Tx test. */
+	/*  true if we are in Single Carrier Tx test. */
+	bool	bSingleCarrier;
+	/*  true if we are in Carrier Suppression Tx Test. */
+	bool	bCarrierSuppression;
+	/* true if we are in Single Tone Tx test. */
+	bool	bSingleTone;
+
+	/*  ACK counter asked by K.Y.. */
+	bool	bMptEnableAckCounter;
+	u32	MptAckCounter;
+
+	u8	APK_bound[2];	/* for APK	path A/path B */
+	bool	bMptIndexEven;
+
+	u8	backup0xc50;
+	u8	backup0xc58;
+	u8	backup0xc30;
+	u8	backup0x52_RF_A;
+	u8	backup0x52_RF_B;
+
+	u8	h2cReqNum;
+	u8	c2hBuf[20];
+
+	u8	btInBuf[100];
+	u32	mptOutLen;
+	u8	mptOutBuf[100];
+};
+
+enum {
+	WRITE_REG = 1,
+	READ_REG,
+	WRITE_RF,
+	READ_RF,
+	MP_START,
+	MP_STOP,
+	MP_RATE,
+	MP_CHANNEL,
+	MP_BANDWIDTH,
+	MP_TXPOWER,
+	MP_ANT_TX,
+	MP_ANT_RX,
+	MP_CTX,
+	MP_QUERY,
+	MP_ARX,
+	MP_PSD,
+	MP_PWRTRK,
+	MP_THER,
+	MP_IOCTL,
+	EFUSE_GET,
+	EFUSE_SET,
+	MP_RESET_STATS,
+	MP_DUMP,
+	MP_PHYPARA,
+	MP_SetRFPathSwh,
+	MP_QueryDrvStats,
+	MP_SetBT,
+	CTA_TEST,
+	MP_NULL,
+};
+
+struct mp_priv {
+	struct adapter *papdater;
+
+	/* Testing Flag */
+	/* 0 for normal type packet, 1 for loopback packet (16bytes TXCMD) */
+	u32 mode;
+
+	u32 prev_fw_state;
+
+	/* OID cmd handler */
+	struct mp_wiparam workparam;
+
+	/* Tx Section */
+	u8 TID;
+	u32 tx_pktcount;
+	struct mp_tx tx;
+
+	/* Rx Section */
+	u32 rx_pktcount;
+	u32 rx_crcerrpktcount;
+	u32 rx_pktloss;
+
+	struct recv_stat rxstat;
+
+	/* RF/BB relative */
+	u8 channel;
+	u8 bandwidth;
+	u8 prime_channel_offset;
+	u8 txpoweridx;
+	u8 txpoweridx_b;
+	u8 rateidx;
+	u32 preamble;
+	u32 CrystalCap;
+
+	u16 antenna_tx;
+	u16 antenna_rx;
+
+	u8 check_mp_pkt;
+
+	u8 bSetTxPower;
+
+	struct wlan_network mp_network;
+	unsigned char network_macaddr[ETH_ALEN];
+
+	u8 *pallocated_mp_xmitframe_buf;
+	u8 *pmp_xmtframe_buf;
+	struct __queue free_mp_xmitqueue;
+	u32 free_mp_xmitframe_cnt;
+
+	struct mpt_context MptCtx;
+};
+
+struct iocmd_struct {
+	u8	cmdclass;
+	u16	value;
+	u8	index;
+};
+
+struct rf_reg_param {
+	u32 path;
+	u32 offset;
+	u32 value;
+};
+
+struct bb_reg_param {
+	u32 offset;
+	u32 value;
+};
+/*  */
+
+#define LOWER	true
+#define RAISE	false
+
+/* Hardware Registers */
+#define BB_REG_BASE_ADDR		0x800
+
+/* MP variables */
+enum mp_mode_{
+	MP_OFF,
+	MP_ON,
+	MP_ERR,
+	MP_CONTINUOUS_TX,
+	MP_SINGLE_CARRIER_TX,
+	MP_CARRIER_SUPPRISSION_TX,
+	MP_SINGLE_TONE_TX,
+	MP_PACKET_TX,
+	MP_PACKET_RX
+};
+
+extern u8 mpdatarate[NumRates];
+
+/* MP set force data rate base on the definition. */
+enum mpt_rate_index {
+	/* CCK rate. */
+	MPT_RATE_1M,	/* 0 */
+	MPT_RATE_2M,
+	MPT_RATE_55M,
+	MPT_RATE_11M,	/* 3 */
+
+	/* OFDM rate. */
+	MPT_RATE_6M,	/* 4 */
+	MPT_RATE_9M,
+	MPT_RATE_12M,
+	MPT_RATE_18M,
+	MPT_RATE_24M,
+	MPT_RATE_36M,
+	MPT_RATE_48M,
+	MPT_RATE_54M,	/* 11 */
+
+	/* HT rate. */
+	MPT_RATE_MCS0,	/* 12 */
+	MPT_RATE_MCS1,
+	MPT_RATE_MCS2,
+	MPT_RATE_MCS3,
+	MPT_RATE_MCS4,
+	MPT_RATE_MCS5,
+	MPT_RATE_MCS6,
+	MPT_RATE_MCS7,	/* 19 */
+	MPT_RATE_MCS8,
+	MPT_RATE_MCS9,
+	MPT_RATE_MCS10,
+	MPT_RATE_MCS11,
+	MPT_RATE_MCS12,
+	MPT_RATE_MCS13,
+	MPT_RATE_MCS14,
+	MPT_RATE_MCS15,	/* 27 */
+	MPT_RATE_LAST
+};
+
+#define MAX_TX_PWR_INDEX_N_MODE 64	/*  0x3F */
+
+enum power_mode {
+	POWER_LOW = 0,
+	POWER_NORMAL
+};
+
+#define RX_PKT_BROADCAST	1
+#define RX_PKT_DEST_ADDR	2
+#define RX_PKT_PHY_MATCH	3
+
+enum encry_ctrl_state {
+	HW_CONTROL,		/* hw encryption& decryption */
+	SW_CONTROL,		/* sw encryption& decryption */
+	HW_ENCRY_SW_DECRY,	/* hw encryption & sw decryption */
+	SW_ENCRY_HW_DECRY	/* sw encryption & hw decryption */
+};
+
+s32 init_mp_priv(struct adapter *padapter);
+void free_mp_priv(struct mp_priv *pmp_priv);
+s32 MPT_InitializeAdapter(struct adapter *padapter, u8 Channel);
+void MPT_DeInitAdapter(struct adapter *padapter);
+s32 mp_start_test(struct adapter *padapter);
+void mp_stop_test(struct adapter *padapter);
+
+u32 _read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask);
+void _write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 bitmask, u32 val);
+
+u32 read_macreg(struct adapter *padapter, u32 addr, u32 sz);
+void write_macreg(struct adapter *padapter, u32 addr, u32 val, u32 sz);
+u32 read_bbreg(struct adapter *padapter, u32 addr, u32 bitmask);
+void write_bbreg(struct adapter *padapter, u32 addr, u32 bitmask, u32 val);
+u32 read_rfreg(struct adapter *padapter, u8 rfpath, u32 addr);
+void write_rfreg(struct adapter *padapter, u8 rfpath, u32 addr, u32 val);
+
+void	SetChannel(struct adapter *pAdapter);
+void	SetBandwidth(struct adapter *pAdapter);
+void	SetTxPower(struct adapter *pAdapter);
+void	SetAntennaPathPower(struct adapter *pAdapter);
+void	SetDataRate(struct adapter *pAdapter);
+
+void	SetAntenna(struct adapter *pAdapter);
+
+s32	SetThermalMeter(struct adapter *pAdapter, u8 target_ther);
+void	GetThermalMeter(struct adapter *pAdapter, u8 *value);
+
+void	SetContinuousTx(struct adapter *pAdapter, u8 bStart);
+void	SetSingleCarrierTx(struct adapter *pAdapter, u8 bStart);
+void	SetSingleToneTx(struct adapter *pAdapter, u8 bStart);
+void	SetCarrierSuppressionTx(struct adapter *pAdapter, u8 bStart);
+void PhySetTxPowerLevel(struct adapter *pAdapter);
+
+void	fill_txdesc_for_mp(struct adapter *padapter, struct tx_desc *ptxdesc);
+void	SetPacketTx(struct adapter *padapter);
+void	SetPacketRx(struct adapter *pAdapter, u8 bStartRx);
+
+void	ResetPhyRxPktCount(struct adapter *pAdapter);
+u32	GetPhyRxPktReceived(struct adapter *pAdapter);
+u32	GetPhyRxPktCRC32Error(struct adapter *pAdapter);
+
+s32	SetPowerTracking(struct adapter *padapter, u8 enable);
+void	GetPowerTracking(struct adapter *padapter, u8 *enable);
+u32	mp_query_psd(struct adapter *pAdapter, u8 *data);
+void Hal_SetAntenna(struct adapter *pAdapter);
+void Hal_SetBandwidth(struct adapter *pAdapter);
+void Hal_SetTxPower(struct adapter *pAdapter);
+void Hal_SetCarrierSuppressionTx(struct adapter *pAdapter, u8 bStart);
+void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart);
+void Hal_SetSingleCarrierTx (struct adapter *pAdapter, u8 bStart);
+void Hal_SetContinuousTx (struct adapter *pAdapter, u8 bStart);
+void Hal_SetBandwidth(struct adapter *pAdapter);
+void Hal_SetDataRate(struct adapter *pAdapter);
+void Hal_SetChannel(struct adapter *pAdapter);
+void Hal_SetAntennaPathPower(struct adapter *pAdapter);
+s32 Hal_SetThermalMeter(struct adapter *pAdapter, u8 target_ther);
+s32 Hal_SetPowerTracking(struct adapter *padapter, u8 enable);
+void Hal_GetPowerTracking(struct adapter *padapter, u8 * enable);
+void Hal_GetThermalMeter(struct adapter *pAdapter, u8 *value);
+void Hal_mpt_SwitchRfSetting(struct adapter *pAdapter);
+void Hal_MPT_CCKTxPowerAdjust(struct adapter * Adapter, bool bInCH14);
+void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *pAdapter, bool beven);
+void Hal_SetCCKTxPower(struct adapter *pAdapter, u8 * TxPower);
+void Hal_SetOFDMTxPower(struct adapter *pAdapter, u8 * TxPower);
+void Hal_TriggerRFThermalMeter(struct adapter *pAdapter);
+u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter);
+void Hal_SetCCKContinuousTx(struct adapter *pAdapter, u8 bStart);
+void Hal_SetOFDMContinuousTx(struct adapter *pAdapter, u8 bStart);
+void Hal_ProSetCrystalCap (struct adapter *pAdapter , u32 CrystalCapVal);
+void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv);
+void MP_PHY_SetRFPathSwitch(struct adapter *pAdapter ,bool bMain);
+
+#endif /* _RTW_MP_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
new file mode 100644
index 000000000000..12835e448d80
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
@@ -0,0 +1,339 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_MP_IOCTL_H_
+#define _RTW_MP_IOCTL_H_
+
+#include <drv_types.h>
+#include <mp_custom_oid.h>
+#include <rtw_ioctl.h>
+#include <rtw_ioctl_rtl.h>
+#include <rtw_efuse.h>
+#include <rtw_mp.h>
+
+/*  */
+struct cfg_dbg_msg_struct {
+	u32 DebugLevel;
+	u32 DebugComponent_H32;
+	u32 DebugComponent_L32;
+};
+
+struct mp_rw_reg {
+	u32 offset;
+	u32 width;
+	u32 value;
+};
+
+struct efuse_access_struct {
+	u16	start_addr;
+	u16	cnts;
+	u8	data[0];
+};
+
+struct burst_rw_reg {
+	u32 offset;
+	u32 len;
+	u8 Data[256];
+};
+
+struct usb_vendor_req {
+	u8	bRequest;
+	u16	wValue;
+	u16	wIndex;
+	u16	wLength;
+	u8	u8Dir;/* 0:OUT, 1:IN */
+	u8	u8InData;
+};
+
+struct dr_variable_struct {
+	u8 offset;
+	u32 variable;
+};
+
+#define _irqlevel_changed_(a, b)
+
+/* rtl8188eu_oid_rtl_seg_81_80_00 */
+int rtl8188eu_oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_priv);
+
+/* rtl8188eu_oid_rtl_seg_81_80_20 */
+int rtl8188eu_oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *par_priv);
+int rtl8188eu_oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv *par_priv);
+int rtl8188eu_oid_rt_pro_set_modulation_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *par_priv);
+int rtl8188eu_oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_priv);
+
+/* rtl8188eu_oid_rtl_seg_81_87 */
+int rtl8188eu_oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv);
+
+/* rtl8188eu_oid_rtl_seg_81_85 */
+int rtl8188eu_oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+
+/*  rtl8188eu_oid_rtl_seg_87_11_00 */
+int rtl8188eu_oid_rt_pro8711_join_bss_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_burst_read_register_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_burst_write_register_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_write_txcmd_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_read16_eeprom_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_write16_eeprom_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro8711_wi_poll_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro8711_pkt_loss_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_rd_attrib_mem_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_wr_attrib_mem_hdl (struct oid_par_priv *poid_par_priv);
+int  rtl8188eu_oid_rt_pro_set_rf_intfs_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_poll_rx_status_hdl(struct oid_par_priv *poid_par_priv);
+/*  rtl8188eu_oid_rtl_seg_87_11_20 */
+int rtl8188eu_oid_rt_pro_cfg_debug_message_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_data_rate_ex_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_basic_rate_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_read_tssi_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_power_tracking_hdl(struct oid_par_priv *poid_par_priv);
+/* rtl8188eu_oid_rtl_seg_87_11_50 */
+int rtl8188eu_oid_rt_pro_qry_pwrstate_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_pwrstate_hdl(struct oid_par_priv *poid_par_priv);
+/* rtl8188eu_oid_rtl_seg_87_11_F0 */
+int rtl8188eu_oid_rt_pro_h2c_set_rate_table_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_h2c_get_rate_table_hdl(struct oid_par_priv *poid_par_priv);
+
+/* rtl8188eu_oid_rtl_seg_87_12_00 */
+int rtl8188eu_oid_rt_pro_encryption_ctrl_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_add_sta_info_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_dele_sta_info_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_query_dr_variable_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_efuse_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_set_crystal_cap_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_get_efuse_max_size_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_tx_agc_offset_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_set_pkt_test_mode_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_get_thermal_meter_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv *par_priv);
+int rtl8188eu_oid_rt_set_power_down_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_get_power_mode_hdl(struct oid_par_priv *poid_par_priv);
+int rtl8188eu_oid_rt_pro_trigger_gpio_hdl(struct oid_par_priv *poid_par_priv);
+
+#ifdef _RTW_MP_IOCTL_C_
+
+static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_00[] = {
+	{1, &oid_null_function},		/* 0x00	OID_RT_PRO_RESET_DUT */
+	{1, &rtl8188eu_oid_rt_pro_set_data_rate_hdl},	/* 0x01 */
+	{1, &rtl8188eu_oid_rt_pro_start_test_hdl},	/* 0x02 */
+	{1, &rtl8188eu_oid_rt_pro_stop_test_hdl},		/* 0x03 */
+	{1, &oid_null_function},	/* 0x04	OID_RT_PRO_SET_PREAMBLE */
+	{1, &oid_null_function},	/* 0x05	OID_RT_PRO_SET_SCRAMBLER */
+	{1, &oid_null_function},	/* 0x06	OID_RT_PRO_SET_FILTER_BB */
+	{1, &oid_null_function},/* 0x07	OID_RT_PRO_SET_MANUAL_DIVERSITY_BB */
+	{1, &rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl},	/* 0x08 */
+	{1, &oid_null_function},/* 0x09	OID_RT_PRO_SET_SLEEP_MODE_DIRECT_CALL */
+	{1, &oid_null_function},/* 0x0A	OID_RT_PRO_SET_WAKE_MODE_DIRECT_CALL */
+	{1, &rtl8188eu_oid_rt_pro_set_continuous_tx_hdl},	/* 0x0B	OID_RT_PRO_SET_TX_CONTINUOUS_DIRECT_CALL */
+	{1, &rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl},/* 0x0C	OID_RT_PRO_SET_SINGLE_CARRIER_TX_CONTINUOUS */
+	{1, &oid_null_function},	/* 0x0D	OID_RT_PRO_SET_TX_ANTENNA_BB */
+	{1, &rtl8188eu_oid_rt_pro_set_antenna_bb_hdl},	/* 0x0E */
+	{1, &oid_null_function},		/* 0x0F	OID_RT_PRO_SET_CR_SCRAMBLER */
+	{1, &oid_null_function},		/* 0x10	OID_RT_PRO_SET_CR_NEW_FILTER */
+	{1, &rtl8188eu_oid_rt_pro_set_tx_power_control_hdl},/* 0x11 OID_RT_PRO_SET_TX_POWER_CONTROL */
+	{1, &oid_null_function},	/* 0x12	OID_RT_PRO_SET_CR_TX_CONFIG */
+	{1, &oid_null_function},	/* 0x13	OID_RT_PRO_GET_TX_POWER_CONTROL */
+	{1, &oid_null_function},	/* 0x14	OID_RT_PRO_GET_CR_SIGNAL_QUALITY */
+	{1, &oid_null_function},	/* 0x15	OID_RT_PRO_SET_CR_SETPOINT */
+	{1, &oid_null_function},	/* 0x16	OID_RT_PRO_SET_INTEGRATOR */
+	{1, &oid_null_function},	/* 0x17	OID_RT_PRO_SET_SIGNAL_QUALITY */
+	{1, &oid_null_function},	/* 0x18	OID_RT_PRO_GET_INTEGRATOR */
+	{1, &oid_null_function},	/* 0x19	OID_RT_PRO_GET_SIGNAL_QUALITY */
+	{1, &oid_null_function},	/* 0x1A	OID_RT_PRO_QUERY_EEPROM_TYPE */
+	{1, &oid_null_function},	/* 0x1B	OID_RT_PRO_WRITE_MAC_ADDRESS */
+	{1, &oid_null_function},	/* 0x1C	OID_RT_PRO_READ_MAC_ADDRESS */
+	{1, &oid_null_function},	/* 0x1D	OID_RT_PRO_WRITE_CIS_DATA */
+	{1, &oid_null_function},	/* 0x1E	OID_RT_PRO_READ_CIS_DATA */
+	{1, &oid_null_function}		/* 0x1F	OID_RT_PRO_WRITE_POWER_CONTROL */
+};
+
+static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_20[] = {
+	{1, &oid_null_function},	/* 0x20	OID_RT_PRO_READ_POWER_CONTROL */
+	{1, &oid_null_function},	/* 0x21	OID_RT_PRO_WRITE_EEPROM */
+	{1, &oid_null_function},	/* 0x22	OID_RT_PRO_READ_EEPROM */
+	{1, &rtl8188eu_oid_rt_pro_reset_tx_packet_sent_hdl},	/* 0x23 */
+	{1, &rtl8188eu_oid_rt_pro_query_tx_packet_sent_hdl},	/* 0x24 */
+	{1, &rtl8188eu_oid_rt_pro_reset_rx_packet_received_hdl},	/* 0x25 */
+	{1, &rtl8188eu_oid_rt_pro_query_rx_packet_received_hdl},	/* 0x26 */
+	{1, &rtl8188eu_oid_rt_pro_query_rx_packet_crc32_error_hdl},	/* 0x27 */
+	{1, &oid_null_function},	/* 0x28	OID_RT_PRO_QUERY_CURRENT_ADDRESS */
+	{1, &oid_null_function},	/* 0x29	OID_RT_PRO_QUERY_PERMANENT_ADDRESS */
+	{1, &oid_null_function},	/* 0x2A	OID_RT_PRO_SET_PHILIPS_RF_PARAMETERS */
+	{1, &rtl8188eu_oid_rt_pro_set_carrier_suppression_tx_hdl},/* 0x2B	OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX */
+	{1, &oid_null_function},	/* 0x2C	OID_RT_PRO_RECEIVE_PACKET */
+	{1, &oid_null_function},	/* 0x2D	OID_RT_PRO_WRITE_EEPROM_BYTE */
+	{1, &oid_null_function},	/* 0x2E	OID_RT_PRO_READ_EEPROM_BYTE */
+	{1, &rtl8188eu_oid_rt_pro_set_modulation_hdl}		/* 0x2F */
+};
+
+static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_40[] = {
+	{1, &oid_null_function},			/* 0x40 */
+	{1, &oid_null_function},			/* 0x41 */
+	{1, &oid_null_function},			/* 0x42 */
+	{1, &rtl8188eu_oid_rt_pro_set_single_tone_tx_hdl},	/* 0x43 */
+	{1, &oid_null_function},			/* 0x44 */
+	{1, &oid_null_function}				/* 0x45 */
+};
+
+static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_80[] = {
+	{1, &oid_null_function},		/* 0x80	OID_RT_DRIVER_OPTION */
+	{1, &oid_null_function},		/* 0x81	OID_RT_RF_OFF */
+	{1, &oid_null_function}			/* 0x82	OID_RT_AUTH_STATUS */
+};
+
+static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_85[] = {
+	{1, &rtl8188eu_oid_rt_wireless_mode_hdl}		/* 0x00	OID_RT_WIRELESS_MODE */
+};
+
+#endif /* _RTL871X_MP_IOCTL_C_ */
+
+struct rwreg_param {
+	u32 offset;
+	u32 width;
+	u32 value;
+};
+
+struct bbreg_param {
+	u32 offset;
+	u32 phymask;
+	u32 value;
+};
+
+struct txpower_param {
+	u32 pwr_index;
+};
+
+struct datarate_param {
+	u32 rate_index;
+};
+
+struct rfintfs_parm {
+	u32 rfintfs;
+};
+
+struct mp_xmit_parm {
+	u8 enable;
+	u32 count;
+	u16 length;
+	u8 payload_type;
+	u8 da[ETH_ALEN];
+};
+
+struct mp_xmit_packet {
+	u32 len;
+	u32 mem[MAX_MP_XMITBUF_SZ >> 2];
+};
+
+struct psmode_param {
+	u32 ps_mode;
+	u32 smart_ps;
+};
+
+/* for OID_RT_PRO_READ16_EEPROM & OID_RT_PRO_WRITE16_EEPROM */
+struct eeprom_rw_param {
+	u32 offset;
+	u16 value;
+};
+
+struct mp_ioctl_handler {
+	u32 paramsize;
+	s32 (*handler)(struct oid_par_priv* poid_par_priv);
+	u32 oid;
+};
+
+struct mp_ioctl_param{
+	u32 subcode;
+	u32 len;
+	u8 data[0];
+};
+
+#define GEN_MP_IOCTL_SUBCODE(code) _MP_IOCTL_ ## code ## _CMD_
+
+enum RTL871X_MP_IOCTL_SUBCODE {
+	GEN_MP_IOCTL_SUBCODE(MP_START),			/*0*/
+	GEN_MP_IOCTL_SUBCODE(MP_STOP),
+	GEN_MP_IOCTL_SUBCODE(READ_REG),
+	GEN_MP_IOCTL_SUBCODE(WRITE_REG),
+	GEN_MP_IOCTL_SUBCODE(READ_BB_REG),
+	GEN_MP_IOCTL_SUBCODE(WRITE_BB_REG),		/*5*/
+	GEN_MP_IOCTL_SUBCODE(READ_RF_REG),
+	GEN_MP_IOCTL_SUBCODE(WRITE_RF_REG),
+	GEN_MP_IOCTL_SUBCODE(SET_CHANNEL),
+	GEN_MP_IOCTL_SUBCODE(SET_TXPOWER),
+	GEN_MP_IOCTL_SUBCODE(SET_DATARATE),		/*10*/
+	GEN_MP_IOCTL_SUBCODE(SET_BANDWIDTH),
+	GEN_MP_IOCTL_SUBCODE(SET_ANTENNA),
+	GEN_MP_IOCTL_SUBCODE(CNTU_TX),
+	GEN_MP_IOCTL_SUBCODE(SC_TX),
+	GEN_MP_IOCTL_SUBCODE(CS_TX),			/*15*/
+	GEN_MP_IOCTL_SUBCODE(ST_TX),
+	GEN_MP_IOCTL_SUBCODE(IOCTL_XMIT_PACKET),
+	GEN_MP_IOCTL_SUBCODE(SET_RX_PKT_TYPE),
+	GEN_MP_IOCTL_SUBCODE(RESET_PHY_RX_PKT_CNT),
+	GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_RECV),	/*20*/
+	GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_ERROR),
+	GEN_MP_IOCTL_SUBCODE(READ16_EEPROM),
+	GEN_MP_IOCTL_SUBCODE(WRITE16_EEPROM),
+	GEN_MP_IOCTL_SUBCODE(EFUSE),
+	GEN_MP_IOCTL_SUBCODE(EFUSE_MAP),		/*25*/
+	GEN_MP_IOCTL_SUBCODE(GET_EFUSE_MAX_SIZE),
+	GEN_MP_IOCTL_SUBCODE(GET_EFUSE_CURRENT_SIZE),
+	GEN_MP_IOCTL_SUBCODE(GET_THERMAL_METER),
+	GEN_MP_IOCTL_SUBCODE(SET_PTM),
+	GEN_MP_IOCTL_SUBCODE(SET_POWER_DOWN),		/*30*/
+	GEN_MP_IOCTL_SUBCODE(TRIGGER_GPIO),
+	GEN_MP_IOCTL_SUBCODE(SET_DM_BT),		/*35*/
+	GEN_MP_IOCTL_SUBCODE(DEL_BA),			/*36*/
+	GEN_MP_IOCTL_SUBCODE(GET_WIFI_STATUS),	/*37*/
+	MAX_MP_IOCTL_SUBCODE,
+};
+
+s32 rtl8188eu_mp_ioctl_xmit_packet_hdl(struct oid_par_priv *poid_par_priv);
+
+#define GEN_HANDLER(sz, hdl, oid) {sz, hdl, oid},
+
+#define EXT_MP_IOCTL_HANDLER(sz, subcode, oid)			\
+	 {sz, rtl8188eu_mp_ioctl_##subcode##_hdl, oid},
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h b/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
new file mode 100644
index 000000000000..ae4c9df7f42a
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_mp_phy_regdef.h
@@ -0,0 +1,1079 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+/*****************************************************************************
+ *
+ * Module:	__RTW_MP_PHY_REGDEF_H_
+ *
+ *
+ * Note:	1. Define PMAC/BB register map
+ *			2. Define RF register map
+ *			3. PMAC/BB register bit mask.
+ *			4. RF reg bit mask.
+ *			5. Other BB/RF relative definition.
+ *
+ *
+ * Export:	Constants, macro, functions(API), global variables(None).
+ *
+ * Abbrev:
+ *
+ * History:
+ *	Data			Who		Remark
+ *	08/07/2007	MHC		1. Porting from 9x series PHYCFG.h.
+ *						2. Reorganize code architecture.
+ *	09/25/2008	MH		1. Add RL6052 register definition
+ *
+ *****************************************************************************/
+#ifndef __RTW_MP_PHY_REGDEF_H_
+#define __RTW_MP_PHY_REGDEF_H_
+
+/*--------------------------Define Parameters-------------------------------*/
+
+/*  */
+/*	8192S Regsiter offset definition */
+/*  */
+
+/*  */
+/*  BB-PHY register PMAC 0x100 PHY 0x800 - 0xEFF */
+/*  1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L-STF */
+/*  2. 0x800/0x900/0xA00/0xC00/0xD00/0xE00 */
+/*  3. RF register 0x00-2E */
+/*  4. Bit Mask for BB/RF register */
+/*  5. Other definition for BB/RF R/W */
+/*  */
+
+/*  */
+/*  1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L-STF */
+/*  1. Page1(0x100) */
+/*  */
+#define	rPMAC_Reset		0x100
+#define	rPMAC_TxStart		0x104
+#define	rPMAC_TxLegacySIG	0x108
+#define	rPMAC_TxHTSIG1		0x10c
+#define	rPMAC_TxHTSIG2		0x110
+#define	rPMAC_PHYDebug		0x114
+#define	rPMAC_TxPacketNum	0x118
+#define	rPMAC_TxIdle		0x11c
+#define	rPMAC_TxMACHeader0	0x120
+#define	rPMAC_TxMACHeader1	0x124
+#define	rPMAC_TxMACHeader2	0x128
+#define	rPMAC_TxMACHeader3	0x12c
+#define	rPMAC_TxMACHeader4	0x130
+#define	rPMAC_TxMACHeader5	0x134
+#define	rPMAC_TxDataType	0x138
+#define	rPMAC_TxRandomSeed	0x13c
+#define	rPMAC_CCKPLCPPreamble	0x140
+#define	rPMAC_CCKPLCPHeader	0x144
+#define	rPMAC_CCKCRC16		0x148
+#define	rPMAC_OFDMRxCRC32OK	0x170
+#define	rPMAC_OFDMRxCRC32Er	0x174
+#define	rPMAC_OFDMRxParityEr	0x178
+#define	rPMAC_OFDMRxCRC8Er	0x17c
+#define	rPMAC_CCKCRxRC16Er	0x180
+#define	rPMAC_CCKCRxRC32Er	0x184
+#define	rPMAC_CCKCRxRC32OK	0x188
+#define	rPMAC_TxStatus		0x18c
+
+/*  */
+/*  2. Page2(0x200) */
+/*  */
+/*  The following two definition are only used for USB interface. */
+/* define	RF_BB_CMD_ADDR	0x02c0	 RF/BB read/write command address. */
+/* define	RF_BB_CMD_DATA	0x02c4	 RF/BB read/write command data. */
+
+/*  */
+/*  3. Page8(0x800) */
+/*  */
+#define	rFPGA0_RFMOD		0x800	/* RF mode & CCK TxSC RF BW Setting?? */
+
+#define	rFPGA0_TxInfo		0x804	/*  Status report?? */
+#define	rFPGA0_PSDFunction	0x808
+
+#define	rFPGA0_TxGainStage	0x80c	/*  Set TX PWR init gain? */
+
+#define	rFPGA0_RFTiming1	0x810	/*  Useless now */
+#define	rFPGA0_RFTiming2	0x814
+/* define rFPGA0_XC_RFTiming		0x818 */
+/* define rFPGA0_XD_RFTiming		0x81c */
+
+#define rFPGA0_XA_HSSIParameter1	0x820	/*  RF 3 wire register */
+#define rFPGA0_XA_HSSIParameter2	0x824
+#define rFPGA0_XB_HSSIParameter1	0x828
+#define rFPGA0_XB_HSSIParameter2	0x82c
+#define rFPGA0_XC_HSSIParameter1	0x830
+#define rFPGA0_XC_HSSIParameter2	0x834
+#define rFPGA0_XD_HSSIParameter1	0x838
+#define rFPGA0_XD_HSSIParameter2	0x83c
+#define	rFPGA0_XA_LSSIParameter		0x840
+#define	rFPGA0_XB_LSSIParameter		0x844
+#define	rFPGA0_XC_LSSIParameter		0x848
+#define	rFPGA0_XD_LSSIParameter		0x84c
+
+#define	rFPGA0_RFWakeUpParameter		0x850	/*  Useless now */
+#define	rFPGA0_RFSleepUpParameter		0x854
+
+#define	rFPGA0_XAB_SwitchControl		0x858	/*  RF Channel switch */
+#define	rFPGA0_XCD_SwitchControl		0x85c
+
+#define	rFPGA0_XA_RFInterfaceOE		0x860	/*  RF Channel switch */
+#define	rFPGA0_XB_RFInterfaceOE		0x864
+#define	rFPGA0_XC_RFInterfaceOE		0x868
+#define	rFPGA0_XD_RFInterfaceOE		0x86c
+
+#define	rFPGA0_XAB_RFInterfaceSW		0x870	/*  RF Interface Software Control */
+#define	rFPGA0_XCD_RFInterfaceSW		0x874
+
+#define	rFPGA0_XAB_RFParameter		0x878	/*  RF Parameter */
+#define	rFPGA0_XCD_RFParameter		0x87c
+
+#define	rFPGA0_AnalogParameter1		0x880	/*  Crystal cap setting RF-R/W protection for parameter4?? */
+#define	rFPGA0_AnalogParameter2		0x884
+#define	rFPGA0_AnalogParameter3		0x888	/*  Useless now */
+#define	rFPGA0_AnalogParameter4		0x88c
+
+#define	rFPGA0_XA_LSSIReadBack		0x8a0	/*  Tranceiver LSSI Readback */
+#define	rFPGA0_XB_LSSIReadBack		0x8a4
+#define	rFPGA0_XC_LSSIReadBack		0x8a8
+#define	rFPGA0_XD_LSSIReadBack		0x8ac
+
+#define	rFPGA0_PSDReport				0x8b4	/*  Useless now */
+#define	rFPGA0_XAB_RFInterfaceRB		0x8e0	/*  Useless now RF Interface Readback Value */
+#define	rFPGA0_XCD_RFInterfaceRB		0x8e4	/*  Useless now */
+
+/*  */
+/*  4. Page9(0x900) */
+/*  */
+#define	rFPGA1_RFMOD				0x900	/* RF mode & OFDM TxSC RF BW Setting?? */
+
+#define	rFPGA1_TxBlock				0x904	/*  Useless now */
+#define	rFPGA1_DebugSelect			0x908	/*  Useless now */
+#define	rFPGA1_TxInfo				0x90c	/*  Useless now Status report?? */
+
+/*  */
+/*  5. PageA(0xA00) */
+/*  */
+/*  Set Control channel to upper or lower. These settings are required only for 40MHz */
+#define	rCCK0_System				0xa00
+
+#define	rCCK0_AFESetting			0xa04	/*  Disable init gain now Select RX path by RSSI */
+#define	rCCK0_CCA					0xa08	/*  Disable init gain now Init gain */
+
+#define	rCCK0_RxAGC1			0xa0c	/* AGC default value, saturation level Antenna Diversity, RX AGC, LNA Threshold, RX LNA Threshold useless now. Not the same as 90 series */
+#define	rCCK0_RxAGC2			0xa10	/* AGC & DAGC */
+
+#define	rCCK0_RxHP			0xa14
+
+#define	rCCK0_DSPParameter1		0xa18	/* Timing recovery & Channel estimation threshold */
+#define	rCCK0_DSPParameter2		0xa1c	/* SQ threshold */
+
+#define	rCCK0_TxFilter1			0xa20
+#define	rCCK0_TxFilter2			0xa24
+#define	rCCK0_DebugPort			0xa28	/* debug port and Tx filter3 */
+#define	rCCK0_FalseAlarmReport		0xa2c	/* 0xa2d	useless now 0xa30-a4f channel report */
+#define	rCCK0_TRSSIReport		0xa50
+#define	rCCK0_RxReport			0xa54  /* 0xa57 */
+#define	rCCK0_FACounterLower		0xa5c  /* 0xa5b */
+#define	rCCK0_FACounterUpper		0xa58  /* 0xa5c */
+
+/*  */
+/*  6. PageC(0xC00) */
+/*  */
+#define	rOFDM0_LSTF			0xc00
+
+#define	rOFDM0_TRxPathEnable		0xc04
+#define	rOFDM0_TRMuxPar			0xc08
+#define	rOFDM0_TRSWIsolation		0xc0c
+
+#define	rOFDM0_XARxAFE			0xc10  /* RxIQ DC offset, Rx digital filter, DC notch filter */
+#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imblance matrix */
+#define	rOFDM0_XBRxAFE			0xc18
+#define	rOFDM0_XBRxIQImbalance		0xc1c
+#define	rOFDM0_XCRxAFE			0xc20
+#define	rOFDM0_XCRxIQImbalance		0xc24
+#define	rOFDM0_XDRxAFE			0xc28
+#define	rOFDM0_XDRxIQImbalance		0xc2c
+
+#define	rOFDM0_RxDetector1		0xc30  /* PD,BW & SBD	DM tune init gain */
+#define	rOFDM0_RxDetector2		0xc34  /* SBD & Fame Sync. */
+#define	rOFDM0_RxDetector3		0xc38  /* Frame Sync. */
+#define	rOFDM0_RxDetector4		0xc3c  /* PD, SBD, Frame Sync & Short-GI */
+
+#define	rOFDM0_RxDSP			0xc40  /* Rx Sync Path */
+#define	rOFDM0_CFOandDAGC		0xc44  /* CFO & DAGC */
+#define	rOFDM0_CCADropThreshold		0xc48 /* CCA Drop threshold */
+#define	rOFDM0_ECCAThreshold		0xc4c /*  energy CCA */
+
+#define	rOFDM0_XAAGCCore1		0xc50	/*  DIG */
+#define	rOFDM0_XAAGCCore2		0xc54
+#define	rOFDM0_XBAGCCore1		0xc58
+#define	rOFDM0_XBAGCCore2		0xc5c
+#define	rOFDM0_XCAGCCore1		0xc60
+#define	rOFDM0_XCAGCCore2		0xc64
+#define	rOFDM0_XDAGCCore1		0xc68
+#define	rOFDM0_XDAGCCore2		0xc6c
+
+#define	rOFDM0_AGCParameter1		0xc70
+#define	rOFDM0_AGCParameter2		0xc74
+#define	rOFDM0_AGCRSSITable		0xc78
+#define	rOFDM0_HTSTFAGC			0xc7c
+
+#define	rOFDM0_XATxIQImbalance		0xc80	/*  TX PWR TRACK and DIG */
+#define	rOFDM0_XATxAFE			0xc84
+#define	rOFDM0_XBTxIQImbalance		0xc88
+#define	rOFDM0_XBTxAFE			0xc8c
+#define	rOFDM0_XCTxIQImbalance		0xc90
+#define	rOFDM0_XCTxAFE			0xc94
+#define	rOFDM0_XDTxIQImbalance		0xc98
+#define	rOFDM0_XDTxAFE			0xc9c
+#define	rOFDM0_RxIQExtAnta		0xca0
+
+#define	rOFDM0_RxHPParameter		0xce0
+#define	rOFDM0_TxPseudoNoiseWgt		0xce4
+#define	rOFDM0_FrameSync		0xcf0
+#define	rOFDM0_DFSReport		0xcf4
+#define	rOFDM0_TxCoeff1			0xca4
+#define	rOFDM0_TxCoeff2			0xca8
+#define	rOFDM0_TxCoeff3			0xcac
+#define	rOFDM0_TxCoeff4			0xcb0
+#define	rOFDM0_TxCoeff5			0xcb4
+#define	rOFDM0_TxCoeff6			0xcb8
+
+/*  7. PageD(0xD00) */
+#define	rOFDM1_LSTF			0xd00
+#define	rOFDM1_TRxPathEnable		0xd04
+
+#define	rOFDM1_CFO			0xd08	/*  No setting now */
+#define	rOFDM1_CSI1			0xd10
+#define	rOFDM1_SBD			0xd14
+#define	rOFDM1_CSI2			0xd18
+#define	rOFDM1_CFOTracking		0xd2c
+#define	rOFDM1_TRxMesaure1		0xd34
+#define	rOFDM1_IntfDet			0xd3c
+#define	rOFDM1_PseudoNoiseStateAB	0xd50
+#define	rOFDM1_PseudoNoiseStateCD	0xd54
+#define	rOFDM1_RxPseudoNoiseWgt		0xd58
+
+#define	rOFDM_PHYCounter1		0xda0  /* cca, parity fail */
+#define	rOFDM_PHYCounter2		0xda4  /* rate illegal, crc8 fail */
+#define	rOFDM_PHYCounter3		0xda8  /* MCS not support */
+
+#define	rOFDM_ShortCFOAB		0xdac	/*  No setting now */
+#define	rOFDM_ShortCFOCD		0xdb0
+#define	rOFDM_LongCFOAB			0xdb4
+#define	rOFDM_LongCFOCD			0xdb8
+#define	rOFDM_TailCFOAB			0xdbc
+#define	rOFDM_TailCFOCD			0xdc0
+#define	rOFDM_PWMeasure1		0xdc4
+#define	rOFDM_PWMeasure2		0xdc8
+#define	rOFDM_BWReport			0xdcc
+#define	rOFDM_AGCReport			0xdd0
+#define	rOFDM_RxSNR			0xdd4
+#define	rOFDM_RxEVMCSI			0xdd8
+#define	rOFDM_SIGReport			0xddc
+
+/*  */
+/*  8. PageE(0xE00) */
+/*  */
+#define	rTxAGC_Rate18_06		0xe00
+#define	rTxAGC_Rate54_24		0xe04
+#define	rTxAGC_CCK_Mcs32		0xe08
+#define	rTxAGC_Mcs03_Mcs00		0xe10
+#define	rTxAGC_Mcs07_Mcs04		0xe14
+#define	rTxAGC_Mcs11_Mcs08		0xe18
+#define	rTxAGC_Mcs15_Mcs12		0xe1c
+
+/*  Analog- control in RX_WAIT_CCA : REG: EE0 [Analog- Power & Control Register] */
+#define		rRx_Wait_CCCA		0xe70
+#define	rAnapar_Ctrl_BB			0xee0
+
+/*  */
+/*  7. RF Register 0x00-0x2E (RF 8256) */
+/*     RF-0222D 0x00-3F */
+/*  */
+/* Zebra1 */
+#define RTL92SE_FPGA_VERIFY 0
+#define	rZebra1_HSSIEnable		0x0	/*  Useless now */
+#define	rZebra1_TRxEnable1		0x1
+#define	rZebra1_TRxEnable2		0x2
+#define	rZebra1_AGC			0x4
+#define	rZebra1_ChargePump		0x5
+/* if (RTL92SE_FPGA_VERIFY == 1) */
+#define	rZebra1_Channel			0x7	/*  RF channel switch */
+/* else */
+
+/* endif */
+#define	rZebra1_TxGain			0x8	/*  Useless now */
+#define	rZebra1_TxLPF			0x9
+#define	rZebra1_RxLPF			0xb
+#define	rZebra1_RxHPFCorner		0xc
+
+/* Zebra4 */
+#define	rGlobalCtrl			0	/*  Useless now */
+#define	rRTL8256_TxLPF			19
+#define	rRTL8256_RxLPF			11
+
+/* RTL8258 */
+#define	rRTL8258_TxLPF			0x11	/*  Useless now */
+#define	rRTL8258_RxLPF			0x13
+#define	rRTL8258_RSSILPF		0xa
+
+/*  */
+/*  RL6052 Register definition */
+#define	RF_AC				0x00	/*  */
+
+#define	RF_IQADJ_G1			0x01	/*  */
+#define	RF_IQADJ_G2			0x02	/*  */
+#define	RF_POW_TRSW			0x05	/*  */
+
+#define	RF_GAIN_RX			0x06	/*  */
+#define	RF_GAIN_TX			0x07	/*  */
+
+#define	RF_TXM_IDAC			0x08	/*  */
+#define	RF_BS_IQGEN			0x0F	/*  */
+
+#define	RF_MODE1			0x10	/*  */
+#define	RF_MODE2			0x11	/*  */
+
+#define	RF_RX_AGC_HP			0x12	/*  */
+#define	RF_TX_AGC			0x13	/*  */
+#define	RF_BIAS				0x14	/*  */
+#define	RF_IPA				0x15	/*  */
+#define	RF_TXBIAS			0x16 /*  */
+#define	RF_POW_ABILITY			0x17	/*  */
+#define	RF_MODE_AG			0x18	/*  */
+#define	rRfChannel			0x18	/*  RF channel and BW switch */
+#define	RF_CHNLBW			0x18	/*  RF channel and BW switch */
+#define	RF_TOP				0x19	/*  */
+
+#define	RF_RX_G1			0x1A	/*  */
+#define	RF_RX_G2			0x1B	/*  */
+
+#define	RF_RX_BB2			0x1C	/*  */
+#define	RF_RX_BB1			0x1D	/*  */
+
+#define	RF_RCK1				0x1E	/*  */
+#define	RF_RCK2				0x1F	/*  */
+
+#define	RF_TX_G1			0x20	/*  */
+#define	RF_TX_G2			0x21	/*  */
+#define	RF_TX_G3			0x22	/*  */
+
+#define	RF_TX_BB1			0x23	/*  */
+
+#define	RF_T_METER			0x24	/*  */
+
+#define	RF_SYN_G1			0x25	/*  RF TX Power control */
+#define	RF_SYN_G2			0x26	/*  RF TX Power control */
+#define	RF_SYN_G3			0x27	/*  RF TX Power control */
+#define	RF_SYN_G4			0x28	/*  RF TX Power control */
+#define	RF_SYN_G5			0x29	/*  RF TX Power control */
+#define	RF_SYN_G6			0x2A	/*  RF TX Power control */
+#define	RF_SYN_G7			0x2B	/*  RF TX Power control */
+#define	RF_SYN_G8			0x2C	/*  RF TX Power control */
+
+#define	RF_RCK_OS			0x30	/*  RF TX PA control */
+#define	RF_TXPA_G1			0x31	/*  RF TX PA control */
+#define	RF_TXPA_G2			0x32	/*  RF TX PA control */
+#define	RF_TXPA_G3			0x33	/*  RF TX PA control */
+
+/*  */
+/* Bit Mask */
+/*  */
+/*  1. Page1(0x100) */
+#define	bBBResetB			0x100	/*  Useless now? */
+#define	bGlobalResetB			0x200
+#define	bOFDMTxStart			0x4
+#define	bCCKTxStart			0x8
+#define	bCRC32Debug			0x100
+#define	bPMACLoopback			0x10
+#define	bTxLSIG				0xffffff
+#define	bOFDMTxRate			0xf
+#define	bOFDMTxReserved			0x10
+#define	bOFDMTxLength			0x1ffe0
+#define	bOFDMTxParity			0x20000
+#define	bTxHTSIG1			0xffffff
+#define	bTxHTMCSRate			0x7f
+#define	bTxHTBW				0x80
+#define	bTxHTLength			0xffff00
+#define	bTxHTSIG2			0xffffff
+#define	bTxHTSmoothing			0x1
+#define	bTxHTSounding			0x2
+#define	bTxHTReserved			0x4
+#define	bTxHTAggreation			0x8
+#define	bTxHTSTBC			0x30
+#define	bTxHTAdvanceCoding		0x40
+#define	bTxHTShortGI			0x80
+#define	bTxHTNumberHT_LTF		0x300
+#define	bTxHTCRC8			0x3fc00
+#define	bCounterReset			0x10000
+#define	bNumOfOFDMTx			0xffff
+#define	bNumOfCCKTx			0xffff0000
+#define	bTxIdleInterval			0xffff
+#define	bOFDMService			0xffff0000
+#define	bTxMACHeader			0xffffffff
+#define	bTxDataInit			0xff
+#define	bTxHTMode			0x100
+#define	bTxDataType			0x30000
+#define	bTxRandomSeed			0xffffffff
+#define	bCCKTxPreamble			0x1
+#define	bCCKTxSFD			0xffff0000
+#define	bCCKTxSIG			0xff
+#define	bCCKTxService			0xff00
+#define	bCCKLengthExt			0x8000
+#define	bCCKTxLength			0xffff0000
+#define	bCCKTxCRC16			0xffff
+#define	bCCKTxStatus			0x1
+#define	bOFDMTxStatus			0x2
+
+#define		IS_BB_REG_OFFSET_92S(_Offset)		((_Offset >= 0x800) && (_Offset <= 0xfff))
+
+/*  2. Page8(0x800) */
+#define	bRFMOD				0x1	/*  Reg 0x800 rFPGA0_RFMOD */
+#define	bJapanMode			0x2
+#define	bCCKTxSC			0x30
+#define	bCCKEn				0x1000000
+#define	bOFDMEn				0x2000000
+
+#define	bOFDMRxADCPhase			0x10000	/*  Useless now */
+#define	bOFDMTxDACPhase			0x40000
+#define	bXATxAGC			0x3f
+
+#define	bXBTxAGC			0xf00	/*  Reg 80c rFPGA0_TxGainStage */
+#define	bXCTxAGC			0xf000
+#define	bXDTxAGC			0xf0000
+
+#define	bPAStart			0xf0000000	/*  Useless now */
+#define	bTRStart			0x00f00000
+#define	bRFStart			0x0000f000
+#define	bBBStart			0x000000f0
+#define	bBBCCKStart			0x0000000f
+#define	bPAEnd				0xf	  /* Reg0x814 */
+#define	bTREnd				0x0f000000
+#define	bRFEnd				0x000f0000
+#define	bCCAMask			0x000000f0   /* T2R */
+#define	bR2RCCAMask			0x00000f00
+#define	bHSSI_R2TDelay			0xf8000000
+#define	bHSSI_T2RDelay			0xf80000
+#define	bContTxHSSI			0x400     /* chane gain at continue Tx */
+#define	bIGFromCCK			0x200
+#define	bAGCAddress			0x3f
+#define	bRxHPTx				0x7000
+#define	bRxHPT2R			0x38000
+#define	bRxHPCCKIni			0xc0000
+#define	bAGCTxCode			0xc00000
+#define	bAGCRxCode			0x300000
+
+#define	b3WireDataLength		0x800	/*  Reg 0x820~84f rFPGA0_XA_HSSIParameter1 */
+#define	b3WireAddressLength		0x400
+
+#define	b3WireRFPowerDown		0x1	/*  Useless now */
+/* define bHWSISelect			0x8 */
+#define	b5GPAPEPolarity			0x40000000
+#define	b2GPAPEPolarity			0x80000000
+#define	bRFSW_TxDefaultAnt		0x3
+#define	bRFSW_TxOptionAnt		0x30
+#define	bRFSW_RxDefaultAnt		0x300
+#define	bRFSW_RxOptionAnt		0x3000
+#define	bRFSI_3WireData			0x1
+#define	bRFSI_3WireClock		0x2
+#define	bRFSI_3WireLoad			0x4
+#define	bRFSI_3WireRW			0x8
+#define	bRFSI_3Wire			0xf
+
+#define	bRFSI_RFENV			0x10	/*  Reg 0x870 rFPGA0_XAB_RFInterfaceSW */
+
+#define	bRFSI_TRSW			0x20	/*  Useless now */
+#define	bRFSI_TRSWB			0x40
+#define	bRFSI_ANTSW			0x100
+#define	bRFSI_ANTSWB			0x200
+#define	bRFSI_PAPE			0x400
+#define	bRFSI_PAPE5G			0x800
+#define	bBandSelect			0x1
+#define	bHTSIG2_GI			0x80
+#define	bHTSIG2_Smoothing		0x01
+#define	bHTSIG2_Sounding		0x02
+#define	bHTSIG2_Aggreaton		0x08
+#define	bHTSIG2_STBC			0x30
+#define	bHTSIG2_AdvCoding		0x40
+#define	bHTSIG2_NumOfHTLTF		0x300
+#define	bHTSIG2_CRC8			0x3fc
+#define	bHTSIG1_MCS			0x7f
+#define	bHTSIG1_BandWidth		0x80
+#define	bHTSIG1_HTLength		0xffff
+#define	bLSIG_Rate			0xf
+#define	bLSIG_Reserved			0x10
+#define	bLSIG_Length			0x1fffe
+#define	bLSIG_Parity			0x20
+#define	bCCKRxPhase			0x4
+#if (RTL92SE_FPGA_VERIFY == 1)
+#define	bLSSIReadAddress		0x3f000000   /* LSSI "Read" Address
+					Reg 0x824 rFPGA0_XA_HSSIParameter2 */
+#else
+#define	bLSSIReadAddress		0x7f800000   /*  T65 RF */
+#endif
+#define	bLSSIReadEdge			0x80000000   /* LSSI "Read" edge signal */
+#if (RTL92SE_FPGA_VERIFY == 1)
+#define	bLSSIReadBackData		0xfff	/*  Reg 0x8a0
+					 rFPGA0_XA_LSSIReadBack */
+#else
+#define	bLSSIReadBackData		0xfffff	/*  T65 RF */
+#endif
+#define	bLSSIReadOKFlag			0x1000	/*  Useless now */
+#define	bCCKSampleRate			0x8       /* 0: 44MHz, 1:88MHz */
+#define	bRegulator0Standby		0x1
+#define	bRegulatorPLLStandby		0x2
+#define	bRegulator1Standby		0x4
+#define	bPLLPowerUp			0x8
+#define	bDPLLPowerUp			0x10
+#define	bDA10PowerUp			0x20
+#define	bAD7PowerUp			0x200
+#define	bDA6PowerUp			0x2000
+#define	bXtalPowerUp			0x4000
+#define	b40MDClkPowerUP			0x8000
+#define	bDA6DebugMode			0x20000
+#define	bDA6Swing			0x380000
+
+#define	bADClkPhase			0x4000000	/*  Reg 0x880
+	 rFPGA0_AnalogParameter1 20/40 CCK support switch 40/80 BB MHZ */
+
+#define	b80MClkDelay			0x18000000	/*  Useless */
+#define	bAFEWatchDogEnable		0x20000000
+
+#define	bXtalCap01			0xc0000000	/*  Reg 0x884
+	 rFPGA0_AnalogParameter2 Crystal cap */
+#define	bXtalCap23			0x3
+#define	bXtalCap92x			0x0f000000
+#define		bXtalCap		0x0f000000
+
+#define	bIntDifClkEnable		0x400	/*  Useless */
+#define	bExtSigClkEnable		0x800
+#define	bBandgapMbiasPowerUp		0x10000
+#define	bAD11SHGain			0xc0000
+#define	bAD11InputRange			0x700000
+#define	bAD11OPCurrent			0x3800000
+#define	bIPathLoopback			0x4000000
+#define	bQPathLoopback			0x8000000
+#define	bAFELoopback			0x10000000
+#define	bDA10Swing			0x7e0
+#define	bDA10Reverse			0x800
+#define	bDAClkSource			0x1000
+#define	bAD7InputRange			0x6000
+#define	bAD7Gain			0x38000
+#define	bAD7OutputCMMode		0x40000
+#define	bAD7InputCMMode			0x380000
+#define	bAD7Current			0xc00000
+#define	bRegulatorAdjust		0x7000000
+#define	bAD11PowerUpAtTx		0x1
+#define	bDA10PSAtTx			0x10
+#define	bAD11PowerUpAtRx		0x100
+#define	bDA10PSAtRx			0x1000
+#define	bCCKRxAGCFormat			0x200
+#define	bPSDFFTSamplepPoint		0xc000
+#define	bPSDAverageNum			0x3000
+#define	bIQPathControl			0xc00
+#define	bPSDFreq			0x3ff
+#define	bPSDAntennaPath			0x30
+#define	bPSDIQSwitch			0x40
+#define	bPSDRxTrigger			0x400000
+#define	bPSDTxTrigger			0x80000000
+#define	bPSDSineToneScale		0x7f000000
+#define	bPSDReport			0xffff
+
+/*  3. Page9(0x900) */
+#define	bOFDMTxSC			0x30000000	/*  Useless */
+#define	bCCKTxOn			0x1
+#define	bOFDMTxOn			0x2
+#define	bDebugPage			0xfff  /* reset debug page and HWord,
+						* LWord */
+#define	bDebugItem			0xff   /* reset debug page and LWord */
+#define	bAntL				0x10
+#define	bAntNonHT			0x100
+#define	bAntHT1				0x1000
+#define	bAntHT2				0x10000
+#define	bAntHT1S1			0x100000
+#define	bAntNonHTS1			0x1000000
+
+/*  4. PageA(0xA00) */
+#define	bCCKBBMode			0x3	/*  Useless */
+#define	bCCKTxPowerSaving		0x80
+#define	bCCKRxPowerSaving		0x40
+
+#define	bCCKSideBand			0x10	/* Reg 0xa00 rCCK0 20/40 sw */
+
+#define	bCCKScramble			0x8	/*  Useless */
+#define	bCCKAntDiversity		0x8000
+#define	bCCKCarrierRecovery		0x4000
+#define	bCCKTxRate			0x3000
+#define	bCCKDCCancel			0x0800
+#define	bCCKISICancel			0x0400
+#define	bCCKMatchFilter			0x0200
+#define	bCCKEqualizer			0x0100
+#define	bCCKPreambleDetect		0x800000
+#define	bCCKFastFalseCCA		0x400000
+#define	bCCKChEstStart			0x300000
+#define	bCCKCCACount			0x080000
+#define	bCCKcs_lim			0x070000
+#define	bCCKBistMode			0x80000000
+#define	bCCKCCAMask			0x40000000
+#define	bCCKTxDACPhase			0x4
+#define	bCCKRxADCPhase			0x20000000   /* r_rx_clk */
+#define	bCCKr_cp_mode0			0x0100
+#define	bCCKTxDCOffset			0xf0
+#define	bCCKRxDCOffset			0xf
+#define	bCCKCCAMode			0xc000
+#define	bCCKFalseCS_lim			0x3f00
+#define	bCCKCS_ratio			0xc00000
+#define	bCCKCorgBit_sel			0x300000
+#define	bCCKPD_lim			0x0f0000
+#define	bCCKNewCCA			0x80000000
+#define	bCCKRxHPofIG			0x8000
+#define	bCCKRxIG			0x7f00
+#define	bCCKLNAPolarity			0x800000
+#define	bCCKRx1stGain			0x7f0000
+#define	bCCKRFExtend			0x20000000 /* CCK Rx init gain polar */
+#define	bCCKRxAGCSatLevel		0x1f000000
+#define	bCCKRxAGCSatCount		0xe0
+#define	bCCKRxRFSettle			0x1f       /* AGCsamp_dly */
+#define	bCCKFixedRxAGC			0x8000
+#define	bCCKAntennaPolarity		0x2000
+#define	bCCKTxFilterType		0x0c00
+#define	bCCKRxAGCReportType		0x0300
+#define	bCCKRxDAGCEn			0x80000000
+#define	bCCKRxDAGCPeriod		0x20000000
+#define	bCCKRxDAGCSatLevel		0x1f000000
+#define	bCCKTimingRecovery		0x800000
+#define	bCCKTxC0			0x3f0000
+#define	bCCKTxC1			0x3f000000
+#define	bCCKTxC2			0x3f
+#define	bCCKTxC3			0x3f00
+#define	bCCKTxC4			0x3f0000
+#define	bCCKTxC5			0x3f000000
+#define	bCCKTxC6			0x3f
+#define	bCCKTxC7			0x3f00
+#define	bCCKDebugPort			0xff0000
+#define	bCCKDACDebug			0x0f000000
+#define	bCCKFalseAlarmEnable		0x8000
+#define	bCCKFalseAlarmRead		0x4000
+#define	bCCKTRSSI			0x7f
+#define	bCCKRxAGCReport			0xfe
+#define	bCCKRxReport_AntSel		0x80000000
+#define	bCCKRxReport_MFOff		0x40000000
+#define	bCCKRxRxReport_SQLoss		0x20000000
+#define	bCCKRxReport_Pktloss		0x10000000
+#define	bCCKRxReport_Lockedbit		0x08000000
+#define	bCCKRxReport_RateError		0x04000000
+#define	bCCKRxReport_RxRate		0x03000000
+#define	bCCKRxFACounterLower		0xff
+#define	bCCKRxFACounterUpper		0xff000000
+#define	bCCKRxHPAGCStart		0xe000
+#define	bCCKRxHPAGCFinal		0x1c00
+#define	bCCKRxFalseAlarmEnable		0x8000
+#define	bCCKFACounterFreeze		0x4000
+#define	bCCKTxPathSel			0x10000000
+#define	bCCKDefaultRxPath		0xc000000
+#define	bCCKOptionRxPath		0x3000000
+
+/*  5. PageC(0xC00) */
+#define	bNumOfSTF			0x3	/*  Useless */
+#define	bShift_L			0xc0
+#define	bGI_TH				0xc
+#define	bRxPathA			0x1
+#define	bRxPathB			0x2
+#define	bRxPathC			0x4
+#define	bRxPathD			0x8
+#define	bTxPathA			0x1
+#define	bTxPathB			0x2
+#define	bTxPathC			0x4
+#define	bTxPathD			0x8
+#define	bTRSSIFreq			0x200
+#define	bADCBackoff			0x3000
+#define	bDFIRBackoff			0xc000
+#define	bTRSSILatchPhase		0x10000
+#define	bRxIDCOffset			0xff
+#define	bRxQDCOffset			0xff00
+#define	bRxDFIRMode			0x1800000
+#define	bRxDCNFType			0xe000000
+#define	bRXIQImb_A			0x3ff
+#define	bRXIQImb_B			0xfc00
+#define	bRXIQImb_C			0x3f0000
+#define	bRXIQImb_D			0xffc00000
+#define	bDC_dc_Notch			0x60000
+#define	bRxNBINotch			0x1f000000
+#define	bPD_TH				0xf
+#define	bPD_TH_Opt2			0xc000
+#define	bPWED_TH			0x700
+#define	bIfMF_Win_L			0x800
+#define	bPD_Option			0x1000
+#define	bMF_Win_L			0xe000
+#define	bBW_Search_L			0x30000
+#define	bwin_enh_L			0xc0000
+#define	bBW_TH				0x700000
+#define	bED_TH2				0x3800000
+#define	bBW_option			0x4000000
+#define	bRatio_TH			0x18000000
+#define	bWindow_L			0xe0000000
+#define	bSBD_Option			0x1
+#define	bFrame_TH			0x1c
+#define	bFS_Option			0x60
+#define	bDC_Slope_check			0x80
+#define	bFGuard_Counter_DC_L		0xe00
+#define	bFrame_Weight_Short		0x7000
+#define	bSub_Tune			0xe00000
+#define	bFrame_DC_Length		0xe000000
+#define	bSBD_start_offset		0x30000000
+#define	bFrame_TH_2			0x7
+#define	bFrame_GI2_TH			0x38
+#define	bGI2_Sync_en			0x40
+#define	bSarch_Short_Early		0x300
+#define	bSarch_Short_Late		0xc00
+#define	bSarch_GI2_Late			0x70000
+#define	bCFOAntSum			0x1
+#define	bCFOAcc				0x2
+#define	bCFOStartOffset			0xc
+#define	bCFOLookBack			0x70
+#define	bCFOSumWeight			0x80
+#define	bDAGCEnable			0x10000
+#define	bTXIQImb_A			0x3ff
+#define	bTXIQImb_B			0xfc00
+#define	bTXIQImb_C			0x3f0000
+#define	bTXIQImb_D			0xffc00000
+#define	bTxIDCOffset			0xff
+#define	bTxQDCOffset			0xff00
+#define	bTxDFIRMode			0x10000
+#define	bTxPesudoNoiseOn		0x4000000
+#define	bTxPesudoNoise_A		0xff
+#define	bTxPesudoNoise_B		0xff00
+#define	bTxPesudoNoise_C		0xff0000
+#define	bTxPesudoNoise_D		0xff000000
+#define	bCCADropOption			0x20000
+#define	bCCADropThres			0xfff00000
+#define	bEDCCA_H			0xf
+#define	bEDCCA_L			0xf0
+#define	bLambda_ED			0x300
+#define	bRxInitialGain			0x7f
+#define	bRxAntDivEn			0x80
+#define	bRxAGCAddressForLNA		0x7f00
+#define	bRxHighPowerFlow		0x8000
+#define	bRxAGCFreezeThres		0xc0000
+#define	bRxFreezeStep_AGC1		0x300000
+#define	bRxFreezeStep_AGC2		0xc00000
+#define	bRxFreezeStep_AGC3		0x3000000
+#define	bRxFreezeStep_AGC0		0xc000000
+#define	bRxRssi_Cmp_En			0x10000000
+#define	bRxQuickAGCEn			0x20000000
+#define	bRxAGCFreezeThresMode		0x40000000
+#define	bRxOverFlowCheckType		0x80000000
+#define	bRxAGCShift			0x7f
+#define	bTRSW_Tri_Only			0x80
+#define	bPowerThres			0x300
+#define	bRxAGCEn			0x1
+#define	bRxAGCTogetherEn		0x2
+#define	bRxAGCMin			0x4
+#define	bRxHP_Ini			0x7
+#define	bRxHP_TRLNA			0x70
+#define	bRxHP_RSSI			0x700
+#define	bRxHP_BBP1			0x7000
+#define	bRxHP_BBP2			0x70000
+#define	bRxHP_BBP3			0x700000
+#define	bRSSI_H				0x7f0000     /* thresh for hi power */
+#define	bRSSI_Gen			0x7f000000   /* thresh for ant div */
+#define	bRxSettle_TRSW			0x7
+#define	bRxSettle_LNA			0x38
+#define	bRxSettle_RSSI			0x1c0
+#define	bRxSettle_BBP			0xe00
+#define	bRxSettle_RxHP			0x7000
+#define	bRxSettle_AntSW_RSSI		0x38000
+#define	bRxSettle_AntSW			0xc0000
+#define	bRxProcessTime_DAGC		0x300000
+#define	bRxSettle_HSSI			0x400000
+#define	bRxProcessTime_BBPPW		0x800000
+#define	bRxAntennaPowerShift    0x3000000
+#define	bRSSITableSelect	0xc000000
+#define	bRxHP_Final	     0x7000000
+#define	bRxHTSettle_BBP	 0x7
+#define	bRxHTSettle_HSSI	0x8
+#define	bRxHTSettle_RxHP	0x70
+#define	bRxHTSettle_BBPPW       0x80
+#define	bRxHTSettle_Idle	0x300
+#define	bRxHTSettle_Reserved    0x1c00
+#define	bRxHTRxHPEn	     0x8000
+#define	bRxHTAGCFreezeThres     0x30000
+#define	bRxHTAGCTogetherEn      0x40000
+#define	bRxHTAGCMin	     0x80000
+#define	bRxHTAGCEn	      0x100000
+#define	bRxHTDAGCEn	     0x200000
+#define	bRxHTRxHP_BBP	   0x1c00000
+#define	bRxHTRxHP_Final	 0xe0000000
+#define	bRxPWRatioTH	    0x3
+#define	bRxPWRatioEn	    0x4
+#define	bRxMFHold	       0x3800
+#define	bRxPD_Delay_TH1	 0x38
+#define	bRxPD_Delay_TH2	 0x1c0
+#define	bRxPD_DC_COUNT_MAX      0x600
+/* define bRxMF_Hold	     0x3800 */
+#define	bRxPD_Delay_TH	  0x8000
+#define	bRxProcess_Delay	0xf0000
+#define	bRxSearchrange_GI2_Early 0x700000
+#define	bRxFrame_Guard_Counter_L 0x3800000
+#define	bRxSGI_Guard_L	  0xc000000
+#define	bRxSGI_Search_L	 0x30000000
+#define	bRxSGI_TH	       0xc0000000
+#define	bDFSCnt0		0xff
+#define	bDFSCnt1		0xff00
+#define	bDFSFlag		0xf0000
+#define	bMFWeightSum	    0x300000
+#define	bMinIdxTH	       0x7f000000
+#define	bDAFormat	       0x40000
+#define	bTxChEmuEnable	  0x01000000
+#define	bTRSWIsolation_A	0x7f
+#define	bTRSWIsolation_B	0x7f00
+#define	bTRSWIsolation_C	0x7f0000
+#define	bTRSWIsolation_D	0x7f000000
+#define	bExtLNAGain	     0x7c00
+
+/*  6. PageE(0xE00) */
+#define	bSTBCEn			0x4	/*  Useless */
+#define	bAntennaMapping	  0x10
+#define	bNss		     0x20
+#define	bCFOAntSumD	      0x200
+#define	bPHYCounterReset	 0x8000000
+#define	bCFOReportGet	    0x4000000
+#define	bOFDMContinueTx	  0x10000000
+#define	bOFDMSingleCarrier       0x20000000
+#define	bOFDMSingleTone	  0x40000000
+/* define bRxPath1		 0x01 */
+/* define bRxPath2		 0x02 */
+/* define bRxPath3		 0x04 */
+/* define bRxPath4		 0x08 */
+/* define bTxPath1		 0x10 */
+/* define bTxPath2		 0x20 */
+#define	bHTDetect		0x100
+#define	bCFOEn		   0x10000
+#define	bCFOValue		0xfff00000
+#define	bSigTone_Re	      0x3f
+#define	bSigTone_Im	      0x7f00
+#define	bCounter_CCA	     0xffff
+#define	bCounter_ParityFail      0xffff0000
+#define	bCounter_RateIllegal     0xffff
+#define	bCounter_CRC8Fail	0xffff0000
+#define	bCounter_MCSNoSupport    0xffff
+#define	bCounter_FastSync	0xffff
+#define	bShortCFO		0xfff
+#define	bShortCFOTLength	 12   /* total */
+#define	bShortCFOFLength	 11   /* fraction */
+#define	bLongCFO		 0x7ff
+#define	bLongCFOTLength	  11
+#define	bLongCFOFLength	  11
+#define	bTailCFO		 0x1fff
+#define	bTailCFOTLength	  13
+#define	bTailCFOFLength	  12
+#define	bmax_en_pwdB	     0xffff
+#define	bCC_power_dB	     0xffff0000
+#define	bnoise_pwdB	      0xffff
+#define	bPowerMeasTLength	10
+#define	bPowerMeasFLength	3
+#define	bRx_HT_BW		0x1
+#define	bRxSC		    0x6
+#define	bRx_HT		   0x8
+#define	bNB_intf_det_on	  0x1
+#define	bIntf_win_len_cfg	0x30
+#define	bNB_Intf_TH_cfg	  0x1c0
+#define	bRFGain		  0x3f
+#define	bTableSel		0x40
+#define	bTRSW		    0x80
+#define	bRxSNR_A		 0xff
+#define	bRxSNR_B		 0xff00
+#define	bRxSNR_C		 0xff0000
+#define	bRxSNR_D		 0xff000000
+#define	bSNREVMTLength	   8
+#define	bSNREVMFLength	   1
+#define	bCSI1st		  0xff
+#define	bCSI2nd		  0xff00
+#define	bRxEVM1st		0xff0000
+#define	bRxEVM2nd		0xff000000
+#define	bSIGEVM		  0xff
+#define	bPWDB		    0xff00
+#define	bSGIEN		   0x10000
+
+#define	bSFactorQAM1	     0xf	/*  Useless */
+#define	bSFactorQAM2	     0xf0
+#define	bSFactorQAM3	     0xf00
+#define	bSFactorQAM4	     0xf000
+#define	bSFactorQAM5	     0xf0000
+#define	bSFactorQAM6	     0xf0000
+#define	bSFactorQAM7	     0xf00000
+#define	bSFactorQAM8	     0xf000000
+#define	bSFactorQAM9	     0xf0000000
+#define	bCSIScheme	       0x100000
+
+#define	bNoiseLvlTopSet	  0x3	/*  Useless */
+#define	bChSmooth		0x4
+#define	bChSmoothCfg1	    0x38
+#define	bChSmoothCfg2	    0x1c0
+#define	bChSmoothCfg3	    0xe00
+#define	bChSmoothCfg4	    0x7000
+#define	bMRCMode		 0x800000
+#define	bTHEVMCfg		0x7000000
+
+#define	bLoopFitType	     0x1	/*  Useless */
+#define	bUpdCFO		  0x40
+#define	bUpdCFOOffData	   0x80
+#define	bAdvUpdCFO	       0x100
+#define	bAdvTimeCtrl	     0x800
+#define	bUpdClko		 0x1000
+#define	bFC		      0x6000
+#define	bTrackingMode	    0x8000
+#define	bPhCmpEnable	     0x10000
+#define	bUpdClkoLTF	      0x20000
+#define	bComChCFO		0x40000
+#define	bCSIEstiMode	     0x80000
+#define	bAdvUpdEqz	       0x100000
+#define	bUChCfg		  0x7000000
+#define	bUpdEqz		  0x8000000
+
+#define	bTxAGCRate18_06			0x7f7f7f7f	/*  Useless */
+#define	bTxAGCRate54_24			0x7f7f7f7f
+#define	bTxAGCRateMCS32			0x7f
+#define	bTxAGCRateCCK			0x7f00
+#define	bTxAGCRateMCS3_MCS0		0x7f7f7f7f
+#define	bTxAGCRateMCS7_MCS4		0x7f7f7f7f
+#define	bTxAGCRateMCS11_MCS8	0x7f7f7f7f
+#define	bTxAGCRateMCS15_MCS12	0x7f7f7f7f
+
+/* Rx Pseduo noise */
+#define	bRxPesudoNoiseOn	 0x20000000	/*  Useless */
+#define	bRxPesudoNoise_A	 0xff
+#define	bRxPesudoNoise_B	 0xff00
+#define	bRxPesudoNoise_C	 0xff0000
+#define	bRxPesudoNoise_D	 0xff000000
+#define	bPesudoNoiseState_A      0xffff
+#define	bPesudoNoiseState_B      0xffff0000
+#define	bPesudoNoiseState_C      0xffff
+#define	bPesudoNoiseState_D      0xffff0000
+
+/* 7. RF Register */
+/* Zebra1 */
+#define	bZebra1_HSSIEnable	0x8		/*  Useless */
+#define	bZebra1_TRxControl	0xc00
+#define	bZebra1_TRxGainSetting    0x07f
+#define	bZebra1_RxCorner	  0xc00
+#define	bZebra1_TxChargePump      0x38
+#define	bZebra1_RxChargePump      0x7
+#define	bZebra1_ChannelNum	0xf80
+#define	bZebra1_TxLPFBW	   0x400
+#define	bZebra1_RxLPFBW	   0x600
+
+/* Zebra4 */
+#define	bRTL8256RegModeCtrl1      0x100	/*  Useless */
+#define	bRTL8256RegModeCtrl0      0x40
+#define	bRTL8256_TxLPFBW	  0x18
+#define	bRTL8256_RxLPFBW	  0x600
+
+/* RTL8258 */
+#define	bRTL8258_TxLPFBW	  0xc	/*  Useless */
+#define	bRTL8258_RxLPFBW	  0xc00
+#define	bRTL8258_RSSILPFBW	0xc0
+
+/*  */
+/*  Other Definition */
+/*  */
+
+/* byte endable for sb_write */
+#define	bByte0		    0x1	/*  Useless */
+#define	bByte1		    0x2
+#define	bByte2		    0x4
+#define	bByte3		    0x8
+#define	bWord0		    0x3
+#define	bWord1		    0xc
+#define	bDWord		    0xf
+
+/* for PutRegsetting & GetRegSetting BitMask */
+#define	bMaskByte0		0xff	/*  Reg 0xc50 rOFDM0_XAAGCCore~0xC6f */
+#define	bMaskByte1		0xff00
+#define	bMaskByte2		0xff0000
+#define	bMaskByte3		0xff000000
+#define	bMaskHWord		0xffff0000
+#define	bMaskLWord		0x0000ffff
+#define	bMaskDWord		0xffffffff
+#define	bMaskH4Bits		0xf0000000
+#define	bMaskOFDM_D		0xffc00000
+#define	bMaskCCK		0x3f3f3f3f
+#define	bMask12Bits		0xfff
+
+/* for PutRFRegsetting & GetRFRegSetting BitMask */
+#if (RTL92SE_FPGA_VERIFY == 1)
+#define		bRFRegOffsetMask	0xfff
+#else
+#define		bRFRegOffsetMask	0xfffff
+#endif
+#define	bEnable		0x1	/*  Useless */
+#define	bDisabl		0x0
+
+#define	LeftAntenna	0x0	/*  Useless */
+#define	RightAntenna	0x1
+
+#define	tCheckTxStatus	500   /* 500ms Useless */
+#define	tUpdateRxCounter 100   /* 100ms */
+
+#define	rateCCK     0	/*  Useless */
+#define	rateOFDM    1
+#define	rateHT      2
+
+/* define Register-End */
+#define	bPMAC_End	 0x1ff	/*  Useless */
+#define	bFPGAPHY0_End	 0x8ff
+#define	bFPGAPHY1_End	 0x9ff
+#define	bCCKPHY0_End	 0xaff
+#define	bOFDMPHY0_End	 0xcff
+#define	bOFDMPHY1_End	 0xdff
+
+/* define max debug item in each debug page */
+/* define bMaxItem_FPGA_PHY0	0x9 */
+/* define bMaxItem_FPGA_PHY1	0x3 */
+/* define bMaxItem_PHY_11B	  0x16 */
+/* define bMaxItem_OFDM_PHY0	0x29 */
+/* define bMaxItem_OFDM_PHY1	0x0 */
+
+#define	bPMACControl	0x0		/*  Useless */
+#define	bWMACControl	0x1
+#define	bWNICControl	0x2
+
+#define RCR_AAP		BIT(0)		/*  accept all physical address */
+#define RCR_APM		BIT(1)		/*  accept physical match */
+#define RCR_AM		BIT(2)		/*  accept multicast */
+#define RCR_AB		BIT(3)		/*  accept broadcast */
+#define RCR_ACRC32	BIT(5)		/*  accept error packet */
+#define RCR_9356SEL	BIT(6)
+#define RCR_AICV	BIT(12)		/*  Accept ICV error packet */
+#define RCR_RXFTH0	(BIT(13)|BIT(14)|BIT(15))	/*  Rx FIFO threshold */
+#define RCR_ADF		BIT(18)		/*  Accept Data(frame type) frame */
+#define RCR_ACF		BIT(19)		/*  Accept control frame */
+#define RCR_AMF		BIT(20)		/*  Accept management frame */
+#define RCR_ADD3	BIT(21)
+#define RCR_APWRMGT	BIT(22)		/*  Accept power management packet */
+#define RCR_CBSSID	BIT(23)		/*  Accept BSSID match packet */
+#define RCR_ENMARP	BIT(28)		/*  enable mac auto reset phy */
+#define RCR_EnCS1	BIT(29)		/*  enable carrier sense method 1 */
+#define RCR_EnCS2	BIT(30)		/*  enable carrier sense method 2 */
+#define RCR_OnlyErlPkt	BIT(31)		/*  Rx Early mode is performed for
+					 *  packet size greater than 1536 */
+
+/*--------------------------Define Parameters-------------------------------*/
+
+#endif	/* __INC_HAL8192SPHYREG_H */
diff --git a/drivers/staging/r8188eu/include/rtw_p2p.h b/drivers/staging/r8188eu/include/rtw_p2p.h
new file mode 100644
index 000000000000..a3e3adc92b99
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_p2p.h
@@ -0,0 +1,135 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_P2P_H_
+#define __RTW_P2P_H_
+
+#include <drv_types.h>
+
+u32 build_beacon_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf);
+u32 build_probe_resp_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf);
+u32 build_prov_disc_request_p2p_ie(struct wifidirect_info *pwdinfo,
+				   u8 *pbuf, u8 *pssid, u8 ussidlen,
+				   u8 *pdev_raddr);
+u32 build_assoc_resp_p2p_ie(struct wifidirect_info *pwdinfo,
+			    u8 *pbuf, u8 status_code);
+u32 build_deauth_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pbuf);
+u32 process_probe_req_p2p_ie(struct wifidirect_info *pwdinfo,
+			     u8 *pframe, uint len);
+u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo,
+			     u8 *pframe, uint len, struct sta_info *psta);
+u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo,
+			    u8 *pframe, uint len);
+u32 process_p2p_devdisc_resp(struct wifidirect_info *pwdinfo,
+			     u8 *pframe, uint len);
+u8 process_p2p_provdisc_req(struct wifidirect_info *pwdinfo,
+			    u8 *pframe, uint len);
+u8 process_p2p_provdisc_resp(struct wifidirect_info *pwdinfo,  u8 *pframe);
+u8 process_p2p_group_negotation_req(struct wifidirect_info *pwdinfo,
+				    u8 *pframe, uint len);
+u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo,
+				     u8 *pframe, uint len);
+u8 process_p2p_group_negotation_confirm(struct wifidirect_info *pwdinfo,
+					u8 *pframe, uint len);
+u8 process_p2p_presence_req(struct wifidirect_info *pwdinfo, u8 *pframe,
+			    uint len);
+void p2p_protocol_wk_hdl(struct adapter *padapter, int intcmdtype);
+void process_p2p_ps_ie(struct adapter *padapter, u8 *ies, u32 ielength);
+void p2p_ps_wk_hdl(struct adapter *padapter, u8 p2p_ps_state);
+u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue);
+void reset_global_wifidirect_info(struct adapter *padapter);
+int rtw_init_wifi_display_info(struct adapter *padapter);
+void rtw_init_wifidirect_timers(struct adapter *padapter);
+void rtw_init_wifidirect_addrs(struct adapter *padapter, u8 *dev_addr,
+			       u8 *iface_addr);
+void init_wifidirect_info(struct adapter *padapter, enum P2P_ROLE role);
+int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role);
+
+static inline void _rtw_p2p_set_state(struct wifidirect_info *wdinfo,
+				      enum P2P_STATE state)
+{
+	if (wdinfo->p2p_state != state)
+		wdinfo->p2p_state = state;
+}
+
+static inline void _rtw_p2p_set_pre_state(struct wifidirect_info *wdinfo,
+					  enum P2P_STATE state)
+{
+	if (wdinfo->pre_p2p_state != state)
+		wdinfo->pre_p2p_state = state;
+}
+
+static inline void _rtw_p2p_set_role(struct wifidirect_info *wdinfo,
+				     enum P2P_ROLE role)
+{
+	if (wdinfo->role != role)
+		wdinfo->role = role;
+}
+
+static inline int _rtw_p2p_state(struct wifidirect_info *wdinfo)
+{
+	return wdinfo->p2p_state;
+}
+
+static inline int _rtw_p2p_pre_state(struct wifidirect_info *wdinfo)
+{
+	return wdinfo->pre_p2p_state;
+}
+
+static inline int _rtw_p2p_role(struct wifidirect_info *wdinfo)
+{
+	return wdinfo->role;
+}
+
+static inline bool _rtw_p2p_chk_state(struct wifidirect_info *wdinfo,
+				      enum P2P_STATE state)
+{
+	return wdinfo->p2p_state == state;
+}
+
+static inline bool _rtw_p2p_chk_role(struct wifidirect_info *wdinfo,
+				     enum P2P_ROLE role)
+{
+	return wdinfo->role == role;
+}
+
+#define rtw_p2p_set_state(wdinfo, state) _rtw_p2p_set_state(wdinfo, state)
+#define rtw_p2p_set_pre_state(wdinfo, state)				\
+	 _rtw_p2p_set_pre_state(wdinfo, state)
+#define rtw_p2p_set_role(wdinfo, role) _rtw_p2p_set_role(wdinfo, role)
+
+#define rtw_p2p_state(wdinfo) _rtw_p2p_state(wdinfo)
+#define rtw_p2p_pre_state(wdinfo) _rtw_p2p_pre_state(wdinfo)
+#define rtw_p2p_role(wdinfo) _rtw_p2p_role(wdinfo)
+#define rtw_p2p_chk_state(wdinfo, state) _rtw_p2p_chk_state(wdinfo, state)
+#define rtw_p2p_chk_role(wdinfo, role) _rtw_p2p_chk_role(wdinfo, role)
+
+#define rtw_p2p_findphase_ex_set(wdinfo, value) \
+	((wdinfo)->find_phase_state_exchange_cnt = (value))
+
+/* is this find phase exchange for social channel scan? */
+#define rtw_p2p_findphase_ex_is_social(wdinfo)   \
+((wdinfo)->find_phase_state_exchange_cnt >= P2P_FINDPHASE_EX_SOCIAL_FIRST)
+
+/* should we need find phase exchange anymore? */
+#define rtw_p2p_findphase_ex_is_needed(wdinfo) \
+	((wdinfo)->find_phase_state_exchange_cnt < P2P_FINDPHASE_EX_MAX && \
+	(wdinfo)->find_phase_state_exchange_cnt != P2P_FINDPHASE_EX_NONE)
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
new file mode 100644
index 000000000000..3db33cd9fee7
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -0,0 +1,282 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_PWRCTRL_H_
+#define __RTW_PWRCTRL_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define FW_PWR0		0
+#define FW_PWR1		1
+#define FW_PWR2		2
+#define FW_PWR3		3
+#define HW_PWR0		7
+#define HW_PWR1		6
+#define HW_PWR2		2
+#define HW_PWR3		0
+#define HW_PWR4		8
+
+#define FW_PWRMSK	0x7
+
+#define XMIT_ALIVE	BIT(0)
+#define RECV_ALIVE	BIT(1)
+#define CMD_ALIVE	BIT(2)
+#define EVT_ALIVE	BIT(3)
+
+enum power_mgnt {
+	PS_MODE_ACTIVE = 0,
+	PS_MODE_MIN,
+	PS_MODE_MAX,
+	PS_MODE_DTIM,
+	PS_MODE_VOIP,
+	PS_MODE_UAPSD_WMM,
+	PS_MODE_UAPSD,
+	PS_MODE_IBSS,
+	PS_MODE_WWLAN,
+	PM_Radio_Off,
+	PM_Card_Disable,
+	PS_MODE_NUM
+};
+
+/*
+	BIT[2:0] = HW state
+	BIT[3] = Protocol PS state,   0: register active state,
+				      1: register sleep state
+	BIT[4] = sub-state
+*/
+
+#define PS_DPS			BIT(0)
+#define PS_LCLK			(PS_DPS)
+#define PS_RF_OFF		BIT(1)
+#define PS_ALL_ON		BIT(2)
+#define PS_ST_ACTIVE		BIT(3)
+
+#define PS_ISR_ENABLE		BIT(4)
+#define PS_IMR_ENABLE		BIT(5)
+#define PS_ACK			BIT(6)
+#define PS_TOGGLE		BIT(7)
+
+#define PS_STATE_MASK		(0x0F)
+#define PS_STATE_HW_MASK	(0x07)
+#define PS_SEQ_MASK		(0xc0)
+
+#define PS_STATE(x)		(PS_STATE_MASK & (x))
+#define PS_STATE_HW(x)		(PS_STATE_HW_MASK & (x))
+#define PS_SEQ(x)		(PS_SEQ_MASK & (x))
+
+#define PS_STATE_S0		(PS_DPS)
+#define PS_STATE_S1		(PS_LCLK)
+#define PS_STATE_S2		(PS_RF_OFF)
+#define PS_STATE_S3		(PS_ALL_ON)
+#define PS_STATE_S4		((PS_ST_ACTIVE) | (PS_ALL_ON))
+
+#define PS_IS_RF_ON(x)	((x) & (PS_ALL_ON))
+#define PS_IS_ACTIVE(x)	((x) & (PS_ST_ACTIVE))
+#define CLR_PS_STATE(x)	((x) = ((x) & (0xF0)))
+
+struct reportpwrstate_parm {
+	unsigned char mode;
+	unsigned char state; /* the CPWM value */
+	unsigned short rsvd;
+};
+
+static inline void _init_pwrlock(struct semaphore  *plock)
+{
+	sema_init(plock, 1);
+}
+
+static inline void _free_pwrlock(struct semaphore  *plock)
+{
+}
+
+static inline void _enter_pwrlock(struct semaphore  *plock)
+{
+	_rtw_down_sema(plock);
+}
+
+static inline void _exit_pwrlock(struct semaphore  *plock)
+{
+	up(plock);
+}
+
+#define LPS_DELAY_TIME	1*HZ /*  1 sec */
+
+#define EXE_PWR_NONE	0x01
+#define EXE_PWR_IPS		0x02
+#define EXE_PWR_LPS		0x04
+
+/*  RF state. */
+enum rt_rf_power_state {
+	rf_on,		/*  RF is on after RFSleep or RFOff */
+	rf_sleep,	/*  802.11 Power Save mode */
+	rf_off,		/*  HW/SW Radio OFF or Inactive Power Save */
+	/* Add the new RF state above this line===== */
+	rf_max
+};
+
+/*  RF Off Level for IPS or HW/SW radio off */
+#define	RT_RF_OFF_LEVL_ASPM		BIT(0)	/* PCI ASPM */
+#define	RT_RF_OFF_LEVL_CLK_REQ		BIT(1)	/* PCI clock request */
+#define	RT_RF_OFF_LEVL_PCI_D3		BIT(2)	/* PCI D3 mode */
+#define	RT_RF_OFF_LEVL_HALT_NIC		BIT(3)	/* NIC halt, re-init hw param*/
+#define	RT_RF_OFF_LEVL_FREE_FW		BIT(4)	/* FW free, re-download the FW*/
+#define	RT_RF_OFF_LEVL_FW_32K		BIT(5)	/* FW in 32k */
+#define	RT_RF_PS_LEVEL_ALWAYS_ASPM	BIT(6)	/* Always enable ASPM and Clock
+						 * Req in initialization. */
+#define	RT_RF_LPS_DISALBE_2R		BIT(30)	/* When LPS is on, disable 2R
+						 * if no packet is RX or TX. */
+#define	RT_RF_LPS_LEVEL_ASPM		BIT(31)	/* LPS with ASPM */
+
+#define	RT_IN_PS_LEVEL(ppsc, _PS_FLAG)				\
+	((ppsc->cur_ps_level & _PS_FLAG) ? true : false)
+#define	RT_CLEAR_PS_LEVEL(ppsc, _PS_FLAG)			\
+	(ppsc->cur_ps_level &= (~(_PS_FLAG)))
+#define	RT_SET_PS_LEVEL(ppsc, _PS_FLAG)				\
+	(ppsc->cur_ps_level |= _PS_FLAG)
+
+enum _PS_BBRegBackup_ {
+	PSBBREG_RF0 = 0,
+	PSBBREG_RF1,
+	PSBBREG_RF2,
+	PSBBREG_AFE0,
+	PSBBREG_TOTALCNT
+};
+
+enum { /*  for ips_mode */
+	IPS_NONE = 0,
+	IPS_NORMAL,
+	IPS_LEVEL_2,
+};
+
+struct pwrctrl_priv {
+	struct semaphore lock;
+	volatile u8 rpwm; /*  requested power state for fw */
+	volatile u8 cpwm; /*  fw current power state. updated when
+			   * 1. read from HCPWM 2. driver lowers power level */
+	volatile u8 tog; /*  toggling */
+	volatile u8 cpwm_tog; /*  toggling */
+
+	u8	pwr_mode;
+	u8	smart_ps;
+	u8	bcn_ant_mode;
+
+	u32	alives;
+	struct work_struct cpwm_event;
+	u8	bpower_saving;
+
+	u8	b_hw_radio_off;
+	u8	reg_rfoff;
+	u8	reg_pdnmode; /* powerdown mode */
+	u32	rfoff_reason;
+
+	/* RF OFF Level */
+	u32	cur_ps_level;
+	u32	reg_rfps_level;
+	uint	ips_enter_cnts;
+	uint	ips_leave_cnts;
+
+	u8	ips_mode;
+	u8	ips_mode_req;	/*  used to accept the mode setting request,
+				 *  will update to ipsmode later */
+	uint bips_processing;
+	u32 ips_deny_time; /* will deny IPS when system time less than this */
+	u8 ps_processing; /* temp used to mark whether in rtw_ps_processor */
+
+	u8	bLeisurePs;
+	u8	LpsIdleCount;
+	u8	power_mgnt;
+	u8	bFwCurrentInPSMode;
+	u32	DelayLPSLastTimeStamp;
+	u8	btcoex_rfon;
+	s32		pnp_current_pwr_state;
+	u8		pnp_bstop_trx;
+
+	u8		bInternalAutoSuspend;
+	u8		bInSuspend;
+#ifdef	CONFIG_BT_COEXIST
+	u8		bAutoResume;
+	u8		autopm_cnt;
+#endif
+	u8		bSupportRemoteWakeup;
+	struct timer_list pwr_state_check_timer;
+	int		pwr_state_check_interval;
+	u8		pwr_state_check_cnts;
+
+	int		ps_flag;
+
+	enum rt_rf_power_state	rf_pwrstate;/* cur power state */
+	enum rt_rf_power_state	change_rfpwrstate;
+
+	u8		wepkeymask;
+	u8		bHWPowerdown;/* if support hw power down */
+	u8		bHWPwrPindetect;
+	u8		bkeepfwalive;
+	u8		brfoffbyhw;
+	unsigned long PS_BBRegBackup[PSBBREG_TOTALCNT];
+};
+
+#define rtw_get_ips_mode_req(pwrctrlpriv) \
+	(pwrctrlpriv)->ips_mode_req
+
+#define rtw_ips_mode_req(pwrctrlpriv, ips_mode) \
+	((pwrctrlpriv)->ips_mode_req = (ips_mode))
+
+#define RTW_PWR_STATE_CHK_INTERVAL 2000
+
+#define _rtw_set_pwr_state_check_timer(pwrctrlpriv, ms) \
+	do { \
+		_set_timer(&(pwrctrlpriv)->pwr_state_check_timer, (ms)); \
+	} while (0)
+
+#define rtw_set_pwr_state_check_timer(pwrctrl)			\
+	_rtw_set_pwr_state_check_timer((pwrctrl),		\
+				       (pwrctrl)->pwr_state_check_interval)
+
+void rtw_init_pwrctrl_priv(struct adapter *adapter);
+void rtw_free_pwrctrl_priv(struct adapter *adapter);
+
+void rtw_set_ps_mode(struct adapter *adapter, u8 ps_mode, u8 smart_ps,
+		     u8 bcn_ant_mode);
+void rtw_set_rpwm(struct adapter *adapter, u8 val8);
+void LeaveAllPowerSaveMode(struct adapter *adapter);
+void ips_enter(struct adapter *padapter);
+int ips_leave(struct adapter *padapter);
+
+void rtw_ps_processor(struct adapter *padapter);
+
+enum rt_rf_power_state RfOnOffDetect(struct adapter *iadapter);
+
+s32 LPS_RF_ON_check(struct adapter *adapter, u32 delay_ms);
+void LPS_Enter(struct adapter *adapter);
+void LPS_Leave(struct adapter *adapter);
+
+u8 rtw_interface_ps_func(struct adapter *adapter,
+			 enum hal_intf_ps_func efunc_id, u8 *val);
+void rtw_set_ips_deny(struct adapter *adapter, u32 ms);
+int _rtw_pwr_wakeup(struct adapter *adapter, u32 ips_defer_ms,
+		    const char *caller);
+#define rtw_pwr_wakeup(adapter)						\
+	 _rtw_pwr_wakeup(adapter, RTW_PWR_STATE_CHK_INTERVAL, __func__)
+#define rtw_pwr_wakeup_ex(adapter, ips_deffer_ms)			\
+	 _rtw_pwr_wakeup(adapter, ips_deffer_ms, __func__)
+int rtw_pm_set_ips(struct adapter *adapter, u8 mode);
+int rtw_pm_set_lps(struct adapter *adapter, u8 mode);
+
+#endif  /* __RTL871X_PWRCTRL_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_qos.h b/drivers/staging/r8188eu/include/rtw_qos.h
new file mode 100644
index 000000000000..bbee1ddc00bb
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_qos.h
@@ -0,0 +1,30 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_QOS_H_
+#define _RTW_QOS_H_
+
+#include <osdep_service.h>
+
+struct	qos_priv	{
+	unsigned int	  qos_option;	/* bit mask option: u-apsd,
+					 * s-apsd, ts, block ack... */
+};
+
+#endif	/* _RTL871X_QOS_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
new file mode 100644
index 000000000000..bc097ed7f966
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -0,0 +1,473 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_RECV_H_
+#define _RTW_RECV_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define NR_RECVFRAME 256
+
+#define RXFRAME_ALIGN	8
+#define RXFRAME_ALIGN_SZ	(1<<RXFRAME_ALIGN)
+
+#define MAX_RXFRAME_CNT	512
+#define MAX_RX_NUMBLKS		(32)
+#define RECVFRAME_HDR_ALIGN 128
+
+#define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
+
+#define MAX_SUBFRAME_COUNT	64
+
+/* for Rx reordering buffer control */
+struct recv_reorder_ctrl {
+	struct adapter	*padapter;
+	u8 enable;
+	u16 indicate_seq;/* wstart_b, init_value=0xffff */
+	u16 wend_b;
+	u8 wsize_b;
+	struct __queue pending_recvframe_queue;
+	struct timer_list reordering_ctrl_timer;
+};
+
+struct	stainfo_rxcache	{
+	u16	tid_rxseq[16];
+/*
+	unsigned short	tid0_rxseq;
+	unsigned short	tid1_rxseq;
+	unsigned short	tid2_rxseq;
+	unsigned short	tid3_rxseq;
+	unsigned short	tid4_rxseq;
+	unsigned short	tid5_rxseq;
+	unsigned short	tid6_rxseq;
+	unsigned short	tid7_rxseq;
+	unsigned short	tid8_rxseq;
+	unsigned short	tid9_rxseq;
+	unsigned short	tid10_rxseq;
+	unsigned short	tid11_rxseq;
+	unsigned short	tid12_rxseq;
+	unsigned short	tid13_rxseq;
+	unsigned short	tid14_rxseq;
+	unsigned short	tid15_rxseq;
+*/
+};
+
+struct smooth_rssi_data {
+	u32	elements[100];	/* array to store values */
+	u32	index;			/* index to current array to store */
+	u32	total_num;		/* num of valid elements */
+	u32	total_val;		/* sum of valid elements */
+};
+
+struct signal_stat {
+	u8	update_req;		/* used to indicate */
+	u8	avg_val;		/* avg of valid elements */
+	u32	total_num;		/* num of valid elements */
+	u32	total_val;		/* sum of valid elements */
+};
+#define MAX_PATH_NUM_92CS		3
+struct phy_info {
+	u8	RxPWDBAll;
+	u8	SignalQuality;	 /*  in 0-100 index. */
+	u8	RxMIMOSignalQuality[MAX_PATH_NUM_92CS]; /* EVM */
+	u8	RxMIMOSignalStrength[MAX_PATH_NUM_92CS];/*  in 0~100 index */
+	s8	RxPower; /*  in dBm Translate from PWdB */
+/*  Real power in dBm for this packet, no beautification and aggregation.
+ * Keep this raw info to be used for the other procedures. */
+	s8	recvpower;
+	u8	BTRxRSSIPercentage;
+	u8	SignalStrength; /*  in 0-100 index. */
+	u8	RxPwr[MAX_PATH_NUM_92CS];/* per-path's pwdb */
+	u8	RxSNR[MAX_PATH_NUM_92CS];/* per-path's SNR */
+};
+
+struct rx_pkt_attrib {
+	u16	pkt_len;
+	u8	physt;
+	u8	drvinfo_sz;
+	u8	shift_sz;
+	u8	hdrlen; /* the WLAN Header Len */
+	u8	to_fr_ds;
+	u8	amsdu;
+	u8	qos;
+	u8	priority;
+	u8	pw_save;
+	u8	mdata;
+	u16	seq_num;
+	u8	frag_num;
+	u8	mfrag;
+	u8	order;
+	u8	privacy; /* in frame_ctrl field */
+	u8	bdecrypted;
+	u8	encrypt; /* when 0 indicate no encrypt. when non-zero,
+			  * indicate the encrypt algorith */
+	u8	iv_len;
+	u8	icv_len;
+	u8	crc_err;
+	u8	icv_err;
+
+	u16 eth_type;
+
+	u8	dst[ETH_ALEN];
+	u8	src[ETH_ALEN];
+	u8	ta[ETH_ALEN];
+	u8	ra[ETH_ALEN];
+	u8	bssid[ETH_ALEN];
+
+	u8 ack_policy;
+
+	u8	key_index;
+
+	u8	mcs_rate;
+	u8	rxht;
+	u8	sgi;
+	u8	pkt_rpt_type;
+	u32	MacIDValidEntry[2];	/*  64 bits present 64 entry. */
+
+	struct phy_info phy_info;
+};
+
+/* These definition is used for Rx packet reordering. */
+#define SN_LESS(a, b)		(((a - b) & 0x800) != 0)
+#define SN_EQUAL(a, b)	(a == b)
+#define REORDER_WAIT_TIME	(50) /*  (ms) */
+
+#define RECVBUFF_ALIGN_SZ 8
+
+#define RXDESC_SIZE	24
+#define RXDESC_OFFSET RXDESC_SIZE
+
+struct recv_stat {
+	__le32 rxdw0;
+	__le32 rxdw1;
+	__le32 rxdw2;
+	__le32 rxdw3;
+	__le32 rxdw4;
+	__le32 rxdw5;
+};
+
+#define EOR BIT(30)
+
+/*
+accesser of recv_priv: rtw_recv_entry(dispatch / passive level);
+recv_thread(passive) ; returnpkt(dispatch)
+; halt(passive) ;
+
+using enter_critical section to protect
+*/
+struct recv_priv {
+	spinlock_t lock;
+	struct __queue free_recv_queue;
+	struct __queue recv_pending_queue;
+	struct __queue uc_swdec_pending_queue;
+	u8 *pallocated_frame_buf;
+	u8 *precv_frame_buf;
+	uint free_recvframe_cnt;
+	struct adapter	*adapter;
+	u32	bIsAnyNonBEPkts;
+	u64	rx_bytes;
+	u64	rx_pkts;
+	u64	rx_drop;
+	u64	last_rx_bytes;
+
+	uint  rx_icv_err;
+	uint  rx_largepacket_crcerr;
+	uint  rx_smallpacket_crcerr;
+	uint  rx_middlepacket_crcerr;
+	struct semaphore allrxreturnevt;
+	uint	ff_hwaddr;
+	u8	rx_pending_cnt;
+
+	struct tasklet_struct irq_prepare_beacon_tasklet;
+	struct tasklet_struct recv_tasklet;
+	struct sk_buff_head free_recv_skb_queue;
+	struct sk_buff_head rx_skb_queue;
+	u8 *pallocated_recv_buf;
+	u8 *precv_buf;    /*  4 alignment */
+	struct __queue free_recv_buf_queue;
+	u32	free_recv_buf_queue_cnt;
+	/* For display the phy informatiom */
+	u8 is_signal_dbg;	/*  for debug */
+	u8 signal_strength_dbg;	/*  for debug */
+	s8 rssi;
+	s8 rxpwdb;
+	u8 signal_strength;
+	u8 signal_qual;
+	u8 noise;
+	int RxSNRdB[2];
+	s8 RxRssi[2];
+	int FalseAlmCnt_all;
+
+	struct timer_list signal_stat_timer;
+	u32 signal_stat_sampling_interval;
+	struct signal_stat signal_qual_data;
+	struct signal_stat signal_strength_data;
+};
+
+#define rtw_set_signal_stat_timer(recvpriv)			\
+	_set_timer(&(recvpriv)->signal_stat_timer,		\
+		   (recvpriv)->signal_stat_sampling_interval)
+
+struct sta_recv_priv {
+	spinlock_t lock;
+	int	option;
+	struct __queue defrag_q; /* keeping the fragment frame until defrag */
+	struct	stainfo_rxcache rxcache;
+};
+
+struct recv_buf {
+	struct list_head list;
+	spinlock_t recvbuf_lock;
+	u32	ref_cnt;
+	struct adapter *adapter;
+	u8	*pbuf;
+	u8	*pallocated_buf;
+	u32	len;
+	u8	*phead;
+	u8	*pdata;
+	u8	*ptail;
+	u8	*pend;
+	struct urb *purb;
+	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
+	u32 alloc_sz;
+	u8  irp_pending;
+	int  transfer_len;
+	struct sk_buff *pskb;
+	u8	reuse;
+};
+
+/*
+	head  ----->
+
+		data  ----->
+
+			payload
+
+		tail  ----->
+
+	end   ----->
+
+	len = (unsigned int )(tail - data);
+
+*/
+struct recv_frame {
+	struct list_head list;
+	struct sk_buff	 *pkt;
+	struct sk_buff	 *pkt_newalloc;
+	struct adapter  *adapter;
+	u8 fragcnt;
+	int frame_tag;
+	struct rx_pkt_attrib attrib;
+	uint  len;
+	u8 *rx_head;
+	u8 *rx_data;
+	u8 *rx_tail;
+	u8 *rx_end;
+	void *precvbuf;
+	struct sta_info *psta;
+	/* for A-MPDU Rx reordering buffer control */
+	struct recv_reorder_ctrl *preorder_ctrl;
+};
+
+struct recv_frame *_rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
+struct recv_frame *rtw_alloc_recvframe(struct __queue *pfree_recv_queue);
+void rtw_init_recvframe(struct recv_frame *precvframe,
+			struct recv_priv *precvpriv);
+int  rtw_free_recvframe(struct recv_frame *precvframe,
+			struct __queue *pfree_recv_queue);
+#define rtw_dequeue_recvframe(queue) rtw_alloc_recvframe(queue)
+int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue);
+int rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue);
+void rtw_free_recvframe_queue(struct __queue *pframequeue,
+			      struct __queue *pfree_recv_queue);
+u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter);
+int rtw_enqueue_recvbuf_to_head(struct recv_buf *buf, struct __queue *queue);
+int rtw_enqueue_recvbuf(struct recv_buf *precvbuf, struct __queue *queue);
+struct recv_buf *rtw_dequeue_recvbuf(struct __queue *queue);
+
+void rtw_reordering_ctrl_timeout_handler(void *pcontext);
+
+static inline u8 *get_rxmem(struct recv_frame *precvframe)
+{
+	/* always return rx_head... */
+	if (precvframe == NULL)
+		return NULL;
+	return precvframe->rx_head;
+}
+
+static inline u8 *get_rx_status(struct recv_frame *precvframe)
+{
+	return get_rxmem(precvframe);
+}
+
+static inline u8 *get_recvframe_data(struct recv_frame *precvframe)
+{
+	/* always return rx_data */
+	if (precvframe == NULL)
+		return NULL;
+
+	return precvframe->rx_data;
+}
+
+static inline u8 *recvframe_push(struct recv_frame *precvframe, int sz)
+{
+	/*  append data before rx_data */
+
+	/* add data to the start of recv_frame
+ *
+ *      This function extends the used data area of the recv_frame at the buffer
+ *      start. rx_data must be still larger than rx_head, after pushing.
+ */
+	if (precvframe == NULL)
+		return NULL;
+	precvframe->rx_data -= sz ;
+	if (precvframe->rx_data < precvframe->rx_head) {
+		precvframe->rx_data += sz;
+		return NULL;
+	}
+	precvframe->len += sz;
+	return precvframe->rx_data;
+}
+
+static inline u8 *recvframe_pull(struct recv_frame *precvframe, int sz)
+{
+	/*  rx_data += sz; move rx_data sz bytes  hereafter */
+
+	/* used for extract sz bytes from rx_data, update rx_data and return
+	 * the updated rx_data to the caller */
+
+	if (precvframe == NULL)
+		return NULL;
+	precvframe->rx_data += sz;
+	if (precvframe->rx_data > precvframe->rx_tail) {
+		precvframe->rx_data -= sz;
+		return NULL;
+	}
+	precvframe->len -= sz;
+	return precvframe->rx_data;
+}
+
+static inline u8 *recvframe_put(struct recv_frame *precvframe, int sz)
+{
+	/* used for append sz bytes from ptr to rx_tail, update rx_tail
+	 * and return the updated rx_tail to the caller */
+	/* after putting, rx_tail must be still larger than rx_end. */
+
+	if (precvframe == NULL)
+		return NULL;
+
+	precvframe->rx_tail += sz;
+
+	if (precvframe->rx_tail > precvframe->rx_end) {
+		precvframe->rx_tail -= sz;
+		return NULL;
+	}
+	precvframe->len += sz;
+	return precvframe->rx_tail;
+}
+
+static inline u8 *recvframe_pull_tail(struct recv_frame *precvframe, int sz)
+{
+	/*  rmv data from rx_tail (by yitsen) */
+
+	/* used for extract sz bytes from rx_end, update rx_end and return
+	 * the updated rx_end to the caller */
+	/* after pulling, rx_end must be still larger than rx_data. */
+
+	if (precvframe == NULL)
+		return NULL;
+	precvframe->rx_tail -= sz;
+	if (precvframe->rx_tail < precvframe->rx_data) {
+		precvframe->rx_tail += sz;
+		return NULL;
+	}
+	precvframe->len -= sz;
+	return precvframe->rx_tail;
+}
+
+static inline unsigned char *get_rxbuf_desc(struct recv_frame *precvframe)
+{
+	unsigned char *buf_desc;
+
+	if (precvframe == NULL)
+		return NULL;
+	return buf_desc;
+}
+
+static inline struct recv_frame *rxmem_to_recvframe(u8 *rxmem)
+{
+	/* due to the design of 2048 bytes alignment of recv_frame,
+	 * we can reference the struct recv_frame */
+	/* from any given member of recv_frame. */
+	/*  rxmem indicates the any member/address in recv_frame */
+
+	return (struct recv_frame *)(((size_t)rxmem >> RXFRAME_ALIGN) << RXFRAME_ALIGN);
+}
+
+static inline struct recv_frame *pkt_to_recvframe(struct sk_buff *pkt)
+{
+	u8 *buf_star;
+	struct recv_frame *precv_frame;
+	precv_frame = rxmem_to_recvframe((unsigned char *)buf_star);
+
+	return precv_frame;
+}
+
+static inline u8 *pkt_to_recvmem(struct sk_buff *pkt)
+{
+	/*  return the rx_head */
+
+	struct recv_frame *precv_frame = pkt_to_recvframe(pkt);
+
+	return	precv_frame->rx_head;
+}
+
+static inline u8 *pkt_to_recvdata(struct sk_buff *pkt)
+{
+	/*  return the rx_data */
+
+	struct recv_frame *precv_frame = pkt_to_recvframe(pkt);
+
+	return	precv_frame->rx_data;
+}
+
+static inline int get_recvframe_len(struct recv_frame *precvframe)
+{
+	return precvframe->len;
+}
+
+static inline s32 translate_percentage_to_dbm(u32 sig_stren_index)
+{
+	s32	power; /*  in dBm. */
+
+	/*  Translate to dBm (x=0.5y-95). */
+	power = (s32)((sig_stren_index + 1) >> 1);
+	power -= 95;
+
+	return power;
+}
+
+struct sta_info;
+
+void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv);
+
+void  mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
new file mode 100644
index 000000000000..d4415e8115b2
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_rf.h
@@ -0,0 +1,145 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef	__RTW_RF_H_
+#define __RTW_RF_H_
+
+#include <rtw_cmd.h>
+
+#define OFDM_PHY		1
+#define MIXED_PHY		2
+#define CCK_PHY		3
+
+#define NumRates	(13)
+
+/*  slot time for 11g */
+#define SHORT_SLOT_TIME			9
+#define NON_SHORT_SLOT_TIME		20
+
+#define RTL8711_RF_MAX_SENS		6
+#define RTL8711_RF_DEF_SENS		4
+
+/*  We now define the following channels as the max channels in each
+ * channel plan. */
+/*  2G, total 14 chnls */
+/*  {1,2,3,4,5,6,7,8,9,10,11,12,13,14} */
+#define	MAX_CHANNEL_NUM_2G		14
+#define	MAX_CHANNEL_NUM			14	/* 2.4 GHz only */
+
+#define NUM_REGULATORYS	1
+
+/* Country codes */
+#define USA				0x555320
+#define EUROPE				0x1 /* temp, should be provided later */
+#define JAPAN				0x2 /* temp, should be provided later */
+
+struct	regulatory_class {
+	u32	starting_freq;				/* MHz, */
+	u8	channel_set[MAX_CHANNEL_NUM];
+	u8	channel_cck_power[MAX_CHANNEL_NUM];	/* dbm */
+	u8	channel_ofdm_power[MAX_CHANNEL_NUM];	/* dbm */
+	u8	txpower_limit;				/* dbm */
+	u8	channel_spacing;			/* MHz */
+	u8	modem;
+};
+
+enum capability {
+	cESS		= 0x0001,
+	cIBSS		= 0x0002,
+	cPollable	= 0x0004,
+	cPollReq	= 0x0008,
+	cPrivacy	= 0x0010,
+	cShortPreamble	= 0x0020,
+	cPBCC		= 0x0040,
+	cChannelAgility	= 0x0080,
+	cSpectrumMgnt	= 0x0100,
+	cQos		= 0x0200,	/* For HCCA, use with CF-Pollable
+					 * and CF-PollReq */
+	cShortSlotTime	= 0x0400,
+	cAPSD		= 0x0800,
+	cRM		= 0x1000,	/*  RRM (Radio Request Measurement) */
+	cDSSS_OFDM	= 0x2000,
+	cDelayedBA	= 0x4000,
+	cImmediateBA	= 0x8000,
+};
+
+enum	_REG_PREAMBLE_MODE {
+	PREAMBLE_LONG	= 1,
+	PREAMBLE_AUTO	= 2,
+	PREAMBLE_SHORT	= 3,
+};
+
+enum _RTL8712_RF_MIMO_CONFIG_ {
+	RTL8712_RFCONFIG_1T = 0x10,
+	RTL8712_RFCONFIG_2T = 0x20,
+	RTL8712_RFCONFIG_1R = 0x01,
+	RTL8712_RFCONFIG_2R = 0x02,
+	RTL8712_RFCONFIG_1T1R = 0x11,
+	RTL8712_RFCONFIG_1T2R = 0x12,
+	RTL8712_RFCONFIG_TURBO = 0x92,
+	RTL8712_RFCONFIG_2T2R = 0x22
+};
+
+enum rf90_radio_path {
+	RF90_PATH_A = 0,		/* Radio Path A */
+	RF90_PATH_B = 1,		/* Radio Path B */
+	RF90_PATH_C = 2,		/* Radio Path C */
+	RF90_PATH_D = 3			/* Radio Path D */
+};
+
+/*  Bandwidth Offset */
+#define HAL_PRIME_CHNL_OFFSET_DONT_CARE	0
+#define HAL_PRIME_CHNL_OFFSET_LOWER	1
+#define HAL_PRIME_CHNL_OFFSET_UPPER	2
+
+/*  Represent Channel Width in HT Capabilities */
+/*  */
+enum ht_channel_width {
+	HT_CHANNEL_WIDTH_20 = 0,
+	HT_CHANNEL_WIDTH_40 = 1,
+	HT_CHANNEL_WIDTH_80 = 2,
+	HT_CHANNEL_WIDTH_160 = 3,
+	HT_CHANNEL_WIDTH_10 = 4,
+};
+
+/*  */
+/*  Represent Extension Channel Offset in HT Capabilities */
+/*  This is available only in 40Mhz mode. */
+/*  */
+enum ht_extchnl_offset {
+	HT_EXTCHNL_OFFSET_NO_EXT = 0,
+	HT_EXTCHNL_OFFSET_UPPER = 1,
+	HT_EXTCHNL_OFFSET_NO_DEF = 2,
+	HT_EXTCHNL_OFFSET_LOWER = 3,
+};
+
+/* 2007/11/15 MH Define different RF type. */
+enum rt_rf_type_def {
+	RF_1T2R = 0,
+	RF_2T4R = 1,
+	RF_2T2R = 2,
+	RF_1T1R = 3,
+	RF_2T2R_GREEN = 4,
+	RF_819X_MAX_TYPE = 5,
+};
+
+u32 rtw_ch2freq(u32 ch);
+u32 rtw_freq2ch(u32 freq);
+
+#endif /* _RTL8711_RF_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_security.h b/drivers/staging/r8188eu/include/rtw_security.h
new file mode 100644
index 000000000000..c720ed1117db
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_security.h
@@ -0,0 +1,382 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __RTW_SECURITY_H_
+#define __RTW_SECURITY_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define _NO_PRIVACY_			0x0
+#define _WEP40_				0x1
+#define _TKIP_				0x2
+#define _TKIP_WTMIC_			0x3
+#define _AES_				0x4
+#define _WEP104_			0x5
+#define _WEP_WPA_MIXED_			0x07  /*  WEP + WPA */
+#define _SMS4_				0x06
+
+#define is_wep_enc(alg) (((alg) == _WEP40_) || ((alg) == _WEP104_))
+
+#define _WPA_IE_ID_	0xdd
+#define _WPA2_IE_ID_	0x30
+
+#define SHA256_MAC_LEN 32
+#define AES_BLOCK_SIZE 16
+#define AES_PRIV_SIZE (4 * 44)
+
+enum {
+	ENCRYP_PROTOCOL_OPENSYS,   /* open system */
+	ENCRYP_PROTOCOL_WEP,       /* WEP */
+	ENCRYP_PROTOCOL_WPA,       /* WPA */
+	ENCRYP_PROTOCOL_WPA2,      /* WPA2 */
+	ENCRYP_PROTOCOL_WAPI,      /* WAPI: Not support in this version */
+	ENCRYP_PROTOCOL_MAX
+};
+
+#ifndef Ndis802_11AuthModeWPA2
+#define Ndis802_11AuthModeWPA2 (Ndis802_11AuthModeWPANone + 1)
+#endif
+
+#ifndef Ndis802_11AuthModeWPA2PSK
+#define Ndis802_11AuthModeWPA2PSK (Ndis802_11AuthModeWPANone + 2)
+#endif
+
+union pn48	{
+	u64	val;
+
+#ifdef __LITTLE_ENDIAN
+	struct {
+		u8 TSC0;
+		u8 TSC1;
+		u8 TSC2;
+		u8 TSC3;
+		u8 TSC4;
+		u8 TSC5;
+		u8 TSC6;
+		u8 TSC7;
+	} _byte_;
+
+#elif defined(__BIG_ENDIAN)
+
+	struct {
+		u8 TSC7;
+		u8 TSC6;
+		u8 TSC5;
+		u8 TSC4;
+		u8 TSC3;
+		u8 TSC2;
+		u8 TSC1;
+		u8 TSC0;
+	} _byte_;
+#endif
+};
+
+union Keytype {
+	u8   skey[16];
+	u32    lkey[4];
+};
+
+struct rt_pmkid_list {
+	u8	bUsed;
+	u8	Bssid[6];
+	u8	PMKID[16];
+	u8	SsidBuf[33];
+	u8	*ssid_octet;
+	u16	ssid_length;
+};
+
+struct security_priv {
+	u32	  dot11AuthAlgrthm;	/*  802.11 auth, could be open,
+					 * shared, 8021x and authswitch */
+	u32	  dot11PrivacyAlgrthm;	/*  This specify the privacy for
+					 * shared auth. algorithm. */
+	/* WEP */
+	u32	  dot11PrivacyKeyIndex;	/*  this is only valid for legendary
+					 * wep, 0~3 for key id.(tx key index) */
+	union Keytype dot11DefKey[4];	/*  this is only valid for def. key */
+	u32	dot11DefKeylen[4];
+	u32 dot118021XGrpPrivacy;	/*  This specify the privacy algthm.
+					 * used for Grp key */
+	u32	dot118021XGrpKeyid;	/*  key id used for Grp Key
+					 * ( tx key index) */
+	union Keytype	dot118021XGrpKey[4];	/*  802.1x Group Key,
+						 * for inx0 and inx1 */
+	union Keytype	dot118021XGrptxmickey[4];
+	union Keytype	dot118021XGrprxmickey[4];
+	union pn48	dot11Grptxpn;		/* PN48 used for Grp Key xmit.*/
+	union pn48	dot11Grprxpn;		/* PN48 used for Grp Key recv.*/
+#ifdef CONFIG_88EU_AP_MODE
+	/* extend security capabilities for AP_MODE */
+	unsigned int dot8021xalg;/* 0:disable, 1:psk, 2:802.1x */
+	unsigned int wpa_psk;/* 0:disable, bit(0): WPA, bit(1):WPA2 */
+	unsigned int wpa_group_cipher;
+	unsigned int wpa2_group_cipher;
+	unsigned int wpa_pairwise_cipher;
+	unsigned int wpa2_pairwise_cipher;
+#endif
+	u8 wps_ie[MAX_WPS_IE_LEN];/* added in assoc req */
+	int wps_ie_len;
+	u8	binstallGrpkey;
+	u8	busetkipkey;
+	u8	bcheck_grpkey;
+	u8	bgrpkey_handshake;
+	s32	sw_encrypt;/* from registry_priv */
+	s32	sw_decrypt;/* from registry_priv */
+	s32	hw_decrypted;/* if the rx packets is hw_decrypted==false,i
+			      * it means the hw has not been ready. */
+
+	/* keeps the auth_type & enc_status from upper layer
+	 * ioctl(wpa_supplicant or wzc) */
+	u32 ndisauthtype;	/*  NDIS_802_11_AUTHENTICATION_MODE */
+	u32 ndisencryptstatus;	/*  NDIS_802_11_ENCRYPTION_STATUS */
+	struct wlan_bssid_ex sec_bss;  /* for joinbss (h2c buffer) usage */
+	struct ndis_802_11_wep ndiswep;
+	u8 assoc_info[600];
+	u8 szofcapability[256]; /* for wpa2 usage */
+	u8 oidassociation[512]; /* for wpa/wpa2 usage */
+	u8 authenticator_ie[256];  /* store ap security information element */
+	u8 supplicant_ie[256];  /* store sta security information element */
+
+	/* for tkip countermeasure */
+	u32 last_mic_err_time;
+	u8	btkip_countermeasure;
+	u8	btkip_wait_report;
+	u32 btkip_countermeasure_time;
+
+	/*  */
+	/*  For WPA2 Pre-Authentication. */
+	/*  */
+	struct rt_pmkid_list PMKIDList[NUM_PMKID_CACHE];
+	u8	PMKIDIndex;
+	u8 bWepDefaultKeyIdxSet;
+};
+
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(5, 8, 0)
+struct sha256_state {
+	u64 length;
+	u32 state[8], curlen;
+	u8 buf[64];
+};
+#endif
+
+#define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)		\
+do {									\
+	switch (psecuritypriv->dot11AuthAlgrthm) {			\
+	case dot11AuthAlgrthm_Open:					\
+	case dot11AuthAlgrthm_Shared:					\
+	case dot11AuthAlgrthm_Auto:					\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;	\
+		break;							\
+	case dot11AuthAlgrthm_8021X:					\
+		if (bmcst)						\
+			encry_algo = (u8)psecuritypriv->dot118021XGrpPrivacy;\
+		else							\
+			encry_algo = (u8)psta->dot118021XPrivacy;	\
+		break;							\
+	case dot11AuthAlgrthm_WAPI:					\
+		encry_algo = (u8)psecuritypriv->dot11PrivacyAlgrthm;	\
+		break;							\
+	}								\
+} while (0)
+
+#define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)			\
+do {									\
+	switch (encrypt) {						\
+	case _WEP40_:							\
+	case _WEP104_:							\
+		iv_len = 4;						\
+		icv_len = 4;						\
+		break;							\
+	case _TKIP_:							\
+		iv_len = 8;						\
+		icv_len = 4;						\
+		break;							\
+	case _AES_:							\
+		iv_len = 8;						\
+		icv_len = 8;						\
+		break;							\
+	case _SMS4_:							\
+		iv_len = 18;						\
+		icv_len = 16;						\
+		break;							\
+	default:							\
+		iv_len = 0;						\
+		icv_len = 0;						\
+		break;							\
+	}								\
+} while (0)
+
+#define GET_TKIP_PN(iv, dot11txpn)					\
+do {									\
+	dot11txpn._byte_.TSC0 = iv[2];					\
+	dot11txpn._byte_.TSC1 = iv[0];					\
+	dot11txpn._byte_.TSC2 = iv[4];					\
+	dot11txpn._byte_.TSC3 = iv[5];					\
+	dot11txpn._byte_.TSC4 = iv[6];					\
+	dot11txpn._byte_.TSC5 = iv[7];					\
+} while (0)
+
+#define ROL32(A, n)	(((A) << (n)) | (((A)>>(32-(n)))  & ((1UL << (n)) - 1)))
+#define ROR32(A, n)	ROL32((A), 32-(n))
+
+struct mic_data {
+	u32  K0, K1;         /*  Key */
+	u32  L, R;           /*  Current state */
+	u32  M;              /*  Message accumulator (single word) */
+	u32  nBytesInM;      /*  # bytes in M */
+};
+
+extern const u32 Te0[256];
+extern const u32 Te1[256];
+extern const u32 Te2[256];
+extern const u32 Te3[256];
+extern const u32 Te4[256];
+extern const u32 Td0[256];
+extern const u32 Td1[256];
+extern const u32 Td2[256];
+extern const u32 Td3[256];
+extern const u32 Td4[256];
+extern const u32 rcon[10];
+extern const u8 Td4s[256];
+extern const u8 rcons[10];
+
+#define RCON(i) (rcons[(i)] << 24)
+
+static inline u32 rotr(u32 val, int bits)
+{
+	return (val >> bits) | (val << (32 - bits));
+}
+
+#define TE0(i) Te0[((i) >> 24) & 0xff]
+#define TE1(i) rotr(Te0[((i) >> 16) & 0xff], 8)
+#define TE2(i) rotr(Te0[((i) >> 8) & 0xff], 16)
+#define TE3(i) rotr(Te0[(i) & 0xff], 24)
+#define TE41(i) ((Te0[((i) >> 24) & 0xff] << 8) & 0xff000000)
+#define TE42(i) (Te0[((i) >> 16) & 0xff] & 0x00ff0000)
+#define TE43(i) (Te0[((i) >> 8) & 0xff] & 0x0000ff00)
+#define TE44(i) ((Te0[(i) & 0xff] >> 8) & 0x000000ff)
+#define TE421(i) ((Te0[((i) >> 16) & 0xff] << 8) & 0xff000000)
+#define TE432(i) (Te0[((i) >> 8) & 0xff] & 0x00ff0000)
+#define TE443(i) (Te0[(i) & 0xff] & 0x0000ff00)
+#define TE414(i) ((Te0[((i) >> 24) & 0xff] >> 8) & 0x000000ff)
+#define TE4(i) ((Te0[(i)] >> 8) & 0x000000ff)
+
+#define TD0(i) Td0[((i) >> 24) & 0xff]
+#define TD1(i) rotr(Td0[((i) >> 16) & 0xff], 8)
+#define TD2(i) rotr(Td0[((i) >> 8) & 0xff], 16)
+#define TD3(i) rotr(Td0[(i) & 0xff], 24)
+#define TD41(i) (Td4s[((i) >> 24) & 0xff] << 24)
+#define TD42(i) (Td4s[((i) >> 16) & 0xff] << 16)
+#define TD43(i) (Td4s[((i) >> 8) & 0xff] << 8)
+#define TD44(i) (Td4s[(i) & 0xff])
+#define TD0_(i) Td0[(i) & 0xff]
+#define TD1_(i) rotr(Td0[(i) & 0xff], 8)
+#define TD2_(i) rotr(Td0[(i) & 0xff], 16)
+#define TD3_(i) rotr(Td0[(i) & 0xff], 24)
+
+#define GETU32(pt) (((u32)(pt)[0] << 24) ^ ((u32)(pt)[1] << 16) ^ \
+			((u32)(pt)[2] <<  8) ^ ((u32)(pt)[3]))
+
+#define PUTU32(ct, st) { \
+(ct)[0] = (u8)((st) >> 24); (ct)[1] = (u8)((st) >> 16); \
+(ct)[2] = (u8)((st) >>  8); (ct)[3] = (u8)(st); }
+
+#define WPA_GET_BE32(a) ((((u32)(a)[0]) << 24) | (((u32)(a)[1]) << 16) | \
+			 (((u32)(a)[2]) << 8) | ((u32)(a)[3]))
+
+#define WPA_PUT_LE16(a, val)			\
+	do {					\
+		(a)[1] = ((u16)(val)) >> 8;	\
+		(a)[0] = ((u16)(val)) & 0xff;	\
+	} while (0)
+
+#define WPA_PUT_BE32(a, val)					\
+	do {							\
+		(a)[0] = (u8)((((u32)(val)) >> 24) & 0xff);	\
+		(a)[1] = (u8)((((u32)(val)) >> 16) & 0xff);	\
+		(a)[2] = (u8)((((u32)(val)) >> 8) & 0xff);	\
+		(a)[3] = (u8)(((u32)(val)) & 0xff);		\
+	} while (0)
+
+#define WPA_PUT_BE64(a, val)				\
+	do {						\
+		(a)[0] = (u8)(((u64)(val)) >> 56);	\
+		(a)[1] = (u8)(((u64)(val)) >> 48);	\
+		(a)[2] = (u8)(((u64)(val)) >> 40);	\
+		(a)[3] = (u8)(((u64)(val)) >> 32);	\
+		(a)[4] = (u8)(((u64)(val)) >> 24);	\
+		(a)[5] = (u8)(((u64)(val)) >> 16);	\
+		(a)[6] = (u8)(((u64)(val)) >> 8);	\
+		(a)[7] = (u8)(((u64)(val)) & 0xff);	\
+	} while (0)
+
+/* ===== start - public domain SHA256 implementation ===== */
+
+/* This is based on SHA256 implementation in LibTomCrypt that was released into
+ * public domain by Tom St Denis. */
+
+/* the K array */
+static const unsigned long K[64] = {
+	0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
+	0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
+	0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
+	0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
+	0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
+	0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
+	0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
+	0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
+	0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
+	0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
+	0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
+	0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
+	0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
+};
+
+/* Various logical functions */
+#define RORc(x, y) \
+	(((((unsigned long)(x) & 0xFFFFFFFFUL) >> (unsigned long)((y)&31)) | \
+	 ((unsigned long)(x) << (unsigned long)(32-((y)&31)))) & 0xFFFFFFFFUL)
+#define Ch(x, y ,z)       (z ^ (x & (y ^ z)))
+#define Maj(x, y, z)      (((x | y) & z) | (x & y))
+#define S(x, n)         RORc((x), (n))
+#define R(x, n)         (((x)&0xFFFFFFFFUL)>>(n))
+#define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
+#define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
+#define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
+#define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
+#ifndef MIN
+#define MIN(x, y) (((x) < (y)) ? (x) : (y))
+#endif
+
+void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);
+void rtw_secmicappendbyte(struct mic_data *pmicdata, u8 b);
+void rtw_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
+void rtw_secgetmic(struct mic_data *pmicdata, u8 *dst);
+void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len,
+			u8 *Miccode, u8   priority);
+u32 rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe);
+u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe);
+void rtw_wep_encrypt(struct adapter *padapter, u8  *pxmitframe);
+u32 rtw_aes_decrypt(struct adapter *padapter, u8  *precvframe);
+u32 rtw_tkip_decrypt(struct adapter *padapter, u8  *precvframe);
+void rtw_wep_decrypt(struct adapter *padapter, u8  *precvframe);
+void rtw_use_tkipkey_handler(void *FunctionContext);
+
+#endif	/* __RTL871X_SECURITY_H_ */
diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
new file mode 100644
index 000000000000..2a1244f75790
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -0,0 +1,50 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_SRESET_C_
+#define _RTW_SRESET_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+struct sreset_priv {
+	struct mutex	silentreset_mutex;
+	u8	silent_reset_inprogress;
+	u8	Wifi_Error_Status;
+	unsigned long last_tx_time;
+	unsigned long last_tx_complete_time;
+};
+
+#include <rtl8188e_hal.h>
+
+#define	WIFI_STATUS_SUCCESS		0
+#define	USB_VEN_REQ_CMD_FAIL	BIT0
+#define	USB_READ_PORT_FAIL		BIT1
+#define	USB_WRITE_PORT_FAIL		BIT2
+#define	WIFI_MAC_TXDMA_ERROR	BIT3
+#define   WIFI_TX_HANG				BIT4
+#define	WIFI_RX_HANG				BIT5
+#define		WIFI_IF_NOT_EXIST			BIT6
+
+void sreset_init_value(struct adapter *padapter);
+void sreset_reset_value(struct adapter *padapter);
+u8 sreset_get_wifi_status(struct adapter *padapter);
+void sreset_set_wifi_error_status(struct adapter *padapter, u32 status);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/rtw_version.h b/drivers/staging/r8188eu/include/rtw_version.h
new file mode 100644
index 000000000000..6d2d52cbb3d3
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_version.h
@@ -0,0 +1 @@
+#define DRIVERVERSION	"v4.1.4_6773.20130222"
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
new file mode 100644
index 000000000000..5253dd0affd7
--- /dev/null
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -0,0 +1,383 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _RTW_XMIT_H_
+#define _RTW_XMIT_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#define MAX_XMITBUF_SZ	(20480)	/*  20k */
+#define NR_XMITBUFF		(4)
+
+#define XMITBUF_ALIGN_SZ	4
+
+/*  xmit extension buff defination */
+#define MAX_XMIT_EXTBUF_SZ	(1536)
+#define NR_XMIT_EXTBUFF		(32)
+
+#define MAX_NUMBLKS		(1)
+
+#define XMIT_VO_QUEUE		(0)
+#define XMIT_VI_QUEUE		(1)
+#define XMIT_BE_QUEUE		(2)
+#define XMIT_BK_QUEUE		(3)
+
+#define VO_QUEUE_INX		0
+#define VI_QUEUE_INX		1
+#define BE_QUEUE_INX		2
+#define BK_QUEUE_INX		3
+#define BCN_QUEUE_INX		4
+#define MGT_QUEUE_INX		5
+#define HIGH_QUEUE_INX		6
+#define TXCMD_QUEUE_INX		7
+
+#define HW_QUEUE_ENTRY		8
+
+#define WEP_IV(pattrib_iv, dot11txpn, keyidx)\
+do {\
+	pattrib_iv[0] = dot11txpn._byte_.TSC0;\
+	pattrib_iv[1] = dot11txpn._byte_.TSC1;\
+	pattrib_iv[2] = dot11txpn._byte_.TSC2;\
+	pattrib_iv[3] = ((keyidx & 0x3)<<6);\
+	dot11txpn.val = (dot11txpn.val == 0xffffff) ? 0 : (dot11txpn.val+1);\
+} while (0)
+
+#define TKIP_IV(pattrib_iv, dot11txpn, keyidx)\
+do {\
+	pattrib_iv[0] = dot11txpn._byte_.TSC1;\
+	pattrib_iv[1] = (dot11txpn._byte_.TSC1 | 0x20) & 0x7f;\
+	pattrib_iv[2] = dot11txpn._byte_.TSC0;\
+	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3)<<6);\
+	pattrib_iv[4] = dot11txpn._byte_.TSC2;\
+	pattrib_iv[5] = dot11txpn._byte_.TSC3;\
+	pattrib_iv[6] = dot11txpn._byte_.TSC4;\
+	pattrib_iv[7] = dot11txpn._byte_.TSC5;\
+	dot11txpn.val = dot11txpn.val == 0xffffffffffffULL ? 0 : (dot11txpn.val+1);\
+} while (0)
+
+#define AES_IV(pattrib_iv, dot11txpn, keyidx)\
+do {							\
+	pattrib_iv[0] = dot11txpn._byte_.TSC0;		\
+	pattrib_iv[1] = dot11txpn._byte_.TSC1;		\
+	pattrib_iv[2] = 0;				\
+	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3)<<6);	\
+	pattrib_iv[4] = dot11txpn._byte_.TSC2;		\
+	pattrib_iv[5] = dot11txpn._byte_.TSC3;		\
+	pattrib_iv[6] = dot11txpn._byte_.TSC4;		\
+	pattrib_iv[7] = dot11txpn._byte_.TSC5;		\
+	dot11txpn.val = dot11txpn.val == 0xffffffffffffULL ? 0 : (dot11txpn.val+1);\
+} while (0)
+
+#define HWXMIT_ENTRY	4
+
+#define TXDESC_SIZE 32
+
+#define PACKET_OFFSET_SZ (8)
+#define TXDESC_OFFSET (TXDESC_SIZE + PACKET_OFFSET_SZ)
+
+struct tx_desc {
+	/* DWORD 0 */
+	__le32 txdw0;
+	__le32 txdw1;
+	__le32 txdw2;
+	__le32 txdw3;
+	__le32 txdw4;
+	__le32 txdw5;
+	__le32 txdw6;
+	__le32 txdw7;
+};
+
+union txdesc {
+	struct tx_desc txdesc;
+	unsigned int value[TXDESC_SIZE>>2];
+};
+
+struct	hw_xmit	{
+	struct __queue *sta_queue;
+	int	accnt;
+};
+
+/* reduce size */
+struct pkt_attrib {
+	u8	type;
+	u8	subtype;
+	u8	bswenc;
+	u8	dhcp_pkt;
+	u16	ether_type;
+	u16	seqnum;
+	u16	pkt_hdrlen;	/* the original 802.3 pkt header len */
+	u16	hdrlen;		/* the WLAN Header Len */
+	u32	pktlen;		/* the original 802.3 pkt raw_data len (not include
+				 * ether_hdr data) */
+	u32	last_txcmdsz;
+	u8	nr_frags;
+	u8	encrypt;	/* when 0 indicate no encrypt. when non-zero,
+				 * indicate the encrypt algorith */
+	u8	iv_len;
+	u8	icv_len;
+	u8	iv[18];
+	u8	icv[16];
+	u8	priority;
+	u8	ack_policy;
+	u8	mac_id;
+	u8	vcs_mode;	/* virtual carrier sense method */
+	u8	dst[ETH_ALEN];
+	u8	src[ETH_ALEN];
+	u8	ta[ETH_ALEN];
+	u8	ra[ETH_ALEN];
+	u8	key_idx;
+	u8	qos_en;
+	u8	ht_en;
+	u8	raid;/* rate adpative id */
+	u8	bwmode;
+	u8	ch_offset;/* PRIME_CHNL_OFFSET */
+	u8	sgi;/* short GI */
+	u8	ampdu_en;/* tx ampdu enable */
+	u8	mdata;/* more data bit */
+	u8	pctrl;/* per packet txdesc control enable */
+	u8	triggered;/* for ap mode handling Power Saving sta */
+	u8	qsel;
+	u8	eosp;
+	u8	rate;
+	u8	intel_proxim;
+	u8	retry_ctrl;
+	struct sta_info *psta;
+};
+
+#define WLANHDR_OFFSET	64
+
+#define NULL_FRAMETAG		(0x0)
+#define DATA_FRAMETAG		0x01
+#define L2_FRAMETAG		0x02
+#define MGNT_FRAMETAG		0x03
+#define AMSDU_FRAMETAG	0x04
+
+#define EII_FRAMETAG		0x05
+#define IEEE8023_FRAMETAG  0x06
+
+#define MP_FRAMETAG		0x07
+
+#define TXAGG_FRAMETAG	0x08
+
+struct  submit_ctx {
+	u32 submit_time; /* */
+	u32 timeout_ms; /* <0: not synchronous, 0: wait forever, >0: up to ms waiting */
+	int status; /* status for operation */
+	struct completion done;
+};
+
+enum {
+	RTW_SCTX_SUBMITTED = -1,
+	RTW_SCTX_DONE_SUCCESS = 0,
+	RTW_SCTX_DONE_UNKNOWN,
+	RTW_SCTX_DONE_TIMEOUT,
+	RTW_SCTX_DONE_BUF_ALLOC,
+	RTW_SCTX_DONE_BUF_FREE,
+	RTW_SCTX_DONE_WRITE_PORT_ERR,
+	RTW_SCTX_DONE_TX_DESC_NA,
+	RTW_SCTX_DONE_TX_DENY,
+	RTW_SCTX_DONE_CCX_PKT_FAIL,
+	RTW_SCTX_DONE_DRV_STOP,
+	RTW_SCTX_DONE_DEV_REMOVE,
+};
+
+void rtw_sctx_init(struct submit_ctx *sctx, int timeout_ms);
+int rtw_sctx_wait(struct submit_ctx *sctx);
+void rtw_sctx_done_err(struct submit_ctx **sctx, int status);
+void rtw_sctx_done(struct submit_ctx **sctx);
+
+struct xmit_buf {
+	struct list_head list;
+	struct adapter *padapter;
+	u8 *pallocated_buf;
+	u8 *pbuf;
+	void *priv_data;
+	u16 ext_tag; /*  0: Normal xmitbuf, 1: extension xmitbuf. */
+	u16 flags;
+	u32 alloc_sz;
+	u32  len;
+	struct submit_ctx *sctx;
+	u32	ff_hwaddr;
+	struct urb *pxmit_urb[8];
+	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
+	u8 bpending[8];
+	int last[8];
+};
+
+struct xmit_frame {
+	struct list_head list;
+	struct pkt_attrib attrib;
+	struct sk_buff *pkt;
+	int	frame_tag;
+	struct adapter *padapter;
+	u8	*buf_addr;
+	struct xmit_buf *pxmitbuf;
+
+	u8	agg_num;
+	s8	pkt_offset;
+	u8 ack_report;
+};
+
+struct tx_servq {
+	struct list_head tx_pending;
+	struct __queue sta_pending;
+	int qcnt;
+};
+
+struct sta_xmit_priv {
+	spinlock_t lock;
+	int	option;
+	int	apsd_setting;	/* When bit mask is on, the associated edca
+				 * queue supports APSD. */
+	struct tx_servq	be_q;			/* priority == 0,3 */
+	struct tx_servq	bk_q;			/* priority == 1,2 */
+	struct tx_servq	vi_q;			/* priority == 4,5 */
+	struct tx_servq	vo_q;			/* priority == 6,7 */
+	struct list_head legacy_dz;
+	struct list_head apsd;
+	u16 txseq_tid[16];
+};
+
+struct	hw_txqueue {
+	volatile int	head;
+	volatile int	tail;
+	volatile int	free_sz;	/* in units of 64 bytes */
+	volatile int      free_cmdsz;
+	volatile int	 txsz[8];
+	uint	ff_hwaddr;
+	uint	cmd_hwaddr;
+	int	ac_tag;
+};
+
+struct agg_pkt_info {
+	u16 offset;
+	u16 pkt_len;
+};
+
+struct	xmit_priv {
+	spinlock_t lock;
+	struct semaphore xmit_sema;
+	struct semaphore terminate_xmitthread_sema;
+	struct __queue be_pending;
+	struct __queue bk_pending;
+	struct __queue vi_pending;
+	struct __queue vo_pending;
+	struct __queue bm_pending;
+	u8 *pallocated_frame_buf;
+	u8 *pxmit_frame_buf;
+	uint free_xmitframe_cnt;
+	struct __queue free_xmit_queue;
+	uint	frag_len;
+	struct adapter	*adapter;
+	u8   vcs_setting;
+	u8	vcs;
+	u8	vcs_type;
+	u64	tx_bytes;
+	u64	tx_pkts;
+	u64	tx_drop;
+	u64	last_tx_bytes;
+	u64	last_tx_pkts;
+	struct hw_xmit *hwxmits;
+	u8	hwxmit_entry;
+	u8	wmm_para_seq[4];/* sequence for wmm ac parameter strength
+				 * from large to small. it's value is 0->vo,
+				 * 1->vi, 2->be, 3->bk. */
+	struct semaphore tx_retevt;/* all tx return event; */
+	u8		txirp_cnt;/*  */
+	struct tasklet_struct xmit_tasklet;
+	/* per AC pending irp */
+	int beq_cnt;
+	int bkq_cnt;
+	int viq_cnt;
+	int voq_cnt;
+	struct __queue free_xmitbuf_queue;
+	struct __queue pending_xmitbuf_queue;
+	u8 *pallocated_xmitbuf;
+	u8 *pxmitbuf;
+	uint free_xmitbuf_cnt;
+	struct __queue free_xmit_extbuf_queue;
+	u8 *pallocated_xmit_extbuf;
+	u8 *pxmit_extbuf;
+	uint free_xmit_extbuf_cnt;
+	u16	nqos_ssn;
+	int	ack_tx;
+	struct mutex ack_tx_mutex;
+	struct submit_ctx ack_tx_ops;
+};
+
+struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv);
+s32 rtw_free_xmitbuf_ext(struct xmit_priv *pxmitpriv,
+			 struct xmit_buf *pxmitbuf);
+struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv);
+s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv,
+		     struct xmit_buf *pxmitbuf);
+void rtw_count_tx_stats(struct adapter *padapter,
+			struct xmit_frame *pxmitframe, int sz);
+void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len);
+s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr,
+		     struct pkt_attrib *pattrib);
+s32 rtw_put_snap(u8 *data, u16 h_proto);
+
+struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv);
+s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv,
+		       struct xmit_frame *pxmitframe);
+void rtw_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
+			      struct __queue *pframequeue);
+struct tx_servq *rtw_get_sta_pending(struct adapter *padapter,
+				     struct sta_info *psta, int up, u8 *ac);
+s32 rtw_xmitframe_enqueue(struct adapter *padapter,
+			  struct xmit_frame *pxmitframe);
+struct xmit_frame *rtw_dequeue_xframe(struct xmit_priv *pxmitpriv,
+				      struct hw_xmit *phwxmit_i, int entry);
+
+s32 rtw_xmit_classifier(struct adapter *padapter,
+			struct xmit_frame *pxmitframe);
+u32 rtw_calculate_wlan_pkt_size_by_attribue(struct pkt_attrib *pattrib);
+#define rtw_wlan_pkt_size(f) rtw_calculate_wlan_pkt_size_by_attribue(&f->attrib)
+s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt,
+			   struct xmit_frame *pxmitframe);
+s32 _rtw_init_hw_txqueue(struct hw_txqueue *phw_txqueue, u8 ac_tag);
+void _rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv);
+s32 rtw_txframes_pending(struct adapter *padapter);
+s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
+				struct pkt_attrib *pattrib);
+void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
+s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
+void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
+void rtw_alloc_hwxmits(struct adapter *padapter);
+void rtw_free_hwxmits(struct adapter *padapter);
+s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
+
+#if defined(CONFIG_88EU_AP_MODE)
+int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_frame *pxmitframe);
+void stop_sta_xmit(struct adapter *padapter, struct sta_info *psta);
+void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta);
+void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *psta);
+#endif
+
+u8	qos_acm(u8 acm_mask, u8 priority);
+u32	rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe);
+int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms);
+void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
+
+/* include after declaring struct xmit_buf, in order to avoid warning */
+#include <xmit_osdep.h>
+
+#endif	/* _RTL871X_XMIT_H_ */
diff --git a/drivers/staging/r8188eu/include/sta_info.h b/drivers/staging/r8188eu/include/sta_info.h
new file mode 100644
index 000000000000..3e909db1d41a
--- /dev/null
+++ b/drivers/staging/r8188eu/include/sta_info.h
@@ -0,0 +1,384 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __STA_INFO_H_
+#define __STA_INFO_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <wifi.h>
+
+#define IBSS_START_MAC_ID	2
+#define NUM_STA 32
+#define NUM_ACL 16
+
+/* if mode ==0, then the sta is allowed once the addr is hit. */
+/* if mode ==1, then the sta is rejected once the addr is non-hit. */
+struct rtw_wlan_acl_node {
+	struct list_head list;
+	u8       addr[ETH_ALEN];
+	u8       valid;
+};
+
+/* mode=0, disable */
+/* mode=1, accept unless in deny list */
+/* mode=2, deny unless in accept list */
+struct wlan_acl_pool {
+	int mode;
+	int num;
+	struct rtw_wlan_acl_node aclnode[NUM_ACL];
+	struct __queue acl_node_q;
+};
+
+struct rssi_sta {
+	s32	UndecoratedSmoothedPWDB;
+	s32	UndecoratedSmoothedCCK;
+	s32	UndecoratedSmoothedOFDM;
+	u64	PacketMap;
+	u8	ValidBit;
+};
+
+struct	stainfo_stats	{
+	u64 rx_mgnt_pkts;
+	u64 rx_beacon_pkts;
+	u64 rx_probereq_pkts;
+	u64 rx_probersp_pkts;
+	u64 rx_probersp_bm_pkts;
+	u64 rx_probersp_uo_pkts;
+	u64 rx_ctrl_pkts;
+	u64 rx_data_pkts;
+
+	u64	last_rx_mgnt_pkts;
+	u64 last_rx_beacon_pkts;
+	u64 last_rx_probereq_pkts;
+	u64 last_rx_probersp_pkts;
+	u64 last_rx_probersp_bm_pkts;
+	u64 last_rx_probersp_uo_pkts;
+	u64	last_rx_ctrl_pkts;
+	u64	last_rx_data_pkts;
+	u64	rx_bytes;
+	u64	rx_drops;
+	u64	tx_pkts;
+	u64	tx_bytes;
+	u64  tx_drops;
+};
+
+struct sta_info {
+	spinlock_t lock;
+	struct list_head list; /* free_sta_queue */
+	struct list_head hash_list; /* sta_hash */
+
+	struct sta_xmit_priv sta_xmitpriv;
+	struct sta_recv_priv sta_recvpriv;
+
+	struct __queue sleep_q;
+	unsigned int sleepq_len;
+
+	uint state;
+	uint aid;
+	uint mac_id;
+	uint qos_option;
+	u8	hwaddr[ETH_ALEN];
+
+	uint	ieee8021x_blocked;	/* 0: allowed, 1:blocked */
+	uint	dot118021XPrivacy; /* aes, tkip... */
+	union Keytype	dot11tkiptxmickey;
+	union Keytype	dot11tkiprxmickey;
+	union Keytype	dot118021x_UncstKey;
+	union pn48		dot11txpn;			/*  PN48 used for Unicast xmit. */
+	union pn48		dot11rxpn;			/*  PN48 used for Unicast recv. */
+	u8	bssrateset[16];
+	u32	bssratelen;
+	s32  rssi;
+	s32	signal_quality;
+
+	u8	cts2self;
+	u8	rtsen;
+
+	u8	raid;
+	u8	init_rate;
+	u32	ra_mask;
+	u8	wireless_mode;	/*  NETWORK_TYPE */
+	struct stainfo_stats sta_stats;
+
+	/* for A-MPDU TX, ADDBA timeout check */
+	struct timer_list addba_retry_timer;
+
+	/* for A-MPDU Rx reordering buffer control */
+	struct recv_reorder_ctrl recvreorder_ctrl[16];
+
+	/* for A-MPDU Tx */
+	/* unsigned char		ampdu_txen_bitmap; */
+	u16	BA_starting_seqctrl[16];
+
+	struct ht_priv	htpriv;
+
+	/* Notes: */
+	/* STA_Mode: */
+	/* curr_network(mlme_priv/security_priv/qos/ht) +
+	 * sta_info: (STA & AP) CAP/INFO */
+	/* scan_q: AP CAP/INFO */
+
+	/* AP_Mode: */
+	/* curr_network(mlme_priv/security_priv/qos/ht) : AP CAP/INFO */
+	/* sta_info: (AP & STA) CAP/INFO */
+
+	struct list_head asoc_list;
+#ifdef CONFIG_88EU_AP_MODE
+	struct list_head auth_list;
+
+	unsigned int expire_to;
+	unsigned int auth_seq;
+	unsigned int authalg;
+	unsigned char chg_txt[128];
+
+	u16 capability;
+	int flags;
+
+	int dot8021xalg;/* 0:disable, 1:psk, 2:802.1x */
+	int wpa_psk;/* 0:disable, bit(0): WPA, bit(1):WPA2 */
+	int wpa_group_cipher;
+	int wpa2_group_cipher;
+	int wpa_pairwise_cipher;
+	int wpa2_pairwise_cipher;
+
+	u8 bpairwise_key_installed;
+
+	u8 wpa_ie[32];
+
+	u8 nonerp_set;
+	u8 no_short_slot_time_set;
+	u8 no_short_preamble_set;
+	u8 no_ht_gf_set;
+	u8 no_ht_set;
+	u8 ht_20mhz_set;
+
+	unsigned int tx_ra_bitmap;
+	u8 qos_info;
+
+	u8 max_sp_len;
+	u8 uapsd_bk;/* BIT(0): Delivery enabled, BIT(1): Trigger enabled */
+	u8 uapsd_be;
+	u8 uapsd_vi;
+	u8 uapsd_vo;
+
+	u8 has_legacy_ac;
+	unsigned int sleepq_ac_len;
+#endif	/*  CONFIG_88EU_AP_MODE */
+
+#ifdef CONFIG_88EU_P2P
+	/* p2p priv data */
+	u8 is_p2p_device;
+	u8 p2p_status_code;
+
+	/* p2p client info */
+	u8 dev_addr[ETH_ALEN];
+	u8 dev_cap;
+	u16 config_methods;
+	u8 primary_dev_type[8];
+	u8 num_of_secdev_type;
+	u8 secdev_types_list[32];/*  32/8 == 4; */
+	u16 dev_name_len;
+	u8 dev_name[32];
+#endif /* CONFIG_88EU_P2P */
+	u8 under_exist_checking;
+	u8 keep_alive_trycnt;
+
+	/* for DM */
+	struct rssi_sta rssi_stat;
+
+	/*  ================ODM Relative Info======================= */
+	/*  Please be careful, don't declare too much structure here.
+	 *  It will cost memory * STA support num. */
+	/*  2011/10/20 MH Add for ODM STA info. */
+	/*  Driver Write */
+	u8	bValid;		/*  record the sta status link or not? */
+	u8	IOTPeer;	/*  Enum value.	HT_IOT_PEER_E */
+	u8	rssi_level;	/* for Refresh RA mask */
+	/*  ODM Write */
+	/* 1 PHY_STATUS_INFO */
+	u8		RSSI_Path[4];		/*  */
+	u8		RSSI_Ave;
+	u8		RXEVM[4];
+	u8		RXSNR[4];
+
+	/*  ================ODM Relative Info======================= */
+	/*  */
+
+	/* To store the sequence number of received management frame */
+	u16 RxMgmtFrameSeqNum;
+};
+
+#define sta_rx_pkts(sta) \
+	(sta->sta_stats.rx_mgnt_pkts \
+	+ sta->sta_stats.rx_ctrl_pkts \
+	+ sta->sta_stats.rx_data_pkts)
+
+#define sta_last_rx_pkts(sta) \
+	(sta->sta_stats.last_rx_mgnt_pkts \
+	+ sta->sta_stats.last_rx_ctrl_pkts \
+	+ sta->sta_stats.last_rx_data_pkts)
+
+#define sta_rx_data_pkts(sta) \
+	(sta->sta_stats.rx_data_pkts)
+
+#define sta_last_rx_data_pkts(sta) \
+	(sta->sta_stats.last_rx_data_pkts)
+
+#define sta_rx_mgnt_pkts(sta) \
+	(sta->sta_stats.rx_mgnt_pkts)
+
+#define sta_last_rx_mgnt_pkts(sta) \
+	(sta->sta_stats.last_rx_mgnt_pkts)
+
+#define sta_rx_beacon_pkts(sta) \
+	(sta->sta_stats.rx_beacon_pkts)
+
+#define sta_last_rx_beacon_pkts(sta) \
+	(sta->sta_stats.last_rx_beacon_pkts)
+
+#define sta_rx_probereq_pkts(sta) \
+	(sta->sta_stats.rx_probereq_pkts)
+
+#define sta_last_rx_probereq_pkts(sta) \
+	(sta->sta_stats.last_rx_probereq_pkts)
+
+#define sta_rx_probersp_pkts(sta) \
+	(sta->sta_stats.rx_probersp_pkts)
+
+#define sta_last_rx_probersp_pkts(sta) \
+	(sta->sta_stats.last_rx_probersp_pkts)
+
+#define sta_rx_probersp_bm_pkts(sta) \
+	(sta->sta_stats.rx_probersp_bm_pkts)
+
+#define sta_last_rx_probersp_bm_pkts(sta) \
+	(sta->sta_stats.last_rx_probersp_bm_pkts)
+
+#define sta_rx_probersp_uo_pkts(sta) \
+	(sta->sta_stats.rx_probersp_uo_pkts)
+
+#define sta_last_rx_probersp_uo_pkts(sta) \
+	(sta->sta_stats.last_rx_probersp_uo_pkts)
+
+#define sta_update_last_rx_pkts(sta) \
+do { \
+	sta->sta_stats.last_rx_mgnt_pkts = sta->sta_stats.rx_mgnt_pkts; \
+	sta->sta_stats.last_rx_beacon_pkts = sta->sta_stats.rx_beacon_pkts; \
+	sta->sta_stats.last_rx_probereq_pkts = sta->sta_stats.rx_probereq_pkts; \
+	sta->sta_stats.last_rx_probersp_pkts = sta->sta_stats.rx_probersp_pkts; \
+	sta->sta_stats.last_rx_probersp_bm_pkts = sta->sta_stats.rx_probersp_bm_pkts; \
+	sta->sta_stats.last_rx_probersp_uo_pkts = sta->sta_stats.rx_probersp_uo_pkts; \
+	sta->sta_stats.last_rx_ctrl_pkts = sta->sta_stats.rx_ctrl_pkts; \
+	sta->sta_stats.last_rx_data_pkts = sta->sta_stats.rx_data_pkts; \
+} while (0)
+
+#define STA_RX_PKTS_ARG(sta) \
+	sta->sta_stats.rx_mgnt_pkts \
+	, sta->sta_stats.rx_ctrl_pkts \
+	, sta->sta_stats.rx_data_pkts
+
+#define STA_LAST_RX_PKTS_ARG(sta) \
+	sta->sta_stats.last_rx_mgnt_pkts \
+	, sta->sta_stats.last_rx_ctrl_pkts \
+	, sta->sta_stats.last_rx_data_pkts
+
+#define STA_RX_PKTS_DIFF_ARG(sta) \
+	sta->sta_stats.rx_mgnt_pkts - sta->sta_stats.last_rx_mgnt_pkts \
+	, sta->sta_stats.rx_ctrl_pkts - sta->sta_stats.last_rx_ctrl_pkts \
+	, sta->sta_stats.rx_data_pkts - sta->sta_stats.last_rx_data_pkts
+
+#define STA_PKTS_FMT "(m:%llu, c:%llu, d:%llu)"
+
+struct	sta_priv {
+	u8 *pallocated_stainfo_buf;
+	u8 *pstainfo_buf;
+	struct __queue free_sta_queue;
+
+	spinlock_t sta_hash_lock;
+	struct list_head sta_hash[NUM_STA];
+	int asoc_sta_count;
+	struct __queue sleep_q;
+	struct __queue wakeup_q;
+
+	struct adapter *padapter;
+
+	spinlock_t asoc_list_lock;
+	struct list_head asoc_list;
+
+#ifdef CONFIG_88EU_AP_MODE
+	struct list_head auth_list;
+	spinlock_t auth_list_lock;
+	u8 asoc_list_cnt;
+	u8 auth_list_cnt;
+
+	unsigned int auth_to;  /* sec, time to expire in authenticating. */
+	unsigned int assoc_to; /* sec, time to expire before associating. */
+	unsigned int expire_to; /* sec , time to expire after associated. */
+
+	/* pointers to STA info; based on allocated AID or NULL if AID free
+	 * AID is in the range 1-2007, so sta_aid[0] corresponders to AID 1
+	 * and so on
+	 */
+	struct sta_info *sta_aid[NUM_STA];
+
+	u16 sta_dz_bitmap;/* only support 15 stations, station aid bitmap
+			   * for sleeping sta. */
+	u16 tim_bitmap;	/* only support 15 stations, aid=0~15 mapping
+			 * bit0~bit15 */
+
+	u16 max_num_sta;
+
+	struct wlan_acl_pool acl_list;
+#endif
+
+};
+
+static inline u32 wifi_mac_hash(u8 *mac)
+{
+	u32 x;
+
+	x = mac[0];
+	x = (x << 2) ^ mac[1];
+	x = (x << 2) ^ mac[2];
+	x = (x << 2) ^ mac[3];
+	x = (x << 2) ^ mac[4];
+	x = (x << 2) ^ mac[5];
+
+	x ^= x >> 8;
+	x  = x & (NUM_STA - 1);
+	return x;
+}
+
+extern u32	_rtw_init_sta_priv(struct sta_priv *pstapriv);
+extern u32	_rtw_free_sta_priv(struct sta_priv *pstapriv);
+
+#define stainfo_offset_valid(offset) (offset < NUM_STA && offset >= 0)
+int rtw_stainfo_offset(struct sta_priv *stapriv, struct sta_info *sta);
+struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int off);
+
+extern struct sta_info *rtw_alloc_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
+extern u32	rtw_free_stainfo(struct adapter *adapt, struct sta_info *psta);
+extern void rtw_free_all_stainfo(struct adapter *adapt);
+extern struct sta_info *rtw_get_stainfo(struct sta_priv *stapriv, u8 *hwaddr);
+extern u32 rtw_init_bcmc_stainfo(struct adapter *adapt);
+extern struct sta_info *rtw_get_bcmc_stainfo(struct adapter *padapter);
+extern u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr);
+
+#endif /* _STA_INFO_H_ */
diff --git a/drivers/staging/r8188eu/include/usb_hal.h b/drivers/staging/r8188eu/include/usb_hal.h
new file mode 100644
index 000000000000..8a65995d5e48
--- /dev/null
+++ b/drivers/staging/r8188eu/include/usb_hal.h
@@ -0,0 +1,26 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __USB_HAL_H__
+#define __USB_HAL_H__
+
+void rtl8188eu_set_hal_ops(struct adapter *padapter);
+#define hal_set_hal_ops	rtl8188eu_set_hal_ops
+
+#endif /* __USB_HAL_H__ */
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
new file mode 100644
index 000000000000..6562082beb7a
--- /dev/null
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -0,0 +1,115 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __USB_OPS_H_
+#define __USB_OPS_H_
+
+#include <linux/version.h>
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <osdep_intf.h>
+
+#define REALTEK_USB_VENQT_READ		0xC0
+#define REALTEK_USB_VENQT_WRITE		0x40
+#define REALTEK_USB_VENQT_CMD_REQ	0x05
+#define REALTEK_USB_VENQT_CMD_IDX	0x00
+
+enum {
+	VENDOR_WRITE = 0x00,
+	VENDOR_READ = 0x01,
+};
+#define ALIGNMENT_UNIT			16
+#define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
+#define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
+
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12))
+#define rtw_usb_control_msg(dev, pipe, request, requesttype,		\
+			    value, index, data, size, timeout_ms)	\
+	usb_control_msg((dev), (pipe), (request), (requesttype), (value),\
+			(index), (data), (size), (timeout_ms))
+#define rtw_usb_bulk_msg(usb_dev, pipe, data, len, actual_length, timeout_ms) \
+	usb_bulk_msg((usb_dev), (pipe), (data), (len),			\
+		     (actual_length), (timeout_ms))
+#else
+#define rtw_usb_control_msg(dev, pipe, request, requesttype,		\
+			    value, index, data, size, timeout_ms)	\
+	usb_control_msg((dev), (pipe), (request), (requesttype),	\
+			(value), (index), (data), (size),		\
+			((timeout_ms) == 0) ||				\
+			((timeout_ms)*HZ/1000 > 0) ?			\
+			((timeout_ms)*HZ/1000) : 1)
+#define rtw_usb_bulk_msg(usb_dev, pipe, data, len,			\
+			 actual_length, timeout_ms) \
+	usb_bulk_msg((usb_dev), (pipe), (data), (len), (actual_length), \
+		     ((timeout_ms) == 0) || ((timeout_ms)*HZ/1000 > 0) ?\
+		     ((timeout_ms)*HZ/1000) : 1)
+#endif
+#include <usb_ops_linux.h>
+
+void rtl8188eu_set_hw_type(struct adapter *padapter);
+#define hal_set_hw_type rtl8188eu_set_hw_type
+void rtl8188eu_set_intf_ops(struct _io_ops *pops);
+#define usb_set_intf_ops rtl8188eu_set_intf_ops
+
+/*
+ * Increase and check if the continual_urb_error of this @param dvobjprivei
+ * is larger than MAX_CONTINUAL_URB_ERR
+ * @return true:
+ * @return false:
+ */
+static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
+{
+	int ret = false;
+	int value;
+	value = ATOMIC_INC_RETURN(&dvobj->continual_urb_error);
+	if (value > MAX_CONTINUAL_URB_ERR) {
+		DBG_88E("[dvobj:%p][ERROR] continual_urb_error:%d > %d\n",
+			dvobj, value, MAX_CONTINUAL_URB_ERR);
+		ret = true;
+	}
+	return ret;
+}
+
+/*
+* Set the continual_urb_error of this @param dvobjprive to 0
+*/
+static inline void rtw_reset_continual_urb_error(struct dvobj_priv *dvobj)
+{
+	ATOMIC_SET(&dvobj->continual_urb_error, 0);
+}
+
+#define USB_HIGH_SPEED_BULK_SIZE	512
+#define USB_FULL_SPEED_BULK_SIZE	64
+
+static inline u8 rtw_usb_bulk_size_boundary(struct adapter *padapter,
+					    int buf_len)
+{
+	u8 rst = true;
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(padapter);
+
+	if (pdvobjpriv->ishighspeed)
+		rst = (0 == (buf_len) % USB_HIGH_SPEED_BULK_SIZE) ?
+		      true : false;
+	else
+		rst = (0 == (buf_len) % USB_FULL_SPEED_BULK_SIZE) ?
+		      true : false;
+	return rst;
+}
+
+#endif /* __USB_OPS_H_ */
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
new file mode 100644
index 000000000000..e5b758a81a5c
--- /dev/null
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -0,0 +1,55 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __USB_OPS_LINUX_H__
+#define __USB_OPS_LINUX_H__
+
+#define VENDOR_CMD_MAX_DATA_LEN	254
+
+#define RTW_USB_CONTROL_MSG_TIMEOUT_TEST	10/* ms */
+#define RTW_USB_CONTROL_MSG_TIMEOUT	500/* ms */
+
+#define MAX_USBCTRL_VENDORREQ_TIMES	10
+
+#define RTW_USB_BULKOUT_TIME	5000/* ms */
+
+#define _usbctrl_vendorreq_async_callback(urb, regs)	\
+	_usbctrl_vendorreq_async_callback(urb)
+#define usb_bulkout_zero_complete(purb, regs)		\
+	usb_bulkout_zero_complete(purb)
+#define usb_write_mem_complete(purb, regs)		\
+	usb_write_mem_complete(purb)
+#define usb_write_port_complete(purb, regs)		\
+	usb_write_port_complete(purb)
+#define usb_read_port_complete(purb, regs)		\
+	usb_read_port_complete(purb)
+#define usb_read_interrupt_complete(purb, regs)		\
+	usb_read_interrupt_complete(purb)
+
+unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
+
+void usb_read_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem);
+void usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
+
+void usb_read_port_cancel(struct intf_hdl *pintfhdl);
+
+u32 usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem);
+void usb_write_port_cancel(struct intf_hdl *pintfhdl);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/usb_osintf.h b/drivers/staging/r8188eu/include/usb_osintf.h
new file mode 100644
index 000000000000..9de99ca9799a
--- /dev/null
+++ b/drivers/staging/r8188eu/include/usb_osintf.h
@@ -0,0 +1,45 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __USB_OSINTF_H
+#define __USB_OSINTF_H
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <usb_vendor_req.h>
+
+extern char *rtw_initmac;
+extern int rtw_mc2u_disable;
+
+#define USBD_HALTED(Status) ((u32)(Status) >> 30 == 3)
+
+u8 usbvendorrequest(struct dvobj_priv *pdvobjpriv, enum bt_usb_request brequest,
+		    enum rt_usb_wvalue wvalue, u8 windex, void *data,
+		    u8 datalen, u8 isdirectionin);
+int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
+void netdev_br_init(struct net_device *netdev);
+void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb);
+void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
+		     unsigned char *ipAddr);
+void nat25_db_expire(struct adapter *priv);
+int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method);
+
+int rtw_resume_process(struct adapter *padapter);
+
+#endif
diff --git a/drivers/staging/r8188eu/include/usb_vendor_req.h b/drivers/staging/r8188eu/include/usb_vendor_req.h
new file mode 100644
index 000000000000..04f1b9e267e1
--- /dev/null
+++ b/drivers/staging/r8188eu/include/usb_vendor_req.h
@@ -0,0 +1,51 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _USB_VENDOR_REQUEST_H_
+#define _USB_VENDOR_REQUEST_H_
+
+/* 4	Set/Get Register related wIndex/Data */
+#define	RT_USB_RESET_MASK_OFF		0
+#define	RT_USB_RESET_MASK_ON		1
+#define	RT_USB_SLEEP_MASK_OFF		0
+#define	RT_USB_SLEEP_MASK_ON		1
+#define	RT_USB_LDO_ON				1
+#define	RT_USB_LDO_OFF				0
+
+/* 4	Set/Get SYSCLK related	wValue or Data */
+#define	RT_USB_SYSCLK_32KHZ		0
+#define	RT_USB_SYSCLK_40MHZ		1
+#define	RT_USB_SYSCLK_60MHZ		2
+
+enum bt_usb_request {
+	RT_USB_SET_REGISTER		= 1,
+	RT_USB_SET_SYSCLK		= 2,
+	RT_USB_GET_SYSCLK		= 3,
+	RT_USB_GET_REGISTER		= 4
+};
+
+enum rt_usb_wvalue {
+	RT_USB_RESET_MASK	=	1,
+	RT_USB_SLEEP_MASK	=	2,
+	RT_USB_USB_HRCPWM	=	3,
+	RT_USB_LDO			=	4,
+	RT_USB_BOOT_TYPE	=	5
+};
+
+#endif
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
new file mode 100644
index 000000000000..33a7e6c19d04
--- /dev/null
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -0,0 +1,1105 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef _WIFI_H_
+#define _WIFI_H_
+
+#include <linux/ieee80211.h>
+
+#ifdef BIT
+/* error	"BIT define occurred earlier elsewhere!\n" */
+#undef BIT
+#endif
+#define BIT(x)	(1 << (x))
+
+#define WLAN_ETHHDR_LEN		14
+#define WLAN_ETHADDR_LEN	6
+#define WLAN_IEEE_OUI_LEN	3
+#define WLAN_ADDR_LEN		6
+#define WLAN_CRC_LEN		4
+#define WLAN_BSSID_LEN		6
+#define WLAN_BSS_TS_LEN		8
+#define WLAN_HDR_A3_LEN		24
+#define WLAN_HDR_A4_LEN		30
+#define WLAN_HDR_A3_QOS_LEN	26
+#define WLAN_HDR_A4_QOS_LEN	32
+#define WLAN_SSID_MAXLEN	32
+#define WLAN_DATA_MAXLEN	2312
+
+#define WLAN_A3_PN_OFFSET	24
+#define WLAN_A4_PN_OFFSET	30
+
+#define WLAN_MIN_ETHFRM_LEN	60
+#define WLAN_MAX_ETHFRM_LEN	1514
+#define WLAN_ETHHDR_LEN		14
+
+#define P80211CAPTURE_VERSION	0x80211001
+
+/*  This value is tested by WiFi 11n Test Plan 5.2.3. */
+/*  This test verifies the WLAN NIC can update the NAV through sending
+ *  the CTS with large duration. */
+#define	WiFiNavUpperUs				30000	/*  30 ms */
+
+enum WIFI_FRAME_TYPE {
+	WIFI_MGT_TYPE  =	(0),
+	WIFI_CTRL_TYPE =	(BIT(2)),
+	WIFI_DATA_TYPE =	(BIT(3)),
+	WIFI_QOS_DATA_TYPE	= (BIT(7)|BIT(3)),	/*  QoS Data */
+};
+
+enum WIFI_FRAME_SUBTYPE {
+	/*  below is for mgt frame */
+	WIFI_ASSOCREQ       = (0 | WIFI_MGT_TYPE),
+	WIFI_ASSOCRSP       = (BIT(4) | WIFI_MGT_TYPE),
+	WIFI_REASSOCREQ     = (BIT(5) | WIFI_MGT_TYPE),
+	WIFI_REASSOCRSP     = (BIT(5) | BIT(4) | WIFI_MGT_TYPE),
+	WIFI_PROBEREQ       = (BIT(6) | WIFI_MGT_TYPE),
+	WIFI_PROBERSP       = (BIT(6) | BIT(4) | WIFI_MGT_TYPE),
+	WIFI_BEACON         = (BIT(7) | WIFI_MGT_TYPE),
+	WIFI_ATIM           = (BIT(7) | BIT(4) | WIFI_MGT_TYPE),
+	WIFI_DISASSOC       = (BIT(7) | BIT(5) | WIFI_MGT_TYPE),
+	WIFI_AUTH           = (BIT(7) | BIT(5) | BIT(4) | WIFI_MGT_TYPE),
+	WIFI_DEAUTH         = (BIT(7) | BIT(6) | WIFI_MGT_TYPE),
+	WIFI_ACTION         = (BIT(7) | BIT(6) | BIT(4) | WIFI_MGT_TYPE),
+
+	/*  below is for control frame */
+	WIFI_PSPOLL         = (BIT(7) | BIT(5) | WIFI_CTRL_TYPE),
+	WIFI_RTS            = (BIT(7) | BIT(5) | BIT(4) | WIFI_CTRL_TYPE),
+	WIFI_CTS            = (BIT(7) | BIT(6) | WIFI_CTRL_TYPE),
+	WIFI_ACK            = (BIT(7) | BIT(6) | BIT(4) | WIFI_CTRL_TYPE),
+	WIFI_CFEND          = (BIT(7) | BIT(6) | BIT(5) | WIFI_CTRL_TYPE),
+	WIFI_CFEND_CFACK    = (BIT(7) | BIT(6) | BIT(5) | BIT(4) |
+	WIFI_CTRL_TYPE),
+
+	/*  below is for data frame */
+	WIFI_DATA           = (0 | WIFI_DATA_TYPE),
+	WIFI_DATA_CFACK     = (BIT(4) | WIFI_DATA_TYPE),
+	WIFI_DATA_CFPOLL    = (BIT(5) | WIFI_DATA_TYPE),
+	WIFI_DATA_CFACKPOLL = (BIT(5) | BIT(4) | WIFI_DATA_TYPE),
+	WIFI_DATA_NULL      = (BIT(6) | WIFI_DATA_TYPE),
+	WIFI_CF_ACK         = (BIT(6) | BIT(4) | WIFI_DATA_TYPE),
+	WIFI_CF_POLL        = (BIT(6) | BIT(5) | WIFI_DATA_TYPE),
+	WIFI_CF_ACKPOLL     = (BIT(6) | BIT(5) | BIT(4) | WIFI_DATA_TYPE),
+	WIFI_QOS_DATA_NULL	= (BIT(6) | WIFI_QOS_DATA_TYPE),
+};
+
+enum WIFI_REASON_CODE	{
+	_RSON_RESERVED_			= 0,
+	_RSON_UNSPECIFIED_		= 1,
+	_RSON_AUTH_NO_LONGER_VALID_	= 2,
+	_RSON_DEAUTH_STA_LEAVING_	= 3,
+	_RSON_INACTIVITY_		= 4,
+	_RSON_UNABLE_HANDLE_		= 5,
+	_RSON_CLS2_			= 6,
+	_RSON_CLS3_			= 7,
+	_RSON_DISAOC_STA_LEAVING_	= 8,
+	_RSON_ASOC_NOT_AUTH_		= 9,
+
+	/*  WPA reason */
+	_RSON_INVALID_IE_		= 13,
+	_RSON_MIC_FAILURE_		= 14,
+	_RSON_4WAY_HNDSHK_TIMEOUT_	= 15,
+	_RSON_GROUP_KEY_UPDATE_TIMEOUT_	= 16,
+	_RSON_DIFF_IE_			= 17,
+	_RSON_MLTCST_CIPHER_NOT_VALID_	= 18,
+	_RSON_UNICST_CIPHER_NOT_VALID_	= 19,
+	_RSON_AKMP_NOT_VALID_		= 20,
+	_RSON_UNSUPPORT_RSNE_VER_	= 21,
+	_RSON_INVALID_RSNE_CAP_		= 22,
+	_RSON_IEEE_802DOT1X_AUTH_FAIL_	= 23,
+
+	/* belowing are Realtek definition */
+	_RSON_PMK_NOT_AVAILABLE_	= 24,
+	_RSON_TDLS_TEAR_TOOFAR_		= 25,
+	_RSON_TDLS_TEAR_UN_RSN_		= 26,
+};
+
+/* Reason codes (IEEE 802.11-2007, 7.3.1.7, Table 7-22)
+
+#define WLAN_REASON_UNSPECIFIED 1
+#define WLAN_REASON_PREV_AUTH_NOT_VALID 2
+#define WLAN_REASON_DEAUTH_LEAVING 3
+#define WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY 4
+#define WLAN_REASON_DISASSOC_AP_BUSY 5
+#define WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA 6
+#define WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA 7
+#define WLAN_REASON_DISASSOC_STA_HAS_LEFT 8
+#define WLAN_REASON_STA_REQ_ASSOC_WITHOUT_AUTH 9 */
+/* IEEE 802.11h */
+#define WLAN_REASON_PWR_CAPABILITY_NOT_VALID 10
+#define WLAN_REASON_SUPPORTED_CHANNEL_NOT_VALID 11
+
+/* IEEE 802.11i
+#define WLAN_REASON_INVALID_IE 13
+#define WLAN_REASON_MICHAEL_MIC_FAILURE 14
+#define WLAN_REASON_4WAY_HANDSHAKE_TIMEOUT 15
+#define WLAN_REASON_GROUP_KEY_UPDATE_TIMEOUT 16
+#define WLAN_REASON_IE_IN_4WAY_DIFFERS 17
+#define WLAN_REASON_GROUP_CIPHER_NOT_VALID 18
+#define WLAN_REASON_PAIRWISE_CIPHER_NOT_VALID 19
+#define WLAN_REASON_AKMP_NOT_VALID 20
+#define WLAN_REASON_UNSUPPORTED_RSN_IE_VERSION 21
+#define WLAN_REASON_INVALID_RSN_IE_CAPAB 22
+#define WLAN_REASON_IEEE_802_1X_AUTH_FAILED 23
+#define WLAN_REASON_CIPHER_SUITE_REJECTED 24 */
+
+enum WIFI_STATUS_CODE {
+	_STATS_SUCCESSFUL_		= 0,
+	_STATS_FAILURE_			= 1,
+	_STATS_CAP_FAIL_		= 10,
+	_STATS_NO_ASOC_			= 11,
+	_STATS_OTHER_			= 12,
+	_STATS_NO_SUPP_ALG_		= 13,
+	_STATS_OUT_OF_AUTH_SEQ_		= 14,
+	_STATS_CHALLENGE_FAIL_		= 15,
+	_STATS_AUTH_TIMEOUT_		= 16,
+	_STATS_UNABLE_HANDLE_STA_	= 17,
+	_STATS_RATE_FAIL_		= 18,
+};
+
+/* Status codes (IEEE 802.11-2007, 7.3.1.9, Table 7-23)
+#define WLAN_STATUS_SUCCESS 0
+#define WLAN_STATUS_UNSPECIFIED_FAILURE 1
+#define WLAN_STATUS_CAPS_UNSUPPORTED 10
+#define WLAN_STATUS_REASSOC_NO_ASSOC 11
+#define WLAN_STATUS_ASSOC_DENIED_UNSPEC 12
+#define WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG 13
+#define WLAN_STATUS_UNKNOWN_AUTH_TRANSACTION 14
+#define WLAN_STATUS_CHALLENGE_FAIL 15
+#define WLAN_STATUS_AUTH_TIMEOUT 16
+#define WLAN_STATUS_AP_UNABLE_TO_HANDLE_NEW_STA 17
+#define WLAN_STATUS_ASSOC_DENIED_RATES 18 */
+
+/* entended */
+/* IEEE 802.11b */
+#define WLAN_STATUS_ASSOC_DENIED_NOSHORT 19
+#define WLAN_STATUS_ASSOC_DENIED_NOPBCC 20
+#define WLAN_STATUS_ASSOC_DENIED_NOAGILITY 21
+/* IEEE 802.11h */
+#define WLAN_STATUS_SPEC_MGMT_REQUIRED 22
+#define WLAN_STATUS_PWR_CAPABILITY_NOT_VALID 23
+#define WLAN_STATUS_SUPPORTED_CHANNEL_NOT_VALID 24
+/* IEEE 802.11g */
+#define WLAN_STATUS_ASSOC_DENIED_NO_SHORT_SLOT_TIME 25
+#define WLAN_STATUS_ASSOC_DENIED_NO_ER_PBCC 26
+#define WLAN_STATUS_ASSOC_DENIED_NO_DSSS_OFDM 27
+/* IEEE 802.11w */
+#define WLAN_STATUS_ASSOC_REJECTED_TEMPORARILY 30
+#define WLAN_STATUS_ROBUST_MGMT_FRAME_POLICY_VIOLATION 31
+/* IEEE 802.11i */
+#define WLAN_STATUS_INVALID_IE 40
+#define WLAN_STATUS_GROUP_CIPHER_NOT_VALID 41
+#define WLAN_STATUS_PAIRWISE_CIPHER_NOT_VALID 42
+#define WLAN_STATUS_AKMP_NOT_VALID 43
+#define WLAN_STATUS_UNSUPPORTED_RSN_IE_VERSION 44
+#define WLAN_STATUS_INVALID_RSN_IE_CAPAB 45
+#define WLAN_STATUS_CIPHER_REJECTED_PER_POLICY 46
+#define WLAN_STATUS_TS_NOT_CREATED 47
+#define WLAN_STATUS_DIRECT_LINK_NOT_ALLOWED 48
+#define WLAN_STATUS_DEST_STA_NOT_PRESENT 49
+#define WLAN_STATUS_DEST_STA_NOT_QOS_STA 50
+#define WLAN_STATUS_ASSOC_DENIED_LISTEN_INT_TOO_LARGE 51
+/* IEEE 802.11r */
+#define WLAN_STATUS_INVALID_FT_ACTION_FRAME_COUNT 52
+#define WLAN_STATUS_INVALID_PMKID 53
+#define WLAN_STATUS_INVALID_MDIE 54
+#define WLAN_STATUS_INVALID_FTIE 55
+
+enum WIFI_REG_DOMAIN {
+	DOMAIN_FCC	= 1,
+	DOMAIN_IC	= 2,
+	DOMAIN_ETSI	= 3,
+	DOMAIN_SPA	= 4,
+	DOMAIN_FRANCE	= 5,
+	DOMAIN_MKK	= 6,
+	DOMAIN_ISRAEL	= 7,
+	DOMAIN_MKK1	= 8,
+	DOMAIN_MKK2	= 9,
+	DOMAIN_MKK3	= 10,
+	DOMAIN_MAX
+};
+
+#define _TO_DS_		BIT(8)
+#define _FROM_DS_	BIT(9)
+#define _MORE_FRAG_	BIT(10)
+#define _RETRY_		BIT(11)
+#define _PWRMGT_	BIT(12)
+#define _MORE_DATA_	BIT(13)
+#define _PRIVACY_	BIT(14)
+#define _ORDER_		BIT(15)
+
+#define SetToDs(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_TO_DS_)
+
+#define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) != 0)
+
+#define ClearToDs(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_TO_DS_))
+
+#define SetFrDs(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_FROM_DS_)
+
+#define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) != 0)
+
+#define ClearFrDs(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_FROM_DS_))
+
+#define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
+
+#define SetMFrag(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_FRAG_)
+
+#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) != 0)
+
+#define ClearMFrag(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_))
+
+#define SetRetry(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_RETRY_)
+
+#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
+
+#define ClearRetry(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_))
+
+#define SetPwrMgt(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_PWRMGT_)
+
+#define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) != 0)
+
+#define ClearPwrMgt(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PWRMGT_))
+
+#define SetMData(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_MORE_DATA_)
+
+#define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) != 0)
+
+#define ClearMData(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_DATA_))
+
+#define SetPrivacy(pbuf)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(_PRIVACY_)
+
+#define GetPrivacy(pbuf)					\
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) != 0)
+
+#define ClearPrivacy(pbuf)	\
+	*(__le16 *)(pbuf) &= (~cpu_to_le16(_PRIVACY_))
+
+#define GetOrder(pbuf)					\
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(_ORDER_)) != 0)
+
+#define GetFrameType(pbuf)				\
+	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
+
+#define SetFrameType(pbuf, type)	\
+	do {	\
+		*(unsigned short *)(pbuf) &= __constant_cpu_to_le16(~(BIT(3) | BIT(2))); \
+		*(unsigned short *)(pbuf) |= __constant_cpu_to_le16(type); \
+	} while (0)
+
+#define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
+	 BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2)))
+
+#define SetFrameSubType(pbuf, type) \
+	do {    \
+		*(__le16 *)(pbuf) &= cpu_to_le16(~(BIT(7) | BIT(6) |	\
+		 BIT(5) | BIT(4) | BIT(3) | BIT(2))); \
+		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
+	} while (0)
+
+#define GetSequence(pbuf)			\
+	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) >> 4)
+
+#define GetFragNum(pbuf)			\
+	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 22)) & 0x0f)
+
+#define GetTupleCache(pbuf)			\
+	(cpu_to_le16(*(unsigned short *)((size_t)(pbuf) + 22)))
+
+#define SetFragNum(pbuf, num) \
+	do {    \
+		*(unsigned short *)((size_t)(pbuf) + 22) = \
+			((*(unsigned short *)((size_t)(pbuf) + 22)) &	\
+			le16_to_cpu(~(0x000f))) | \
+			cpu_to_le16(0x0f & (num));     \
+	} while (0)
+
+#define SetSeqNum(pbuf, num) \
+	do {    \
+		*(__le16 *)((size_t)(pbuf) + 22) = \
+			((*(__le16 *)((size_t)(pbuf) + 22)) & cpu_to_le16((unsigned short)0x000f)) | \
+			cpu_to_le16((unsigned short)(0xfff0 & (num << 4))); \
+	} while (0)
+
+#define SetDuration(pbuf, dur) \
+	*(__le16 *)((size_t)(pbuf) + 2) = cpu_to_le16(0xffff & (dur))
+
+#define SetPriority(pbuf, tid)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf)
+
+#define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
+
+#define SetEOSP(pbuf, eosp)	\
+		*(__le16 *)(pbuf) |= cpu_to_le16((eosp & 1) << 4)
+
+#define SetAckpolicy(pbuf, ack)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5)
+
+#define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
+
+#define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
+
+#define SetAMsdu(pbuf, amsdu)	\
+	*(__le16 *)(pbuf) |= cpu_to_le16((amsdu & 1) << 7)
+
+#define GetAid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) + 2)) & 0x3fff)
+
+#define GetTid(pbuf)	(le16_to_cpu(*(__le16 *)((size_t)(pbuf) +	\
+			(((GetToDs(pbuf)<<1) | GetFrDs(pbuf)) == 3 ?	\
+			30 : 24))) & 0x000f)
+
+#define GetAddr1Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 4))
+
+#define GetAddr2Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 10))
+
+#define GetAddr3Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 16))
+
+#define GetAddr4Ptr(pbuf)	((unsigned char *)((size_t)(pbuf) + 24))
+
+#define MacAddr_isBcst(addr) \
+	( \
+	((addr[0] == 0xff) && (addr[1] == 0xff) && \
+	(addr[2] == 0xff) && (addr[3] == 0xff) && \
+	(addr[4] == 0xff) && (addr[5] == 0xff))  ? true : false \
+)
+
+static inline int IS_MCAST(unsigned char *da)
+{
+	if ((*da) & 0x01)
+		return true;
+	else
+		return false;
+}
+
+static inline unsigned char *get_da(unsigned char *pframe)
+{
+	unsigned char	*da;
+	unsigned int to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
+
+	switch (to_fr_ds) {
+	case 0x00:	/*  ToDs=0, FromDs=0 */
+		da = GetAddr1Ptr(pframe);
+		break;
+	case 0x01:	/*  ToDs=0, FromDs=1 */
+		da = GetAddr1Ptr(pframe);
+		break;
+	case 0x02:	/*  ToDs=1, FromDs=0 */
+		da = GetAddr3Ptr(pframe);
+		break;
+	default:	/*  ToDs=1, FromDs=1 */
+		da = GetAddr3Ptr(pframe);
+		break;
+	}
+	return da;
+}
+
+static inline unsigned char *get_sa(unsigned char *pframe)
+{
+	unsigned char	*sa;
+	unsigned int	to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
+
+	switch (to_fr_ds) {
+	case 0x00:	/*  ToDs=0, FromDs=0 */
+		sa = GetAddr2Ptr(pframe);
+		break;
+	case 0x01:	/*  ToDs=0, FromDs=1 */
+		sa = GetAddr3Ptr(pframe);
+		break;
+	case 0x02:	/*  ToDs=1, FromDs=0 */
+		sa = GetAddr2Ptr(pframe);
+		break;
+	default:	/*  ToDs=1, FromDs=1 */
+		sa = GetAddr4Ptr(pframe);
+		break;
+	}
+	return sa;
+}
+
+static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
+{
+	unsigned char	*sa;
+	unsigned int	to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
+
+	switch (to_fr_ds) {
+	case 0x00:	/*  ToDs=0, FromDs=0 */
+		sa = GetAddr3Ptr(pframe);
+		break;
+	case 0x01:	/*  ToDs=0, FromDs=1 */
+		sa = GetAddr2Ptr(pframe);
+		break;
+	case 0x02:	/*  ToDs=1, FromDs=0 */
+		sa = GetAddr1Ptr(pframe);
+		break;
+	case 0x03:	/*  ToDs=1, FromDs=1 */
+		sa = GetAddr1Ptr(pframe);
+		break;
+	default:
+		sa = NULL; /*  */
+		break;
+	}
+	return sa;
+}
+
+static inline int IsFrameTypeCtrl(unsigned char *pframe)
+{
+	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
+		return true;
+	else
+		return false;
+}
+/*-----------------------------------------------------------------------------
+			Below is for the security related definition
+------------------------------------------------------------------------------*/
+#define _RESERVED_FRAME_TYPE_		0
+#define _SKB_FRAME_TYPE_		2
+#define _PRE_ALLOCMEM_			1
+#define _PRE_ALLOCHDR_			3
+#define _PRE_ALLOCLLCHDR_		4
+#define _PRE_ALLOCICVHDR_		5
+#define _PRE_ALLOCMICHDR_		6
+
+#define _SIFSTIME_				\
+	((priv->pmib->dot11BssType.net_work_type & WIRELESS_11A) ? 16 : 10)
+#define _ACKCTSLNG_		14	/* 14 bytes long, including crclng */
+#define _CRCLNG_		4
+
+#define _ASOCREQ_IE_OFFSET_	4	/*  excluding wlan_hdr */
+#define	_ASOCRSP_IE_OFFSET_	6
+#define _REASOCREQ_IE_OFFSET_	10
+#define _REASOCRSP_IE_OFFSET_	6
+#define _PROBEREQ_IE_OFFSET_	0
+#define	_PROBERSP_IE_OFFSET_	12
+#define _AUTH_IE_OFFSET_	6
+#define _DEAUTH_IE_OFFSET_	0
+#define _BEACON_IE_OFFSET_	12
+#define _PUBLIC_ACTION_IE_OFFSET_	8
+
+#define _FIXED_IE_LENGTH_	_BEACON_IE_OFFSET_
+
+#define _SSID_IE_		0
+#define _SUPPORTEDRATES_IE_	1
+#define _DSSET_IE_		3
+#define _TIM_IE_		5
+#define _IBSS_PARA_IE_		6
+#define _COUNTRY_IE_		7
+#define _CHLGETXT_IE_		16
+#define _SUPPORTED_CH_IE_	36
+#define _CH_SWTICH_ANNOUNCE_	37	/* Secondary Channel Offset */
+#define _RSN_IE_2_		48
+#define _SSN_IE_1_		221
+#define _ERPINFO_IE_		42
+#define _EXT_SUPPORTEDRATES_IE_	50
+
+#define _HT_CAPABILITY_IE_	45
+#define _FTIE_			55
+#define _TIMEOUT_ITVL_IE_	56
+#define _SRC_IE_		59
+#define _HT_EXTRA_INFO_IE_	61
+#define _HT_ADD_INFO_IE_	61 /* _HT_EXTRA_INFO_IE_ */
+#define _WAPI_IE_		68
+
+#define	EID_BSSCoexistence	72 /*  20/40 BSS Coexistence */
+#define	EID_BSSIntolerantChlReport	73
+#define _RIC_Descriptor_IE_	75
+
+#define _LINK_ID_IE_		101
+#define _CH_SWITCH_TIMING_	104
+#define _PTI_BUFFER_STATUS_	106
+#define _EXT_CAP_IE_		127
+#define _VENDOR_SPECIFIC_IE_	221
+
+#define	_RESERVED47_		47
+
+/* ---------------------------------------------------------------------------
+					Below is the fixed elements...
+-----------------------------------------------------------------------------*/
+#define _AUTH_ALGM_NUM_		2
+#define _AUTH_SEQ_NUM_		2
+#define _BEACON_ITERVAL_	2
+#define _CAPABILITY_		2
+#define _CURRENT_APADDR_	6
+#define _LISTEN_INTERVAL_	2
+#define _RSON_CODE_		2
+#define _ASOC_ID_		2
+#define _STATUS_CODE_		2
+#define _TIMESTAMP_		8
+
+#define AUTH_ODD_TO		0
+#define AUTH_EVEN_TO		1
+
+#define WLAN_ETHCONV_ENCAP	1
+#define WLAN_ETHCONV_RFC1042	2
+#define WLAN_ETHCONV_8021h	3
+
+#define cap_ESS		BIT(0)
+#define cap_IBSS	BIT(1)
+#define cap_CFPollable	BIT(2)
+#define cap_CFRequest	BIT(3)
+#define cap_Privacy	BIT(4)
+#define cap_ShortPremble BIT(5)
+#define cap_PBCC	BIT(6)
+#define cap_ChAgility	BIT(7)
+#define cap_SpecMgmt	BIT(8)
+#define cap_QoSi	BIT(9)
+#define cap_ShortSlot	BIT(10)
+
+/*-----------------------------------------------------------------------------
+				Below is the definition for 802.11i / 802.1x
+------------------------------------------------------------------------------*/
+#define _IEEE8021X_MGT_			1	/*  WPA */
+#define _IEEE8021X_PSK_			2	/*  WPA with pre-shared key */
+
+/*
+#define _NO_PRIVACY_			0
+#define _WEP_40_PRIVACY_		1
+#define _TKIP_PRIVACY_			2
+#define _WRAP_PRIVACY_			3
+#define _CCMP_PRIVACY_			4
+#define _WEP_104_PRIVACY_		5
+#define _WEP_WPA_MIXED_PRIVACY_ 6	WEP + WPA
+*/
+
+/*-----------------------------------------------------------------------------
+				Below is the definition for WMM
+------------------------------------------------------------------------------*/
+#define _WMM_IE_Length_				7  /*  for WMM STA */
+#define _WMM_Para_Element_Length_		24
+
+/*-----------------------------------------------------------------------------
+				Below is the definition for 802.11n
+------------------------------------------------------------------------------*/
+
+#define SetOrderBit(pbuf)	\
+	do	{	\
+		*(unsigned short *)(pbuf) |= cpu_to_le16(_ORDER_); \
+	} while (0)
+
+#define GetOrderBit(pbuf)			\
+	(((*(unsigned short *)(pbuf)) & le16_to_cpu(_ORDER_)) != 0)
+
+/**
+ * struct rtw_ieee80211_bar - HT Block Ack Request
+ *
+ * This structure refers to "HT BlockAckReq" as
+ * described in 802.11n draft section 7.2.1.7.1
+ */
+struct rtw_ieee80211_bar {
+	__le16 frame_control;
+	__le16 duration;
+	unsigned char ra[ETH_ALEN];
+	unsigned char ta[ETH_ALEN];
+	__le16 control;
+	__le16 start_seq_num;
+} __packed;
+
+/* 802.11 BAR control masks */
+#define IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL     0x0000
+#define IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA  0x0004
+
+/**
+ * struct ieee80211_ht_cap - HT additional information
+ *
+ * This structure refers to "HT information element" as
+ * described in 802.11n draft section 7.3.2.53
+ */
+struct ieee80211_ht_addt_info {
+	unsigned char	control_chan;
+	unsigned char	ht_param;
+	__le16	operation_mode;
+	__le16	stbc_param;
+	unsigned char	basic_set[16];
+} __packed;
+
+struct HT_caps_element {
+	union {
+		struct {
+			__le16	HT_caps_info;
+			unsigned char	AMPDU_para;
+			unsigned char	MCS_rate[16];
+			__le16	HT_ext_caps;
+			__le16	Beamforming_caps;
+			unsigned char	ASEL_caps;
+		} HT_cap_element;
+		unsigned char HT_cap[26];
+	} u;
+} __packed;
+
+struct HT_info_element {
+	unsigned char	primary_channel;
+	unsigned char	infos[5];
+	unsigned char	MCS_rate[16];
+} __packed;
+
+struct AC_param {
+	unsigned char		ACI_AIFSN;
+	unsigned char		CW;
+	__le16	TXOP_limit;
+} __packed;
+
+struct WMM_para_element {
+	unsigned char		QoS_info;
+	unsigned char		reserved;
+	struct AC_param	ac_param[4];
+} __packed;
+
+struct ADDBA_request {
+	unsigned char	action_code;
+	unsigned char	dialog_token;
+	__le16	BA_para_set;
+	__le16	BA_timeout_value;
+	__le16	BA_starting_seqctrl;
+} __packed;
+
+enum ht_cap_ampdu_factor {
+	MAX_AMPDU_FACTOR_8K	= 0,
+	MAX_AMPDU_FACTOR_16K	= 1,
+	MAX_AMPDU_FACTOR_32K	= 2,
+	MAX_AMPDU_FACTOR_64K	= 3,
+};
+
+/* 802.11n HT capabilities masks */
+#define IEEE80211_HT_CAP_SUP_WIDTH		0x0002
+#define IEEE80211_HT_CAP_SM_PS			0x000C
+#define IEEE80211_HT_CAP_GRN_FLD		0x0010
+#define IEEE80211_HT_CAP_SGI_20			0x0020
+#define IEEE80211_HT_CAP_SGI_40			0x0040
+#define IEEE80211_HT_CAP_TX_STBC		0x0080
+#define IEEE80211_HT_CAP_RX_STBC		0x0300
+#define IEEE80211_HT_CAP_DELAY_BA		0x0400
+#define IEEE80211_HT_CAP_MAX_AMSDU		0x0800
+#define IEEE80211_HT_CAP_DSSSCCK40		0x1000
+/* 802.11n HT capability AMPDU settings */
+#define IEEE80211_HT_CAP_AMPDU_FACTOR		0x03
+#define IEEE80211_HT_CAP_AMPDU_DENSITY		0x1C
+/* 802.11n HT capability MSC set */
+#define IEEE80211_SUPP_MCS_SET_UEQM		4
+#define IEEE80211_HT_CAP_MAX_STREAMS		4
+#define IEEE80211_SUPP_MCS_SET_LEN		10
+/* maximum streams the spec allows */
+#define IEEE80211_HT_CAP_MCS_TX_DEFINED		0x01
+#define IEEE80211_HT_CAP_MCS_TX_RX_DIFF		0x02
+#define IEEE80211_HT_CAP_MCS_TX_STREAMS		0x0C
+#define IEEE80211_HT_CAP_MCS_TX_UEQM		0x10
+/* 802.11n HT IE masks */
+#define IEEE80211_HT_IE_CHA_SEC_OFFSET		0x03
+#define IEEE80211_HT_IE_CHA_SEC_NONE		0x00
+#define IEEE80211_HT_IE_CHA_SEC_ABOVE		0x01
+#define IEEE80211_HT_IE_CHA_SEC_BELOW		0x03
+#define IEEE80211_HT_IE_CHA_WIDTH		0x04
+#define IEEE80211_HT_IE_HT_PROTECTION		0x0003
+#define IEEE80211_HT_IE_NON_GF_STA_PRSNT	0x0004
+#define IEEE80211_HT_IE_NON_HT_STA_PRSNT	0x0010
+
+/* block-ack parameters */
+#define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
+#define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
+#define RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
+#define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
+#define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
+
+/*
+ * A-PMDU buffer sizes
+ * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
+ */
+#define IEEE80211_MIN_AMPDU_BUF 0x8
+#if (LINUX_VERSION_CODE < KERNEL_VERSION(4,19,0))
+#define IEEE80211_MAX_AMPDU_BUF 0x40
+#endif
+
+/* Spatial Multiplexing Power Save Modes */
+#define WLAN_HT_CAP_SM_PS_STATIC	0
+#define WLAN_HT_CAP_SM_PS_DYNAMIC	1
+#define WLAN_HT_CAP_SM_PS_INVALID	2
+#define WLAN_HT_CAP_SM_PS_DISABLED	3
+
+#define OP_MODE_PURE                    0
+#define OP_MODE_MAY_BE_LEGACY_STAS      1
+#define OP_MODE_20MHZ_HT_STA_ASSOCED    2
+#define OP_MODE_MIXED                   3
+
+#define HT_INFO_HT_PARAM_SECONDARY_CHNL_OFF_MASK	((u8) BIT(0) | BIT(1))
+#define HT_INFO_HT_PARAM_SECONDARY_CHNL_ABOVE		((u8) BIT(0))
+#define HT_INFO_HT_PARAM_SECONDARY_CHNL_BELOW		((u8) BIT(0) | BIT(1))
+#define HT_INFO_HT_PARAM_REC_TRANS_CHNL_WIDTH		((u8) BIT(2))
+#define HT_INFO_HT_PARAM_RIFS_MODE			((u8) BIT(3))
+#define HT_INFO_HT_PARAM_CTRL_ACCESS_ONLY		((u8) BIT(4))
+#define HT_INFO_HT_PARAM_SRV_INTERVAL_GRANULARITY	((u8) BIT(5))
+
+#define HT_INFO_OPERATION_MODE_OP_MODE_MASK	\
+		((u16) (0x0001 | 0x0002))
+#define HT_INFO_OPERATION_MODE_OP_MODE_OFFSET		0
+#define HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT	((u8) BIT(2))
+#define HT_INFO_OPERATION_MODE_TRANSMIT_BURST_LIMIT	((u8) BIT(3))
+#define HT_INFO_OPERATION_MODE_NON_HT_STA_PRESENT	((u8) BIT(4))
+
+#define HT_INFO_STBC_PARAM_DUAL_BEACON		((u16) BIT(6))
+#define HT_INFO_STBC_PARAM_DUAL_STBC_PROTECT	((u16) BIT(7))
+#define HT_INFO_STBC_PARAM_SECONDARY_BC		((u16) BIT(8))
+#define HT_INFO_STBC_PARAM_LSIG_TXOP_PROTECT_ALLOWED	((u16) BIT(9))
+#define HT_INFO_STBC_PARAM_PCO_ACTIVE		((u16) BIT(10))
+#define HT_INFO_STBC_PARAM_PCO_PHASE		((u16) BIT(11))
+
+/*	===============WPS Section=============== */
+/*	For WPSv1.0 */
+#define WPSOUI					0x0050f204
+/*	WPS attribute ID */
+#define WPS_ATTR_VER1				0x104A
+#define WPS_ATTR_SIMPLE_CONF_STATE		0x1044
+#define WPS_ATTR_RESP_TYPE			0x103B
+#define WPS_ATTR_UUID_E				0x1047
+#define WPS_ATTR_MANUFACTURER			0x1021
+#define WPS_ATTR_MODEL_NAME			0x1023
+#define WPS_ATTR_MODEL_NUMBER			0x1024
+#define WPS_ATTR_SERIAL_NUMBER			0x1042
+#define WPS_ATTR_PRIMARY_DEV_TYPE		0x1054
+#define WPS_ATTR_SEC_DEV_TYPE_LIST		0x1055
+#define WPS_ATTR_DEVICE_NAME			0x1011
+#define WPS_ATTR_CONF_METHOD			0x1008
+#define WPS_ATTR_RF_BANDS			0x103C
+#define WPS_ATTR_DEVICE_PWID			0x1012
+#define WPS_ATTR_REQUEST_TYPE			0x103A
+#define WPS_ATTR_ASSOCIATION_STATE		0x1002
+#define WPS_ATTR_CONFIG_ERROR			0x1009
+#define WPS_ATTR_VENDOR_EXT			0x1049
+#define WPS_ATTR_SELECTED_REGISTRAR		0x1041
+
+/*	Value of WPS attribute "WPS_ATTR_DEVICE_NAME */
+#define WPS_MAX_DEVICE_NAME_LEN			32
+
+/*	Value of WPS Request Type Attribute */
+#define WPS_REQ_TYPE_ENROLLEE_INFO_ONLY		0x00
+#define WPS_REQ_TYPE_ENROLLEE_OPEN_8021X	0x01
+#define WPS_REQ_TYPE_REGISTRAR			0x02
+#define WPS_REQ_TYPE_WLAN_MANAGER_REGISTRAR	0x03
+
+/*	Value of WPS Response Type Attribute */
+#define WPS_RESPONSE_TYPE_INFO_ONLY	0x00
+#define WPS_RESPONSE_TYPE_8021X		0x01
+#define WPS_RESPONSE_TYPE_REGISTRAR	0x02
+#define WPS_RESPONSE_TYPE_AP		0x03
+
+/*	Value of WPS WiFi Simple Configuration State Attribute */
+#define WPS_WSC_STATE_NOT_CONFIG	0x01
+#define WPS_WSC_STATE_CONFIG		0x02
+
+/*	Value of WPS Version Attribute */
+#define WPS_VERSION_1			0x10
+
+/*	Value of WPS Configuration Method Attribute */
+#define WPS_CONFIG_METHOD_FLASH		0x0001
+#define WPS_CONFIG_METHOD_ETHERNET	0x0002
+#define WPS_CONFIG_METHOD_LABEL		0x0004
+#define WPS_CONFIG_METHOD_DISPLAY	0x0008
+#define WPS_CONFIG_METHOD_E_NFC		0x0010
+#define WPS_CONFIG_METHOD_I_NFC		0x0020
+#define WPS_CONFIG_METHOD_NFC		0x0040
+#define WPS_CONFIG_METHOD_PBC		0x0080
+#define WPS_CONFIG_METHOD_KEYPAD	0x0100
+#define WPS_CONFIG_METHOD_VPBC		0x0280
+#define WPS_CONFIG_METHOD_PPBC		0x0480
+#define WPS_CONFIG_METHOD_VDISPLAY	0x2008
+#define WPS_CONFIG_METHOD_PDISPLAY	0x4008
+
+/*	Value of Category ID of WPS Primary Device Type Attribute */
+#define WPS_PDT_CID_DISPLAYS		0x0007
+#define WPS_PDT_CID_MULIT_MEDIA		0x0008
+#define WPS_PDT_CID_RTK_WIDI		WPS_PDT_CID_MULIT_MEDIA
+
+/*	Value of Sub Category ID of WPS Primary Device Type Attribute */
+#define WPS_PDT_SCID_MEDIA_SERVER	0x0005
+#define WPS_PDT_SCID_RTK_DMP		WPS_PDT_SCID_MEDIA_SERVER
+
+/*	Value of Device Password ID */
+#define WPS_DPID_P			0x0000
+#define WPS_DPID_USER_SPEC		0x0001
+#define WPS_DPID_MACHINE_SPEC		0x0002
+#define WPS_DPID_REKEY			0x0003
+#define WPS_DPID_PBC			0x0004
+#define WPS_DPID_REGISTRAR_SPEC		0x0005
+
+/*	Value of WPS RF Bands Attribute */
+#define WPS_RF_BANDS_2_4_GHZ		0x01
+#define WPS_RF_BANDS_5_GHZ		0x02
+
+/*	Value of WPS Association State Attribute */
+#define WPS_ASSOC_STATE_NOT_ASSOCIATED		0x00
+#define WPS_ASSOC_STATE_CONNECTION_SUCCESS	0x01
+#define WPS_ASSOC_STATE_CONFIGURATION_FAILURE	0x02
+#define WPS_ASSOC_STATE_ASSOCIATION_FAILURE	0x03
+#define WPS_ASSOC_STATE_IP_FAILURE		0x04
+
+/*	=====================P2P Section===================== */
+/*	For P2P */
+#define	P2POUI					0x506F9A09
+
+/*	P2P Attribute ID */
+#define	P2P_ATTR_STATUS				0x00
+#define	P2P_ATTR_MINOR_REASON_CODE		0x01
+#define	P2P_ATTR_CAPABILITY			0x02
+#define	P2P_ATTR_DEVICE_ID			0x03
+#define	P2P_ATTR_GO_INTENT			0x04
+#define	P2P_ATTR_CONF_TIMEOUT			0x05
+#define	P2P_ATTR_LISTEN_CH			0x06
+#define	P2P_ATTR_GROUP_BSSID			0x07
+#define	P2P_ATTR_EX_LISTEN_TIMING		0x08
+#define	P2P_ATTR_INTENTED_IF_ADDR		0x09
+#define	P2P_ATTR_MANAGEABILITY			0x0A
+#define	P2P_ATTR_CH_LIST			0x0B
+#define	P2P_ATTR_NOA				0x0C
+#define	P2P_ATTR_DEVICE_INFO			0x0D
+#define	P2P_ATTR_GROUP_INFO			0x0E
+#define	P2P_ATTR_GROUP_ID			0x0F
+#define	P2P_ATTR_INTERFACE			0x10
+#define	P2P_ATTR_OPERATING_CH			0x11
+#define	P2P_ATTR_INVITATION_FLAGS		0x12
+
+/*	Value of Status Attribute */
+#define	P2P_STATUS_SUCCESS				0x00
+#define	P2P_STATUS_FAIL_INFO_UNAVAILABLE		0x01
+#define	P2P_STATUS_FAIL_INCOMPATIBLE_PARAM		0x02
+#define	P2P_STATUS_FAIL_LIMIT_REACHED			0x03
+#define	P2P_STATUS_FAIL_INVALID_PARAM			0x04
+#define	P2P_STATUS_FAIL_REQUEST_UNABLE			0x05
+#define	P2P_STATUS_FAIL_PREVOUS_PROTO_ERR		0x06
+#define	P2P_STATUS_FAIL_NO_COMMON_CH			0x07
+#define	P2P_STATUS_FAIL_UNKNOWN_P2PGROUP		0x08
+#define	P2P_STATUS_FAIL_BOTH_GOINTENT_15		0x09
+#define	P2P_STATUS_FAIL_INCOMPATIBLE_PROVSION		0x0A
+#define	P2P_STATUS_FAIL_USER_REJECT			0x0B
+
+/*	Value of Inviation Flags Attribute */
+#define	P2P_INVITATION_FLAGS_PERSISTENT			BIT(0)
+
+#define	DMP_P2P_DEVCAP_SUPPORT	(P2P_DEVCAP_SERVICE_DISCOVERY | \
+				P2P_DEVCAP_CLIENT_DISCOVERABILITY | \
+				P2P_DEVCAP_CONCURRENT_OPERATION | \
+				P2P_DEVCAP_INVITATION_PROC)
+
+#define	DMP_P2P_GRPCAP_SUPPORT	(P2P_GRPCAP_INTRABSS)
+
+/*	Value of Device Capability Bitmap */
+#define	P2P_DEVCAP_SERVICE_DISCOVERY		BIT(0)
+#define	P2P_DEVCAP_CLIENT_DISCOVERABILITY	BIT(1)
+#define	P2P_DEVCAP_CONCURRENT_OPERATION		BIT(2)
+#define	P2P_DEVCAP_INFRA_MANAGED		BIT(3)
+#define	P2P_DEVCAP_DEVICE_LIMIT			BIT(4)
+#define	P2P_DEVCAP_INVITATION_PROC		BIT(5)
+
+/*	Value of Group Capability Bitmap */
+#define	P2P_GRPCAP_GO				BIT(0)
+#define	P2P_GRPCAP_PERSISTENT_GROUP		BIT(1)
+#define	P2P_GRPCAP_GROUP_LIMIT			BIT(2)
+#define	P2P_GRPCAP_INTRABSS			BIT(3)
+#define	P2P_GRPCAP_CROSS_CONN			BIT(4)
+#define	P2P_GRPCAP_PERSISTENT_RECONN		BIT(5)
+#define	P2P_GRPCAP_GROUP_FORMATION		BIT(6)
+
+/*	P2P Public Action Frame (Management Frame) */
+#define	P2P_PUB_ACTION_ACTION			0x09
+
+/*	P2P Public Action Frame Type */
+#define	P2P_GO_NEGO_REQ				0
+#define	P2P_GO_NEGO_RESP			1
+#define	P2P_GO_NEGO_CONF			2
+#define	P2P_INVIT_REQ				3
+#define	P2P_INVIT_RESP				4
+#define	P2P_DEVDISC_REQ				5
+#define	P2P_DEVDISC_RESP			6
+#define	P2P_PROVISION_DISC_REQ			7
+#define	P2P_PROVISION_DISC_RESP			8
+
+/*	P2P Action Frame Type */
+#define	P2P_NOTICE_OF_ABSENCE			0
+#define	P2P_PRESENCE_REQUEST			1
+#define	P2P_PRESENCE_RESPONSE			2
+#define	P2P_GO_DISC_REQUEST			3
+
+#define	P2P_MAX_PERSISTENT_GROUP_NUM		10
+
+#define	P2P_PROVISIONING_SCAN_CNT		3
+
+#define	P2P_WILDCARD_SSID_LEN			7
+
+/* default value, used when: (1)p2p disabed or (2)p2p enabled
+ * but only do 1 scan phase */
+#define	P2P_FINDPHASE_EX_NONE		0
+/*  used when p2p enabled and want to do 1 scan phase and
+ *  P2P_FINDPHASE_EX_MAX-1 find phase */
+#define	P2P_FINDPHASE_EX_FULL		1
+#define	P2P_FINDPHASE_EX_SOCIAL_FIRST	(P2P_FINDPHASE_EX_FULL+1)
+#define	P2P_FINDPHASE_EX_MAX		4
+#define	P2P_FINDPHASE_EX_SOCIAL_LAST	P2P_FINDPHASE_EX_MAX
+
+/* 5 seconds timeout for sending the provision discovery request */
+#define	P2P_PROVISION_TIMEOUT		5000
+/* 3 seconds timeout for sending the prov disc request concurrent mode */
+#define	P2P_CONCURRENT_PROVISION_TIME	3000
+/* 5 seconds timeout for receiving the group negotiation response */
+#define	P2P_GO_NEGO_TIMEOUT		5000
+/* 3 seconds timeout for sending the negotiation request under concurrent mode */
+#define	P2P_CONCURRENT_GO_NEGO_TIME	3000
+/* 100ms */
+#define	P2P_TX_PRESCAN_TIMEOUT		100
+/* 5 seconds timeout for sending the invitation request */
+#define	P2P_INVITE_TIMEOUT		5000
+/* 3 seconds timeout for sending the invitation request under concurrent mode */
+#define	P2P_CONCURRENT_INVITE_TIME	3000
+/* 25 seconds timeout to reset the scan channel (based on channel plan) */
+#define	P2P_RESET_SCAN_CH		25000
+#define	P2P_MAX_INTENT			15
+
+#define	P2P_MAX_NOA_NUM			2
+
+/*	WPS Configuration Method */
+#define	WPS_CM_NONE			0x0000
+#define	WPS_CM_LABEL			0x0004
+#define	WPS_CM_DISPLYA			0x0008
+#define	WPS_CM_EXTERNAL_NFC_TOKEN	0x0010
+#define	WPS_CM_INTEGRATED_NFC_TOKEN	0x0020
+#define	WPS_CM_NFC_INTERFACE		0x0040
+#define	WPS_CM_PUSH_BUTTON		0x0080
+#define	WPS_CM_KEYPAD			0x0100
+#define	WPS_CM_SW_PUHS_BUTTON		0x0280
+#define	WPS_CM_HW_PUHS_BUTTON		0x0480
+#define	WPS_CM_SW_DISPLAY_P		0x2008
+#define	WPS_CM_LCD_DISPLAY_P		0x4008
+
+enum P2P_ROLE {
+	P2P_ROLE_DISABLE = 0,
+	P2P_ROLE_DEVICE = 1,
+	P2P_ROLE_CLIENT = 2,
+	P2P_ROLE_GO = 3
+};
+
+enum P2P_STATE {
+	P2P_STATE_NONE = 0,			/* P2P disable */
+	/* P2P had enabled and do nothing */
+	P2P_STATE_IDLE = 1,
+	P2P_STATE_LISTEN = 2,			/* In pure listen state */
+	P2P_STATE_SCAN = 3,			/* In scan phase */
+	/* In the listen state of find phase */
+	P2P_STATE_FIND_PHASE_LISTEN = 4,
+	/* In the search state of find phase */
+	P2P_STATE_FIND_PHASE_SEARCH = 5,
+	/* In P2P provisioning discovery */
+	P2P_STATE_TX_PROVISION_DIS_REQ = 6,
+	P2P_STATE_RX_PROVISION_DIS_RSP = 7,
+	P2P_STATE_RX_PROVISION_DIS_REQ = 8,
+	/* Doing the group owner negoitation handshake */
+	P2P_STATE_GONEGO_ING = 9,
+	/* finish the group negoitation handshake with success */
+	P2P_STATE_GONEGO_OK = 10,
+	/* finish the group negoitation handshake with failure */
+	P2P_STATE_GONEGO_FAIL = 11,
+	/* receiving the P2P Inviation request and match with the profile. */
+	P2P_STATE_RECV_INVITE_REQ_MATCH = 12,
+	/* Doing the P2P WPS */
+	P2P_STATE_PROVISIONING_ING = 13,
+	/* Finish the P2P WPS */
+	P2P_STATE_PROVISIONING_DONE = 14,
+	/* Transmit the P2P Invitation request */
+	P2P_STATE_TX_INVITE_REQ = 15,
+	/* Receiving the P2P Invitation response */
+	P2P_STATE_RX_INVITE_RESP_OK = 16,
+	/* receiving the P2P Inviation request and dismatch with the profile. */
+	P2P_STATE_RECV_INVITE_REQ_DISMATCH = 17,
+	/* receiving the P2P Inviation request and this wifi is GO. */
+	P2P_STATE_RECV_INVITE_REQ_GO = 18,
+	/* receiving the P2P Inviation request to join an existing P2P Group. */
+	P2P_STATE_RECV_INVITE_REQ_JOIN = 19,
+	/* recveing the P2P Inviation response with failure */
+	P2P_STATE_RX_INVITE_RESP_FAIL = 20,
+	/* receiving p2p negoitation response with information is not available */
+	P2P_STATE_RX_INFOR_NOREADY = 21,
+	/* sending p2p negoitation response with information is not available */
+	P2P_STATE_TX_INFOR_NOREADY = 22,
+};
+
+enum P2P_WPSINFO {
+	P2P_NO_WPSINFO				= 0,
+	P2P_GOT_WPSINFO_PEER_DISPLAY_PIN	= 1,
+	P2P_GOT_WPSINFO_SELF_DISPLAY_PIN	= 2,
+	P2P_GOT_WPSINFO_PBC			= 3,
+};
+
+#define	P2P_PRIVATE_IOCTL_SET_LEN		64
+
+enum P2P_PROTO_WK_ID {
+	P2P_FIND_PHASE_WK = 0,
+	P2P_RESTORE_STATE_WK = 1,
+	P2P_PRE_TX_PROVDISC_PROCESS_WK = 2,
+	P2P_PRE_TX_NEGOREQ_PROCESS_WK = 3,
+	P2P_PRE_TX_INVITEREQ_PROCESS_WK = 4,
+	P2P_AP_P2P_CH_SWITCH_PROCESS_WK =5,
+	P2P_RO_CH_WK = 6,
+};
+
+enum P2P_PS_STATE {
+	P2P_PS_DISABLE = 0,
+	P2P_PS_ENABLE = 1,
+	P2P_PS_SCAN = 2,
+	P2P_PS_SCAN_DONE = 3,
+	P2P_PS_ALLSTASLEEP = 4, /*  for P2P GO */
+};
+
+enum P2P_PS_MODE {
+	P2P_PS_NONE = 0,
+	P2P_PS_CTWINDOW = 1,
+	P2P_PS_NOA	 = 2,
+	P2P_PS_MIX = 3, /*  CTWindow and NoA */
+};
+
+/*	=====================WFD Section===================== */
+/*	For Wi-Fi Display */
+#define	WFD_ATTR_DEVICE_INFO		0x00
+#define	WFD_ATTR_ASSOC_BSSID		0x01
+#define	WFD_ATTR_COUPLED_SINK_INFO	0x06
+#define	WFD_ATTR_LOCAL_IP_ADDR		0x08
+#define	WFD_ATTR_SESSION_INFO		0x09
+#define	WFD_ATTR_ALTER_MAC		0x0a
+
+/*	For WFD Device Information Attribute */
+#define	WFD_DEVINFO_SOURCE			0x0000
+#define	WFD_DEVINFO_PSINK			0x0001
+#define	WFD_DEVINFO_SSINK			0x0002
+#define	WFD_DEVINFO_DUAL			0x0003
+
+#define	WFD_DEVINFO_SESSION_AVAIL		0x0010
+#define	WFD_DEVINFO_WSD				0x0040
+#define	WFD_DEVINFO_PC_TDLS			0x0080
+#define	WFD_DEVINFO_HDCP_SUPPORT		0x0100
+
+#define IP_MCAST_MAC(mac)				\
+	((mac[0] == 0x01) && (mac[1] == 0x00) && (mac[2] == 0x5e))
+#define ICMPV6_MCAST_MAC(mac)				\
+	((mac[0] == 0x33) && (mac[1] == 0x33) && (mac[2] != 0xff))
+
+#endif /*  _WIFI_H_ */
diff --git a/drivers/staging/r8188eu/include/wlan_bssdef.h b/drivers/staging/r8188eu/include/wlan_bssdef.h
new file mode 100644
index 000000000000..eae8bac175b2
--- /dev/null
+++ b/drivers/staging/r8188eu/include/wlan_bssdef.h
@@ -0,0 +1,343 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __WLAN_BSSDEF_H__
+#define __WLAN_BSSDEF_H__
+
+#define MAX_IE_SZ			768
+
+#define NDIS_802_11_LENGTH_SSID         32
+#define NDIS_802_11_LENGTH_RATES        8
+#define NDIS_802_11_LENGTH_RATES_EX     16
+
+#define NDIS_802_11_RSSI long           /*  in dBm */
+
+struct ndis_802_11_ssid {
+	u32  SsidLength;
+	u8  Ssid[32];
+};
+
+enum NDIS_802_11_NETWORK_TYPE {
+	Ndis802_11FH,
+	Ndis802_11DS,
+	Ndis802_11OFDM5,
+	Ndis802_11OFDM24,
+	Ndis802_11NetworkTypeMax    /*  dummy upper bound */
+};
+
+struct ndis_802_11_config_fh {
+	u32           Length;		/*  Length of structure */
+	u32           HopPattern;	/*  As defined by 802.11, MSB set */
+	u32           HopSet;		/*  to one if non-802.11 */
+	u32           DwellTime;	/*  units are Kusec */
+};
+
+/*
+ *	FW will only save the channel number in DSConfig.
+ *	ODI Handler will convert the channel number to freq. number.
+ */
+struct ndis_802_11_config {
+	u32           Length;             /*  Length of structure */
+	u32           BeaconPeriod;       /*  units are Kusec */
+	u32           ATIMWindow;         /*  units are Kusec */
+	u32           DSConfig;           /*  Frequency, units are kHz */
+	struct ndis_802_11_config_fh    FHConfig;
+};
+
+enum ndis_802_11_network_infra {
+	Ndis802_11IBSS,
+	Ndis802_11Infrastructure,
+	Ndis802_11AutoUnknown,
+	Ndis802_11InfrastructureMax,     /*  dummy upper bound */
+	Ndis802_11APMode
+};
+
+struct ndis_802_11_fixed_ie {
+	u8  Timestamp[8];
+	u16  BeaconInterval;
+	u16  Capabilities;
+};
+
+struct ndis_802_11_var_ie {
+	u8  ElementID;
+	u8  Length;
+	u8  data[1];
+};
+
+/*
+ * Length is the 4 bytes multiples of the sume of
+ *	[ETH_ALEN] + 2 + sizeof (struct ndis_802_11_ssid) + sizeof (u32)
+ *	+ sizeof (NDIS_802_11_RSSI) + sizeof (enum NDIS_802_11_NETWORK_TYPE)
+ *	+ sizeof (struct ndis_802_11_config)
+ *	+ NDIS_802_11_LENGTH_RATES_EX + IELength
+ *
+ * Except the IELength, all other fields are fixed length.
+ * Therefore, we can define a macro to represent the partial sum. */
+
+enum ndis_802_11_auth_mode {
+	Ndis802_11AuthModeOpen,
+	Ndis802_11AuthModeShared,
+	Ndis802_11AuthModeAutoSwitch,
+	Ndis802_11AuthModeWPA,
+	Ndis802_11AuthModeWPAPSK,
+	Ndis802_11AuthModeWPANone,
+	Ndis802_11AuthModeWAPI,
+	Ndis802_11AuthModeMax	/*  Not a real mode, upper bound */
+};
+
+enum ndis_802_11_wep_status {
+	Ndis802_11WEPEnabled,
+	Ndis802_11Encryption1Enabled = Ndis802_11WEPEnabled,
+	Ndis802_11WEPDisabled,
+	Ndis802_11EncryptionDisabled = Ndis802_11WEPDisabled,
+	Ndis802_11WEPKeyAbsent,
+	Ndis802_11Encryption1KeyAbsent = Ndis802_11WEPKeyAbsent,
+	Ndis802_11WEPNotSupported,
+	Ndis802_11EncryptionNotSupported = Ndis802_11WEPNotSupported,
+	Ndis802_11Encryption2Enabled,
+	Ndis802_11Encryption2KeyAbsent,
+	Ndis802_11Encryption3Enabled,
+	Ndis802_11Encryption3KeyAbsent,
+	Ndis802_11_EncryptionWAPI
+};
+
+#define NDIS_802_11_AI_REQFI_CAPABILITIES      1
+#define NDIS_802_11_AI_REQFI_LISTENINTERVAL    2
+#define NDIS_802_11_AI_REQFI_CURRENTAPADDRESS  4
+
+#define NDIS_802_11_AI_RESFI_CAPABILITIES      1
+#define NDIS_802_11_AI_RESFI_STATUSCODE        2
+#define NDIS_802_11_AI_RESFI_ASSOCIATIONID     4
+
+struct ndis_802_11_ai_reqfi {
+    u16 Capabilities;
+    u16 ListenInterval;
+    unsigned char CurrentAPAddress[ETH_ALEN];
+};
+
+struct ndis_802_11_ai_resfi {
+    u16 Capabilities;
+    u16 StatusCode;
+    u16 AssociationId;
+};
+
+struct ndis_802_11_assoc_info {
+	u32  Length;
+	u16 AvailableRequestFixedIEs;
+	struct ndis_802_11_ai_reqfi    RequestFixedIEs;
+	u32  RequestIELength;
+	u32  OffsetRequestIEs;
+	u16 AvailableResponseFixedIEs;
+	struct ndis_802_11_ai_resfi    ResponseFixedIEs;
+	u32  ResponseIELength;
+	u32  OffsetResponseIEs;
+};
+
+enum ndis_802_11_reload_def {
+	Ndis802_11ReloadWEPKeys
+};
+
+/*  Key mapping keys require a BSSID */
+struct ndis_802_11_key {
+	u32           Length;             /*  Length of this structure */
+	u32           KeyIndex;
+	u32           KeyLength;          /*  length of key in bytes */
+	unsigned char BSSID[ETH_ALEN];
+	unsigned long long KeyRSC;
+	u8           KeyMaterial[32];  /* var len depending on above field */
+};
+
+struct ndis_802_11_remove_key {
+	u32                   Length;        /*  Length */
+	u32                   KeyIndex;
+	unsigned char BSSID[ETH_ALEN];
+};
+
+struct ndis_802_11_wep {
+	u32     Length;        /*  Length of this structure */
+	u32     KeyIndex;      /*  0 is the per-client key,
+				  * 1-N are the global keys */
+	u32     KeyLength;     /*  length of key in bytes */
+	u8     KeyMaterial[16];/*  variable len depending on above field */
+};
+
+struct ndis_802_11_auth_req {
+	u32 Length;            /*  Length of structure */
+	unsigned char Bssid[ETH_ALEN];
+	u32 Flags;
+};
+
+enum ndis_802_11_status_type {
+	Ndis802_11StatusType_Authentication,
+	Ndis802_11StatusType_MediaStreamMode,
+	Ndis802_11StatusType_PMKID_CandidateList,
+	Ndis802_11StatusTypeMax    /*  not a real type, defined as
+				    * an upper bound */
+};
+
+struct ndis_802_11_status_ind {
+	enum ndis_802_11_status_type StatusType;
+};
+
+/*  mask for authentication/integrity fields */
+#define NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS        	0x0f
+#define NDIS_802_11_AUTH_REQUEST_REAUTH			0x01
+#define NDIS_802_11_AUTH_REQUEST_KEYUPDATE		0x02
+#define NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR		0x06
+#define NDIS_802_11_AUTH_REQUEST_GROUP_ERROR		0x0E
+
+/*  MIC check time, 60 seconds. */
+#define MIC_CHECK_TIME	60000000
+
+struct ndis_802_11_auth_evt {
+	struct ndis_802_11_status_ind       Status;
+	struct ndis_802_11_auth_req  Request[1];
+};
+
+struct ndis_802_11_test {
+	u32 Length;
+	u32 Type;
+	union {
+		struct ndis_802_11_auth_evt AuthenticationEvent;
+		NDIS_802_11_RSSI RssiTrigger;
+	} tt;
+};
+
+#ifndef Ndis802_11APMode
+#define Ndis802_11APMode (Ndis802_11InfrastructureMax+1)
+#endif
+
+struct wlan_phy_info {
+	u8	SignalStrength;/* in percentage) */
+	u8	SignalQuality;/* in percentage) */
+	u8	Optimum_antenna;  /* for Antenna diversity */
+	u8	Reserved_0;
+};
+
+struct wlan_bcn_info {
+	/* these infor get from rtw_get_encrypt_info when
+	 *	 * translate scan to UI */
+	u8 encryp_protocol;/* ENCRYP_PROTOCOL_E: OPEN/WEP/WPA/WPA2/WAPI */
+	int group_cipher; /* WPA/WPA2 group cipher */
+	int pairwise_cipher;/* WPA/WPA2/WEP pairwise cipher */
+	int is_8021x;
+
+	/* bwmode 20/40 and ch_offset UP/LOW */
+	unsigned short	ht_cap_info;
+	unsigned char	ht_info_infos_0;
+};
+
+/* temporally add #pragma pack for structure alignment issue of
+*   struct wlan_bssid_ex and get_struct wlan_bssid_ex_sz()
+*/
+struct wlan_bssid_ex {
+	u32  Length;
+	unsigned char MacAddress[ETH_ALEN];
+	u8  Reserved[2];/* 0]: IS beacon frame */
+	struct ndis_802_11_ssid  Ssid;
+	u32  Privacy;
+	NDIS_802_11_RSSI  Rssi;/* in dBM,raw data ,get from PHY) */
+	enum  NDIS_802_11_NETWORK_TYPE  NetworkTypeInUse;
+	struct ndis_802_11_config  Configuration;
+	enum ndis_802_11_network_infra  InfrastructureMode;
+	unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
+	struct wlan_phy_info	PhyInfo;
+	u32  IELength;
+	u8  IEs[MAX_IE_SZ];	/* timestamp, beacon interval, and
+				 * capability information) */
+} __packed;
+
+static inline uint get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
+{
+	return sizeof(struct wlan_bssid_ex) - MAX_IE_SZ + bss->IELength;
+}
+
+struct	wlan_network {
+	struct list_head list;
+	int	network_type;	/* refer to ieee80211.h for WIRELESS_11A/B/G */
+	int	fixed;		/*  set fixed when not to be removed
+				 *  in site-surveying */
+	unsigned long	last_scanned; /* timestamp for the network */
+	int	aid;		/* will only be valid when a BSS is joinned. */
+	int	join_res;
+	struct wlan_bssid_ex	network; /* must be the last item */
+	struct wlan_bcn_info	BcnInfo;
+};
+
+enum VRTL_CARRIER_SENSE {
+	DISABLE_VCS,
+	ENABLE_VCS,
+	AUTO_VCS
+};
+
+enum VCS_TYPE {
+	NONE_VCS,
+	RTS_CTS,
+	CTS_TO_SELF
+};
+
+#define PWR_CAM 0
+#define PWR_MINPS 1
+#define PWR_MAXPS 2
+#define PWR_UAPSD 3
+#define PWR_VOIP 4
+
+enum UAPSD_MAX_SP {
+	NO_LIMIT,
+	TWO_MSDU,
+	FOUR_MSDU,
+	SIX_MSDU
+};
+
+#define NUM_PRE_AUTH_KEY 16
+#define NUM_PMKID_CACHE NUM_PRE_AUTH_KEY
+
+/*
+*	WPA2
+*/
+
+struct pmkid_candidate {
+	unsigned char BSSID[ETH_ALEN];
+	u32 Flags;
+};
+
+struct ndis_802_11_pmkid_list {
+	u32 Version;       /*  Version of the structure */
+	u32 NumCandidates; /*  No. of pmkid candidates */
+	struct pmkid_candidate CandidateList[1];
+};
+
+struct ndis_802_11_auth_encrypt {
+	enum ndis_802_11_auth_mode AuthModeSupported;
+	enum ndis_802_11_wep_status EncryptStatusSupported;
+};
+
+struct ndis_802_11_cap {
+	u32  Length;
+	u32  Version;
+	u32  NoOfPMKIDs;
+	u32  NoOfAuthEncryptPairsSupported;
+	struct ndis_802_11_auth_encrypt AuthenticationEncryptionSupported[1];
+};
+
+u8 key_2char2num(u8 hch, u8 lch);
+u8 key_char2num(u8 ch);
+u8 str_2char2num(u8 hch, u8 lch);
+
+#endif /* ifndef WLAN_BSSDEF_H_ */
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
new file mode 100644
index 000000000000..2ff622ba24f0
--- /dev/null
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -0,0 +1,67 @@
+/******************************************************************************
+ *
+ * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110, USA
+ *
+ *
+ ******************************************************************************/
+#ifndef __XMIT_OSDEP_H_
+#define __XMIT_OSDEP_H_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+struct pkt_file {
+	struct sk_buff *pkt;
+	size_t pkt_len;	 /* the remainder length of the open_file */
+	unsigned char *cur_buffer;
+	u8 *buf_start;
+	u8 *cur_addr;
+	size_t buf_len;
+};
+
+extern int rtw_ht_enable;
+extern int rtw_cbw40_enable;
+extern int rtw_ampdu_enable;/* for enable tx_ampdu */
+
+#define NR_XMITFRAME	256
+
+struct xmit_priv;
+struct pkt_attrib;
+struct sta_xmit_priv;
+struct xmit_frame;
+struct xmit_buf;
+
+int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
+
+void rtw_os_xmit_schedule(struct adapter *padapter);
+
+int rtw_os_xmit_resource_alloc(struct adapter *padapter,
+			       struct xmit_buf *pxmitbuf, u32 alloc_sz);
+void rtw_os_xmit_resource_free(struct adapter *padapter,
+			       struct xmit_buf *pxmitbuf, u32 free_sz);
+
+void rtw_set_tx_chksum_offload(struct sk_buff *pkt, struct pkt_attrib *pattrib);
+
+uint rtw_remainder_len(struct pkt_file *pfile);
+void _rtw_open_pktfile(struct sk_buff *pkt, struct pkt_file *pfile);
+uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
+int rtw_endofpktfile(struct pkt_file *pfile);
+
+void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
+void rtw_os_xmit_complete(struct adapter *padapter,
+			  struct xmit_frame *pxframe);
+
+#endif /* __XMIT_OSDEP_H_ */
-- 
2.31.1


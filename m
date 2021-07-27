Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4EB3D83E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhG0XWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhG0XWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:22:31 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD8C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:22:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m19so240352wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4ItEvR8vaH2Xa9Ok+6tyaGanJJO9qEoXUdsmmgERmo=;
        b=W9Txuc8V02Edqh2UwJtp0R7XQQXxhuoOEcA7npI7Bt43ZRx2XP7e/Tlq1gM2GsfTRU
         /UOmUgfLIsaVN556/6/KvZ3A+U4AM7wsQw8HuInhkL5bAMysqq+FvAbo4rZOKxpipHFY
         FsDXzlMbiVUFJBLZT210X7sAW8m2kZZ2hN+V5Ihx3Jh/I+W7p84uBGMKqKIHKsiml0WI
         H3gBH5khAEltJstz5ZeJAzHx4PaOB52RzCihoSEnGsuhkepn0tKKqiGYF2hhEWY0d0S4
         4jL82VFq2xE9JZM6o4/dKQ215BGBPdQQZigVDK7LZ6AItk5t7UsiXMqVdxyyN0srSxB5
         yHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4ItEvR8vaH2Xa9Ok+6tyaGanJJO9qEoXUdsmmgERmo=;
        b=kEqQ5Fr7opbU+yxUQZuNWE55MN1aTDesIbj/Jbj/BbKB7sYwu1r+mUqOQegh/aSfcT
         pbkyY8lmH4LodAgnaIFRSUHhW2hZGX0gNkiP4Doh9AX8D02xXljW0kxcBiuHfz+tLCg1
         oLawnQJDvuTQYYFNkixZLIlD6+niXMTJc87q4tuhj2Pw+rX14axuGe9Q6ZmBrSh7/LJ4
         HYVv45maL+GNyt5Gv8juHwIzcvFTOD1N8pUyPCaIIXNytj9mrksyrpG4JgafSuWXwUya
         rEGgl9dqHLWv8krwO/f9ZJ7Zd/01RR33HQsjotlwTd5K5YBU5v97j4sTzmj9qcp6opR3
         dBRQ==
X-Gm-Message-State: AOAM532q21oVGRYI9wvxFV3ErIcohZG/278RVXlDc/vUBzutJ9LRC2f/
        1uhDhWXo2xtKO201cYDlpGnuKQ==
X-Google-Smtp-Source: ABdhPJwY7tXClDGxhA6xEoOrZ8ATTCjGXi1i4I6p5bfP10mWbbtRNJTa4xakvHQQTKuOt+jpYHLPXQ==
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr6376060wmk.97.1627428147406;
        Tue, 27 Jul 2021 16:22:27 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m7sm3848367wmq.20.2021.07.27.16.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:22:25 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        fabioaiuto83@gmail.com, martin@kaiser.cx
Subject: [PATCH v4 2/6] staging: r8188eu: introduce new hal dir for RTL8188eu driver
Date:   Wed, 28 Jul 2021 00:22:15 +0100
Message-Id: <20210727232219.2948-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210727232219.2948-1-phil@philpotter.co.uk>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is split in order to keep the file sizes down. This hal
directory is part of the newer/better driver from GitHub modified by
Larry Finger. Import this as the basis for all future work going
forward.

Suggested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c  |   86 +
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  760 ++++++
 .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  720 +++++
 .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  230 ++
 .../staging/r8188eu/hal/HalHWImg8188E_RF.c    |  268 ++
 drivers/staging/r8188eu/hal/HalPhyRf.c        |   49 +
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 1505 +++++++++++
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |  132 +
 drivers/staging/r8188eu/hal/hal_com.c         |  381 +++
 drivers/staging/r8188eu/hal/hal_intf.c        |  468 ++++
 drivers/staging/r8188eu/hal/odm.c             | 2174 +++++++++++++++
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |  601 +++++
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  400 +++
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  130 +
 drivers/staging/r8188eu/hal/odm_debug.c       |   32 +
 drivers/staging/r8188eu/hal/odm_interface.c   |  205 ++
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  762 ++++++
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |  267 ++
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 2390 +++++++++++++++++
 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  851 ++++++
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 1135 ++++++++
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c |  569 ++++
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c |  202 ++
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |   80 +
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   |   91 +
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  111 +
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  136 +
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  703 +++++
 drivers/staging/r8188eu/hal/usb_halinit.c     | 2334 ++++++++++++++++
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  717 +++++
 30 files changed, 18489 insertions(+)
 create mode 100644 drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
 create mode 100644 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
 create mode 100644 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
 create mode 100644 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
 create mode 100644 drivers/staging/r8188eu/hal/hal_com.c
 create mode 100644 drivers/staging/r8188eu/hal/hal_intf.c
 create mode 100644 drivers/staging/r8188eu/hal/odm.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_HWConfig.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_RTL8188E.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_debug.c
 create mode 100644 drivers/staging/r8188eu/hal/odm_interface.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_cmd.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_dm.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_mp.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_sreset.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_led.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c
 create mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
 create mode 100644 drivers/staging/r8188eu/hal/usb_halinit.c
 create mode 100644 drivers/staging/r8188eu/hal/usb_ops_linux.c

diff --git a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
new file mode 100644
index 000000000000..fc23bf159345
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
@@ -0,0 +1,86 @@
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
+#include "Hal8188EPwrSeq.h"
+#include <rtl8188e_hal.h>
+
+/*
+    drivers should parse below arrays and do the corresponding actions
+*/
+/* 3 Power on  Array */
+struct wl_pwr_cfg rtl8188E_power_on_flow[RTL8188E_TRANS_CARDEMU_TO_ACT_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_CARDEMU_TO_ACT
+	RTL8188E_TRANS_END
+};
+
+/* 3Radio off Array */
+struct wl_pwr_cfg rtl8188E_radio_off_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_ACT_TO_CARDEMU
+	RTL8188E_TRANS_END
+};
+
+/* 3Card Disable Array */
+struct wl_pwr_cfg rtl8188E_card_disable_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_ACT_TO_CARDEMU
+	RTL8188E_TRANS_CARDEMU_TO_CARDDIS
+	RTL8188E_TRANS_END
+};
+
+/* 3 Card Enable Array */
+struct wl_pwr_cfg rtl8188E_card_enable_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_CARDDIS_TO_CARDEMU
+	RTL8188E_TRANS_CARDEMU_TO_ACT
+	RTL8188E_TRANS_END
+};
+
+/* 3Suspend Array */
+struct wl_pwr_cfg rtl8188E_suspend_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_ACT_TO_CARDEMU
+	RTL8188E_TRANS_CARDEMU_TO_SUS
+	RTL8188E_TRANS_END
+};
+
+/* 3 Resume Array */
+struct wl_pwr_cfg rtl8188E_resume_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_CARDEMU_TO_SUS_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_SUS_TO_CARDEMU
+	RTL8188E_TRANS_CARDEMU_TO_ACT
+	RTL8188E_TRANS_END
+};
+
+/* 3HWPDN Array */
+struct wl_pwr_cfg rtl8188E_hwpdn_flow[RTL8188E_TRANS_ACT_TO_CARDEMU_STEPS + RTL8188E_TRANS_CARDEMU_TO_PDN_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	RTL8188E_TRANS_ACT_TO_CARDEMU
+	RTL8188E_TRANS_CARDEMU_TO_PDN
+	RTL8188E_TRANS_END
+};
+
+/* 3 Enter LPS */
+struct wl_pwr_cfg rtl8188E_enter_lps_flow[RTL8188E_TRANS_ACT_TO_LPS_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	/* FW behavior */
+	RTL8188E_TRANS_ACT_TO_LPS
+	RTL8188E_TRANS_END
+};
+
+/* 3 Leave LPS */
+struct wl_pwr_cfg rtl8188E_leave_lps_flow[RTL8188E_TRANS_LPS_TO_ACT_STEPS + RTL8188E_TRANS_END_STEPS] = {
+	/* FW behavior */
+	RTL8188E_TRANS_LPS_TO_ACT
+	RTL8188E_TRANS_END
+};
diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
new file mode 100644
index 000000000000..e9b12128b6b1
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -0,0 +1,760 @@
+/*++
+Copyright (c) Realtek Semiconductor Corp. All rights reserved.
+
+Module Name:
+	RateAdaptive.c
+
+Abstract:
+	Implement Rate Adaptive functions for common operations.
+
+Major Change History:
+	When       Who               What
+	---------- ---------------   -------------------------------
+	2011-08-12 Page            Create.
+
+--*/
+#include "odm_precomp.h"
+
+/*  Rate adaptive parameters */
+
+static u8 RETRY_PENALTY[PERENTRY][RETRYSIZE+1] = {
+		{5, 4, 3, 2, 0, 3},      /* 92 , idx = 0 */
+		{6, 5, 4, 3, 0, 4},      /* 86 , idx = 1 */
+		{6, 5, 4, 2, 0, 4},      /* 81 , idx = 2 */
+		{8, 7, 6, 4, 0, 6},      /* 75 , idx = 3 */
+		{10, 9, 8, 6, 0, 8},     /* 71	, idx = 4 */
+		{10, 9, 8, 4, 0, 8},     /* 66	, idx = 5 */
+		{10, 9, 8, 2, 0, 8},     /* 62	, idx = 6 */
+		{10, 9, 8, 0, 0, 8},     /* 59	, idx = 7 */
+		{18, 17, 16, 8, 0, 16},  /* 53 , idx = 8 */
+		{26, 25, 24, 16, 0, 24}, /* 50	, idx = 9 */
+		{34, 33, 32, 24, 0, 32}, /* 47	, idx = 0x0a */
+		{34, 31, 28, 20, 0, 32}, /* 43	, idx = 0x0b */
+		{34, 31, 27, 18, 0, 32}, /* 40 , idx = 0x0c */
+		{34, 31, 26, 16, 0, 32}, /* 37 , idx = 0x0d */
+		{34, 30, 22, 16, 0, 32}, /* 32 , idx = 0x0e */
+		{34, 30, 24, 16, 0, 32}, /* 26 , idx = 0x0f */
+		{49, 46, 40, 16, 0, 48}, /* 20	, idx = 0x10 */
+		{49, 45, 32, 0, 0, 48},  /* 17 , idx = 0x11 */
+		{49, 45, 22, 18, 0, 48}, /* 15	, idx = 0x12 */
+		{49, 40, 24, 16, 0, 48}, /* 12	, idx = 0x13 */
+		{49, 32, 18, 12, 0, 48}, /* 9 , idx = 0x14 */
+		{49, 22, 18, 14, 0, 48}, /* 6 , idx = 0x15 */
+		{49, 16, 16, 0, 0, 48}
+	}; /* 3, idx = 0x16 */
+
+static u8 PT_PENALTY[RETRYSIZE+1] = {34, 31, 30, 24, 0, 32};
+
+/*  wilson modify */
+static u8 RETRY_PENALTY_IDX[2][RATESIZE] = {
+		{4, 4, 4, 5, 4, 4, 5, 7, 7, 7, 8, 0x0a,	       /*  SS>TH */
+		4, 4, 4, 4, 6, 0x0a, 0x0b, 0x0d,
+		5, 5, 7, 7, 8, 0x0b, 0x0d, 0x0f},			   /*  0329 R01 */
+		{0x0a, 0x0a, 0x0b, 0x0c, 0x0a,
+		0x0a, 0x0b, 0x0c, 0x0d, 0x10, 0x13, 0x14,	   /*  SS<TH */
+		0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x11, 0x13, 0x15,
+		9, 9, 9, 9, 0x0c, 0x0e, 0x11, 0x13}
+	};
+
+static u8 RETRY_PENALTY_UP_IDX[RATESIZE] = {
+		0x0c, 0x0d, 0x0d, 0x0f, 0x0d, 0x0e,
+		0x0f, 0x0f, 0x10, 0x12, 0x13, 0x14,	       /*  SS>TH */
+		0x0f, 0x10, 0x10, 0x12, 0x12, 0x13, 0x14, 0x15,
+		0x11, 0x11, 0x12, 0x13, 0x13, 0x13, 0x14, 0x15};
+
+static u8 RSSI_THRESHOLD[RATESIZE] = {
+		0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0x24, 0x26, 0x2a,
+		0x18, 0x1a, 0x1d, 0x1f, 0x21, 0x27, 0x29, 0x2a,
+		0, 0, 0, 0x1f, 0x23, 0x28, 0x2a, 0x2c};
+
+static u16 N_THRESHOLD_HIGH[RATESIZE] = {
+		4, 4, 8, 16,
+		24, 36, 48, 72, 96, 144, 192, 216,
+		60, 80, 100, 160, 240, 400, 560, 640,
+		300, 320, 480, 720, 1000, 1200, 1600, 2000};
+static u16 N_THRESHOLD_LOW[RATESIZE] = {
+		2, 2, 4, 8,
+		12, 18, 24, 36, 48, 72, 96, 108,
+		30, 40, 50, 80, 120, 200, 280, 320,
+		150, 160, 240, 360, 500, 600, 800, 1000};
+
+static u8 DROPING_NECESSARY[RATESIZE] = {
+		1, 1, 1, 1,
+		1, 2, 3, 4, 5, 6, 7, 8,
+		1, 2, 3, 4, 5, 6, 7, 8,
+		5, 6, 7, 8, 9, 10, 11, 12};
+
+static u8 PendingForRateUpFail[5] = {2, 10, 24, 40, 60};
+static u16 DynamicTxRPTTiming[6] = {
+	0x186a, 0x30d4, 0x493e, 0x61a8, 0x7a12 , 0x927c}; /*  200ms-1200ms */
+
+/*  End Rate adaptive parameters */
+
+static void odm_SetTxRPTTiming_8188E(
+		struct odm_dm_struct *dm_odm,
+		struct odm_ra_info *pRaInfo,
+		u8 extend
+	)
+{
+	u8 idx = 0;
+
+	for (idx = 0; idx < 5; idx++)
+		if (DynamicTxRPTTiming[idx] == pRaInfo->RptTime)
+			break;
+
+	if (extend == 0) { /*  back to default timing */
+		idx = 0;  /* 200ms */
+	} else if (extend == 1) {/*  increase the timing */
+		idx += 1;
+		if (idx > 5)
+			idx = 5;
+	} else if (extend == 2) {/*  decrease the timing */
+		if (idx != 0)
+			idx -= 1;
+	}
+	pRaInfo->RptTime = DynamicTxRPTTiming[idx];
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("pRaInfo->RptTime = 0x%x\n", pRaInfo->RptTime));
+}
+
+static int odm_RateDown_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *pRaInfo)
+{
+	u8 RateID, LowestRate, HighestRate;
+	u8 i;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("=====>odm_RateDown_8188E()\n"));
+	if (NULL == pRaInfo) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("odm_RateDown_8188E(): pRaInfo is NULL\n"));
+		return -1;
+	}
+	RateID = pRaInfo->PreRate;
+	LowestRate = pRaInfo->LowestRate;
+	HighestRate = pRaInfo->HighestRate;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     (" RateID =%d LowestRate =%d HighestRate =%d RateSGI =%d\n",
+		     RateID, LowestRate, HighestRate, pRaInfo->RateSGI));
+	if (RateID > HighestRate) {
+		RateID = HighestRate;
+	} else if (pRaInfo->RateSGI) {
+		pRaInfo->RateSGI = 0;
+	} else if (RateID > LowestRate) {
+		if (RateID > 0) {
+			for (i = RateID-1; i > LowestRate; i--) {
+				if (pRaInfo->RAUseRate & BIT(i)) {
+					RateID = i;
+					goto RateDownFinish;
+				}
+			}
+		}
+	} else if (RateID <= LowestRate) {
+		RateID = LowestRate;
+	}
+RateDownFinish:
+	if (pRaInfo->RAWaitingCounter == 1) {
+		pRaInfo->RAWaitingCounter += 1;
+		pRaInfo->RAPendingCounter += 1;
+	} else if (pRaInfo->RAWaitingCounter == 0) {
+		;
+	} else {
+		pRaInfo->RAWaitingCounter = 0;
+		pRaInfo->RAPendingCounter = 0;
+	}
+
+	if (pRaInfo->RAPendingCounter >= 4)
+		pRaInfo->RAPendingCounter = 4;
+
+	pRaInfo->DecisionRate = RateID;
+	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 2);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("Rate down, RPT Timing default\n"));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("RAWaitingCounter %d, RAPendingCounter %d", pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("Rate down to RateID %d RateSGI %d\n", RateID, pRaInfo->RateSGI));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateDown_8188E()\n"));
+	return 0;
+}
+
+static int odm_RateUp_8188E(
+		struct odm_dm_struct *dm_odm,
+		struct odm_ra_info *pRaInfo
+	)
+{
+	u8 RateID, HighestRate;
+	u8 i;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("=====>odm_RateUp_8188E()\n"));
+	if (NULL == pRaInfo) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("odm_RateUp_8188E(): pRaInfo is NULL\n"));
+		return -1;
+	}
+	RateID = pRaInfo->PreRate;
+	HighestRate = pRaInfo->HighestRate;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     (" RateID =%d HighestRate =%d\n",
+		     RateID, HighestRate));
+	if (pRaInfo->RAWaitingCounter == 1) {
+		pRaInfo->RAWaitingCounter = 0;
+		pRaInfo->RAPendingCounter = 0;
+	} else if (pRaInfo->RAWaitingCounter > 1) {
+		pRaInfo->PreRssiStaRA = pRaInfo->RssiStaRA;
+		goto RateUpfinish;
+	}
+	odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 0);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("odm_RateUp_8188E():Decrease RPT Timing\n"));
+
+	if (RateID < HighestRate) {
+		for (i = RateID+1; i <= HighestRate; i++) {
+			if (pRaInfo->RAUseRate & BIT(i)) {
+				RateID = i;
+				goto RateUpfinish;
+			}
+		}
+	} else if (RateID == HighestRate) {
+		if (pRaInfo->SGIEnable && (pRaInfo->RateSGI != 1))
+			pRaInfo->RateSGI = 1;
+		else if ((pRaInfo->SGIEnable) != 1)
+			pRaInfo->RateSGI = 0;
+	} else {
+		RateID = HighestRate;
+	}
+RateUpfinish:
+	if (pRaInfo->RAWaitingCounter == (4+PendingForRateUpFail[pRaInfo->RAPendingCounter]))
+		pRaInfo->RAWaitingCounter = 0;
+	else
+		pRaInfo->RAWaitingCounter++;
+
+	pRaInfo->DecisionRate = RateID;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("Rate up to RateID %d\n", RateID));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("RAWaitingCounter %d, RAPendingCounter %d", pRaInfo->RAWaitingCounter, pRaInfo->RAPendingCounter));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateUp_8188E()\n"));
+	return 0;
+}
+
+static void odm_ResetRaCounter_8188E(struct odm_ra_info *pRaInfo)
+{
+	u8 RateID;
+
+	RateID = pRaInfo->DecisionRate;
+	pRaInfo->NscUp = (N_THRESHOLD_HIGH[RateID]+N_THRESHOLD_LOW[RateID])>>1;
+	pRaInfo->NscDown = (N_THRESHOLD_HIGH[RateID]+N_THRESHOLD_LOW[RateID])>>1;
+}
+
+static void odm_RateDecision_8188E(struct odm_dm_struct *dm_odm,
+		struct odm_ra_info *pRaInfo
+	)
+{
+	u8 RateID = 0, RtyPtID = 0, PenaltyID1 = 0, PenaltyID2 = 0;
+	/* u32 pool_retry; */
+	static u8 DynamicTxRPTTimingCounter;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("=====>odm_RateDecision_8188E()\n"));
+
+	if (pRaInfo->Active && (pRaInfo->TOTAL > 0)) { /*  STA used and data packet exits */
+		if ((pRaInfo->RssiStaRA < (pRaInfo->PreRssiStaRA - 3)) ||
+		    (pRaInfo->RssiStaRA > (pRaInfo->PreRssiStaRA + 3))) {
+			pRaInfo->RAWaitingCounter = 0;
+			pRaInfo->RAPendingCounter = 0;
+		}
+		/*  Start RA decision */
+		if (pRaInfo->PreRate > pRaInfo->HighestRate)
+			RateID = pRaInfo->HighestRate;
+		else
+			RateID = pRaInfo->PreRate;
+		if (pRaInfo->RssiStaRA > RSSI_THRESHOLD[RateID])
+			RtyPtID = 0;
+		else
+			RtyPtID = 1;
+		PenaltyID1 = RETRY_PENALTY_IDX[RtyPtID][RateID]; /* TODO by page */
+
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+			     (" NscDown init is %d\n", pRaInfo->NscDown));
+		pRaInfo->NscDown += pRaInfo->RTY[0] * RETRY_PENALTY[PenaltyID1][0];
+		pRaInfo->NscDown += pRaInfo->RTY[1] * RETRY_PENALTY[PenaltyID1][1];
+		pRaInfo->NscDown += pRaInfo->RTY[2] * RETRY_PENALTY[PenaltyID1][2];
+		pRaInfo->NscDown += pRaInfo->RTY[3] * RETRY_PENALTY[PenaltyID1][3];
+		pRaInfo->NscDown += pRaInfo->RTY[4] * RETRY_PENALTY[PenaltyID1][4];
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+			     (" NscDown is %d, total*penalty[5] is %d\n",
+			     pRaInfo->NscDown, (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5])));
+		if (pRaInfo->NscDown > (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5]))
+			pRaInfo->NscDown -= pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID1][5];
+		else
+			pRaInfo->NscDown = 0;
+
+		/*  rate up */
+		PenaltyID2 = RETRY_PENALTY_UP_IDX[RateID];
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+			     (" NscUp init is %d\n", pRaInfo->NscUp));
+		pRaInfo->NscUp += pRaInfo->RTY[0] * RETRY_PENALTY[PenaltyID2][0];
+		pRaInfo->NscUp += pRaInfo->RTY[1] * RETRY_PENALTY[PenaltyID2][1];
+		pRaInfo->NscUp += pRaInfo->RTY[2] * RETRY_PENALTY[PenaltyID2][2];
+		pRaInfo->NscUp += pRaInfo->RTY[3] * RETRY_PENALTY[PenaltyID2][3];
+		pRaInfo->NscUp += pRaInfo->RTY[4] * RETRY_PENALTY[PenaltyID2][4];
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+			     ("NscUp is %d, total*up[5] is %d\n",
+			     pRaInfo->NscUp, (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5])));
+		if (pRaInfo->NscUp > (pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5]))
+			pRaInfo->NscUp -= pRaInfo->TOTAL * RETRY_PENALTY[PenaltyID2][5];
+		else
+			pRaInfo->NscUp = 0;
+
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE|ODM_COMP_INIT, ODM_DBG_LOUD,
+			     (" RssiStaRa = %d RtyPtID =%d PenaltyID1 = 0x%x  PenaltyID2 = 0x%x RateID =%d NscDown =%d NscUp =%d SGI =%d\n",
+			     pRaInfo->RssiStaRA, RtyPtID, PenaltyID1, PenaltyID2, RateID, pRaInfo->NscDown, pRaInfo->NscUp, pRaInfo->RateSGI));
+		if ((pRaInfo->NscDown < N_THRESHOLD_LOW[RateID]) ||
+		    (pRaInfo->DROP > DROPING_NECESSARY[RateID]))
+			odm_RateDown_8188E(dm_odm, pRaInfo);
+		else if (pRaInfo->NscUp > N_THRESHOLD_HIGH[RateID])
+			odm_RateUp_8188E(dm_odm, pRaInfo);
+
+		if (pRaInfo->DecisionRate > pRaInfo->HighestRate)
+			pRaInfo->DecisionRate = pRaInfo->HighestRate;
+
+		if ((pRaInfo->DecisionRate) == (pRaInfo->PreRate))
+			DynamicTxRPTTimingCounter += 1;
+		else
+			DynamicTxRPTTimingCounter = 0;
+
+		if (DynamicTxRPTTimingCounter >= 4) {
+			odm_SetTxRPTTiming_8188E(dm_odm, pRaInfo, 1);
+			ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE,
+				     ODM_DBG_LOUD, ("<===== Rate don't change 4 times, Extend RPT Timing\n"));
+			DynamicTxRPTTimingCounter = 0;
+		}
+
+		pRaInfo->PreRate = pRaInfo->DecisionRate;  /* YJ, add, 120120 */
+
+		odm_ResetRaCounter_8188E(pRaInfo);
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, ("<===== odm_RateDecision_8188E()\n"));
+}
+
+static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_info *pRaInfo)
+{  /*  Wilson 2011/10/26 */
+	u32 MaskFromReg;
+	s8 i;
+
+	switch (pRaInfo->RateID) {
+	case RATR_INX_WIRELESS_NGB:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff015;
+		break;
+	case RATR_INX_WIRELESS_NG:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff010;
+		break;
+	case RATR_INX_WIRELESS_NB:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff005;
+		break;
+	case RATR_INX_WIRELESS_N:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0f8ff000;
+		break;
+	case RATR_INX_WIRELESS_GB:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x00000ff5;
+		break;
+	case RATR_INX_WIRELESS_G:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x00000ff0;
+		break;
+	case RATR_INX_WIRELESS_B:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&0x0000000d;
+		break;
+	case 12:
+		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR0);
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		break;
+	case 13:
+		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR1);
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		break;
+	case 14:
+		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR2);
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		break;
+	case 15:
+		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR3);
+		pRaInfo->RAUseRate = (pRaInfo->RateMask)&MaskFromReg;
+		break;
+	default:
+		pRaInfo->RAUseRate = (pRaInfo->RateMask);
+		break;
+	}
+	/*  Highest rate */
+	if (pRaInfo->RAUseRate) {
+		for (i = RATESIZE; i >= 0; i--) {
+			if ((pRaInfo->RAUseRate)&BIT(i)) {
+				pRaInfo->HighestRate = i;
+				break;
+			}
+		}
+	} else {
+		pRaInfo->HighestRate = 0;
+	}
+	/*  Lowest rate */
+	if (pRaInfo->RAUseRate) {
+		for (i = 0; i < RATESIZE; i++) {
+			if ((pRaInfo->RAUseRate) & BIT(i)) {
+				pRaInfo->LowestRate = i;
+				break;
+			}
+		}
+	} else {
+		pRaInfo->LowestRate = 0;
+	}
+		if (pRaInfo->HighestRate > 0x13)
+			pRaInfo->PTModeSS = 3;
+		else if (pRaInfo->HighestRate > 0x0b)
+			pRaInfo->PTModeSS = 2;
+		else if (pRaInfo->HighestRate > 0x03)
+			pRaInfo->PTModeSS = 1;
+		else
+			pRaInfo->PTModeSS = 0;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+		     ("ODM_ARFBRefresh_8188E(): PTModeSS =%d\n", pRaInfo->PTModeSS));
+
+	if (pRaInfo->DecisionRate > pRaInfo->HighestRate)
+		pRaInfo->DecisionRate = pRaInfo->HighestRate;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+		     ("ODM_ARFBRefresh_8188E(): RateID =%d RateMask =%8.8x RAUseRate =%8.8x HighestRate =%d, DecisionRate =%d\n",
+		     pRaInfo->RateID, pRaInfo->RateMask, pRaInfo->RAUseRate, pRaInfo->HighestRate, pRaInfo->DecisionRate));
+	return 0;
+}
+
+static void odm_PTTryState_8188E(struct odm_ra_info *pRaInfo)
+{
+	pRaInfo->PTTryState = 0;
+	switch (pRaInfo->PTModeSS) {
+	case 3:
+		if (pRaInfo->DecisionRate >= 0x19)
+			pRaInfo->PTTryState = 1;
+		break;
+	case 2:
+		if (pRaInfo->DecisionRate >= 0x11)
+			pRaInfo->PTTryState = 1;
+		break;
+	case 1:
+		if (pRaInfo->DecisionRate >= 0x0a)
+			pRaInfo->PTTryState = 1;
+		break;
+	case 0:
+		if (pRaInfo->DecisionRate >= 0x03)
+			pRaInfo->PTTryState = 1;
+		break;
+	default:
+		pRaInfo->PTTryState = 0;
+		break;
+	}
+
+	if (pRaInfo->RssiStaRA < 48) {
+		pRaInfo->PTStage = 0;
+	} else if (pRaInfo->PTTryState == 1) {
+		if ((pRaInfo->PTStopCount >= 10) ||
+		    (pRaInfo->PTPreRssi > pRaInfo->RssiStaRA + 5) ||
+		    (pRaInfo->PTPreRssi < pRaInfo->RssiStaRA - 5) ||
+		    (pRaInfo->DecisionRate != pRaInfo->PTPreRate)) {
+			if (pRaInfo->PTStage == 0)
+				pRaInfo->PTStage = 1;
+			else if (pRaInfo->PTStage == 1)
+				pRaInfo->PTStage = 3;
+			else
+				pRaInfo->PTStage = 5;
+
+			pRaInfo->PTPreRssi = pRaInfo->RssiStaRA;
+			pRaInfo->PTStopCount = 0;
+		} else {
+			pRaInfo->RAstage = 0;
+			pRaInfo->PTStopCount++;
+		}
+	} else {
+		pRaInfo->PTStage = 0;
+		pRaInfo->RAstage = 0;
+	}
+	pRaInfo->PTPreRate = pRaInfo->DecisionRate;
+}
+
+static void odm_PTDecision_8188E(struct odm_ra_info *pRaInfo)
+{
+	u8 j;
+	u8 temp_stage;
+	u32 numsc;
+	u32 num_total;
+	u8 stage_id;
+
+	numsc  = 0;
+	num_total = pRaInfo->TOTAL * PT_PENALTY[5];
+	for (j = 0; j <= 4; j++) {
+		numsc += pRaInfo->RTY[j] * PT_PENALTY[j];
+		if (numsc > num_total)
+			break;
+	}
+
+	j = j >> 1;
+	temp_stage = (pRaInfo->PTStage + 1) >> 1;
+	if (temp_stage > j)
+		stage_id = temp_stage-j;
+	else
+		stage_id = 0;
+
+	pRaInfo->PTSmoothFactor = (pRaInfo->PTSmoothFactor>>1) + (pRaInfo->PTSmoothFactor>>2) + stage_id*16+2;
+	if (pRaInfo->PTSmoothFactor > 192)
+		pRaInfo->PTSmoothFactor = 192;
+	stage_id = pRaInfo->PTSmoothFactor >> 6;
+	temp_stage = stage_id*2;
+	if (temp_stage != 0)
+		temp_stage -= 1;
+	if (pRaInfo->DROP > 3)
+		temp_stage = 0;
+	pRaInfo->PTStage = temp_stage;
+}
+
+static void
+odm_RATxRPTTimerSetting(
+		struct odm_dm_struct *dm_odm,
+		u16 minRptTime
+)
+{
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" =====>odm_RATxRPTTimerSetting()\n"));
+
+	if (dm_odm->CurrminRptTime != minRptTime) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+			     (" CurrminRptTime = 0x%04x minRptTime = 0x%04x\n", dm_odm->CurrminRptTime, minRptTime));
+		rtw_rpt_timer_cfg_cmd(dm_odm->Adapter, minRptTime);
+		dm_odm->CurrminRptTime = minRptTime;
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE, (" <===== odm_RATxRPTTimerSetting()\n"));
+}
+
+void
+ODM_RASupport_Init(
+		struct odm_dm_struct *dm_odm
+	)
+{
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("=====>ODM_RASupport_Init()\n"));
+
+	/*  2012/02/14 MH Be noticed, the init must be after IC type is recognized!!!!! */
+	if (dm_odm->SupportICType == ODM_RTL8188E)
+		dm_odm->RaSupport88E = true;
+}
+
+int ODM_RAInfo_Init(struct odm_dm_struct *dm_odm, u8 macid)
+{
+	struct odm_ra_info *pRaInfo = &dm_odm->RAInfo[macid];
+	u8 WirelessMode = 0xFF; /* invalid value */
+	u8 max_rate_idx = 0x13; /* MCS7 */
+	if (dm_odm->pWirelessMode != NULL)
+		WirelessMode = *(dm_odm->pWirelessMode);
+
+	if (WirelessMode != 0xFF) {
+		if (WirelessMode & ODM_WM_N24G)
+			max_rate_idx = 0x13;
+		else if (WirelessMode & ODM_WM_G)
+			max_rate_idx = 0x0b;
+		else if (WirelessMode & ODM_WM_B)
+			max_rate_idx = 0x03;
+	}
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+		     ("ODM_RAInfo_Init(): WirelessMode:0x%08x , max_raid_idx:0x%02x\n",
+		     WirelessMode, max_rate_idx));
+
+	pRaInfo->DecisionRate = max_rate_idx;
+	pRaInfo->PreRate = max_rate_idx;
+	pRaInfo->HighestRate = max_rate_idx;
+	pRaInfo->LowestRate = 0;
+	pRaInfo->RateID = 0;
+	pRaInfo->RateMask = 0xffffffff;
+	pRaInfo->RssiStaRA = 0;
+	pRaInfo->PreRssiStaRA = 0;
+	pRaInfo->SGIEnable = 0;
+	pRaInfo->RAUseRate = 0xffffffff;
+	pRaInfo->NscDown = (N_THRESHOLD_HIGH[0x13]+N_THRESHOLD_LOW[0x13])/2;
+	pRaInfo->NscUp = (N_THRESHOLD_HIGH[0x13]+N_THRESHOLD_LOW[0x13])/2;
+	pRaInfo->RateSGI = 0;
+	pRaInfo->Active = 1;	/* Active is not used at present. by page, 110819 */
+	pRaInfo->RptTime = 0x927c;
+	pRaInfo->DROP = 0;
+	pRaInfo->RTY[0] = 0;
+	pRaInfo->RTY[1] = 0;
+	pRaInfo->RTY[2] = 0;
+	pRaInfo->RTY[3] = 0;
+	pRaInfo->RTY[4] = 0;
+	pRaInfo->TOTAL = 0;
+	pRaInfo->RAWaitingCounter = 0;
+	pRaInfo->RAPendingCounter = 0;
+	pRaInfo->PTActive = 1;   /*  Active when this STA is use */
+	pRaInfo->PTTryState = 0;
+	pRaInfo->PTStage = 5; /*  Need to fill into HW_PWR_STATUS */
+	pRaInfo->PTSmoothFactor = 192;
+	pRaInfo->PTStopCount = 0;
+	pRaInfo->PTPreRate = 0;
+	pRaInfo->PTPreRssi = 0;
+	pRaInfo->PTModeSS = 0;
+	pRaInfo->RAstage = 0;
+	return 0;
+}
+
+int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm)
+{
+	u8 macid = 0;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("=====>\n"));
+	dm_odm->CurrminRptTime = 0;
+
+	for (macid = 0; macid < ODM_ASSOCIATE_ENTRY_NUM; macid++)
+		ODM_RAInfo_Init(dm_odm, macid);
+
+	return 0;
+}
+
+u8 ODM_RA_GetShortGI_8188E(struct odm_dm_struct *dm_odm, u8 macid)
+{
+	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+		return 0;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     ("macid =%d SGI =%d\n", macid, dm_odm->RAInfo[macid].RateSGI));
+	return dm_odm->RAInfo[macid].RateSGI;
+}
+
+u8 ODM_RA_GetDecisionRate_8188E(struct odm_dm_struct *dm_odm, u8 macid)
+{
+	u8 DecisionRate = 0;
+
+	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+		return 0;
+	DecisionRate = (dm_odm->RAInfo[macid].DecisionRate);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		(" macid =%d DecisionRate = 0x%x\n", macid, DecisionRate));
+	return DecisionRate;
+}
+
+u8 ODM_RA_GetHwPwrStatus_8188E(struct odm_dm_struct *dm_odm, u8 macid)
+{
+	u8 PTStage = 5;
+
+	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+		return 0;
+	PTStage = (dm_odm->RAInfo[macid].PTStage);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     ("macid =%d PTStage = 0x%x\n", macid, PTStage));
+	return PTStage;
+}
+
+void ODM_RA_UpdateRateInfo_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 RateID, u32 RateMask, u8 SGIEnable)
+{
+	struct odm_ra_info *pRaInfo = NULL;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+		     ("macid =%d RateID = 0x%x RateMask = 0x%x SGIEnable =%d\n",
+		     macid, RateID, RateMask, SGIEnable));
+	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+		return;
+
+	pRaInfo = &(dm_odm->RAInfo[macid]);
+	pRaInfo->RateID = RateID;
+	pRaInfo->RateMask = RateMask;
+	pRaInfo->SGIEnable = SGIEnable;
+	odm_ARFBRefresh_8188E(dm_odm, pRaInfo);
+}
+
+void ODM_RA_SetRSSI_8188E(struct odm_dm_struct *dm_odm, u8 macid, u8 Rssi)
+{
+	struct odm_ra_info *pRaInfo = NULL;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_TRACE,
+		     (" macid =%d Rssi =%d\n", macid, Rssi));
+	if ((NULL == dm_odm) || (macid >= ASSOCIATE_ENTRY_NUM))
+		return;
+
+	pRaInfo = &(dm_odm->RAInfo[macid]);
+	pRaInfo->RssiStaRA = Rssi;
+}
+
+void ODM_RA_Set_TxRPT_Time(struct odm_dm_struct *dm_odm, u16 minRptTime)
+{
+	ODM_Write2Byte(dm_odm, REG_TX_RPT_TIME, minRptTime);
+}
+
+void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16 TxRPT_Len, u32 macid_entry0, u32 macid_entry1)
+{
+	struct odm_ra_info *pRAInfo = NULL;
+	u8 MacId = 0;
+	u8 *pBuffer = NULL;
+	u32 valid = 0, ItemNum = 0;
+	u16 minRptTime = 0x927c;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+		     ("=====>ODM_RA_TxRPT2Handle_8188E(): valid0 =%d valid1 =%d BufferLength =%d\n",
+		     macid_entry0, macid_entry1, TxRPT_Len));
+
+	ItemNum = TxRPT_Len >> 3;
+	pBuffer = TxRPT_Buf;
+
+	do {
+		if (MacId >= ASSOCIATE_ENTRY_NUM)
+			valid = 0;
+		else if (MacId >= 32)
+			valid = (1 << (MacId - 32)) & macid_entry1;
+		else
+			valid = (1 << MacId) & macid_entry0;
+
+		pRAInfo = &(dm_odm->RAInfo[MacId]);
+		if (valid) {
+			pRAInfo->RTY[0] = (u16)GET_TX_REPORT_TYPE1_RERTY_0(pBuffer);
+			pRAInfo->RTY[1] = (u16)GET_TX_REPORT_TYPE1_RERTY_1(pBuffer);
+			pRAInfo->RTY[2] = (u16)GET_TX_REPORT_TYPE1_RERTY_2(pBuffer);
+			pRAInfo->RTY[3] = (u16)GET_TX_REPORT_TYPE1_RERTY_3(pBuffer);
+			pRAInfo->RTY[4] = (u16)GET_TX_REPORT_TYPE1_RERTY_4(pBuffer);
+			pRAInfo->DROP =   (u16)GET_TX_REPORT_TYPE1_DROP_0(pBuffer);
+			pRAInfo->TOTAL = pRAInfo->RTY[0] + pRAInfo->RTY[1] +
+					 pRAInfo->RTY[2] + pRAInfo->RTY[3] +
+					 pRAInfo->RTY[4] + pRAInfo->DROP;
+			if (pRAInfo->TOTAL != 0) {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD,
+					     ("macid =%d Total =%d R0 =%d R1 =%d R2 =%d R3 =%d R4 =%d D0 =%d valid0 =%x valid1 =%x\n",
+					     MacId, pRAInfo->TOTAL,
+					     pRAInfo->RTY[0], pRAInfo->RTY[1],
+					     pRAInfo->RTY[2], pRAInfo->RTY[3],
+					     pRAInfo->RTY[4], pRAInfo->DROP,
+					     macid_entry0 , macid_entry1));
+				if (pRAInfo->PTActive) {
+					if (pRAInfo->RAstage < 5)
+						odm_RateDecision_8188E(dm_odm, pRAInfo);
+					else if (pRAInfo->RAstage == 5) /*  Power training try state */
+						odm_PTTryState_8188E(pRAInfo);
+					else /*  RAstage == 6 */
+						odm_PTDecision_8188E(pRAInfo);
+
+					/*  Stage_RA counter */
+					if (pRAInfo->RAstage <= 5)
+						pRAInfo->RAstage++;
+					else
+						pRAInfo->RAstage = 0;
+				} else {
+					odm_RateDecision_8188E(dm_odm, pRAInfo);
+				}
+				ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD,
+					     ("macid =%d R0 =%d R1 =%d R2 =%d R3 =%d R4 =%d drop =%d valid0 =%x RateID =%d SGI =%d\n",
+					     MacId,
+					     pRAInfo->RTY[0],
+					     pRAInfo->RTY[1],
+					     pRAInfo->RTY[2],
+					     pRAInfo->RTY[3],
+					     pRAInfo->RTY[4],
+					     pRAInfo->DROP,
+					     macid_entry0,
+					     pRAInfo->DecisionRate,
+					     pRAInfo->RateSGI));
+			} else {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, (" TOTAL = 0!!!!\n"));
+			}
+		}
+
+		if (minRptTime > pRAInfo->RptTime)
+			minRptTime = pRAInfo->RptTime;
+
+		pBuffer += TX_RPT2_ITEM_SIZE;
+		MacId++;
+	} while (MacId < ItemNum);
+
+	odm_RATxRPTTimerSetting(dm_odm, minRptTime);
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_RATE_ADAPTIVE, ODM_DBG_LOUD, ("<===== ODM_RA_TxRPT2Handle_8188E()\n"));
+}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
new file mode 100644
index 000000000000..f06c14cd4e04
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
@@ -0,0 +1,720 @@
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
+#include "odm_precomp.h"
+
+#include <rtw_iol.h>
+
+#define read_next_pair(array, v1, v2, i)		\
+	 do {						\
+		 i += 2;				\
+		 v1 = array[i];				\
+		 v2 = array[i+1];			\
+	 } while (0)
+
+static bool CheckCondition(const u32  condition, const u32  hex)
+{
+	u32 _board     = (hex & 0x000000FF);
+	u32 _interface = (hex & 0x0000FF00) >> 8;
+	u32 _platform  = (hex & 0x00FF0000) >> 16;
+	u32 cond = condition;
+
+	if (condition == 0xCDCDCDCD)
+		return true;
+
+	cond = condition & 0x000000FF;
+	if ((_board == cond) && cond != 0x00)
+		return false;
+
+	cond = condition & 0x0000FF00;
+	cond = cond >> 8;
+	if ((_interface & cond) == 0 && cond != 0x07)
+		return false;
+
+	cond = condition & 0x00FF0000;
+	cond = cond >> 16;
+	if ((_platform & cond) == 0 && cond != 0x0F)
+		return false;
+	return true;
+}
+
+/******************************************************************************
+*                           AGC_TAB_1T.TXT
+******************************************************************************/
+
+static u32 array_agc_tab_1t_8188e[] = {
+		0xC78, 0xFB000001,
+		0xC78, 0xFB010001,
+		0xC78, 0xFB020001,
+		0xC78, 0xFB030001,
+		0xC78, 0xFB040001,
+		0xC78, 0xFB050001,
+		0xC78, 0xFA060001,
+		0xC78, 0xF9070001,
+		0xC78, 0xF8080001,
+		0xC78, 0xF7090001,
+		0xC78, 0xF60A0001,
+		0xC78, 0xF50B0001,
+		0xC78, 0xF40C0001,
+		0xC78, 0xF30D0001,
+		0xC78, 0xF20E0001,
+		0xC78, 0xF10F0001,
+		0xC78, 0xF0100001,
+		0xC78, 0xEF110001,
+		0xC78, 0xEE120001,
+		0xC78, 0xED130001,
+		0xC78, 0xEC140001,
+		0xC78, 0xEB150001,
+		0xC78, 0xEA160001,
+		0xC78, 0xE9170001,
+		0xC78, 0xE8180001,
+		0xC78, 0xE7190001,
+		0xC78, 0xE61A0001,
+		0xC78, 0xE51B0001,
+		0xC78, 0xE41C0001,
+		0xC78, 0xE31D0001,
+		0xC78, 0xE21E0001,
+		0xC78, 0xE11F0001,
+		0xC78, 0x8A200001,
+		0xC78, 0x89210001,
+		0xC78, 0x88220001,
+		0xC78, 0x87230001,
+		0xC78, 0x86240001,
+		0xC78, 0x85250001,
+		0xC78, 0x84260001,
+		0xC78, 0x83270001,
+		0xC78, 0x82280001,
+		0xC78, 0x6B290001,
+		0xC78, 0x6A2A0001,
+		0xC78, 0x692B0001,
+		0xC78, 0x682C0001,
+		0xC78, 0x672D0001,
+		0xC78, 0x662E0001,
+		0xC78, 0x652F0001,
+		0xC78, 0x64300001,
+		0xC78, 0x63310001,
+		0xC78, 0x62320001,
+		0xC78, 0x61330001,
+		0xC78, 0x46340001,
+		0xC78, 0x45350001,
+		0xC78, 0x44360001,
+		0xC78, 0x43370001,
+		0xC78, 0x42380001,
+		0xC78, 0x41390001,
+		0xC78, 0x403A0001,
+		0xC78, 0x403B0001,
+		0xC78, 0x403C0001,
+		0xC78, 0x403D0001,
+		0xC78, 0x403E0001,
+		0xC78, 0x403F0001,
+		0xC78, 0xFB400001,
+		0xC78, 0xFB410001,
+		0xC78, 0xFB420001,
+		0xC78, 0xFB430001,
+		0xC78, 0xFB440001,
+		0xC78, 0xFB450001,
+		0xC78, 0xFB460001,
+		0xC78, 0xFB470001,
+		0xC78, 0xFB480001,
+		0xC78, 0xFA490001,
+		0xC78, 0xF94A0001,
+		0xC78, 0xF84B0001,
+		0xC78, 0xF74C0001,
+		0xC78, 0xF64D0001,
+		0xC78, 0xF54E0001,
+		0xC78, 0xF44F0001,
+		0xC78, 0xF3500001,
+		0xC78, 0xF2510001,
+		0xC78, 0xF1520001,
+		0xC78, 0xF0530001,
+		0xC78, 0xEF540001,
+		0xC78, 0xEE550001,
+		0xC78, 0xED560001,
+		0xC78, 0xEC570001,
+		0xC78, 0xEB580001,
+		0xC78, 0xEA590001,
+		0xC78, 0xE95A0001,
+		0xC78, 0xE85B0001,
+		0xC78, 0xE75C0001,
+		0xC78, 0xE65D0001,
+		0xC78, 0xE55E0001,
+		0xC78, 0xE45F0001,
+		0xC78, 0xE3600001,
+		0xC78, 0xE2610001,
+		0xC78, 0xC3620001,
+		0xC78, 0xC2630001,
+		0xC78, 0xC1640001,
+		0xC78, 0x8B650001,
+		0xC78, 0x8A660001,
+		0xC78, 0x89670001,
+		0xC78, 0x88680001,
+		0xC78, 0x87690001,
+		0xC78, 0x866A0001,
+		0xC78, 0x856B0001,
+		0xC78, 0x846C0001,
+		0xC78, 0x676D0001,
+		0xC78, 0x666E0001,
+		0xC78, 0x656F0001,
+		0xC78, 0x64700001,
+		0xC78, 0x63710001,
+		0xC78, 0x62720001,
+		0xC78, 0x61730001,
+		0xC78, 0x60740001,
+		0xC78, 0x46750001,
+		0xC78, 0x45760001,
+		0xC78, 0x44770001,
+		0xC78, 0x43780001,
+		0xC78, 0x42790001,
+		0xC78, 0x417A0001,
+		0xC78, 0x407B0001,
+		0xC78, 0x407C0001,
+		0xC78, 0x407D0001,
+		0xC78, 0x407E0001,
+		0xC78, 0x407F0001,
+};
+
+enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
+{
+	u32     hex         = 0;
+	u32     i           = 0;
+	u8     platform    = dm_odm->SupportPlatform;
+	u8     interfaceValue   = dm_odm->SupportInterface;
+	u8     board       = dm_odm->BoardType;
+	u32     arraylen    = sizeof(array_agc_tab_1t_8188e)/sizeof(u32);
+	u32    *array       = array_agc_tab_1t_8188e;
+	bool		biol = false;
+	struct adapter *adapter =  dm_odm->Adapter;
+	struct xmit_frame *pxmit_frame = NULL;
+	u8 bndy_cnt = 1;
+	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
+
+	hex += board;
+	hex += interfaceValue << 8;
+	hex += platform << 16;
+	hex += 0xFF000000;
+	biol = rtw_IOL_applied(adapter);
+
+	if (biol) {
+		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
+		if (pxmit_frame == NULL) {
+			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			return HAL_STATUS_FAILURE;
+		}
+	}
+
+	for (i = 0; i < arraylen; i += 2) {
+		u32 v1 = array[i];
+		u32 v2 = array[i+1];
+
+		/*  This (offset, data) pair meets the condition. */
+		if (v1 < 0xCDCDCDCD) {
+			if (biol) {
+				if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+					bndy_cnt++;
+				rtw_IOL_append_WD_cmd(pxmit_frame, (u16)v1, v2, bMaskDWord);
+			} else {
+				odm_ConfigBB_AGC_8188E(dm_odm, v1, bMaskDWord, v2);
+			}
+			continue;
+		} else {
+			/*  This line is the start line of branch. */
+			if (!CheckCondition(array[i], hex)) {
+				/*  Discard the following (offset, data) pairs. */
+				read_next_pair(array, v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < arraylen - 2)
+					read_next_pair(array, v1, v2, i);
+				i -= 2; /*  prevent from for-loop += 2 */
+			} else { /*  Configure matched pairs and skip to end of if-else. */
+				read_next_pair(array, v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < arraylen - 2) {
+					if (biol) {
+						if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+							bndy_cnt++;
+						rtw_IOL_append_WD_cmd(pxmit_frame, (u16)v1, v2, bMaskDWord);
+					} else {
+						odm_ConfigBB_AGC_8188E(dm_odm, v1, bMaskDWord, v2);
+					}
+					read_next_pair(array, v1, v2, i);
+				}
+
+				while (v2 != 0xDEAD && i < arraylen - 2)
+					read_next_pair(array, v1, v2, i);
+			}
+		}
+	}
+	if (biol) {
+		if (!rtw_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+			printk("~~~ %s IOL_exec_cmds Failed !!!\n", __func__);
+			rst = HAL_STATUS_FAILURE;
+		}
+	}
+	return rst;
+}
+
+/******************************************************************************
+*                           PHY_REG_1T.TXT
+******************************************************************************/
+
+static u32 array_phy_reg_1t_8188e[] = {
+		0x800, 0x80040000,
+		0x804, 0x00000003,
+		0x808, 0x0000FC00,
+		0x80C, 0x0000000A,
+		0x810, 0x10001331,
+		0x814, 0x020C3D10,
+		0x818, 0x02200385,
+		0x81C, 0x00000000,
+		0x820, 0x01000100,
+		0x824, 0x00390204,
+		0x828, 0x00000000,
+		0x82C, 0x00000000,
+		0x830, 0x00000000,
+		0x834, 0x00000000,
+		0x838, 0x00000000,
+		0x83C, 0x00000000,
+		0x840, 0x00010000,
+		0x844, 0x00000000,
+		0x848, 0x00000000,
+		0x84C, 0x00000000,
+		0x850, 0x00000000,
+		0x854, 0x00000000,
+		0x858, 0x569A11A9,
+		0x85C, 0x01000014,
+		0x860, 0x66F60110,
+		0x864, 0x061F0649,
+		0x868, 0x00000000,
+		0x86C, 0x27272700,
+		0x870, 0x07000760,
+		0x874, 0x25004000,
+		0x878, 0x00000808,
+		0x87C, 0x00000000,
+		0x880, 0xB0000C1C,
+		0x884, 0x00000001,
+		0x888, 0x00000000,
+		0x88C, 0xCCC000C0,
+		0x890, 0x00000800,
+		0x894, 0xFFFFFFFE,
+		0x898, 0x40302010,
+		0x89C, 0x00706050,
+		0x900, 0x00000000,
+		0x904, 0x00000023,
+		0x908, 0x00000000,
+		0x90C, 0x81121111,
+		0x910, 0x00000002,
+		0x914, 0x00000201,
+		0xA00, 0x00D047C8,
+		0xA04, 0x80FF000C,
+		0xA08, 0x8C838300,
+		0xA0C, 0x2E7F120F,
+		0xA10, 0x9500BB78,
+		0xA14, 0x1114D028,
+		0xA18, 0x00881117,
+		0xA1C, 0x89140F00,
+		0xA20, 0x1A1B0000,
+		0xA24, 0x090E1317,
+		0xA28, 0x00000204,
+		0xA2C, 0x00D30000,
+		0xA70, 0x101FBF00,
+		0xA74, 0x00000007,
+		0xA78, 0x00000900,
+		0xA7C, 0x225B0606,
+		0xA80, 0x218075B1,
+		0xB2C, 0x80000000,
+		0xC00, 0x48071D40,
+		0xC04, 0x03A05611,
+		0xC08, 0x000000E4,
+		0xC0C, 0x6C6C6C6C,
+		0xC10, 0x08800000,
+		0xC14, 0x40000100,
+		0xC18, 0x08800000,
+		0xC1C, 0x40000100,
+		0xC20, 0x00000000,
+		0xC24, 0x00000000,
+		0xC28, 0x00000000,
+		0xC2C, 0x00000000,
+		0xC30, 0x69E9AC47,
+		0xC34, 0x469652AF,
+		0xC38, 0x49795994,
+		0xC3C, 0x0A97971C,
+		0xC40, 0x1F7C403F,
+		0xC44, 0x000100B7,
+		0xC48, 0xEC020107,
+		0xC4C, 0x007F037F,
+		0xC50, 0x69553420,
+		0xC54, 0x43BC0094,
+		0xC58, 0x00013169,
+		0xC5C, 0x00250492,
+		0xC60, 0x00000000,
+		0xC64, 0x7112848B,
+		0xC68, 0x47C00BFF,
+		0xC6C, 0x00000036,
+		0xC70, 0x2C7F000D,
+		0xC74, 0x020610DB,
+		0xC78, 0x0000001F,
+		0xC7C, 0x00B91612,
+		0xC80, 0x390000E4,
+		0xC84, 0x20F60000,
+		0xC88, 0x40000100,
+		0xC8C, 0x20200000,
+		0xC90, 0x00091521,
+		0xC94, 0x00000000,
+		0xC98, 0x00121820,
+		0xC9C, 0x00007F7F,
+		0xCA0, 0x00000000,
+		0xCA4, 0x000300A0,
+		0xCA8, 0x00000000,
+		0xCAC, 0x00000000,
+		0xCB0, 0x00000000,
+		0xCB4, 0x00000000,
+		0xCB8, 0x00000000,
+		0xCBC, 0x28000000,
+		0xCC0, 0x00000000,
+		0xCC4, 0x00000000,
+		0xCC8, 0x00000000,
+		0xCCC, 0x00000000,
+		0xCD0, 0x00000000,
+		0xCD4, 0x00000000,
+		0xCD8, 0x64B22427,
+		0xCDC, 0x00766932,
+		0xCE0, 0x00222222,
+		0xCE4, 0x00000000,
+		0xCE8, 0x37644302,
+		0xCEC, 0x2F97D40C,
+		0xD00, 0x00000740,
+		0xD04, 0x00020401,
+		0xD08, 0x0000907F,
+		0xD0C, 0x20010201,
+		0xD10, 0xA0633333,
+		0xD14, 0x3333BC43,
+		0xD18, 0x7A8F5B6F,
+		0xD2C, 0xCC979975,
+		0xD30, 0x00000000,
+		0xD34, 0x80608000,
+		0xD38, 0x00000000,
+		0xD3C, 0x00127353,
+		0xD40, 0x00000000,
+		0xD44, 0x00000000,
+		0xD48, 0x00000000,
+		0xD4C, 0x00000000,
+		0xD50, 0x6437140A,
+		0xD54, 0x00000000,
+		0xD58, 0x00000282,
+		0xD5C, 0x30032064,
+		0xD60, 0x4653DE68,
+		0xD64, 0x04518A3C,
+		0xD68, 0x00002101,
+		0xD6C, 0x2A201C16,
+		0xD70, 0x1812362E,
+		0xD74, 0x322C2220,
+		0xD78, 0x000E3C24,
+		0xE00, 0x2D2D2D2D,
+		0xE04, 0x2D2D2D2D,
+		0xE08, 0x0390272D,
+		0xE10, 0x2D2D2D2D,
+		0xE14, 0x2D2D2D2D,
+		0xE18, 0x2D2D2D2D,
+		0xE1C, 0x2D2D2D2D,
+		0xE28, 0x00000000,
+		0xE30, 0x1000DC1F,
+		0xE34, 0x10008C1F,
+		0xE38, 0x02140102,
+		0xE3C, 0x681604C2,
+		0xE40, 0x01007C00,
+		0xE44, 0x01004800,
+		0xE48, 0xFB000000,
+		0xE4C, 0x000028D1,
+		0xE50, 0x1000DC1F,
+		0xE54, 0x10008C1F,
+		0xE58, 0x02140102,
+		0xE5C, 0x28160D05,
+		0xE60, 0x00000008,
+		0xE68, 0x001B25A4,
+		0xE6C, 0x00C00014,
+		0xE70, 0x00C00014,
+		0xE74, 0x01000014,
+		0xE78, 0x01000014,
+		0xE7C, 0x01000014,
+		0xE80, 0x01000014,
+		0xE84, 0x00C00014,
+		0xE88, 0x01000014,
+		0xE8C, 0x00C00014,
+		0xED0, 0x00C00014,
+		0xED4, 0x00C00014,
+		0xED8, 0x00C00014,
+		0xEDC, 0x00000014,
+		0xEE0, 0x00000014,
+		0xEEC, 0x01C00014,
+		0xF14, 0x00000003,
+		0xF4C, 0x00000000,
+		0xF00, 0x00000300,
+};
+
+enum HAL_STATUS ODM_ReadAndConfig_PHY_REG_1T_8188E(struct odm_dm_struct *dm_odm)
+{
+	u32     hex         = 0;
+	u32     i           = 0;
+	u8     platform    = dm_odm->SupportPlatform;
+	u8     interfaceValue   = dm_odm->SupportInterface;
+	u8     board       = dm_odm->BoardType;
+	u32     arraylen    = sizeof(array_phy_reg_1t_8188e)/sizeof(u32);
+	u32    *array       = array_phy_reg_1t_8188e;
+	bool	biol = false;
+	struct adapter *adapter =  dm_odm->Adapter;
+	struct xmit_frame *pxmit_frame = NULL;
+	u8 bndy_cnt = 1;
+	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
+	hex += board;
+	hex += interfaceValue << 8;
+	hex += platform << 16;
+	hex += 0xFF000000;
+	biol = rtw_IOL_applied(adapter);
+
+	if (biol) {
+		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapter);
+		if (pxmit_frame == NULL) {
+			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			return HAL_STATUS_FAILURE;
+		}
+	}
+
+	for (i = 0; i < arraylen; i += 2) {
+		u32 v1 = array[i];
+		u32 v2 = array[i+1];
+
+		/*  This (offset, data) pair meets the condition. */
+		if (v1 < 0xCDCDCDCD) {
+			if (biol) {
+				if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+					bndy_cnt++;
+				if (v1 == 0xfe) {
+					rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 50);
+				} else if (v1 == 0xfd) {
+					rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 5);
+				} else if (v1 == 0xfc) {
+					rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 1);
+				} else if (v1 == 0xfb) {
+					rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 50);
+				} else if (v1 == 0xfa) {
+					rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 5);
+				} else if (v1 == 0xf9) {
+					rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 1);
+				} else {
+					if (v1 == 0xa24)
+						dm_odm->RFCalibrateInfo.RegA24 = v2;
+					rtw_IOL_append_WD_cmd(pxmit_frame, (u16)v1, v2, bMaskDWord);
+				}
+			} else {
+				odm_ConfigBB_PHY_8188E(dm_odm, v1, bMaskDWord, v2);
+			}
+			continue;
+		} else { /*  This line is the start line of branch. */
+			if (!CheckCondition(array[i], hex)) {
+				/*  Discard the following (offset, data) pairs. */
+				read_next_pair(array, v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < arraylen - 2)
+					read_next_pair(array, v1, v2, i);
+				i -= 2; /*  prevent from for-loop += 2 */
+			} else { /*  Configure matched pairs and skip to end of if-else. */
+				read_next_pair(array, v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < arraylen - 2) {
+					if (biol) {
+						if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+							bndy_cnt++;
+						if (v1 == 0xfe) {
+							rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 50);
+						} else if (v1 == 0xfd) {
+							rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 5);
+						} else if (v1 == 0xfc) {
+							rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 1);
+						} else if (v1 == 0xfb) {
+							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 50);
+						} else if (v1 == 0xfa) {
+							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 5);
+						} else if (v1 == 0xf9) {
+							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 1);
+						} else{
+							if (v1 == 0xa24)
+								dm_odm->RFCalibrateInfo.RegA24 = v2;
+
+							rtw_IOL_append_WD_cmd(pxmit_frame, (u16)v1, v2, bMaskDWord);
+						}
+					} else {
+						odm_ConfigBB_PHY_8188E(dm_odm, v1, bMaskDWord, v2);
+					}
+					read_next_pair(array, v1, v2, i);
+				}
+
+				while (v2 != 0xDEAD && i < arraylen - 2)
+					read_next_pair(array, v1, v2, i);
+			}
+		}
+	}
+	if (biol) {
+		if (!rtw_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+			rst = HAL_STATUS_FAILURE;
+			pr_info("~~~ IOL Config %s Failed !!!\n", __func__);
+		}
+	}
+	return rst;
+}
+
+/******************************************************************************
+*                           PHY_REG_PG.TXT
+******************************************************************************/
+
+static u32 array_phy_reg_pg_8188e[] = {
+		0xE00, 0xFFFFFFFF, 0x06070809,
+		0xE04, 0xFFFFFFFF, 0x02020405,
+		0xE08, 0x0000FF00, 0x00000006,
+		0x86C, 0xFFFFFF00, 0x00020400,
+		0xE10, 0xFFFFFFFF, 0x08090A0B,
+		0xE14, 0xFFFFFFFF, 0x01030607,
+		0xE18, 0xFFFFFFFF, 0x08090A0B,
+		0xE1C, 0xFFFFFFFF, 0x01030607,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x02020202,
+		0xE04, 0xFFFFFFFF, 0x00020202,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x04040404,
+		0xE14, 0xFFFFFFFF, 0x00020404,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x02020202,
+		0xE04, 0xFFFFFFFF, 0x00020202,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x04040404,
+		0xE14, 0xFFFFFFFF, 0x00020404,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x02020202,
+		0xE04, 0xFFFFFFFF, 0x00020202,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x04040404,
+		0xE14, 0xFFFFFFFF, 0x00020404,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+		0xE00, 0xFFFFFFFF, 0x00000000,
+		0xE04, 0xFFFFFFFF, 0x00000000,
+		0xE08, 0x0000FF00, 0x00000000,
+		0x86C, 0xFFFFFF00, 0x00000000,
+		0xE10, 0xFFFFFFFF, 0x00000000,
+		0xE14, 0xFFFFFFFF, 0x00000000,
+		0xE18, 0xFFFFFFFF, 0x00000000,
+		0xE1C, 0xFFFFFFFF, 0x00000000,
+
+};
+
+void ODM_ReadAndConfig_PHY_REG_PG_8188E(struct odm_dm_struct *dm_odm)
+{
+	u32  hex;
+	u32  i           = 0;
+	u8  platform    = dm_odm->SupportPlatform;
+	u8  interfaceValue   = dm_odm->SupportInterface;
+	u8  board       = dm_odm->BoardType;
+	u32  arraylen    = sizeof(array_phy_reg_pg_8188e) / sizeof(u32);
+	u32 *array       = array_phy_reg_pg_8188e;
+
+	hex = board + (interfaceValue << 8);
+	hex += (platform << 16) + 0xFF000000;
+
+	for (i = 0; i < arraylen; i += 3) {
+		u32 v1 = array[i];
+		u32 v2 = array[i+1];
+		u32 v3 = array[i+2];
+
+		/*  this line is a line of pure_body */
+		if (v1 < 0xCDCDCDCD) {
+			odm_ConfigBB_PHY_REG_PG_8188E(dm_odm, v1, v2, v3);
+			continue;
+		} else { /*  this line is the start of branch */
+			if (!CheckCondition(array[i], hex)) {
+				/*  don't need the hw_body */
+				i += 2; /*  skip the pair of expression */
+				v1 = array[i];
+				v2 = array[i+1];
+				v3 = array[i+2];
+				while (v2 != 0xDEAD) {
+					i += 3;
+					v1 = array[i];
+					v2 = array[i+1];
+					v3 = array[i+1];
+				}
+			}
+		}
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
new file mode 100644
index 000000000000..bac0238e314c
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c
@@ -0,0 +1,230 @@
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
+#include "odm_precomp.h"
+#include <rtw_iol.h>
+
+static bool Checkcondition(const u32  condition, const u32  hex)
+{
+	u32 _board     = (hex & 0x000000FF);
+	u32 _interface = (hex & 0x0000FF00) >> 8;
+	u32 _platform  = (hex & 0x00FF0000) >> 16;
+	u32 cond = condition;
+
+	if (condition == 0xCDCDCDCD)
+		return true;
+
+	cond = condition & 0x000000FF;
+	if ((_board == cond) && cond != 0x00)
+		return false;
+
+	cond = condition & 0x0000FF00;
+	cond = cond >> 8;
+	if ((_interface & cond) == 0 && cond != 0x07)
+		return false;
+
+	cond = condition & 0x00FF0000;
+	cond = cond >> 16;
+	if ((_platform & cond) == 0 && cond != 0x0F)
+		return false;
+	return true;
+}
+
+/******************************************************************************
+*                           MAC_REG.TXT
+******************************************************************************/
+
+static u32 array_MAC_REG_8188E[] = {
+		0x026, 0x00000041,
+		0x027, 0x00000035,
+		0x428, 0x0000000A,
+		0x429, 0x00000010,
+		0x430, 0x00000000,
+		0x431, 0x00000001,
+		0x432, 0x00000002,
+		0x433, 0x00000004,
+		0x434, 0x00000005,
+		0x435, 0x00000006,
+		0x436, 0x00000007,
+		0x437, 0x00000008,
+		0x438, 0x00000000,
+		0x439, 0x00000000,
+		0x43A, 0x00000001,
+		0x43B, 0x00000002,
+		0x43C, 0x00000004,
+		0x43D, 0x00000005,
+		0x43E, 0x00000006,
+		0x43F, 0x00000007,
+		0x440, 0x0000005D,
+		0x441, 0x00000001,
+		0x442, 0x00000000,
+		0x444, 0x00000015,
+		0x445, 0x000000F0,
+		0x446, 0x0000000F,
+		0x447, 0x00000000,
+		0x458, 0x00000041,
+		0x459, 0x000000A8,
+		0x45A, 0x00000072,
+		0x45B, 0x000000B9,
+		0x460, 0x00000066,
+		0x461, 0x00000066,
+		0x480, 0x00000008,
+		0x4C8, 0x000000FF,
+		0x4C9, 0x00000008,
+		0x4CC, 0x000000FF,
+		0x4CD, 0x000000FF,
+		0x4CE, 0x00000001,
+		0x4D3, 0x00000001,
+		0x500, 0x00000026,
+		0x501, 0x000000A2,
+		0x502, 0x0000002F,
+		0x503, 0x00000000,
+		0x504, 0x00000028,
+		0x505, 0x000000A3,
+		0x506, 0x0000005E,
+		0x507, 0x00000000,
+		0x508, 0x0000002B,
+		0x509, 0x000000A4,
+		0x50A, 0x0000005E,
+		0x50B, 0x00000000,
+		0x50C, 0x0000004F,
+		0x50D, 0x000000A4,
+		0x50E, 0x00000000,
+		0x50F, 0x00000000,
+		0x512, 0x0000001C,
+		0x514, 0x0000000A,
+		0x516, 0x0000000A,
+		0x525, 0x0000004F,
+		0x550, 0x00000010,
+		0x551, 0x00000010,
+		0x559, 0x00000002,
+		0x55D, 0x000000FF,
+		0x605, 0x00000030,
+		0x608, 0x0000000E,
+		0x609, 0x0000002A,
+		0x620, 0x000000FF,
+		0x621, 0x000000FF,
+		0x622, 0x000000FF,
+		0x623, 0x000000FF,
+		0x624, 0x000000FF,
+		0x625, 0x000000FF,
+		0x626, 0x000000FF,
+		0x627, 0x000000FF,
+		0x652, 0x00000020,
+		0x63C, 0x0000000A,
+		0x63D, 0x0000000A,
+		0x63E, 0x0000000E,
+		0x63F, 0x0000000E,
+		0x640, 0x00000040,
+		0x66E, 0x00000005,
+		0x700, 0x00000021,
+		0x701, 0x00000043,
+		0x702, 0x00000065,
+		0x703, 0x00000087,
+		0x708, 0x00000021,
+		0x709, 0x00000043,
+		0x70A, 0x00000065,
+		0x70B, 0x00000087,
+};
+
+enum HAL_STATUS ODM_ReadAndConfig_MAC_REG_8188E(struct odm_dm_struct *dm_odm)
+{
+	#define READ_NEXT_PAIR(v1, v2, i) do { i += 2; v1 = array[i]; v2 = array[i+1]; } while (0)
+
+	u32     hex         = 0;
+	u32     i;
+	u8     platform    = dm_odm->SupportPlatform;
+	u8     interface_val   = dm_odm->SupportInterface;
+	u8     board       = dm_odm->BoardType;
+	u32     array_len    = sizeof(array_MAC_REG_8188E)/sizeof(u32);
+	u32    *array       = array_MAC_REG_8188E;
+	bool	biol = false;
+
+	struct adapter *adapt =  dm_odm->Adapter;
+	struct xmit_frame	*pxmit_frame = NULL;
+	u8 bndy_cnt = 1;
+	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
+	hex += board;
+	hex += interface_val << 8;
+	hex += platform << 16;
+	hex += 0xFF000000;
+
+	biol = rtw_IOL_applied(adapt);
+
+	if (biol) {
+		pxmit_frame = rtw_IOL_accquire_xmit_frame(adapt);
+		if (pxmit_frame == NULL) {
+			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			return HAL_STATUS_FAILURE;
+		}
+	}
+
+	for (i = 0; i < array_len; i += 2) {
+		u32 v1 = array[i];
+		u32 v2 = array[i+1];
+
+		/*  This (offset, data) pair meets the condition. */
+		if (v1 < 0xCDCDCDCD) {
+				if (biol) {
+					if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+						bndy_cnt++;
+					rtw_IOL_append_WB_cmd(pxmit_frame, (u16)v1, (u8)v2, 0xFF);
+				} else {
+					odm_ConfigMAC_8188E(dm_odm, v1, (u8)v2);
+				}
+				continue;
+		} else { /*  This line is the start line of branch. */
+			if (!Checkcondition(array[i], hex)) {
+				/*  Discard the following (offset, data) pairs. */
+				READ_NEXT_PAIR(v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < array_len - 2) {
+					READ_NEXT_PAIR(v1, v2, i);
+				}
+				i -= 2; /*  prevent from for-loop += 2 */
+			} else { /*  Configure matched pairs and skip to end of if-else. */
+				READ_NEXT_PAIR(v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < array_len - 2) {
+					if (biol) {
+						if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+							bndy_cnt++;
+						rtw_IOL_append_WB_cmd(pxmit_frame, (u16)v1, (u8)v2, 0xFF);
+					} else {
+						odm_ConfigMAC_8188E(dm_odm, v1, (u8)v2);
+					}
+
+					READ_NEXT_PAIR(v1, v2, i);
+				}
+				while (v2 != 0xDEAD && i < array_len - 2)
+					READ_NEXT_PAIR(v1, v2, i);
+			}
+		}
+	}
+	if (biol) {
+		if (!rtw_IOL_exec_cmds_sync(dm_odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+			pr_info("~~~ MAC IOL_exec_cmds Failed !!!\n");
+			rst = HAL_STATUS_FAILURE;
+		}
+	}
+	return rst;
+}
diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
new file mode 100644
index 000000000000..b5d5050c0a17
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c
@@ -0,0 +1,268 @@
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
+#include "odm_precomp.h"
+
+#include <rtw_iol.h>
+
+static bool CheckCondition(const u32  Condition, const u32  Hex)
+{
+	u32 _board     = (Hex & 0x000000FF);
+	u32 _interface = (Hex & 0x0000FF00) >> 8;
+	u32 _platform  = (Hex & 0x00FF0000) >> 16;
+	u32 cond = Condition;
+
+	if (Condition == 0xCDCDCDCD)
+		return true;
+
+	cond = Condition & 0x000000FF;
+	if ((_board == cond) && cond != 0x00)
+		return false;
+
+	cond = Condition & 0x0000FF00;
+	cond = cond >> 8;
+	if ((_interface & cond) == 0 && cond != 0x07)
+		return false;
+
+	cond = Condition & 0x00FF0000;
+	cond = cond >> 16;
+	if ((_platform & cond) == 0 && cond != 0x0F)
+		return false;
+	return true;
+}
+
+/******************************************************************************
+*                           RadioA_1T.TXT
+******************************************************************************/
+
+static u32 Array_RadioA_1T_8188E[] = {
+		0x000, 0x00030000,
+		0x008, 0x00084000,
+		0x018, 0x00000407,
+		0x019, 0x00000012,
+		0x01E, 0x00080009,
+		0x01F, 0x00000880,
+		0x02F, 0x0001A060,
+		0x03F, 0x00000000,
+		0x042, 0x000060C0,
+		0x057, 0x000D0000,
+		0x058, 0x000BE180,
+		0x067, 0x00001552,
+		0x083, 0x00000000,
+		0x0B0, 0x000FF8FC,
+		0x0B1, 0x00054400,
+		0x0B2, 0x000CCC19,
+		0x0B4, 0x00043003,
+		0x0B6, 0x0004953E,
+		0x0B7, 0x0001C718,
+		0x0B8, 0x000060FF,
+		0x0B9, 0x00080001,
+		0x0BA, 0x00040000,
+		0x0BB, 0x00000400,
+		0x0BF, 0x000C0000,
+		0x0C2, 0x00002400,
+		0x0C3, 0x00000009,
+		0x0C4, 0x00040C91,
+		0x0C5, 0x00099999,
+		0x0C6, 0x000000A3,
+		0x0C7, 0x00088820,
+		0x0C8, 0x00076C06,
+		0x0C9, 0x00000000,
+		0x0CA, 0x00080000,
+		0x0DF, 0x00000180,
+		0x0EF, 0x000001A0,
+		0x051, 0x0006B27D,
+		0xFF0F041F, 0xABCD,
+		0x052, 0x0007E4DD,
+		0xCDCDCDCD, 0xCDCD,
+		0x052, 0x0007E49D,
+		0xFF0F041F, 0xDEAD,
+		0x053, 0x00000073,
+		0x056, 0x00051FF3,
+		0x035, 0x00000086,
+		0x035, 0x00000186,
+		0x035, 0x00000286,
+		0x036, 0x00001C25,
+		0x036, 0x00009C25,
+		0x036, 0x00011C25,
+		0x036, 0x00019C25,
+		0x0B6, 0x00048538,
+		0x018, 0x00000C07,
+		0x05A, 0x0004BD00,
+		0x019, 0x000739D0,
+		0x034, 0x0000ADF3,
+		0x034, 0x00009DF0,
+		0x034, 0x00008DED,
+		0x034, 0x00007DEA,
+		0x034, 0x00006DE7,
+		0x034, 0x000054EE,
+		0x034, 0x000044EB,
+		0x034, 0x000034E8,
+		0x034, 0x0000246B,
+		0x034, 0x00001468,
+		0x034, 0x0000006D,
+		0x000, 0x00030159,
+		0x084, 0x00068200,
+		0x086, 0x000000CE,
+		0x087, 0x00048A00,
+		0x08E, 0x00065540,
+		0x08F, 0x00088000,
+		0x0EF, 0x000020A0,
+		0x03B, 0x000F02B0,
+		0x03B, 0x000EF7B0,
+		0x03B, 0x000D4FB0,
+		0x03B, 0x000CF060,
+		0x03B, 0x000B0090,
+		0x03B, 0x000A0080,
+		0x03B, 0x00090080,
+		0x03B, 0x0008F780,
+		0x03B, 0x000722B0,
+		0x03B, 0x0006F7B0,
+		0x03B, 0x00054FB0,
+		0x03B, 0x0004F060,
+		0x03B, 0x00030090,
+		0x03B, 0x00020080,
+		0x03B, 0x00010080,
+		0x03B, 0x0000F780,
+		0x0EF, 0x000000A0,
+		0x000, 0x00010159,
+		0x018, 0x0000F407,
+		0xFFE, 0x00000000,
+		0xFFE, 0x00000000,
+		0x01F, 0x00080003,
+		0xFFE, 0x00000000,
+		0xFFE, 0x00000000,
+		0x01E, 0x00000001,
+		0x01F, 0x00080000,
+		0x000, 0x00033E60,
+};
+
+enum HAL_STATUS ODM_ReadAndConfig_RadioA_1T_8188E(struct odm_dm_struct *pDM_Odm)
+{
+	#define READ_NEXT_PAIR(v1, v2, i) do	\
+		 { i += 2; v1 = Array[i];	\
+		 v2 = Array[i+1]; } while (0)
+
+	u32     hex         = 0;
+	u32     i           = 0;
+	u8     platform    = pDM_Odm->SupportPlatform;
+	u8     interfaceValue   = pDM_Odm->SupportInterface;
+	u8     board       = pDM_Odm->BoardType;
+	u32     ArrayLen    = sizeof(Array_RadioA_1T_8188E)/sizeof(u32);
+	u32    *Array       = Array_RadioA_1T_8188E;
+	bool		biol = false;
+	struct adapter *Adapter =  pDM_Odm->Adapter;
+	struct xmit_frame *pxmit_frame = NULL;
+	u8 bndy_cnt = 1;
+	enum HAL_STATUS rst = HAL_STATUS_SUCCESS;
+
+	hex += board;
+	hex += interfaceValue << 8;
+	hex += platform << 16;
+	hex += 0xFF000000;
+	biol = rtw_IOL_applied(Adapter);
+
+	if (biol) {
+		pxmit_frame = rtw_IOL_accquire_xmit_frame(Adapter);
+		if (pxmit_frame == NULL) {
+			pr_info("rtw_IOL_accquire_xmit_frame failed\n");
+			return HAL_STATUS_FAILURE;
+		}
+	}
+
+	for (i = 0; i < ArrayLen; i += 2) {
+		u32 v1 = Array[i];
+		u32 v2 = Array[i+1];
+
+		/*  This (offset, data) pair meets the condition. */
+		if (v1 < 0xCDCDCDCD) {
+			if (biol) {
+				if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+					bndy_cnt++;
+
+				if (v1 == 0xffe)
+					rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 50);
+				else if (v1 == 0xfd)
+					rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 5);
+				else if (v1 == 0xfc)
+					rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 1);
+				else if (v1 == 0xfb)
+					rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 50);
+				else if (v1 == 0xfa)
+					rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 5);
+				else if (v1 == 0xf9)
+					rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 1);
+				else
+					rtw_IOL_append_WRF_cmd(pxmit_frame, RF_PATH_A, (u16)v1, v2, bRFRegOffsetMask);
+			} else {
+				odm_ConfigRF_RadioA_8188E(pDM_Odm, v1, v2);
+			}
+		    continue;
+		} else { /*  This line is the start line of branch. */
+			if (!CheckCondition(Array[i], hex)) {
+				/*  Discard the following (offset, data) pairs. */
+				READ_NEXT_PAIR(v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < ArrayLen - 2)
+					READ_NEXT_PAIR(v1, v2, i);
+				i -= 2; /*  prevent from for-loop += 2 */
+			} else { /*  Configure matched pairs and skip to end of if-else. */
+			READ_NEXT_PAIR(v1, v2, i);
+				while (v2 != 0xDEAD &&
+				       v2 != 0xCDEF &&
+				       v2 != 0xCDCD && i < ArrayLen - 2) {
+					if (biol) {
+						if (rtw_IOL_cmd_boundary_handle(pxmit_frame))
+							bndy_cnt++;
+
+						if (v1 == 0xffe)
+							rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 50);
+						else if (v1 == 0xfd)
+							rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 5);
+						else if (v1 == 0xfc)
+							rtw_IOL_append_DELAY_MS_cmd(pxmit_frame, 1);
+						else if (v1 == 0xfb)
+							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 50);
+						else if (v1 == 0xfa)
+							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 5);
+						else if (v1 == 0xf9)
+							rtw_IOL_append_DELAY_US_cmd(pxmit_frame, 1);
+						else
+							rtw_IOL_append_WRF_cmd(pxmit_frame, RF_PATH_A, (u16)v1, v2, bRFRegOffsetMask);
+					} else {
+						odm_ConfigRF_RadioA_8188E(pDM_Odm, v1, v2);
+					}
+					READ_NEXT_PAIR(v1, v2, i);
+				}
+
+				while (v2 != 0xDEAD && i < ArrayLen - 2)
+					READ_NEXT_PAIR(v1, v2, i);
+			}
+		}
+	}
+	if (biol) {
+		if (!rtw_IOL_exec_cmds_sync(pDM_Odm->Adapter, pxmit_frame, 1000, bndy_cnt)) {
+			rst = HAL_STATUS_FAILURE;
+			pr_info("~~~ IOL Config %s Failed !!!\n", __func__);
+		}
+	}
+	return rst;
+}
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf.c b/drivers/staging/r8188eu/hal/HalPhyRf.c
new file mode 100644
index 000000000000..980f7da8ab3b
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/HalPhyRf.c
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
+
+ #include "odm_precomp.h"
+
+/* 3============================================================ */
+/* 3 IQ Calibration */
+/* 3============================================================ */
+
+void ODM_ResetIQKResult(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+u8 ODM_GetRightChnlPlaceforIQK(u8 chnl)
+{
+	u8	channel_all[ODM_TARGET_CHNL_NUM_2G_5G] = {
+		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
+		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64,
+		100, 102, 104, 106, 108, 110, 112, 114, 116, 118, 120, 122,
+		124, 126, 128, 130, 132, 134, 136, 138, 140, 149, 151, 153,
+		155, 157, 159, 161, 163, 165
+	};
+	u8	place = chnl;
+
+	if (chnl > 14) {
+		for (place = 14; place < sizeof(channel_all); place++) {
+			if (channel_all[place] == chnl)
+				return place-13;
+		}
+	}
+	return 0;
+}
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
new file mode 100644
index 000000000000..8a7947d8de7f
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -0,0 +1,1505 @@
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
+#include "odm_precomp.h"
+
+/*---------------------------Define Local Constant---------------------------*/
+/*  2010/04/25 MH Define the max tx power tracking tx agc power. */
+#define		ODM_TXPWRTRACK_MAX_IDX_88E		6
+
+/*---------------------------Define Local Constant---------------------------*/
+
+/* 3============================================================ */
+/* 3 Tx Power Tracking */
+/* 3============================================================ */
+/*-----------------------------------------------------------------------------
+ * Function:	ODM_TxPwrTrackAdjust88E()
+ *
+ * Overview:	88E we can not write 0xc80/c94/c4c/ 0xa2x. Instead of write TX agc.
+ *				No matter OFDM & CCK use the same method.
+ *
+ * Input:		NONE
+ *
+ * Output:		NONE
+ *
+ * Return:		NONE
+ *
+ * Revised History:
+ *	When		Who		Remark
+ *	04/23/2012	MHC		Create Version 0.
+ *	04/23/2012	MHC		Adjust TX agc directly not throughput BB digital.
+ *
+ *---------------------------------------------------------------------------*/
+void ODM_TxPwrTrackAdjust88E(struct odm_dm_struct *dm_odm, u8 Type,/*  0 = OFDM, 1 = CCK */
+	u8 *pDirection, 		/*  1 = +(increase) 2 = -(decrease) */
+	u32 *pOutWriteVal		/*  Tx tracking CCK/OFDM BB swing index adjust */
+	)
+{
+	u8 pwr_value = 0;
+	/*  Tx power tracking BB swing table. */
+	/*  The base index = 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB */
+	if (Type == 0) {		/*  For OFDM afjust */
+		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
+			     ("BbSwingIdxOfdm = %d BbSwingFlagOfdm=%d\n",
+			     dm_odm->BbSwingIdxOfdm, dm_odm->BbSwingFlagOfdm));
+
+		if (dm_odm->BbSwingIdxOfdm <= dm_odm->BbSwingIdxOfdmBase) {
+			*pDirection	= 1;
+			pwr_value		= (dm_odm->BbSwingIdxOfdmBase - dm_odm->BbSwingIdxOfdm);
+		} else {
+			*pDirection	= 2;
+			pwr_value		= (dm_odm->BbSwingIdxOfdm - dm_odm->BbSwingIdxOfdmBase);
+		}
+
+		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
+			     ("BbSwingIdxOfdm = %d BbSwingFlagOfdm=%d\n",
+			     dm_odm->BbSwingIdxOfdm, dm_odm->BbSwingFlagOfdm));
+	} else if (Type == 1) {	/*  For CCK adjust. */
+		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD,
+			     ("dm_odm->BbSwingIdxCck = %d dm_odm->BbSwingIdxCckBase = %d\n",
+			     dm_odm->BbSwingIdxCck, dm_odm->BbSwingIdxCckBase));
+
+		if (dm_odm->BbSwingIdxCck <= dm_odm->BbSwingIdxCckBase) {
+			*pDirection	= 1;
+			pwr_value		= (dm_odm->BbSwingIdxCckBase - dm_odm->BbSwingIdxCck);
+		} else {
+			*pDirection	= 2;
+			pwr_value		= (dm_odm->BbSwingIdxCck - dm_odm->BbSwingIdxCckBase);
+		}
+	}
+
+	/*  */
+	/*  2012/04/25 MH According to Ed/Luke.Lees estimate for EVM the max tx power tracking */
+	/*  need to be less than 6 power index for 88E. */
+	/*  */
+	if (pwr_value >= ODM_TXPWRTRACK_MAX_IDX_88E && *pDirection == 1)
+		pwr_value = ODM_TXPWRTRACK_MAX_IDX_88E;
+
+	*pOutWriteVal = pwr_value | (pwr_value<<8) | (pwr_value<<16) | (pwr_value<<24);
+}	/*  ODM_TxPwrTrackAdjust88E */
+
+/*-----------------------------------------------------------------------------
+ * Function:	odm_TxPwrTrackSetPwr88E()
+ *
+ * Overview:	88E change all channel tx power accordign to flag.
+ *				OFDM & CCK are all different.
+ *
+ * Input:		NONE
+ *
+ * Output:		NONE
+ *
+ * Return:		NONE
+ *
+ * Revised History:
+ *	When		Who		Remark
+ *	04/23/2012	MHC		Create Version 0.
+ *
+ *---------------------------------------------------------------------------*/
+static void odm_TxPwrTrackSetPwr88E(struct odm_dm_struct *dm_odm)
+{
+	if (dm_odm->BbSwingFlagOfdm || dm_odm->BbSwingFlagCck) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_TX_PWR_TRACK, ODM_DBG_LOUD, ("odm_TxPwrTrackSetPwr88E CH=%d\n", *(dm_odm->pChannel)));
+		PHY_SetTxPowerLevel8188E(dm_odm->Adapter, *(dm_odm->pChannel));
+		dm_odm->BbSwingFlagOfdm = false;
+		dm_odm->BbSwingFlagCck	= false;
+	}
+}	/*  odm_TxPwrTrackSetPwr88E */
+
+/* 091212 chiyokolin */
+void
+odm_TXPowerTrackingCallback_ThermalMeter_8188E(
+	struct adapter *Adapter
+	)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	u8 ThermalValue = 0, delta, delta_LCK, delta_IQK, offset;
+	u8 ThermalValue_AVG_count = 0;
+	u32 ThermalValue_AVG = 0;
+	s32 ele_A = 0, ele_D, TempCCk, X, value32;
+	s32 Y, ele_C = 0;
+	s8 OFDM_index[2], CCK_index = 0;
+	s8 OFDM_index_old[2] = {0, 0}, CCK_index_old = 0;
+	u32 i = 0, j = 0;
+	bool is2t = false;
+
+	u8 OFDM_min_index = 6, rf; /* OFDM BB Swing should be less than +3.0dB, which is required by Arthur */
+	u8 Indexforchannel = 0/*GetRightChnlPlaceforIQK(pHalData->CurrentChannel)*/;
+	s8 OFDM_index_mapping[2][index_mapping_NUM_88E] = {
+		{0, 0, 2, 3, 4, 4, 		/* 2.4G, decrease power */
+		5, 6, 7, 7, 8, 9,
+		10, 10, 11}, /*  For lower temperature, 20120220 updated on 20120220. */
+		{0, 0, -1, -2, -3, -4, 		/* 2.4G, increase power */
+		-4, -4, -4, -5, -7, -8,
+		-9, -9, -10},
+	};
+	u8 Thermal_mapping[2][index_mapping_NUM_88E] = {
+		{0, 2, 4, 6, 8, 10, 		/* 2.4G, decrease power */
+		12, 14, 16, 18, 20, 22,
+		24, 26, 27},
+		{0, 2, 4, 6, 8, 10, 		/* 2.4G,, increase power */
+		12, 14, 16, 18, 20, 22,
+		25, 25, 25},
+	};
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	/*  2012/04/25 MH Add for tx power tracking to set tx power in tx agc for 88E. */
+	odm_TxPwrTrackSetPwr88E(dm_odm);
+
+	dm_odm->RFCalibrateInfo.TXPowerTrackingCallbackCnt++; /* cosa add for debug */
+	dm_odm->RFCalibrateInfo.bTXPowerTrackingInit = true;
+
+	/*  <Kordan> RFCalibrateInfo.RegA24 will be initialized when ODM HW configuring, but MP configures with para files. */
+	dm_odm->RFCalibrateInfo.RegA24 = 0x090e1317;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("===>dm_TXPowerTrackingCallback_ThermalMeter_8188E txpowercontrol %d\n",
+		     dm_odm->RFCalibrateInfo.TxPowerTrackControl));
+
+	ThermalValue = (u8)ODM_GetRFReg(dm_odm, RF_PATH_A, RF_T_METER_88E, 0xfc00);	/* 0x42: RF Reg[15:10] 88E */
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("Readback Thermal Meter = 0x%x pre thermal meter 0x%x EEPROMthermalmeter 0x%x\n",
+		     ThermalValue, dm_odm->RFCalibrateInfo.ThermalValue, pHalData->EEPROMThermalMeter));
+
+	if (is2t)
+		rf = 2;
+	else
+		rf = 1;
+
+	if (ThermalValue) {
+		/* Query OFDM path A default setting */
+		ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XATxIQImbalance, bMaskDWord)&bMaskOFDM_D;
+		for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
+			if (ele_D == (OFDMSwingTable[i]&bMaskOFDM_D)) {
+				OFDM_index_old[0] = (u8)i;
+				dm_odm->BbSwingIdxOfdmBase = (u8)i;
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("Initial pathA ele_D reg0x%x = 0x%x, OFDM_index=0x%x\n",
+					     rOFDM0_XATxIQImbalance, ele_D, OFDM_index_old[0]));
+				break;
+			}
+		}
+
+		/* Query OFDM path B default setting */
+		if (is2t) {
+			ele_D = ODM_GetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord)&bMaskOFDM_D;
+			for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {	/* find the index */
+				if (ele_D == (OFDMSwingTable[i]&bMaskOFDM_D)) {
+					OFDM_index_old[1] = (u8)i;
+					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+						     ("Initial pathB ele_D reg0x%x = 0x%x, OFDM_index=0x%x\n",
+						rOFDM0_XBTxIQImbalance, ele_D, OFDM_index_old[1]));
+					break;
+				}
+			}
+		}
+
+		/* Query CCK default setting From 0xa24 */
+		TempCCk = dm_odm->RFCalibrateInfo.RegA24;
+
+		for (i = 0; i < CCK_TABLE_SIZE; i++) {
+			if (dm_odm->RFCalibrateInfo.bCCKinCH14) {
+				if (ODM_CompareMemory(dm_odm, (void *)&TempCCk, (void *)&CCKSwingTable_Ch14[i][2], 4) == 0) {
+					CCK_index_old = (u8)i;
+					dm_odm->BbSwingIdxCckBase = (u8)i;
+					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+						     ("Initial reg0x%x = 0x%x, CCK_index=0x%x, ch 14 %d\n",
+						     rCCK0_TxFilter2, TempCCk, CCK_index_old, dm_odm->RFCalibrateInfo.bCCKinCH14));
+					break;
+				}
+			} else {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("RegA24: 0x%X, CCKSwingTable_Ch1_Ch13[%d][2]: CCKSwingTable_Ch1_Ch13[i][2]: 0x%X\n",
+					     TempCCk, i, CCKSwingTable_Ch1_Ch13[i][2]));
+				if (ODM_CompareMemory(dm_odm, (void *)&TempCCk, (void *)&CCKSwingTable_Ch1_Ch13[i][2], 4) == 0) {
+					CCK_index_old = (u8)i;
+					dm_odm->BbSwingIdxCckBase = (u8)i;
+					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+						     ("Initial reg0x%x = 0x%x, CCK_index=0x%x, ch14 %d\n",
+						     rCCK0_TxFilter2, TempCCk, CCK_index_old, dm_odm->RFCalibrateInfo.bCCKinCH14));
+					break;
+				}
+			}
+		}
+
+		if (!dm_odm->RFCalibrateInfo.ThermalValue) {
+			dm_odm->RFCalibrateInfo.ThermalValue = pHalData->EEPROMThermalMeter;
+			dm_odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
+			dm_odm->RFCalibrateInfo.ThermalValue_IQK = ThermalValue;
+
+			for (i = 0; i < rf; i++)
+				dm_odm->RFCalibrateInfo.OFDM_index[i] = OFDM_index_old[i];
+			dm_odm->RFCalibrateInfo.CCK_index = CCK_index_old;
+		}
+
+		if (dm_odm->RFCalibrateInfo.bReloadtxpowerindex)
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+				     ("reload ofdm index for band switch\n"));
+
+		/* calculate average thermal meter */
+		dm_odm->RFCalibrateInfo.ThermalValue_AVG[dm_odm->RFCalibrateInfo.ThermalValue_AVG_index] = ThermalValue;
+		dm_odm->RFCalibrateInfo.ThermalValue_AVG_index++;
+		if (dm_odm->RFCalibrateInfo.ThermalValue_AVG_index == AVG_THERMAL_NUM_88E)
+			dm_odm->RFCalibrateInfo.ThermalValue_AVG_index = 0;
+
+		for (i = 0; i < AVG_THERMAL_NUM_88E; i++) {
+			if (dm_odm->RFCalibrateInfo.ThermalValue_AVG[i]) {
+				ThermalValue_AVG += dm_odm->RFCalibrateInfo.ThermalValue_AVG[i];
+				ThermalValue_AVG_count++;
+			}
+		}
+
+		if (ThermalValue_AVG_count) {
+			ThermalValue = (u8)(ThermalValue_AVG / ThermalValue_AVG_count);
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+				     ("AVG Thermal Meter = 0x%x\n", ThermalValue));
+		}
+
+		if (dm_odm->RFCalibrateInfo.bReloadtxpowerindex) {
+			delta = ThermalValue > pHalData->EEPROMThermalMeter ?
+				(ThermalValue - pHalData->EEPROMThermalMeter) :
+				(pHalData->EEPROMThermalMeter - ThermalValue);
+			dm_odm->RFCalibrateInfo.bReloadtxpowerindex = false;
+			dm_odm->RFCalibrateInfo.bDoneTxpower = false;
+		} else if (dm_odm->RFCalibrateInfo.bDoneTxpower) {
+			delta = (ThermalValue > dm_odm->RFCalibrateInfo.ThermalValue) ?
+				(ThermalValue - dm_odm->RFCalibrateInfo.ThermalValue) :
+				(dm_odm->RFCalibrateInfo.ThermalValue - ThermalValue);
+		} else {
+			delta = ThermalValue > pHalData->EEPROMThermalMeter ?
+				(ThermalValue - pHalData->EEPROMThermalMeter) :
+				(pHalData->EEPROMThermalMeter - ThermalValue);
+		}
+		delta_LCK = (ThermalValue > dm_odm->RFCalibrateInfo.ThermalValue_LCK) ?
+			    (ThermalValue - dm_odm->RFCalibrateInfo.ThermalValue_LCK) :
+			    (dm_odm->RFCalibrateInfo.ThermalValue_LCK - ThermalValue);
+		delta_IQK = (ThermalValue > dm_odm->RFCalibrateInfo.ThermalValue_IQK) ?
+			    (ThermalValue - dm_odm->RFCalibrateInfo.ThermalValue_IQK) :
+			    (dm_odm->RFCalibrateInfo.ThermalValue_IQK - ThermalValue);
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+			     ("Readback Thermal Meter = 0x%x pre thermal meter 0x%x EEPROMthermalmeter 0x%x delta 0x%x delta_LCK 0x%x delta_IQK 0x%x\n",
+			     ThermalValue, dm_odm->RFCalibrateInfo.ThermalValue,
+			     pHalData->EEPROMThermalMeter, delta, delta_LCK, delta_IQK));
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+			     ("pre thermal meter LCK 0x%x pre thermal meter IQK 0x%x delta_LCK_bound 0x%x delta_IQK_bound 0x%x\n",
+			     dm_odm->RFCalibrateInfo.ThermalValue_LCK,
+			     dm_odm->RFCalibrateInfo.ThermalValue_IQK,
+			     dm_odm->RFCalibrateInfo.Delta_LCK,
+			     dm_odm->RFCalibrateInfo.Delta_IQK));
+
+		if ((delta_LCK >= 8)) { /*  Delta temperature is equal to or larger than 20 centigrade. */
+			dm_odm->RFCalibrateInfo.ThermalValue_LCK = ThermalValue;
+			PHY_LCCalibrate_8188E(Adapter);
+		}
+
+		if (delta > 0 && dm_odm->RFCalibrateInfo.TxPowerTrackControl) {
+			delta = ThermalValue > pHalData->EEPROMThermalMeter ?
+				(ThermalValue - pHalData->EEPROMThermalMeter) :
+				(pHalData->EEPROMThermalMeter - ThermalValue);
+			/* calculate new OFDM / CCK offset */
+			if (ThermalValue > pHalData->EEPROMThermalMeter)
+				j = 1;
+			else
+				j = 0;
+			for (offset = 0; offset < index_mapping_NUM_88E; offset++) {
+				if (delta < Thermal_mapping[j][offset]) {
+					if (offset != 0)
+						offset--;
+					break;
+				}
+			}
+			if (offset >= index_mapping_NUM_88E)
+				offset = index_mapping_NUM_88E-1;
+			for (i = 0; i < rf; i++)
+				OFDM_index[i] = dm_odm->RFCalibrateInfo.OFDM_index[i] + OFDM_index_mapping[j][offset];
+			CCK_index = dm_odm->RFCalibrateInfo.CCK_index + OFDM_index_mapping[j][offset];
+
+			if (is2t) {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("temp OFDM_A_index=0x%x, OFDM_B_index=0x%x, CCK_index=0x%x\n",
+					     dm_odm->RFCalibrateInfo.OFDM_index[0],
+					     dm_odm->RFCalibrateInfo.OFDM_index[1],
+					     dm_odm->RFCalibrateInfo.CCK_index));
+			} else {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("temp OFDM_A_index=0x%x, CCK_index=0x%x\n",
+					     dm_odm->RFCalibrateInfo.OFDM_index[0],
+					     dm_odm->RFCalibrateInfo.CCK_index));
+			}
+
+			for (i = 0; i < rf; i++) {
+				if (OFDM_index[i] > OFDM_TABLE_SIZE_92D-1)
+					OFDM_index[i] = OFDM_TABLE_SIZE_92D-1;
+				else if (OFDM_index[i] < OFDM_min_index)
+					OFDM_index[i] = OFDM_min_index;
+			}
+
+			if (CCK_index > CCK_TABLE_SIZE-1)
+				CCK_index = CCK_TABLE_SIZE-1;
+			else if (CCK_index < 0)
+				CCK_index = 0;
+
+			if (is2t) {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("new OFDM_A_index=0x%x, OFDM_B_index=0x%x, CCK_index=0x%x\n",
+					     OFDM_index[0], OFDM_index[1], CCK_index));
+			} else {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("new OFDM_A_index=0x%x, CCK_index=0x%x\n",
+					     OFDM_index[0], CCK_index));
+			}
+
+			/* 2 temporarily remove bNOPG */
+			/* Config by SwingTable */
+			if (dm_odm->RFCalibrateInfo.TxPowerTrackControl) {
+				dm_odm->RFCalibrateInfo.bDoneTxpower = true;
+
+				/* Adujst OFDM Ant_A according to IQK result */
+				ele_D = (OFDMSwingTable[(u8)OFDM_index[0]] & 0xFFC00000)>>22;
+				X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][0];
+				Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][1];
+
+				/*  Revse TX power table. */
+				dm_odm->BbSwingIdxOfdm		= (u8)OFDM_index[0];
+				dm_odm->BbSwingIdxCck		= (u8)CCK_index;
+
+				if (dm_odm->BbSwingIdxOfdmCurrent != dm_odm->BbSwingIdxOfdm) {
+					dm_odm->BbSwingIdxOfdmCurrent = dm_odm->BbSwingIdxOfdm;
+					dm_odm->BbSwingFlagOfdm = true;
+				}
+
+				if (dm_odm->BbSwingIdxCckCurrent != dm_odm->BbSwingIdxCck) {
+					dm_odm->BbSwingIdxCckCurrent = dm_odm->BbSwingIdxCck;
+					dm_odm->BbSwingFlagCck = true;
+				}
+
+				if (X != 0) {
+					if ((X & 0x00000200) != 0)
+						X = X | 0xFFFFFC00;
+					ele_A = ((X * ele_D)>>8)&0x000003FF;
+
+					/* new element C = element D x Y */
+					if ((Y & 0x00000200) != 0)
+						Y = Y | 0xFFFFFC00;
+					ele_C = ((Y * ele_D)>>8)&0x000003FF;
+
+					/*  2012/04/23 MH According to Luke's suggestion, we can not write BB digital */
+					/*  to increase TX power. Otherwise, EVM will be bad. */
+				}
+
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("TxPwrTracking for path A: X=0x%x, Y=0x%x ele_A=0x%x ele_C=0x%x ele_D=0x%x 0xe94=0x%x 0xe9c=0x%x\n",
+					     (u32)X, (u32)Y, (u32)ele_A, (u32)ele_C, (u32)ele_D, (u32)X, (u32)Y));
+
+				if (is2t) {
+					ele_D = (OFDMSwingTable[(u8)OFDM_index[1]] & 0xFFC00000)>>22;
+
+					/* new element A = element D x X */
+					X = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][4];
+					Y = dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][5];
+
+					if ((X != 0) && (*(dm_odm->pBandType) == ODM_BAND_2_4G)) {
+						if ((X & 0x00000200) != 0)	/* consider minus */
+							X = X | 0xFFFFFC00;
+						ele_A = ((X * ele_D)>>8)&0x000003FF;
+
+						/* new element C = element D x Y */
+						if ((Y & 0x00000200) != 0)
+							Y = Y | 0xFFFFFC00;
+						ele_C = ((Y * ele_D)>>8)&0x00003FF;
+
+						/* wtite new elements A, C, D to regC88 and regC9C, element B is always 0 */
+						value32 = (ele_D<<22) | ((ele_C&0x3F)<<16) | ele_A;
+						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, value32);
+
+						value32 = (ele_C&0x000003C0)>>6;
+						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, value32);
+
+						value32 = ((X * ele_D)>>7)&0x01;
+						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT28, value32);
+					} else {
+						ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord, OFDMSwingTable[(u8)OFDM_index[1]]);
+						ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, bMaskH4Bits, 0x00);
+						ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT28, 0x00);
+					}
+
+					ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+						     ("TxPwrTracking path B: X=0x%x, Y=0x%x ele_A=0x%x ele_C=0x%x ele_D=0x%x 0xeb4=0x%x 0xebc=0x%x\n",
+						     (u32)X, (u32)Y, (u32)ele_A,
+						     (u32)ele_C, (u32)ele_D, (u32)X, (u32)Y));
+				}
+
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+					     ("TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
+					     ODM_GetBBReg(dm_odm, 0xc80, bMaskDWord), ODM_GetBBReg(dm_odm,
+					     0xc94, bMaskDWord), ODM_GetRFReg(dm_odm, RF_PATH_A, 0x24, bRFRegOffsetMask)));
+			}
+		}
+
+		if (delta_IQK >= 8) { /*  Delta temperature is equal to or larger than 20 centigrade. */
+			ODM_ResetIQKResult(dm_odm);
+
+			dm_odm->RFCalibrateInfo.ThermalValue_IQK = ThermalValue;
+			PHY_IQCalibrate_8188E(Adapter, false);
+		}
+		/* update thermal meter value */
+		if (dm_odm->RFCalibrateInfo.TxPowerTrackControl)
+			dm_odm->RFCalibrateInfo.ThermalValue = ThermalValue;
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("<===dm_TXPowerTrackingCallback_ThermalMeter_8188E\n"));
+	dm_odm->RFCalibrateInfo.TXPowercount = 0;
+}
+
+/* 1 7.	IQK */
+#define MAX_TOLERANCE		5
+#define IQK_DELAY_TIME		1		/* ms */
+
+static u8 /* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+phy_PathA_IQK_8188E(struct adapter *adapt, bool configPathB)
+{
+	u32 regeac, regE94, regE9C, regEA4;
+	u8 result = 0x00;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A IQK!\n"));
+
+	/* 1 Tx IQK */
+	/* path-A IQK setting */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A IQK setting!\n"));
+	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
+	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
+	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x8214032a);
+	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
+
+	/* LO calibration setting */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x00462911);
+
+	/* One shot, path A LOK & IQK */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+
+	/*  delay x ms */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E));
+	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
+	ODM_delay_ms(IQK_DELAY_TIME_88E);
+
+	/*  Check failed */
+	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xeac = 0x%x\n", regeac));
+	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe94 = 0x%x\n", regE94));
+	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xe9c = 0x%x\n", regE9C));
+	regEA4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xea4 = 0x%x\n", regEA4));
+
+	if (!(regeac & BIT28) &&
+	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
+	    (((regE9C & 0x03FF0000)>>16) != 0x42))
+		result |= 0x01;
+	return result;
+}
+
+static u8 /* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+phy_PathA_RxIQK(struct adapter *adapt, bool configPathB)
+{
+	u32 regeac, regE94, regE9C, regEA4, u4tmp;
+	u8 result = 0x00;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Rx IQK!\n"));
+
+	/* 1 Get TXIMR setting */
+	/* modify RXIQK mode table */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table!\n"));
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf117B);
+
+	/* PA,PAD off */
+	ODM_SetRFReg(dm_odm, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x980);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, 0x56, bRFRegOffsetMask, 0x51000);
+
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+
+	/* IQK setting */
+	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, 0x01007c00);
+	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x81004800);
+
+	/* path-A IQK setting */
+	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008c1c);
+	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x30008c1c);
+	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x82160c1f);
+	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160000);
+
+	/* LO calibration setting */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
+
+	/* One shot, path A LOK & IQK */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+
+	/*  delay x ms */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("Delay %d ms for One shot, path A LOK & IQK.\n",
+		     IQK_DELAY_TIME_88E));
+	ODM_delay_ms(IQK_DELAY_TIME_88E);
+
+	/*  Check failed */
+	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xeac = 0x%x\n", regeac));
+	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xe94 = 0x%x\n", regE94));
+	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xe9c = 0x%x\n", regE9C));
+
+	if (!(regeac & BIT28) &&
+	    (((regE94 & 0x03FF0000)>>16) != 0x142) &&
+	    (((regE9C & 0x03FF0000)>>16) != 0x42))
+		result |= 0x01;
+	else							/* if Tx not OK, ignore Rx */
+		return result;
+
+	u4tmp = 0x80007C00 | (regE94&0x3FF0000)  | ((regE9C&0x3FF0000) >> 16);
+	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, u4tmp);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("0xe40 = 0x%x u4tmp = 0x%x\n", ODM_GetBBReg(dm_odm, rTx_IQK, bMaskDWord), u4tmp));
+
+	/* 1 RX IQK */
+	/* modify RXIQK mode table */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path-A Rx IQK modify RXIQK mode table 2!\n"));
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_WE_LUT, bRFRegOffsetMask, 0x800a0);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_RCK_OS, bRFRegOffsetMask, 0x30000);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G1, bRFRegOffsetMask, 0x0000f);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_TXPA_G2, bRFRegOffsetMask, 0xf7ffa);
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+
+	/* IQK setting */
+	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x01004800);
+
+	/* path-A IQK setting */
+	ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x38008c1c);
+	ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x18008c1c);
+	ODM_SetBBReg(dm_odm, rTx_IQK_PI_A, bMaskDWord, 0x82160c05);
+	ODM_SetBBReg(dm_odm, rRx_IQK_PI_A, bMaskDWord, 0x28160c1f);
+
+	/* LO calibration setting */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("LO calibration setting!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Rsp, bMaskDWord, 0x0046a911);
+
+	/* One shot, path A LOK & IQK */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf9000000);
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+
+	/*  delay x ms */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Delay %d ms for One shot, path A LOK & IQK.\n", IQK_DELAY_TIME_88E));
+	/* PlatformStallExecution(IQK_DELAY_TIME_88E*1000); */
+	ODM_delay_ms(IQK_DELAY_TIME_88E);
+
+	/*  Check failed */
+	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xeac = 0x%x\n", regeac));
+	regE94 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xe94 = 0x%x\n", regE94));
+	regE9C = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xe9c = 0x%x\n", regE9C));
+	regEA4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("0xea4 = 0x%x\n", regEA4));
+
+	/* reload RF 0xdf */
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	ODM_SetRFReg(dm_odm, RF_PATH_A, 0xdf, bRFRegOffsetMask, 0x180);
+
+	if (!(regeac & BIT27) &&		/* if Tx is OK, check whether Rx is OK */
+	    (((regEA4 & 0x03FF0000)>>16) != 0x132) &&
+	    (((regeac & 0x03FF0000)>>16) != 0x36))
+		result |= 0x02;
+	else
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A Rx IQK fail!!\n"));
+
+	return result;
+}
+
+static u8 /* bit0 = 1 => Tx OK, bit1 = 1 => Rx OK */
+phy_PathB_IQK_8188E(struct adapter *adapt)
+{
+	u32 regeac, regeb4, regebc, regec4, regecc;
+	u8 result = 0x00;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B IQK!\n"));
+
+	/* One shot, path B LOK & IQK */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("One shot, path A LOK & IQK!\n"));
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Cont, bMaskDWord, 0x00000002);
+	ODM_SetBBReg(dm_odm, rIQK_AGC_Cont, bMaskDWord, 0x00000000);
+
+	/*  delay x ms */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("Delay %d ms for One shot, path B LOK & IQK.\n",
+		     IQK_DELAY_TIME_88E));
+	ODM_delay_ms(IQK_DELAY_TIME_88E);
+
+	/*  Check failed */
+	regeac = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xeac = 0x%x\n", regeac));
+	regeb4 = ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xeb4 = 0x%x\n", regeb4));
+	regebc = ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xebc = 0x%x\n", regebc));
+	regec4 = ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xec4 = 0x%x\n", regec4));
+	regecc = ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord);
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("0xecc = 0x%x\n", regecc));
+
+	if (!(regeac & BIT31) &&
+	    (((regeb4 & 0x03FF0000)>>16) != 0x142) &&
+	    (((regebc & 0x03FF0000)>>16) != 0x42))
+		result |= 0x01;
+	else
+		return result;
+
+	if (!(regeac & BIT30) &&
+	    (((regec4 & 0x03FF0000)>>16) != 0x132) &&
+	    (((regecc & 0x03FF0000)>>16) != 0x36))
+		result |= 0x02;
+	else
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path B Rx IQK fail!!\n"));
+	return result;
+}
+
+static void patha_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u8 final_candidate, bool txonly)
+{
+	u32 Oldval_0, X, TX0_A, reg;
+	s32 Y, TX0_C;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("Path A IQ Calibration %s !\n",
+		     (iqkok) ? "Success" : "Failed"));
+
+	if (final_candidate == 0xFF) {
+		return;
+	} else if (iqkok) {
+		Oldval_0 = (ODM_GetBBReg(dm_odm, rOFDM0_XATxIQImbalance, bMaskDWord) >> 22) & 0x3FF;
+
+		X = result[final_candidate][0];
+		if ((X & 0x00000200) != 0)
+			X = X | 0xFFFFFC00;
+		TX0_A = (X * Oldval_0) >> 8;
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+			     ("X = 0x%x, TX0_A = 0x%x, Oldval_0 0x%x\n",
+			     X, TX0_A, Oldval_0));
+		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x3FF, TX0_A);
+
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(31), ((X * Oldval_0>>7) & 0x1));
+
+		Y = result[final_candidate][1];
+		if ((Y & 0x00000200) != 0)
+			Y = Y | 0xFFFFFC00;
+
+		TX0_C = (Y * Oldval_0) >> 8;
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Y = 0x%x, TX = 0x%x\n", Y, TX0_C));
+		ODM_SetBBReg(dm_odm, rOFDM0_XCTxAFE, 0xF0000000, ((TX0_C&0x3C0)>>6));
+		ODM_SetBBReg(dm_odm, rOFDM0_XATxIQImbalance, 0x003F0000, (TX0_C&0x3F));
+
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(29), ((Y * Oldval_0>>7) & 0x1));
+
+		if (txonly) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("patha_fill_iqk only Tx OK\n"));
+			return;
+		}
+
+		reg = result[final_candidate][2];
+		ODM_SetBBReg(dm_odm, rOFDM0_XARxIQImbalance, 0x3FF, reg);
+
+		reg = result[final_candidate][3] & 0x3F;
+		ODM_SetBBReg(dm_odm, rOFDM0_XARxIQImbalance, 0xFC00, reg);
+
+		reg = (result[final_candidate][3] >> 6) & 0xF;
+		ODM_SetBBReg(dm_odm, rOFDM0_RxIQExtAnta, 0xF0000000, reg);
+	}
+}
+
+static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8], u8 final_candidate, bool txonly)
+{
+	u32 Oldval_1, X, TX1_A, reg;
+	s32 Y, TX1_C;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("Path B IQ Calibration %s !\n",
+		     (iqkok) ? "Success" : "Failed"));
+
+	if (final_candidate == 0xFF) {
+		return;
+	} else if (iqkok) {
+		Oldval_1 = (ODM_GetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, bMaskDWord) >> 22) & 0x3FF;
+
+		X = result[final_candidate][4];
+		if ((X & 0x00000200) != 0)
+			X = X | 0xFFFFFC00;
+		TX1_A = (X * Oldval_1) >> 8;
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("X = 0x%x, TX1_A = 0x%x\n", X, TX1_A));
+		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x3FF, TX1_A);
+
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(27), ((X * Oldval_1>>7) & 0x1));
+
+		Y = result[final_candidate][5];
+		if ((Y & 0x00000200) != 0)
+			Y = Y | 0xFFFFFC00;
+
+		TX1_C = (Y * Oldval_1) >> 8;
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Y = 0x%x, TX1_C = 0x%x\n", Y, TX1_C));
+		ODM_SetBBReg(dm_odm, rOFDM0_XDTxAFE, 0xF0000000, ((TX1_C&0x3C0)>>6));
+		ODM_SetBBReg(dm_odm, rOFDM0_XBTxIQImbalance, 0x003F0000, (TX1_C&0x3F));
+
+		ODM_SetBBReg(dm_odm, rOFDM0_ECCAThreshold, BIT(25), ((Y * Oldval_1>>7) & 0x1));
+
+		if (txonly)
+			return;
+
+		reg = result[final_candidate][6];
+		ODM_SetBBReg(dm_odm, rOFDM0_XBRxIQImbalance, 0x3FF, reg);
+
+		reg = result[final_candidate][7] & 0x3F;
+		ODM_SetBBReg(dm_odm, rOFDM0_XBRxIQImbalance, 0xFC00, reg);
+
+		reg = (result[final_candidate][7] >> 6) & 0xF;
+		ODM_SetBBReg(dm_odm, rOFDM0_AGCRSSITable, 0x0000F000, reg);
+	}
+}
+
+/*  */
+/*  2011/07/26 MH Add an API for testing IQK fail case. */
+/*  */
+/*  MP Already declare in odm.c */
+static bool ODM_CheckPowerStatus(struct adapter *Adapter)
+{
+	return	true;
+}
+
+void _PHY_SaveADDARegisters(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegisterNum)
+{
+	u32 i;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	if (!ODM_CheckPowerStatus(adapt))
+		return;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Save ADDA parameters.\n"));
+	for (i = 0; i < RegisterNum; i++) {
+		ADDABackup[i] = ODM_GetBBReg(dm_odm, ADDAReg[i], bMaskDWord);
+	}
+}
+
+static void _PHY_SaveMACRegisters(
+		struct adapter *adapt,
+		u32 *MACReg,
+		u32 *MACBackup
+	)
+{
+	u32 i;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Save MAC parameters.\n"));
+	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
+		MACBackup[i] = ODM_Read1Byte(dm_odm, MACReg[i]);
+	}
+	MACBackup[i] = ODM_Read4Byte(dm_odm, MACReg[i]);
+}
+
+static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegiesterNum)
+{
+	u32 i;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Reload ADDA power saving parameters !\n"));
+	for (i = 0; i < RegiesterNum; i++)
+		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, ADDABackup[i]);
+}
+
+static void
+_PHY_ReloadMACRegisters(
+		struct adapter *adapt,
+		u32 *MACReg,
+		u32 *MACBackup
+	)
+{
+	u32 i;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Reload MAC parameters !\n"));
+	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
+		ODM_Write1Byte(dm_odm, MACReg[i], (u8)MACBackup[i]);
+	}
+	ODM_Write4Byte(dm_odm, MACReg[i], MACBackup[i]);
+}
+
+void
+_PHY_PathADDAOn(
+		struct adapter *adapt,
+		u32 *ADDAReg,
+		bool isPathAOn,
+		bool is2t
+	)
+{
+	u32 pathOn;
+	u32 i;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("ADDA ON.\n"));
+
+	pathOn = isPathAOn ? 0x04db25a4 : 0x0b1b25a4;
+	if (!is2t) {
+		pathOn = 0x0bdb25a0;
+		ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, 0x0b1b25a0);
+	} else {
+		ODM_SetBBReg(dm_odm, ADDAReg[0], bMaskDWord, pathOn);
+	}
+
+	for (i = 1; i < IQK_ADDA_REG_NUM; i++)
+		ODM_SetBBReg(dm_odm, ADDAReg[i], bMaskDWord, pathOn);
+}
+
+void
+_PHY_MACSettingCalibration(
+		struct adapter *adapt,
+		u32 *MACReg,
+		u32 *MACBackup
+	)
+{
+	u32 i = 0;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("MAC settings for Calibration.\n"));
+
+	ODM_Write1Byte(dm_odm, MACReg[i], 0x3F);
+
+	for (i = 1; i < (IQK_MAC_REG_NUM - 1); i++) {
+		ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT3)));
+	}
+	ODM_Write1Byte(dm_odm, MACReg[i], (u8)(MACBackup[i]&(~BIT5)));
+}
+
+void
+_PHY_PathAStandBy(
+	struct adapter *adapt
+	)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path-A standby mode!\n"));
+
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x0);
+	ODM_SetBBReg(dm_odm, 0x840, bMaskDWord, 0x00010000);
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+}
+
+static void _PHY_PIModeSwitch(
+		struct adapter *adapt,
+		bool PIMode
+	)
+{
+	u32 mode;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("BB Switch to %s mode!\n", (PIMode ? "PI" : "SI")));
+
+	mode = PIMode ? 0x01000100 : 0x01000000;
+	ODM_SetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, bMaskDWord, mode);
+	ODM_SetBBReg(dm_odm, rFPGA0_XB_HSSIParameter1, bMaskDWord, mode);
+}
+
+static bool phy_SimularityCompare_8188E(
+		struct adapter *adapt,
+		s32 resulta[][8],
+		u8  c1,
+		u8  c2
+	)
+{
+	u32 i, j, diff, sim_bitmap, bound = 0;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	u8 final_candidate[2] = {0xFF, 0xFF};	/* for path A and path B */
+	bool result = true;
+	bool is2t;
+	s32 tmp1 = 0, tmp2 = 0;
+
+	if ((dm_odm->RFType == ODM_2T2R) || (dm_odm->RFType == ODM_2T3R) || (dm_odm->RFType == ODM_2T4R))
+		is2t = true;
+	else
+		is2t = false;
+
+	if (is2t)
+		bound = 8;
+	else
+		bound = 4;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("===> IQK:phy_SimularityCompare_8188E c1 %d c2 %d!!!\n", c1, c2));
+
+	sim_bitmap = 0;
+
+	for (i = 0; i < bound; i++) {
+		if ((i == 1) || (i == 3) || (i == 5) || (i == 7)) {
+			if ((resulta[c1][i] & 0x00000200) != 0)
+				tmp1 = resulta[c1][i] | 0xFFFFFC00;
+			else
+				tmp1 = resulta[c1][i];
+
+			if ((resulta[c2][i] & 0x00000200) != 0)
+				tmp2 = resulta[c2][i] | 0xFFFFFC00;
+			else
+				tmp2 = resulta[c2][i];
+		} else {
+			tmp1 = resulta[c1][i];
+			tmp2 = resulta[c2][i];
+		}
+
+		diff = (tmp1 > tmp2) ? (tmp1 - tmp2) : (tmp2 - tmp1);
+
+		if (diff > MAX_TOLERANCE) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+				     ("IQK:phy_SimularityCompare_8188E differnece overflow index %d compare1 0x%x compare2 0x%x!!!\n",
+				     i, resulta[c1][i], resulta[c2][i]));
+
+			if ((i == 2 || i == 6) && !sim_bitmap) {
+				if (resulta[c1][i] + resulta[c1][i+1] == 0)
+					final_candidate[(i/4)] = c2;
+				else if (resulta[c2][i] + resulta[c2][i+1] == 0)
+					final_candidate[(i/4)] = c1;
+				else
+					sim_bitmap = sim_bitmap | (1<<i);
+			} else {
+				sim_bitmap = sim_bitmap | (1<<i);
+			}
+		}
+	}
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK:phy_SimularityCompare_8188E sim_bitmap   %d !!!\n", sim_bitmap));
+
+	if (sim_bitmap == 0) {
+		for (i = 0; i < (bound/4); i++) {
+			if (final_candidate[i] != 0xFF) {
+				for (j = i*4; j < (i+1)*4-2; j++)
+					resulta[3][j] = resulta[final_candidate[i]][j];
+				result = false;
+			}
+		}
+		return result;
+	} else {
+		if (!(sim_bitmap & 0x03)) {		   /* path A TX OK */
+			for (i = 0; i < 2; i++)
+				resulta[3][i] = resulta[c1][i];
+		}
+		if (!(sim_bitmap & 0x0c)) {		   /* path A RX OK */
+			for (i = 2; i < 4; i++)
+				resulta[3][i] = resulta[c1][i];
+		}
+
+		if (!(sim_bitmap & 0x30)) { /* path B TX OK */
+			for (i = 4; i < 6; i++)
+				resulta[3][i] = resulta[c1][i];
+		}
+
+		if (!(sim_bitmap & 0xc0)) { /* path B RX OK */
+			for (i = 6; i < 8; i++)
+				resulta[3][i] = resulta[c1][i];
+		}
+		return false;
+	}
+}
+
+static void phy_IQCalibrate_8188E(struct adapter *adapt, s32 result[][8], u8 t, bool is2t)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	u32 i;
+	u8 PathAOK, PathBOK;
+	u32 ADDA_REG[IQK_ADDA_REG_NUM] = {
+						rFPGA0_XCD_SwitchControl, rBlue_Tooth,
+						rRx_Wait_CCA, 	rTx_CCK_RFON,
+						rTx_CCK_BBON, rTx_OFDM_RFON,
+						rTx_OFDM_BBON, rTx_To_Rx,
+						rTx_To_Tx, 	rRx_CCK,
+						rRx_OFDM, 	rRx_Wait_RIFS,
+						rRx_TO_Rx, 	rStandby,
+						rSleep, 			rPMPD_ANAEN };
+	u32 IQK_MAC_REG[IQK_MAC_REG_NUM] = {
+						REG_TXPAUSE, 	REG_BCN_CTRL,
+						REG_BCN_CTRL_1, REG_GPIO_MUXCFG};
+
+	/* since 92C & 92D have the different define in IQK_BB_REG */
+	u32 IQK_BB_REG_92C[IQK_BB_REG_NUM] = {
+							rOFDM0_TRxPathEnable, 	rOFDM0_TRMuxPar,
+							rFPGA0_XCD_RFInterfaceSW, rConfig_AntA, rConfig_AntB,
+							rFPGA0_XAB_RFInterfaceSW, rFPGA0_XA_RFInterfaceOE,
+							rFPGA0_XB_RFInterfaceOE, rFPGA0_RFMOD
+							};
+
+	u32 retryCount = 9;
+	if (*(dm_odm->mp_mode) == 1)
+		retryCount = 9;
+	else
+		retryCount = 2;
+	/*  Note: IQ calibration must be performed after loading */
+	/* 		PHY_REG.txt , and radio_a, radio_b.txt */
+
+	if (t == 0) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2t ? "2T2R" : "1T1R"), t));
+
+		/*  Save ADDA parameters, turn Path A ADDA on */
+		_PHY_SaveADDARegisters(adapt, ADDA_REG, dm_odm->RFCalibrateInfo.ADDA_backup, IQK_ADDA_REG_NUM);
+		_PHY_SaveMACRegisters(adapt, IQK_MAC_REG, dm_odm->RFCalibrateInfo.IQK_MAC_backup);
+		_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQ Calibration for %s for %d times\n", (is2t ? "2T2R" : "1T1R"), t));
+
+	_PHY_PathADDAOn(adapt, ADDA_REG, true, is2t);
+	if (t == 0)
+		dm_odm->RFCalibrateInfo.bRfPiEnable = (u8)ODM_GetBBReg(dm_odm, rFPGA0_XA_HSSIParameter1, BIT(8));
+
+	if (!dm_odm->RFCalibrateInfo.bRfPiEnable) {
+		/*  Switch BB to PI mode to do IQ Calibration. */
+		_PHY_PIModeSwitch(adapt, true);
+	}
+
+	/* BB setting */
+	ODM_SetBBReg(dm_odm, rFPGA0_RFMOD, BIT24, 0x00);
+	ODM_SetBBReg(dm_odm, rOFDM0_TRxPathEnable, bMaskDWord, 0x03a05600);
+	ODM_SetBBReg(dm_odm, rOFDM0_TRMuxPar, bMaskDWord, 0x000800e4);
+	ODM_SetBBReg(dm_odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, 0x22204000);
+
+	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT10, 0x01);
+	ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFInterfaceSW, BIT26, 0x01);
+	ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT10, 0x00);
+	ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT10, 0x00);
+
+	if (is2t) {
+		ODM_SetBBReg(dm_odm, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00010000);
+		ODM_SetBBReg(dm_odm, rFPGA0_XB_LSSIParameter, bMaskDWord, 0x00010000);
+	}
+
+	/* MAC settings */
+	_PHY_MACSettingCalibration(adapt, IQK_MAC_REG, dm_odm->RFCalibrateInfo.IQK_MAC_backup);
+
+	/* Page B init */
+	/* AP or IQK */
+	ODM_SetBBReg(dm_odm, rConfig_AntA, bMaskDWord, 0x0f600000);
+
+	if (is2t)
+		ODM_SetBBReg(dm_odm, rConfig_AntB, bMaskDWord, 0x0f600000);
+
+	/*  IQ calibration setting */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK setting!\n"));
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+	ODM_SetBBReg(dm_odm, rTx_IQK, bMaskDWord, 0x01007c00);
+	ODM_SetBBReg(dm_odm, rRx_IQK, bMaskDWord, 0x81004800);
+
+	for (i = 0; i < retryCount; i++) {
+		PathAOK = phy_PathA_IQK_8188E(adapt, is2t);
+		if (PathAOK == 0x01) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Tx IQK Success!!\n"));
+				result[t][0] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_A, bMaskDWord)&0x3FF0000)>>16;
+				result[t][1] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_A, bMaskDWord)&0x3FF0000)>>16;
+			break;
+		}
+	}
+
+	for (i = 0; i < retryCount; i++) {
+		PathAOK = phy_PathA_RxIQK(adapt, is2t);
+		if (PathAOK == 0x03) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("Path A Rx IQK Success!!\n"));
+				result[t][2] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
+				result[t][3] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_A_2, bMaskDWord)&0x3FF0000)>>16;
+			break;
+		} else {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A Rx IQK Fail!!\n"));
+		}
+	}
+
+	if (0x00 == PathAOK) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path A IQK failed!!\n"));
+	}
+
+	if (is2t) {
+		_PHY_PathAStandBy(adapt);
+
+		/*  Turn Path B ADDA on */
+		_PHY_PathADDAOn(adapt, ADDA_REG, false, is2t);
+
+		for (i = 0; i < retryCount; i++) {
+			PathBOK = phy_PathB_IQK_8188E(adapt);
+			if (PathBOK == 0x03) {
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B IQK Success!!\n"));
+				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord)&0x3FF0000)>>16;
+				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord)&0x3FF0000)>>16;
+				result[t][6] = (ODM_GetBBReg(dm_odm, rRx_Power_Before_IQK_B_2, bMaskDWord)&0x3FF0000)>>16;
+				result[t][7] = (ODM_GetBBReg(dm_odm, rRx_Power_After_IQK_B_2, bMaskDWord)&0x3FF0000)>>16;
+				break;
+			} else if (i == (retryCount - 1) && PathBOK == 0x01) {	/* Tx IQK OK */
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B Only Tx IQK Success!!\n"));
+				result[t][4] = (ODM_GetBBReg(dm_odm, rTx_Power_Before_IQK_B, bMaskDWord)&0x3FF0000)>>16;
+				result[t][5] = (ODM_GetBBReg(dm_odm, rTx_Power_After_IQK_B, bMaskDWord)&0x3FF0000)>>16;
+			}
+		}
+
+		if (0x00 == PathBOK) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("Path B IQK failed!!\n"));
+		}
+	}
+
+	/* Back to BB mode, load original value */
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK:Back to BB mode, load original value!\n"));
+	ODM_SetBBReg(dm_odm, rFPGA0_IQK, bMaskDWord, 0);
+
+	if (t != 0) {
+		if (!dm_odm->RFCalibrateInfo.bRfPiEnable) {
+			/*  Switch back BB to SI mode after finish IQ Calibration. */
+			_PHY_PIModeSwitch(adapt, false);
+		}
+
+		/*  Reload ADDA power saving parameters */
+		reload_adda_reg(adapt, ADDA_REG, dm_odm->RFCalibrateInfo.ADDA_backup, IQK_ADDA_REG_NUM);
+
+		/*  Reload MAC parameters */
+		_PHY_ReloadMACRegisters(adapt, IQK_MAC_REG, dm_odm->RFCalibrateInfo.IQK_MAC_backup);
+
+		reload_adda_reg(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup, IQK_BB_REG_NUM);
+
+		/*  Restore RX initial gain */
+		ODM_SetBBReg(dm_odm, rFPGA0_XA_LSSIParameter, bMaskDWord, 0x00032ed3);
+		if (is2t)
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_LSSIParameter, bMaskDWord, 0x00032ed3);
+
+		/* load 0xe30 IQC default value */
+		ODM_SetBBReg(dm_odm, rTx_IQK_Tone_A, bMaskDWord, 0x01008c00);
+		ODM_SetBBReg(dm_odm, rRx_IQK_Tone_A, bMaskDWord, 0x01008c00);
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("phy_IQCalibrate_8188E() <==\n"));
+}
+
+static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
+{
+	u8 tmpreg;
+	u32 RF_Amode = 0, RF_Bmode = 0, LC_Cal;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	/* Check continuous TX and Packet TX */
+	tmpreg = ODM_Read1Byte(dm_odm, 0xd03);
+
+	if ((tmpreg&0x70) != 0)			/* Deal with contisuous TX case */
+		ODM_Write1Byte(dm_odm, 0xd03, tmpreg&0x8F);	/* disable all continuous TX */
+	else							/*  Deal with Packet TX case */
+		ODM_Write1Byte(dm_odm, REG_TXPAUSE, 0xFF);			/*  block all queues */
+
+	if ((tmpreg&0x70) != 0) {
+		/* 1. Read original RF mode */
+		/* Path-A */
+		RF_Amode = PHY_QueryRFReg(adapt, RF_PATH_A, RF_AC, bMask12Bits);
+
+		/* Path-B */
+		if (is2t)
+			RF_Bmode = PHY_QueryRFReg(adapt, RF_PATH_B, RF_AC, bMask12Bits);
+
+		/* 2. Set RF mode = standby mode */
+		/* Path-A */
+		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, (RF_Amode&0x8FFFF)|0x10000);
+
+		/* Path-B */
+		if (is2t)
+			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, (RF_Bmode&0x8FFFF)|0x10000);
+	}
+
+	/* 3. Read RF reg18 */
+	LC_Cal = PHY_QueryRFReg(adapt, RF_PATH_A, RF_CHNLBW, bMask12Bits);
+
+	/* 4. Set LC calibration begin	bit15 */
+	ODM_SetRFReg(dm_odm, RF_PATH_A, RF_CHNLBW, bMask12Bits, LC_Cal|0x08000);
+
+	ODM_sleep_ms(100);
+
+	/* Restore original situation */
+	if ((tmpreg&0x70) != 0) {
+		/* Deal with continuous TX case */
+		/* Path-A */
+		ODM_Write1Byte(dm_odm, 0xd03, tmpreg);
+		ODM_SetRFReg(dm_odm, RF_PATH_A, RF_AC, bMask12Bits, RF_Amode);
+
+		/* Path-B */
+		if (is2t)
+			ODM_SetRFReg(dm_odm, RF_PATH_B, RF_AC, bMask12Bits, RF_Bmode);
+	} else {
+		/*  Deal with Packet TX case */
+		ODM_Write1Byte(dm_odm, REG_TXPAUSE, 0x00);
+	}
+}
+
+void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	struct mpt_context *pMptCtx = &(adapt->mppriv.MptCtx);
+	s32 result[4][8];	/* last is final result */
+	u8 i, final_candidate, Indexforchannel;
+	bool pathaok, pathbok;
+	s32 RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC;
+	bool is12simular, is13simular, is23simular;
+	bool singletone = false, carrier_sup = false;
+	u32 IQK_BB_REG_92C[IQK_BB_REG_NUM] = {
+		rOFDM0_XARxIQImbalance, rOFDM0_XBRxIQImbalance,
+		rOFDM0_ECCAThreshold, rOFDM0_AGCRSSITable,
+		rOFDM0_XATxIQImbalance, rOFDM0_XBTxIQImbalance,
+		rOFDM0_XCTxAFE, rOFDM0_XDTxAFE,
+		rOFDM0_RxIQExtAnta};
+	bool is2t;
+
+	is2t = (dm_odm->RFType == ODM_2T2R) ? true : false;
+	if (!ODM_CheckPowerStatus(adapt))
+		return;
+
+	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
+		return;
+
+	if (*(dm_odm->mp_mode) == 1) {
+		singletone = pMptCtx->bSingleTone;
+		carrier_sup = pMptCtx->bCarrierSuppression;
+	}
+
+	/*  20120213<Kordan> Turn on when continuous Tx to pass lab testing. (required by Edlu) */
+	if (singletone || carrier_sup)
+		return;
+
+	if (recovery) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("PHY_IQCalibrate_8188E: Return due to recovery!\n"));
+		reload_adda_reg(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
+		return;
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK:Start!!!\n"));
+
+	for (i = 0; i < 8; i++) {
+		result[0][i] = 0;
+		result[1][i] = 0;
+		result[2][i] = 0;
+		if ((i == 0) || (i == 2) || (i == 4)  || (i == 6))
+			result[3][i] = 0x100;
+		else
+			result[3][i] = 0;
+	}
+	final_candidate = 0xff;
+	pathaok = false;
+	pathbok = false;
+	is12simular = false;
+	is23simular = false;
+	is13simular = false;
+
+	for (i = 0; i < 3; i++) {
+		phy_IQCalibrate_8188E(adapt, result, i, is2t);
+
+		if (i == 1) {
+			is12simular = phy_SimularityCompare_8188E(adapt, result, 0, 1);
+			if (is12simular) {
+				final_candidate = 0;
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is12simular final_candidate is %x\n", final_candidate));
+				break;
+			}
+		}
+
+		if (i == 2) {
+			is13simular = phy_SimularityCompare_8188E(adapt, result, 0, 2);
+			if (is13simular) {
+				final_candidate = 0;
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is13simular final_candidate is %x\n", final_candidate));
+
+				break;
+			}
+			is23simular = phy_SimularityCompare_8188E(adapt, result, 1, 2);
+			if (is23simular) {
+				final_candidate = 1;
+				ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD, ("IQK: is23simular final_candidate is %x\n", final_candidate));
+			} else {
+				final_candidate = 3;
+			}
+		}
+	}
+
+	for (i = 0; i < 4; i++) {
+		RegE94 = result[i][0];
+		RegE9C = result[i][1];
+		RegEA4 = result[i][2];
+		RegEAC = result[i][3];
+		RegEB4 = result[i][4];
+		RegEBC = result[i][5];
+		RegEC4 = result[i][6];
+		RegECC = result[i][7];
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+			     ("IQK: RegE94=%x RegE9C=%x RegEA4=%x RegEAC=%x RegEB4=%x RegEBC=%x RegEC4=%x RegECC=%x\n",
+			     RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC));
+	}
+
+	if (final_candidate != 0xff) {
+		RegE94 = result[final_candidate][0];
+		RegE9C = result[final_candidate][1];
+		RegEA4 = result[final_candidate][2];
+		RegEAC = result[final_candidate][3];
+		RegEB4 = result[final_candidate][4];
+		RegEBC = result[final_candidate][5];
+		dm_odm->RFCalibrateInfo.RegE94 = RegE94;
+		dm_odm->RFCalibrateInfo.RegE9C = RegE9C;
+		dm_odm->RFCalibrateInfo.RegEB4 = RegEB4;
+		dm_odm->RFCalibrateInfo.RegEBC = RegEBC;
+		RegEC4 = result[final_candidate][6];
+		RegECC = result[final_candidate][7];
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+			     ("IQK: final_candidate is %x\n", final_candidate));
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+			     ("IQK: RegE94=%x RegE9C=%x RegEA4=%x RegEAC=%x RegEB4=%x RegEBC=%x RegEC4=%x RegECC=%x\n",
+			     RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC));
+		pathaok = true;
+		pathbok = true;
+	} else {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK: FAIL use default value\n"));
+		dm_odm->RFCalibrateInfo.RegE94 = 0x100;
+		dm_odm->RFCalibrateInfo.RegEB4 = 0x100;	/* X default value */
+		dm_odm->RFCalibrateInfo.RegE9C = 0x0;
+		dm_odm->RFCalibrateInfo.RegEBC = 0x0;	/* Y default value */
+	}
+	if (RegE94 != 0)
+		patha_fill_iqk(adapt, pathaok, result, final_candidate, (RegEA4 == 0));
+	if (is2t) {
+		if (RegEB4 != 0)
+			pathb_fill_iqk(adapt, pathbok, result, final_candidate, (RegEC4 == 0));
+	}
+
+	Indexforchannel = ODM_GetRightChnlPlaceforIQK(pHalData->CurrentChannel);
+
+/* To Fix BSOD when final_candidate is 0xff */
+/* by sherry 20120321 */
+	if (final_candidate < 4) {
+		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
+			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][i] = result[final_candidate][i];
+		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].bIQKDone = true;
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("\nIQK OK Indexforchannel %d.\n", Indexforchannel));
+
+	_PHY_SaveADDARegisters(adapt, IQK_BB_REG_92C, dm_odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("IQK finished\n"));
+}
+
+void PHY_LCCalibrate_8188E(struct adapter *adapt)
+{
+	bool singletone = false, carrier_sup = false;
+	u32 timeout = 2000, timecount = 0;
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	struct mpt_context *pMptCtx = &(adapt->mppriv.MptCtx);
+
+	if (*(dm_odm->mp_mode) == 1) {
+		singletone = pMptCtx->bSingleTone;
+		carrier_sup = pMptCtx->bCarrierSuppression;
+	}
+	if (!(dm_odm->SupportAbility & ODM_RF_CALIBRATION))
+		return;
+	/*  20120213<Kordan> Turn on when continuous Tx to pass lab testing. (required by Edlu) */
+	if (singletone || carrier_sup)
+		return;
+
+	while (*(dm_odm->pbScanInProcess) && timecount < timeout) {
+		ODM_delay_ms(50);
+		timecount += 50;
+	}
+
+	dm_odm->RFCalibrateInfo.bLCKInProgress = true;
+
+	if (dm_odm->RFType == ODM_2T2R) {
+		phy_LCCalibrate_8188E(adapt, true);
+	} else {
+		/*  For 88C 1T1R */
+		phy_LCCalibrate_8188E(adapt, false);
+	}
+
+	dm_odm->RFCalibrateInfo.bLCKInProgress = false;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,
+		     ("LCK:Finish!!!interface %d\n", dm_odm->InterfaceIndex));
+}
+
+static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2t)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	if (!adapt->hw_init_completed) {
+		u8 u1btmp;
+		u1btmp = ODM_Read1Byte(dm_odm, REG_LEDCFG2) | BIT7;
+		ODM_Write1Byte(dm_odm, REG_LEDCFG2, u1btmp);
+		ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFParameter, BIT13, 0x01);
+	}
+
+	if (is2t) {	/* 92C */
+		if (main)
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT5|BIT6, 0x1);	/* 92C_Path_A */
+		else
+			ODM_SetBBReg(dm_odm, rFPGA0_XB_RFInterfaceOE, BIT5|BIT6, 0x2);	/* BT */
+	} else {			/* 88C */
+		if (main)
+			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT8|BIT9, 0x2);	/* Main */
+		else
+			ODM_SetBBReg(dm_odm, rFPGA0_XA_RFInterfaceOE, BIT8|BIT9, 0x1);	/* Aux */
+	}
+}
+
+void PHY_SetRFPathSwitch_8188E(struct adapter *adapt, bool main)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
+	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+
+	if (dm_odm->RFType == ODM_2T2R) {
+		phy_setrfpathswitch_8188e(adapt, main, true);
+	} else {
+		/*  For 88C 1T1R */
+		phy_setrfpathswitch_8188e(adapt, main, false);
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
new file mode 100644
index 000000000000..5700dbce5b8c
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -0,0 +1,132 @@
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
+/*++
+Copyright (c) Realtek Semiconductor Corp. All rights reserved.
+
+Module Name:
+	HalPwrSeqCmd.c
+
+Abstract:
+	Implement HW Power sequence configuration CMD handling routine for Realtek devices.
+
+Major Change History:
+	When       Who               What
+	---------- ---------------   -------------------------------
+	2011-10-26 Lucas            Modify to be compatible with SD4-CE driver.
+	2011-07-07 Roger            Create.
+
+--*/
+
+#include <HalPwrSeqCmd.h>
+
+/*	Description: */
+/*		This routine deals with the Power Configuration CMDs parsing
+ *		for RTL8723/RTL8188E Series IC.
+ *	Assumption:
+ *		We should follow specific format which was released from HW SD.
+ */
+u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
+		       u8 ifacetype, struct wl_pwr_cfg pwrseqcmd[])
+{
+	struct wl_pwr_cfg pwrcfgcmd = {0};
+	u8 poll_bit = false;
+	u32 aryidx = 0;
+	u8 value = 0;
+	u32 offset = 0;
+	u32 poll_count = 0; /*  polling autoload done. */
+	u32 max_poll_count = 5000;
+
+	do {
+		pwrcfgcmd = pwrseqcmd[aryidx];
+
+		RT_TRACE(_module_hal_init_c_ , _drv_info_,
+			 ("HalPwrSeqCmdParsing: offset(%#x) cut_msk(%#x) fab_msk(%#x) interface_msk(%#x) base(%#x) cmd(%#x) msk(%#x) value(%#x)\n",
+			 GET_PWR_CFG_OFFSET(pwrcfgcmd),
+			 GET_PWR_CFG_CUT_MASK(pwrcfgcmd),
+			 GET_PWR_CFG_FAB_MASK(pwrcfgcmd),
+			 GET_PWR_CFG_INTF_MASK(pwrcfgcmd),
+			 GET_PWR_CFG_BASE(pwrcfgcmd),
+			 GET_PWR_CFG_CMD(pwrcfgcmd),
+			 GET_PWR_CFG_MASK(pwrcfgcmd),
+			 GET_PWR_CFG_VALUE(pwrcfgcmd)));
+
+		/* 2 Only Handle the command whose FAB, CUT, and Interface are matched */
+		if ((GET_PWR_CFG_FAB_MASK(pwrcfgcmd) & fab_vers) &&
+		    (GET_PWR_CFG_CUT_MASK(pwrcfgcmd) & cut_vers) &&
+		    (GET_PWR_CFG_INTF_MASK(pwrcfgcmd) & ifacetype)) {
+			switch (GET_PWR_CFG_CMD(pwrcfgcmd)) {
+			case PWR_CMD_READ:
+				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_READ\n"));
+				break;
+			case PWR_CMD_WRITE:
+				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_WRITE\n"));
+				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
+
+				/*  Read the value from system register */
+				value = rtw_read8(padapter, offset);
+
+				value &= ~(GET_PWR_CFG_MASK(pwrcfgcmd));
+				value |= (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd));
+
+				/*  Write the value back to system register */
+				rtw_write8(padapter, offset, value);
+				break;
+			case PWR_CMD_POLLING:
+				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_POLLING\n"));
+
+				poll_bit = false;
+				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
+				do {
+						value = rtw_read8(padapter, offset);
+
+					value &= GET_PWR_CFG_MASK(pwrcfgcmd);
+					if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
+						poll_bit = true;
+					else
+						rtw_udelay_os(10);
+
+					if (poll_count++ > max_poll_count) {
+						DBG_88E("Fail to polling Offset[%#x]\n", offset);
+						return false;
+					}
+				} while (!poll_bit);
+				break;
+			case PWR_CMD_DELAY:
+				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_DELAY\n"));
+				if (GET_PWR_CFG_VALUE(pwrcfgcmd) == PWRSEQ_DELAY_US)
+					rtw_udelay_os(GET_PWR_CFG_OFFSET(pwrcfgcmd));
+				else
+					rtw_udelay_os(GET_PWR_CFG_OFFSET(pwrcfgcmd)*1000);
+				break;
+			case PWR_CMD_END:
+				/*  When this command is parsed, end the process */
+				RT_TRACE(_module_hal_init_c_ , _drv_info_, ("HalPwrSeqCmdParsing: PWR_CMD_END\n"));
+				return true;
+				break;
+			default:
+				RT_TRACE(_module_hal_init_c_ , _drv_err_, ("HalPwrSeqCmdParsing: Unknown CMD!!\n"));
+				break;
+			}
+		}
+
+		aryidx++;/* Add Array Index */
+	} while (1);
+	return true;
+}
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
new file mode 100644
index 000000000000..60ff30f1c3ac
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -0,0 +1,381 @@
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
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#include <hal_intf.h>
+#include <hal_com.h>
+#include <rtl8188e_hal.h>
+
+#define _HAL_INIT_C_
+
+void dump_chip_info(struct HAL_VERSION	chip_vers)
+{
+	uint cnt = 0;
+	char buf[128];
+
+	if (IS_81XXC(chip_vers)) {
+		cnt += sprintf((buf+cnt), "Chip Version Info: %s_",
+			       IS_92C_SERIAL(chip_vers) ?
+			       "CHIP_8192C" : "CHIP_8188C");
+	} else if (IS_92D(chip_vers)) {
+		cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8192D_");
+	} else if (IS_8723_SERIES(chip_vers)) {
+		cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8723A_");
+	} else if (IS_8188E(chip_vers)) {
+		cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8188E_");
+	}
+
+	cnt += sprintf((buf+cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
+		       "Normal_Chip" : "Test_Chip");
+	cnt += sprintf((buf+cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
+		       "TSMC" : "UMC");
+	if (IS_A_CUT(chip_vers))
+		cnt += sprintf((buf+cnt), "A_CUT_");
+	else if (IS_B_CUT(chip_vers))
+		cnt += sprintf((buf+cnt), "B_CUT_");
+	else if (IS_C_CUT(chip_vers))
+		cnt += sprintf((buf+cnt), "C_CUT_");
+	else if (IS_D_CUT(chip_vers))
+		cnt += sprintf((buf+cnt), "D_CUT_");
+	else if (IS_E_CUT(chip_vers))
+		cnt += sprintf((buf+cnt), "E_CUT_");
+	else
+		cnt += sprintf((buf+cnt), "UNKNOWN_CUT(%d)_",
+			       chip_vers.CUTVersion);
+
+	if (IS_1T1R(chip_vers))
+		cnt += sprintf((buf+cnt), "1T1R_");
+	else if (IS_1T2R(chip_vers))
+		cnt += sprintf((buf+cnt), "1T2R_");
+	else if (IS_2T2R(chip_vers))
+		cnt += sprintf((buf+cnt), "2T2R_");
+	else
+		cnt += sprintf((buf+cnt), "UNKNOWN_RFTYPE(%d)_",
+			       chip_vers.RFType);
+
+	cnt += sprintf((buf+cnt), "RomVer(%d)\n", chip_vers.ROMVer);
+
+	pr_info("%s", buf);
+}
+
+#define	CHAN_PLAN_HW	0x80
+
+u8 /* return the final channel plan decision */
+hal_com_get_channel_plan(struct adapter *padapter, u8 hw_channel_plan,
+			 u8 sw_channel_plan, u8 def_channel_plan,
+			 bool load_fail)
+{
+	u8 sw_cfg;
+	u8 chnlplan;
+
+	sw_cfg = true;
+	if (!load_fail) {
+		if (!rtw_is_channel_plan_valid(sw_channel_plan))
+			sw_cfg = false;
+		if (hw_channel_plan & CHAN_PLAN_HW)
+			sw_cfg = false;
+	}
+
+	if (sw_cfg)
+		chnlplan = sw_channel_plan;
+	else
+		chnlplan = hw_channel_plan & (~CHAN_PLAN_HW);
+
+	if (!rtw_is_channel_plan_valid(chnlplan))
+		chnlplan = def_channel_plan;
+
+	return chnlplan;
+}
+
+u8 MRateToHwRate(u8 rate)
+{
+	u8 ret = DESC_RATE1M;
+
+	switch (rate) {
+		/*  CCK and OFDM non-HT rates */
+	case IEEE80211_CCK_RATE_1MB:
+		ret = DESC_RATE1M;
+		break;
+	case IEEE80211_CCK_RATE_2MB:
+		ret = DESC_RATE2M;
+		break;
+	case IEEE80211_CCK_RATE_5MB:
+		ret = DESC_RATE5_5M;
+		break;
+	case IEEE80211_CCK_RATE_11MB:
+		ret = DESC_RATE11M;
+		break;
+	case IEEE80211_OFDM_RATE_6MB:
+		ret = DESC_RATE6M;
+		break;
+	case IEEE80211_OFDM_RATE_9MB:
+		ret = DESC_RATE9M;
+		break;
+	case IEEE80211_OFDM_RATE_12MB:
+		ret = DESC_RATE12M;
+		break;
+	case IEEE80211_OFDM_RATE_18MB:
+		ret = DESC_RATE18M;
+		break;
+	case IEEE80211_OFDM_RATE_24MB:
+		ret = DESC_RATE24M;
+		break;
+	case IEEE80211_OFDM_RATE_36MB:
+		ret = DESC_RATE36M;
+		break;
+	case IEEE80211_OFDM_RATE_48MB:
+		ret = DESC_RATE48M;
+		break;
+	case IEEE80211_OFDM_RATE_54MB:
+		ret = DESC_RATE54M;
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+void HalSetBrateCfg(struct adapter *adapt, u8 *brates, u16 *rate_cfg)
+{
+	u8 i, is_brate, brate;
+
+	for (i = 0; i < NDIS_802_11_LENGTH_RATES_EX; i++) {
+		is_brate = brates[i] & IEEE80211_BASIC_RATE_MASK;
+		brate = brates[i] & 0x7f;
+
+		if (is_brate) {
+			switch (brate) {
+			case IEEE80211_CCK_RATE_1MB:
+				*rate_cfg |= RATE_1M;
+				break;
+			case IEEE80211_CCK_RATE_2MB:
+				*rate_cfg |= RATE_2M;
+				break;
+			case IEEE80211_CCK_RATE_5MB:
+				*rate_cfg |= RATE_5_5M;
+				break;
+			case IEEE80211_CCK_RATE_11MB:
+				*rate_cfg |= RATE_11M;
+				break;
+			case IEEE80211_OFDM_RATE_6MB:
+				*rate_cfg |= RATE_6M;
+				break;
+			case IEEE80211_OFDM_RATE_9MB:
+				*rate_cfg |= RATE_9M;
+				break;
+			case IEEE80211_OFDM_RATE_12MB:
+				*rate_cfg |= RATE_12M;
+				break;
+			case IEEE80211_OFDM_RATE_18MB:
+				*rate_cfg |= RATE_18M;
+				break;
+			case IEEE80211_OFDM_RATE_24MB:
+				*rate_cfg |= RATE_24M;
+				break;
+			case IEEE80211_OFDM_RATE_36MB:
+				*rate_cfg |= RATE_36M;
+				break;
+			case IEEE80211_OFDM_RATE_48MB:
+				*rate_cfg |= RATE_48M;
+				break;
+			case IEEE80211_OFDM_RATE_54MB:
+				*rate_cfg |= RATE_54M;
+				break;
+			}
+		}
+	}
+}
+
+static void one_out_pipe(struct adapter *adapter)
+{
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
+
+	pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+	pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
+	pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[0];/* BE */
+	pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[0];/* BK */
+
+	pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+	pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+	pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+	pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+}
+
+static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
+{
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
+
+	if (wifi_cfg) { /* WMM */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  0,  1,  0,  1,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[1];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[0];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+
+	} else {/* typical setting */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  1,	1,  0,  0,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+	}
+}
+
+static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
+{
+	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
+
+	if (wifi_cfg) {/* for WMM */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  1,	2,  1,  0,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:N, 2:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+
+	} else {/* typical setting */
+		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
+		/*  2,  2,  1,  0,   0,   0,   0,    0,    0}; */
+		/* 0:H, 1:N, 2:L */
+
+		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
+		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
+		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[2];/* BK */
+
+		pdvobjpriv->Queue2Pipe[4] = pdvobjpriv->RtOutPipe[0];/* BCN */
+		pdvobjpriv->Queue2Pipe[5] = pdvobjpriv->RtOutPipe[0];/* MGT */
+		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
+		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
+	}
+}
+
+bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
+{
+	struct registry_priv *pregistrypriv = &adapter->registrypriv;
+	bool  wifi_cfg = (pregistrypriv->wifi_spec) ? true : false;
+	bool result = true;
+
+	switch (numoutpipe) {
+	case 2:
+		two_out_pipe(adapter, wifi_cfg);
+		break;
+	case 3:
+		three_out_pipe(adapter, wifi_cfg);
+		break;
+	case 1:
+		one_out_pipe(adapter);
+		break;
+	default:
+		result = false;
+		break;
+	}
+	return result;
+}
+
+void hal_init_macaddr(struct adapter *adapter)
+{
+	rtw_hal_set_hwreg(adapter, HW_VAR_MAC_ADDR,
+			  adapter->eeprompriv.mac_addr);
+}
+
+/*
+* C2H event format:
+* Field	 TRIGGER		CONTENT	   CMD_SEQ	CMD_LEN		 CMD_ID
+* BITS	 [127:120]	[119:16]      [15:8]		  [7:4]		   [3:0]
+*/
+
+void c2h_evt_clear(struct adapter *adapter)
+{
+	rtw_write8(adapter, REG_C2HEVT_CLEAR, C2H_EVT_HOST_CLOSE);
+}
+
+s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
+{
+	s32 ret = _FAIL;
+	struct c2h_evt_hdr *c2h_evt;
+	int i;
+	u8 trigger;
+
+	if (buf == NULL)
+		goto exit;
+
+	trigger = rtw_read8(adapter, REG_C2HEVT_CLEAR);
+
+	if (trigger == C2H_EVT_HOST_CLOSE)
+		goto exit; /* Not ready */
+	else if (trigger != C2H_EVT_FW_CLOSE)
+		goto clear_evt; /* Not a valid value */
+
+	c2h_evt = (struct c2h_evt_hdr *)buf;
+
+	memset(c2h_evt, 0, 16);
+
+	*buf = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL);
+	*(buf+1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
+
+	RT_PRINT_DATA(_module_hal_init_c_, _drv_info_, "c2h_evt_read(): ",
+		      &c2h_evt , sizeof(c2h_evt));
+
+	/* Read the content */
+	for (i = 0; i < c2h_evt->plen; i++)
+		c2h_evt->payload[i] = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL +
+						sizeof(*c2h_evt) + i);
+
+	RT_PRINT_DATA(_module_hal_init_c_, _drv_info_,
+		      "c2h_evt_read(): Command Content:\n",
+		      c2h_evt->payload, c2h_evt->plen);
+
+	ret = _SUCCESS;
+
+clear_evt:
+	/*
+	* Clear event to notify FW we have read the command.
+	* If this field isn't clear, the FW won't update the next
+	* command message.
+	*/
+	c2h_evt_clear(adapter);
+exit:
+	return ret;
+}
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
new file mode 100644
index 000000000000..ce37c7594f2d
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -0,0 +1,468 @@
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
+
+#define _HAL_INTF_C_
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <hal_intf.h>
+#include <usb_hal.h>
+
+void rtw_hal_chip_configure(struct adapter *adapt)
+{
+	if (adapt->HalFunc.intf_chip_configure)
+		adapt->HalFunc.intf_chip_configure(adapt);
+}
+
+void rtw_hal_read_chip_info(struct adapter *adapt)
+{
+	if (adapt->HalFunc.read_adapter_info)
+		adapt->HalFunc.read_adapter_info(adapt);
+}
+
+void rtw_hal_read_chip_version(struct adapter *adapt)
+{
+	if (adapt->HalFunc.read_chip_version)
+		adapt->HalFunc.read_chip_version(adapt);
+}
+
+void rtw_hal_def_value_init(struct adapter *adapt)
+{
+	if (adapt->HalFunc.init_default_value)
+		adapt->HalFunc.init_default_value(adapt);
+}
+
+void rtw_hal_free_data(struct adapter *adapt)
+{
+	if (adapt->HalFunc.free_hal_data)
+		adapt->HalFunc.free_hal_data(adapt);
+}
+
+void rtw_hal_dm_init(struct adapter *adapt)
+{
+	if (adapt->HalFunc.dm_init)
+		adapt->HalFunc.dm_init(adapt);
+}
+
+void rtw_hal_dm_deinit(struct adapter *adapt)
+{
+	/*  cancel dm  timer */
+	if (adapt->HalFunc.dm_deinit)
+		adapt->HalFunc.dm_deinit(adapt);
+}
+
+void rtw_hal_sw_led_init(struct adapter *adapt)
+{
+	if (adapt->HalFunc.InitSwLeds)
+		adapt->HalFunc.InitSwLeds(adapt);
+}
+
+void rtw_hal_sw_led_deinit(struct adapter *adapt)
+{
+	if (adapt->HalFunc.DeInitSwLeds)
+		adapt->HalFunc.DeInitSwLeds(adapt);
+}
+
+u32 rtw_hal_power_on(struct adapter *adapt)
+{
+	if (adapt->HalFunc.hal_power_on)
+		return adapt->HalFunc.hal_power_on(adapt);
+	return _FAIL;
+}
+
+uint	 rtw_hal_init(struct adapter *adapt)
+{
+	uint	status = _SUCCESS;
+
+	adapt->hw_init_completed = false;
+
+	status = adapt->HalFunc.hal_init(adapt);
+
+	if (status == _SUCCESS) {
+		adapt->hw_init_completed = true;
+
+		if (adapt->registrypriv.notch_filter == 1)
+			rtw_hal_notch_filter(adapt, 1);
+
+		rtw_hal_reset_security_engine(adapt);
+	} else {
+		adapt->hw_init_completed = false;
+		DBG_88E("rtw_hal_init: hal__init fail\n");
+	}
+
+	RT_TRACE(_module_hal_init_c_, _drv_err_,
+		 ("-rtl871x_hal_init:status=0x%x\n", status));
+
+	return status;
+}
+
+uint rtw_hal_deinit(struct adapter *adapt)
+{
+	uint	status = _SUCCESS;
+
+	status = adapt->HalFunc.hal_deinit(adapt);
+
+	if (status == _SUCCESS)
+		adapt->hw_init_completed = false;
+	else
+		DBG_88E("\n rtw_hal_deinit: hal_init fail\n");
+
+	return status;
+}
+
+void rtw_hal_set_hwreg(struct adapter *adapt, u8 variable, u8 *val)
+{
+	if (adapt->HalFunc.SetHwRegHandler)
+		adapt->HalFunc.SetHwRegHandler(adapt, variable, val);
+}
+
+void rtw_hal_get_hwreg(struct adapter *adapt, u8 variable, u8 *val)
+{
+	if (adapt->HalFunc.GetHwRegHandler)
+		adapt->HalFunc.GetHwRegHandler(adapt, variable, val);
+}
+
+u8 rtw_hal_set_def_var(struct adapter *adapt, enum hal_def_variable var,
+		      void *val)
+{
+	if (adapt->HalFunc.SetHalDefVarHandler)
+		return adapt->HalFunc.SetHalDefVarHandler(adapt, var, val);
+	return _FAIL;
+}
+
+u8 rtw_hal_get_def_var(struct adapter *adapt,
+		       enum hal_def_variable var, void *val)
+{
+	if (adapt->HalFunc.GetHalDefVarHandler)
+		return adapt->HalFunc.GetHalDefVarHandler(adapt, var, val);
+	return _FAIL;
+}
+
+void rtw_hal_set_odm_var(struct adapter *adapt,
+			 enum hal_odm_variable var, void *val1,
+			 bool set)
+{
+	if (adapt->HalFunc.SetHalODMVarHandler)
+		adapt->HalFunc.SetHalODMVarHandler(adapt, var,
+						      val1, set);
+}
+
+void rtw_hal_get_odm_var(struct adapter *adapt,
+			 enum hal_odm_variable var, void *val1,
+			 bool set)
+{
+	if (adapt->HalFunc.GetHalODMVarHandler)
+		adapt->HalFunc.GetHalODMVarHandler(adapt, var,
+						      val1, set);
+}
+
+void rtw_hal_enable_interrupt(struct adapter *adapt)
+{
+	if (adapt->HalFunc.enable_interrupt)
+		adapt->HalFunc.enable_interrupt(adapt);
+	else
+		DBG_88E("%s: HalFunc.enable_interrupt is NULL!\n", __func__);
+}
+
+void rtw_hal_disable_interrupt(struct adapter *adapt)
+{
+	if (adapt->HalFunc.disable_interrupt)
+		adapt->HalFunc.disable_interrupt(adapt);
+	else
+		DBG_88E("%s: HalFunc.disable_interrupt is NULL!\n", __func__);
+}
+
+u32 rtw_hal_inirp_init(struct adapter *adapt)
+{
+	u32 rst = _FAIL;
+
+	if (adapt->HalFunc.inirp_init)
+		rst = adapt->HalFunc.inirp_init(adapt);
+	else
+		DBG_88E(" %s HalFunc.inirp_init is NULL!!!\n", __func__);
+	return rst;
+}
+
+u32 rtw_hal_inirp_deinit(struct adapter *adapt)
+{
+	if (adapt->HalFunc.inirp_deinit)
+		return adapt->HalFunc.inirp_deinit(adapt);
+
+	return _FAIL;
+}
+
+u8 rtw_hal_intf_ps_func(struct adapter *adapt,
+			enum hal_intf_ps_func efunc_id, u8 *val)
+{
+	if (adapt->HalFunc.interface_ps_func)
+		return adapt->HalFunc.interface_ps_func(adapt, efunc_id,
+							   val);
+	return _FAIL;
+}
+
+s32 rtw_hal_xmitframe_enqueue(struct adapter *padapter,
+			      struct xmit_frame *pxmitframe)
+{
+	if(padapter->HalFunc.hal_xmitframe_enqueue)
+		return padapter->HalFunc.hal_xmitframe_enqueue(padapter, pxmitframe);
+	return false;
+}
+
+s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
+{
+	if (adapt->HalFunc.hal_xmit)
+		return adapt->HalFunc.hal_xmit(adapt, pxmitframe);
+
+	return false;
+}
+
+s32 rtw_hal_mgnt_xmit(struct adapter *adapt, struct xmit_frame *pmgntframe)
+{
+	s32 ret = _FAIL;
+	if (adapt->HalFunc.mgnt_xmit)
+		ret = adapt->HalFunc.mgnt_xmit(adapt, pmgntframe);
+	return ret;
+}
+
+s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
+{
+	if (adapt->HalFunc.init_xmit_priv != NULL)
+		return adapt->HalFunc.init_xmit_priv(adapt);
+	return _FAIL;
+}
+
+void rtw_hal_free_xmit_priv(struct adapter *adapt)
+{
+	if (adapt->HalFunc.free_xmit_priv != NULL)
+		adapt->HalFunc.free_xmit_priv(adapt);
+}
+
+s32 rtw_hal_init_recv_priv(struct adapter *adapt)
+{
+	if (adapt->HalFunc.init_recv_priv)
+		return adapt->HalFunc.init_recv_priv(adapt);
+
+	return _FAIL;
+}
+
+void rtw_hal_free_recv_priv(struct adapter *adapt)
+{
+	if (adapt->HalFunc.free_recv_priv)
+		adapt->HalFunc.free_recv_priv(adapt);
+}
+
+void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
+{
+	struct mlme_priv *pmlmepriv = &(adapt->mlmepriv);
+
+	if (check_fwstate(pmlmepriv, WIFI_AP_STATE) == true) {
+#ifdef CONFIG_88EU_AP_MODE
+		struct sta_info *psta = NULL;
+		struct sta_priv *pstapriv = &adapt->stapriv;
+		if ((mac_id-1) > 0)
+			psta = pstapriv->sta_aid[(mac_id-1) - 1];
+		if (psta)
+			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
+#endif
+	} else {
+		if (adapt->HalFunc.UpdateRAMaskHandler)
+			adapt->HalFunc.UpdateRAMaskHandler(adapt, mac_id,
+							      rssi_level);
+	}
+}
+
+void rtw_hal_add_ra_tid(struct adapter *adapt, u32 bitmap, u8 arg,
+			u8 rssi_level)
+{
+	if (adapt->HalFunc.Add_RateATid)
+		adapt->HalFunc.Add_RateATid(adapt, bitmap, arg,
+					       rssi_level);
+}
+
+/*	Start specifical interface thread		*/
+void rtw_hal_start_thread(struct adapter *adapt)
+{
+	if (adapt->HalFunc.run_thread)
+		adapt->HalFunc.run_thread(adapt);
+}
+
+/*	Start specifical interface thread		*/
+void rtw_hal_stop_thread(struct adapter *adapt)
+{
+	if (adapt->HalFunc.cancel_thread)
+		adapt->HalFunc.cancel_thread(adapt);
+}
+
+u32 rtw_hal_read_bbreg(struct adapter *adapt, u32 regaddr, u32 bitmask)
+{
+	u32 data = 0;
+
+	if (adapt->HalFunc.read_bbreg)
+		data = adapt->HalFunc.read_bbreg(adapt, regaddr, bitmask);
+	return data;
+}
+
+void rtw_hal_write_bbreg(struct adapter *adapt, u32 regaddr, u32 bitmask,
+			 u32 data)
+{
+	if (adapt->HalFunc.write_bbreg)
+		adapt->HalFunc.write_bbreg(adapt, regaddr, bitmask, data);
+}
+
+u32 rtw_hal_read_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
+		       u32 regaddr, u32 bitmask)
+{
+	u32 data = 0;
+
+	if (adapt->HalFunc.read_rfreg)
+		data = adapt->HalFunc.read_rfreg(adapt, rfpath, regaddr,
+						    bitmask);
+	return data;
+}
+
+void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
+			 u32 regaddr, u32 bitmask, u32 data)
+{
+	if (adapt->HalFunc.write_rfreg)
+		adapt->HalFunc.write_rfreg(adapt, rfpath, regaddr,
+					      bitmask, data);
+}
+
+s32 rtw_hal_interrupt_handler(struct adapter *adapt)
+{
+	if (adapt->HalFunc.interrupt_handler)
+		return adapt->HalFunc.interrupt_handler(adapt);
+	return _FAIL;
+}
+
+void rtw_hal_set_bwmode(struct adapter *adapt,
+			enum ht_channel_width bandwidth, u8 offset)
+{
+	if (adapt->HalFunc.set_bwmode_handler)
+		adapt->HalFunc.set_bwmode_handler(adapt, bandwidth,
+						     offset);
+}
+
+void rtw_hal_set_chan(struct adapter *adapt, u8 channel)
+{
+	if (adapt->HalFunc.set_channel_handler)
+		adapt->HalFunc.set_channel_handler(adapt, channel);
+}
+
+void rtw_hal_dm_watchdog(struct adapter *adapt)
+{
+	if (adapt->HalFunc.hal_dm_watchdog)
+		adapt->HalFunc.hal_dm_watchdog(adapt);
+}
+
+void rtw_hal_bcn_related_reg_setting(struct adapter *adapt)
+{
+	if (adapt->HalFunc.SetBeaconRelatedRegistersHandler)
+		adapt->HalFunc.SetBeaconRelatedRegistersHandler(adapt);
+}
+
+u8 rtw_hal_antdiv_before_linked(struct adapter *adapt)
+{
+	if (adapt->HalFunc.AntDivBeforeLinkHandler)
+		return adapt->HalFunc.AntDivBeforeLinkHandler(adapt);
+	return false;
+}
+
+void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
+				  struct wlan_bssid_ex *dst,
+				  struct wlan_bssid_ex *src)
+{
+	if (adapt->HalFunc.AntDivCompareHandler)
+		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
+}
+
+void rtw_hal_sreset_init(struct adapter *adapt)
+{
+	if (adapt->HalFunc.sreset_init_value)
+		adapt->HalFunc.sreset_init_value(adapt);
+}
+
+void rtw_hal_sreset_reset(struct adapter *adapt)
+{
+	if (adapt->HalFunc.silentreset)
+		adapt->HalFunc.silentreset(adapt);
+}
+
+void rtw_hal_sreset_reset_value(struct adapter *adapt)
+{
+	if (adapt->HalFunc.sreset_reset_value)
+		adapt->HalFunc.sreset_reset_value(adapt);
+}
+
+void rtw_hal_sreset_xmit_status_check(struct adapter *adapt)
+{
+	if (adapt->HalFunc.sreset_xmit_status_check)
+		adapt->HalFunc.sreset_xmit_status_check(adapt);
+}
+
+void rtw_hal_sreset_linked_status_check(struct adapter *adapt)
+{
+	if (adapt->HalFunc.sreset_linked_status_check)
+		adapt->HalFunc.sreset_linked_status_check(adapt);
+}
+
+u8   rtw_hal_sreset_get_wifi_status(struct adapter *adapt)
+{
+	u8 status = 0;
+
+	if (adapt->HalFunc.sreset_get_wifi_status)
+		status = adapt->HalFunc.sreset_get_wifi_status(adapt);
+	return status;
+}
+
+int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
+		    u32 max_wating_ms, u32 bndy_cnt)
+{
+	if (adapter->HalFunc.IOL_exec_cmds_sync)
+		return adapter->HalFunc.IOL_exec_cmds_sync(adapter, xmit_frame,
+							   max_wating_ms,
+							   bndy_cnt);
+	return _FAIL;
+}
+
+void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
+{
+	if (adapter->HalFunc.hal_notch_filter)
+		adapter->HalFunc.hal_notch_filter(adapter, enable);
+}
+
+void rtw_hal_reset_security_engine(struct adapter *adapter)
+{
+	if (adapter->HalFunc.hal_reset_security_engine)
+		adapter->HalFunc.hal_reset_security_engine(adapter);
+}
+
+s32 rtw_hal_c2h_handler(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt)
+{
+	s32 ret = _FAIL;
+
+	if (adapter->HalFunc.c2h_handler)
+		ret = adapter->HalFunc.c2h_handler(adapter, c2h_evt);
+	return ret;
+}
+
+c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
+{
+	return adapter->HalFunc.c2h_id_filter_ccx;
+}
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
new file mode 100644
index 000000000000..8b8754c42bc1
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -0,0 +1,2174 @@
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
+/*  include files */
+
+#include "odm_precomp.h"
+
+static const u16 dB_Invert_Table[8][12] = {
+	{1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4},
+	{4, 5, 6, 6, 7, 8, 9, 10, 11, 13, 14, 16},
+	{18, 20, 22, 25, 28, 32, 35, 40, 45, 50, 56, 63},
+	{71, 79, 89, 100, 112, 126, 141, 158, 178, 200, 224, 251},
+	{282, 316, 355, 398, 447, 501, 562, 631, 708, 794, 891, 1000},
+	{1122, 1259, 1413, 1585, 1778, 1995, 2239, 2512, 2818, 3162, 3548, 3981},
+	{4467, 5012, 5623, 6310, 7079, 7943, 8913, 10000, 11220, 12589, 14125, 15849},
+	{17783, 19953, 22387, 25119, 28184, 31623, 35481, 39811, 44668, 50119, 56234, 65535}
+};
+
+/* avoid to warn in FreeBSD ==> To DO modify */
+static u32 EDCAParam[HT_IOT_PEER_MAX][3] = {
+	/*  UL			DL */
+	{0x5ea42b, 0x5ea42b, 0x5ea42b}, /* 0:unknown AP */
+	{0xa44f, 0x5ea44f, 0x5e431c}, /*  1:realtek AP */
+	{0x5ea42b, 0x5ea42b, 0x5ea42b}, /*  2:unknown AP => realtek_92SE */
+	{0x5ea32b, 0x5ea42b, 0x5e4322}, /*  3:broadcom AP */
+	{0x5ea422, 0x00a44f, 0x00a44f}, /*  4:ralink AP */
+	{0x5ea322, 0x00a630, 0x00a44f}, /*  5:atheros AP */
+	{0x5e4322, 0x5e4322, 0x5e4322},/*  6:cisco AP */
+	{0x5ea44f, 0x00a44f, 0x5ea42b}, /*  8:marvell AP */
+	{0x5ea42b, 0x5ea42b, 0x5ea42b}, /*  10:unknown AP=> 92U AP */
+	{0x5ea42b, 0xa630, 0x5e431c}, /*  11:airgocap AP */
+};
+
+/*  Global var */
+u32 OFDMSwingTable[OFDM_TABLE_SIZE_92D] = {
+	0x7f8001fe, /*  0, +6.0dB */
+	0x788001e2, /*  1, +5.5dB */
+	0x71c001c7, /*  2, +5.0dB */
+	0x6b8001ae, /*  3, +4.5dB */
+	0x65400195, /*  4, +4.0dB */
+	0x5fc0017f, /*  5, +3.5dB */
+	0x5a400169, /*  6, +3.0dB */
+	0x55400155, /*  7, +2.5dB */
+	0x50800142, /*  8, +2.0dB */
+	0x4c000130, /*  9, +1.5dB */
+	0x47c0011f, /*  10, +1.0dB */
+	0x43c0010f, /*  11, +0.5dB */
+	0x40000100, /*  12, +0dB */
+	0x3c8000f2, /*  13, -0.5dB */
+	0x390000e4, /*  14, -1.0dB */
+	0x35c000d7, /*  15, -1.5dB */
+	0x32c000cb, /*  16, -2.0dB */
+	0x300000c0, /*  17, -2.5dB */
+	0x2d4000b5, /*  18, -3.0dB */
+	0x2ac000ab, /*  19, -3.5dB */
+	0x288000a2, /*  20, -4.0dB */
+	0x26000098, /*  21, -4.5dB */
+	0x24000090, /*  22, -5.0dB */
+	0x22000088, /*  23, -5.5dB */
+	0x20000080, /*  24, -6.0dB */
+	0x1e400079, /*  25, -6.5dB */
+	0x1c800072, /*  26, -7.0dB */
+	0x1b00006c, /*  27. -7.5dB */
+	0x19800066, /*  28, -8.0dB */
+	0x18000060, /*  29, -8.5dB */
+	0x16c0005b, /*  30, -9.0dB */
+	0x15800056, /*  31, -9.5dB */
+	0x14400051, /*  32, -10.0dB */
+	0x1300004c, /*  33, -10.5dB */
+	0x12000048, /*  34, -11.0dB */
+	0x11000044, /*  35, -11.5dB */
+	0x10000040, /*  36, -12.0dB */
+	0x0f00003c,/*  37, -12.5dB */
+	0x0e400039,/*  38, -13.0dB */
+	0x0d800036,/*  39, -13.5dB */
+	0x0cc00033,/*  40, -14.0dB */
+	0x0c000030,/*  41, -14.5dB */
+	0x0b40002d,/*  42, -15.0dB */
+};
+
+u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8] = {
+	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04}, /*  0, +0dB */
+	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04}, /*  1, -0.5dB */
+	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03}, /*  2, -1.0dB */
+	{0x2d, 0x2d, 0x27, 0x1f, 0x18, 0x0f, 0x08, 0x03}, /*  3, -1.5dB */
+	{0x2b, 0x2a, 0x25, 0x1e, 0x16, 0x0e, 0x07, 0x03}, /*  4, -2.0dB */
+	{0x28, 0x28, 0x22, 0x1c, 0x15, 0x0d, 0x07, 0x03}, /*  5, -2.5dB */
+	{0x26, 0x25, 0x21, 0x1b, 0x14, 0x0d, 0x06, 0x03}, /*  6, -3.0dB */
+	{0x24, 0x23, 0x1f, 0x19, 0x13, 0x0c, 0x06, 0x03}, /*  7, -3.5dB */
+	{0x22, 0x21, 0x1d, 0x18, 0x11, 0x0b, 0x06, 0x02}, /*  8, -4.0dB */
+	{0x20, 0x20, 0x1b, 0x16, 0x11, 0x08, 0x05, 0x02}, /*  9, -4.5dB */
+	{0x1f, 0x1e, 0x1a, 0x15, 0x10, 0x0a, 0x05, 0x02}, /*  10, -5.0dB */
+	{0x1d, 0x1c, 0x18, 0x14, 0x0f, 0x0a, 0x05, 0x02}, /*  11, -5.5dB */
+	{0x1b, 0x1a, 0x17, 0x13, 0x0e, 0x09, 0x04, 0x02}, /*  12, -6.0dB */
+	{0x1a, 0x19, 0x16, 0x12, 0x0d, 0x09, 0x04, 0x02}, /*  13, -6.5dB */
+	{0x18, 0x17, 0x15, 0x11, 0x0c, 0x08, 0x04, 0x02}, /*  14, -7.0dB */
+	{0x17, 0x16, 0x13, 0x10, 0x0c, 0x08, 0x04, 0x02}, /*  15, -7.5dB */
+	{0x16, 0x15, 0x12, 0x0f, 0x0b, 0x07, 0x04, 0x01}, /*  16, -8.0dB */
+	{0x14, 0x14, 0x11, 0x0e, 0x0b, 0x07, 0x03, 0x02}, /*  17, -8.5dB */
+	{0x13, 0x13, 0x10, 0x0d, 0x0a, 0x06, 0x03, 0x01}, /*  18, -9.0dB */
+	{0x12, 0x12, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01}, /*  19, -9.5dB */
+	{0x11, 0x11, 0x0f, 0x0c, 0x09, 0x06, 0x03, 0x01}, /*  20, -10.0dB */
+	{0x10, 0x10, 0x0e, 0x0b, 0x08, 0x05, 0x03, 0x01}, /*  21, -10.5dB */
+	{0x0f, 0x0f, 0x0d, 0x0b, 0x08, 0x05, 0x03, 0x01}, /*  22, -11.0dB */
+	{0x0e, 0x0e, 0x0c, 0x0a, 0x08, 0x05, 0x02, 0x01}, /*  23, -11.5dB */
+	{0x0d, 0x0d, 0x0c, 0x0a, 0x07, 0x05, 0x02, 0x01}, /*  24, -12.0dB */
+	{0x0d, 0x0c, 0x0b, 0x09, 0x07, 0x04, 0x02, 0x01}, /*  25, -12.5dB */
+	{0x0c, 0x0c, 0x0a, 0x09, 0x06, 0x04, 0x02, 0x01}, /*  26, -13.0dB */
+	{0x0b, 0x0b, 0x0a, 0x08, 0x06, 0x04, 0x02, 0x01}, /*  27, -13.5dB */
+	{0x0b, 0x0a, 0x09, 0x08, 0x06, 0x04, 0x02, 0x01}, /*  28, -14.0dB */
+	{0x0a, 0x0a, 0x09, 0x07, 0x05, 0x03, 0x02, 0x01}, /*  29, -14.5dB */
+	{0x0a, 0x09, 0x08, 0x07, 0x05, 0x03, 0x02, 0x01}, /*  30, -15.0dB */
+	{0x09, 0x09, 0x08, 0x06, 0x05, 0x03, 0x01, 0x01}, /*  31, -15.5dB */
+	{0x09, 0x08, 0x07, 0x06, 0x04, 0x03, 0x01, 0x01}	/*  32, -16.0dB */
+};
+
+u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8] = {
+	{0x36, 0x35, 0x2e, 0x1b, 0x00, 0x00, 0x00, 0x00}, /*  0, +0dB */
+	{0x33, 0x32, 0x2b, 0x19, 0x00, 0x00, 0x00, 0x00}, /*  1, -0.5dB */
+	{0x30, 0x2f, 0x29, 0x18, 0x00, 0x00, 0x00, 0x00}, /*  2, -1.0dB */
+	{0x2d, 0x2d, 0x17, 0x17, 0x00, 0x00, 0x00, 0x00}, /*  3, -1.5dB */
+	{0x2b, 0x2a, 0x25, 0x15, 0x00, 0x00, 0x00, 0x00}, /*  4, -2.0dB */
+	{0x28, 0x28, 0x24, 0x14, 0x00, 0x00, 0x00, 0x00}, /*  5, -2.5dB */
+	{0x26, 0x25, 0x21, 0x13, 0x00, 0x00, 0x00, 0x00}, /*  6, -3.0dB */
+	{0x24, 0x23, 0x1f, 0x12, 0x00, 0x00, 0x00, 0x00}, /*  7, -3.5dB */
+	{0x22, 0x21, 0x1d, 0x11, 0x00, 0x00, 0x00, 0x00}, /*  8, -4.0dB */
+	{0x20, 0x20, 0x1b, 0x10, 0x00, 0x00, 0x00, 0x00}, /*  9, -4.5dB */
+	{0x1f, 0x1e, 0x1a, 0x0f, 0x00, 0x00, 0x00, 0x00}, /*  10, -5.0dB */
+	{0x1d, 0x1c, 0x18, 0x0e, 0x00, 0x00, 0x00, 0x00}, /*  11, -5.5dB */
+	{0x1b, 0x1a, 0x17, 0x0e, 0x00, 0x00, 0x00, 0x00}, /*  12, -6.0dB */
+	{0x1a, 0x19, 0x16, 0x0d, 0x00, 0x00, 0x00, 0x00}, /*  13, -6.5dB */
+	{0x18, 0x17, 0x15, 0x0c, 0x00, 0x00, 0x00, 0x00}, /*  14, -7.0dB */
+	{0x17, 0x16, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x00}, /*  15, -7.5dB */
+	{0x16, 0x15, 0x12, 0x0b, 0x00, 0x00, 0x00, 0x00}, /*  16, -8.0dB */
+	{0x14, 0x14, 0x11, 0x0a, 0x00, 0x00, 0x00, 0x00}, /*  17, -8.5dB */
+	{0x13, 0x13, 0x10, 0x0a, 0x00, 0x00, 0x00, 0x00}, /*  18, -9.0dB */
+	{0x12, 0x12, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00}, /*  19, -9.5dB */
+	{0x11, 0x11, 0x0f, 0x09, 0x00, 0x00, 0x00, 0x00}, /*  20, -10.0dB */
+	{0x10, 0x10, 0x0e, 0x08, 0x00, 0x00, 0x00, 0x00}, /*  21, -10.5dB */
+	{0x0f, 0x0f, 0x0d, 0x08, 0x00, 0x00, 0x00, 0x00}, /*  22, -11.0dB */
+	{0x0e, 0x0e, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00}, /*  23, -11.5dB */
+	{0x0d, 0x0d, 0x0c, 0x07, 0x00, 0x00, 0x00, 0x00}, /*  24, -12.0dB */
+	{0x0d, 0x0c, 0x0b, 0x06, 0x00, 0x00, 0x00, 0x00}, /*  25, -12.5dB */
+	{0x0c, 0x0c, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00}, /*  26, -13.0dB */
+	{0x0b, 0x0b, 0x0a, 0x06, 0x00, 0x00, 0x00, 0x00}, /*  27, -13.5dB */
+	{0x0b, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  28, -14.0dB */
+	{0x0a, 0x0a, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  29, -14.5dB */
+	{0x0a, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  30, -15.0dB */
+	{0x09, 0x09, 0x08, 0x05, 0x00, 0x00, 0x00, 0x00}, /*  31, -15.5dB */
+	{0x09, 0x08, 0x07, 0x04, 0x00, 0x00, 0x00, 0x00}  /*  32, -16.0dB */
+};
+
+#define		RxDefaultAnt1		0x65a9
+#define	RxDefaultAnt2		0x569a
+
+/* 3 Export Interface */
+
+/*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
+void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
+{
+	/* 2012.05.03 Luke: For all IC series */
+	odm_CommonInfoSelfInit(pDM_Odm);
+	odm_CmnInfoInit_Debug(pDM_Odm);
+	odm_DIGInit(pDM_Odm);
+	odm_RateAdaptiveMaskInit(pDM_Odm);
+
+	if (pDM_Odm->SupportICType & ODM_IC_11AC_SERIES) {
+		;
+	} else if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
+		odm_PrimaryCCA_Init(pDM_Odm);    /*  Gary */
+		odm_DynamicBBPowerSavingInit(pDM_Odm);
+		odm_DynamicTxPowerInit(pDM_Odm);
+		odm_TXPowerTrackingInit(pDM_Odm);
+		ODM_EdcaTurboInit(pDM_Odm);
+		ODM_RAInfo_Init_all(pDM_Odm);
+		if ((pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)	||
+		    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV) ||
+		    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
+			odm_InitHybridAntDiv(pDM_Odm);
+		else if (pDM_Odm->AntDivType == CGCS_RX_SW_ANTDIV)
+			odm_SwAntDivInit(pDM_Odm);
+	}
+}
+
+/*  2011/09/20 MH This is the entry pointer for all team to execute HW out source DM. */
+/*  You can not add any dummy function here, be care, you can only use DM structure */
+/*  to perform any new ODM_DM. */
+void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm)
+{
+	/* 2012.05.03 Luke: For all IC series */
+	odm_GlobalAdapterCheck();
+	odm_CmnInfoHook_Debug(pDM_Odm);
+	odm_CmnInfoUpdate_Debug(pDM_Odm);
+	odm_CommonInfoSelfUpdate(pDM_Odm);
+	odm_FalseAlarmCounterStatistics(pDM_Odm);
+	odm_RSSIMonitorCheck(pDM_Odm);
+
+	/* For CE Platform(SPRD or Tablet) */
+	/* 8723A or 8189ES platform */
+	/* NeilChen--2012--08--24-- */
+	/* Fix Leave LPS issue */
+	if ((pDM_Odm->Adapter->pwrctrlpriv.pwr_mode != PS_MODE_ACTIVE) &&/*  in LPS mode */
+	    ((pDM_Odm->SupportICType & (ODM_RTL8723A)) ||
+	    (pDM_Odm->SupportICType & (ODM_RTL8188E) &&
+	    ((pDM_Odm->SupportInterface  == ODM_ITRF_SDIO))))) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("----Step1: odm_DIG is in LPS mode\n"));
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("---Step2: 8723AS is in LPS mode\n"));
+		odm_DIGbyRSSI_LPS(pDM_Odm);
+	} else {
+		odm_DIG(pDM_Odm);
+	}
+	odm_CCKPacketDetectionThresh(pDM_Odm);
+
+	if (*(pDM_Odm->pbPowerSaving))
+		return;
+
+	odm_RefreshRateAdaptiveMask(pDM_Odm);
+
+	odm_DynamicBBPowerSaving(pDM_Odm);
+	odm_DynamicPrimaryCCA(pDM_Odm);
+	if ((pDM_Odm->AntDivType ==  CG_TRX_HW_ANTDIV)	||
+	    (pDM_Odm->AntDivType == CGCS_RX_HW_ANTDIV)	||
+	    (pDM_Odm->AntDivType == CG_TRX_SMART_ANTDIV))
+		odm_HwAntDiv(pDM_Odm);
+	else if (pDM_Odm->AntDivType == CGCS_RX_SW_ANTDIV)
+		odm_SwAntDivChkAntSwitch(pDM_Odm, SWAW_STEP_PEAK);
+
+	if (pDM_Odm->SupportICType & ODM_IC_11AC_SERIES) {
+		;
+	} else if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
+		ODM_TXPowerTrackingCheck(pDM_Odm);
+	      odm_EdcaTurboCheck(pDM_Odm);
+		odm_DynamicTxPower(pDM_Odm);
+	}
+	odm_dtc(pDM_Odm);
+}
+
+/*  Init /.. Fixed HW value. Only init time. */
+void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, u32 Value)
+{
+	/*  This section is used for init value */
+	switch	(CmnInfo) {
+	/*  Fixed ODM value. */
+	case	ODM_CMNINFO_ABILITY:
+		pDM_Odm->SupportAbility = (u32)Value;
+		break;
+	case	ODM_CMNINFO_PLATFORM:
+		pDM_Odm->SupportPlatform = (u8)Value;
+		break;
+	case	ODM_CMNINFO_INTERFACE:
+		pDM_Odm->SupportInterface = (u8)Value;
+		break;
+	case	ODM_CMNINFO_MP_TEST_CHIP:
+		pDM_Odm->bIsMPChip = (u8)Value;
+		break;
+	case	ODM_CMNINFO_IC_TYPE:
+		pDM_Odm->SupportICType = Value;
+		break;
+	case	ODM_CMNINFO_CUT_VER:
+		pDM_Odm->CutVersion = (u8)Value;
+		break;
+	case	ODM_CMNINFO_FAB_VER:
+		pDM_Odm->FabVersion = (u8)Value;
+		break;
+	case	ODM_CMNINFO_RF_TYPE:
+		pDM_Odm->RFType = (u8)Value;
+		break;
+	case    ODM_CMNINFO_RF_ANTENNA_TYPE:
+		pDM_Odm->AntDivType = (u8)Value;
+		break;
+	case	ODM_CMNINFO_BOARD_TYPE:
+		pDM_Odm->BoardType = (u8)Value;
+		break;
+	case	ODM_CMNINFO_EXT_LNA:
+		pDM_Odm->ExtLNA = (u8)Value;
+		break;
+	case	ODM_CMNINFO_EXT_PA:
+		pDM_Odm->ExtPA = (u8)Value;
+		break;
+	case	ODM_CMNINFO_EXT_TRSW:
+		pDM_Odm->ExtTRSW = (u8)Value;
+		break;
+	case	ODM_CMNINFO_PATCH_ID:
+		pDM_Odm->PatchID = (u8)Value;
+		break;
+	case	ODM_CMNINFO_BINHCT_TEST:
+		pDM_Odm->bInHctTest = (bool)Value;
+		break;
+	case	ODM_CMNINFO_BWIFI_TEST:
+		pDM_Odm->bWIFITest = (bool)Value;
+		break;
+	case	ODM_CMNINFO_SMART_CONCURRENT:
+		pDM_Odm->bDualMacSmartConcurrent = (bool)Value;
+		break;
+	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
+	default:
+		/* do nothing */
+		break;
+	}
+
+	/*  Tx power tracking BB swing table. */
+	/*  The base index = 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB */
+	pDM_Odm->BbSwingIdxOfdm			= 12; /*  Set defalut value as index 12. */
+	pDM_Odm->BbSwingIdxOfdmCurrent	= 12;
+	pDM_Odm->BbSwingFlagOfdm		= false;
+}
+
+void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, void *pValue)
+{
+	/*  */
+	/*  Hook call by reference pointer. */
+	/*  */
+	switch	(CmnInfo) {
+	/*  Dynamic call by reference pointer. */
+	case	ODM_CMNINFO_MAC_PHY_MODE:
+		pDM_Odm->pMacPhyMode = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_TX_UNI:
+		pDM_Odm->pNumTxBytesUnicast = (u64 *)pValue;
+		break;
+	case	ODM_CMNINFO_RX_UNI:
+		pDM_Odm->pNumRxBytesUnicast = (u64 *)pValue;
+		break;
+	case	ODM_CMNINFO_WM_MODE:
+		pDM_Odm->pWirelessMode = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_BAND:
+		pDM_Odm->pBandType = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
+		pDM_Odm->pSecChOffset = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_SEC_MODE:
+		pDM_Odm->pSecurity = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_BW:
+		pDM_Odm->pBandWidth = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_CHNL:
+		pDM_Odm->pChannel = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_DMSP_GET_VALUE:
+		pDM_Odm->pbGetValueFromOtherMac = (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_BUDDY_ADAPTOR:
+		pDM_Odm->pBuddyAdapter = (struct adapter **)pValue;
+		break;
+	case	ODM_CMNINFO_DMSP_IS_MASTER:
+		pDM_Odm->pbMasterOfDMSP = (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_SCAN:
+		pDM_Odm->pbScanInProcess = (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_POWER_SAVING:
+		pDM_Odm->pbPowerSaving = (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_ONE_PATH_CCA:
+		pDM_Odm->pOnePathCCA = (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_DRV_STOP:
+		pDM_Odm->pbDriverStopped =  (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_PNP_IN:
+		pDM_Odm->pbDriverIsGoingToPnpSetPowerSleep =  (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_INIT_ON:
+		pDM_Odm->pinit_adpt_in_progress =  (bool *)pValue;
+		break;
+	case	ODM_CMNINFO_ANT_TEST:
+		pDM_Odm->pAntennaTest =  (u8 *)pValue;
+		break;
+	case	ODM_CMNINFO_NET_CLOSED:
+		pDM_Odm->pbNet_closed = (bool *)pValue;
+		break;
+	case    ODM_CMNINFO_MP_MODE:
+		pDM_Odm->mp_mode = (u8 *)pValue;
+		break;
+	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
+	default:
+		/* do nothing */
+		break;
+	}
+}
+
+void ODM_CmnInfoPtrArrayHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, u16 Index, void *pValue)
+{
+	/*  Hook call by reference pointer. */
+	switch	(CmnInfo) {
+	/*  Dynamic call by reference pointer. */
+	case	ODM_CMNINFO_STA_STATUS:
+		pDM_Odm->pODM_StaInfo[Index] = (struct sta_info *)pValue;
+		break;
+	/* To remove the compiler warning, must add an empty default statement to handle the other values. */
+	default:
+		/* do nothing */
+		break;
+	}
+}
+
+/*  Update Band/CHannel/.. The values are dynamic but non-per-packet. */
+void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
+{
+	/*  */
+	/*  This init variable may be changed in run time. */
+	/*  */
+	switch	(CmnInfo) {
+	case	ODM_CMNINFO_ABILITY:
+		pDM_Odm->SupportAbility = (u32)Value;
+		break;
+	case	ODM_CMNINFO_RF_TYPE:
+		pDM_Odm->RFType = (u8)Value;
+		break;
+	case	ODM_CMNINFO_WIFI_DIRECT:
+		pDM_Odm->bWIFI_Direct = (bool)Value;
+		break;
+	case	ODM_CMNINFO_WIFI_DISPLAY:
+		pDM_Odm->bWIFI_Display = (bool)Value;
+		break;
+	case	ODM_CMNINFO_LINK:
+		pDM_Odm->bLinked = (bool)Value;
+		break;
+	case	ODM_CMNINFO_RSSI_MIN:
+		pDM_Odm->RSSI_Min = (u8)Value;
+		break;
+	case	ODM_CMNINFO_DBG_COMP:
+		pDM_Odm->DebugComponents = Value;
+		break;
+	case	ODM_CMNINFO_DBG_LEVEL:
+		pDM_Odm->DebugLevel = (u32)Value;
+		break;
+	case	ODM_CMNINFO_RA_THRESHOLD_HIGH:
+		pDM_Odm->RateAdaptive.HighRSSIThresh = (u8)Value;
+		break;
+	case	ODM_CMNINFO_RA_THRESHOLD_LOW:
+		pDM_Odm->RateAdaptive.LowRSSIThresh = (u8)Value;
+		break;
+	}
+}
+
+void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
+{
+	pDM_Odm->bCckHighPower = (bool) ODM_GetBBReg(pDM_Odm, 0x824, BIT9);
+	pDM_Odm->RFPathRxEnable = (u8) ODM_GetBBReg(pDM_Odm, 0xc04, 0x0F);
+	if (pDM_Odm->SupportICType & (ODM_RTL8192C|ODM_RTL8192D))
+		pDM_Odm->AntDivType = CG_TRX_HW_ANTDIV;
+	if (pDM_Odm->SupportICType & (ODM_RTL8723A))
+		pDM_Odm->AntDivType = CGCS_RX_SW_ANTDIV;
+
+	ODM_InitDebugSetting(pDM_Odm);
+}
+
+void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
+{
+	u8 EntryCnt = 0;
+	u8 i;
+	struct sta_info *pEntry;
+
+	if (*(pDM_Odm->pBandWidth) == ODM_BW40M) {
+		if (*(pDM_Odm->pSecChOffset) == 1)
+			pDM_Odm->ControlChannel = *(pDM_Odm->pChannel) - 2;
+		else if (*(pDM_Odm->pSecChOffset) == 2)
+			pDM_Odm->ControlChannel = *(pDM_Odm->pChannel) + 2;
+	} else {
+		pDM_Odm->ControlChannel = *(pDM_Odm->pChannel);
+	}
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		pEntry = pDM_Odm->pODM_StaInfo[i];
+		if (IS_STA_VALID(pEntry))
+			EntryCnt++;
+	}
+	if (EntryCnt == 1)
+		pDM_Odm->bOneEntryOnly = true;
+	else
+		pDM_Odm->bOneEntryOnly = false;
+}
+
+void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm)
+{
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoInit_Debug==>\n"));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportPlatform=%d\n", pDM_Odm->SupportPlatform));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportAbility=0x%x\n", pDM_Odm->SupportAbility));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportInterface=%d\n", pDM_Odm->SupportInterface));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportICType=0x%x\n", pDM_Odm->SupportICType));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("CutVersion=%d\n", pDM_Odm->CutVersion));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("FabVersion=%d\n", pDM_Odm->FabVersion));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RFType=%d\n", pDM_Odm->RFType));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("BoardType=%d\n", pDM_Odm->BoardType));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtLNA=%d\n", pDM_Odm->ExtLNA));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtPA=%d\n", pDM_Odm->ExtPA));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("ExtTRSW=%d\n", pDM_Odm->ExtTRSW));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("PatchID=%d\n", pDM_Odm->PatchID));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bInHctTest=%d\n", pDM_Odm->bInHctTest));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFITest=%d\n", pDM_Odm->bWIFITest));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bDualMacSmartConcurrent=%d\n", pDM_Odm->bDualMacSmartConcurrent));
+}
+
+void odm_CmnInfoHook_Debug(struct odm_dm_struct *pDM_Odm)
+{
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoHook_Debug==>\n"));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pNumTxBytesUnicast=%llu\n", *(pDM_Odm->pNumTxBytesUnicast)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pNumRxBytesUnicast=%llu\n", *(pDM_Odm->pNumRxBytesUnicast)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pWirelessMode=0x%x\n", *(pDM_Odm->pWirelessMode)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pSecChOffset=%d\n", *(pDM_Odm->pSecChOffset)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pSecurity=%d\n", *(pDM_Odm->pSecurity)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pBandWidth=%d\n", *(pDM_Odm->pBandWidth)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pChannel=%d\n", *(pDM_Odm->pChannel)));
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pbScanInProcess=%d\n", *(pDM_Odm->pbScanInProcess)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pbPowerSaving=%d\n", *(pDM_Odm->pbPowerSaving)));
+
+	if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL))
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("pOnePathCCA=%d\n", *(pDM_Odm->pOnePathCCA)));
+}
+
+void odm_CmnInfoUpdate_Debug(struct odm_dm_struct *pDM_Odm)
+{
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoUpdate_Debug==>\n"));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFI_Direct=%d\n", pDM_Odm->bWIFI_Direct));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bWIFI_Display=%d\n", pDM_Odm->bWIFI_Display));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("bLinked=%d\n", pDM_Odm->bLinked));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("RSSI_Min=%d\n", pDM_Odm->RSSI_Min));
+}
+
+static int getIGIForDiff(int value_IGI)
+{
+	#define ONERCCA_LOW_TH		0x30
+	#define ONERCCA_LOW_DIFF	8
+
+	if (value_IGI < ONERCCA_LOW_TH) {
+		if ((ONERCCA_LOW_TH - value_IGI) < ONERCCA_LOW_DIFF)
+			return ONERCCA_LOW_TH;
+		else
+			return value_IGI + ONERCCA_LOW_DIFF;
+	} else {
+		return value_IGI;
+	}
+}
+
+void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
+{
+	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
+		     ("ODM_REG(IGI_A,pDM_Odm)=0x%x, ODM_BIT(IGI,pDM_Odm)=0x%x\n",
+		     ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm)));
+
+	if (pDM_DigTable->CurIGValue != CurrentIGI) {
+		if (pDM_Odm->SupportPlatform & (ODM_CE|ODM_MP)) {
+			ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+				if (pDM_Odm->SupportICType != ODM_RTL8188E)
+				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+		} else if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
+			switch (*(pDM_Odm->pOnePathCCA)) {
+			case ODM_CCA_2R:
+				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+					if (pDM_Odm->SupportICType != ODM_RTL8188E)
+					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+				break;
+			case ODM_CCA_1R_A:
+				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+					if (pDM_Odm->SupportICType != ODM_RTL8188E)
+					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), getIGIForDiff(CurrentIGI));
+				break;
+			case ODM_CCA_1R_B:
+				ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm), getIGIForDiff(CurrentIGI));
+					if (pDM_Odm->SupportICType != ODM_RTL8188E)
+					ODM_SetBBReg(pDM_Odm, ODM_REG(IGI_B, pDM_Odm), ODM_BIT(IGI, pDM_Odm), CurrentIGI);
+					break;
+				}
+		}
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("CurrentIGI(0x%02x).\n", CurrentIGI));
+		/* pDM_DigTable->PreIGValue = pDM_DigTable->CurIGValue; */
+		pDM_DigTable->CurIGValue = CurrentIGI;
+	}
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("ODM_Write_DIG():CurrentIGI=0x%x\n", CurrentIGI));
+
+/*  Add by Neil Chen to enable edcca to MP Platform */
+}
+
+/* Need LPS mode for CE platform --2012--08--24--- */
+/* 8723AS/8189ES */
+void odm_DIGbyRSSI_LPS(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *pAdapter = pDM_Odm->Adapter;
+	struct false_alarm_stats *pFalseAlmCnt = &pDM_Odm->FalseAlmCnt;
+
+	u8 RSSI_Lower = DM_DIG_MIN_NIC;   /* 0x1E or 0x1C */
+	u8 bFwCurrentInPSMode = false;
+	u8 CurrentIGI = pDM_Odm->RSSI_Min;
+
+	if (!(pDM_Odm->SupportICType & (ODM_RTL8723A | ODM_RTL8188E)))
+		return;
+
+	CurrentIGI = CurrentIGI + RSSI_OFFSET_DIG;
+	bFwCurrentInPSMode = pAdapter->pwrctrlpriv.bFwCurrentInPSMode;
+
+	/*  Using FW PS mode to make IGI */
+	if (bFwCurrentInPSMode) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("---Neil---odm_DIG is in LPS mode\n"));
+		/* Adjust by  FA in LPS MODE */
+		if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_LPS)
+			CurrentIGI = CurrentIGI+2;
+		else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1_LPS)
+			CurrentIGI = CurrentIGI+1;
+		else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0_LPS)
+			CurrentIGI = CurrentIGI-1;
+	} else {
+		CurrentIGI = RSSI_Lower;
+	}
+
+	/* Lower bound checking */
+
+	/* RSSI Lower bound check */
+	if ((pDM_Odm->RSSI_Min-10) > DM_DIG_MIN_NIC)
+		RSSI_Lower = (pDM_Odm->RSSI_Min-10);
+	else
+		RSSI_Lower = DM_DIG_MIN_NIC;
+
+	/* Upper and Lower Bound checking */
+	 if (CurrentIGI > DM_DIG_MAX_NIC)
+		CurrentIGI = DM_DIG_MAX_NIC;
+	 else if (CurrentIGI < RSSI_Lower)
+		CurrentIGI = RSSI_Lower;
+
+	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
+}
+
+void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+
+	pDM_DigTable->CurIGValue = (u8) ODM_GetBBReg(pDM_Odm, ODM_REG(IGI_A, pDM_Odm), ODM_BIT(IGI, pDM_Odm));
+	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
+	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
+	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
+	pDM_DigTable->FAHighThresh	= DM_false_ALARM_THRESH_HIGH;
+	if (pDM_Odm->BoardType == ODM_BOARD_HIGHPWR) {
+		pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
+		pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
+	} else {
+		pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
+		pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
+	}
+	pDM_DigTable->BackoffVal = DM_DIG_BACKOFF_DEFAULT;
+	pDM_DigTable->BackoffVal_range_max = DM_DIG_BACKOFF_MAX;
+	pDM_DigTable->BackoffVal_range_min = DM_DIG_BACKOFF_MIN;
+	pDM_DigTable->PreCCK_CCAThres = 0xFF;
+	pDM_DigTable->CurCCK_CCAThres = 0x83;
+	pDM_DigTable->ForbiddenIGI = DM_DIG_MIN_NIC;
+	pDM_DigTable->LargeFAHit = 0;
+	pDM_DigTable->Recover_cnt = 0;
+	pDM_DigTable->DIG_Dynamic_MIN_0 = DM_DIG_MIN_NIC;
+	pDM_DigTable->DIG_Dynamic_MIN_1 = DM_DIG_MIN_NIC;
+	pDM_DigTable->bMediaConnect_0 = false;
+	pDM_DigTable->bMediaConnect_1 = false;
+
+	/* To Initialize pDM_Odm->bDMInitialGainEnable == false to avoid DIG error */
+	pDM_Odm->bDMInitialGainEnable = true;
+}
+
+void odm_DIG(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+	struct false_alarm_stats *pFalseAlmCnt = &pDM_Odm->FalseAlmCnt;
+	u8 DIG_Dynamic_MIN;
+	u8 DIG_MaxOfMin;
+	bool FirstConnect, FirstDisConnect;
+	u8 dm_dig_max, dm_dig_min;
+	u8 CurrentIGI = pDM_DigTable->CurIGValue;
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG()==>\n"));
+	if ((!(pDM_Odm->SupportAbility&ODM_BB_DIG)) || (!(pDM_Odm->SupportAbility&ODM_BB_FA_CNT))) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
+			     ("odm_DIG() Return: SupportAbility ODM_BB_DIG or ODM_BB_FA_CNT is disabled\n"));
+		return;
+	}
+
+	if (*(pDM_Odm->pbScanInProcess)) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() Return: In Scan Progress\n"));
+		return;
+	}
+
+	/* add by Neil Chen to avoid PSD is processing */
+	if (pDM_Odm->bDMInitialGainEnable == false) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() Return: PSD is Processing\n"));
+		return;
+	}
+
+	if (pDM_Odm->SupportICType == ODM_RTL8192D) {
+		if (*(pDM_Odm->pMacPhyMode) == ODM_DMSP) {
+			if (*(pDM_Odm->pbMasterOfDMSP)) {
+				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
+				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
+				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
+			} else {
+				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_1;
+				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_1);
+				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
+			}
+		} else {
+			if (*(pDM_Odm->pBandType) == ODM_BAND_5G) {
+				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
+				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
+				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
+			} else {
+				DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_1;
+				FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_1);
+				FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_1);
+			}
+		}
+	} else {
+		DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
+		FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
+		FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
+	}
+
+	/* 1 Boundary Decision */
+	if ((pDM_Odm->SupportICType & (ODM_RTL8192C|ODM_RTL8723A)) &&
+	    ((pDM_Odm->BoardType == ODM_BOARD_HIGHPWR) || pDM_Odm->ExtLNA)) {
+		if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
+			dm_dig_max = DM_DIG_MAX_AP_HP;
+			dm_dig_min = DM_DIG_MIN_AP_HP;
+		} else {
+			dm_dig_max = DM_DIG_MAX_NIC_HP;
+			dm_dig_min = DM_DIG_MIN_NIC_HP;
+		}
+		DIG_MaxOfMin = DM_DIG_MAX_AP_HP;
+	} else {
+		if (pDM_Odm->SupportPlatform & (ODM_AP|ODM_ADSL)) {
+			dm_dig_max = DM_DIG_MAX_AP;
+			dm_dig_min = DM_DIG_MIN_AP;
+			DIG_MaxOfMin = dm_dig_max;
+		} else {
+			dm_dig_max = DM_DIG_MAX_NIC;
+			dm_dig_min = DM_DIG_MIN_NIC;
+			DIG_MaxOfMin = DM_DIG_MAX_AP;
+		}
+	}
+	if (pDM_Odm->bLinked) {
+	      /* 2 8723A Series, offset need to be 10 */
+		if (pDM_Odm->SupportICType == (ODM_RTL8723A)) {
+			/* 2 Upper Bound */
+			if ((pDM_Odm->RSSI_Min + 10) > DM_DIG_MAX_NIC)
+				pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
+			else if ((pDM_Odm->RSSI_Min + 10) < DM_DIG_MIN_NIC)
+				pDM_DigTable->rx_gain_range_max = DM_DIG_MIN_NIC;
+			else
+				pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 10;
+			/* 2 If BT is Concurrent, need to set Lower Bound */
+			DIG_Dynamic_MIN = DM_DIG_MIN_NIC;
+		} else {
+			/* 2 Modify DIG upper bound */
+			if ((pDM_Odm->RSSI_Min + 20) > dm_dig_max)
+				pDM_DigTable->rx_gain_range_max = dm_dig_max;
+			else if ((pDM_Odm->RSSI_Min + 20) < dm_dig_min)
+				pDM_DigTable->rx_gain_range_max = dm_dig_min;
+			else
+				pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 20;
+			/* 2 Modify DIG lower bound */
+			if (pDM_Odm->bOneEntryOnly) {
+				if (pDM_Odm->RSSI_Min < dm_dig_min)
+					DIG_Dynamic_MIN = dm_dig_min;
+				else if (pDM_Odm->RSSI_Min > DIG_MaxOfMin)
+					DIG_Dynamic_MIN = DIG_MaxOfMin;
+				else
+					DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
+					     ("odm_DIG() : bOneEntryOnly=true,  DIG_Dynamic_MIN=0x%x\n",
+					     DIG_Dynamic_MIN));
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
+					     ("odm_DIG() : pDM_Odm->RSSI_Min=%d\n",
+					     pDM_Odm->RSSI_Min));
+			} else if ((pDM_Odm->SupportICType == ODM_RTL8188E) &&
+				   (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
+				/* 1 Lower Bound for 88E AntDiv */
+				if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV) {
+					DIG_Dynamic_MIN = (u8) pDM_DigTable->AntDiv_RSSI_max;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+						     ("odm_DIG(): pDM_DigTable->AntDiv_RSSI_max=%d\n",
+						     pDM_DigTable->AntDiv_RSSI_max));
+				}
+			} else {
+				DIG_Dynamic_MIN = dm_dig_min;
+			}
+		}
+	} else {
+		pDM_DigTable->rx_gain_range_max = dm_dig_max;
+		DIG_Dynamic_MIN = dm_dig_min;
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG() : No Link\n"));
+	}
+
+	/* 1 Modify DIG lower bound, deal with abnormally large false alarm */
+	if (pFalseAlmCnt->Cnt_all > 10000) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("dm_DIG(): Abnornally false alarm case.\n"));
+
+		if (pDM_DigTable->LargeFAHit != 3)
+			pDM_DigTable->LargeFAHit++;
+		if (pDM_DigTable->ForbiddenIGI < CurrentIGI) {
+			pDM_DigTable->ForbiddenIGI = CurrentIGI;
+			pDM_DigTable->LargeFAHit = 1;
+		}
+
+		if (pDM_DigTable->LargeFAHit >= 3) {
+			if ((pDM_DigTable->ForbiddenIGI+1) > pDM_DigTable->rx_gain_range_max)
+				pDM_DigTable->rx_gain_range_min = pDM_DigTable->rx_gain_range_max;
+			else
+				pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
+			pDM_DigTable->Recover_cnt = 3600; /* 3600=2hr */
+		}
+
+	} else {
+		/* Recovery mechanism for IGI lower bound */
+		if (pDM_DigTable->Recover_cnt != 0) {
+			pDM_DigTable->Recover_cnt--;
+		} else {
+			if (pDM_DigTable->LargeFAHit < 3) {
+				if ((pDM_DigTable->ForbiddenIGI-1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
+					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
+					pDM_DigTable->rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: At Lower Bound\n"));
+				} else {
+					pDM_DigTable->ForbiddenIGI--;
+					pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): Normal Case: Approach Lower Bound\n"));
+				}
+			} else {
+				pDM_DigTable->LargeFAHit = 0;
+			}
+		}
+	}
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
+		     ("odm_DIG(): pDM_DigTable->LargeFAHit=%d\n",
+		     pDM_DigTable->LargeFAHit));
+
+	/* 1 Adjust initial gain by false alarm */
+	if (pDM_Odm->bLinked) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): DIG AfterLink\n"));
+		if (FirstConnect) {
+			CurrentIGI = pDM_Odm->RSSI_Min;
+			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("DIG: First Connect\n"));
+		} else {
+			if (pDM_Odm->SupportICType == ODM_RTL8192D) {
+				if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2_92D)
+					CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
+				else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1_92D)
+					CurrentIGI = CurrentIGI + 1; /* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
+				else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0_92D)
+					CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
+			} else {
+				if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2)
+						CurrentIGI = CurrentIGI + 4;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
+				else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1)
+						CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
+				else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0)
+						CurrentIGI = CurrentIGI - 2;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
+			}
+		}
+	} else {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): DIG BeforeLink\n"));
+		if (FirstDisConnect) {
+			CurrentIGI = pDM_DigTable->rx_gain_range_min;
+			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): First DisConnect\n"));
+		} else {
+			/* 2012.03.30 LukeLee: enable DIG before link but with very high thresholds */
+			if (pFalseAlmCnt->Cnt_all > 10000)
+				CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
+			else if (pFalseAlmCnt->Cnt_all > 8000)
+				CurrentIGI = CurrentIGI + 1;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
+			else if (pFalseAlmCnt->Cnt_all < 500)
+				CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
+			ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): England DIG\n"));
+		}
+	}
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): DIG End Adjust IGI\n"));
+	/* 1 Check initial gain by upper/lower bound */
+	if (CurrentIGI > pDM_DigTable->rx_gain_range_max)
+		CurrentIGI = pDM_DigTable->rx_gain_range_max;
+	if (CurrentIGI < pDM_DigTable->rx_gain_range_min)
+		CurrentIGI = pDM_DigTable->rx_gain_range_min;
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD,
+		     ("odm_DIG(): rx_gain_range_max=0x%x, rx_gain_range_min=0x%x\n",
+		     pDM_DigTable->rx_gain_range_max, pDM_DigTable->rx_gain_range_min));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): TotalFA=%d\n", pFalseAlmCnt->Cnt_all));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_DIG, ODM_DBG_LOUD, ("odm_DIG(): CurIGValue=0x%x\n", CurrentIGI));
+
+	/* 2 High power RSSI threshold */
+
+	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
+	pDM_DigTable->bMediaConnect_0 = pDM_Odm->bLinked;
+	pDM_DigTable->DIG_Dynamic_MIN_0 = DIG_Dynamic_MIN;
+}
+
+/* 3============================================================ */
+/* 3 FASLE ALARM CHECK */
+/* 3============================================================ */
+
+void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm)
+{
+	u32 ret_value;
+	struct false_alarm_stats *FalseAlmCnt = &(pDM_Odm->FalseAlmCnt);
+
+	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
+		return;
+
+	if (pDM_Odm->SupportICType & ODM_IC_11N_SERIES) {
+		/* hold ofdm counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT31, 1); /* hold page C counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT31, 1); /* hold page D counter */
+
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE1_11N, bMaskDWord);
+		FalseAlmCnt->Cnt_Fast_Fsync = (ret_value&0xffff);
+		FalseAlmCnt->Cnt_SB_Search_fail = ((ret_value&0xffff0000)>>16);
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE2_11N, bMaskDWord);
+		FalseAlmCnt->Cnt_OFDM_CCA = (ret_value&0xffff);
+		FalseAlmCnt->Cnt_Parity_Fail = ((ret_value&0xffff0000)>>16);
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE3_11N, bMaskDWord);
+		FalseAlmCnt->Cnt_Rate_Illegal = (ret_value&0xffff);
+		FalseAlmCnt->Cnt_Crc8_fail = ((ret_value&0xffff0000)>>16);
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_TYPE4_11N, bMaskDWord);
+		FalseAlmCnt->Cnt_Mcs_fail = (ret_value&0xffff);
+
+		FalseAlmCnt->Cnt_Ofdm_fail = FalseAlmCnt->Cnt_Parity_Fail + FalseAlmCnt->Cnt_Rate_Illegal +
+					     FalseAlmCnt->Cnt_Crc8_fail + FalseAlmCnt->Cnt_Mcs_fail +
+					     FalseAlmCnt->Cnt_Fast_Fsync + FalseAlmCnt->Cnt_SB_Search_fail;
+
+		if (pDM_Odm->SupportICType == ODM_RTL8188E) {
+			ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_SC_CNT_11N, bMaskDWord);
+			FalseAlmCnt->Cnt_BW_LSC = (ret_value&0xffff);
+			FalseAlmCnt->Cnt_BW_USC = ((ret_value&0xffff0000)>>16);
+		}
+
+		/* hold cck counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT12, 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT14, 1);
+
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_LSB_11N, bMaskByte0);
+		FalseAlmCnt->Cnt_Cck_fail = ret_value;
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_MSB_11N, bMaskByte3);
+		FalseAlmCnt->Cnt_Cck_fail +=  (ret_value & 0xff)<<8;
+
+		ret_value = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_CCA_CNT_11N, bMaskDWord);
+		FalseAlmCnt->Cnt_CCK_CCA = ((ret_value&0xFF)<<8) | ((ret_value&0xFF00)>>8);
+
+		FalseAlmCnt->Cnt_all = (FalseAlmCnt->Cnt_Fast_Fsync +
+					FalseAlmCnt->Cnt_SB_Search_fail +
+					FalseAlmCnt->Cnt_Parity_Fail +
+					FalseAlmCnt->Cnt_Rate_Illegal +
+					FalseAlmCnt->Cnt_Crc8_fail +
+					FalseAlmCnt->Cnt_Mcs_fail +
+					FalseAlmCnt->Cnt_Cck_fail);
+
+		FalseAlmCnt->Cnt_CCA_all = FalseAlmCnt->Cnt_OFDM_CCA + FalseAlmCnt->Cnt_CCK_CCA;
+
+		if (pDM_Odm->SupportICType >= ODM_RTL8723A) {
+			/* reset false alarm counter registers */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT31, 1);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTC_11N, BIT31, 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT27, 1);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT27, 0);
+			/* update ofdm counter */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_HOLDC_11N, BIT31, 0); /* update page C counter */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RSTD_11N, BIT31, 0); /* update page D counter */
+
+			/* reset CCK CCA counter */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT13|BIT12, 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT13|BIT12, 2);
+			/* reset CCK FA counter */
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT15|BIT14, 0);
+			ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11N, BIT15|BIT14, 2);
+		}
+
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Enter odm_FalseAlarmCounterStatistics\n"));
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
+			     ("Cnt_Fast_Fsync=%d, Cnt_SB_Search_fail=%d\n",
+			     FalseAlmCnt->Cnt_Fast_Fsync, FalseAlmCnt->Cnt_SB_Search_fail));
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
+			     ("Cnt_Parity_Fail=%d, Cnt_Rate_Illegal=%d\n",
+			     FalseAlmCnt->Cnt_Parity_Fail, FalseAlmCnt->Cnt_Rate_Illegal));
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD,
+			     ("Cnt_Crc8_fail=%d, Cnt_Mcs_fail=%d\n",
+			     FalseAlmCnt->Cnt_Crc8_fail, FalseAlmCnt->Cnt_Mcs_fail));
+	} else { /* FOR ODM_IC_11AC_SERIES */
+		/* read OFDM FA counter */
+		FalseAlmCnt->Cnt_Ofdm_fail = ODM_GetBBReg(pDM_Odm, ODM_REG_OFDM_FA_11AC, bMaskLWord);
+		FalseAlmCnt->Cnt_Cck_fail = ODM_GetBBReg(pDM_Odm, ODM_REG_CCK_FA_11AC, bMaskLWord);
+		FalseAlmCnt->Cnt_all = FalseAlmCnt->Cnt_Ofdm_fail + FalseAlmCnt->Cnt_Cck_fail;
+
+		/*  reset OFDM FA coutner */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT17, 1);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_OFDM_FA_RST_11AC, BIT17, 0);
+		/*  reset CCK FA counter */
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT15, 0);
+		ODM_SetBBReg(pDM_Odm, ODM_REG_CCK_FA_RST_11AC, BIT15, 1);
+	}
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Cnt_Cck_fail=%d\n", FalseAlmCnt->Cnt_Cck_fail));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Cnt_Ofdm_fail=%d\n", FalseAlmCnt->Cnt_Ofdm_fail));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_FA_CNT, ODM_DBG_LOUD, ("Total False Alarm=%d\n", FalseAlmCnt->Cnt_all));
+}
+
+/* 3============================================================ */
+/* 3 CCK Packet Detect Threshold */
+/* 3============================================================ */
+
+void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm)
+{
+	u8 CurCCK_CCAThres;
+	struct false_alarm_stats *FalseAlmCnt = &(pDM_Odm->FalseAlmCnt);
+
+	if (!(pDM_Odm->SupportAbility & (ODM_BB_CCK_PD|ODM_BB_FA_CNT)))
+		return;
+	if (pDM_Odm->ExtLNA)
+		return;
+	if (pDM_Odm->bLinked) {
+		if (pDM_Odm->RSSI_Min > 25) {
+			CurCCK_CCAThres = 0xcd;
+		} else if ((pDM_Odm->RSSI_Min <= 25) && (pDM_Odm->RSSI_Min > 10)) {
+			CurCCK_CCAThres = 0x83;
+		} else {
+			if (FalseAlmCnt->Cnt_Cck_fail > 1000)
+				CurCCK_CCAThres = 0x83;
+			else
+				CurCCK_CCAThres = 0x40;
+		}
+	} else {
+		if (FalseAlmCnt->Cnt_Cck_fail > 1000)
+			CurCCK_CCAThres = 0x83;
+		else
+			CurCCK_CCAThres = 0x40;
+	}
+	ODM_Write_CCK_CCA_Thres(pDM_Odm, CurCCK_CCAThres);
+}
+
+void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres)
+{
+	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+
+	if (pDM_DigTable->CurCCK_CCAThres != CurCCK_CCAThres)		/* modify by Guo.Mingzhi 2012-01-03 */
+		ODM_Write1Byte(pDM_Odm, ODM_REG(CCK_CCA, pDM_Odm), CurCCK_CCAThres);
+	pDM_DigTable->PreCCK_CCAThres = pDM_DigTable->CurCCK_CCAThres;
+	pDM_DigTable->CurCCK_CCAThres = CurCCK_CCAThres;
+}
+
+/* 3============================================================ */
+/* 3 BB Power Save */
+/* 3============================================================ */
+void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
+
+	pDM_PSTable->PreCCAState = CCA_MAX;
+	pDM_PSTable->CurCCAState = CCA_MAX;
+	pDM_PSTable->PreRFState = RF_MAX;
+	pDM_PSTable->CurRFState = RF_MAX;
+	pDM_PSTable->Rssi_val_min = 0;
+	pDM_PSTable->initialize = 0;
+}
+
+void odm_DynamicBBPowerSaving(struct odm_dm_struct *pDM_Odm)
+{
+	if ((pDM_Odm->SupportICType != ODM_RTL8192C) && (pDM_Odm->SupportICType != ODM_RTL8723A))
+		return;
+	if (!(pDM_Odm->SupportAbility & ODM_BB_PWR_SAVE))
+		return;
+	if (!(pDM_Odm->SupportPlatform & (ODM_MP|ODM_CE)))
+		return;
+
+	/* 1 2.Power Saving for 92C */
+	if ((pDM_Odm->SupportICType == ODM_RTL8192C) && (pDM_Odm->RFType == ODM_2T2R)) {
+		odm_1R_CCA(pDM_Odm);
+	} else {
+	/*  20100628 Joseph: Turn off BB power save for 88CE because it makesthroughput unstable. */
+	/*  20100831 Joseph: Turn ON BB power save again after modifying AGC delay from 900ns ot 600ns. */
+	/* 1 3.Power Saving for 88C */
+		ODM_RF_Saving(pDM_Odm, false);
+	}
+}
+
+void odm_1R_CCA(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
+
+	if (pDM_Odm->RSSI_Min != 0xFF) {
+		if (pDM_PSTable->PreCCAState == CCA_2R) {
+			if (pDM_Odm->RSSI_Min >= 35)
+				pDM_PSTable->CurCCAState = CCA_1R;
+			else
+				pDM_PSTable->CurCCAState = CCA_2R;
+		} else {
+			if (pDM_Odm->RSSI_Min <= 30)
+				pDM_PSTable->CurCCAState = CCA_2R;
+			else
+				pDM_PSTable->CurCCAState = CCA_1R;
+		}
+	} else {
+		pDM_PSTable->CurCCAState = CCA_MAX;
+	}
+
+	if (pDM_PSTable->PreCCAState != pDM_PSTable->CurCCAState) {
+		if (pDM_PSTable->CurCCAState == CCA_1R) {
+			if (pDM_Odm->RFType == ODM_2T2R)
+				ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x13);
+			else
+				ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x23);
+		} else {
+			ODM_SetBBReg(pDM_Odm, 0xc04, bMaskByte0, 0x33);
+		}
+		pDM_PSTable->PreCCAState = pDM_PSTable->CurCCAState;
+	}
+}
+
+void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
+{
+	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
+	u8 Rssi_Up_bound = 30;
+	u8 Rssi_Low_bound = 25;
+
+	if (pDM_Odm->PatchID == 40) { /* RT_CID_819x_FUNAI_TV */
+		Rssi_Up_bound = 50;
+		Rssi_Low_bound = 45;
+	}
+	if (pDM_PSTable->initialize == 0) {
+		pDM_PSTable->Reg874 = (ODM_GetBBReg(pDM_Odm, 0x874, bMaskDWord)&0x1CC000)>>14;
+		pDM_PSTable->RegC70 = (ODM_GetBBReg(pDM_Odm, 0xc70, bMaskDWord)&BIT3)>>3;
+		pDM_PSTable->Reg85C = (ODM_GetBBReg(pDM_Odm, 0x85c, bMaskDWord)&0xFF000000)>>24;
+		pDM_PSTable->RegA74 = (ODM_GetBBReg(pDM_Odm, 0xa74, bMaskDWord)&0xF000)>>12;
+		pDM_PSTable->initialize = 1;
+	}
+
+	if (!bForceInNormal) {
+		if (pDM_Odm->RSSI_Min != 0xFF) {
+			if (pDM_PSTable->PreRFState == RF_Normal) {
+				if (pDM_Odm->RSSI_Min >= Rssi_Up_bound)
+					pDM_PSTable->CurRFState = RF_Save;
+				else
+					pDM_PSTable->CurRFState = RF_Normal;
+			} else {
+				if (pDM_Odm->RSSI_Min <= Rssi_Low_bound)
+					pDM_PSTable->CurRFState = RF_Normal;
+				else
+					pDM_PSTable->CurRFState = RF_Save;
+			}
+		} else {
+			pDM_PSTable->CurRFState = RF_MAX;
+		}
+	} else {
+		pDM_PSTable->CurRFState = RF_Normal;
+	}
+
+	if (pDM_PSTable->PreRFState != pDM_PSTable->CurRFState) {
+		if (pDM_PSTable->CurRFState == RF_Save) {
+			/*  <tynli_note> 8723 RSSI report will be wrong. Set 0x874[5]=1 when enter BB power saving mode. */
+			/*  Suggested by SD3 Yu-Nan. 2011.01.20. */
+			if (pDM_Odm->SupportICType == ODM_RTL8723A)
+				ODM_SetBBReg(pDM_Odm, 0x874  , BIT5, 0x1); /* Reg874[5]=1b'1 */
+			ODM_SetBBReg(pDM_Odm, 0x874  , 0x1C0000, 0x2); /* Reg874[20:18]=3'b010 */
+			ODM_SetBBReg(pDM_Odm, 0xc70, BIT3, 0); /* RegC70[3]=1'b0 */
+			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, 0x63); /* Reg85C[31:24]=0x63 */
+			ODM_SetBBReg(pDM_Odm, 0x874, 0xC000, 0x2); /* Reg874[15:14]=2'b10 */
+			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, 0x3); /* RegA75[7:4]=0x3 */
+			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x0); /* Reg818[28]=1'b0 */
+			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x1); /* Reg818[28]=1'b1 */
+		} else {
+			ODM_SetBBReg(pDM_Odm, 0x874  , 0x1CC000, pDM_PSTable->Reg874);
+			ODM_SetBBReg(pDM_Odm, 0xc70, BIT3, pDM_PSTable->RegC70);
+			ODM_SetBBReg(pDM_Odm, 0x85c, 0xFF000000, pDM_PSTable->Reg85C);
+			ODM_SetBBReg(pDM_Odm, 0xa74, 0xF000, pDM_PSTable->RegA74);
+			ODM_SetBBReg(pDM_Odm, 0x818, BIT28, 0x0);
+
+			if (pDM_Odm->SupportICType == ODM_RTL8723A)
+				ODM_SetBBReg(pDM_Odm, 0x874, BIT5, 0x0); /* Reg874[5]=1b'0 */
+		}
+		pDM_PSTable->PreRFState = pDM_PSTable->CurRFState;
+	}
+}
+
+/* 3============================================================ */
+/* 3 RATR MASK */
+/* 3============================================================ */
+/* 3============================================================ */
+/* 3 Rate Adaptive */
+/* 3============================================================ */
+
+void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct odm_rate_adapt *pOdmRA = &pDM_Odm->RateAdaptive;
+
+	pOdmRA->Type = DM_Type_ByDriver;
+	if (pOdmRA->Type == DM_Type_ByDriver)
+		pDM_Odm->bUseRAMask = true;
+	else
+		pDM_Odm->bUseRAMask = false;
+
+	pOdmRA->RATRState = DM_RATR_STA_INIT;
+	pOdmRA->HighRSSIThresh = 50;
+	pOdmRA->LowRSSIThresh = 20;
+}
+
+u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u8 rssi_level)
+{
+	struct sta_info *pEntry;
+	u32 rate_bitmap = 0x0fffffff;
+	u8 WirelessMode;
+
+	pEntry = pDM_Odm->pODM_StaInfo[macid];
+	if (!IS_STA_VALID(pEntry))
+		return ra_mask;
+
+	WirelessMode = pEntry->wireless_mode;
+
+	switch (WirelessMode) {
+	case ODM_WM_B:
+		if (ra_mask & 0x0000000c)		/* 11M or 5.5M enable */
+			rate_bitmap = 0x0000000d;
+		else
+			rate_bitmap = 0x0000000f;
+		break;
+	case (ODM_WM_A|ODM_WM_G):
+		if (rssi_level == DM_RATR_STA_HIGH)
+			rate_bitmap = 0x00000f00;
+		else
+			rate_bitmap = 0x00000ff0;
+		break;
+	case (ODM_WM_B|ODM_WM_G):
+		if (rssi_level == DM_RATR_STA_HIGH)
+			rate_bitmap = 0x00000f00;
+		else if (rssi_level == DM_RATR_STA_MIDDLE)
+			rate_bitmap = 0x00000ff0;
+		else
+			rate_bitmap = 0x00000ff5;
+		break;
+	case (ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
+	case (ODM_WM_A|ODM_WM_B|ODM_WM_G|ODM_WM_N24G):
+		if (pDM_Odm->RFType == ODM_1T2R || pDM_Odm->RFType == ODM_1T1R) {
+			if (rssi_level == DM_RATR_STA_HIGH) {
+				rate_bitmap = 0x000f0000;
+			} else if (rssi_level == DM_RATR_STA_MIDDLE) {
+				rate_bitmap = 0x000ff000;
+			} else {
+				if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
+					rate_bitmap = 0x000ff015;
+				else
+					rate_bitmap = 0x000ff005;
+			}
+		} else {
+			if (rssi_level == DM_RATR_STA_HIGH) {
+				rate_bitmap = 0x0f8f0000;
+			} else if (rssi_level == DM_RATR_STA_MIDDLE) {
+				rate_bitmap = 0x0f8ff000;
+			} else {
+				if (*(pDM_Odm->pBandWidth) == ODM_BW40M)
+					rate_bitmap = 0x0f8ff015;
+				else
+					rate_bitmap = 0x0f8ff005;
+			}
+		}
+		break;
+	default:
+		/* case WIRELESS_11_24N: */
+		/* case WIRELESS_11_5N: */
+		if (pDM_Odm->RFType == RF_1T2R)
+			rate_bitmap = 0x000fffff;
+		else
+			rate_bitmap = 0x0fffffff;
+		break;
+	}
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
+		     (" ==> rssi_level:0x%02x, WirelessMode:0x%02x, rate_bitmap:0x%08x\n",
+		     rssi_level, WirelessMode, rate_bitmap));
+
+	return rate_bitmap;
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:	odm_RefreshRateAdaptiveMask()
+ *
+ * Overview:	Update rate table mask according to rssi
+ *
+ * Input:		NONE
+ *
+ * Output:		NONE
+ *
+ * Return:		NONE
+ *
+ * Revised History:
+ *	When		Who		Remark
+ *	05/27/2009	hpfan	Create Version 0.
+ *
+ *---------------------------------------------------------------------------*/
+void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RA_MASK))
+		return;
+	/*  */
+	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
+	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
+	/*  HW dynamic mechanism. */
+	/*  */
+	switch	(pDM_Odm->SupportPlatform) {
+	case	ODM_MP:
+		odm_RefreshRateAdaptiveMaskMP(pDM_Odm);
+		break;
+	case	ODM_CE:
+		odm_RefreshRateAdaptiveMaskCE(pDM_Odm);
+		break;
+	case	ODM_AP:
+	case	ODM_ADSL:
+		odm_RefreshRateAdaptiveMaskAPADSL(pDM_Odm);
+		break;
+	}
+}
+
+void odm_RefreshRateAdaptiveMaskMP(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+void odm_RefreshRateAdaptiveMaskCE(struct odm_dm_struct *pDM_Odm)
+{
+	u8 i;
+	struct adapter *pAdapter = pDM_Odm->Adapter;
+
+	if (pAdapter->bDriverStopped) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_TRACE, ("<---- odm_RefreshRateAdaptiveMask(): driver is going to unload\n"));
+		return;
+	}
+
+	if (!pDM_Odm->bUseRAMask) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("<---- odm_RefreshRateAdaptiveMask(): driver does not control rate adaptive mask\n"));
+		return;
+	}
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
+		if (IS_STA_VALID(pstat)) {
+			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false , &pstat->rssi_level)) {
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD,
+					     ("RSSI:%d, RSSI_LEVEL:%d\n",
+					     pstat->rssi_stat.UndecoratedSmoothedPWDB, pstat->rssi_level));
+				rtw_hal_update_ra_mask(pAdapter, i, pstat->rssi_level);
+			}
+		}
+	}
+}
+
+void odm_RefreshRateAdaptiveMaskAPADSL(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+/*  Return Value: bool */
+/*  - true: RATRState is changed. */
+bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate, u8 *pRATRState)
+{
+	struct odm_rate_adapt *pRA = &pDM_Odm->RateAdaptive;
+	const u8 GoUpGap = 5;
+	u8 HighRSSIThreshForRA = pRA->HighRSSIThresh;
+	u8 LowRSSIThreshForRA = pRA->LowRSSIThresh;
+	u8 RATRState;
+
+	/*  Threshold Adjustment: */
+	/*  when RSSI state trends to go up one or two levels, make sure RSSI is high enough. */
+	/*  Here GoUpGap is added to solve the boundary's level alternation issue. */
+	switch (*pRATRState) {
+	case DM_RATR_STA_INIT:
+	case DM_RATR_STA_HIGH:
+		break;
+	case DM_RATR_STA_MIDDLE:
+		HighRSSIThreshForRA += GoUpGap;
+		break;
+	case DM_RATR_STA_LOW:
+		HighRSSIThreshForRA += GoUpGap;
+		LowRSSIThreshForRA += GoUpGap;
+		break;
+	default:
+		ODM_RT_ASSERT(pDM_Odm, false, ("wrong rssi level setting %d !", *pRATRState));
+		break;
+	}
+
+	/*  Decide RATRState by RSSI. */
+	if (RSSI > HighRSSIThreshForRA)
+		RATRState = DM_RATR_STA_HIGH;
+	else if (RSSI > LowRSSIThreshForRA)
+		RATRState = DM_RATR_STA_MIDDLE;
+	else
+		RATRState = DM_RATR_STA_LOW;
+
+	if (*pRATRState != RATRState || bForceUpdate) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_RA_MASK, ODM_DBG_LOUD, ("RSSI Level %d -> %d\n", *pRATRState, RATRState));
+		*pRATRState = RATRState;
+		return true;
+	}
+	return false;
+}
+
+/* 3============================================================ */
+/* 3 Dynamic Tx Power */
+/* 3============================================================ */
+
+void odm_DynamicTxPowerInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
+	pdmpriv->bDynamicTxPowerEnable = false;
+	pdmpriv->LastDTPLvl = TxHighPwrLevel_Normal;
+	pdmpriv->DynamicTxHighPowerLvl = TxHighPwrLevel_Normal;
+}
+
+void odm_DynamicTxPower(struct odm_dm_struct *pDM_Odm)
+{
+	/*  For AP/ADSL use struct rtl8192cd_priv * */
+	/*  For CE/NIC use struct adapter * */
+
+	if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
+		return;
+
+	/*  2012/01/12 MH According to Luke's suggestion, only high power will support the feature. */
+	if (!pDM_Odm->ExtPA)
+		return;
+
+	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
+	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
+	/*  HW dynamic mechanism. */
+	switch	(pDM_Odm->SupportPlatform) {
+	case	ODM_MP:
+	case	ODM_CE:
+		odm_DynamicTxPowerNIC(pDM_Odm);
+		break;
+	case	ODM_AP:
+		odm_DynamicTxPowerAP(pDM_Odm);
+		break;
+	case	ODM_ADSL:
+		break;
+	}
+}
+
+void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
+		return;
+
+	if (pDM_Odm->SupportICType == ODM_RTL8188E) {
+		/*  ??? */
+		/*  This part need to be redefined. */
+	}
+}
+
+void odm_DynamicTxPowerAP(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+/* 3============================================================ */
+/* 3 RSSI Monitor */
+/* 3============================================================ */
+
+void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_RSSI_MONITOR))
+		return;
+
+	/*  */
+	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
+	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
+	/*  HW dynamic mechanism. */
+	/*  */
+	switch	(pDM_Odm->SupportPlatform) {
+	case	ODM_MP:
+		odm_RSSIMonitorCheckMP(pDM_Odm);
+		break;
+	case	ODM_CE:
+		odm_RSSIMonitorCheckCE(pDM_Odm);
+		break;
+	case	ODM_AP:
+		odm_RSSIMonitorCheckAP(pDM_Odm);
+		break;
+	case	ODM_ADSL:
+		/* odm_DIGAP(pDM_Odm); */
+		break;
+	}
+
+}	/*  odm_RSSIMonitorCheck */
+
+void odm_RSSIMonitorCheckMP(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+static void FindMinimumRSSI(struct adapter *pAdapter)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
+	struct mlme_priv	*pmlmepriv = &pAdapter->mlmepriv;
+
+	/* 1 1.Determine the minimum RSSI */
+	if ((check_fwstate(pmlmepriv, _FW_LINKED) == false) &&
+	    (pdmpriv->EntryMinUndecoratedSmoothedPWDB == 0))
+		pdmpriv->MinUndecoratedPWDBForDM = 0;
+	if (check_fwstate(pmlmepriv, _FW_LINKED) == true)	/*  Default port */
+		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
+	else /*  associated entry pwdb */
+		pdmpriv->MinUndecoratedPWDBForDM = pdmpriv->EntryMinUndecoratedSmoothedPWDB;
+}
+
+void odm_RSSIMonitorCheckCE(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
+	int	i;
+	int	tmpEntryMaxPWDB = 0, tmpEntryMinPWDB = 0xff;
+	u8	sta_cnt = 0;
+	u32 PWDB_rssi[NUM_STA] = {0};/* 0~15]:MACID, [16~31]:PWDB_rssi */
+	struct sta_info *psta;
+	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+	if (!check_fwstate(&Adapter->mlmepriv, _FW_LINKED))
+		return;
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		psta = pDM_Odm->pODM_StaInfo[i];
+		if (IS_STA_VALID(psta) &&
+		    (psta->state & WIFI_ASOC_STATE) &&
+		    memcmp(psta->hwaddr, bcast_addr, ETH_ALEN) &&
+		    memcmp(psta->hwaddr, myid(&Adapter->eeprompriv), ETH_ALEN)) {
+			if (psta->rssi_stat.UndecoratedSmoothedPWDB < tmpEntryMinPWDB)
+				tmpEntryMinPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
+
+			if (psta->rssi_stat.UndecoratedSmoothedPWDB > tmpEntryMaxPWDB)
+				tmpEntryMaxPWDB = psta->rssi_stat.UndecoratedSmoothedPWDB;
+			if (psta->rssi_stat.UndecoratedSmoothedPWDB != (-1))
+				PWDB_rssi[sta_cnt++] = (psta->mac_id | (psta->rssi_stat.UndecoratedSmoothedPWDB<<16));
+		}
+	}
+
+	for (i = 0; i < sta_cnt; i++) {
+		if (PWDB_rssi[i] != (0)) {
+			if (pHalData->fw_ractrl) {
+				/*  Report every sta's RSSI to FW */
+			} else {
+				ODM_RA_SetRSSI_8188E(
+				&(pHalData->odmpriv), (PWDB_rssi[i]&0xFF), (u8)((PWDB_rssi[i]>>16) & 0xFF));
+			}
+		}
+	}
+
+	if (tmpEntryMaxPWDB != 0)	/*  If associated entry is found */
+		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = tmpEntryMaxPWDB;
+	else
+		pdmpriv->EntryMaxUndecoratedSmoothedPWDB = 0;
+
+	if (tmpEntryMinPWDB != 0xff) /*  If associated entry is found */
+		pdmpriv->EntryMinUndecoratedSmoothedPWDB = tmpEntryMinPWDB;
+	else
+		pdmpriv->EntryMinUndecoratedSmoothedPWDB = 0;
+
+	FindMinimumRSSI(Adapter);
+	ODM_CmnInfoUpdate(&pHalData->odmpriv , ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
+}
+
+void odm_RSSIMonitorCheckAP(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+void ODM_InitAllTimers(struct odm_dm_struct *pDM_Odm)
+{
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+	ODM_InitializeTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer,
+			    (void *)odm_SwAntDivChkAntSwitchCallback, NULL, "SwAntennaSwitchTimer");
+#else
+	timer_setup(&pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer, odm_SwAntDivChkAntSwitchCallback, 0);
+#endif
+}
+
+void ODM_CancelAllTimers(struct odm_dm_struct *pDM_Odm)
+{
+	ODM_CancelTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer);
+}
+
+void ODM_ReleaseAllTimers(struct odm_dm_struct *pDM_Odm)
+{
+	ODM_ReleaseTimer(pDM_Odm, &pDM_Odm->DM_SWAT_Table.SwAntennaSwitchTimer);
+
+	ODM_ReleaseTimer(pDM_Odm, &pDM_Odm->FastAntTrainingTimer);
+}
+
+/* 3============================================================ */
+/* 3 Tx Power Tracking */
+/* 3============================================================ */
+
+void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm)
+{
+	odm_TXPowerTrackingThermalMeterInit(pDM_Odm);
+}
+
+void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
+{
+	pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
+	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
+	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = false;
+	if (*(pDM_Odm->mp_mode) != 1)
+		pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
+	MSG_88E("pDM_Odm TxPowerTrackControl = %d\n", pDM_Odm->RFCalibrateInfo.TxPowerTrackControl);
+
+	pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
+}
+
+void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
+{
+	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
+	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
+	/*  HW dynamic mechanism. */
+	switch	(pDM_Odm->SupportPlatform) {
+	case	ODM_MP:
+		odm_TXPowerTrackingCheckMP(pDM_Odm);
+		break;
+	case	ODM_CE:
+		odm_TXPowerTrackingCheckCE(pDM_Odm);
+		break;
+	case	ODM_AP:
+		odm_TXPowerTrackingCheckAP(pDM_Odm);
+		break;
+	case	ODM_ADSL:
+		break;
+	}
+}
+
+void odm_TXPowerTrackingCheckCE(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+
+	if (!(pDM_Odm->SupportAbility & ODM_RF_TX_PWR_TRACK))
+		return;
+
+	if (!pDM_Odm->RFCalibrateInfo.TM_Trigger) {		/* at least delay 1 sec */
+		PHY_SetRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, BIT17 | BIT16, 0x03);
+
+		pDM_Odm->RFCalibrateInfo.TM_Trigger = 1;
+		return;
+	} else {
+		odm_TXPowerTrackingCallback_ThermalMeter_8188E(Adapter);
+		pDM_Odm->RFCalibrateInfo.TM_Trigger = 0;
+	}
+}
+
+void odm_TXPowerTrackingCheckMP(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+void odm_TXPowerTrackingCheckAP(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+/* antenna mapping info */
+/*  1: right-side antenna */
+/*  2/0: left-side antenna */
+/* PDM_SWAT_Table->CCK_Ant1_Cnt /OFDM_Ant1_Cnt:  for right-side antenna:   Ant:1    RxDefaultAnt1 */
+/* PDM_SWAT_Table->CCK_Ant2_Cnt /OFDM_Ant2_Cnt:  for left-side antenna:     Ant:0    RxDefaultAnt2 */
+/*  We select left antenna as default antenna in initial process, modify it as needed */
+/*  */
+
+/* 3============================================================ */
+/* 3 SW Antenna Diversity */
+/* 3============================================================ */
+void odm_SwAntDivInit(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+void ODM_SwAntDivChkPerPktRssi(struct odm_dm_struct *pDM_Odm, u8 StationID, struct odm_phy_status_info *pPhyInfo)
+{
+}
+
+void odm_SwAntDivChkAntSwitch(struct odm_dm_struct *pDM_Odm, u8 Step)
+{
+}
+
+void ODM_SwAntDivRestAfterLink(struct odm_dm_struct *pDM_Odm)
+{
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+void odm_SwAntDivChkAntSwitchCallback(void *FunctionContext)
+#else
+void odm_SwAntDivChkAntSwitchCallback(struct timer_list *t)
+#endif
+{
+}
+
+/* 3============================================================ */
+/* 3 SW Antenna Diversity */
+/* 3============================================================ */
+
+void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Return: Not Support HW AntDiv\n"));
+		return;
+	}
+
+	if (pDM_Odm->SupportICType & (ODM_RTL8192C | ODM_RTL8192D))
+		;
+	else if (pDM_Odm->SupportICType == ODM_RTL8188E)
+		ODM_AntennaDiversityInit_88E(pDM_Odm);
+}
+
+void ODM_AntselStatistics_88C(struct odm_dm_struct *pDM_Odm, u8 MacId, u32 PWDBAll, bool isCCKrate)
+{
+	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
+
+	if (pDM_SWAT_Table->antsel == 1) {
+		if (isCCKrate) {
+			pDM_SWAT_Table->CCK_Ant1_Cnt[MacId]++;
+		} else {
+			pDM_SWAT_Table->OFDM_Ant1_Cnt[MacId]++;
+			pDM_SWAT_Table->RSSI_Ant1_Sum[MacId] += PWDBAll;
+		}
+	} else {
+		if (isCCKrate) {
+			pDM_SWAT_Table->CCK_Ant2_Cnt[MacId]++;
+		} else {
+			pDM_SWAT_Table->OFDM_Ant2_Cnt[MacId]++;
+			pDM_SWAT_Table->RSSI_Ant2_Sum[MacId] += PWDBAll;
+		}
+	}
+}
+
+void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm)
+{
+	if (!(pDM_Odm->SupportAbility & ODM_BB_ANT_DIV)) {
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Return: Not Support HW AntDiv\n"));
+		return;
+	}
+
+	if (pDM_Odm->SupportICType == ODM_RTL8188E)
+		ODM_AntennaDiversity_88E(pDM_Odm);
+}
+
+/* EDCA Turbo */
+void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
+	pDM_Odm->DM_EDCA_Table.bIsCurRDLState = false;
+	Adapter->recvpriv.bIsAnyNonBEPkts = false;
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial VO PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_VO_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial VI PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_VI_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial BE PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_BE_PARAM)));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("Orginial BK PARAM: 0x%x\n", ODM_Read4Byte(pDM_Odm, ODM_EDCA_BK_PARAM)));
+}	/*  ODM_InitEdcaTurbo */
+
+void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm)
+{
+	/*  2011/09/29 MH In HW integration first stage, we provide 4 different handle to operate */
+	/*  at the same time. In the stage2/3, we need to prive universal interface and merge all */
+	/*  HW dynamic mechanism. */
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("odm_EdcaTurboCheck========================>\n"));
+
+	if (!(pDM_Odm->SupportAbility & ODM_MAC_EDCA_TURBO))
+		return;
+
+	switch	(pDM_Odm->SupportPlatform) {
+	case	ODM_MP:
+		break;
+	case	ODM_CE:
+		odm_EdcaTurboCheckCE(pDM_Odm);
+		break;
+	case	ODM_AP:
+	case	ODM_ADSL:
+		break;
+	}
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_EDCA_TURBO, ODM_DBG_LOUD, ("<========================odm_EdcaTurboCheck\n"));
+}	/*  odm_CheckEdcaTurbo */
+
+void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	u32	trafficIndex;
+	u32	edca_param;
+	u64	cur_tx_bytes = 0;
+	u64	cur_rx_bytes = 0;
+	u8	bbtchange = false;
+	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+	struct xmit_priv		*pxmitpriv = &(Adapter->xmitpriv);
+	struct recv_priv		*precvpriv = &(Adapter->recvpriv);
+	struct registry_priv	*pregpriv = &Adapter->registrypriv;
+	struct mlme_ext_priv	*pmlmeext = &(Adapter->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+
+	if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0)) */
+		goto dm_CheckEdcaTurbo_EXIT;
+
+	if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
+		goto dm_CheckEdcaTurbo_EXIT;
+
+	/*  Check if the status needs to be changed. */
+	if ((bbtchange) || (!precvpriv->bIsAnyNonBEPkts)) {
+		cur_tx_bytes = pxmitpriv->tx_bytes - pxmitpriv->last_tx_bytes;
+		cur_rx_bytes = precvpriv->rx_bytes - precvpriv->last_rx_bytes;
+
+		/* traffic, TX or RX */
+		if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_RALINK) ||
+		    (pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_ATHEROS)) {
+			if (cur_tx_bytes > (cur_rx_bytes << 2)) {
+				/*  Uplink TP is present. */
+				trafficIndex = UP_LINK;
+			} else {
+				/*  Balance TP is present. */
+				trafficIndex = DOWN_LINK;
+			}
+		} else {
+			if (cur_rx_bytes > (cur_tx_bytes << 2)) {
+				/*  Downlink TP is present. */
+				trafficIndex = DOWN_LINK;
+			} else {
+				/*  Balance TP is present. */
+				trafficIndex = UP_LINK;
+			}
+		}
+
+		if ((pDM_Odm->DM_EDCA_Table.prv_traffic_idx != trafficIndex) || (!pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA)) {
+			if ((pmlmeinfo->assoc_AP_vendor == HT_IOT_PEER_CISCO) && (pmlmeext->cur_wireless_mode & WIRELESS_11_24N))
+				edca_param = EDCAParam[pmlmeinfo->assoc_AP_vendor][trafficIndex];
+			else
+				edca_param = EDCAParam[HT_IOT_PEER_UNKNOWN][trafficIndex];
+
+			rtw_write32(Adapter, REG_EDCA_BE_PARAM, edca_param);
+
+			pDM_Odm->DM_EDCA_Table.prv_traffic_idx = trafficIndex;
+		}
+
+		pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = true;
+	} else {
+		/*  Turn Off EDCA turbo here. */
+		/*  Restore original EDCA according to the declaration of AP. */
+		 if (pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA) {
+			rtw_write32(Adapter, REG_EDCA_BE_PARAM, pHalData->AcParam_BE);
+			pDM_Odm->DM_EDCA_Table.bCurrentTurboEDCA = false;
+		}
+	}
+
+dm_CheckEdcaTurbo_EXIT:
+	/*  Set variables for next time. */
+	precvpriv->bIsAnyNonBEPkts = false;
+	pxmitpriv->last_tx_bytes = pxmitpriv->tx_bytes;
+	precvpriv->last_rx_bytes = precvpriv->rx_bytes;
+}
+
+/*  need to ODM CE Platform */
+/* move to here for ANT detection mechanism using */
+
+u32 GetPSDData(struct odm_dm_struct *pDM_Odm, unsigned int point, u8 initial_gain_psd)
+{
+	u32 psd_report;
+
+	/* Set DCO frequency index, offset=(40MHz/SamplePts)*point */
+	ODM_SetBBReg(pDM_Odm, 0x808, 0x3FF, point);
+
+	/* Start PSD calculation, Reg808[22]=0->1 */
+	ODM_SetBBReg(pDM_Odm, 0x808, BIT22, 1);
+	/* Need to wait for HW PSD report */
+	ODM_StallExecution(30);
+	ODM_SetBBReg(pDM_Odm, 0x808, BIT22, 0);
+	/* Read PSD report, Reg8B4[15:0] */
+	psd_report = ODM_GetBBReg(pDM_Odm, 0x8B4, bMaskDWord) & 0x0000FFFF;
+
+	psd_report = (u32) (ConvertTo_dB(psd_report))+(u32)(initial_gain_psd-0x1c);
+
+	return psd_report;
+}
+
+u32 ConvertTo_dB(u32 Value)
+{
+	u8 i;
+	u8 j;
+	u32 dB;
+
+	Value = Value & 0xFFFF;
+	for (i = 0; i < 8; i++) {
+		if (Value <= dB_Invert_Table[i][11])
+			break;
+	}
+
+	if (i >= 8)
+		return 96;	/*  maximum 96 dB */
+
+	for (j = 0; j < 12; j++) {
+		if (Value <= dB_Invert_Table[i][j])
+			break;
+	}
+
+	dB = i*12 + j + 1;
+
+	return dB;
+}
+
+/*  2011/09/22 MH Add for 92D global spin lock utilization. */
+void odm_GlobalAdapterCheck(void)
+{
+}	/*  odm_GlobalAdapterCheck */
+
+/*  Description: */
+/* 	Set Single/Dual Antenna default setting for products that do not do detection in advance. */
+/*  Added by Joseph, 2012.03.22 */
+void ODM_SingleDualAntennaDefaultSetting(struct odm_dm_struct *pDM_Odm)
+{
+	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
+
+	pDM_SWAT_Table->ANTA_ON = true;
+	pDM_SWAT_Table->ANTB_ON = true;
+}
+
+/* 2 8723A ANT DETECT */
+
+static void odm_PHY_SaveAFERegisters(struct odm_dm_struct *pDM_Odm, u32 *AFEReg, u32 *AFEBackup, u32 RegisterNum)
+{
+	u32 i;
+
+	/* RTPRINT(FINIT, INIT_IQK, ("Save ADDA parameters.\n")); */
+	for (i = 0; i < RegisterNum; i++)
+		AFEBackup[i] = ODM_GetBBReg(pDM_Odm, AFEReg[i], bMaskDWord);
+}
+
+static void odm_PHY_ReloadAFERegisters(struct odm_dm_struct *pDM_Odm, u32 *AFEReg, u32 *AFEBackup, u32 RegiesterNum)
+{
+	u32 i;
+
+	for (i = 0; i < RegiesterNum; i++)
+		ODM_SetBBReg(pDM_Odm, AFEReg[i], bMaskDWord, AFEBackup[i]);
+}
+
+/* 2 8723A ANT DETECT */
+/*  Description: */
+/* 	Implement IQK single tone for RF DPK loopback and BB PSD scanning. */
+/* 	This function is cooperated with BB team Neil. */
+bool ODM_SingleDualAntennaDetection(struct odm_dm_struct *pDM_Odm, u8 mode)
+{
+	struct sw_ant_switch *pDM_SWAT_Table = &pDM_Odm->DM_SWAT_Table;
+	u32 CurrentChannel, RfLoopReg;
+	u8 n;
+	u32 Reg88c, Regc08, Reg874, Regc50;
+	u8 initial_gain = 0x5a;
+	u32 PSD_report_tmp;
+	u32 AntA_report = 0x0, AntB_report = 0x0, AntO_report = 0x0;
+	bool bResult = true;
+	u32 AFE_Backup[16];
+	u32 AFE_REG_8723A[16] = {
+		rRx_Wait_CCA, rTx_CCK_RFON,
+		rTx_CCK_BBON, rTx_OFDM_RFON,
+		rTx_OFDM_BBON, rTx_To_Rx,
+		rTx_To_Tx, rRx_CCK,
+		rRx_OFDM, rRx_Wait_RIFS,
+		rRx_TO_Rx, rStandby,
+		rSleep, rPMPD_ANAEN,
+		rFPGA0_XCD_SwitchControl, rBlue_Tooth};
+
+	if (!(pDM_Odm->SupportICType & (ODM_RTL8723A|ODM_RTL8192C)))
+		return bResult;
+
+	if (!(pDM_Odm->SupportAbility&ODM_BB_ANT_DIV))
+		return bResult;
+
+	if (pDM_Odm->SupportICType == ODM_RTL8192C) {
+		/* Which path in ADC/DAC is turnned on for PSD: both I/Q */
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT10|BIT11, 0x3);
+		/* Ageraged number: 8 */
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT12|BIT13, 0x1);
+		/* pts = 128; */
+		ODM_SetBBReg(pDM_Odm, 0x808, BIT14|BIT15, 0x0);
+	}
+
+	/* 1 Backup Current RF/BB Settings */
+
+	CurrentChannel = ODM_GetRFReg(pDM_Odm, RF_PATH_A, ODM_CHANNEL, bRFRegOffsetMask);
+	RfLoopReg = ODM_GetRFReg(pDM_Odm, RF_PATH_A, 0x00, bRFRegOffsetMask);
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, ODM_DPDT, Antenna_A);  /*  change to Antenna A */
+	/*  Step 1: USE IQK to transmitter single tone */
+
+	ODM_StallExecution(10);
+
+	/* Store A Path Register 88c, c08, 874, c50 */
+	Reg88c = ODM_GetBBReg(pDM_Odm, rFPGA0_AnalogParameter4, bMaskDWord);
+	Regc08 = ODM_GetBBReg(pDM_Odm, rOFDM0_TRMuxPar, bMaskDWord);
+	Reg874 = ODM_GetBBReg(pDM_Odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord);
+	Regc50 = ODM_GetBBReg(pDM_Odm, rOFDM0_XAAGCCore1, bMaskDWord);
+
+	/*  Store AFE Registers */
+	odm_PHY_SaveAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
+
+	/* Set PSD 128 pts */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_PSDFunction, BIT14|BIT15, 0x0);  /* 128 pts */
+
+	/*  To SET CH1 to do */
+	ODM_SetRFReg(pDM_Odm, RF_PATH_A, ODM_CHANNEL, bRFRegOffsetMask, 0x01);     /* Channel 1 */
+
+	/*  AFE all on step */
+	ODM_SetBBReg(pDM_Odm, rRx_Wait_CCA, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rTx_CCK_RFON, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rTx_CCK_BBON, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rTx_OFDM_RFON, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rTx_OFDM_BBON, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rTx_To_Rx, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rTx_To_Tx, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rRx_CCK, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rRx_OFDM, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rRx_Wait_RIFS, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rRx_TO_Rx, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rStandby, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rSleep, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rPMPD_ANAEN, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XCD_SwitchControl, bMaskDWord, 0x6FDB25A4);
+	ODM_SetBBReg(pDM_Odm, rBlue_Tooth, bMaskDWord, 0x6FDB25A4);
+
+	/*  3 wire Disable */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_AnalogParameter4, bMaskDWord, 0xCCF000C0);
+
+	/* BB IQK Setting */
+	ODM_SetBBReg(pDM_Odm, rOFDM0_TRMuxPar, bMaskDWord, 0x000800E4);
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, 0x22208000);
+
+	/* IQK setting tone@ 4.34Mhz */
+	ODM_SetBBReg(pDM_Odm, rTx_IQK_Tone_A, bMaskDWord, 0x10008C1C);
+	ODM_SetBBReg(pDM_Odm, rTx_IQK, bMaskDWord, 0x01007c00);
+
+	/* Page B init */
+	ODM_SetBBReg(pDM_Odm, rConfig_AntA, bMaskDWord, 0x00080000);
+	ODM_SetBBReg(pDM_Odm, rConfig_AntA, bMaskDWord, 0x0f600000);
+	ODM_SetBBReg(pDM_Odm, rRx_IQK, bMaskDWord, 0x01004800);
+	ODM_SetBBReg(pDM_Odm, rRx_IQK_Tone_A, bMaskDWord, 0x10008c1f);
+	ODM_SetBBReg(pDM_Odm, rTx_IQK_PI_A, bMaskDWord, 0x82150008);
+	ODM_SetBBReg(pDM_Odm, rRx_IQK_PI_A, bMaskDWord, 0x28150008);
+	ODM_SetBBReg(pDM_Odm, rIQK_AGC_Rsp, bMaskDWord, 0x001028d0);
+
+	/* RF loop Setting */
+	ODM_SetRFReg(pDM_Odm, RF_PATH_A, 0x0, 0xFFFFF, 0x50008);
+
+	/* IQK Single tone start */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_IQK, bMaskDWord, 0x80800000);
+	ODM_SetBBReg(pDM_Odm, rIQK_AGC_Pts, bMaskDWord, 0xf8000000);
+	ODM_StallExecution(1000);
+	PSD_report_tmp = 0x0;
+
+	for (n = 0; n < 2; n++) {
+		PSD_report_tmp =  GetPSDData(pDM_Odm, 14, initial_gain);
+		if (PSD_report_tmp > AntA_report)
+			AntA_report = PSD_report_tmp;
+	}
+
+	PSD_report_tmp = 0x0;
+
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_B);  /*  change to Antenna B */
+	ODM_StallExecution(10);
+
+	for (n = 0; n < 2; n++) {
+		PSD_report_tmp =  GetPSDData(pDM_Odm, 14, initial_gain);
+		if (PSD_report_tmp > AntB_report)
+			AntB_report = PSD_report_tmp;
+	}
+
+	/*  change to open case */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, 0x300, 0);  /*  change to Ant A and B all open case */
+	ODM_StallExecution(10);
+
+	for (n = 0; n < 2; n++) {
+		PSD_report_tmp =  GetPSDData(pDM_Odm, 14, initial_gain);
+		if (PSD_report_tmp > AntO_report)
+			AntO_report = PSD_report_tmp;
+	}
+
+	/* Close IQK Single Tone function */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_IQK, bMaskDWord, 0x00000000);
+	PSD_report_tmp = 0x0;
+
+	/* 1 Return to antanna A */
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_A);
+	ODM_SetBBReg(pDM_Odm, rFPGA0_AnalogParameter4, bMaskDWord, Reg88c);
+	ODM_SetBBReg(pDM_Odm, rOFDM0_TRMuxPar, bMaskDWord, Regc08);
+	ODM_SetBBReg(pDM_Odm, rFPGA0_XCD_RFInterfaceSW, bMaskDWord, Reg874);
+	ODM_SetBBReg(pDM_Odm, rOFDM0_XAAGCCore1, 0x7F, 0x40);
+	ODM_SetBBReg(pDM_Odm, rOFDM0_XAAGCCore1, bMaskDWord, Regc50);
+	ODM_SetRFReg(pDM_Odm, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, CurrentChannel);
+	ODM_SetRFReg(pDM_Odm, RF_PATH_A, 0x00, bRFRegOffsetMask, RfLoopReg);
+
+	/* Reload AFE Registers */
+	odm_PHY_ReloadAFERegisters(pDM_Odm, AFE_REG_8723A, AFE_Backup, 16);
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("psd_report_A[%d]= %d\n", 2416, AntA_report));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("psd_report_B[%d]= %d\n", 2416, AntB_report));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("psd_report_O[%d]= %d\n", 2416, AntO_report));
+
+	if (pDM_Odm->SupportICType == ODM_RTL8723A) {
+	/* 2 Test Ant B based on Ant A is ON */
+		if (mode == ANTTESTB) {
+			if (AntA_report >= 100) {
+				if (AntB_report > (AntA_report+1)) {
+					pDM_SWAT_Table->ANTB_ON = false;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Single Antenna A\n"));
+				} else {
+					pDM_SWAT_Table->ANTB_ON = true;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Dual Antenna is A and B\n"));
+				}
+			} else {
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Need to check again\n"));
+				pDM_SWAT_Table->ANTB_ON = false; /*  Set Antenna B off as default */
+				bResult = false;
+			}
+		} else if (mode == ANTTESTALL) {
+			/* 2 Test Ant A and B based on DPDT Open */
+			if ((AntO_report >= 100)&(AntO_report < 118)) {
+				if (AntA_report > (AntO_report+1)) {
+					pDM_SWAT_Table->ANTA_ON = false;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant A is OFF"));
+				} else {
+					pDM_SWAT_Table->ANTA_ON = true;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant A is ON"));
+				}
+
+				if (AntB_report > (AntO_report+2)) {
+					pDM_SWAT_Table->ANTB_ON = false;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant B is OFF"));
+				} else {
+					pDM_SWAT_Table->ANTB_ON = true;
+					ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Ant B is ON"));
+				}
+			}
+		}
+	} else if (pDM_Odm->SupportICType == ODM_RTL8192C) {
+		if (AntA_report >= 100) {
+			if (AntB_report > (AntA_report+2)) {
+				pDM_SWAT_Table->ANTA_ON = false;
+				pDM_SWAT_Table->ANTB_ON = true;
+				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_B);
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Single Antenna B\n"));
+			} else if (AntA_report > (AntB_report+2)) {
+				pDM_SWAT_Table->ANTA_ON = true;
+				pDM_SWAT_Table->ANTB_ON = false;
+				ODM_SetBBReg(pDM_Odm,  rFPGA0_XA_RFInterfaceOE, 0x300, Antenna_A);
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Single Antenna A\n"));
+			} else {
+				pDM_SWAT_Table->ANTA_ON = true;
+				pDM_SWAT_Table->ANTB_ON = true;
+				ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+					     ("ODM_SingleDualAntennaDetection(): Dual Antenna\n"));
+			}
+		} else {
+			ODM_RT_TRACE(pDM_Odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_SingleDualAntennaDetection(): Need to check again\n"));
+			pDM_SWAT_Table->ANTA_ON = true; /*  Set Antenna A on as default */
+			pDM_SWAT_Table->ANTB_ON = false; /*  Set Antenna B off as default */
+			bResult = false;
+		}
+	}
+	return bResult;
+}
+
+/* Justin: According to the current RRSI to adjust Response Frame TX power, 2012/11/05 */
+void odm_dtc(struct odm_dm_struct *pDM_Odm)
+{
+}
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
new file mode 100644
index 000000000000..523801cabb43
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -0,0 +1,601 @@
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
+/*  include files */
+
+#include "odm_precomp.h"
+
+#define READ_AND_CONFIG     READ_AND_CONFIG_MP
+
+#define READ_AND_CONFIG_MP(ic, txt) (ODM_ReadAndConfig##txt##ic(dm_odm))
+#define READ_AND_CONFIG_TC(ic, txt) (ODM_ReadAndConfig_TC##txt##ic(dm_odm))
+
+static u8 odm_QueryRxPwrPercentage(s8 AntPower)
+{
+	if ((AntPower <= -100) || (AntPower >= 20))
+		return	0;
+	else if (AntPower >= 0)
+		return	100;
+	else
+		return 100+AntPower;
+}
+
+/*  2012/01/12 MH MOve some signal strength smooth method to MP HAL layer. */
+/*  IF other SW team do not support the feature, remove this section.?? */
+static s32 odm_sig_patch_lenove(struct odm_dm_struct *dm_odm, s32 CurrSig)
+{
+	return 0;
+}
+
+static s32 odm_sig_patch_netcore(struct odm_dm_struct *dm_odm, s32 CurrSig)
+{
+	return 0;
+}
+
+static s32 odm_SignalScaleMapping_92CSeries(struct odm_dm_struct *dm_odm, s32 CurrSig)
+{
+	s32 RetSig = 0;
+
+	if ((dm_odm->SupportInterface  == ODM_ITRF_USB) ||
+	    (dm_odm->SupportInterface  == ODM_ITRF_SDIO)) {
+		if (CurrSig >= 51 && CurrSig <= 100)
+			RetSig = 100;
+		else if (CurrSig >= 41 && CurrSig <= 50)
+			RetSig = 80 + ((CurrSig - 40)*2);
+		else if (CurrSig >= 31 && CurrSig <= 40)
+			RetSig = 66 + (CurrSig - 30);
+		else if (CurrSig >= 21 && CurrSig <= 30)
+			RetSig = 54 + (CurrSig - 20);
+		else if (CurrSig >= 10 && CurrSig <= 20)
+			RetSig = 42 + (((CurrSig - 10) * 2) / 3);
+		else if (CurrSig >= 5 && CurrSig <= 9)
+			RetSig = 22 + (((CurrSig - 5) * 3) / 2);
+		else if (CurrSig >= 1 && CurrSig <= 4)
+			RetSig = 6 + (((CurrSig - 1) * 3) / 2);
+		else
+			RetSig = CurrSig;
+	}
+	return RetSig;
+}
+
+static s32 odm_SignalScaleMapping(struct odm_dm_struct *dm_odm, s32 CurrSig)
+{
+	if ((dm_odm->SupportPlatform == ODM_MP) &&
+	    (dm_odm->SupportInterface != ODM_ITRF_PCIE) && /* USB & SDIO */
+	    (dm_odm->PatchID == 10))
+		return odm_sig_patch_netcore(dm_odm, CurrSig);
+	else if ((dm_odm->SupportPlatform == ODM_MP) &&
+		 (dm_odm->SupportInterface == ODM_ITRF_PCIE) &&
+		 (dm_odm->PatchID == 19))
+		return odm_sig_patch_lenove(dm_odm, CurrSig);
+	else
+		return odm_SignalScaleMapping_92CSeries(dm_odm, CurrSig);
+}
+
+/* pMgntInfo->CustomerID == RT_CID_819x_Lenovo */
+static u8 odm_SQ_process_patch_RT_CID_819x_Lenovo(struct odm_dm_struct *dm_odm,
+	u8 isCCKrate, u8 PWDB_ALL, u8 path, u8 RSSI)
+{
+	return 0;
+}
+
+static u8 odm_EVMdbToPercentage(s8 Value)
+{
+	/*  -33dB~0dB to 0%~99% */
+	s8 ret_val;
+
+	ret_val = Value;
+
+	if (ret_val >= 0)
+		ret_val = 0;
+	if (ret_val <= -33)
+		ret_val = -33;
+
+	ret_val = 0 - ret_val;
+	ret_val *= 3;
+
+	if (ret_val == 99)
+		ret_val = 100;
+	return ret_val;
+}
+
+static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
+			struct odm_phy_status_info *pPhyInfo,
+			u8 *pPhyStatus,
+			struct odm_per_pkt_info *pPktinfo,
+			struct adapter *adapt)
+{
+	struct sw_ant_switch *pDM_SWAT_Table = &dm_odm->DM_SWAT_Table;
+	u8 i, Max_spatial_stream;
+	s8 rx_pwr[4], rx_pwr_all = 0;
+	u8 EVM, PWDB_ALL = 0, PWDB_ALL_BT;
+	u8 RSSI, total_rssi = 0;
+	u8 isCCKrate = 0;
+	u8 rf_rx_num = 0;
+	u8 cck_highpwr = 0;
+	u8 LNA_idx, VGA_idx;
+
+	struct phy_status_rpt *pPhyStaRpt = (struct phy_status_rpt *)pPhyStatus;
+
+	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+
+	pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = -1;
+	pPhyInfo->RxMIMOSignalQuality[RF_PATH_B] = -1;
+
+	if (isCCKrate) {
+		u8 report;
+		u8 cck_agc_rpt;
+
+		dm_odm->PhyDbgInfo.NumQryPhyStatusCCK++;
+		/*  (1)Hardware does not provide RSSI for CCK */
+		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
+
+		cck_highpwr = dm_odm->bCckHighPower;
+
+		cck_agc_rpt =  pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a ;
+
+		/* 2011.11.28 LukeLee: 88E use different LNA & VGA gain table */
+		/* The RSSI formula should be modified according to the gain table */
+		/* In 88E, cck_highpwr is always set to 1 */
+		if (dm_odm->SupportICType & (ODM_RTL8188E|ODM_RTL8812)) {
+			LNA_idx = ((cck_agc_rpt & 0xE0) >> 5);
+			VGA_idx = (cck_agc_rpt & 0x1F);
+			switch (LNA_idx) {
+			case 7:
+				if (VGA_idx <= 27)
+					rx_pwr_all = -100 + 2*(27-VGA_idx); /* VGA_idx = 27~2 */
+				else
+					rx_pwr_all = -100;
+				break;
+			case 6:
+				rx_pwr_all = -48 + 2*(2-VGA_idx); /* VGA_idx = 2~0 */
+				break;
+			case 5:
+				rx_pwr_all = -42 + 2*(7-VGA_idx); /* VGA_idx = 7~5 */
+				break;
+			case 4:
+				rx_pwr_all = -36 + 2*(7-VGA_idx); /* VGA_idx = 7~4 */
+				break;
+			case 3:
+				rx_pwr_all = -24 + 2*(7-VGA_idx); /* VGA_idx = 7~0 */
+				break;
+			case 2:
+				if (cck_highpwr)
+					rx_pwr_all = -12 + 2*(5-VGA_idx); /* VGA_idx = 5~0 */
+				else
+					rx_pwr_all = -6 + 2*(5-VGA_idx);
+				break;
+			case 1:
+					rx_pwr_all = 8-2*VGA_idx;
+				break;
+			case 0:
+					rx_pwr_all = 14-2*VGA_idx;
+				break;
+			default:
+				break;
+			}
+			rx_pwr_all += 6;
+			PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+			if (!cck_highpwr) {
+				if (PWDB_ALL >= 80)
+					PWDB_ALL = ((PWDB_ALL-80)<<1)+((PWDB_ALL-80)>>1)+80;
+				else if ((PWDB_ALL <= 78) && (PWDB_ALL >= 20))
+					PWDB_ALL += 3;
+				if (PWDB_ALL > 100)
+					PWDB_ALL = 100;
+			}
+		} else {
+			if (!cck_highpwr) {
+				report = (cck_agc_rpt & 0xc0)>>6;
+				switch (report) {
+				/*  03312009 modified by cosa */
+				/*  Modify the RF RNA gain value to -40, -20, -2, 14 by Jenyu's suggestion */
+				/*  Note: different RF with the different RNA gain. */
+				case 0x3:
+					rx_pwr_all = -46 - (cck_agc_rpt & 0x3e);
+					break;
+				case 0x2:
+					rx_pwr_all = -26 - (cck_agc_rpt & 0x3e);
+					break;
+				case 0x1:
+					rx_pwr_all = -12 - (cck_agc_rpt & 0x3e);
+					break;
+				case 0x0:
+					rx_pwr_all = 16 - (cck_agc_rpt & 0x3e);
+					break;
+				}
+			} else {
+				report = (cck_agc_rpt & 0x60)>>5;
+				switch (report) {
+				case 0x3:
+					rx_pwr_all = -46 - ((cck_agc_rpt & 0x1f)<<1) ;
+					break;
+				case 0x2:
+					rx_pwr_all = -26 - ((cck_agc_rpt & 0x1f)<<1);
+					break;
+				case 0x1:
+					rx_pwr_all = -12 - ((cck_agc_rpt & 0x1f)<<1);
+					break;
+				case 0x0:
+					rx_pwr_all = 16 - ((cck_agc_rpt & 0x1f)<<1);
+					break;
+				}
+			}
+
+			PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+
+			/* Modification for ext-LNA board */
+			if (dm_odm->BoardType == ODM_BOARD_HIGHPWR) {
+				if ((cck_agc_rpt>>7) == 0) {
+					PWDB_ALL = (PWDB_ALL > 94) ? 100 : (PWDB_ALL+6);
+				} else {
+					if (PWDB_ALL > 38)
+						PWDB_ALL -= 16;
+					else
+						PWDB_ALL = (PWDB_ALL <= 16) ? (PWDB_ALL>>2) : (PWDB_ALL-12);
+				}
+
+				/* CCK modification */
+				if (PWDB_ALL > 25 && PWDB_ALL <= 60)
+					PWDB_ALL += 6;
+			} else {/* Modification for int-LNA board */
+				if (PWDB_ALL > 99)
+					PWDB_ALL -= 8;
+				else if (PWDB_ALL > 50 && PWDB_ALL <= 68)
+					PWDB_ALL += 4;
+			}
+		}
+
+		pPhyInfo->RxPWDBAll = PWDB_ALL;
+		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL;
+		pPhyInfo->RecvSignalPower = rx_pwr_all;
+		/*  (3) Get Signal Quality (EVM) */
+		if (pPktinfo->bPacketMatchBSSID) {
+			u8 SQ, SQ_rpt;
+
+			if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 19)) {
+				SQ = odm_SQ_process_patch_RT_CID_819x_Lenovo(dm_odm, isCCKrate, PWDB_ALL, 0, 0);
+			} else if (pPhyInfo->RxPWDBAll > 40 && !dm_odm->bInHctTest) {
+				SQ = 100;
+			} else {
+				SQ_rpt = pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all;
+
+				if (SQ_rpt > 64)
+					SQ = 0;
+				else if (SQ_rpt < 20)
+					SQ = 100;
+				else
+					SQ = ((64-SQ_rpt) * 100) / 44;
+			}
+			pPhyInfo->SignalQuality = SQ;
+			pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = SQ;
+			pPhyInfo->RxMIMOSignalQuality[RF_PATH_B] = -1;
+		}
+	} else { /* is OFDM rate */
+		dm_odm->PhyDbgInfo.NumQryPhyStatusOFDM++;
+
+		/*  (1)Get RSSI for HT rate */
+
+		 for (i = RF_PATH_A; i < RF_PATH_MAX; i++) {
+			/*  2008/01/30 MH we will judge RF RX path now. */
+			if (dm_odm->RFPathRxEnable & BIT(i))
+				rf_rx_num++;
+
+			rx_pwr[i] = ((pPhyStaRpt->path_agc[i].gain & 0x3F)*2) - 110;
+			if (i == RF_PATH_A)
+				adapt->signal_strength = rx_pwr[i];
+
+			pPhyInfo->RxPwr[i] = rx_pwr[i];
+
+			/* Translate DBM to percentage. */
+			RSSI = odm_QueryRxPwrPercentage(rx_pwr[i]);
+			total_rssi += RSSI;
+
+			/* Modification for ext-LNA board */
+			if (dm_odm->BoardType == ODM_BOARD_HIGHPWR) {
+				if ((pPhyStaRpt->path_agc[i].trsw) == 1)
+					RSSI = (RSSI > 94) ? 100 : (RSSI + 6);
+				else
+					RSSI = (RSSI <= 16) ? (RSSI >> 3) : (RSSI - 16);
+
+				if ((RSSI <= 34) && (RSSI >= 4))
+					RSSI -= 4;
+			}
+
+			pPhyInfo->RxMIMOSignalStrength[i] = (u8)RSSI;
+
+			/* Get Rx snr value in DB */
+			pPhyInfo->RxSNR[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
+			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
+
+			/* Record Signal Strength for next packet */
+			if (pPktinfo->bPacketMatchBSSID) {
+				if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 19)) {
+					if (i == RF_PATH_A)
+						pPhyInfo->SignalQuality = odm_SQ_process_patch_RT_CID_819x_Lenovo(dm_odm, isCCKrate, PWDB_ALL, i, RSSI);
+				}
+			}
+		}
+		/*  (2)PWDB, Average PWDB cacluated by hardware (for rate adaptive) */
+		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
+
+		PWDB_ALL = odm_QueryRxPwrPercentage(rx_pwr_all);
+		PWDB_ALL_BT = PWDB_ALL;
+
+		pPhyInfo->RxPWDBAll = PWDB_ALL;
+		pPhyInfo->BTRxRSSIPercentage = PWDB_ALL_BT;
+		pPhyInfo->RxPower = rx_pwr_all;
+		pPhyInfo->RecvSignalPower = rx_pwr_all;
+
+		if ((dm_odm->SupportPlatform == ODM_MP) && (dm_odm->PatchID == 19)) {
+			/* do nothing */
+		} else {
+			/*  (3)EVM of HT rate */
+			if (pPktinfo->Rate >= DESC92C_RATEMCS8 && pPktinfo->Rate <= DESC92C_RATEMCS15)
+				Max_spatial_stream = 2; /* both spatial stream make sense */
+			else
+				Max_spatial_stream = 1; /* only spatial stream 1 makes sense */
+
+			for (i = 0; i < Max_spatial_stream; i++) {
+				/*  Do not use shift operation like "rx_evmX >>= 1" because the compilor of free build environment */
+				/*  fill most significant bit to "zero" when doing shifting operation which may change a negative */
+				/*  value to positive one, then the dbm value (which is supposed to be negative)  is not correct anymore. */
+				EVM = odm_EVMdbToPercentage((pPhyStaRpt->stream_rxevm[i]));	/* dbm */
+
+				if (pPktinfo->bPacketMatchBSSID) {
+					if (i == RF_PATH_A) /*  Fill value in RFD, Get the first spatial stream only */
+						pPhyInfo->SignalQuality = (u8)(EVM & 0xff);
+					pPhyInfo->RxMIMOSignalQuality[i] = (u8)(EVM & 0xff);
+				}
+			}
+		}
+	}
+	/* UI BSS List signal strength(in percentage), make it good looking, from 0~100. */
+	/* It is assigned to the BSS List in GetValueFromBeaconOrProbeRsp(). */
+	if (isCCKrate) {
+		pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, PWDB_ALL));/* PWDB_ALL; */
+	} else {
+		if (rf_rx_num != 0)
+			pPhyInfo->SignalStrength = (u8)(odm_SignalScaleMapping(dm_odm, total_rssi /= rf_rx_num));
+	}
+
+	/* For 92C/92D HW (Hybrid) Antenna Diversity */
+	pDM_SWAT_Table->antsel = pPhyStaRpt->ant_sel;
+	/* For 88E HW Antenna Diversity */
+	dm_odm->DM_FatTable.antsel_rx_keep_0 = pPhyStaRpt->ant_sel;
+	dm_odm->DM_FatTable.antsel_rx_keep_1 = pPhyStaRpt->ant_sel_b;
+	dm_odm->DM_FatTable.antsel_rx_keep_2 = pPhyStaRpt->antsel_rx_keep_2;
+}
+
+void odm_Init_RSSIForDM(struct odm_dm_struct *dm_odm)
+{
+}
+
+static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
+				  struct odm_phy_status_info *pPhyInfo,
+				  struct odm_per_pkt_info *pPktinfo)
+{
+	s32 UndecoratedSmoothedPWDB, UndecoratedSmoothedCCK;
+	s32 UndecoratedSmoothedOFDM, RSSI_Ave;
+	u8 isCCKrate = 0;
+	u8 RSSI_max, RSSI_min, i;
+	u32 OFDM_pkt = 0;
+	u32 Weighting = 0;
+	struct sta_info *pEntry;
+
+	if (pPktinfo->StationID == 0xFF)
+		return;
+	pEntry = dm_odm->pODM_StaInfo[pPktinfo->StationID];
+	if (!IS_STA_VALID(pEntry))
+		return;
+	if ((!pPktinfo->bPacketMatchBSSID))
+		return;
+
+	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+
+	/* Smart Antenna Debug Message------------------  */
+	if (dm_odm->SupportICType == ODM_RTL8188E) {
+		u8 antsel_tr_mux;
+		struct fast_ant_train *pDM_FatTable = &dm_odm->DM_FatTable;
+
+		if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV) {
+			if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE) {
+				if (pPktinfo->bPacketToSelf) {
+					antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2<<2) |
+							(pDM_FatTable->antsel_rx_keep_1<<1) |
+							pDM_FatTable->antsel_rx_keep_0;
+					pDM_FatTable->antSumRSSI[antsel_tr_mux] += pPhyInfo->RxPWDBAll;
+					pDM_FatTable->antRSSIcnt[antsel_tr_mux]++;
+				}
+			}
+		} else if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
+			if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
+				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2<<2) |
+						(pDM_FatTable->antsel_rx_keep_1<<1) | pDM_FatTable->antsel_rx_keep_0;
+				ODM_AntselStatistics_88E(dm_odm, antsel_tr_mux, pPktinfo->StationID, pPhyInfo->RxPWDBAll);
+			}
+		}
+	}
+	/* Smart Antenna Debug Message------------------ */
+
+	UndecoratedSmoothedCCK =  pEntry->rssi_stat.UndecoratedSmoothedCCK;
+	UndecoratedSmoothedOFDM = pEntry->rssi_stat.UndecoratedSmoothedOFDM;
+	UndecoratedSmoothedPWDB = pEntry->rssi_stat.UndecoratedSmoothedPWDB;
+
+	if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
+		if (!isCCKrate) { /* ofdm rate */
+			if (pPhyInfo->RxMIMOSignalStrength[RF_PATH_B] == 0) {
+				RSSI_Ave = pPhyInfo->RxMIMOSignalStrength[RF_PATH_A];
+			} else {
+				if (pPhyInfo->RxMIMOSignalStrength[RF_PATH_A] > pPhyInfo->RxMIMOSignalStrength[RF_PATH_B]) {
+					RSSI_max = pPhyInfo->RxMIMOSignalStrength[RF_PATH_A];
+					RSSI_min = pPhyInfo->RxMIMOSignalStrength[RF_PATH_B];
+				} else {
+					RSSI_max = pPhyInfo->RxMIMOSignalStrength[RF_PATH_B];
+					RSSI_min = pPhyInfo->RxMIMOSignalStrength[RF_PATH_A];
+				}
+				if ((RSSI_max - RSSI_min) < 3)
+					RSSI_Ave = RSSI_max;
+				else if ((RSSI_max - RSSI_min) < 6)
+					RSSI_Ave = RSSI_max - 1;
+				else if ((RSSI_max - RSSI_min) < 10)
+					RSSI_Ave = RSSI_max - 2;
+				else
+					RSSI_Ave = RSSI_max - 3;
+			}
+
+			/* 1 Process OFDM RSSI */
+			if (UndecoratedSmoothedOFDM <= 0) {	/*  initialize */
+				UndecoratedSmoothedOFDM = pPhyInfo->RxPWDBAll;
+			} else {
+				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedOFDM) {
+					UndecoratedSmoothedOFDM =
+							(((UndecoratedSmoothedOFDM)*(Rx_Smooth_Factor-1)) +
+							(RSSI_Ave)) / (Rx_Smooth_Factor);
+					UndecoratedSmoothedOFDM = UndecoratedSmoothedOFDM + 1;
+				} else {
+					UndecoratedSmoothedOFDM =
+							(((UndecoratedSmoothedOFDM)*(Rx_Smooth_Factor-1)) +
+							(RSSI_Ave)) / (Rx_Smooth_Factor);
+				}
+			}
+
+			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap<<1) | BIT0;
+
+		} else {
+			RSSI_Ave = pPhyInfo->RxPWDBAll;
+
+			/* 1 Process CCK RSSI */
+			if (UndecoratedSmoothedCCK <= 0) {	/*  initialize */
+				UndecoratedSmoothedCCK = pPhyInfo->RxPWDBAll;
+			} else {
+				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedCCK) {
+					UndecoratedSmoothedCCK =
+							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor-1)) +
+							pPhyInfo->RxPWDBAll) / Rx_Smooth_Factor;
+					UndecoratedSmoothedCCK = UndecoratedSmoothedCCK + 1;
+				} else {
+					UndecoratedSmoothedCCK =
+							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor-1)) +
+							pPhyInfo->RxPWDBAll) / Rx_Smooth_Factor;
+				}
+			}
+			pEntry->rssi_stat.PacketMap = pEntry->rssi_stat.PacketMap<<1;
+		}
+		/* 2011.07.28 LukeLee: modified to prevent unstable CCK RSSI */
+		if (pEntry->rssi_stat.ValidBit >= 64)
+			pEntry->rssi_stat.ValidBit = 64;
+		else
+			pEntry->rssi_stat.ValidBit++;
+
+		for (i = 0; i < pEntry->rssi_stat.ValidBit; i++)
+			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap>>i)&BIT0;
+
+		if (pEntry->rssi_stat.ValidBit == 64) {
+			Weighting = ((OFDM_pkt<<4) > 64) ? 64 : (OFDM_pkt<<4);
+			UndecoratedSmoothedPWDB = (Weighting*UndecoratedSmoothedOFDM+(64-Weighting)*UndecoratedSmoothedCCK)>>6;
+		} else {
+			if (pEntry->rssi_stat.ValidBit != 0)
+				UndecoratedSmoothedPWDB = (OFDM_pkt * UndecoratedSmoothedOFDM +
+							  (pEntry->rssi_stat.ValidBit-OFDM_pkt) *
+							  UndecoratedSmoothedCCK)/pEntry->rssi_stat.ValidBit;
+			else
+				UndecoratedSmoothedPWDB = 0;
+		}
+		pEntry->rssi_stat.UndecoratedSmoothedCCK = UndecoratedSmoothedCCK;
+		pEntry->rssi_stat.UndecoratedSmoothedOFDM = UndecoratedSmoothedOFDM;
+		pEntry->rssi_stat.UndecoratedSmoothedPWDB = UndecoratedSmoothedPWDB;
+	}
+}
+
+/*  Endianness before calling this API */
+static void ODM_PhyStatusQuery_92CSeries(struct odm_dm_struct *dm_odm,
+					 struct odm_phy_status_info *pPhyInfo,
+					 u8 *pPhyStatus,
+					 struct odm_per_pkt_info *pPktinfo,
+					 struct adapter *adapt)
+{
+	odm_RxPhyStatus92CSeries_Parsing(dm_odm, pPhyInfo, pPhyStatus,
+					 pPktinfo, adapt);
+	if (dm_odm->RSSI_test) {
+		/*  Select the packets to do RSSI checking for antenna switching. */
+		if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon)
+				ODM_SwAntDivChkPerPktRssi(dm_odm, pPktinfo->StationID, pPhyInfo);
+	} else {
+		odm_Process_RSSIForDM(dm_odm, pPhyInfo, pPktinfo);
+	}
+}
+
+void ODM_PhyStatusQuery(struct odm_dm_struct *dm_odm,
+			struct odm_phy_status_info *pPhyInfo,
+			u8 *pPhyStatus, struct odm_per_pkt_info *pPktinfo,
+			struct adapter *adapt)
+{
+	ODM_PhyStatusQuery_92CSeries(dm_odm, pPhyInfo, pPhyStatus, pPktinfo, adapt);
+}
+
+/*  For future use. */
+void ODM_MacStatusQuery(struct odm_dm_struct *dm_odm, u8 *mac_stat,
+			u8 macid, bool pkt_match_bssid,
+			bool pkttoself, bool pkt_beacon)
+{
+	/*  2011/10/19 Driver team will handle in the future. */
+}
+
+enum HAL_STATUS ODM_ConfigRFWithHeaderFile(struct odm_dm_struct *dm_odm,
+					   enum rf_radio_path content,
+					   enum rf_radio_path rfpath)
+{
+	ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("===>ODM_ConfigRFWithHeaderFile\n"));
+	if (dm_odm->SupportICType == ODM_RTL8188E) {
+		if (rfpath == RF_PATH_A)
+			READ_AND_CONFIG(8188E, _RadioA_1T_);
+		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, (" ===> ODM_ConfigRFWithHeaderFile() Radio_A:Rtl8188ERadioA_1TArray\n"));
+		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, (" ===> ODM_ConfigRFWithHeaderFile() Radio_B:Rtl8188ERadioB_1TArray\n"));
+	}
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("ODM_ConfigRFWithHeaderFile: Radio No %x\n", rfpath));
+	return HAL_STATUS_SUCCESS;
+}
+
+enum HAL_STATUS ODM_ConfigBBWithHeaderFile(struct odm_dm_struct *dm_odm,
+					   enum odm_bb_config_type config_tp)
+{
+	if (dm_odm->SupportICType == ODM_RTL8188E) {
+		if (config_tp == CONFIG_BB_PHY_REG) {
+			READ_AND_CONFIG(8188E, _PHY_REG_1T_);
+		} else if (config_tp == CONFIG_BB_AGC_TAB) {
+			READ_AND_CONFIG(8188E, _AGC_TAB_1T_);
+		} else if (config_tp == CONFIG_BB_PHY_REG_PG) {
+			READ_AND_CONFIG(8188E, _PHY_REG_PG_);
+			ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD,
+				     (" ===> phy_ConfigBBWithHeaderFile() agc:Rtl8188EPHY_REG_PGArray\n"));
+		}
+	}
+	return HAL_STATUS_SUCCESS;
+}
+
+enum HAL_STATUS ODM_ConfigMACWithHeaderFile(struct odm_dm_struct *dm_odm)
+{
+	u8 result = HAL_STATUS_SUCCESS;
+	if (dm_odm->SupportICType == ODM_RTL8188E)
+		result = READ_AND_CONFIG(8188E, _MAC_REG_);
+	return result;
+}
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
new file mode 100644
index 000000000000..858fc39de6aa
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -0,0 +1,400 @@
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
+#include "odm_precomp.h"
+
+void ODM_DIG_LowerBound_88E(struct odm_dm_struct *dm_odm)
+{
+	struct rtw_dig *pDM_DigTable = &dm_odm->DM_DigTable;
+
+	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
+		pDM_DigTable->rx_gain_range_min = (u8) pDM_DigTable->AntDiv_RSSI_max;
+		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+			     ("ODM_DIG_LowerBound_88E(): pDM_DigTable->AntDiv_RSSI_max=%d\n", pDM_DigTable->AntDiv_RSSI_max));
+	}
+	/* If only one Entry connected */
+}
+
+static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
+{
+	u32	value32;
+
+	if (*(dm_odm->mp_mode) == 1) {
+		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
+		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0); /*  disable HW AntDiv */
+		ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);  /*  1:CG, 0:CS */
+		return;
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("odm_RX_HWAntDivInit()\n"));
+
+	/* MAC Setting */
+	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
+	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT23|BIT25)); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	/* Pin Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT9|BIT8, 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT10, 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT22, 1);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);	/* Regb2c[31]=1'b1	output at CG only */
+	/* OFDM Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
+	/* CCK Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT7, 1); /* Fix CCK PHY status report issue */
+	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT4, 1); /* CCK complete HW AntDiv within 64 samples */
+	ODM_UpdateRxIdleAnt_88E(dm_odm, MAIN_ANT);
+	ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, 0xFFFF, 0x0201);	/* antenna mapping table */
+}
+
+static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
+{
+	u32	value32;
+
+	if (*(dm_odm->mp_mode) == 1) {
+		dm_odm->AntDivType = CGCS_RX_SW_ANTDIV;
+		ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0); /*  disable HW AntDiv */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, 0); /* Default RX   (0/1) */
+		return;
+	}
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("odm_TRX_HWAntDivInit()\n"));
+
+	/* MAC Setting */
+	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
+	ODM_SetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32|(BIT23|BIT25)); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	/* Pin Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT9|BIT8, 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT10, 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT22, 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	ODM_SetBBReg(dm_odm, ODM_REG_LNA_SWITCH_11N, BIT31, 1);	/* Regb2c[31]=1'b1	output at CG only */
+	/* OFDM Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_ANTDIV_PARA1_11N, bMaskDWord, 0x000000a0);
+	/* CCK Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_BB_PWR_SAV4_11N, BIT7, 1); /* Fix CCK PHY status report issue */
+	ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA2_11N, BIT4, 1); /* CCK complete HW AntDiv within 64 samples */
+	/* Tx Settings */
+	ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT21, 0); /* Reg80c[21]=1'b0		from TX Reg */
+	ODM_UpdateRxIdleAnt_88E(dm_odm, MAIN_ANT);
+
+	/* antenna mapping table */
+	if (!dm_odm->bIsMPChip) { /* testchip */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT10|BIT9|BIT8, 1);	/* Reg858[10:8]=3'b001 */
+		ODM_SetBBReg(dm_odm, ODM_REG_RX_DEFUALT_A_11N, BIT13|BIT12|BIT11, 2);	/* Reg858[13:11]=3'b010 */
+	} else { /* MPchip */
+		ODM_SetBBReg(dm_odm, ODM_REG_ANT_MAPPING1_11N, bMaskDWord, 0x0201);	/* Reg914=3'b010, Reg915=3'b001 */
+	}
+}
+
+static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
+{
+	u32	value32, i;
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	u32	AntCombination = 2;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("odm_FastAntTrainingInit()\n"));
+
+	if (*(dm_odm->mp_mode) == 1) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_INIT, ODM_DBG_LOUD, ("dm_odm->AntDivType: %d\n", dm_odm->AntDivType));
+		return;
+	}
+
+	for (i = 0; i < 6; i++) {
+		dm_fat_tbl->Bssid[i] = 0;
+		dm_fat_tbl->antSumRSSI[i] = 0;
+		dm_fat_tbl->antRSSIcnt[i] = 0;
+		dm_fat_tbl->antAveRSSI[i] = 0;
+	}
+	dm_fat_tbl->TrainIdx = 0;
+	dm_fat_tbl->FAT_State = FAT_NORMAL_STATE;
+
+	/* MAC Setting */
+	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
+	ODM_SetMACReg(dm_odm, 0x4c, bMaskDWord, value32|(BIT23|BIT25)); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
+	value32 = ODM_GetMACReg(dm_odm,  0x7B4, bMaskDWord);
+	ODM_SetMACReg(dm_odm, 0x7b4, bMaskDWord, value32|(BIT16|BIT17)); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
+
+	/* Match MAC ADDR */
+	ODM_SetMACReg(dm_odm, 0x7b4, 0xFFFF, 0);
+	ODM_SetMACReg(dm_odm, 0x7b0, bMaskDWord, 0);
+
+	ODM_SetBBReg(dm_odm, 0x870, BIT9|BIT8, 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
+	ODM_SetBBReg(dm_odm, 0x864, BIT10, 0);	/* Reg864[10]=1'b0	antsel2 by HW */
+	ODM_SetBBReg(dm_odm, 0xb2c, BIT22, 0);	/* Regb2c[22]=1'b0	disable CS/CG switch */
+	ODM_SetBBReg(dm_odm, 0xb2c, BIT31, 1);	/* Regb2c[31]=1'b1	output at CG only */
+	ODM_SetBBReg(dm_odm, 0xca4, bMaskDWord, 0x000000a0);
+
+	/* antenna mapping table */
+	if (AntCombination == 2) {
+		if (!dm_odm->bIsMPChip) { /* testchip */
+			ODM_SetBBReg(dm_odm, 0x858, BIT10|BIT9|BIT8, 1);	/* Reg858[10:8]=3'b001 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT13|BIT12|BIT11, 2);	/* Reg858[13:11]=3'b010 */
+		} else { /* MPchip */
+			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 1);
+			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 2);
+		}
+	} else if (AntCombination == 7) {
+		if (!dm_odm->bIsMPChip) { /* testchip */
+			ODM_SetBBReg(dm_odm, 0x858, BIT10|BIT9|BIT8, 0);	/* Reg858[10:8]=3'b000 */
+			ODM_SetBBReg(dm_odm, 0x858, BIT13|BIT12|BIT11, 1);	/* Reg858[13:11]=3'b001 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT16, 0);
+			ODM_SetBBReg(dm_odm, 0x858, BIT15|BIT14, 2);	/* Reg878[0],Reg858[14:15])=3'b010 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT19|BIT18|BIT17, 3);/* Reg878[3:1]=3b'011 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT22|BIT21|BIT20, 4);/* Reg878[6:4]=3b'100 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT25|BIT24|BIT23, 5);/* Reg878[9:7]=3b'101 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT28|BIT27|BIT26, 6);/* Reg878[12:10]=3b'110 */
+			ODM_SetBBReg(dm_odm, 0x878, BIT31|BIT30|BIT29, 7);/* Reg878[15:13]=3b'111 */
+		} else { /* MPchip */
+			ODM_SetBBReg(dm_odm, 0x914, bMaskByte0, 0);
+			ODM_SetBBReg(dm_odm, 0x914, bMaskByte1, 1);
+			ODM_SetBBReg(dm_odm, 0x914, bMaskByte2, 2);
+			ODM_SetBBReg(dm_odm, 0x914, bMaskByte3, 3);
+			ODM_SetBBReg(dm_odm, 0x918, bMaskByte0, 4);
+			ODM_SetBBReg(dm_odm, 0x918, bMaskByte1, 5);
+			ODM_SetBBReg(dm_odm, 0x918, bMaskByte2, 6);
+			ODM_SetBBReg(dm_odm, 0x918, bMaskByte3, 7);
+		}
+	}
+
+	/* Default Ant Setting when no fast training */
+	ODM_SetBBReg(dm_odm, 0x80c, BIT21, 1); /* Reg80c[21]=1'b1		from TX Info */
+	ODM_SetBBReg(dm_odm, 0x864, BIT5|BIT4|BIT3, 0);	/* Default RX */
+	ODM_SetBBReg(dm_odm, 0x864, BIT8|BIT7|BIT6, 1);	/* Optional RX */
+
+	/* Enter Traing state */
+	ODM_SetBBReg(dm_odm, 0x864, BIT2|BIT1|BIT0, (AntCombination-1));	/* Reg864[2:0]=3'd6	ant combination=reg864[2:0]+1 */
+	ODM_SetBBReg(dm_odm, 0xc50, BIT7, 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
+}
+
+void ODM_AntennaDiversityInit_88E(struct odm_dm_struct *dm_odm)
+{
+	if (dm_odm->SupportICType != ODM_RTL8188E)
+		return;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("dm_odm->AntDivType=%d\n", dm_odm->AntDivType));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("dm_odm->bIsMPChip=%s\n", (dm_odm->bIsMPChip ? "true" : "false")));
+
+	if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)
+		odm_RX_HWAntDivInit(dm_odm);
+	else if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
+		odm_TRX_HWAntDivInit(dm_odm);
+	else if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV)
+		odm_FastAntTrainingInit(dm_odm);
+}
+
+void ODM_UpdateRxIdleAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant)
+{
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	u32	DefaultAnt, OptionalAnt;
+
+	if (dm_fat_tbl->RxIdleAnt != Ant) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Need to Update Rx Idle Ant\n"));
+		if (Ant == MAIN_ANT) {
+			DefaultAnt = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ? MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
+			OptionalAnt = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ? AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
+		} else {
+			DefaultAnt = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ? AUX_ANT_CG_TRX : AUX_ANT_CGCS_RX;
+			OptionalAnt = (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) ? MAIN_ANT_CG_TRX : MAIN_ANT_CGCS_RX;
+		}
+
+		if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, DefaultAnt);	/* Default RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT8|BIT7|BIT6, OptionalAnt);		/* Optional RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_ANTSEL_CTRL_11N, BIT14|BIT13|BIT12, DefaultAnt);	/* Default TX */
+			ODM_SetMACReg(dm_odm, ODM_REG_RESP_TX_11N, BIT6|BIT7, DefaultAnt);	/* Resp Tx */
+		} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT5|BIT4|BIT3, DefaultAnt);	/* Default RX */
+			ODM_SetBBReg(dm_odm, ODM_REG_RX_ANT_CTRL_11N, BIT8|BIT7|BIT6, OptionalAnt);		/* Optional RX */
+		}
+	}
+	dm_fat_tbl->RxIdleAnt = Ant;
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("RxIdleAnt=%s\n", (Ant == MAIN_ANT) ? "MAIN_ANT" : "AUX_ANT"));
+	if (Ant != MAIN_ANT)
+		pr_info("RxIdleAnt=AUX_ANT\n");
+}
+
+static void odm_UpdateTxAnt_88E(struct odm_dm_struct *dm_odm, u8 Ant, u32 MacId)
+{
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	u8	TargetAnt;
+
+	if (Ant == MAIN_ANT)
+		TargetAnt = MAIN_ANT_CG_TRX;
+	else
+		TargetAnt = AUX_ANT_CG_TRX;
+	dm_fat_tbl->antsel_a[MacId] = TargetAnt&BIT0;
+	dm_fat_tbl->antsel_b[MacId] = (TargetAnt&BIT1)>>1;
+	dm_fat_tbl->antsel_c[MacId] = (TargetAnt&BIT2)>>2;
+
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+		     ("Tx from TxInfo, TargetAnt=%s\n",
+		     (Ant == MAIN_ANT) ? "MAIN_ANT" : "AUX_ANT"));
+	ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+		     ("antsel_tr_mux=3'b%d%d%d\n",
+		     dm_fat_tbl->antsel_c[MacId], dm_fat_tbl->antsel_b[MacId], dm_fat_tbl->antsel_a[MacId]));
+}
+
+void ODM_SetTxAntByTxInfo_88E(struct odm_dm_struct *dm_odm, u8 *pDesc, u8 macId)
+{
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+
+	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV)) {
+		SET_TX_DESC_ANTSEL_A_88E(pDesc, dm_fat_tbl->antsel_a[macId]);
+		SET_TX_DESC_ANTSEL_B_88E(pDesc, dm_fat_tbl->antsel_b[macId]);
+		SET_TX_DESC_ANTSEL_C_88E(pDesc, dm_fat_tbl->antsel_c[macId]);
+	}
+}
+
+void ODM_AntselStatistics_88E(struct odm_dm_struct *dm_odm, u8 antsel_tr_mux, u32 MacId, u8 RxPWDBAll)
+{
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV) {
+		if (antsel_tr_mux == MAIN_ANT_CG_TRX) {
+			dm_fat_tbl->MainAnt_Sum[MacId] += RxPWDBAll;
+			dm_fat_tbl->MainAnt_Cnt[MacId]++;
+		} else {
+			dm_fat_tbl->AuxAnt_Sum[MacId] += RxPWDBAll;
+			dm_fat_tbl->AuxAnt_Cnt[MacId]++;
+		}
+	} else if (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV) {
+		if (antsel_tr_mux == MAIN_ANT_CGCS_RX) {
+			dm_fat_tbl->MainAnt_Sum[MacId] += RxPWDBAll;
+			dm_fat_tbl->MainAnt_Cnt[MacId]++;
+		} else {
+			dm_fat_tbl->AuxAnt_Sum[MacId] += RxPWDBAll;
+			dm_fat_tbl->AuxAnt_Cnt[MacId]++;
+		}
+	}
+}
+
+static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
+{
+	u32	i, MinRSSI = 0xFF, AntDivMaxRSSI = 0, MaxRSSI = 0, LocalMinRSSI, LocalMaxRSSI;
+	u32	Main_RSSI, Aux_RSSI;
+	u8	RxIdleAnt = 0, TargetAnt = 7;
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	struct rtw_dig *pDM_DigTable = &dm_odm->DM_DigTable;
+	struct sta_info *pEntry;
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		pEntry = dm_odm->pODM_StaInfo[i];
+		if (IS_STA_VALID(pEntry)) {
+			/* 2 Caculate RSSI per Antenna */
+			Main_RSSI = (dm_fat_tbl->MainAnt_Cnt[i] != 0) ? (dm_fat_tbl->MainAnt_Sum[i]/dm_fat_tbl->MainAnt_Cnt[i]) : 0;
+			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i]/dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
+			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
+			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+				     ("MacID=%d, MainAnt_Sum=%d, MainAnt_Cnt=%d\n",
+				     i, dm_fat_tbl->MainAnt_Sum[i],
+				     dm_fat_tbl->MainAnt_Cnt[i]));
+			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+				     ("MacID=%d, AuxAnt_Sum=%d, AuxAnt_Cnt=%d\n",
+				     i, dm_fat_tbl->AuxAnt_Sum[i], dm_fat_tbl->AuxAnt_Cnt[i]));
+			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD,
+				     ("MacID=%d, Main_RSSI= %d, Aux_RSSI= %d\n",
+				     i, Main_RSSI, Aux_RSSI));
+			/* 2 Select MaxRSSI for DIG */
+			LocalMaxRSSI = (Main_RSSI > Aux_RSSI) ? Main_RSSI : Aux_RSSI;
+			if ((LocalMaxRSSI > AntDivMaxRSSI) && (LocalMaxRSSI < 40))
+				AntDivMaxRSSI = LocalMaxRSSI;
+			if (LocalMaxRSSI > MaxRSSI)
+				MaxRSSI = LocalMaxRSSI;
+
+			/* 2 Select RX Idle Antenna */
+			if ((dm_fat_tbl->RxIdleAnt == MAIN_ANT) && (Main_RSSI == 0))
+				Main_RSSI = Aux_RSSI;
+			else if ((dm_fat_tbl->RxIdleAnt == AUX_ANT) && (Aux_RSSI == 0))
+				Aux_RSSI = Main_RSSI;
+
+			LocalMinRSSI = (Main_RSSI > Aux_RSSI) ? Aux_RSSI : Main_RSSI;
+			if (LocalMinRSSI < MinRSSI) {
+				MinRSSI = LocalMinRSSI;
+				RxIdleAnt = TargetAnt;
+			}
+			/* 2 Select TRX Antenna */
+			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
+				odm_UpdateTxAnt_88E(dm_odm, TargetAnt, i);
+		}
+		dm_fat_tbl->MainAnt_Sum[i] = 0;
+		dm_fat_tbl->AuxAnt_Sum[i] = 0;
+		dm_fat_tbl->MainAnt_Cnt[i] = 0;
+		dm_fat_tbl->AuxAnt_Cnt[i] = 0;
+	}
+
+	/* 2 Set RX Idle Antenna */
+	ODM_UpdateRxIdleAnt_88E(dm_odm, RxIdleAnt);
+
+	pDM_DigTable->AntDiv_RSSI_max = AntDivMaxRSSI;
+	pDM_DigTable->RSSI_max = MaxRSSI;
+}
+
+void ODM_AntennaDiversity_88E(struct odm_dm_struct *dm_odm)
+{
+	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
+	if ((dm_odm->SupportICType != ODM_RTL8188E) || (!(dm_odm->SupportAbility & ODM_BB_ANT_DIV)))
+		return;
+	if (!dm_odm->bLinked) {
+		ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("ODM_AntennaDiversity_88E(): No Link.\n"));
+		if (dm_fat_tbl->bBecomeLinked) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Need to Turn off HW AntDiv\n"));
+			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 0);	/* RegC50[7]=1'b1		enable HW AntDiv */
+			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT15, 0); /* Enable CCK AntDiv */
+			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
+				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT21, 0); /* Reg80c[21]=1'b0		from TX Reg */
+			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
+		}
+		return;
+	} else {
+		if (!dm_fat_tbl->bBecomeLinked) {
+			ODM_RT_TRACE(dm_odm, ODM_COMP_ANT_DIV, ODM_DBG_LOUD, ("Need to Turn on HW AntDiv\n"));
+			/* Because HW AntDiv is disabled before Link, we enable HW AntDiv after link */
+			ODM_SetBBReg(dm_odm, ODM_REG_IGI_A_11N, BIT7, 1);	/* RegC50[7]=1'b1		enable HW AntDiv */
+			ODM_SetBBReg(dm_odm, ODM_REG_CCK_ANTDIV_PARA1_11N, BIT15, 1); /* Enable CCK AntDiv */
+			if (dm_odm->AntDivType == CG_TRX_HW_ANTDIV)
+				ODM_SetBBReg(dm_odm, ODM_REG_TX_ANT_CTRL_11N, BIT21, 1); /* Reg80c[21]=1'b1		from TX Info */
+			dm_fat_tbl->bBecomeLinked = dm_odm->bLinked;
+		}
+	}
+	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV))
+		odm_HWAntDiv(dm_odm);
+}
+
+/* 3============================================================ */
+/* 3 Dynamic Primary CCA */
+/* 3============================================================ */
+
+void odm_PrimaryCCA_Init(struct odm_dm_struct *dm_odm)
+{
+	struct dyn_primary_cca *PrimaryCCA = &(dm_odm->DM_PriCCA);
+
+	PrimaryCCA->DupRTS_flag = 0;
+	PrimaryCCA->intf_flag = 0;
+	PrimaryCCA->intf_type = 0;
+	PrimaryCCA->Monitor_flag = 0;
+	PrimaryCCA->PriCCA_flag = 0;
+}
+
+bool ODM_DynamicPrimaryCCA_DupRTS(struct odm_dm_struct *dm_odm)
+{
+	struct dyn_primary_cca *PrimaryCCA = &(dm_odm->DM_PriCCA);
+
+	return	PrimaryCCA->DupRTS_flag;
+}
+
+void odm_DynamicPrimaryCCA(struct odm_dm_struct *dm_odm)
+{
+	return;
+}
diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
new file mode 100644
index 000000000000..0ff31370fb98
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
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
+
+#include "odm_precomp.h"
+
+void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+			   u32 Data, enum rf_radio_path RF_PATH,
+			   u32 RegAddr)
+{
+    if (Addr == 0xffe) {
+		ODM_sleep_ms(50);
+	} else if (Addr == 0xfd) {
+		ODM_delay_ms(5);
+	} else if (Addr == 0xfc) {
+		ODM_delay_ms(1);
+	} else if (Addr == 0xfb) {
+		ODM_delay_us(50);
+	} else if (Addr == 0xfa) {
+		ODM_delay_us(5);
+	} else if (Addr == 0xf9) {
+		ODM_delay_us(1);
+	} else {
+		ODM_SetRFReg(pDM_Odm, RF_PATH, RegAddr, bRFRegOffsetMask, Data);
+		/*  Add 1us delay between BB/RF register setting. */
+		ODM_delay_us(1);
+	}
+}
+
+void odm_ConfigRF_RadioA_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
+{
+	u32  content = 0x1000; /*  RF_Content: radioa_txt */
+	u32 maskforPhySet = (u32)(content&0xE000);
+
+	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_A, Addr|maskforPhySet);
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigRFWithHeaderFile: [RadioA] %08X %08X\n", Addr, Data));
+}
+
+void odm_ConfigRF_RadioB_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Data)
+{
+	u32  content = 0x1001; /*  RF_Content: radiob_txt */
+	u32 maskforPhySet = (u32)(content&0xE000);
+
+	odm_ConfigRFReg_8188E(pDM_Odm, Addr, Data, RF_PATH_B, Addr|maskforPhySet);
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigRFWithHeaderFile: [RadioB] %08X %08X\n", Addr, Data));
+}
+
+void odm_ConfigMAC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u8 Data)
+{
+	ODM_Write1Byte(pDM_Odm, Addr, Data);
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE, ("===> ODM_ConfigMACWithHeaderFile: [MAC_REG] %08X %08X\n", Addr, Data));
+}
+
+void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
+{
+	ODM_SetBBReg(pDM_Odm, Addr, Bitmask, Data);
+	/*  Add 1us delay between BB/RF register setting. */
+	ODM_delay_us(1);
+
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE,
+		     ("===> ODM_ConfigBBWithHeaderFile: [AGC_TAB] %08X %08X\n",
+		     Addr, Data));
+}
+
+void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
+				   u32 Bitmask, u32 Data)
+{
+	if (Addr == 0xfe) {
+		ODM_sleep_ms(50);
+	} else if (Addr == 0xfd) {
+		ODM_delay_ms(5);
+	} else if (Addr == 0xfc) {
+		ODM_delay_ms(1);
+	} else if (Addr == 0xfb) {
+		ODM_delay_us(50);
+	} else if (Addr == 0xfa) {
+		ODM_delay_us(5);
+	} else if (Addr == 0xf9) {
+		ODM_delay_us(1);
+	} else{
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_LOUD,
+			     ("===> @@@@@@@ ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X %08X\n",
+			     Addr, Bitmask, Data));
+		storePwrIndexDiffRateOffset(pDM_Odm->Adapter, Addr, Bitmask, Data);
+	}
+}
+
+void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask, u32 Data)
+{
+	if (Addr == 0xfe) {
+		ODM_sleep_ms(50);
+	} else if (Addr == 0xfd) {
+		ODM_delay_ms(5);
+	} else if (Addr == 0xfc) {
+		ODM_delay_ms(1);
+	} else if (Addr == 0xfb) {
+		ODM_delay_us(50);
+	} else if (Addr == 0xfa) {
+		ODM_delay_us(5);
+	} else if (Addr == 0xf9) {
+		ODM_delay_us(1);
+	} else {
+		if (Addr == 0xa24)
+			pDM_Odm->RFCalibrateInfo.RegA24 = Data;
+		ODM_SetBBReg(pDM_Odm, Addr, Bitmask, Data);
+
+		/*  Add 1us delay between BB/RF register setting. */
+		ODM_delay_us(1);
+		ODM_RT_TRACE(pDM_Odm, ODM_COMP_INIT, ODM_DBG_TRACE,
+			     ("===> ODM_ConfigBBWithHeaderFile: [PHY_REG] %08X %08X\n",
+			     Addr, Data));
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
new file mode 100644
index 000000000000..84caadd6c8e5
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/odm_debug.c
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
+/*  include files */
+
+#include "odm_precomp.h"
+
+void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm)
+{
+	pDM_Odm->DebugLevel = ODM_DBG_TRACE;
+
+	pDM_Odm->DebugComponents = 0;
+}
+
+u32 GlobalDebugLevel;
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
new file mode 100644
index 000000000000..3be5a5f8d873
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -0,0 +1,205 @@
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
+#include "odm_precomp.h"
+/*  ODM IO Relative API. */
+
+u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	return rtw_read8(Adapter, RegAddr);
+}
+
+u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	return rtw_read16(Adapter, RegAddr);
+}
+
+u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	return rtw_read32(Adapter, RegAddr);
+}
+
+void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	rtw_write8(Adapter, RegAddr, Data);
+}
+
+void ODM_Write2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 Data)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	rtw_write16(Adapter, RegAddr, Data);
+}
+
+void ODM_Write4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 Data)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	rtw_write32(Adapter, RegAddr, Data);
+}
+
+void ODM_SetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
+}
+
+u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	return PHY_QueryBBReg(Adapter, RegAddr, BitMask);
+}
+
+void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	PHY_SetBBReg(Adapter, RegAddr, BitMask, Data);
+}
+
+u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	return PHY_QueryBBReg(Adapter, RegAddr, BitMask);
+}
+
+void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask, u32 Data)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask, Data);
+}
+
+u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	return PHY_QueryRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask);
+}
+
+/*  ODM Memory relative API. */
+void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length)
+{
+	*pPtr = rtw_zvmalloc(length);
+}
+
+/*  length could be ignored, used to detect memory leakage. */
+void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length)
+{
+	rtw_vmfree(pPtr, length);
+}
+
+s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
+{
+	return !memcmp(pBuf1, pBuf2, length);
+}
+
+/*  ODM MISC relative API. */
+void ODM_AcquireSpinLock(struct odm_dm_struct *pDM_Odm, enum RT_SPINLOCK_TYPE type)
+{
+}
+
+void ODM_ReleaseSpinLock(struct odm_dm_struct *pDM_Odm, enum RT_SPINLOCK_TYPE type)
+{
+}
+
+/*  Work item relative API. FOr MP driver only~! */
+void ODM_InitializeWorkItem(struct odm_dm_struct *pDM_Odm, void *pRtWorkItem,
+			    RT_WORKITEM_CALL_BACK RtWorkItemCallback,
+			    void *pContext, const char *szID)
+{
+}
+
+void ODM_StartWorkItem(void *pRtWorkItem)
+{
+}
+
+void ODM_StopWorkItem(void *pRtWorkItem)
+{
+}
+
+void ODM_FreeWorkItem(void *pRtWorkItem)
+{
+}
+
+void ODM_ScheduleWorkItem(void *pRtWorkItem)
+{
+}
+
+void ODM_IsWorkItemScheduled(void *pRtWorkItem)
+{
+}
+
+/*  ODM Timer relative API. */
+void ODM_StallExecution(u32 usDelay)
+{
+	rtw_udelay_os(usDelay);
+}
+
+void ODM_delay_ms(u32 ms)
+{
+	rtw_mdelay_os(ms);
+}
+
+void ODM_delay_us(u32 us)
+{
+	rtw_udelay_os(us);
+}
+
+void ODM_sleep_ms(u32 ms)
+{
+	rtw_msleep_os(ms);
+}
+
+void ODM_sleep_us(u32 us)
+{
+	rtw_usleep_os(us);
+}
+
+void ODM_SetTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer, u32 msDelay)
+{
+	_set_timer(pTimer, msDelay); /* ms */
+}
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 15, 0)
+void ODM_InitializeTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer,
+			 void *CallBackFunc, void *pContext,
+			 const char *szID)
+{
+	struct adapter *Adapter = pDM_Odm->Adapter;
+	_init_timer(pTimer, Adapter->pnetdev, CallBackFunc, pDM_Odm);
+}
+#endif
+
+void ODM_CancelTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
+{
+	_cancel_timer_ex(pTimer);
+}
+
+void ODM_ReleaseTimer(struct odm_dm_struct *pDM_Odm, struct timer_list *pTimer)
+{
+}
+
+/*  ODM FW relative API. */
+u32 ODM_FillH2CCmd(u8 *pH2CBuffer, u32 H2CBufferLen, u32 CmdNum,
+		      u32 *pElementID, u32 *pCmdLen,
+		      u8 **pCmbBuffer, u8 *CmdStartSeq)
+{
+	return	true;
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
new file mode 100644
index 000000000000..d60db45a6f0b
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -0,0 +1,762 @@
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
+#define _RTL8188E_CMD_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <recv_osdep.h>
+#include <cmd_osdep.h>
+#include <mlme_osdep.h>
+#include <rtw_ioctl_set.h>
+
+#include <rtl8188e_hal.h>
+
+#define RTL88E_MAX_H2C_BOX_NUMS		4
+#define RTL88E_MAX_CMD_LEN		7
+#define RTL88E_MESSAGE_BOX_SIZE		4
+#define RTL88E_EX_MESSAGE_BOX_SIZE	4
+
+static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
+{
+	u8 read_down = false;
+	int	retry_cnts = 100;
+
+	u8 valid;
+
+	do {
+		valid = rtw_read8(adapt, REG_HMETFR) & BIT(msgbox_num);
+		if (0 == valid)
+			read_down = true;
+	} while ((!read_down) && (retry_cnts--));
+
+	return read_down;
+}
+
+/*****************************************
+* H2C Msg format :
+* 0x1DF - 0x1D0
+*| 31 - 8	| 7-5	 4 - 0	|
+*| h2c_msg	|Class_ID CMD_ID	|
+*
+* Extend 0x1FF - 0x1F0
+*|31 - 0	  |
+*|ext_msg|
+******************************************/
+static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *pCmdBuffer)
+{
+	u8 bcmd_down = false;
+	s32 retry_cnts = 100;
+	u8 h2c_box_num;
+	u32 msgbox_addr;
+	u32 msgbox_ex_addr;
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	u8 cmd_idx, ext_cmd_len;
+	u32 h2c_cmd = 0;
+	u32 h2c_cmd_ex = 0;
+	s32 ret = _FAIL;
+
+	if (!adapt->bFWReady) {
+		DBG_88E("FillH2CCmd_88E(): return H2C cmd because fw is not ready\n");
+		return ret;
+	}
+
+	if (!pCmdBuffer)
+		goto exit;
+	if (CmdLen > RTL88E_MAX_CMD_LEN)
+		goto exit;
+	if (adapt->bSurpriseRemoved)
+		goto exit;
+
+	/* pay attention to if  race condition happened in  H2C cmd setting. */
+	do {
+		h2c_box_num = haldata->LastHMEBoxNum;
+
+		if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
+			DBG_88E(" fw read cmd failed...\n");
+			goto exit;
+		}
+
+		*(u8 *)(&h2c_cmd) = ElementID;
+
+		if (CmdLen <= 3) {
+			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, CmdLen);
+		} else {
+			memcpy((u8 *)(&h2c_cmd)+1, pCmdBuffer, 3);
+			ext_cmd_len = CmdLen-3;
+			memcpy((u8 *)(&h2c_cmd_ex), pCmdBuffer+3, ext_cmd_len);
+
+			/* Write Ext command */
+			msgbox_ex_addr = REG_HMEBOX_EXT_0 + (h2c_box_num * RTL88E_EX_MESSAGE_BOX_SIZE);
+			for (cmd_idx = 0; cmd_idx < ext_cmd_len; cmd_idx++) {
+				rtw_write8(adapt, msgbox_ex_addr+cmd_idx, *((u8 *)(&h2c_cmd_ex)+cmd_idx));
+			}
+		}
+		/*  Write command */
+		msgbox_addr = REG_HMEBOX_0 + (h2c_box_num * RTL88E_MESSAGE_BOX_SIZE);
+		for (cmd_idx = 0; cmd_idx < RTL88E_MESSAGE_BOX_SIZE; cmd_idx++) {
+			rtw_write8(adapt, msgbox_addr+cmd_idx, *((u8 *)(&h2c_cmd)+cmd_idx));
+		}
+		bcmd_down = true;
+
+		haldata->LastHMEBoxNum = (h2c_box_num+1) % RTL88E_MAX_H2C_BOX_NUMS;
+
+	} while ((!bcmd_down) && (retry_cnts--));
+
+	ret = _SUCCESS;
+
+exit:
+
+	return ret;
+}
+
+u8 rtl8188e_set_rssi_cmd(struct adapter *adapt, u8 *param)
+{
+	u8 res = _SUCCESS;
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+
+	if (haldata->fw_ractrl) {
+		;
+	} else {
+		DBG_88E("==>%s fw dont support RA\n", __func__);
+		res = _FAIL;
+	}
+
+	return res;
+}
+
+u8 rtl8188e_set_raid_cmd(struct adapter *adapt, u32 mask)
+{
+	u8 buf[3];
+	u8 res = _SUCCESS;
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+
+	if (haldata->fw_ractrl) {
+		__le32 lmask;
+
+		memset(buf, 0, 3);
+		lmask = cpu_to_le32(mask);
+		memcpy(buf, &lmask, 3);
+
+		FillH2CCmd_88E(adapt, H2C_DM_MACID_CFG, 3, buf);
+	} else {
+		DBG_88E("==>%s fw dont support RA\n", __func__);
+		res = _FAIL;
+	}
+
+	return res;
+}
+
+/* bitmap[0:27] = tx_rate_bitmap */
+/* bitmap[28:31]= Rate Adaptive id */
+/* arg[0:4] = macid */
+/* arg[5] = Short GI */
+void rtl8188e_Add_RateATid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi_level)
+{
+	struct hal_data_8188e *haldata = GET_HAL_DATA(pAdapter);
+
+	u8 macid, init_rate, raid, shortGIrate = false;
+
+	macid = arg&0x1f;
+
+	raid = (bitmap>>28) & 0x0f;
+	bitmap &= 0x0fffffff;
+
+	if (rssi_level != DM_RATR_STA_INIT)
+		bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, macid, bitmap, rssi_level);
+
+	bitmap |= ((raid<<28)&0xf0000000);
+
+	init_rate = get_highest_rate_idx(bitmap&0x0fffffff)&0x3f;
+
+	shortGIrate = (arg&BIT(5)) ? true : false;
+
+	if (shortGIrate)
+		init_rate |= BIT(6);
+
+	raid = (bitmap>>28) & 0x0f;
+
+	bitmap &= 0x0fffffff;
+
+	DBG_88E("%s=> mac_id:%d, raid:%d, ra_bitmap=0x%x, shortGIrate=0x%02x\n",
+		__func__, macid, raid, bitmap, shortGIrate);
+
+	ODM_RA_UpdateRateInfo_8188E(&(haldata->odmpriv), macid, raid, bitmap, shortGIrate);
+}
+
+void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
+{
+	struct setpwrmode_parm H2CSetPwrMode;
+	struct pwrctrl_priv *pwrpriv = &adapt->pwrctrlpriv;
+	u8 RLBM = 0; /*  0:Min, 1:Max, 2:User define */
+
+	DBG_88E("%s: Mode=%d SmartPS=%d UAPSD=%d\n", __func__,
+		Mode, pwrpriv->smart_ps, adapt->registrypriv.uapsd_enable);
+
+	switch (Mode) {
+	case PS_MODE_ACTIVE:
+		H2CSetPwrMode.Mode = 0;
+		break;
+	case PS_MODE_MIN:
+		H2CSetPwrMode.Mode = 1;
+		break;
+	case PS_MODE_MAX:
+		RLBM = 1;
+		H2CSetPwrMode.Mode = 1;
+		break;
+	case PS_MODE_DTIM:
+		RLBM = 2;
+		H2CSetPwrMode.Mode = 1;
+		break;
+	case PS_MODE_UAPSD_WMM:
+		H2CSetPwrMode.Mode = 2;
+		break;
+	default:
+		H2CSetPwrMode.Mode = 0;
+		break;
+	}
+
+	H2CSetPwrMode.SmartPS_RLBM = (((pwrpriv->smart_ps<<4)&0xf0) | (RLBM & 0x0f));
+
+	H2CSetPwrMode.AwakeInterval = 1;
+
+	H2CSetPwrMode.bAllQueueUAPSD = adapt->registrypriv.uapsd_enable;
+
+	if (Mode > 0)
+		H2CSetPwrMode.PwrState = 0x00;/*  AllON(0x0C), RFON(0x04), RFOFF(0x00) */
+	else
+		H2CSetPwrMode.PwrState = 0x0C;/*  AllON(0x0C), RFON(0x04), RFOFF(0x00) */
+
+	FillH2CCmd_88E(adapt, H2C_PS_PWR_MODE, sizeof(H2CSetPwrMode), (u8 *)&H2CSetPwrMode);
+
+}
+
+void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
+{
+	u8 opmode, macid;
+	u16 mst_rpt = le16_to_cpu(mstatus_rpt);
+	opmode = (u8) mst_rpt;
+	macid = (u8)(mst_rpt >> 8);
+
+	DBG_88E("### %s: MStatus=%x MACID=%d\n", __func__, opmode, macid);
+	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
+}
+
+static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
+{
+	struct rtw_ieee80211_hdr	*pwlanhdr;
+	__le16 *fctrl;
+	u32 rate_len, pktlen;
+	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex		*cur_network = &(pmlmeinfo->network);
+	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+
+	fctrl = &(pwlanhdr->frame_ctl);
+	*(fctrl) = 0;
+
+	memcpy(pwlanhdr->addr1, bc_addr, ETH_ALEN);
+	memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+	memcpy(pwlanhdr->addr3, get_my_bssid(cur_network), ETH_ALEN);
+
+	SetSeqNum(pwlanhdr, 0/*pmlmeext->mgnt_seq*/);
+	SetFrameSubType(pframe, WIFI_BEACON);
+
+	pframe += sizeof(struct rtw_ieee80211_hdr_3addr);
+	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+
+	/* timestamp will be inserted by hardware */
+	pframe += 8;
+	pktlen += 8;
+
+	/*  beacon interval: 2 bytes */
+	memcpy(pframe, (unsigned char *)(rtw_get_beacon_interval_from_ie(cur_network->IEs)), 2);
+
+	pframe += 2;
+	pktlen += 2;
+
+	/*  capability info: 2 bytes */
+	memcpy(pframe, (unsigned char *)(rtw_get_capability_from_ie(cur_network->IEs)), 2);
+
+	pframe += 2;
+	pktlen += 2;
+
+	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+		pktlen += cur_network->IELength - sizeof(struct ndis_802_11_fixed_ie);
+		memcpy(pframe, cur_network->IEs+sizeof(struct ndis_802_11_fixed_ie), pktlen);
+
+		goto _ConstructBeacon;
+	}
+
+	/* below for ad-hoc mode */
+
+	/*  SSID */
+	pframe = rtw_set_ie(pframe, _SSID_IE_, cur_network->Ssid.SsidLength, cur_network->Ssid.Ssid, &pktlen);
+
+	/*  supported rates... */
+	rate_len = rtw_get_rateset_len(cur_network->SupportedRates);
+	pframe = rtw_set_ie(pframe, _SUPPORTEDRATES_IE_, ((rate_len > 8) ? 8 : rate_len), cur_network->SupportedRates, &pktlen);
+
+	/*  DS parameter set */
+	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
+
+	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+		u32 ATIMWindow;
+		/*  IBSS Parameter Set... */
+		ATIMWindow = 0;
+		pframe = rtw_set_ie(pframe, _IBSS_PARA_IE_, 2, (unsigned char *)(&ATIMWindow), &pktlen);
+	}
+
+	/* todo: ERP IE */
+
+	/*  EXTERNDED SUPPORTED RATE */
+	if (rate_len > 8)
+		pframe = rtw_set_ie(pframe, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8), (cur_network->SupportedRates + 8), &pktlen);
+
+	/* todo:HT for adhoc */
+
+_ConstructBeacon:
+
+	if ((pktlen + TXDESC_SIZE) > 512) {
+		DBG_88E("beacon frame too large\n");
+		return;
+	}
+
+	*pLength = pktlen;
+}
+
+static void ConstructPSPoll(struct adapter *adapt, u8 *pframe, u32 *pLength)
+{
+	struct rtw_ieee80211_hdr	*pwlanhdr;
+	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	__le16 *fctrl;
+
+	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+
+	/*  Frame control. */
+	fctrl = &(pwlanhdr->frame_ctl);
+	*(fctrl) = 0;
+	SetPwrMgt(fctrl);
+	SetFrameSubType(pframe, WIFI_PSPOLL);
+
+	/*  AID. */
+	SetDuration(pframe, (pmlmeinfo->aid | 0xc000));
+
+	/*  BSSID. */
+	memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+
+	/*  TA. */
+	memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+
+	*pLength = 16;
+}
+
+static void ConstructNullFunctionData(struct adapter *adapt, u8 *pframe,
+	u32 *pLength,
+	u8 *StaAddr,
+	u8 bQoS,
+	u8 AC,
+	u8 bEosp,
+	u8 bForcePowerSave)
+{
+	struct rtw_ieee80211_hdr	*pwlanhdr;
+	__le16 *fctrl;
+	u32 pktlen;
+	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
+	struct wlan_network		*cur_network = &pmlmepriv->cur_network;
+	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+
+	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+
+	fctrl = &pwlanhdr->frame_ctl;
+	*(fctrl) = 0;
+	if (bForcePowerSave)
+		SetPwrMgt(fctrl);
+
+	switch (cur_network->network.InfrastructureMode) {
+	case Ndis802_11Infrastructure:
+		SetToDs(fctrl);
+		memcpy(pwlanhdr->addr1, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+		memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+		memcpy(pwlanhdr->addr3, StaAddr, ETH_ALEN);
+		break;
+	case Ndis802_11APMode:
+		SetFrDs(fctrl);
+		memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
+		memcpy(pwlanhdr->addr2, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+		memcpy(pwlanhdr->addr3, myid(&(adapt->eeprompriv)), ETH_ALEN);
+		break;
+	case Ndis802_11IBSS:
+	default:
+		memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
+		memcpy(pwlanhdr->addr2, myid(&(adapt->eeprompriv)), ETH_ALEN);
+		memcpy(pwlanhdr->addr3, get_my_bssid(&(pmlmeinfo->network)), ETH_ALEN);
+		break;
+	}
+
+	SetSeqNum(pwlanhdr, 0);
+
+	if (bQoS) {
+		struct rtw_ieee80211_hdr_3addr_qos *pwlanqoshdr;
+
+		SetFrameSubType(pframe, WIFI_QOS_DATA_NULL);
+
+		pwlanqoshdr = (struct rtw_ieee80211_hdr_3addr_qos *)pframe;
+		SetPriority(&pwlanqoshdr->qc, AC);
+		SetEOSP(&pwlanqoshdr->qc, bEosp);
+
+		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr_qos);
+	} else {
+		SetFrameSubType(pframe, WIFI_DATA_NULL);
+
+		pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	}
+
+	*pLength = pktlen;
+}
+
+static void ConstructProbeRsp(struct adapter *adapt, u8 *pframe, u32 *pLength, u8 *StaAddr, bool bHideSSID)
+{
+	struct rtw_ieee80211_hdr	*pwlanhdr;
+	__le16 *fctrl;
+	u8 *mac, *bssid;
+	u32 pktlen;
+	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+
+	pwlanhdr = (struct rtw_ieee80211_hdr *)pframe;
+
+	mac = myid(&(adapt->eeprompriv));
+	bssid = cur_network->MacAddress;
+
+	fctrl = &(pwlanhdr->frame_ctl);
+	*(fctrl) = 0;
+	memcpy(pwlanhdr->addr1, StaAddr, ETH_ALEN);
+	memcpy(pwlanhdr->addr2, mac, ETH_ALEN);
+	memcpy(pwlanhdr->addr3, bssid, ETH_ALEN);
+
+	SetSeqNum(pwlanhdr, 0);
+	SetFrameSubType(fctrl, WIFI_PROBERSP);
+
+	pktlen = sizeof(struct rtw_ieee80211_hdr_3addr);
+	pframe += pktlen;
+
+	if (cur_network->IELength > MAX_IE_SZ)
+		return;
+
+	memcpy(pframe, cur_network->IEs, cur_network->IELength);
+	pframe += cur_network->IELength;
+	pktlen += cur_network->IELength;
+
+	*pLength = pktlen;
+}
+
+/*  To check if reserved page content is destroyed by beacon because beacon is too large. */
+/*  2010.06.23. Added by tynli. */
+void CheckFwRsvdPageContent(struct adapter *Adapter)
+{
+}
+
+/*  */
+/*  Description: Fill the reserved packets that FW will use to RSVD page. */
+/*			Now we just send 4 types packet to rsvd page. */
+/*			(1)Beacon, (2)Ps-poll, (3)Null data, (4)ProbeRsp. */
+/*	Input: */
+/*	    bDLFinished - false: At the first time we will send all the packets as a large packet to Hw, */
+/*						so we need to set the packet length to total length. */
+/*			      true: At the second time, we should send the first packet (default:beacon) */
+/*						to Hw again and set the length in descriptor to the real beacon length. */
+/*  2009.10.15 by tynli. */
+static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
+{
+	struct hal_data_8188e *haldata;
+	struct xmit_frame	*pmgntframe;
+	struct pkt_attrib	*pattrib;
+	struct xmit_priv *pxmitpriv;
+	struct mlme_ext_priv *pmlmeext;
+	struct mlme_ext_info	*pmlmeinfo;
+	u32 BeaconLength = 0, ProbeRspLength = 0, PSPollLength;
+	u32 NullDataLength, QosNullLength;
+	u8 *ReservedPagePacket;
+	u8 PageNum, PageNeed, TxDescLen;
+	u16 BufIndex;
+	u32 TotalPacketLen;
+	struct rsvdpage_loc RsvdPageLoc;
+
+	DBG_88E("%s\n", __func__);
+	ReservedPagePacket = (u8 *)rtw_zmalloc(1000);
+	if (ReservedPagePacket == NULL) {
+		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
+		return;
+	}
+
+	haldata = GET_HAL_DATA(adapt);
+	pxmitpriv = &adapt->xmitpriv;
+	pmlmeext = &adapt->mlmeextpriv;
+	pmlmeinfo = &pmlmeext->mlmext_info;
+
+	TxDescLen = TXDESC_SIZE;
+	PageNum = 0;
+
+	/* 3 (1) beacon * 2 pages */
+	BufIndex = TXDESC_OFFSET;
+	ConstructBeacon(adapt, &ReservedPagePacket[BufIndex], &BeaconLength);
+
+	/*  When we count the first page size, we need to reserve description size for the RSVD */
+	/*  packet, it will be filled in front of the packet in TXPKTBUF. */
+	PageNeed = (u8)PageNum_128(TxDescLen + BeaconLength);
+	/*  To reserved 2 pages for beacon buffer. 2010.06.24. */
+	if (PageNeed == 1)
+		PageNeed += 1;
+	PageNum += PageNeed;
+	haldata->FwRsvdPageStartOffset = PageNum;
+
+	BufIndex += PageNeed*128;
+
+	/* 3 (2) ps-poll *1 page */
+	RsvdPageLoc.LocPsPoll = PageNum;
+	ConstructPSPoll(adapt, &ReservedPagePacket[BufIndex], &PSPollLength);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], PSPollLength, true, false);
+
+	PageNeed = (u8)PageNum_128(TxDescLen + PSPollLength);
+	PageNum += PageNeed;
+
+	BufIndex += PageNeed*128;
+
+	/* 3 (3) null data * 1 page */
+	RsvdPageLoc.LocNullData = PageNum;
+	ConstructNullFunctionData(adapt, &ReservedPagePacket[BufIndex], &NullDataLength, get_my_bssid(&pmlmeinfo->network), false, 0, 0, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], NullDataLength, false, false);
+
+	PageNeed = (u8)PageNum_128(TxDescLen + NullDataLength);
+	PageNum += PageNeed;
+
+	BufIndex += PageNeed*128;
+
+	/* 3 (4) probe response * 1page */
+	RsvdPageLoc.LocProbeRsp = PageNum;
+	ConstructProbeRsp(adapt, &ReservedPagePacket[BufIndex], &ProbeRspLength, get_my_bssid(&pmlmeinfo->network), false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], ProbeRspLength, false, false);
+
+	PageNeed = (u8)PageNum_128(TxDescLen + ProbeRspLength);
+	PageNum += PageNeed;
+
+	BufIndex += PageNeed*128;
+
+	/* 3 (5) Qos null data */
+	RsvdPageLoc.LocQosNull = PageNum;
+	ConstructNullFunctionData(adapt, &ReservedPagePacket[BufIndex],
+				  &QosNullLength, get_my_bssid(&pmlmeinfo->network), true, 0, 0, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], QosNullLength, false, false);
+
+	PageNeed = (u8)PageNum_128(TxDescLen + QosNullLength);
+	PageNum += PageNeed;
+
+	TotalPacketLen = BufIndex + QosNullLength;
+	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
+	if (pmgntframe == NULL)
+		goto exit;
+
+	/*  update attribute */
+	pattrib = &pmgntframe->attrib;
+	update_mgntframe_attrib(adapt, pattrib);
+	pattrib->qsel = 0x10;
+	pattrib->last_txcmdsz = TotalPacketLen - TXDESC_OFFSET;
+	pattrib->pktlen = pattrib->last_txcmdsz;
+	memcpy(pmgntframe->buf_addr, ReservedPagePacket, TotalPacketLen);
+
+	rtw_hal_mgnt_xmit(adapt, pmgntframe);
+
+	DBG_88E("%s: Set RSVD page location to Fw\n", __func__);
+	FillH2CCmd_88E(adapt, H2C_COM_RSVD_PAGE, sizeof(RsvdPageLoc), (u8 *)&RsvdPageLoc);
+
+exit:
+	kfree(ReservedPagePacket);
+}
+
+void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
+{
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct mlme_ext_priv *pmlmeext = &(adapt->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	bool	bSendBeacon = false;
+	bool	bcn_valid = false;
+	u8 DLBcnCount = 0;
+	u32 poll = 0;
+
+	DBG_88E("%s mstatus(%x)\n", __func__, mstatus);
+
+	if (mstatus == 1) {
+		/*  We should set AID, correct TSF, HW seq enable before set JoinBssReport to Fw in 88/92C. */
+		/*  Suggested by filen. Added by tynli. */
+		rtw_write16(adapt, REG_BCN_PSR_RPT, (0xC000|pmlmeinfo->aid));
+		/*  Do not set TSF again here or vWiFi beacon DMA INT will not work. */
+
+		/* Set REG_CR bit 8. DMA beacon by SW. */
+		haldata->RegCR_1 |= BIT0;
+		rtw_write8(adapt,  REG_CR+1, haldata->RegCR_1);
+
+		/*  Disable Hw protection for a time which revserd for Hw sending beacon. */
+		/*  Fix download reserved page packet fail that access collision with the protection time. */
+		/*  2010.05.11. Added by tynli. */
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)&(~BIT(3)));
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)|BIT(4));
+
+		if (haldata->RegFwHwTxQCtrl&BIT6) {
+			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
+			bSendBeacon = true;
+		}
+
+		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
+		rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl&(~BIT6)));
+		haldata->RegFwHwTxQCtrl &= (~BIT6);
+
+		/*  Clear beacon valid check bit. */
+		rtw_hal_set_hwreg(adapt, HW_VAR_BCN_VALID, NULL);
+		DLBcnCount = 0;
+		poll = 0;
+		do {
+			/*  download rsvd page. */
+			SetFwRsvdPagePkt(adapt, false);
+			DLBcnCount++;
+			do {
+				rtw_yield_os();
+				/* rtw_mdelay_os(10); */
+				/*  check rsvd page download OK. */
+				rtw_hal_get_hwreg(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
+				poll++;
+			} while (!bcn_valid && (poll%10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
+		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
+
+		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
+			;
+		else if (!bcn_valid)
+			DBG_88E("%s: 1 Download RSVD page failed! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
+		else
+			DBG_88E("%s: 1 Download RSVD success! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
+		/*  */
+		/*  We just can send the reserved page twice during the time that Tx thread is stopped (e.g. pnpsetpower) */
+		/*  because we need to free the Tx BCN Desc which is used by the first reserved page packet. */
+		/*  At run time, we cannot get the Tx Desc until it is released in TxHandleInterrupt() so we will return */
+		/*  the beacon TCB in the following code. 2011.11.23. by tynli. */
+		/*  */
+
+		/*  Enable Bcn */
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)|BIT(3));
+		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL)&(~BIT(4)));
+
+		/*  To make sure that if there exists an adapter which would like to send beacon. */
+		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
+		/*  prevent from setting 0x422[6] to 0 after download reserved page, or it will cause */
+		/*  the beacon cannot be sent by HW. */
+		/*  2010.06.23. Added by tynli. */
+		if (bSendBeacon) {
+			rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl|BIT6));
+			haldata->RegFwHwTxQCtrl |= BIT6;
+		}
+
+		/*  Update RSVD page location H2C to Fw. */
+		if (bcn_valid) {
+			rtw_hal_set_hwreg(adapt, HW_VAR_BCN_VALID, NULL);
+			DBG_88E("Set RSVD page location to Fw.\n");
+		}
+
+		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
+		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
+		haldata->RegCR_1 &= (~BIT0);
+		rtw_write8(adapt,  REG_CR+1, haldata->RegCR_1);
+	}
+
+}
+
+void rtl8188e_set_p2p_ps_offload_cmd(struct adapter *adapt, u8 p2p_ps_state)
+{
+#ifdef CONFIG_88EU_P2P
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+	struct wifidirect_info	*pwdinfo = &(adapt->wdinfo);
+	struct P2P_PS_Offload_t	*p2p_ps_offload = &haldata->p2p_ps_offload;
+	u8 i;
+
+	switch (p2p_ps_state) {
+	case P2P_PS_DISABLE:
+		DBG_88E("P2P_PS_DISABLE\n");
+		memset(p2p_ps_offload, 0, 1);
+		break;
+	case P2P_PS_ENABLE:
+		DBG_88E("P2P_PS_ENABLE\n");
+		/*  update CTWindow value. */
+		if (pwdinfo->ctwindow > 0) {
+			p2p_ps_offload->CTWindow_En = 1;
+			rtw_write8(adapt, REG_P2P_CTWIN, pwdinfo->ctwindow);
+		}
+
+		/*  hw only support 2 set of NoA */
+		for (i = 0; i < pwdinfo->noa_num; i++) {
+			/*  To control the register setting for which NOA */
+			rtw_write8(adapt, REG_NOA_DESC_SEL, (i << 4));
+			if (i == 0)
+				p2p_ps_offload->NoA0_En = 1;
+			else
+				p2p_ps_offload->NoA1_En = 1;
+
+			/*  config P2P NoA Descriptor Register */
+			rtw_write32(adapt, REG_NOA_DESC_DURATION, pwdinfo->noa_duration[i]);
+			rtw_write32(adapt, REG_NOA_DESC_INTERVAL, pwdinfo->noa_interval[i]);
+			rtw_write32(adapt, REG_NOA_DESC_START, pwdinfo->noa_start_time[i]);
+			rtw_write8(adapt, REG_NOA_DESC_COUNT, pwdinfo->noa_count[i]);
+		}
+
+		if ((pwdinfo->opp_ps == 1) || (pwdinfo->noa_num > 0)) {
+			/*  rst p2p circuit */
+			rtw_write8(adapt, REG_DUAL_TSF_RST, BIT(4));
+
+			p2p_ps_offload->Offload_En = 1;
+
+			if (pwdinfo->role == P2P_ROLE_GO) {
+				p2p_ps_offload->role = 1;
+				p2p_ps_offload->AllStaSleep = 0;
+			} else {
+				p2p_ps_offload->role = 0;
+			}
+
+			p2p_ps_offload->discovery = 0;
+		}
+		break;
+	case P2P_PS_SCAN:
+		DBG_88E("P2P_PS_SCAN\n");
+		p2p_ps_offload->discovery = 1;
+		break;
+	case P2P_PS_SCAN_DONE:
+		DBG_88E("P2P_PS_SCAN_DONE\n");
+		p2p_ps_offload->discovery = 0;
+		pwdinfo->p2p_ps_state = P2P_PS_ENABLE;
+		break;
+	default:
+		break;
+	}
+
+	FillH2CCmd_88E(adapt, H2C_PS_P2P_OFFLOAD, 1, (u8 *)p2p_ps_offload);
+#endif
+
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
new file mode 100644
index 000000000000..2590277b95ba
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -0,0 +1,267 @@
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
+/*  Description: */
+/*  */
+/*  This file is for 92CE/92CU dynamic mechanism only */
+/*  */
+/*  */
+/*  */
+#define _RTL8188E_DM_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#include <rtl8188e_hal.h>
+
+static void dm_CheckStatistics(struct adapter *Adapter)
+{
+}
+
+/*  Initialize GPIO setting registers */
+static void dm_InitGPIOSetting(struct adapter *Adapter)
+{
+	u8	tmp1byte;
+
+	tmp1byte = rtw_read8(Adapter, REG_GPIO_MUXCFG);
+	tmp1byte &= (GPIOSEL_GPIO | ~GPIOSEL_ENBT);
+
+	rtw_write8(Adapter, REG_GPIO_MUXCFG, tmp1byte);
+}
+
+/*  */
+/*  functions */
+/*  */
+static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
+{
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	u8 cut_ver, fab_ver;
+
+	/*  Init Value */
+	memset(dm_odm, 0, sizeof(*dm_odm));
+
+	dm_odm->Adapter = Adapter;
+
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PLATFORM, ODM_CE);
+
+	if (Adapter->interface_type == RTW_GSPI)
+		ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, ODM_ITRF_SDIO);
+	else
+		ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_INTERFACE, Adapter->interface_type);/* RTL871X_HCI_TYPE */
+
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_IC_TYPE, ODM_RTL8188E);
+
+	fab_ver = ODM_TSMC;
+	cut_ver = ODM_CUT_A;
+
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_FAB_VER, fab_ver);
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_CUT_VER, cut_ver);
+
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_MP_TEST_CHIP, IS_NORMAL_CHIP(hal_data->VersionID));
+
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_PATCH_ID, hal_data->CustomerID);
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_BWIFI_TEST, Adapter->registrypriv.wifi_spec);
+
+	if (hal_data->rf_type == RF_1T1R)
+		ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_RF_TYPE, ODM_1T1R);
+	else if (hal_data->rf_type == RF_2T2R)
+		ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_RF_TYPE, ODM_2T2R);
+	else if (hal_data->rf_type == RF_1T2R)
+		ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_RF_TYPE, ODM_1T2R);
+
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
+
+	pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION |
+				ODM_RF_TX_PWR_TRACK;
+
+	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
+}
+
+static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
+{
+	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
+	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
+	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	int i;
+
+	pdmpriv->InitODMFlag =	ODM_BB_DIG |
+				ODM_BB_RA_MASK |
+				ODM_BB_DYNAMIC_TXPWR |
+				ODM_BB_FA_CNT |
+				ODM_BB_RSSI_MONITOR |
+				ODM_BB_CCK_PD |
+				ODM_BB_PWR_SAVE |
+				ODM_MAC_EDCA_TURBO |
+				ODM_RF_CALIBRATION |
+				ODM_RF_TX_PWR_TRACK;
+	if (hal_data->AntDivCfg)
+		pdmpriv->InitODMFlag |= ODM_BB_ANT_DIV;
+
+	if (Adapter->registrypriv.mp_mode == 1) {
+		pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION |
+					ODM_RF_TX_PWR_TRACK;
+	}
+
+	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
+
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_TX_UNI, &(Adapter->xmitpriv.tx_bytes));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_RX_UNI, &(Adapter->recvpriv.rx_bytes));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &(pmlmeext->cur_wireless_mode));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &(hal_data->nCur40MhzPrimeSC));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_MODE, &(Adapter->securitypriv.dot11PrivacyAlgrthm));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &(hal_data->CurrentChannelBW));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &(hal_data->CurrentChannel));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_NET_CLOSED, &(Adapter->net_closed));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_MP_MODE, &(Adapter->registrypriv.mp_mode));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &(pmlmepriv->bScanInProcess));
+	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_POWER_SAVING, &(pwrctrlpriv->bpower_saving));
+	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
+
+	for (i = 0; i < NUM_STA; i++)
+		ODM_CmnInfoPtrArrayHook(dm_odm, ODM_CMNINFO_STA_STATUS, i, NULL);
+}
+
+void rtl8188e_InitHalDm(struct adapter *Adapter)
+{
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	struct odm_dm_struct *dm_odm = &(hal_data->odmpriv);
+
+	dm_InitGPIOSetting(Adapter);
+	pdmpriv->DM_Type = DM_Type_ByDriver;
+	pdmpriv->DMFlag = DYNAMIC_FUNC_DISABLE;
+	Update_ODM_ComInfo_88E(Adapter);
+	ODM_DMInit(dm_odm);
+	Adapter->fix_rate = 0xFF;
+}
+
+void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
+{
+	bool fw_cur_in_ps = false;
+	bool fw_ps_awake = true;
+	u8 hw_init_completed = false;
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+
+
+	hw_init_completed = Adapter->hw_init_completed;
+
+	if (!hw_init_completed)
+		goto skip_dm;
+
+	fw_cur_in_ps = Adapter->pwrctrlpriv.bFwCurrentInPSMode;
+	rtw_hal_get_hwreg(Adapter, HW_VAR_FWLPS_RF_ON, (u8 *)(&fw_ps_awake));
+
+	/*  Fw is under p2p powersaving mode, driver should stop dynamic mechanism. */
+	/*  modifed by thomas. 2011.06.11. */
+	if (Adapter->wdinfo.p2p_ps_mode)
+		fw_ps_awake = false;
+
+	if (hw_init_completed && ((!fw_cur_in_ps) && fw_ps_awake)) {
+		/*  Calculate Tx/Rx statistics. */
+		dm_CheckStatistics(Adapter);
+
+
+	}
+
+	/* ODM */
+	if (hw_init_completed) {
+		struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
+		u8 bLinked = false;
+
+		if ((check_fwstate(pmlmepriv, WIFI_AP_STATE)) ||
+		    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))) {
+			if (Adapter->stapriv.asoc_sta_count > 2)
+				bLinked = true;
+		} else {/* Station mode */
+			if (check_fwstate(pmlmepriv, _FW_LINKED))
+				bLinked = true;
+		}
+
+		ODM_CmnInfoUpdate(&hal_data->odmpriv, ODM_CMNINFO_LINK, bLinked);
+		ODM_DMWatchdog(&hal_data->odmpriv);
+	}
+skip_dm:
+	/*  Check GPIO to determine current RF on/off and Pbc status. */
+	/*  Check Hardware Radio ON/OFF or not */
+	return;
+}
+
+void rtl8188e_init_dm_priv(struct adapter *Adapter)
+{
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	struct odm_dm_struct *podmpriv = &hal_data->odmpriv;
+
+	memset(pdmpriv, 0, sizeof(struct dm_priv));
+	Init_ODM_ComInfo_88E(Adapter);
+	ODM_InitDebugSetting(podmpriv);
+}
+
+void rtl8188e_deinit_dm_priv(struct adapter *Adapter)
+{
+}
+
+/*  Add new function to reset the state of antenna diversity before link. */
+/*  Compare RSSI for deciding antenna */
+void AntDivCompare8188E(struct adapter *Adapter, struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src)
+{
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+
+	if (0 != hal_data->AntDivCfg) {
+		/* select optimum_antenna for before linked =>For antenna diversity */
+		if (dst->Rssi >=  src->Rssi) {/* keep org parameter */
+			src->Rssi = dst->Rssi;
+			src->PhyInfo.Optimum_antenna = dst->PhyInfo.Optimum_antenna;
+		}
+	}
+}
+
+/*  Add new function to reset the state of antenna diversity before link. */
+u8 AntDivBeforeLink8188E(struct adapter *Adapter)
+{
+	struct hal_data_8188e *hal_data = GET_HAL_DATA(Adapter);
+	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
+	struct sw_ant_switch *dm_swat_tbl = &dm_odm->DM_SWAT_Table;
+	struct mlme_priv *pmlmepriv = &(Adapter->mlmepriv);
+
+	/*  Condition that does not need to use antenna diversity. */
+	if (hal_data->AntDivCfg == 0)
+		return false;
+
+	if (check_fwstate(pmlmepriv, _FW_LINKED))
+		return false;
+
+	if (dm_swat_tbl->SWAS_NoLink_State == 0) {
+		/* switch channel */
+		dm_swat_tbl->SWAS_NoLink_State = 1;
+		dm_swat_tbl->CurAntenna = (dm_swat_tbl->CurAntenna == Antenna_A) ? Antenna_B : Antenna_A;
+
+		rtw_antenna_select_cmd(Adapter, dm_swat_tbl->CurAntenna, false);
+		return true;
+	} else {
+		dm_swat_tbl->SWAS_NoLink_State = 0;
+		return false;
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
new file mode 100644
index 000000000000..d9f115d187c9
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -0,0 +1,2390 @@
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
+#define _HAL_INIT_C_
+
+#include <linux/firmware.h>
+#include <drv_types.h>
+#include <rtw_efuse.h>
+
+#include <rtl8188e_hal.h>
+
+#include <rtw_iol.h>
+
+#include <usb_ops.h>
+
+static void iol_mode_enable(struct adapter *padapter, u8 enable)
+{
+	u8 reg_0xf0 = 0;
+
+	if (enable) {
+		/* Enable initial offload */
+		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
+		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0|SW_OFFLOAD_EN);
+
+		if (!padapter->bFWReady) {
+			DBG_88E("bFWReady == false call reset 8051...\n");
+			_8051Reset88E(padapter);
+		}
+
+	} else {
+		/* disable initial offload */
+		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
+		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 & ~SW_OFFLOAD_EN);
+	}
+}
+
+static s32 iol_execute(struct adapter *padapter, u8 control)
+{
+	s32 status = _FAIL;
+	u8 reg_0x88 = 0;
+	u32 start = 0, passing_time = 0;
+
+	control = control&0x0f;
+	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
+	rtw_write8(padapter, REG_HMEBOX_E0,  reg_0x88|control);
+
+	start = jiffies;
+	while ((reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0)) & control &&
+	       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
+		;
+	}
+
+	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
+	status = (reg_0x88 & control) ? _FAIL : _SUCCESS;
+	if (reg_0x88 & control<<4)
+		status = _FAIL;
+	return status;
+}
+
+static s32 iol_InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
+{
+	s32 rst = _SUCCESS;
+	iol_mode_enable(padapter, 1);
+	rtw_write8(padapter, REG_TDECTRL+1, txpktbuf_bndy);
+	rst = iol_execute(padapter, CMD_INIT_LLT);
+	iol_mode_enable(padapter, 0);
+	return rst;
+}
+
+static void
+efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
+{
+	u8 *efuseTbl = NULL;
+	u8 rtemp8;
+	u16	eFuse_Addr = 0;
+	u8 offset, wren;
+	u16	i, j;
+	u16	**eFuseWord = NULL;
+	u16	efuse_utilized = 0;
+	u8 u1temp = 0;
+
+	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
+	if (efuseTbl == NULL) {
+		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
+		goto exit;
+	}
+
+	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+	if (eFuseWord == NULL) {
+		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+		goto exit;
+	}
+
+	/*  0. Refresh efuse init map as all oxFF. */
+	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
+		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++)
+			eFuseWord[i][j] = 0xFFFF;
+
+	/*  */
+	/*  1. Read the first byte to check if efuse is empty!!! */
+	/*  */
+	/*  */
+	rtemp8 = *(phymap+eFuse_Addr);
+	if (rtemp8 != 0xFF) {
+		efuse_utilized++;
+		eFuse_Addr++;
+	} else {
+		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
+		goto exit;
+	}
+
+	/*  */
+	/*  2. Read real efuse content. Filter PG header and every section data. */
+	/*  */
+	while ((rtemp8 != 0xFF) && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
+		/*  Check PG header for section num. */
+		if ((rtemp8 & 0x1F) == 0x0F) {		/* extended header */
+			u1temp = ((rtemp8 & 0xE0) >> 5);
+			rtemp8 = *(phymap+eFuse_Addr);
+			if ((rtemp8 & 0x0F) == 0x0F) {
+				eFuse_Addr++;
+				rtemp8 = *(phymap+eFuse_Addr);
+
+				if (rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E))
+					eFuse_Addr++;
+				continue;
+			} else {
+				offset = ((rtemp8 & 0xF0) >> 1) | u1temp;
+				wren = (rtemp8 & 0x0F);
+				eFuse_Addr++;
+			}
+		} else {
+			offset = ((rtemp8 >> 4) & 0x0f);
+			wren = (rtemp8 & 0x0f);
+		}
+
+		if (offset < EFUSE_MAX_SECTION_88E) {
+			/*  Get word enable value from PG header */
+			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
+				/*  Check word enable condition in the section */
+				if (!(wren & 0x01)) {
+					rtemp8 = *(phymap+eFuse_Addr);
+					eFuse_Addr++;
+					efuse_utilized++;
+					eFuseWord[offset][i] = (rtemp8 & 0xff);
+					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
+						break;
+					rtemp8 = *(phymap+eFuse_Addr);
+					eFuse_Addr++;
+					efuse_utilized++;
+					eFuseWord[offset][i] |= (((u16)rtemp8 << 8) & 0xff00);
+
+					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
+						break;
+				}
+				wren >>= 1;
+			}
+		}
+		/*  Read next PG header */
+		rtemp8 = *(phymap+eFuse_Addr);
+
+		if (rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
+			efuse_utilized++;
+			eFuse_Addr++;
+		}
+	}
+
+	/*  */
+	/*  3. Collect 16 sections and 4 word unit into Efuse map. */
+	/*  */
+	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++) {
+		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++) {
+			efuseTbl[(i*8)+(j*2)] = (eFuseWord[i][j] & 0xff);
+			efuseTbl[(i*8)+((j*2)+1)] = ((eFuseWord[i][j] >> 8) & 0xff);
+		}
+	}
+
+	/*  */
+	/*  4. Copy from Efuse map to output pointer memory!!! */
+	/*  */
+	for (i = 0; i < _size_byte; i++)
+		pbuf[i] = efuseTbl[_offset+i];
+
+	/*  */
+	/*  5. Calculate Efuse utilization. */
+	/*  */
+
+exit:
+	kfree(efuseTbl);
+
+	if (eFuseWord)
+		rtw_mfree2d((void *)eFuseWord, EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+}
+
+static void efuse_read_phymap_from_txpktbuf(
+	struct adapter  *adapter,
+	int bcnhead,	/* beacon head, where FW store len(2-byte) and efuse physical map. */
+	u8 *content,	/* buffer to store efuse physical map */
+	u16 *size	/* for efuse content: the max byte to read. will update to byte read */
+	)
+{
+	u16 dbg_addr = 0;
+	u32 start  = 0, passing_time = 0;
+	u8 reg_0x143 = 0;
+	__le32 lo32 = 0, hi32 = 0;
+	u16 len = 0, count = 0;
+	int i = 0;
+	u16 limit = *size;
+
+	u8 *pos = content;
+
+	if (bcnhead < 0) /* if not valid */
+		bcnhead = rtw_read8(adapter, REG_TDECTRL+1);
+
+	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
+
+	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
+
+	dbg_addr = bcnhead*128/8; /* 8-bytes addressing */
+
+	while (1) {
+		rtw_write16(adapter, REG_PKTBUF_DBG_ADDR, dbg_addr+i);
+
+		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
+		start = jiffies;
+		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
+		       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
+			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, rtw_read8(adapter, 0x106));
+			rtw_usleep_os(100);
+		}
+
+		/* data from EEPROM needs to be in LE */
+		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
+		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
+
+		if (i == 0) {
+			/* Although lenc is only used in a debug statement,
+			 * do not remove it as the rtw_read16() call consumes
+			 * 2 bytes from the EEPROM source.
+			 */
+			u16 lenc = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
+
+			len = le32_to_cpu(lo32) & 0x0000ffff;
+
+			limit = (len-2 < limit) ? len-2 : limit;
+
+			DBG_88E("%s len:%u, lenc:%u\n", __func__, len, lenc);
+
+			memcpy(pos, ((u8 *)&lo32)+2, (limit >= count+2) ? 2 : limit-count);
+			count += (limit >= count+2) ? 2 : limit-count;
+			pos = content+count;
+		} else {
+			memcpy(pos, ((u8 *)&lo32), (limit >= count+4) ? 4 : limit-count);
+			count += (limit >= count+4) ? 4 : limit-count;
+			pos = content+count;
+		}
+
+		if (limit > count && len-2 > count) {
+			memcpy(pos, (u8 *)&hi32, (limit >= count+4) ? 4 : limit-count);
+			count += (limit >= count+4) ? 4 : limit-count;
+			pos = content+count;
+		}
+
+		if (limit <= count || len-2 <= count)
+			break;
+		i++;
+	}
+	rtw_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, DISABLE_TRXPKT_BUF_ACCESS);
+	DBG_88E("%s read count:%u\n", __func__, count);
+	*size = count;
+}
+
+static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset, u16 size_byte, u8 *logical_map)
+{
+	s32 status = _FAIL;
+	u8 physical_map[512];
+	u16 size = 512;
+
+	rtw_write8(padapter, REG_TDECTRL+1, txpktbuf_bndy);
+	memset(physical_map, 0xFF, 512);
+	rtw_write8(padapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
+	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
+	if (status == _SUCCESS)
+		efuse_read_phymap_from_txpktbuf(padapter, txpktbuf_bndy, physical_map, &size);
+	efuse_phymap_to_logical(physical_map, offset, size_byte, logical_map);
+	return status;
+}
+
+s32 rtl8188e_iol_efuse_patch(struct adapter *padapter)
+{
+	s32	result = _SUCCESS;
+
+	DBG_88E("==> %s\n", __func__);
+	if (rtw_IOL_applied(padapter)) {
+		iol_mode_enable(padapter, 1);
+		result = iol_execute(padapter, CMD_READ_EFUSE_MAP);
+		if (result == _SUCCESS)
+			result = iol_execute(padapter, CMD_EFUSE_PATCH);
+
+		iol_mode_enable(padapter, 0);
+	}
+	return result;
+}
+
+static s32 iol_ioconfig(struct adapter *padapter, u8 iocfg_bndy)
+{
+	s32 rst = _SUCCESS;
+
+	rtw_write8(padapter, REG_TDECTRL+1, iocfg_bndy);
+	rst = iol_execute(padapter, CMD_IOCONFIG);
+	return rst;
+}
+
+static int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt)
+{
+	struct pkt_attrib *pattrib = &xmit_frame->attrib;
+	u8 i;
+	int ret = _FAIL;
+
+	if (rtw_IOL_append_END_cmd(xmit_frame) != _SUCCESS)
+		goto exit;
+	if (rtw_usb_bulk_size_boundary(adapter, TXDESC_SIZE+pattrib->last_txcmdsz)) {
+		if (rtw_IOL_append_END_cmd(xmit_frame) != _SUCCESS)
+			goto exit;
+	}
+
+	dump_mgntframe_and_wait(adapter, xmit_frame, max_wating_ms);
+
+	iol_mode_enable(adapter, 1);
+	for (i = 0; i < bndy_cnt; i++) {
+		u8 page_no = 0;
+		page_no = i*2;
+		ret = iol_ioconfig(adapter, page_no);
+		if (ret != _SUCCESS)
+			break;
+	}
+	iol_mode_enable(adapter, 0);
+exit:
+	/* restore BCN_HEAD */
+	rtw_write8(adapter, REG_TDECTRL+1, 0);
+	return ret;
+}
+
+void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
+{
+	u32 fifo_data, reg_140;
+	u32 addr, rstatus, loop = 0;
+	u16 data_cnts = (data_len/8)+1;
+	u8 *pbuf = rtw_zvmalloc(data_len+10);
+	DBG_88E("###### %s ######\n", __func__);
+
+	rtw_write8(Adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
+	if (pbuf) {
+		for (addr = 0; addr < data_cnts; addr++) {
+			rtw_write32(Adapter, 0x140, addr);
+			rtw_usleep_os(2);
+			loop = 0;
+			do {
+				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL)&BIT24);
+				if (rstatus) {
+					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L);
+					memcpy(pbuf+(addr*8), &fifo_data, 4);
+
+					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_H);
+					memcpy(pbuf+(addr*8+4), &fifo_data, 4);
+				}
+				rtw_usleep_os(2);
+			} while (!rstatus && (loop++ < 10));
+		}
+		rtw_IOL_cmd_buf_dump(Adapter, data_len, pbuf);
+		rtw_vmfree(pbuf, data_len+10);
+	}
+	DBG_88E("###### %s ######\n", __func__);
+}
+
+static void _FWDownloadEnable(struct adapter *padapter, bool enable)
+{
+	u8 tmp;
+
+	if (enable) {
+		/*  MCU firmware download enable. */
+		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
+
+		/*  8051 reset */
+		tmp = rtw_read8(padapter, REG_MCUFWDL+2);
+		rtw_write8(padapter, REG_MCUFWDL+2, tmp&0xf7);
+	} else {
+		/*  MCU firmware download disable. */
+		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		rtw_write8(padapter, REG_MCUFWDL, tmp&0xfe);
+
+		/*  Reserved for fw extension. */
+		rtw_write8(padapter, REG_MCUFWDL+1, 0x00);
+	}
+}
+
+#define MAX_REG_BOLCK_SIZE	196
+
+static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
+{
+	int ret = _SUCCESS;
+	u32	blockSize_p1 = 4;	/*  (Default) Phase #1 : PCI muse use 4-byte write to download FW */
+	u32	blockSize_p2 = 8;	/*  Phase #2 : Use 8-byte, if Phase#1 use big size to write FW. */
+	u32	blockSize_p3 = 1;	/*  Phase #3 : Use 1-byte, the remnant of FW image. */
+	u32	blockCount_p1 = 0, blockCount_p2 = 0, blockCount_p3 = 0;
+	u32	remainSize_p1 = 0, remainSize_p2 = 0;
+	u8 *bufferPtr	= (u8 *)buffer;
+	u32	i = 0, offset = 0;
+
+	blockSize_p1 = MAX_REG_BOLCK_SIZE;
+
+	/* 3 Phase #1 */
+	blockCount_p1 = buffSize / blockSize_p1;
+	remainSize_p1 = buffSize % blockSize_p1;
+
+	if (blockCount_p1) {
+		RT_TRACE(_module_hal_init_c_, _drv_notice_,
+			 ("_BlockWrite: [P1] buffSize(%d) blockSize_p1(%d) blockCount_p1(%d) remainSize_p1(%d)\n",
+			 buffSize, blockSize_p1, blockCount_p1, remainSize_p1));
+	}
+
+	for (i = 0; i < blockCount_p1; i++) {
+		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * blockSize_p1), blockSize_p1, (bufferPtr + i * blockSize_p1));
+		if (ret == _FAIL)
+			goto exit;
+	}
+
+	/* 3 Phase #2 */
+	if (remainSize_p1) {
+		offset = blockCount_p1 * blockSize_p1;
+
+		blockCount_p2 = remainSize_p1/blockSize_p2;
+		remainSize_p2 = remainSize_p1%blockSize_p2;
+
+		if (blockCount_p2) {
+				RT_TRACE(_module_hal_init_c_, _drv_notice_,
+					 ("_BlockWrite: [P2] buffSize_p2(%d) blockSize_p2(%d) blockCount_p2(%d) remainSize_p2(%d)\n",
+					 (buffSize-offset), blockSize_p2 , blockCount_p2, remainSize_p2));
+		}
+
+		for (i = 0; i < blockCount_p2; i++) {
+			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i*blockSize_p2), blockSize_p2, (bufferPtr + offset + i*blockSize_p2));
+
+			if (ret == _FAIL)
+				goto exit;
+		}
+	}
+
+	/* 3 Phase #3 */
+	if (remainSize_p2) {
+		offset = (blockCount_p1 * blockSize_p1) + (blockCount_p2 * blockSize_p2);
+
+		blockCount_p3 = remainSize_p2 / blockSize_p3;
+
+		RT_TRACE(_module_hal_init_c_, _drv_notice_,
+			 ("_BlockWrite: [P3] buffSize_p3(%d) blockSize_p3(%d) blockCount_p3(%d)\n",
+			 (buffSize-offset), blockSize_p3, blockCount_p3));
+
+		for (i = 0; i < blockCount_p3; i++) {
+			ret = rtw_write8(padapter, (FW_8188E_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
+
+			if (ret == _FAIL)
+				goto exit;
+		}
+	}
+
+exit:
+	return ret;
+}
+
+static int _PageWrite(struct adapter *padapter, u32 page, void *buffer, u32 size)
+{
+	u8 value8;
+	u8 u8Page = (u8)(page & 0x07);
+
+	value8 = (rtw_read8(padapter, REG_MCUFWDL+2) & 0xF8) | u8Page;
+	rtw_write8(padapter, REG_MCUFWDL+2, value8);
+
+	return _BlockWrite(padapter, buffer, size);
+}
+
+static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
+{
+	/*  Since we need dynamic decide method of dwonload fw, so we call this function to get chip version. */
+	/*  We can remove _ReadChipVersion from ReadpadapterInfo8192C later. */
+	int ret = _SUCCESS;
+	u32	pageNums, remainSize;
+	u32	page, offset;
+	u8 *bufferPtr = (u8 *)buffer;
+
+	pageNums = size / MAX_PAGE_SIZE;
+	remainSize = size % MAX_PAGE_SIZE;
+
+	for (page = 0; page < pageNums; page++) {
+		offset = page * MAX_PAGE_SIZE;
+		ret = _PageWrite(padapter, page, bufferPtr+offset, MAX_PAGE_SIZE);
+
+		if (ret == _FAIL)
+			goto exit;
+	}
+	if (remainSize) {
+		offset = pageNums * MAX_PAGE_SIZE;
+		page = pageNums;
+		ret = _PageWrite(padapter, page, bufferPtr+offset, remainSize);
+
+		if (ret == _FAIL)
+			goto exit;
+	}
+	RT_TRACE(_module_hal_init_c_, _drv_info_, ("_WriteFW Done- for Normal chip.\n"));
+exit:
+	return ret;
+}
+
+void _8051Reset88E(struct adapter *padapter)
+{
+	u8 u1bTmp;
+
+	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN+1);
+	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT2));
+	rtw_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp|(BIT2));
+	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
+}
+
+static s32 _FWFreeToGo(struct adapter *padapter)
+{
+	u32	counter = 0;
+	u32	value32;
+
+	/*  polling CheckSum report */
+	do {
+		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		if (value32 & FWDL_ChkSum_rpt)
+			break;
+	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
+
+	if (counter >= POLLING_READY_TIMEOUT_COUNT) {
+		DBG_88E("%s: chksum report fail! REG_MCUFWDL:0x%08x\n", __func__, value32);
+		return _FAIL;
+	}
+	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
+
+	value32 = rtw_read32(padapter, REG_MCUFWDL);
+	value32 |= MCUFWDL_RDY;
+	value32 &= ~WINTINI_RDY;
+	rtw_write32(padapter, REG_MCUFWDL, value32);
+
+	_8051Reset88E(padapter);
+
+	/*  polling for FW ready */
+	counter = 0;
+	do {
+		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		if (value32 & WINTINI_RDY) {
+			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
+			return _SUCCESS;
+		}
+		rtw_udelay_os(5);
+	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
+
+	DBG_88E("%s: Polling FW ready fail!! REG_MCUFWDL:0x%08x\n", __func__, value32);
+	return _FAIL;
+}
+
+#define IS_FW_81xxC(padapter)	(((GET_HAL_DATA(padapter))->FirmwareSignature & 0xFFF0) == 0x88C0)
+
+static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
+{
+	s32	rtStatus = _SUCCESS;
+	const struct firmware *fw;
+	const char *fw_name = "rtlwifi/rtl8188eufw.bin";
+	int err = request_firmware(&fw, fw_name, device);
+
+	if (err) {
+		pr_err("Request firmware failed with error 0x%x\n", err);
+		rtStatus = _FAIL;
+		goto Exit;
+	}
+	if (!fw) {
+		pr_err("Firmware %s not available\n", fw_name);
+		rtStatus = _FAIL;
+		goto Exit;
+	}
+	if (fw->size > FW_8188E_SIZE) {
+		rtStatus = _FAIL;
+		RT_TRACE(_module_hal_init_c_, _drv_err_, ("Firmware size exceed 0x%X. Check it.\n", FW_8188E_SIZE));
+		goto Exit;
+	}
+
+	pFirmware->szFwBuffer = kzalloc(FW_8188E_SIZE, GFP_KERNEL);
+	if (!pFirmware->szFwBuffer) {
+		pr_err("Failed to allocate pFirmware->szFwBuffer\n");
+		rtStatus = _FAIL;
+		goto Exit;
+	}
+	memcpy(pFirmware->szFwBuffer, fw->data, fw->size);
+	pFirmware->ulFwLength = fw->size;
+	release_firmware(fw);
+	DBG_88E_LEVEL(_drv_info_, "+%s: !bUsedWoWLANFw, FmrmwareLen:%d+\n", __func__, pFirmware->ulFwLength);
+
+Exit:
+	return rtStatus;
+}
+
+s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
+{
+	s32	rtStatus = _SUCCESS;
+	u8 writeFW_retry = 0;
+	u32 fwdl_start_time;
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
+	struct device *device = dvobj_to_dev(dvobj);
+	struct rt_firmware_hdr *pFwHdr = NULL;
+	u8 *pFirmwareBuf;
+	u32 FirmwareLen;
+	static int log_version;
+
+	RT_TRACE(_module_hal_init_c_, _drv_info_, ("+%s\n", __func__));
+	if (!dvobj->firmware.szFwBuffer)
+		rtStatus = load_firmware(&dvobj->firmware, device);
+	if (rtStatus == _FAIL) {
+		dvobj->firmware.szFwBuffer = NULL;
+		goto Exit;
+	}
+	pFirmwareBuf = dvobj->firmware.szFwBuffer;
+	FirmwareLen = dvobj->firmware.ulFwLength;
+
+	/*  To Check Fw header. Added by tynli. 2009.12.04. */
+	pFwHdr = (struct rt_firmware_hdr *)dvobj->firmware.szFwBuffer;
+
+	pHalData->FirmwareVersion =  le16_to_cpu(pFwHdr->Version);
+	pHalData->FirmwareSubVersion = pFwHdr->Subversion;
+	pHalData->FirmwareSignature = le16_to_cpu(pFwHdr->Signature);
+
+	if (!log_version++)
+		pr_info("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
+			DRIVER_PREFIX, pHalData->FirmwareVersion,
+			pHalData->FirmwareSubVersion, pHalData->FirmwareSignature);
+
+	if (IS_FW_HEADER_EXIST(pFwHdr)) {
+		/*  Shift 32 bytes for FW header */
+		pFirmwareBuf = pFirmwareBuf + 32;
+		FirmwareLen = FirmwareLen - 32;
+	}
+
+	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
+	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
+	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
+		rtw_write8(padapter, REG_MCUFWDL, 0x00);
+		_8051Reset88E(padapter);
+	}
+
+	_FWDownloadEnable(padapter, true);
+	fwdl_start_time = jiffies;
+	while (1) {
+		/* reset the FWDL chksum */
+		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_ChkSum_rpt);
+
+		rtStatus = _WriteFW(padapter, pFirmwareBuf, FirmwareLen);
+
+		if (rtStatus == _SUCCESS ||
+		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && writeFW_retry++ >= 3))
+			break;
+
+		DBG_88E("%s writeFW_retry:%u, time after fwdl_start_time:%ums\n",
+			__func__, writeFW_retry, rtw_get_passing_time_ms(fwdl_start_time)
+		);
+	}
+	_FWDownloadEnable(padapter, false);
+	if (_SUCCESS != rtStatus) {
+		DBG_88E("DL Firmware failed!\n");
+		goto Exit;
+	}
+
+	rtStatus = _FWFreeToGo(padapter);
+	if (_SUCCESS != rtStatus) {
+		DBG_88E("DL Firmware failed!\n");
+		goto Exit;
+	}
+	RT_TRACE(_module_hal_init_c_, _drv_info_, ("Firmware is ready to run!\n"));
+
+Exit:
+	return rtStatus;
+}
+
+void rtl8188e_InitializeFirmwareVars(struct adapter *padapter)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+
+	/*  Init Fw LPS related. */
+	padapter->pwrctrlpriv.bFwCurrentInPSMode = false;
+
+	/*  Init H2C counter. by tynli. 2009.12.09. */
+	pHalData->LastHMEBoxNum = 0;
+}
+
+static void rtl8188e_free_hal_data(struct adapter *padapter)
+{
+
+	kfree(padapter->HalData);
+	padapter->HalData = NULL;
+
+}
+
+/*  */
+/*			Efuse related code */
+/*  */
+enum{
+		VOLTAGE_V25						= 0x03,
+		LDOE25_SHIFT						= 28 ,
+	};
+
+static bool
+hal_EfusePgPacketWrite2ByteHeader(
+		struct adapter *pAdapter,
+		u8 efuseType,
+		u16				*pAddr,
+		struct pgpkt *pTargetPkt,
+		bool bPseudoTest);
+static bool
+hal_EfusePgPacketWrite1ByteHeader(
+		struct adapter *pAdapter,
+		u8 efuseType,
+		u16				*pAddr,
+		struct pgpkt *pTargetPkt,
+		bool bPseudoTest);
+static bool
+hal_EfusePgPacketWriteData(
+		struct adapter *pAdapter,
+		u8 efuseType,
+		u16				*pAddr,
+		struct pgpkt *pTargetPkt,
+		bool bPseudoTest);
+
+static void
+hal_EfusePowerSwitch_RTL8188E(
+		struct adapter *pAdapter,
+		u8 bWrite,
+		u8 PwrState)
+{
+	u8 tempval;
+	u16	tmpV16;
+
+	if (PwrState) {
+		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
+
+		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
+		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
+		if (!(tmpV16 & PWC_EV12V)) {
+			tmpV16 |= PWC_EV12V;
+			 rtw_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
+		}
+		/*  Reset: 0x0000h[28], default valid */
+		tmpV16 =  rtw_read16(pAdapter, REG_SYS_FUNC_EN);
+		if (!(tmpV16 & FEN_ELDR)) {
+			tmpV16 |= FEN_ELDR;
+			rtw_write16(pAdapter, REG_SYS_FUNC_EN, tmpV16);
+		}
+
+		/*  Clock: Gated(0x0008h[5]) 8M(0x0008h[1]) clock from ANA, default valid */
+		tmpV16 = rtw_read16(pAdapter, REG_SYS_CLKR);
+		if ((!(tmpV16 & LOADER_CLK_EN))  || (!(tmpV16 & ANA8M))) {
+			tmpV16 |= (LOADER_CLK_EN | ANA8M);
+			rtw_write16(pAdapter, REG_SYS_CLKR, tmpV16);
+		}
+
+		if (bWrite) {
+			/*  Enable LDO 2.5V before read/write action */
+			tempval = rtw_read8(pAdapter, EFUSE_TEST+3);
+			tempval &= 0x0F;
+			tempval |= (VOLTAGE_V25 << 4);
+			rtw_write8(pAdapter, EFUSE_TEST+3, (tempval | 0x80));
+		}
+	} else {
+		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
+
+		if (bWrite) {
+			/*  Disable LDO 2.5V after read/write action */
+			tempval = rtw_read8(pAdapter, EFUSE_TEST+3);
+			rtw_write8(pAdapter, EFUSE_TEST+3, (tempval & 0x7F));
+		}
+	}
+}
+
+static void
+rtl8188e_EfusePowerSwitch(
+		struct adapter *pAdapter,
+		u8 bWrite,
+		u8 PwrState)
+{
+	hal_EfusePowerSwitch_RTL8188E(pAdapter, bWrite, PwrState);
+}
+
+static void Hal_EfuseReadEFuse88E(struct adapter *Adapter,
+	u16			_offset,
+	u16			_size_byte,
+	u8 *pbuf,
+		bool bPseudoTest
+	)
+{
+	u8 *efuseTbl = NULL;
+	u8 rtemp8[1];
+	u16	eFuse_Addr = 0;
+	u8 offset, wren;
+	u16	i, j;
+	u16	**eFuseWord = NULL;
+	u16	efuse_utilized = 0;
+	u8 u1temp = 0;
+
+	/*  */
+	/*  Do NOT excess total size of EFuse table. Added by Roger, 2008.11.10. */
+	/*  */
+	if ((_offset + _size_byte) > EFUSE_MAP_LEN_88E) {/*  total E-Fuse table is 512bytes */
+		DBG_88E("Hal_EfuseReadEFuse88E(): Invalid offset(%#x) with read bytes(%#x)!!\n", _offset, _size_byte);
+		goto exit;
+	}
+
+	efuseTbl = (u8 *)rtw_zmalloc(EFUSE_MAP_LEN_88E);
+	if (efuseTbl == NULL) {
+		DBG_88E("%s: alloc efuseTbl fail!\n", __func__);
+		goto exit;
+	}
+
+	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+	if (eFuseWord == NULL) {
+		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+		goto exit;
+	}
+
+	/*  0. Refresh efuse init map as all oxFF. */
+	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
+		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++)
+			eFuseWord[i][j] = 0xFFFF;
+
+	/*  */
+	/*  1. Read the first byte to check if efuse is empty!!! */
+	/*  */
+	/*  */
+	ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+	if (*rtemp8 != 0xFF) {
+		efuse_utilized++;
+		eFuse_Addr++;
+	} else {
+		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, *rtemp8);
+		goto exit;
+	}
+
+	/*  */
+	/*  2. Read real efuse content. Filter PG header and every section data. */
+	/*  */
+	while ((*rtemp8 != 0xFF) && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
+		/*  Check PG header for section num. */
+		if ((*rtemp8 & 0x1F) == 0x0F) {		/* extended header */
+			u1temp = ((*rtemp8 & 0xE0) >> 5);
+
+			ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+
+			if ((*rtemp8 & 0x0F) == 0x0F) {
+				eFuse_Addr++;
+				ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+
+				if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E))
+					eFuse_Addr++;
+				continue;
+			} else {
+				offset = ((*rtemp8 & 0xF0) >> 1) | u1temp;
+				wren = (*rtemp8 & 0x0F);
+				eFuse_Addr++;
+			}
+		} else {
+			offset = ((*rtemp8 >> 4) & 0x0f);
+			wren = (*rtemp8 & 0x0f);
+		}
+
+		if (offset < EFUSE_MAX_SECTION_88E) {
+			/*  Get word enable value from PG header */
+
+			for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
+				/*  Check word enable condition in the section */
+				if (!(wren & 0x01)) {
+					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					eFuse_Addr++;
+					efuse_utilized++;
+					eFuseWord[offset][i] = (*rtemp8 & 0xff);
+					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
+						break;
+					ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+					eFuse_Addr++;
+					efuse_utilized++;
+					eFuseWord[offset][i] |= (((u16)*rtemp8 << 8) & 0xff00);
+					if (eFuse_Addr >= EFUSE_REAL_CONTENT_LEN_88E)
+						break;
+				}
+				wren >>= 1;
+			}
+		}
+
+		/*  Read next PG header */
+		ReadEFuseByte(Adapter, eFuse_Addr, rtemp8, bPseudoTest);
+
+		if (*rtemp8 != 0xFF && (eFuse_Addr < EFUSE_REAL_CONTENT_LEN_88E)) {
+			efuse_utilized++;
+			eFuse_Addr++;
+		}
+	}
+
+	/*  3. Collect 16 sections and 4 word unit into Efuse map. */
+	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++) {
+		for (j = 0; j < EFUSE_MAX_WORD_UNIT; j++) {
+			efuseTbl[(i*8)+(j*2)] = (eFuseWord[i][j] & 0xff);
+			efuseTbl[(i*8)+((j*2)+1)] = ((eFuseWord[i][j] >> 8) & 0xff);
+		}
+	}
+
+	/*  4. Copy from Efuse map to output pointer memory!!! */
+	for (i = 0; i < _size_byte; i++)
+		pbuf[i] = efuseTbl[_offset+i];
+
+	/*  5. Calculate Efuse utilization. */
+	rtw_hal_set_hwreg(Adapter, HW_VAR_EFUSE_BYTES, (u8 *)&eFuse_Addr);
+
+exit:
+	kfree(efuseTbl);
+
+	if (eFuseWord)
+		rtw_mfree2d((void *)eFuseWord, EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
+}
+
+static void ReadEFuseByIC(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+{
+	if (!bPseudoTest) {
+		int ret = _FAIL;
+		if (rtw_IOL_applied(Adapter)) {
+			rtw_hal_power_on(Adapter);
+
+			iol_mode_enable(Adapter, 1);
+			ret = iol_read_efuse(Adapter, 0, _offset, _size_byte, pbuf);
+			iol_mode_enable(Adapter, 0);
+
+			if (_SUCCESS == ret)
+				goto exit;
+		}
+	}
+	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
+
+exit:
+	return;
+}
+
+static void ReadEFuse_Pseudo(struct adapter *Adapter, u8 efuseType, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
+{
+	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
+}
+
+static void rtl8188e_ReadEFuse(struct adapter *Adapter, u8 efuseType,
+			       u16 _offset, u16 _size_byte, u8 *pbuf,
+			       bool bPseudoTest)
+{
+	if (bPseudoTest)
+		ReadEFuse_Pseudo (Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+	else
+		ReadEFuseByIC(Adapter, efuseType, _offset, _size_byte, pbuf, bPseudoTest);
+}
+
+/* Do not support BT */
+static void Hal_EFUSEGetEfuseDefinition88E(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut)
+{
+	switch (type) {
+	case TYPE_EFUSE_MAX_SECTION:
+		{
+			u8 *pMax_section;
+			pMax_section = (u8 *)pOut;
+			*pMax_section = EFUSE_MAX_SECTION_88E;
+		}
+		break;
+	case TYPE_EFUSE_REAL_CONTENT_LEN:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
+		}
+		break;
+	case TYPE_EFUSE_CONTENT_LEN_BANK:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
+		}
+		break;
+	case TYPE_AVAILABLE_EFUSE_BYTES_BANK:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+		}
+		break;
+	case TYPE_AVAILABLE_EFUSE_BYTES_TOTAL:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+		}
+		break;
+	case TYPE_EFUSE_MAP_LEN:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = (u16)EFUSE_MAP_LEN_88E;
+		}
+		break;
+	case TYPE_EFUSE_PROTECT_BYTES_BANK:
+		{
+			u8 *pu1Tmp;
+			pu1Tmp = (u8 *)pOut;
+			*pu1Tmp = (u8)(EFUSE_OOB_PROTECT_BYTES_88E);
+		}
+		break;
+	default:
+		{
+			u8 *pu1Tmp;
+			pu1Tmp = (u8 *)pOut;
+			*pu1Tmp = 0;
+		}
+		break;
+	}
+}
+
+static void Hal_EFUSEGetEfuseDefinition_Pseudo88E(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut)
+{
+	switch (type) {
+	case TYPE_EFUSE_MAX_SECTION:
+		{
+			u8 *pMax_section;
+			pMax_section = (u8 *)pOut;
+			*pMax_section = EFUSE_MAX_SECTION_88E;
+		}
+		break;
+	case TYPE_EFUSE_REAL_CONTENT_LEN:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
+		}
+		break;
+	case TYPE_EFUSE_CONTENT_LEN_BANK:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = EFUSE_REAL_CONTENT_LEN_88E;
+		}
+		break;
+	case TYPE_AVAILABLE_EFUSE_BYTES_BANK:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+		}
+		break;
+	case TYPE_AVAILABLE_EFUSE_BYTES_TOTAL:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = (u16)(EFUSE_REAL_CONTENT_LEN_88E-EFUSE_OOB_PROTECT_BYTES_88E);
+		}
+		break;
+	case TYPE_EFUSE_MAP_LEN:
+		{
+			u16 *pu2Tmp;
+			pu2Tmp = (u16 *)pOut;
+			*pu2Tmp = (u16)EFUSE_MAP_LEN_88E;
+		}
+		break;
+	case TYPE_EFUSE_PROTECT_BYTES_BANK:
+		{
+			u8 *pu1Tmp;
+			pu1Tmp = (u8 *)pOut;
+			*pu1Tmp = (u8)(EFUSE_OOB_PROTECT_BYTES_88E);
+		}
+		break;
+	default:
+		{
+			u8 *pu1Tmp;
+			pu1Tmp = (u8 *)pOut;
+			*pu1Tmp = 0;
+		}
+		break;
+	}
+}
+
+static void rtl8188e_EFUSE_GetEfuseDefinition(struct adapter *pAdapter, u8 efuseType, u8 type, void *pOut, bool bPseudoTest)
+{
+	if (bPseudoTest)
+		Hal_EFUSEGetEfuseDefinition_Pseudo88E(pAdapter, efuseType, type, pOut);
+	else
+		Hal_EFUSEGetEfuseDefinition88E(pAdapter, efuseType, type, pOut);
+}
+
+static u8 Hal_EfuseWordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest)
+{
+	u16	tmpaddr = 0;
+	u16	start_addr = efuse_addr;
+	u8 badworden = 0x0F;
+	u8 tmpdata[8];
+
+	memset((void *)tmpdata, 0xff, PGPKT_DATA_SIZE);
+
+	if (!(word_en&BIT0)) {
+		tmpaddr = start_addr;
+		efuse_OneByteWrite(pAdapter, start_addr++, data[0], bPseudoTest);
+		efuse_OneByteWrite(pAdapter, start_addr++, data[1], bPseudoTest);
+
+		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[0], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[1], bPseudoTest);
+		if ((data[0] != tmpdata[0]) || (data[1] != tmpdata[1]))
+			badworden &= (~BIT0);
+	}
+	if (!(word_en&BIT1)) {
+		tmpaddr = start_addr;
+		efuse_OneByteWrite(pAdapter, start_addr++, data[2], bPseudoTest);
+		efuse_OneByteWrite(pAdapter, start_addr++, data[3], bPseudoTest);
+
+		efuse_OneByteRead(pAdapter, tmpaddr    , &tmpdata[2], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[3], bPseudoTest);
+		if ((data[2] != tmpdata[2]) || (data[3] != tmpdata[3]))
+			badworden &= (~BIT1);
+	}
+	if (!(word_en&BIT2)) {
+		tmpaddr = start_addr;
+		efuse_OneByteWrite(pAdapter, start_addr++, data[4], bPseudoTest);
+		efuse_OneByteWrite(pAdapter, start_addr++, data[5], bPseudoTest);
+
+		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[4], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[5], bPseudoTest);
+		if ((data[4] != tmpdata[4]) || (data[5] != tmpdata[5]))
+			badworden &= (~BIT2);
+	}
+	if (!(word_en&BIT3)) {
+		tmpaddr = start_addr;
+		efuse_OneByteWrite(pAdapter, start_addr++, data[6], bPseudoTest);
+		efuse_OneByteWrite(pAdapter, start_addr++, data[7], bPseudoTest);
+
+		efuse_OneByteRead(pAdapter, tmpaddr, &tmpdata[6], bPseudoTest);
+		efuse_OneByteRead(pAdapter, tmpaddr+1, &tmpdata[7], bPseudoTest);
+		if ((data[6] != tmpdata[6]) || (data[7] != tmpdata[7]))
+			badworden &= (~BIT3);
+	}
+	return badworden;
+}
+
+static u8 Hal_EfuseWordEnableDataWrite_Pseudo(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest)
+{
+	u8 ret;
+
+	ret = Hal_EfuseWordEnableDataWrite(pAdapter, efuse_addr, word_en, data, bPseudoTest);
+	return ret;
+}
+
+static u8 rtl8188e_Efuse_WordEnableDataWrite(struct adapter *pAdapter, u16 efuse_addr, u8 word_en, u8 *data, bool bPseudoTest)
+{
+	u8 ret = 0;
+
+	if (bPseudoTest)
+		ret = Hal_EfuseWordEnableDataWrite_Pseudo (pAdapter, efuse_addr, word_en, data, bPseudoTest);
+	else
+		ret = Hal_EfuseWordEnableDataWrite(pAdapter, efuse_addr, word_en, data, bPseudoTest);
+	return ret;
+}
+
+static u16 hal_EfuseGetCurrentSize_8188e(struct adapter *pAdapter, bool bPseudoTest)
+{
+	int	bContinual = true;
+	u16	efuse_addr = 0;
+	u8 hoffset = 0, hworden = 0;
+	u8 efuse_data, word_cnts = 0;
+
+	if (bPseudoTest)
+		efuse_addr = (u16)(fakeEfuseUsedBytes);
+	else
+		rtw_hal_get_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
+
+	while (bContinual &&
+	       efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest) &&
+	       AVAILABLE_EFUSE_ADDR(efuse_addr)) {
+		if (efuse_data != 0xFF) {
+			if ((efuse_data&0x1F) == 0x0F) {		/* extended header */
+				hoffset = efuse_data;
+				efuse_addr++;
+				efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest);
+				if ((efuse_data & 0x0F) == 0x0F) {
+					efuse_addr++;
+					continue;
+				} else {
+					hoffset = ((hoffset & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
+					hworden = efuse_data & 0x0F;
+				}
+			} else {
+				hoffset = (efuse_data>>4) & 0x0F;
+				hworden =  efuse_data & 0x0F;
+			}
+			word_cnts = Efuse_CalculateWordCnts(hworden);
+			/* read next header */
+			efuse_addr = efuse_addr + (word_cnts*2)+1;
+		} else {
+			bContinual = false;
+		}
+	}
+
+	if (bPseudoTest)
+		fakeEfuseUsedBytes = efuse_addr;
+	else
+		rtw_hal_set_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&efuse_addr);
+
+	return efuse_addr;
+}
+
+static u16 Hal_EfuseGetCurrentSize_Pseudo(struct adapter *pAdapter, bool bPseudoTest)
+{
+	u16	ret = 0;
+
+	ret = hal_EfuseGetCurrentSize_8188e(pAdapter, bPseudoTest);
+	return ret;
+}
+
+static u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bPseudoTest)
+{
+	u16	ret = 0;
+
+	if (bPseudoTest)
+		ret = Hal_EfuseGetCurrentSize_Pseudo(pAdapter, bPseudoTest);
+	else
+		ret = hal_EfuseGetCurrentSize_8188e(pAdapter, bPseudoTest);
+	return ret;
+}
+
+static int hal_EfusePgPacketRead_8188e(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
+{
+	u8 ReadState = PG_STATE_HEADER;
+	int	bContinual = true;
+	int	bDataEmpty = true;
+	u8 efuse_data, word_cnts = 0;
+	u16	efuse_addr = 0;
+	u8 hoffset = 0, hworden = 0;
+	u8 tmpidx = 0;
+	u8 tmpdata[8];
+	u8 max_section = 0;
+	u8 tmp_header = 0;
+
+	EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAX_SECTION, (void *)&max_section, bPseudoTest);
+
+	if (data == NULL)
+		return false;
+	if (offset > max_section)
+		return false;
+
+	memset((void *)data, 0xff, sizeof(u8)*PGPKT_DATA_SIZE);
+	memset((void *)tmpdata, 0xff, sizeof(u8)*PGPKT_DATA_SIZE);
+
+	/*  <Roger_TODO> Efuse has been pre-programmed dummy 5Bytes at the end of Efuse by CP. */
+	/*  Skip dummy parts to prevent unexpected data read from Efuse. */
+	/*  By pass right now. 2009.02.19. */
+	while (bContinual && AVAILABLE_EFUSE_ADDR(efuse_addr)) {
+		/*   Header Read ------------- */
+		if (ReadState & PG_STATE_HEADER) {
+			if (efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
+				if (EXT_HEADER(efuse_data)) {
+					tmp_header = efuse_data;
+					efuse_addr++;
+					efuse_OneByteRead(pAdapter, efuse_addr, &efuse_data, bPseudoTest);
+					if (!ALL_WORDS_DISABLED(efuse_data)) {
+						hoffset = ((tmp_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
+						hworden = efuse_data & 0x0F;
+					} else {
+						DBG_88E("Error, All words disabled\n");
+						efuse_addr++;
+						continue;
+					}
+				} else {
+					hoffset = (efuse_data>>4) & 0x0F;
+					hworden =  efuse_data & 0x0F;
+				}
+				word_cnts = Efuse_CalculateWordCnts(hworden);
+				bDataEmpty = true;
+
+				if (hoffset == offset) {
+					for (tmpidx = 0; tmpidx < word_cnts*2; tmpidx++) {
+						if (efuse_OneByteRead(pAdapter, efuse_addr+1+tmpidx, &efuse_data, bPseudoTest)) {
+							tmpdata[tmpidx] = efuse_data;
+							if (efuse_data != 0xff)
+								bDataEmpty = false;
+						}
+					}
+					if (bDataEmpty == false) {
+						ReadState = PG_STATE_DATA;
+					} else {/* read next header */
+						efuse_addr = efuse_addr + (word_cnts*2)+1;
+						ReadState = PG_STATE_HEADER;
+					}
+				} else {/* read next header */
+					efuse_addr = efuse_addr + (word_cnts*2)+1;
+					ReadState = PG_STATE_HEADER;
+				}
+			} else {
+				bContinual = false;
+			}
+		} else if (ReadState & PG_STATE_DATA) {
+		/*   Data section Read ------------- */
+			efuse_WordEnableDataRead(hworden, tmpdata, data);
+			efuse_addr = efuse_addr + (word_cnts*2)+1;
+			ReadState = PG_STATE_HEADER;
+		}
+
+	}
+
+	if ((data[0] == 0xff) && (data[1] == 0xff) && (data[2] == 0xff)  && (data[3] == 0xff) &&
+	    (data[4] == 0xff) && (data[5] == 0xff) && (data[6] == 0xff)  && (data[7] == 0xff))
+		return false;
+	else
+		return true;
+}
+
+static int Hal_EfusePgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
+{
+	int	ret;
+
+	ret = hal_EfusePgPacketRead_8188e(pAdapter, offset, data, bPseudoTest);
+	return ret;
+}
+
+static int Hal_EfusePgPacketRead_Pseudo(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
+{
+	int	ret;
+
+	ret = hal_EfusePgPacketRead_8188e(pAdapter, offset, data, bPseudoTest);
+	return ret;
+}
+
+static int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest)
+{
+	int	ret;
+
+	if (bPseudoTest)
+		ret = Hal_EfusePgPacketRead_Pseudo (pAdapter, offset, data, bPseudoTest);
+	else
+		ret = Hal_EfusePgPacketRead(pAdapter, offset, data, bPseudoTest);
+	return ret;
+}
+
+static bool hal_EfuseFixHeaderProcess(struct adapter *pAdapter, u8 efuseType, struct pgpkt *pFixPkt, u16 *pAddr, bool bPseudoTest)
+{
+	u8 originaldata[8], badworden = 0;
+	u16	efuse_addr = *pAddr;
+	u32	PgWriteSuccess = 0;
+
+	memset((void *)originaldata, 0xff, 8);
+
+	if (Efuse_PgPacketRead(pAdapter, pFixPkt->offset, originaldata, bPseudoTest)) {
+		/* check if data exist */
+		badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr+1, pFixPkt->word_en, originaldata, bPseudoTest);
+
+		if (badworden != 0xf) {	/*  write fail */
+			PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pFixPkt->offset, badworden, originaldata, bPseudoTest);
+
+			if (!PgWriteSuccess)
+				return false;
+			else
+				efuse_addr = Efuse_GetCurrentSize(pAdapter, efuseType, bPseudoTest);
+		} else {
+			efuse_addr = efuse_addr + (pFixPkt->word_cnts*2) + 1;
+		}
+	} else {
+		efuse_addr = efuse_addr + (pFixPkt->word_cnts*2) + 1;
+	}
+	*pAddr = efuse_addr;
+	return true;
+}
+
+static bool hal_EfusePgPacketWrite2ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
+{
+	bool bRet = false;
+	u16	efuse_addr = *pAddr, efuse_max_available_len = 0;
+	u8 pg_header = 0, tmp_header = 0, pg_header_temp = 0;
+	u8 repeatcnt = 0;
+
+	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
+
+	while (efuse_addr < efuse_max_available_len) {
+		pg_header = ((pTargetPkt->offset & 0x07) << 5) | 0x0F;
+		efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
+		efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
+
+		while (tmp_header == 0xFF) {
+			if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
+				return false;
+
+			efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
+			efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
+		}
+
+		/* to write ext_header */
+		if (tmp_header == pg_header) {
+			efuse_addr++;
+			pg_header_temp = pg_header;
+			pg_header = ((pTargetPkt->offset & 0x78) << 1) | pTargetPkt->word_en;
+
+			efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
+			efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
+
+			while (tmp_header == 0xFF) {
+				if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
+					return false;
+
+				efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
+				efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
+			}
+
+			if ((tmp_header & 0x0F) == 0x0F) {	/* word_en PG fail */
+				if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_) {
+					return false;
+				} else {
+					efuse_addr++;
+					continue;
+				}
+			} else if (pg_header != tmp_header) {	/* offset PG fail */
+				struct pgpkt	fixPkt;
+				fixPkt.offset = ((pg_header_temp & 0xE0) >> 5) | ((tmp_header & 0xF0) >> 1);
+				fixPkt.word_en = tmp_header & 0x0F;
+				fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
+				if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr, bPseudoTest))
+					return false;
+			} else {
+				bRet = true;
+				break;
+			}
+		} else if ((tmp_header & 0x1F) == 0x0F) {		/* wrong extended header */
+			efuse_addr += 2;
+			continue;
+		}
+	}
+
+	*pAddr = efuse_addr;
+	return bRet;
+}
+
+static bool hal_EfusePgPacketWrite1ByteHeader(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
+{
+	bool bRet = false;
+	u8 pg_header = 0, tmp_header = 0;
+	u16	efuse_addr = *pAddr;
+	u8 repeatcnt = 0;
+
+	pg_header = ((pTargetPkt->offset << 4) & 0xf0) | pTargetPkt->word_en;
+
+	efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
+	efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
+
+	while (tmp_header == 0xFF) {
+		if (repeatcnt++ > EFUSE_REPEAT_THRESHOLD_)
+			return false;
+		efuse_OneByteWrite(pAdapter, efuse_addr, pg_header, bPseudoTest);
+		efuse_OneByteRead(pAdapter, efuse_addr, &tmp_header, bPseudoTest);
+	}
+
+	if (pg_header == tmp_header) {
+		bRet = true;
+	} else {
+		struct pgpkt	fixPkt;
+		fixPkt.offset = (tmp_header>>4) & 0x0F;
+		fixPkt.word_en = tmp_header & 0x0F;
+		fixPkt.word_cnts = Efuse_CalculateWordCnts(fixPkt.word_en);
+		if (!hal_EfuseFixHeaderProcess(pAdapter, efuseType, &fixPkt, &efuse_addr, bPseudoTest))
+			return false;
+	}
+
+	*pAddr = efuse_addr;
+	return bRet;
+}
+
+static bool hal_EfusePgPacketWriteData(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
+{
+	u16	efuse_addr = *pAddr;
+	u8 badworden = 0;
+	u32	PgWriteSuccess = 0;
+
+	badworden = 0x0f;
+	badworden = Efuse_WordEnableDataWrite(pAdapter, efuse_addr+1, pTargetPkt->word_en, pTargetPkt->data, bPseudoTest);
+	if (badworden == 0x0F) {
+		/*  write ok */
+		return true;
+	} else {
+		/* reorganize other pg packet */
+		PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
+		if (!PgWriteSuccess)
+			return false;
+		else
+			return true;
+	}
+}
+
+static bool
+hal_EfusePgPacketWriteHeader(
+				struct adapter *pAdapter,
+				u8 efuseType,
+				u16				*pAddr,
+				struct pgpkt *pTargetPkt,
+				bool bPseudoTest)
+{
+	bool bRet = false;
+
+	if (pTargetPkt->offset >= EFUSE_MAX_SECTION_BASE)
+		bRet = hal_EfusePgPacketWrite2ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt, bPseudoTest);
+	else
+		bRet = hal_EfusePgPacketWrite1ByteHeader(pAdapter, efuseType, pAddr, pTargetPkt, bPseudoTest);
+
+	return bRet;
+}
+
+static bool wordEnMatched(struct pgpkt *pTargetPkt, struct pgpkt *pCurPkt,
+			  u8 *pWden)
+{
+	u8 match_word_en = 0x0F;	/*  default all words are disabled */
+
+	/*  check if the same words are enabled both target and current PG packet */
+	if (((pTargetPkt->word_en & BIT0) == 0) &&
+	    ((pCurPkt->word_en & BIT0) == 0))
+		match_word_en &= ~BIT0;				/*  enable word 0 */
+	if (((pTargetPkt->word_en & BIT1) == 0) &&
+	    ((pCurPkt->word_en & BIT1) == 0))
+		match_word_en &= ~BIT1;				/*  enable word 1 */
+	if (((pTargetPkt->word_en & BIT2) == 0) &&
+	    ((pCurPkt->word_en & BIT2) == 0))
+		match_word_en &= ~BIT2;				/*  enable word 2 */
+	if (((pTargetPkt->word_en & BIT3) == 0) &&
+	    ((pCurPkt->word_en & BIT3) == 0))
+		match_word_en &= ~BIT3;				/*  enable word 3 */
+
+	*pWden = match_word_en;
+
+	if (match_word_en != 0xf)
+		return true;
+	else
+		return false;
+}
+
+static bool hal_EfuseCheckIfDatafollowed(struct adapter *pAdapter, u8 word_cnts, u16 startAddr, bool bPseudoTest)
+{
+	bool bRet = false;
+	u8 i, efuse_data;
+
+	for (i = 0; i < (word_cnts*2); i++) {
+		if (efuse_OneByteRead(pAdapter, (startAddr+i), &efuse_data, bPseudoTest) && (efuse_data != 0xFF))
+			bRet = true;
+	}
+	return bRet;
+}
+
+static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u16 *pAddr, struct pgpkt *pTargetPkt, bool bPseudoTest)
+{
+	bool bRet = false;
+	u8 i, efuse_data = 0, cur_header = 0;
+	u8 matched_wden = 0, badworden = 0;
+	u16	startAddr = 0, efuse_max_available_len = 0, efuse_max = 0;
+	struct pgpkt curPkt;
+
+	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_AVAILABLE_EFUSE_BYTES_BANK, (void *)&efuse_max_available_len, bPseudoTest);
+	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&efuse_max, bPseudoTest);
+
+	if (efuseType == EFUSE_WIFI) {
+		if (bPseudoTest) {
+			startAddr = (u16)(fakeEfuseUsedBytes%EFUSE_REAL_CONTENT_LEN);
+		} else {
+			rtw_hal_get_hwreg(pAdapter, HW_VAR_EFUSE_BYTES, (u8 *)&startAddr);
+			startAddr %= EFUSE_REAL_CONTENT_LEN;
+		}
+	} else {
+		if (bPseudoTest)
+			startAddr = (u16)(fakeBTEfuseUsedBytes%EFUSE_REAL_CONTENT_LEN);
+		else
+			startAddr = (u16)(BTEfuseUsedBytes%EFUSE_REAL_CONTENT_LEN);
+	}
+
+	while (1) {
+		if (startAddr >= efuse_max_available_len) {
+			bRet = false;
+			break;
+		}
+
+		if (efuse_OneByteRead(pAdapter, startAddr, &efuse_data, bPseudoTest) && (efuse_data != 0xFF)) {
+			if (EXT_HEADER(efuse_data)) {
+				cur_header = efuse_data;
+				startAddr++;
+				efuse_OneByteRead(pAdapter, startAddr, &efuse_data, bPseudoTest);
+				if (ALL_WORDS_DISABLED(efuse_data)) {
+					bRet = false;
+					break;
+				} else {
+					curPkt.offset = ((cur_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
+					curPkt.word_en = efuse_data & 0x0F;
+				}
+			} else {
+				cur_header  =  efuse_data;
+				curPkt.offset = (cur_header>>4) & 0x0F;
+				curPkt.word_en = cur_header & 0x0F;
+			}
+
+			curPkt.word_cnts = Efuse_CalculateWordCnts(curPkt.word_en);
+			/*  if same header is found but no data followed */
+			/*  write some part of data followed by the header. */
+			if ((curPkt.offset == pTargetPkt->offset) &&
+			    (!hal_EfuseCheckIfDatafollowed(pAdapter, curPkt.word_cnts, startAddr+1, bPseudoTest)) &&
+			    wordEnMatched(pTargetPkt, &curPkt, &matched_wden)) {
+				/*  Here to write partial data */
+				badworden = Efuse_WordEnableDataWrite(pAdapter, startAddr+1, matched_wden, pTargetPkt->data, bPseudoTest);
+				if (badworden != 0x0F) {
+					u32	PgWriteSuccess = 0;
+					/*  if write fail on some words, write these bad words again */
+
+					PgWriteSuccess = Efuse_PgPacketWrite(pAdapter, pTargetPkt->offset, badworden, pTargetPkt->data, bPseudoTest);
+
+					if (!PgWriteSuccess) {
+						bRet = false;	/*  write fail, return */
+						break;
+					}
+				}
+				/*  partial write ok, update the target packet for later use */
+				for (i = 0; i < 4; i++) {
+					if ((matched_wden & (0x1<<i)) == 0)	/*  this word has been written */
+						pTargetPkt->word_en |= (0x1<<i);	/*  disable the word */
+				}
+				pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
+			}
+			/*  read from next header */
+			startAddr = startAddr + (curPkt.word_cnts*2) + 1;
+		} else {
+			/*  not used header, 0xff */
+			*pAddr = startAddr;
+			bRet = true;
+			break;
+		}
+	}
+	return bRet;
+}
+
+static bool
+hal_EfusePgCheckAvailableAddr(
+		struct adapter *pAdapter,
+		u8 efuseType,
+		bool bPseudoTest
+	)
+{
+	u16	efuse_max_available_len = 0;
+
+	/* Change to check TYPE_EFUSE_MAP_LEN , because 8188E raw 256, logic map over 256. */
+	EFUSE_GetEfuseDefinition(pAdapter, EFUSE_WIFI, TYPE_EFUSE_MAP_LEN, (void *)&efuse_max_available_len, false);
+
+	if (Efuse_GetCurrentSize(pAdapter, efuseType, bPseudoTest) >= efuse_max_available_len)
+		return false;
+	return true;
+}
+
+static void hal_EfuseConstructPGPkt(u8 offset, u8 word_en, u8 *pData, struct pgpkt *pTargetPkt)
+{
+	memset((void *)pTargetPkt->data, 0xFF, sizeof(u8)*8);
+	pTargetPkt->offset = offset;
+	pTargetPkt->word_en = word_en;
+	efuse_WordEnableDataRead(word_en, pData, pTargetPkt->data);
+	pTargetPkt->word_cnts = Efuse_CalculateWordCnts(pTargetPkt->word_en);
+}
+
+static bool hal_EfusePgPacketWrite_8188e(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *pData, bool bPseudoTest)
+{
+	struct pgpkt	targetPkt;
+	u16			startAddr = 0;
+	u8 efuseType = EFUSE_WIFI;
+
+	if (!hal_EfusePgCheckAvailableAddr(pAdapter, efuseType, bPseudoTest))
+		return false;
+
+	hal_EfuseConstructPGPkt(offset, word_en, pData, &targetPkt);
+
+	if (!hal_EfusePartialWriteCheck(pAdapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
+		return false;
+
+	if (!hal_EfusePgPacketWriteHeader(pAdapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
+		return false;
+
+	if (!hal_EfusePgPacketWriteData(pAdapter, efuseType, &startAddr, &targetPkt, bPseudoTest))
+		return false;
+
+	return true;
+}
+
+static int Hal_EfusePgPacketWrite_Pseudo(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
+{
+	int ret;
+
+	ret = hal_EfusePgPacketWrite_8188e(pAdapter, offset, word_en, data, bPseudoTest);
+	return ret;
+}
+
+static int Hal_EfusePgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
+{
+	int	ret = 0;
+	ret = hal_EfusePgPacketWrite_8188e(pAdapter, offset, word_en, data, bPseudoTest);
+
+	return ret;
+}
+
+static int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest)
+{
+	int	ret;
+
+	if (bPseudoTest)
+		ret = Hal_EfusePgPacketWrite_Pseudo (pAdapter, offset, word_en, data, bPseudoTest);
+	else
+		ret = Hal_EfusePgPacketWrite(pAdapter, offset, word_en, data, bPseudoTest);
+	return ret;
+}
+
+static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
+{
+	u32				value32;
+	struct HAL_VERSION		ChipVersion;
+	struct hal_data_8188e	*pHalData;
+
+	pHalData = GET_HAL_DATA(padapter);
+
+	value32 = rtw_read32(padapter, REG_SYS_CFG);
+	ChipVersion.ICType = CHIP_8188E;
+	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
+
+	ChipVersion.RFType = RF_TYPE_1T1R;
+	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
+	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK)>>CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
+
+	/*  For regulator mode. by tynli. 2011.01.14 */
+	pHalData->RegulatorMode = ((value32 & TRP_BT_EN) ? RT_LDO_REGULATOR : RT_SWITCHING_REGULATOR);
+
+	ChipVersion.ROMVer = 0;	/*  ROM code version. */
+	pHalData->MultiFunc = RT_MULTI_FUNC_NONE;
+
+	dump_chip_info(ChipVersion);
+
+	pHalData->VersionID = ChipVersion;
+
+	if (IS_1T2R(ChipVersion)) {
+		pHalData->rf_type = RF_1T2R;
+		pHalData->NumTotalRFPath = 2;
+	} else if (IS_2T2R(ChipVersion)) {
+		pHalData->rf_type = RF_2T2R;
+		pHalData->NumTotalRFPath = 2;
+	} else{
+		pHalData->rf_type = RF_1T1R;
+		pHalData->NumTotalRFPath = 1;
+	}
+
+	MSG_88E("RF_Type is %x!!\n", pHalData->rf_type);
+
+	return ChipVersion;
+}
+
+static void rtl8188e_read_chip_version(struct adapter *padapter)
+{
+	ReadChipVersion8188E(padapter);
+}
+
+static void rtl8188e_GetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
+{
+}
+
+static void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	struct odm_dm_struct *podmpriv = &pHalData->odmpriv;
+	switch (eVariable) {
+	case HAL_ODM_STA_INFO:
+		{
+			struct sta_info *psta = (struct sta_info *)pValue1;
+			if (bSet) {
+				DBG_88E("### Set STA_(%d) info\n", psta->mac_id);
+				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, psta);
+				ODM_RAInfo_Init(podmpriv, psta->mac_id);
+			} else {
+				DBG_88E("### Clean STA_(%d) info\n", psta->mac_id);
+				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, NULL);
+		       }
+		}
+		break;
+	case HAL_ODM_P2P_STATE:
+			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DIRECT, bSet);
+		break;
+	case HAL_ODM_WIFI_DISPLAY_STATE:
+			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DISPLAY, bSet);
+		break;
+	default:
+		break;
+	}
+}
+
+void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_adapter)
+{
+	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
+}
+
+void rtl8188e_start_thread(struct adapter *padapter)
+{
+}
+
+void rtl8188e_stop_thread(struct adapter *padapter)
+{
+}
+
+static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
+{
+	if (enable) {
+		DBG_88E("Enable notch filter\n");
+		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) | BIT1);
+	} else {
+		DBG_88E("Disable notch filter\n");
+		rtw_write8(adapter, rOFDM0_RxDSP+1, rtw_read8(adapter, rOFDM0_RxDSP+1) & ~BIT1);
+	}
+}
+void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
+{
+	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
+
+	pHalFunc->dm_init = &rtl8188e_init_dm_priv;
+	pHalFunc->dm_deinit = &rtl8188e_deinit_dm_priv;
+
+	pHalFunc->read_chip_version = &rtl8188e_read_chip_version;
+
+	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8188E;
+	pHalFunc->set_channel_handler = &PHY_SwChnl8188E;
+
+	pHalFunc->hal_dm_watchdog = &rtl8188e_HalDmWatchDog;
+
+	pHalFunc->Add_RateATid = &rtl8188e_Add_RateATid;
+	pHalFunc->run_thread = &rtl8188e_start_thread;
+	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
+
+	pHalFunc->AntDivBeforeLinkHandler = &AntDivBeforeLink8188E;
+	pHalFunc->AntDivCompareHandler = &AntDivCompare8188E;
+	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
+	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
+	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
+	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
+
+	/*  Efuse related function */
+	pHalFunc->EfusePowerSwitch = &rtl8188e_EfusePowerSwitch;
+	pHalFunc->ReadEFuse = &rtl8188e_ReadEFuse;
+	pHalFunc->EFUSEGetEfuseDefinition = &rtl8188e_EFUSE_GetEfuseDefinition;
+	pHalFunc->EfuseGetCurrentSize = &rtl8188e_EfuseGetCurrentSize;
+	pHalFunc->Efuse_PgPacketRead = &rtl8188e_Efuse_PgPacketRead;
+	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
+	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
+
+	pHalFunc->sreset_init_value = &sreset_init_value;
+	pHalFunc->sreset_reset_value = &sreset_reset_value;
+	pHalFunc->silentreset = &rtl8188e_silentreset_for_specific_platform;
+	pHalFunc->sreset_xmit_status_check = &rtl8188e_sreset_xmit_status_check;
+	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
+	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
+
+	pHalFunc->GetHalODMVarHandler = &rtl8188e_GetHalODMVar;
+	pHalFunc->SetHalODMVarHandler = &rtl8188e_SetHalODMVar;
+
+	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
+
+	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
+}
+
+u8 GetEEPROMSize8188E(struct adapter *padapter)
+{
+	u8 size = 0;
+	u32	cr;
+
+	cr = rtw_read16(padapter, REG_9346CR);
+	/*  6: EEPROM used is 93C46, 4: boot from E-Fuse. */
+	size = (cr & BOOT_FROM_EEPROM) ? 6 : 4;
+
+	MSG_88E("EEPROM type is %s\n", size == 4 ? "E-FUSE" : "93C46");
+
+	return size;
+}
+
+/*  */
+/*  */
+/*  LLT R/W/Init function */
+/*  */
+/*  */
+static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
+{
+	s32	status = _SUCCESS;
+	s32	count = 0;
+	u32	value = _LLT_INIT_ADDR(address) | _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
+	u16	LLTReg = REG_LLT_INIT;
+
+	rtw_write32(padapter, LLTReg, value);
+
+	/* polling */
+	do {
+		value = rtw_read32(padapter, LLTReg);
+		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
+			break;
+
+		if (count > POLLING_LLT_THRESHOLD) {
+			RT_TRACE(_module_hal_init_c_, _drv_err_, ("Failed to polling write LLT done at address %d!\n", address));
+			status = _FAIL;
+			break;
+		}
+	} while (count++);
+
+	return status;
+}
+
+s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
+{
+	s32	status = _FAIL;
+	u32	i;
+	u32	Last_Entry_Of_TxPktBuf = LAST_ENTRY_OF_TX_PKT_BUFFER;/*  176, 22k */
+
+	if (rtw_IOL_applied(padapter)) {
+		status = iol_InitLLTTable(padapter, txpktbuf_bndy);
+	} else {
+		for (i = 0; i < (txpktbuf_bndy - 1); i++) {
+			status = _LLTWrite(padapter, i, i + 1);
+			if (_SUCCESS != status)
+				return status;
+		}
+
+		/*  end of list */
+		status = _LLTWrite(padapter, (txpktbuf_bndy - 1), 0xFF);
+		if (_SUCCESS != status)
+			return status;
+
+		/*  Make the other pages as ring buffer */
+		/*  This ring buffer is used as beacon buffer if we config this MAC as two MAC transfer. */
+		/*  Otherwise used as local loopback buffer. */
+		for (i = txpktbuf_bndy; i < Last_Entry_Of_TxPktBuf; i++) {
+			status = _LLTWrite(padapter, i, (i + 1));
+			if (_SUCCESS != status)
+				return status;
+		}
+
+		/*  Let last entry point to the start entry of ring buffer */
+		status = _LLTWrite(padapter, Last_Entry_Of_TxPktBuf, txpktbuf_bndy);
+		if (_SUCCESS != status) {
+			return status;
+		}
+	}
+
+	return status;
+}
+
+void
+Hal_InitPGData88E(struct adapter *padapter)
+{
+	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
+
+	if (!pEEPROM->bautoload_fail_flag) { /*  autoload OK. */
+		if (!is_boot_from_eeprom(padapter)) {
+			/*  Read EFUSE real map to shadow. */
+			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+		}
+	} else {/* autoload fail */
+		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
+		/* update to default value 0xFF */
+		if (!is_boot_from_eeprom(padapter))
+			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
+	}
+}
+
+void
+Hal_EfuseParseIDCode88E(
+		struct adapter *padapter,
+		u8 *hwinfo
+	)
+{
+	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
+	u16			EEPROMId;
+
+	/*  Check 0x8129 again for making sure autoload status!! */
+	EEPROMId = le16_to_cpu(*((__le16 *)hwinfo));
+	if (EEPROMId != RTL_EEPROM_ID) {
+		pr_err("EEPROM ID(%#x) is invalid!!\n", EEPROMId);
+		pEEPROM->bautoload_fail_flag = true;
+	} else {
+		pEEPROM->bautoload_fail_flag = false;
+	}
+
+	pr_info("EEPROM ID = 0x%04x\n", EEPROMId);
+}
+
+static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G, u8 *PROMContent, bool AutoLoadFail)
+{
+	u32 rfPath, eeAddr = EEPROM_TX_PWR_INX_88E, group, TxCount = 0;
+
+	memset(pwrInfo24G, 0, sizeof(struct txpowerinfo24g));
+
+	if (AutoLoadFail) {
+		for (rfPath = 0; rfPath < RF_PATH_MAX; rfPath++) {
+			/* 2.4G default value */
+			for (group = 0; group < MAX_CHNL_GROUP_24G; group++) {
+				pwrInfo24G->IndexCCK_Base[rfPath][group] =	EEPROM_DEFAULT_24G_INDEX;
+				pwrInfo24G->IndexBW40_Base[rfPath][group] =	EEPROM_DEFAULT_24G_INDEX;
+			}
+			for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
+				if (TxCount == 0) {
+					pwrInfo24G->BW20_Diff[rfPath][0] = EEPROM_DEFAULT_24G_HT20_DIFF;
+					pwrInfo24G->OFDM_Diff[rfPath][0] = EEPROM_DEFAULT_24G_OFDM_DIFF;
+				} else {
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
+					pwrInfo24G->BW40_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
+					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
+				}
+			}
+		}
+		return;
+	}
+
+	for (rfPath = 0; rfPath < RF_PATH_MAX; rfPath++) {
+		/* 2.4G default value */
+		for (group = 0; group < MAX_CHNL_GROUP_24G; group++) {
+			pwrInfo24G->IndexCCK_Base[rfPath][group] =	PROMContent[eeAddr++];
+			if (pwrInfo24G->IndexCCK_Base[rfPath][group] == 0xFF)
+				pwrInfo24G->IndexCCK_Base[rfPath][group] = EEPROM_DEFAULT_24G_INDEX;
+		}
+		for (group = 0; group < MAX_CHNL_GROUP_24G-1; group++) {
+			pwrInfo24G->IndexBW40_Base[rfPath][group] =	PROMContent[eeAddr++];
+			if (pwrInfo24G->IndexBW40_Base[rfPath][group] == 0xFF)
+				pwrInfo24G->IndexBW40_Base[rfPath][group] =	EEPROM_DEFAULT_24G_INDEX;
+		}
+		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
+			if (TxCount == 0) {
+				pwrInfo24G->BW40_Diff[rfPath][TxCount] = 0;
+				if (PROMContent[eeAddr] == 0xFF) {
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] = EEPROM_DEFAULT_24G_HT20_DIFF;
+				} else {
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] = (PROMContent[eeAddr]&0xf0)>>4;
+					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
+				}
+
+				if (PROMContent[eeAddr] == 0xFF) {
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_24G_OFDM_DIFF;
+				} else {
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
+				}
+				pwrInfo24G->CCK_Diff[rfPath][TxCount] = 0;
+				eeAddr++;
+			} else {
+				if (PROMContent[eeAddr] == 0xFF) {
+					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
+				} else {
+					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
+					if (pwrInfo24G->BW40_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+						pwrInfo24G->BW40_Diff[rfPath][TxCount] |= 0xF0;
+				}
+
+				if (PROMContent[eeAddr] == 0xFF) {
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
+				} else {
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
+				}
+				eeAddr++;
+
+				if (PROMContent[eeAddr] == 0xFF) {
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
+				} else {
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
+					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
+				}
+
+				if (PROMContent[eeAddr] == 0xFF) {
+					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
+				} else {
+					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					if (pwrInfo24G->CCK_Diff[rfPath][TxCount] & BIT3)		/* 4bit sign number to 8 bit sign number */
+						pwrInfo24G->CCK_Diff[rfPath][TxCount] |= 0xF0;
+				}
+				eeAddr++;
+			}
+		}
+	}
+}
+
+static u8 Hal_GetChnlGroup88E(u8 chnl, u8 *pGroup)
+{
+	u8 bIn24G = true;
+
+	if (chnl <= 14) {
+		bIn24G = true;
+
+		if (chnl < 3)			/*  Channel 1-2 */
+			*pGroup = 0;
+		else if (chnl < 6)		/*  Channel 3-5 */
+			*pGroup = 1;
+		else	 if (chnl < 9)		/*  Channel 6-8 */
+			*pGroup = 2;
+		else if (chnl < 12)		/*  Channel 9-11 */
+			*pGroup = 3;
+		else if (chnl < 14)		/*  Channel 12-13 */
+			*pGroup = 4;
+		else if (chnl == 14)		/*  Channel 14 */
+			*pGroup = 5;
+	} else {
+		bIn24G = false;
+
+		if (chnl <= 40)
+			*pGroup = 0;
+		else if (chnl <= 48)
+			*pGroup = 1;
+		else	 if (chnl <= 56)
+			*pGroup = 2;
+		else if (chnl <= 64)
+			*pGroup = 3;
+		else if (chnl <= 104)
+			*pGroup = 4;
+		else if (chnl <= 112)
+			*pGroup = 5;
+		else if (chnl <= 120)
+			*pGroup = 5;
+		else if (chnl <= 128)
+			*pGroup = 6;
+		else if (chnl <= 136)
+			*pGroup = 7;
+		else if (chnl <= 144)
+			*pGroup = 8;
+		else if (chnl <= 153)
+			*pGroup = 9;
+		else if (chnl <= 161)
+			*pGroup = 10;
+		else if (chnl <= 177)
+			*pGroup = 11;
+	}
+	return bIn24G;
+}
+
+void Hal_ReadPowerSavingMode88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
+{
+	if (AutoLoadFail) {
+		padapter->pwrctrlpriv.bHWPowerdown = false;
+		padapter->pwrctrlpriv.bSupportRemoteWakeup = false;
+	} else {
+		/* hw power down mode selection , 0:rf-off / 1:power down */
+
+		if (padapter->registrypriv.hwpdn_mode == 2)
+			padapter->pwrctrlpriv.bHWPowerdown = (hwinfo[EEPROM_RF_FEATURE_OPTION_88E] & BIT4);
+		else
+			padapter->pwrctrlpriv.bHWPowerdown = padapter->registrypriv.hwpdn_mode;
+
+		/*  decide hw if support remote wakeup function */
+		/*  if hw supported, 8051 (SIE) will generate WeakUP signal(D+/D- toggle) when autoresume */
+		padapter->pwrctrlpriv.bSupportRemoteWakeup = (hwinfo[EEPROM_USB_OPTIONAL_FUNCTION0] & BIT1) ? true : false;
+
+		DBG_88E("%s...bHWPwrPindetect(%x)-bHWPowerdown(%x) , bSupportRemoteWakeup(%x)\n", __func__,
+		padapter->pwrctrlpriv.bHWPwrPindetect, padapter->pwrctrlpriv.bHWPowerdown , padapter->pwrctrlpriv.bSupportRemoteWakeup);
+
+		DBG_88E("### PS params =>  power_mgnt(%x), usbss_enable(%x) ###\n", padapter->registrypriv.power_mgnt, padapter->registrypriv.usbss_enable);
+	}
+}
+
+void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool AutoLoadFail)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	struct txpowerinfo24g pwrInfo24G;
+	u8 rfPath, ch, group;
+	u8 bIn24G, TxCount;
+
+	Hal_ReadPowerValueFromPROM_8188E(&pwrInfo24G, PROMContent, AutoLoadFail);
+
+	if (!AutoLoadFail)
+		pHalData->bTXPowerDataReadFromEEPORM = true;
+
+	for (rfPath = 0; rfPath < pHalData->NumTotalRFPath; rfPath++) {
+		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
+			bIn24G = Hal_GetChnlGroup88E(ch, &group);
+			if (bIn24G) {
+				pHalData->Index24G_CCK_Base[rfPath][ch] = pwrInfo24G.IndexCCK_Base[rfPath][group];
+				if (ch == 14)
+					pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][4];
+				else
+					pHalData->Index24G_BW40_Base[rfPath][ch] = pwrInfo24G.IndexBW40_Base[rfPath][group];
+			}
+			if (bIn24G) {
+				DBG_88E("======= Path %d, Channel %d =======\n", rfPath, ch);
+				DBG_88E("Index24G_CCK_Base[%d][%d] = 0x%x\n", rfPath, ch , pHalData->Index24G_CCK_Base[rfPath][ch]);
+				DBG_88E("Index24G_BW40_Base[%d][%d] = 0x%x\n", rfPath, ch , pHalData->Index24G_BW40_Base[rfPath][ch]);
+			}
+		}
+		for (TxCount = 0; TxCount < MAX_TX_COUNT; TxCount++) {
+			pHalData->CCK_24G_Diff[rfPath][TxCount] = pwrInfo24G.CCK_Diff[rfPath][TxCount];
+			pHalData->OFDM_24G_Diff[rfPath][TxCount] = pwrInfo24G.OFDM_Diff[rfPath][TxCount];
+			pHalData->BW20_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW20_Diff[rfPath][TxCount];
+			pHalData->BW40_24G_Diff[rfPath][TxCount] = pwrInfo24G.BW40_Diff[rfPath][TxCount];
+			DBG_88E("======= TxCount %d =======\n", TxCount);
+			DBG_88E("CCK_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->CCK_24G_Diff[rfPath][TxCount]);
+			DBG_88E("OFDM_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->OFDM_24G_Diff[rfPath][TxCount]);
+			DBG_88E("BW20_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->BW20_24G_Diff[rfPath][TxCount]);
+			DBG_88E("BW40_24G_Diff[%d][%d] = %d\n", rfPath, TxCount, pHalData->BW40_24G_Diff[rfPath][TxCount]);
+		}
+	}
+
+	/*  2010/10/19 MH Add Regulator recognize for CU. */
+	if (!AutoLoadFail) {
+		pHalData->EEPROMRegulatory = (PROMContent[EEPROM_RF_BOARD_OPTION_88E]&0x7);	/* bit0~2 */
+		if (PROMContent[EEPROM_RF_BOARD_OPTION_88E] == 0xFF)
+			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION&0x7);	/* bit0~2 */
+	} else {
+		pHalData->EEPROMRegulatory = 0;
+	}
+	DBG_88E("EEPROMRegulatory = 0x%x\n", pHalData->EEPROMRegulatory);
+}
+
+void Hal_EfuseParseXtal_8188E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+
+	if (!AutoLoadFail) {
+		pHalData->CrystalCap = hwinfo[EEPROM_XTAL_88E];
+		if (pHalData->CrystalCap == 0xFF)
+			pHalData->CrystalCap = EEPROM_Default_CrystalCap_88E;
+	} else {
+		pHalData->CrystalCap = EEPROM_Default_CrystalCap_88E;
+	}
+	DBG_88E("CrystalCap: 0x%2x\n", pHalData->CrystalCap);
+}
+
+void Hal_EfuseParseBoardType88E(struct adapter *pAdapter, u8 *hwinfo, bool AutoLoadFail)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(pAdapter);
+
+	if (!AutoLoadFail)
+		pHalData->BoardType = ((hwinfo[EEPROM_RF_BOARD_OPTION_88E]&0xE0)>>5);
+	else
+		pHalData->BoardType = 0;
+	DBG_88E("Board Type: 0x%2x\n", pHalData->BoardType);
+}
+
+void Hal_EfuseParseEEPROMVer88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+
+	if (!AutoLoadFail) {
+		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_88E];
+		if (pHalData->EEPROMVersion == 0xFF)
+			pHalData->EEPROMVersion = EEPROM_Default_Version;
+	} else {
+		pHalData->EEPROMVersion = 1;
+	}
+	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
+		 ("Hal_EfuseParseEEPROMVer(), EEVer = %d\n",
+		 pHalData->EEPROMVersion));
+}
+
+void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
+{
+	padapter->mlmepriv.ChannelPlan =
+		 hal_com_get_channel_plan(padapter,
+					  hwinfo ? hwinfo[EEPROM_ChannelPlan_88E] : 0xFF,
+					  padapter->registrypriv.channel_plan,
+					  RT_CHANNEL_DOMAIN_WORLD_WIDE_13, AutoLoadFail);
+
+	DBG_88E("mlmepriv.ChannelPlan = 0x%02x\n", padapter->mlmepriv.ChannelPlan);
+}
+
+void Hal_EfuseParseCustomerID88E(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+
+	if (!AutoLoadFail) {
+		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CUSTOMERID_88E];
+	} else {
+		pHalData->EEPROMCustomerID = 0;
+		pHalData->EEPROMSubCustomerID = 0;
+	}
+	DBG_88E("EEPROM Customer ID: 0x%2x\n", pHalData->EEPROMCustomerID);
+}
+
+void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool AutoLoadFail)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct registry_priv	*registry_par = &pAdapter->registrypriv;
+
+	if (!AutoLoadFail) {
+		/*  Antenna Diversity setting. */
+		if (registry_par->antdiv_cfg == 2) { /*  2:By EFUSE */
+			pHalData->AntDivCfg = (PROMContent[EEPROM_RF_BOARD_OPTION_88E]&0x18)>>3;
+			if (PROMContent[EEPROM_RF_BOARD_OPTION_88E] == 0xFF)
+				pHalData->AntDivCfg = (EEPROM_DEFAULT_BOARD_OPTION&0x18)>>3;;
+		} else {
+			pHalData->AntDivCfg = registry_par->antdiv_cfg;  /*  0:OFF , 1:ON, 2:By EFUSE */
+		}
+
+		if (registry_par->antdiv_type == 0) {
+			/* If TRxAntDivType is AUTO in advanced setting, use EFUSE value instead. */
+			pHalData->TRxAntDivType = PROMContent[EEPROM_RF_ANTENNA_OPT_88E];
+			if (pHalData->TRxAntDivType == 0xFF)
+				pHalData->TRxAntDivType = CG_TRX_HW_ANTDIV; /*  For 88EE, 1Tx and 1RxCG are fixed.(1Ant, Tx and RxCG are both on aux port) */
+		} else {
+			pHalData->TRxAntDivType = registry_par->antdiv_type;
+		}
+
+		if (pHalData->TRxAntDivType == CG_TRX_HW_ANTDIV || pHalData->TRxAntDivType == CGCS_RX_HW_ANTDIV)
+			pHalData->AntDivCfg = 1; /*  0xC1[3] is ignored. */
+	} else {
+		pHalData->AntDivCfg = 0;
+		pHalData->TRxAntDivType = pHalData->TRxAntDivType; /*  The value in the driver setting of device manager. */
+	}
+	DBG_88E("EEPROM : AntDivCfg = %x, TRxAntDivType = %x\n", pHalData->AntDivCfg, pHalData->TRxAntDivType);
+}
+
+void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+
+	/*  ThermalMeter from EEPROM */
+	if (!AutoloadFail)
+		pHalData->EEPROMThermalMeter = PROMContent[EEPROM_THERMAL_METER_88E];
+	else
+		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
+
+	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
+		pHalData->bAPKThermalMeterIgnore = true;
+		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
+	}
+	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
+}
+
+void Hal_InitChannelPlan(struct adapter *padapter)
+{
+}
+
+bool HalDetectPwrDownMode88E(struct adapter *Adapter)
+{
+	u8 tmpvalue = 0;
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
+
+	EFUSE_ShadowRead(Adapter, 1, EEPROM_RF_FEATURE_OPTION_88E, (u32 *)&tmpvalue);
+
+	/*  2010/08/25 MH INF priority > PDN Efuse value. */
+	if (tmpvalue & BIT(4) && pwrctrlpriv->reg_pdnmode)
+		pHalData->pwrdown = true;
+	else
+		pHalData->pwrdown = false;
+
+	DBG_88E("HalDetectPwrDownMode(): PDN =%d\n", pHalData->pwrdown);
+
+	return pHalData->pwrdown;
+}	/*  HalDetectPwrDownMode */
+
+/*  This function is used only for 92C to set REG_BCN_CTRL(0x550) register. */
+/*  We just reserve the value of the register in variable pHalData->RegBcnCtrlVal and then operate */
+/*  the value of the register via atomic operation. */
+/*  This prevents from race condition when setting this register. */
+/*  The value of pHalData->RegBcnCtrlVal is initialized in HwConfigureRTL8192CE() function. */
+
+void SetBcnCtrlReg(struct adapter *padapter, u8 SetBits, u8 ClearBits)
+{
+	struct hal_data_8188e *pHalData;
+
+	pHalData = GET_HAL_DATA(padapter);
+
+	pHalData->RegBcnCtrlVal |= SetBits;
+	pHalData->RegBcnCtrlVal &= ~ClearBits;
+
+	rtw_write8(padapter, REG_BCN_CTRL, (u8)pHalData->RegBcnCtrlVal);
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_mp.c b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
new file mode 100644
index 000000000000..66388902ab94
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_mp.c
@@ -0,0 +1,851 @@
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
+#define _RTL8188E_MP_C_
+
+#include <drv_types.h>
+#include <rtw_mp.h>
+#include <rtl8188e_hal.h>
+#include <rtl8188e_dm.h>
+
+s32 Hal_SetPowerTracking(struct adapter *padapter, u8 enable)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+
+	if (!netif_running(padapter->pnetdev)) {
+		RT_TRACE(_module_mp_, _drv_warning_,
+			 ("SetPowerTracking! Fail: interface not opened!\n"));
+		return _FAIL;
+	}
+
+	if (!check_fwstate(&padapter->mlmepriv, WIFI_MP_STATE)) {
+		RT_TRACE(_module_mp_, _drv_warning_,
+			 ("SetPowerTracking! Fail: not in MP mode!\n"));
+		return _FAIL;
+	}
+
+	if (enable)
+		pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
+	else
+		pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = false;
+
+	return _SUCCESS;
+}
+
+void Hal_GetPowerTracking(struct adapter *padapter, u8 *enable)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+
+	*enable = pDM_Odm->RFCalibrateInfo.TxPowerTrackControl;
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:	mpt_SwitchRfSetting
+ *
+ * Overview:	Change RF Setting when we siwthc channel/rate/BW for MP.
+ *
+ * Input:	struct adapter *				pAdapter
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Revised History:
+ * When			Who		Remark
+ * 01/08/2009	MHC		Suggestion from SD3 Willis for 92S series.
+ * 01/09/2009	MHC		Add CCK modification for 40MHZ. Suggestion from SD3.
+ *
+ *---------------------------------------------------------------------------*/
+void Hal_mpt_SwitchRfSetting(struct adapter *pAdapter)
+{
+	struct mp_priv	*pmp = &pAdapter->mppriv;
+
+	/*  <20120525, Kordan> Dynamic mechanism for APK, asked by Dennis. */
+		pmp->MptCtx.backup0x52_RF_A = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0);
+		pmp->MptCtx.backup0x52_RF_B = (u8)PHY_QueryRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0);
+		PHY_SetRFReg(pAdapter, RF_PATH_A, RF_0x52, 0x000F0, 0xD);
+		PHY_SetRFReg(pAdapter, RF_PATH_B, RF_0x52, 0x000F0, 0xD);
+
+	return;
+}
+/*---------------------------hal\rtl8192c\MPT_Phy.c---------------------------*/
+
+/*---------------------------hal\rtl8192c\MPT_HelperFunc.c---------------------------*/
+void Hal_MPT_CCKTxPowerAdjust(struct adapter *Adapter, bool bInCH14)
+{
+	u32		TempVal = 0, TempVal2 = 0, TempVal3 = 0;
+	u32		CurrCCKSwingVal = 0, CCKSwingIndex = 12;
+	u8		i;
+
+	/*  get current cck swing value and check 0xa22 & 0xa23 later to match the table. */
+	CurrCCKSwingVal = read_bbreg(Adapter, rCCK0_TxFilter1, bMaskHWord);
+
+	if (!bInCH14) {
+		/*  Readback the current bb cck swing value and compare with the table to */
+		/*  get the current swing index */
+		for (i = 0; i < CCK_TABLE_SIZE; i++) {
+			if (((CurrCCKSwingVal&0xff) == (u32)CCKSwingTable_Ch1_Ch13[i][0]) &&
+			    (((CurrCCKSwingVal&0xff00)>>8) == (u32)CCKSwingTable_Ch1_Ch13[i][1])) {
+				CCKSwingIndex = i;
+				break;
+			}
+		}
+
+		/* Write 0xa22 0xa23 */
+		TempVal = CCKSwingTable_Ch1_Ch13[CCKSwingIndex][0] +
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][1]<<8);
+
+		/* Write 0xa24 ~ 0xa27 */
+		TempVal2 = 0;
+		TempVal2 = CCKSwingTable_Ch1_Ch13[CCKSwingIndex][2] +
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][3]<<8) +
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][4]<<16)+
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][5]<<24);
+
+		/* Write 0xa28  0xa29 */
+		TempVal3 = 0;
+		TempVal3 = CCKSwingTable_Ch1_Ch13[CCKSwingIndex][6] +
+				(CCKSwingTable_Ch1_Ch13[CCKSwingIndex][7]<<8);
+	} else {
+		for (i = 0; i < CCK_TABLE_SIZE; i++) {
+			if (((CurrCCKSwingVal&0xff) == (u32)CCKSwingTable_Ch14[i][0]) &&
+			    (((CurrCCKSwingVal&0xff00)>>8) == (u32)CCKSwingTable_Ch14[i][1])) {
+				CCKSwingIndex = i;
+				break;
+			}
+		}
+
+		/* Write 0xa22 0xa23 */
+		TempVal = CCKSwingTable_Ch14[CCKSwingIndex][0] +
+				(CCKSwingTable_Ch14[CCKSwingIndex][1]<<8);
+
+		/* Write 0xa24 ~ 0xa27 */
+		TempVal2 = 0;
+		TempVal2 = CCKSwingTable_Ch14[CCKSwingIndex][2] +
+				(CCKSwingTable_Ch14[CCKSwingIndex][3]<<8) +
+				(CCKSwingTable_Ch14[CCKSwingIndex][4]<<16)+
+				(CCKSwingTable_Ch14[CCKSwingIndex][5]<<24);
+
+		/* Write 0xa28  0xa29 */
+		TempVal3 = 0;
+		TempVal3 = CCKSwingTable_Ch14[CCKSwingIndex][6] +
+				(CCKSwingTable_Ch14[CCKSwingIndex][7]<<8);
+	}
+
+	write_bbreg(Adapter, rCCK0_TxFilter1, bMaskHWord, TempVal);
+	write_bbreg(Adapter, rCCK0_TxFilter2, bMaskDWord, TempVal2);
+	write_bbreg(Adapter, rCCK0_DebugPort, bMaskLWord, TempVal3);
+}
+
+void Hal_MPT_CCKTxPowerAdjustbyIndex(struct adapter *pAdapter, bool beven)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct mpt_context *pMptCtx = &pAdapter->mppriv.MptCtx;
+	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+	s32		TempCCk;
+	u8		CCK_index, CCK_index_old = 0;
+	u8		Action = 0;	/* 0: no action, 1: even->odd, 2:odd->even */
+	s32		i = 0;
+
+	if (!IS_92C_SERIAL(pHalData->VersionID))
+		return;
+	if (beven && !pMptCtx->bMptIndexEven) {
+		/* odd->even */
+		Action = 2;
+		pMptCtx->bMptIndexEven = true;
+	} else if (!beven && pMptCtx->bMptIndexEven) {
+		/* even->odd */
+		Action = 1;
+		pMptCtx->bMptIndexEven = false;
+	}
+
+	if (Action != 0) {
+		/* Query CCK default setting From 0xa24 */
+		TempCCk = read_bbreg(pAdapter, rCCK0_TxFilter2, bMaskDWord) & bMaskCCK;
+		for (i = 0; i < CCK_TABLE_SIZE; i++) {
+			if (pDM_Odm->RFCalibrateInfo.bCCKinCH14) {
+				if (!memcmp((void *)&TempCCk, (void *)&CCKSwingTable_Ch14[i][2], 4)) {
+					CCK_index_old = (u8)i;
+					break;
+				}
+			} else {
+				if (!memcmp((void *)&TempCCk, (void *)&CCKSwingTable_Ch1_Ch13[i][2], 4)) {
+					CCK_index_old = (u8)i;
+					break;
+				}
+			}
+		}
+
+		if (Action == 1)
+			CCK_index = CCK_index_old - 1;
+		else
+			CCK_index = CCK_index_old + 1;
+
+		/* Adjust CCK according to gain index */
+		if (!pDM_Odm->RFCalibrateInfo.bCCKinCH14) {
+			rtw_write8(pAdapter, 0xa22, CCKSwingTable_Ch1_Ch13[CCK_index][0]);
+			rtw_write8(pAdapter, 0xa23, CCKSwingTable_Ch1_Ch13[CCK_index][1]);
+			rtw_write8(pAdapter, 0xa24, CCKSwingTable_Ch1_Ch13[CCK_index][2]);
+			rtw_write8(pAdapter, 0xa25, CCKSwingTable_Ch1_Ch13[CCK_index][3]);
+			rtw_write8(pAdapter, 0xa26, CCKSwingTable_Ch1_Ch13[CCK_index][4]);
+			rtw_write8(pAdapter, 0xa27, CCKSwingTable_Ch1_Ch13[CCK_index][5]);
+			rtw_write8(pAdapter, 0xa28, CCKSwingTable_Ch1_Ch13[CCK_index][6]);
+			rtw_write8(pAdapter, 0xa29, CCKSwingTable_Ch1_Ch13[CCK_index][7]);
+		} else {
+			rtw_write8(pAdapter, 0xa22, CCKSwingTable_Ch14[CCK_index][0]);
+			rtw_write8(pAdapter, 0xa23, CCKSwingTable_Ch14[CCK_index][1]);
+			rtw_write8(pAdapter, 0xa24, CCKSwingTable_Ch14[CCK_index][2]);
+			rtw_write8(pAdapter, 0xa25, CCKSwingTable_Ch14[CCK_index][3]);
+			rtw_write8(pAdapter, 0xa26, CCKSwingTable_Ch14[CCK_index][4]);
+			rtw_write8(pAdapter, 0xa27, CCKSwingTable_Ch14[CCK_index][5]);
+			rtw_write8(pAdapter, 0xa28, CCKSwingTable_Ch14[CCK_index][6]);
+			rtw_write8(pAdapter, 0xa29, CCKSwingTable_Ch14[CCK_index][7]);
+		}
+	}
+}
+/*---------------------------hal\rtl8192c\MPT_HelperFunc.c---------------------------*/
+
+/*
+ * SetChannel
+ * Description
+ *	Use H2C command to change channel,
+ *	not only modify rf register, but also other setting need to be done.
+ */
+void Hal_SetChannel(struct adapter *pAdapter)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	struct mp_priv	*pmp = &pAdapter->mppriv;
+	struct odm_dm_struct *pDM_Odm = &(pHalData->odmpriv);
+	u8		eRFPath;
+	u8		channel = pmp->channel;
+
+	/*  set RF channel register */
+	for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
+		_write_rfreg(pAdapter, eRFPath, ODM_CHANNEL, 0x3FF, channel);
+	Hal_mpt_SwitchRfSetting(pAdapter);
+
+	SelectChannel(pAdapter, channel);
+
+	if (pHalData->CurrentChannel == 14 && !pDM_Odm->RFCalibrateInfo.bCCKinCH14) {
+		pDM_Odm->RFCalibrateInfo.bCCKinCH14 = true;
+		Hal_MPT_CCKTxPowerAdjust(pAdapter, pDM_Odm->RFCalibrateInfo.bCCKinCH14);
+	} else if (pHalData->CurrentChannel != 14 && pDM_Odm->RFCalibrateInfo.bCCKinCH14) {
+		pDM_Odm->RFCalibrateInfo.bCCKinCH14 = false;
+		Hal_MPT_CCKTxPowerAdjust(pAdapter, pDM_Odm->RFCalibrateInfo.bCCKinCH14);
+	}
+}
+
+/*
+ * Notice
+ *	Switch bandwitdth may change center frequency(channel)
+ */
+void Hal_SetBandwidth(struct adapter *pAdapter)
+{
+	struct mp_priv *pmp = &pAdapter->mppriv;
+
+	SetBWMode(pAdapter, pmp->bandwidth, pmp->prime_channel_offset);
+	Hal_mpt_SwitchRfSetting(pAdapter);
+}
+
+void Hal_SetCCKTxPower(struct adapter *pAdapter, u8 *TxPower)
+{
+	u32 tmpval = 0;
+
+	/*  rf-A cck tx power */
+	write_bbreg(pAdapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, TxPower[RF_PATH_A]);
+	tmpval = (TxPower[RF_PATH_A]<<16) | (TxPower[RF_PATH_A]<<8) | TxPower[RF_PATH_A];
+	write_bbreg(pAdapter, rTxAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
+
+	/*  rf-B cck tx power */
+	write_bbreg(pAdapter, rTxAGC_B_CCK11_A_CCK2_11, bMaskByte0, TxPower[RF_PATH_B]);
+	tmpval = (TxPower[RF_PATH_B]<<16) | (TxPower[RF_PATH_B]<<8) | TxPower[RF_PATH_B];
+	write_bbreg(pAdapter, rTxAGC_B_CCK1_55_Mcs32, 0xffffff00, tmpval);
+
+	RT_TRACE(_module_mp_, _drv_notice_,
+		 ("-SetCCKTxPower: A[0x%02x] B[0x%02x]\n",
+		  TxPower[RF_PATH_A], TxPower[RF_PATH_B]));
+}
+
+void Hal_SetOFDMTxPower(struct adapter *pAdapter, u8 *TxPower)
+{
+	u32 TxAGC = 0;
+	u8 tmpval = 0;
+
+	/*  HT Tx-rf(A) */
+	tmpval = TxPower[RF_PATH_A];
+	TxAGC = (tmpval<<24) | (tmpval<<16) | (tmpval<<8) | tmpval;
+
+	write_bbreg(pAdapter, rTxAGC_A_Rate18_06, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_A_Rate54_24, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_A_Mcs03_Mcs00, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_A_Mcs07_Mcs04, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_A_Mcs11_Mcs08, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_A_Mcs15_Mcs12, bMaskDWord, TxAGC);
+
+	/*  HT Tx-rf(B) */
+	tmpval = TxPower[RF_PATH_B];
+	TxAGC = (tmpval<<24) | (tmpval<<16) | (tmpval<<8) | tmpval;
+
+	write_bbreg(pAdapter, rTxAGC_B_Rate18_06, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_B_Rate54_24, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_B_Mcs03_Mcs00, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_B_Mcs07_Mcs04, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_B_Mcs11_Mcs08, bMaskDWord, TxAGC);
+	write_bbreg(pAdapter, rTxAGC_B_Mcs15_Mcs12, bMaskDWord, TxAGC);
+}
+
+void Hal_SetAntennaPathPower(struct adapter *pAdapter)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(pAdapter);
+	u8 TxPowerLevel[RF_PATH_MAX];
+	u8 rfPath;
+
+	TxPowerLevel[RF_PATH_A] = pAdapter->mppriv.txpoweridx;
+	TxPowerLevel[RF_PATH_B] = pAdapter->mppriv.txpoweridx_b;
+
+	switch (pAdapter->mppriv.antenna_tx) {
+	case ANTENNA_A:
+	default:
+		rfPath = RF_PATH_A;
+		break;
+	case ANTENNA_B:
+		rfPath = RF_PATH_B;
+		break;
+	case ANTENNA_C:
+		rfPath = RF_PATH_C;
+		break;
+	}
+
+	switch (pHalData->rf_chip) {
+	case RF_8225:
+	case RF_8256:
+	case RF_6052:
+		Hal_SetCCKTxPower(pAdapter, TxPowerLevel);
+		if (pAdapter->mppriv.rateidx < MPT_RATE_6M)	/*  CCK rate */
+			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath]%2 == 0);
+		Hal_SetOFDMTxPower(pAdapter, TxPowerLevel);
+		break;
+	default:
+		break;
+	}
+}
+
+void Hal_SetTxPower(struct adapter *pAdapter)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(pAdapter);
+	u8 TxPower = pAdapter->mppriv.txpoweridx;
+	u8 TxPowerLevel[RF_PATH_MAX];
+	u8 rf, rfPath;
+
+	for (rf = 0; rf < RF_PATH_MAX; rf++)
+		TxPowerLevel[rf] = TxPower;
+
+	switch (pAdapter->mppriv.antenna_tx) {
+	case ANTENNA_A:
+	default:
+		rfPath = RF_PATH_A;
+		break;
+	case ANTENNA_B:
+		rfPath = RF_PATH_B;
+		break;
+	case ANTENNA_C:
+		rfPath = RF_PATH_C;
+		break;
+	}
+
+	switch (pHalData->rf_chip) {
+	/*  2008/09/12 MH Test only !! We enable the TX power tracking for MP!!!!! */
+	/*  We should call normal driver API later!! */
+	case RF_8225:
+	case RF_8256:
+	case RF_6052:
+		Hal_SetCCKTxPower(pAdapter, TxPowerLevel);
+		if (pAdapter->mppriv.rateidx < MPT_RATE_6M)	/*  CCK rate */
+			Hal_MPT_CCKTxPowerAdjustbyIndex(pAdapter, TxPowerLevel[rfPath]%2 == 0);
+		Hal_SetOFDMTxPower(pAdapter, TxPowerLevel);
+		break;
+	default:
+		break;
+	}
+}
+
+void Hal_SetDataRate(struct adapter *pAdapter)
+{
+	Hal_mpt_SwitchRfSetting(pAdapter);
+}
+
+void Hal_SetAntenna(struct adapter *pAdapter)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+
+	struct ant_sel_ofdm *p_ofdm_tx;	/* OFDM Tx register */
+	struct ant_sel_cck *p_cck_txrx;
+	u8	r_rx_antenna_ofdm = 0, r_ant_select_cck_val = 0;
+	u8	chgTx = 0, chgRx = 0;
+	u32	r_ant_select_ofdm_val = 0, r_ofdm_tx_en_val = 0;
+
+	p_ofdm_tx = (struct ant_sel_ofdm *)&r_ant_select_ofdm_val;
+	p_cck_txrx = (struct ant_sel_cck *)&r_ant_select_cck_val;
+
+	p_ofdm_tx->r_ant_ht1	= 0x1;
+	p_ofdm_tx->r_ant_ht2	= 0x2;	/*  Second TX RF path is A */
+	p_ofdm_tx->r_ant_non_ht = 0x3;	/*  0x1+0x2=0x3 */
+
+	switch (pAdapter->mppriv.antenna_tx) {
+	case ANTENNA_A:
+		p_ofdm_tx->r_tx_antenna		= 0x1;
+		r_ofdm_tx_en_val		= 0x1;
+		p_ofdm_tx->r_ant_l		= 0x1;
+		p_ofdm_tx->r_ant_ht_s1		= 0x1;
+		p_ofdm_tx->r_ant_non_ht_s1	= 0x1;
+		p_cck_txrx->r_ccktx_enable	= 0x8;
+		chgTx = 1;
+
+		/*  From SD3 Willis suggestion !!! Set RF A=TX and B as standby */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 2);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 1);
+		r_ofdm_tx_en_val		= 0x3;
+
+		/*  Power save */
+
+		/*  We need to close RFB by SW control */
+		if (pHalData->rf_type == RF_2T2R) {
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT10, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT26, 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XB_RFInterfaceOE, BIT10, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT1, 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT17, 0);
+		}
+		break;
+	case ANTENNA_B:
+		p_ofdm_tx->r_tx_antenna		= 0x2;
+		r_ofdm_tx_en_val		= 0x2;
+		p_ofdm_tx->r_ant_l		= 0x2;
+		p_ofdm_tx->r_ant_ht_s1		= 0x2;
+		p_ofdm_tx->r_ant_non_ht_s1	= 0x2;
+		p_cck_txrx->r_ccktx_enable	= 0x4;
+		chgTx = 1;
+		/*  From SD3 Willis suggestion !!! Set RF A as standby */
+		PHY_SetBBReg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 1);
+		PHY_SetBBReg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 2);
+
+		/*  Power save */
+		/* cosa r_ant_select_ofdm_val = 0x22222222; */
+
+		/*  2008/10/31 MH From SD3 Willi's suggestion. We must read RF 1T table. */
+		/*  2009/01/08 MH From Sd3 Willis. We need to close RFA by SW control */
+		if (pHalData->rf_type == RF_2T2R || pHalData->rf_type == RF_1T2R) {
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT10, 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XA_RFInterfaceOE, BIT10, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT26, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT1, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT17, 1);
+		}
+		break;
+	case ANTENNA_AB:	/*  For 8192S */
+		p_ofdm_tx->r_tx_antenna		= 0x3;
+		r_ofdm_tx_en_val		= 0x3;
+		p_ofdm_tx->r_ant_l		= 0x3;
+		p_ofdm_tx->r_ant_ht_s1		= 0x3;
+		p_ofdm_tx->r_ant_non_ht_s1	= 0x3;
+		p_cck_txrx->r_ccktx_enable	= 0xC;
+		chgTx = 1;
+
+		/*  From SD3 Willis suggestion !!! Set RF B as standby */
+		PHY_SetBBReg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 2);
+		PHY_SetBBReg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 2);
+
+		/*  Disable Power save */
+		/* cosa r_ant_select_ofdm_val = 0x3321333; */
+		/*  2009/01/08 MH From Sd3 Willis. We need to enable RFA/B by SW control */
+		if (pHalData->rf_type == RF_2T2R) {
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT10, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFInterfaceSW, BIT26, 0);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT1, 1);
+			PHY_SetBBReg(pAdapter, rFPGA0_XAB_RFParameter, BIT17, 1);
+		}
+		break;
+	default:
+		break;
+	}
+
+	/*  r_rx_antenna_ofdm, bit0=A, bit1=B, bit2=C, bit3=D */
+	/*  r_cckrx_enable : CCK default, 0=A, 1=B, 2=C, 3=D */
+	/*  r_cckrx_enable_2 : CCK option, 0=A, 1=B, 2=C, 3=D */
+	switch (pAdapter->mppriv.antenna_rx) {
+	case ANTENNA_A:
+		r_rx_antenna_ofdm		= 0x1;	/*  A */
+		p_cck_txrx->r_cckrx_enable	= 0x0;	/*  default: A */
+		p_cck_txrx->r_cckrx_enable_2	= 0x0;	/*  option: A */
+		chgRx = 1;
+		break;
+	case ANTENNA_B:
+		r_rx_antenna_ofdm		= 0x2;	/*  B */
+		p_cck_txrx->r_cckrx_enable	= 0x1;	/*  default: B */
+		p_cck_txrx->r_cckrx_enable_2	= 0x1;	/*  option: B */
+		chgRx = 1;
+		break;
+	case ANTENNA_AB:
+		r_rx_antenna_ofdm		= 0x3;	/*  AB */
+		p_cck_txrx->r_cckrx_enable	= 0x0;	/*  default:A */
+		p_cck_txrx->r_cckrx_enable_2	= 0x1;	/*  option:B */
+		chgRx = 1;
+		break;
+	default:
+		break;
+	}
+
+	if (chgTx && chgRx) {
+		switch (pHalData->rf_chip) {
+		case RF_8225:
+		case RF_8256:
+		case RF_6052:
+			/* r_ant_sel_cck_val = r_ant_select_cck_val; */
+			PHY_SetBBReg(pAdapter, rFPGA1_TxInfo, 0x7fffffff, r_ant_select_ofdm_val);	/* OFDM Tx */
+			PHY_SetBBReg(pAdapter, rFPGA0_TxInfo, 0x0000000f, r_ofdm_tx_en_val);		/* OFDM Tx */
+			PHY_SetBBReg(pAdapter, rOFDM0_TRxPathEnable, 0x0000000f, r_rx_antenna_ofdm);	/* OFDM Rx */
+			PHY_SetBBReg(pAdapter, rOFDM1_TRxPathEnable, 0x0000000f, r_rx_antenna_ofdm);	/* OFDM Rx */
+			PHY_SetBBReg(pAdapter, rCCK0_AFESetting, bMaskByte3, r_ant_select_cck_val);	/* CCK TxRx */
+
+			break;
+		default:
+			break;
+		}
+	}
+
+	RT_TRACE(_module_mp_, _drv_notice_, ("-SwitchAntenna: finished\n"));
+}
+
+s32 Hal_SetThermalMeter(struct adapter *pAdapter, u8 target_ther)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(pAdapter);
+
+	if (!netif_running(pAdapter->pnetdev)) {
+		RT_TRACE(_module_mp_, _drv_warning_, ("SetThermalMeter! Fail: interface not opened!\n"));
+		return _FAIL;
+	}
+
+	if (check_fwstate(&pAdapter->mlmepriv, WIFI_MP_STATE) == false) {
+		RT_TRACE(_module_mp_, _drv_warning_, ("SetThermalMeter: Fail! not in MP mode!\n"));
+		return _FAIL;
+	}
+
+	target_ther &= 0xff;
+	if (target_ther < 0x07)
+		target_ther = 0x07;
+	else if (target_ther > 0x1d)
+		target_ther = 0x1d;
+
+	pHalData->EEPROMThermalMeter = target_ther;
+
+	return _SUCCESS;
+}
+
+void Hal_TriggerRFThermalMeter(struct adapter *pAdapter)
+{
+	_write_rfreg(pAdapter, RF_PATH_A , RF_T_METER_88E , BIT17 | BIT16 , 0x03);
+}
+
+u8 Hal_ReadRFThermalMeter(struct adapter *pAdapter)
+{
+	u32 ThermalValue = 0;
+
+	ThermalValue = _read_rfreg(pAdapter, RF_PATH_A, RF_T_METER_88E, 0xfc00);
+	return (u8)ThermalValue;
+}
+
+void Hal_GetThermalMeter(struct adapter *pAdapter, u8 *value)
+{
+	Hal_TriggerRFThermalMeter(pAdapter);
+	rtw_msleep_os(1000);
+	*value = Hal_ReadRFThermalMeter(pAdapter);
+}
+
+void Hal_SetSingleCarrierTx(struct adapter *pAdapter, u8 bStart)
+{
+	pAdapter->mppriv.MptCtx.bSingleCarrier = bStart;
+	if (bStart) {
+		/*  Start Single Carrier. */
+		RT_TRACE(_module_mp_, _drv_alert_, ("SetSingleCarrierTx: test start\n"));
+		/*  1. if OFDM block on? */
+		if (!read_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn))
+			write_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn, bEnable);/* set OFDM block on */
+
+		/*  2. set CCK test mode off, set to CCK normal mode */
+		write_bbreg(pAdapter, rCCK0_System, bCCKBBMode, bDisable);
+		/*  3. turn on scramble setting */
+		write_bbreg(pAdapter, rCCK0_System, bCCKScramble, bEnable);
+		/*  4. Turn On Single Carrier Tx and turn off the other test modes. */
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bEnable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
+		/* for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000500);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000500);
+	} else {
+		/*  Stop Single Carrier. */
+		RT_TRACE(_module_mp_, _drv_alert_, ("SetSingleCarrierTx: test stop\n"));
+
+		/*  Turn off all test modes. */
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
+		rtw_msleep_os(10);
+
+		/* BB Reset */
+		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
+		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
+
+		/* Stop for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000100);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000100);
+	}
+}
+
+void Hal_SetSingleToneTx(struct adapter *pAdapter, u8 bStart)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(pAdapter);
+	bool		is92C = IS_92C_SERIAL(pHalData->VersionID);
+
+	u8 rfPath;
+	u32              reg58 = 0x0;
+	switch (pAdapter->mppriv.antenna_tx) {
+	case ANTENNA_A:
+	default:
+		rfPath = RF_PATH_A;
+		break;
+	case ANTENNA_B:
+		rfPath = RF_PATH_B;
+		break;
+	case ANTENNA_C:
+		rfPath = RF_PATH_C;
+		break;
+	}
+
+	pAdapter->mppriv.MptCtx.bSingleTone = bStart;
+	if (bStart) {
+		/*  Start Single Tone. */
+		RT_TRACE(_module_mp_, _drv_alert_, ("SetSingleToneTx: test start\n"));
+		/*  <20120326, Kordan> To amplify the power of tone for Xtal calibration. (asked by Edlu) */
+		if (IS_HARDWARE_TYPE_8188E(pAdapter)) {
+			reg58 = PHY_QueryRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask);
+			reg58 &= 0xFFFFFFF0;
+			reg58 += 2;
+			PHY_SetRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask, reg58);
+		}
+		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x0);
+		PHY_SetBBReg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x0);
+
+		if (is92C) {
+			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT19, 0x01);
+			rtw_usleep_os(100);
+			if (rfPath == RF_PATH_A)
+				write_rfreg(pAdapter, RF_PATH_B, 0x00, 0x10000); /*  PAD all on. */
+			else if (rfPath == RF_PATH_B)
+				write_rfreg(pAdapter, RF_PATH_A, 0x00, 0x10000); /*  PAD all on. */
+			write_rfreg(pAdapter, rfPath, 0x00, 0x2001f); /*  PAD all on. */
+			rtw_usleep_os(100);
+		} else {
+			write_rfreg(pAdapter, rfPath, 0x21, 0xd4000);
+			rtw_usleep_os(100);
+			write_rfreg(pAdapter, rfPath, 0x00, 0x2001f); /*  PAD all on. */
+			rtw_usleep_os(100);
+		}
+
+		/* for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000500);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000500);
+
+	} else {
+		/*  Stop Single Tone. */
+		RT_TRACE(_module_mp_, _drv_alert_, ("SetSingleToneTx: test stop\n"));
+
+		/*  <20120326, Kordan> To amplify the power of tone for Xtal calibration. (asked by Edlu) */
+		/*  <20120326, Kordan> Only in single tone mode. (asked by Edlu) */
+		if (IS_HARDWARE_TYPE_8188E(pAdapter)) {
+			reg58 = PHY_QueryRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask);
+			reg58 &= 0xFFFFFFF0;
+			PHY_SetRFReg(pAdapter, RF_PATH_A, LNA_Low_Gain_3, bRFRegOffsetMask, reg58);
+		}
+		write_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn, 0x1);
+		write_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
+		if (is92C) {
+			_write_rfreg(pAdapter, RF_PATH_A, 0x21, BIT19, 0x00);
+			rtw_usleep_os(100);
+			write_rfreg(pAdapter, RF_PATH_A, 0x00, 0x32d75); /*  PAD all on. */
+			write_rfreg(pAdapter, RF_PATH_B, 0x00, 0x32d75); /*  PAD all on. */
+			rtw_usleep_os(100);
+		} else {
+			write_rfreg(pAdapter, rfPath, 0x21, 0x54000);
+			rtw_usleep_os(100);
+			write_rfreg(pAdapter, rfPath, 0x00, 0x30000); /*  PAD all on. */
+			rtw_usleep_os(100);
+		}
+
+		/* Stop for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000100);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000100);
+	}
+}
+
+void Hal_SetCarrierSuppressionTx(struct adapter *pAdapter, u8 bStart)
+{
+	pAdapter->mppriv.MptCtx.bCarrierSuppression = bStart;
+	if (bStart) {
+		/*  Start Carrier Suppression. */
+		RT_TRACE(_module_mp_, _drv_alert_, ("SetCarrierSuppressionTx: test start\n"));
+		if (pAdapter->mppriv.rateidx <= MPT_RATE_11M) {
+			/*  1. if CCK block on? */
+			if (!read_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn))
+				write_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn, bEnable);/* set CCK block on */
+
+			/* Turn Off All Test Mode */
+			write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
+			write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
+			write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
+
+			write_bbreg(pAdapter, rCCK0_System, bCCKBBMode, 0x2);    /* transmit mode */
+			write_bbreg(pAdapter, rCCK0_System, bCCKScramble, 0x0);  /* turn off scramble setting */
+
+			/* Set CCK Tx Test Rate */
+			write_bbreg(pAdapter, rCCK0_System, bCCKTxRate, 0x0);    /* Set FTxRate to 1Mbps */
+		}
+
+		/* for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000500);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000500);
+	} else {
+		/*  Stop Carrier Suppression. */
+		RT_TRACE(_module_mp_, _drv_alert_, ("SetCarrierSuppressionTx: test stop\n"));
+		if (pAdapter->mppriv.rateidx <= MPT_RATE_11M) {
+			write_bbreg(pAdapter, rCCK0_System, bCCKBBMode, 0x0);    /* normal mode */
+			write_bbreg(pAdapter, rCCK0_System, bCCKScramble, 0x1);  /* turn on scramble setting */
+
+			/* BB Reset */
+			write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
+			write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
+		}
+
+		/* Stop for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000100);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000100);
+	}
+}
+
+void Hal_SetCCKContinuousTx(struct adapter *pAdapter, u8 bStart)
+{
+	u32 cckrate;
+
+	if (bStart) {
+		RT_TRACE(_module_mp_, _drv_alert_,
+			 ("SetCCKContinuousTx: test start\n"));
+
+		/*  1. if CCK block on? */
+		if (!read_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn))
+			write_bbreg(pAdapter, rFPGA0_RFMOD, bCCKEn, bEnable);/* set CCK block on */
+
+		/* Turn Off All Test Mode */
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
+		/* Set CCK Tx Test Rate */
+		cckrate  = pAdapter->mppriv.rateidx;
+		write_bbreg(pAdapter, rCCK0_System, bCCKTxRate, cckrate);
+		write_bbreg(pAdapter, rCCK0_System, bCCKBBMode, 0x2);	/* transmit mode */
+		write_bbreg(pAdapter, rCCK0_System, bCCKScramble, bEnable);	/* turn on scramble setting */
+
+		/* for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000500);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000500);
+	} else {
+		RT_TRACE(_module_mp_, _drv_info_,
+			 ("SetCCKContinuousTx: test stop\n"));
+
+		write_bbreg(pAdapter, rCCK0_System, bCCKBBMode, 0x0);	/* normal mode */
+		write_bbreg(pAdapter, rCCK0_System, bCCKScramble, bEnable);	/* turn on scramble setting */
+
+		/* BB Reset */
+		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
+		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
+
+		/* Stop for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000100);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000100);
+	}
+
+	pAdapter->mppriv.MptCtx.bCckContTx = bStart;
+	pAdapter->mppriv.MptCtx.bOfdmContTx = false;
+} /* mpt_StartCckContTx */
+
+void Hal_SetOFDMContinuousTx(struct adapter *pAdapter, u8 bStart)
+{
+	if (bStart) {
+		RT_TRACE(_module_mp_, _drv_info_, ("SetOFDMContinuousTx: test start\n"));
+		/*  1. if OFDM block on? */
+		if (!read_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn))
+			write_bbreg(pAdapter, rFPGA0_RFMOD, bOFDMEn, bEnable);/* set OFDM block on */
+
+		/*  2. set CCK test mode off, set to CCK normal mode */
+		write_bbreg(pAdapter, rCCK0_System, bCCKBBMode, bDisable);
+
+		/*  3. turn on scramble setting */
+		write_bbreg(pAdapter, rCCK0_System, bCCKScramble, bEnable);
+		/*  4. Turn On Continue Tx and turn off the other test modes. */
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bEnable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
+
+		/* for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000500);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000500);
+
+	} else {
+		RT_TRACE(_module_mp_, _drv_info_, ("SetOFDMContinuousTx: test stop\n"));
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
+		write_bbreg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
+		/* Delay 10 ms */
+		rtw_msleep_os(10);
+		/* BB Reset */
+		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
+		write_bbreg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
+
+		/* Stop for dynamic set Power index. */
+		write_bbreg(pAdapter, rFPGA0_XA_HSSIParameter1, bMaskDWord, 0x01000100);
+		write_bbreg(pAdapter, rFPGA0_XB_HSSIParameter1, bMaskDWord, 0x01000100);
+	}
+
+	pAdapter->mppriv.MptCtx.bCckContTx = false;
+	pAdapter->mppriv.MptCtx.bOfdmContTx = bStart;
+} /* mpt_StartOfdmContTx */
+
+void Hal_SetContinuousTx(struct adapter *pAdapter, u8 bStart)
+{
+	RT_TRACE(_module_mp_, _drv_info_,
+		 ("SetContinuousTx: rate:%d\n", pAdapter->mppriv.rateidx));
+
+	pAdapter->mppriv.MptCtx.bStartContTx = bStart;
+	if (pAdapter->mppriv.rateidx <= MPT_RATE_11M)
+		Hal_SetCCKContinuousTx(pAdapter, bStart);
+	else if ((pAdapter->mppriv.rateidx >= MPT_RATE_6M) &&
+		 (pAdapter->mppriv.rateidx <= MPT_RATE_MCS15))
+		Hal_SetOFDMContinuousTx(pAdapter, bStart);
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
new file mode 100644
index 000000000000..36ad9dbbd8b0
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -0,0 +1,1135 @@
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
+#define _RTL8188E_PHYCFG_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <rtw_iol.h>
+#include <rtl8188e_hal.h>
+
+/*---------------------------Define Local Constant---------------------------*/
+/* Channel switch:The size of command tables for switch channel*/
+#define MAX_PRECMD_CNT 16
+#define MAX_RFDEPENDCMD_CNT 16
+#define MAX_POSTCMD_CNT 16
+
+#define MAX_DOZE_WAITING_TIMES_9x 64
+
+/*---------------------------Define Local Constant---------------------------*/
+
+/*------------------------Define global variable-----------------------------*/
+
+/*------------------------Define local variable------------------------------*/
+
+/*--------------------Define export function prototype-----------------------*/
+/*  Please refer to header file */
+/*--------------------Define export function prototype-----------------------*/
+
+/*----------------------------Function Body----------------------------------*/
+/*  */
+/*  1. BB register R/W API */
+/*  */
+
+/**
+* Function:	phy_CalculateBitShift
+*
+* OverView:	Get shifted position of the BitMask
+*
+* Input:
+*			u32		BitMask,
+*
+* Output:	none
+* Return:		u32		Return the shift bit bit position of the mask
+*/
+static	u32 phy_CalculateBitShift(u32 BitMask)
+{
+	u32 i;
+
+	for (i = 0; i <= 31; i++) {
+		if (((BitMask>>i) &  0x1) == 1)
+			break;
+	}
+	return i;
+}
+
+/**
+* Function:	PHY_QueryBBReg
+*
+* OverView:	Read "sepcific bits" from BB register
+*
+* Input:
+*			struct adapter *Adapter,
+*			u32			RegAddr,	The target address to be readback
+*			u32			BitMask		The target bit position in the target address
+*								to be readback
+* Output:	None
+* Return:		u32			Data		The readback register value
+* Note:		This function is equal to "GetRegSetting" in PHY programming guide
+*/
+u32
+rtl8188e_PHY_QueryBBReg(
+		struct adapter *Adapter,
+		u32 RegAddr,
+		u32 BitMask
+	)
+{
+	u32 ReturnValue = 0, OriginalValue, BitShift;
+
+	OriginalValue = rtw_read32(Adapter, RegAddr);
+	BitShift = phy_CalculateBitShift(BitMask);
+	ReturnValue = (OriginalValue & BitMask) >> BitShift;
+	return ReturnValue;
+}
+
+/**
+* Function:	PHY_SetBBReg
+*
+* OverView:	Write "Specific bits" to BB register (page 8~)
+*
+* Input:
+*			struct adapter *Adapter,
+*			u32			RegAddr,	The target address to be modified
+*			u32			BitMask		The target bit position in the target address
+*									to be modified
+*			u32			Data		The new register value in the target bit position
+*									of the target address
+*
+* Output:	None
+* Return:		None
+* Note:		This function is equal to "PutRegSetting" in PHY programming guide
+*/
+
+void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
+{
+	u32 OriginalValue, BitShift;
+
+	if (BitMask != bMaskDWord) { /* if not "double word" write */
+		OriginalValue = rtw_read32(Adapter, RegAddr);
+		BitShift = phy_CalculateBitShift(BitMask);
+		Data = ((OriginalValue & (~BitMask)) | (Data << BitShift));
+	}
+
+	rtw_write32(Adapter, RegAddr, Data);
+}
+
+/*  */
+/*  2. RF register R/W API */
+/*  */
+/**
+* Function:	phy_RFSerialRead
+*
+* OverView:	Read regster from RF chips
+*
+* Input:
+*			struct adapter *Adapter,
+*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
+*			u32			Offset,		The target address to be read
+*
+* Output:	None
+* Return:		u32			reback value
+* Note:		Threre are three types of serial operations:
+*			1. Software serial write
+*			2. Hardware LSSI-Low Speed Serial Interface
+*			3. Hardware HSSI-High speed
+*			serial write. Driver need to implement (1) and (2).
+*			This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
+*/
+static	u32
+phy_RFSerialRead(
+		struct adapter *Adapter,
+		enum rf_radio_path eRFPath,
+		u32 Offset
+	)
+{
+	u32 retValue = 0;
+	struct hal_data_8188e				*pHalData = GET_HAL_DATA(Adapter);
+	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[eRFPath];
+	u32 NewOffset;
+	u32 tmplong, tmplong2;
+	u8 	RfPiEnable = 0;
+	/*  */
+	/*  Make sure RF register offset is correct */
+	/*  */
+	Offset &= 0xff;
+
+	/*  */
+	/*  Switch page for 8256 RF IC */
+	/*  */
+	NewOffset = Offset;
+
+	/*  For 92S LSSI Read RFLSSIRead */
+	/*  For RF A/B write 0x824/82c(does not work in the future) */
+	/*  We must use 0x824 for RF A and B to execute read trigger */
+	tmplong = PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord);
+	if (eRFPath == RF_PATH_A)
+		tmplong2 = tmplong;
+	else
+		tmplong2 = PHY_QueryBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord);
+
+	tmplong2 = (tmplong2 & (~bLSSIReadAddress)) | (NewOffset<<23) | bLSSIReadEdge;	/* T65 RF */
+
+	PHY_SetBBReg(Adapter, rFPGA0_XA_HSSIParameter2, bMaskDWord, tmplong&(~bLSSIReadEdge));
+	rtw_udelay_os(10);/*  PlatformStallExecution(10); */
+
+	PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, bMaskDWord, tmplong2);
+	rtw_udelay_os(100);/* PlatformStallExecution(100); */
+
+	rtw_udelay_os(10);/* PlatformStallExecution(10); */
+
+	if (eRFPath == RF_PATH_A)
+		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XA_HSSIParameter1, BIT8);
+	else if (eRFPath == RF_PATH_B)
+		RfPiEnable = (u8)PHY_QueryBBReg(Adapter, rFPGA0_XB_HSSIParameter1, BIT8);
+
+	if (RfPiEnable) {	/*  Read from BBreg8b8, 12 bits for 8190, 20bits for T65 RF */
+		retValue = PHY_QueryBBReg(Adapter, pPhyReg->rfLSSIReadBackPi, bLSSIReadBackData);
+	} else {	/* Read from BBreg8a0, 12 bits for 8190, 20 bits for T65 RF */
+		retValue = PHY_QueryBBReg(Adapter, pPhyReg->rfLSSIReadBack, bLSSIReadBackData);
+	}
+	return retValue;
+}
+
+/**
+* Function:	phy_RFSerialWrite
+*
+* OverView:	Write data to RF register (page 8~)
+*
+* Input:
+*			struct adapter *Adapter,
+*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
+*			u32			Offset,		The target address to be read
+*			u32			Data		The new register Data in the target bit position
+*									of the target to be read
+*
+* Output:	None
+* Return:		None
+* Note:		Threre are three types of serial operations:
+*			1. Software serial write
+*			2. Hardware LSSI-Low Speed Serial Interface
+*			3. Hardware HSSI-High speed
+*			serial write. Driver need to implement (1) and (2).
+*			This function is equal to the combination of RF_ReadReg() and  RFLSSIRead()
+ *
+ * Note:		  For RF8256 only
+ *			 The total count of RTL8256(Zebra4) register is around 36 bit it only employs
+ *			 4-bit RF address. RTL8256 uses "register mode control bit" (Reg00[12], Reg00[10])
+ *			 to access register address bigger than 0xf. See "Appendix-4 in PHY Configuration
+ *			 programming guide" for more details.
+ *			 Thus, we define a sub-finction for RTL8526 register address conversion
+ *		       ===========================================================
+ *			 Register Mode		RegCTL[1]		RegCTL[0]		Note
+ *								(Reg00[12])		(Reg00[10])
+ *		       ===========================================================
+ *			 Reg_Mode0				0				x			Reg 0 ~15(0x0 ~ 0xf)
+ *		       ------------------------------------------------------------------
+ *			 Reg_Mode1				1				0			Reg 16 ~30(0x1 ~ 0xf)
+ *		       ------------------------------------------------------------------
+ *			 Reg_Mode2				1				1			Reg 31 ~ 45(0x1 ~ 0xf)
+ *		       ------------------------------------------------------------------
+ *
+ *	2008/09/02	MH	Add 92S RF definition
+ *
+ *
+ *
+*/
+static	void
+phy_RFSerialWrite(
+		struct adapter *Adapter,
+		enum rf_radio_path eRFPath,
+		u32 Offset,
+		u32 Data
+	)
+{
+	u32 DataAndAddr = 0;
+	struct hal_data_8188e				*pHalData = GET_HAL_DATA(Adapter);
+	struct bb_reg_def *pPhyReg = &pHalData->PHYRegDef[eRFPath];
+	u32 NewOffset;
+
+	/*  2009/06/17 MH We can not execute IO for power save or other accident mode. */
+
+	Offset &= 0xff;
+
+	/*  */
+	/*  Switch page for 8256 RF IC */
+	/*  */
+	NewOffset = Offset;
+
+	/*  */
+	/*  Put write addr in [5:0]  and write data in [31:16] */
+	/*  */
+	DataAndAddr = ((NewOffset<<20) | (Data&0x000fffff)) & 0x0fffffff;	/*  T65 RF */
+
+	/*  */
+	/*  Write Operation */
+	/*  */
+	PHY_SetBBReg(Adapter, pPhyReg->rf3wireOffset, bMaskDWord, DataAndAddr);
+}
+
+/**
+* Function:	PHY_QueryRFReg
+*
+* OverView:	Query "Specific bits" to RF register (page 8~)
+*
+* Input:
+*			struct adapter *Adapter,
+*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
+*			u32			RegAddr,	The target address to be read
+*			u32			BitMask		The target bit position in the target address
+*									to be read
+*
+* Output:	None
+* Return:		u32			Readback value
+* Note:		This function is equal to "GetRFRegSetting" in PHY programming guide
+*/
+u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, enum rf_radio_path eRFPath,
+			    u32 RegAddr, u32 BitMask)
+{
+	u32 Original_Value, Readback_Value, BitShift;
+
+	Original_Value = phy_RFSerialRead(Adapter, eRFPath, RegAddr);
+
+	BitShift =  phy_CalculateBitShift(BitMask);
+	Readback_Value = (Original_Value & BitMask) >> BitShift;
+	return Readback_Value;
+}
+
+/**
+* Function:	PHY_SetRFReg
+*
+* OverView:	Write "Specific bits" to RF register (page 8~)
+*
+* Input:
+*			struct adapter *Adapter,
+*			enum rf_radio_path eRFPath,	Radio path of A/B/C/D
+*			u32			RegAddr,	The target address to be modified
+*			u32			BitMask		The target bit position in the target address
+*									to be modified
+*			u32			Data		The new register Data in the target bit position
+*									of the target address
+*
+* Output:	None
+* Return:		None
+* Note:		This function is equal to "PutRFRegSetting" in PHY programming guide
+*/
+void
+rtl8188e_PHY_SetRFReg(
+		struct adapter *Adapter,
+		enum rf_radio_path eRFPath,
+		u32 RegAddr,
+		u32 BitMask,
+		u32 Data
+	)
+{
+	u32 Original_Value, BitShift;
+
+	/*  RF data is 12 bits only */
+	if (BitMask != bRFRegOffsetMask) {
+		Original_Value = phy_RFSerialRead(Adapter, eRFPath, RegAddr);
+		BitShift =  phy_CalculateBitShift(BitMask);
+		Data = ((Original_Value & (~BitMask)) | (Data << BitShift));
+	}
+
+	phy_RFSerialWrite(Adapter, eRFPath, RegAddr, Data);
+}
+
+/*  */
+/*  3. Initial MAC/BB/RF config by reading MAC/BB/RF txt. */
+/*  */
+
+/*-----------------------------------------------------------------------------
+ * Function:    PHY_MACConfig8192C
+ *
+ * Overview:	Condig MAC by header file or parameter file.
+ *
+ * Input:       NONE
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Revised History:
+ *  When		Who		Remark
+ *  08/12/2008	MHC		Create Version 0.
+ *
+ *---------------------------------------------------------------------------*/
+s32 PHY_MACConfig8188E(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	int rtStatus = _SUCCESS;
+
+	/*  */
+	/*  Config MAC */
+	/*  */
+	if (HAL_STATUS_FAILURE == ODM_ConfigMACWithHeaderFile(&pHalData->odmpriv))
+		rtStatus = _FAIL;
+
+	/*  2010.07.13 AMPDU aggregation number B */
+	rtw_write16(Adapter, REG_MAX_AGGR_NUM, MAX_AGGR_NUM);
+
+	return rtStatus;
+}
+
+/**
+* Function:	phy_InitBBRFRegisterDefinition
+*
+* OverView:	Initialize Register definition offset for Radio Path A/B/C/D
+*
+* Input:
+*			struct adapter *Adapter,
+*
+* Output:	None
+* Return:		None
+* Note:		The initialization value is constant and it should never be changes
+*/
+static	void
+phy_InitBBRFRegisterDefinition(
+		struct adapter *Adapter
+)
+{
+	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+
+	/*  RF Interface Sowrtware Control */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 LSBs if read 32-bit from 0x870 */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfs = rFPGA0_XAB_RFInterfaceSW; /*  16 MSBs if read 32-bit from 0x870 (16-bit for 0x872) */
+	pHalData->PHYRegDef[RF_PATH_C].rfintfs = rFPGA0_XCD_RFInterfaceSW;/*  16 LSBs if read 32-bit from 0x874 */
+	pHalData->PHYRegDef[RF_PATH_D].rfintfs = rFPGA0_XCD_RFInterfaceSW;/*  16 MSBs if read 32-bit from 0x874 (16-bit for 0x876) */
+
+	/*  RF Interface Readback Value */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfi = rFPGA0_XAB_RFInterfaceRB; /*  16 LSBs if read 32-bit from 0x8E0 */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfi = rFPGA0_XAB_RFInterfaceRB;/*  16 MSBs if read 32-bit from 0x8E0 (16-bit for 0x8E2) */
+	pHalData->PHYRegDef[RF_PATH_C].rfintfi = rFPGA0_XCD_RFInterfaceRB;/*  16 LSBs if read 32-bit from 0x8E4 */
+	pHalData->PHYRegDef[RF_PATH_D].rfintfi = rFPGA0_XCD_RFInterfaceRB;/*  16 MSBs if read 32-bit from 0x8E4 (16-bit for 0x8E6) */
+
+	/*  RF Interface Output (and Enable) */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfo = rFPGA0_XA_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x860 */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfo = rFPGA0_XB_RFInterfaceOE; /*  16 LSBs if read 32-bit from 0x864 */
+
+	/*  RF Interface (Output and)  Enable */
+	pHalData->PHYRegDef[RF_PATH_A].rfintfe = rFPGA0_XA_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x860 (16-bit for 0x862) */
+	pHalData->PHYRegDef[RF_PATH_B].rfintfe = rFPGA0_XB_RFInterfaceOE; /*  16 MSBs if read 32-bit from 0x864 (16-bit for 0x866) */
+
+	/* Addr of LSSI. Wirte RF register by driver */
+	pHalData->PHYRegDef[RF_PATH_A].rf3wireOffset = rFPGA0_XA_LSSIParameter; /* LSSI Parameter */
+	pHalData->PHYRegDef[RF_PATH_B].rf3wireOffset = rFPGA0_XB_LSSIParameter;
+
+	/*  RF parameter */
+	pHalData->PHYRegDef[RF_PATH_A].rfLSSI_Select = rFPGA0_XAB_RFParameter;  /* BB Band Select */
+	pHalData->PHYRegDef[RF_PATH_B].rfLSSI_Select = rFPGA0_XAB_RFParameter;
+	pHalData->PHYRegDef[RF_PATH_C].rfLSSI_Select = rFPGA0_XCD_RFParameter;
+	pHalData->PHYRegDef[RF_PATH_D].rfLSSI_Select = rFPGA0_XCD_RFParameter;
+
+	/*  Tx AGC Gain Stage (same for all path. Should we remove this?) */
+	pHalData->PHYRegDef[RF_PATH_A].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
+	pHalData->PHYRegDef[RF_PATH_B].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
+	pHalData->PHYRegDef[RF_PATH_C].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
+	pHalData->PHYRegDef[RF_PATH_D].rfTxGainStage = rFPGA0_TxGainStage; /* Tx gain stage */
+
+	/*  Tranceiver A~D HSSI Parameter-1 */
+	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara1 = rFPGA0_XA_HSSIParameter1;  /* wire control parameter1 */
+	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara1 = rFPGA0_XB_HSSIParameter1;  /* wire control parameter1 */
+
+	/*  Tranceiver A~D HSSI Parameter-2 */
+	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
+	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
+
+	/*  RF switch Control */
+	pHalData->PHYRegDef[RF_PATH_A].rfSwitchControl = rFPGA0_XAB_SwitchControl; /* TR/Ant switch control */
+	pHalData->PHYRegDef[RF_PATH_B].rfSwitchControl = rFPGA0_XAB_SwitchControl;
+	pHalData->PHYRegDef[RF_PATH_C].rfSwitchControl = rFPGA0_XCD_SwitchControl;
+	pHalData->PHYRegDef[RF_PATH_D].rfSwitchControl = rFPGA0_XCD_SwitchControl;
+
+	/*  AGC control 1 */
+	pHalData->PHYRegDef[RF_PATH_A].rfAGCControl1 = rOFDM0_XAAGCCore1;
+	pHalData->PHYRegDef[RF_PATH_B].rfAGCControl1 = rOFDM0_XBAGCCore1;
+	pHalData->PHYRegDef[RF_PATH_C].rfAGCControl1 = rOFDM0_XCAGCCore1;
+	pHalData->PHYRegDef[RF_PATH_D].rfAGCControl1 = rOFDM0_XDAGCCore1;
+
+	/*  AGC control 2 */
+	pHalData->PHYRegDef[RF_PATH_A].rfAGCControl2 = rOFDM0_XAAGCCore2;
+	pHalData->PHYRegDef[RF_PATH_B].rfAGCControl2 = rOFDM0_XBAGCCore2;
+	pHalData->PHYRegDef[RF_PATH_C].rfAGCControl2 = rOFDM0_XCAGCCore2;
+	pHalData->PHYRegDef[RF_PATH_D].rfAGCControl2 = rOFDM0_XDAGCCore2;
+
+	/*  RX AFE control 1 */
+	pHalData->PHYRegDef[RF_PATH_A].rfRxIQImbalance = rOFDM0_XARxIQImbalance;
+	pHalData->PHYRegDef[RF_PATH_B].rfRxIQImbalance = rOFDM0_XBRxIQImbalance;
+	pHalData->PHYRegDef[RF_PATH_C].rfRxIQImbalance = rOFDM0_XCRxIQImbalance;
+	pHalData->PHYRegDef[RF_PATH_D].rfRxIQImbalance = rOFDM0_XDRxIQImbalance;
+
+	/*  RX AFE control 1 */
+	pHalData->PHYRegDef[RF_PATH_A].rfRxAFE = rOFDM0_XARxAFE;
+	pHalData->PHYRegDef[RF_PATH_B].rfRxAFE = rOFDM0_XBRxAFE;
+	pHalData->PHYRegDef[RF_PATH_C].rfRxAFE = rOFDM0_XCRxAFE;
+	pHalData->PHYRegDef[RF_PATH_D].rfRxAFE = rOFDM0_XDRxAFE;
+
+	/*  Tx AFE control 1 */
+	pHalData->PHYRegDef[RF_PATH_A].rfTxIQImbalance = rOFDM0_XATxIQImbalance;
+	pHalData->PHYRegDef[RF_PATH_B].rfTxIQImbalance = rOFDM0_XBTxIQImbalance;
+	pHalData->PHYRegDef[RF_PATH_C].rfTxIQImbalance = rOFDM0_XCTxIQImbalance;
+	pHalData->PHYRegDef[RF_PATH_D].rfTxIQImbalance = rOFDM0_XDTxIQImbalance;
+
+	/*  Tx AFE control 2 */
+	pHalData->PHYRegDef[RF_PATH_A].rfTxAFE = rOFDM0_XATxAFE;
+	pHalData->PHYRegDef[RF_PATH_B].rfTxAFE = rOFDM0_XBTxAFE;
+	pHalData->PHYRegDef[RF_PATH_C].rfTxAFE = rOFDM0_XCTxAFE;
+	pHalData->PHYRegDef[RF_PATH_D].rfTxAFE = rOFDM0_XDTxAFE;
+
+	/*  Tranceiver LSSI Readback SI mode */
+	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
+	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
+	pHalData->PHYRegDef[RF_PATH_C].rfLSSIReadBack = rFPGA0_XC_LSSIReadBack;
+	pHalData->PHYRegDef[RF_PATH_D].rfLSSIReadBack = rFPGA0_XD_LSSIReadBack;
+
+	/*  Tranceiver LSSI Readback PI mode */
+	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
+	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBackPi = TransceiverB_HSPI_Readback;
+}
+
+void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+
+	if (RegAddr == rTxAGC_A_Rate18_06)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][0] = Data;
+	if (RegAddr == rTxAGC_A_Rate54_24)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][1] = Data;
+	if (RegAddr == rTxAGC_A_CCK1_Mcs32)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][6] = Data;
+	if (RegAddr == rTxAGC_B_CCK11_A_CCK2_11 && BitMask == 0xffffff00)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][7] = Data;
+	if (RegAddr == rTxAGC_A_Mcs03_Mcs00)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][2] = Data;
+	if (RegAddr == rTxAGC_A_Mcs07_Mcs04)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][3] = Data;
+	if (RegAddr == rTxAGC_A_Mcs11_Mcs08)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][4] = Data;
+	if (RegAddr == rTxAGC_A_Mcs15_Mcs12) {
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][5] = Data;
+		if (pHalData->rf_type == RF_1T1R)
+			pHalData->pwrGroupCnt++;
+	}
+	if (RegAddr == rTxAGC_B_Rate18_06)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][8] = Data;
+	if (RegAddr == rTxAGC_B_Rate54_24)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][9] = Data;
+	if (RegAddr == rTxAGC_B_CCK1_55_Mcs32)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][14] = Data;
+	if (RegAddr == rTxAGC_B_CCK11_A_CCK2_11 && BitMask == 0x000000ff)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][15] = Data;
+	if (RegAddr == rTxAGC_B_Mcs03_Mcs00)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][10] = Data;
+	if (RegAddr == rTxAGC_B_Mcs07_Mcs04)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][11] = Data;
+	if (RegAddr == rTxAGC_B_Mcs11_Mcs08)
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][12] = Data;
+	if (RegAddr == rTxAGC_B_Mcs15_Mcs12) {
+		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][13] = Data;
+		if (pHalData->rf_type != RF_1T1R)
+			pHalData->pwrGroupCnt++;
+	}
+}
+
+static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
+{
+	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(Adapter);
+	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+	int			rtStatus = _SUCCESS;
+
+	/*  */
+	/*  1. Read PHY_REG.TXT BB INIT!! */
+	/*  We will separate as 88C / 92C according to chip version */
+	/*  */
+	if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG))
+		rtStatus = _FAIL;
+	if (rtStatus != _SUCCESS)
+		goto phy_BB8190_Config_ParaFile_Fail;
+
+	/*  2. If EEPROM or EFUSE autoload OK, We must config by PHY_REG_PG.txt */
+	if (!pEEPROM->bautoload_fail_flag) {
+		pHalData->pwrGroupCnt = 0;
+
+		if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG_PG))
+			rtStatus = _FAIL;
+	}
+
+	if (rtStatus != _SUCCESS)
+		goto phy_BB8190_Config_ParaFile_Fail;
+
+	/*  3. BB AGC table Initialization */
+	if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv,  CONFIG_BB_AGC_TAB))
+		rtStatus = _FAIL;
+
+	if (rtStatus != _SUCCESS)
+		goto phy_BB8190_Config_ParaFile_Fail;
+
+phy_BB8190_Config_ParaFile_Fail:
+
+	return rtStatus;
+}
+
+int
+PHY_BBConfig8188E(
+		struct adapter *Adapter
+	)
+{
+	int	rtStatus = _SUCCESS;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	u32 RegVal;
+	u8 CrystalCap;
+
+	phy_InitBBRFRegisterDefinition(Adapter);
+
+	/*  Enable BB and RF */
+	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
+	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal|BIT13|BIT0|BIT1));
+
+	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
+
+	rtw_write8(Adapter, REG_RF_CTRL, RF_EN|RF_RSTB|RF_SDMRSTB);
+
+	rtw_write8(Adapter, REG_SYS_FUNC_EN, FEN_USBA | FEN_USBD | FEN_BB_GLB_RSTn | FEN_BBRSTB);
+
+	/*  Config BB and AGC */
+	rtStatus = phy_BB8188E_Config_ParaFile(Adapter);
+
+	/*  write 0x24[16:11] = 0x24[22:17] = CrystalCap */
+	CrystalCap = pHalData->CrystalCap & 0x3F;
+	PHY_SetBBReg(Adapter, REG_AFE_XTAL_CTRL, 0x7ff800, (CrystalCap | (CrystalCap << 6)));
+
+	return rtStatus;
+}
+
+int PHY_RFConfig8188E(struct adapter *Adapter)
+{
+	int		rtStatus = _SUCCESS;
+
+	/*  RF config */
+	rtStatus = PHY_RF6052_Config8188E(Adapter);
+	return rtStatus;
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:    PHY_ConfigRFWithParaFile()
+ *
+ * Overview:    This function read RF parameters from general file format, and do RF 3-wire
+ *
+ * Input:	struct adapter *Adapter
+ *			ps8					pFileName
+ *			enum rf_radio_path eRFPath
+ *
+ * Output:      NONE
+ *
+ * Return:      RT_STATUS_SUCCESS: configuration file exist
+ *
+ * Note:		Delay may be required for RF configuration
+ *---------------------------------------------------------------------------*/
+int rtl8188e_PHY_ConfigRFWithParaFile(struct adapter *Adapter, u8 *pFileName, enum rf_radio_path eRFPath)
+{
+	return _SUCCESS;
+}
+
+void
+rtl8192c_PHY_GetHWRegOriginalValue(
+		struct adapter *Adapter
+	)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+
+	/*  read rx initial gain */
+	pHalData->DefaultInitialGain[0] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XAAGCCore1, bMaskByte0);
+	pHalData->DefaultInitialGain[1] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
+	pHalData->DefaultInitialGain[2] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XCAGCCore1, bMaskByte0);
+	pHalData->DefaultInitialGain[3] = (u8)PHY_QueryBBReg(Adapter, rOFDM0_XDAGCCore1, bMaskByte0);
+
+	/*  read framesync */
+	pHalData->framesync = (u8)PHY_QueryBBReg(Adapter, rOFDM0_RxDetector3, bMaskByte0);
+	pHalData->framesyncC34 = PHY_QueryBBReg(Adapter, rOFDM0_RxDetector2, bMaskDWord);
+}
+
+/*  */
+/*	Description: */
+/*		Map dBm into Tx power index according to */
+/*		current HW model, for example, RF and PA, and */
+/*		current wireless mode. */
+/*	By Bruce, 2008-01-29. */
+/*  */
+static	u8 phy_DbmToTxPwrIdx(struct adapter *Adapter, enum wireless_mode WirelessMode, int PowerInDbm)
+{
+	u8 TxPwrIdx = 0;
+	int				Offset = 0;
+
+	/*  */
+	/*  Tested by MP, we found that CCK Index 0 equals to 8dbm, OFDM legacy equals to */
+	/*  3dbm, and OFDM HT equals to 0dbm respectively. */
+	/*  Note: */
+	/*	The mapping may be different by different NICs. Do not use this formula for what needs accurate result. */
+	/*  By Bruce, 2008-01-29. */
+	/*  */
+	switch (WirelessMode) {
+	case WIRELESS_MODE_B:
+		Offset = -7;
+		break;
+
+	case WIRELESS_MODE_G:
+	case WIRELESS_MODE_N_24G:
+	default:
+		Offset = -8;
+		break;
+	}
+
+	if ((PowerInDbm - Offset) > 0)
+		TxPwrIdx = (u8)((PowerInDbm - Offset) * 2);
+	else
+		TxPwrIdx = 0;
+
+	/*  Tx Power Index is too large. */
+	if (TxPwrIdx > MAX_TXPWR_IDX_NMODE_92S)
+		TxPwrIdx = MAX_TXPWR_IDX_NMODE_92S;
+
+	return TxPwrIdx;
+}
+
+/*  */
+/*	Description: */
+/*		Map Tx power index into dBm according to */
+/*		current HW model, for example, RF and PA, and */
+/*		current wireless mode. */
+/*	By Bruce, 2008-01-29. */
+/*  */
+static int phy_TxPwrIdxToDbm(struct adapter *Adapter, enum wireless_mode WirelessMode, u8 TxPwrIdx)
+{
+	int				Offset = 0;
+	int				PwrOutDbm = 0;
+
+	/*  */
+	/*  Tested by MP, we found that CCK Index 0 equals to -7dbm, OFDM legacy equals to -8dbm. */
+	/*  Note: */
+	/*	The mapping may be different by different NICs. Do not use this formula for what needs accurate result. */
+	/*  By Bruce, 2008-01-29. */
+	/*  */
+	switch (WirelessMode) {
+	case WIRELESS_MODE_B:
+		Offset = -7;
+		break;
+	case WIRELESS_MODE_G:
+	case WIRELESS_MODE_N_24G:
+	default:
+		Offset = -8;
+		break;
+	}
+
+	PwrOutDbm = TxPwrIdx / 2 + Offset; /*  Discard the decimal part. */
+
+	return PwrOutDbm;
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:    GetTxPowerLevel8190()
+ *
+ * Overview:    This function is export to "common" moudule
+ *
+ * Input:       struct adapter *Adapter
+ *			psByte			Power Level
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ *---------------------------------------------------------------------------*/
+void PHY_GetTxPowerLevel8188E(struct adapter *Adapter, u32 *powerlevel)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	u8 TxPwrLevel = 0;
+	int			TxPwrDbm;
+
+	/*  */
+	/*  Because the Tx power indexes are different, we report the maximum of them to */
+	/*  meet the CCX TPC request. By Bruce, 2008-01-31. */
+	/*  */
+
+	/*  CCK */
+	TxPwrLevel = pHalData->CurrentCckTxPwrIdx;
+	TxPwrDbm = phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_B, TxPwrLevel);
+
+	/*  Legacy OFDM */
+	TxPwrLevel = pHalData->CurrentOfdm24GTxPwrIdx + pHalData->LegacyHTTxPowerDiff;
+
+	/*  Compare with Legacy OFDM Tx power. */
+	if (phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_G, TxPwrLevel) > TxPwrDbm)
+		TxPwrDbm = phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_G, TxPwrLevel);
+
+	/*  HT OFDM */
+	TxPwrLevel = pHalData->CurrentOfdm24GTxPwrIdx;
+
+	/*  Compare with HT OFDM Tx power. */
+	if (phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_N_24G, TxPwrLevel) > TxPwrDbm)
+		TxPwrDbm = phy_TxPwrIdxToDbm(Adapter, WIRELESS_MODE_N_24G, TxPwrLevel);
+
+	*powerlevel = TxPwrDbm;
+}
+
+static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
+			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
+			       u8 *BW40PowerLevel)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	u8 index = (channel - 1);
+	u8 TxCount = 0, path_nums;
+
+	if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
+		path_nums = 1;
+	else
+		path_nums = 2;
+
+	for (TxCount = 0; TxCount < path_nums; TxCount++) {
+		if (TxCount == RF_PATH_A) {
+			/*  1. CCK */
+			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
+			/* 2. OFDM */
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+				pHalData->OFDM_24G_Diff[TxCount][RF_PATH_A];
+			/*  1. BW20 */
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+				pHalData->BW20_24G_Diff[TxCount][RF_PATH_A];
+			/* 2. BW40 */
+			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
+		} else if (TxCount == RF_PATH_B) {
+			/*  1. CCK */
+			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
+			/* 2. OFDM */
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[TxCount][index];
+			/*  1. BW20 */
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[TxCount][RF_PATH_A]+
+			pHalData->BW20_24G_Diff[TxCount][index];
+			/* 2. BW40 */
+			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
+		} else if (TxCount == RF_PATH_C) {
+			/*  1. CCK */
+			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
+			/* 2. OFDM */
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
+			pHalData->BW20_24G_Diff[TxCount][index];
+			/*  1. BW20 */
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
+			pHalData->BW20_24G_Diff[TxCount][index];
+			/* 2. BW40 */
+			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
+		} else if (TxCount == RF_PATH_D) {
+			/*  1. CCK */
+			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
+			/* 2. OFDM */
+			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_C][index]+
+			pHalData->BW20_24G_Diff[TxCount][index];
+
+			/*  1. BW20 */
+			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_A][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_B][index]+
+			pHalData->BW20_24G_Diff[RF_PATH_C][index]+
+			pHalData->BW20_24G_Diff[TxCount][index];
+
+			/* 2. BW40 */
+			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
+		}
+	}
+}
+
+static void phy_PowerIndexCheck88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
+				   u8 *ofdmPowerLevel, u8 *BW20PowerLevel, u8 *BW40PowerLevel)
+{
+	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
+
+	pHalData->CurrentCckTxPwrIdx = cckPowerLevel[0];
+	pHalData->CurrentOfdm24GTxPwrIdx = ofdmPowerLevel[0];
+	pHalData->CurrentBW2024GTxPwrIdx = BW20PowerLevel[0];
+	pHalData->CurrentBW4024GTxPwrIdx = BW40PowerLevel[0];
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:    SetTxPowerLevel8190()
+ *
+ * Overview:    This function is export to "HalCommon" moudule
+ *			We must consider RF path later!!!!!!!
+ *
+ * Input:       struct adapter *Adapter
+ *			u8		channel
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *	2008/11/04	MHC		We remove EEPROM_93C56.
+ *						We need to move CCX relative code to independet file.
+ *	2009/01/21	MHC		Support new EEPROM format from SD3 requirement.
+ *
+ *---------------------------------------------------------------------------*/
+void
+PHY_SetTxPowerLevel8188E(
+		struct adapter *Adapter,
+		u8 channel
+	)
+{
+	u8 cckPowerLevel[MAX_TX_COUNT] = {0};
+	u8 ofdmPowerLevel[MAX_TX_COUNT] = {0};/*  [0]:RF-A, [1]:RF-B */
+	u8 BW20PowerLevel[MAX_TX_COUNT] = {0};
+	u8 BW40PowerLevel[MAX_TX_COUNT] = {0};
+
+	getTxPowerIndex88E(Adapter, channel, &cckPowerLevel[0], &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0]);
+
+	phy_PowerIndexCheck88E(Adapter, channel, &cckPowerLevel[0], &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0]);
+
+	rtl8188e_PHY_RF6052SetCckTxPower(Adapter, &cckPowerLevel[0]);
+	rtl8188e_PHY_RF6052SetOFDMTxPower(Adapter, &ofdmPowerLevel[0], &BW20PowerLevel[0], &BW40PowerLevel[0], channel);
+}
+
+/*  */
+/*	Description: */
+/*		Update transmit power level of all channel supported. */
+/*  */
+/*	TODO: */
+/*		A mode. */
+/*	By Bruce, 2008-02-04. */
+/*  */
+bool
+PHY_UpdateTxPowerDbm8188E(
+		struct adapter *Adapter,
+		int		powerInDbm
+	)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	u8 idx;
+	u8 rf_path;
+
+	/*  TODO: A mode Tx power. */
+	u8 CckTxPwrIdx = phy_DbmToTxPwrIdx(Adapter, WIRELESS_MODE_B, powerInDbm);
+	u8 OfdmTxPwrIdx = phy_DbmToTxPwrIdx(Adapter, WIRELESS_MODE_N_24G, powerInDbm);
+
+	if (OfdmTxPwrIdx - pHalData->LegacyHTTxPowerDiff > 0)
+		OfdmTxPwrIdx -= pHalData->LegacyHTTxPowerDiff;
+	else
+		OfdmTxPwrIdx = 0;
+
+	for (idx = 0; idx < 14; idx++) {
+		for (rf_path = 0; rf_path < 2; rf_path++) {
+			pHalData->TxPwrLevelCck[rf_path][idx] = CckTxPwrIdx;
+			pHalData->TxPwrLevelHT40_1S[rf_path][idx] =
+			pHalData->TxPwrLevelHT40_2S[rf_path][idx] = OfdmTxPwrIdx;
+		}
+	}
+	return true;
+}
+
+void
+PHY_ScanOperationBackup8188E(
+		struct adapter *Adapter,
+		u8 Operation
+	)
+{
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:    PHY_SetBWModeCallback8192C()
+ *
+ * Overview:    Timer callback function for SetSetBWMode
+ *
+ * Input:		PRT_TIMER		pTimer
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Note:		(1) We do not take j mode into consideration now
+ *			(2) Will two workitem of "switch channel" and "switch channel bandwidth" run
+ *			     concurrently?
+ *---------------------------------------------------------------------------*/
+static void
+_PHY_SetBWMode92C(
+		struct adapter *Adapter
+)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	u8 regBwOpMode;
+	u8 regRRSR_RSC;
+
+	if (pHalData->rf_chip == RF_PSEUDO_11N)
+		return;
+
+	/*  There is no 40MHz mode in RF_8225. */
+	if (pHalData->rf_chip == RF_8225)
+		return;
+
+	if (Adapter->bDriverStopped)
+		return;
+
+	/* 3 */
+	/* 3<1>Set MAC register */
+	/* 3 */
+
+	regBwOpMode = rtw_read8(Adapter, REG_BWOPMODE);
+	regRRSR_RSC = rtw_read8(Adapter, REG_RRSR+2);
+
+	switch (pHalData->CurrentChannelBW) {
+	case HT_CHANNEL_WIDTH_20:
+		regBwOpMode |= BW_OPMODE_20MHZ;
+		/*  2007/02/07 Mark by Emily because we have not verify whether this register works */
+		rtw_write8(Adapter, REG_BWOPMODE, regBwOpMode);
+		break;
+	case HT_CHANNEL_WIDTH_40:
+		regBwOpMode &= ~BW_OPMODE_20MHZ;
+		/*  2007/02/07 Mark by Emily because we have not verify whether this register works */
+		rtw_write8(Adapter, REG_BWOPMODE, regBwOpMode);
+		regRRSR_RSC = (regRRSR_RSC&0x90) | (pHalData->nCur40MhzPrimeSC<<5);
+		rtw_write8(Adapter, REG_RRSR+2, regRRSR_RSC);
+		break;
+	default:
+		break;
+	}
+
+	/* 3  */
+	/* 3 <2>Set PHY related register */
+	/* 3 */
+	switch (pHalData->CurrentChannelBW) {
+	/* 20 MHz channel*/
+	case HT_CHANNEL_WIDTH_20:
+		PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x0);
+		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x0);
+		break;
+	/* 40 MHz channel*/
+	case HT_CHANNEL_WIDTH_40:
+		PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bRFMOD, 0x1);
+		PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x1);
+		/*  Set Control channel to upper or lower. These settings are required only for 40MHz */
+		PHY_SetBBReg(Adapter, rCCK0_System, bCCKSideBand, (pHalData->nCur40MhzPrimeSC>>1));
+		PHY_SetBBReg(Adapter, rOFDM1_LSTF, 0xC00, pHalData->nCur40MhzPrimeSC);
+		PHY_SetBBReg(Adapter, 0x818, (BIT26 | BIT27),
+			     (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) ? 2 : 1);
+		break;
+	default:
+		break;
+	}
+	/* Skip over setting of J-mode in BB register here. Default value is "None J mode". Emily 20070315 */
+
+	/* 3<3>Set RF related register */
+	switch (pHalData->rf_chip) {
+	case RF_8225:
+		break;
+	case RF_8256:
+		/*  Please implement this function in Hal8190PciPhy8256.c */
+		break;
+	case RF_8258:
+		/*  Please implement this function in Hal8190PciPhy8258.c */
+		break;
+	case RF_PSEUDO_11N:
+		break;
+	case RF_6052:
+		rtl8188e_PHY_RF6052SetBandwidth(Adapter, pHalData->CurrentChannelBW);
+		break;
+	default:
+		break;
+	}
+}
+
+ /*-----------------------------------------------------------------------------
+ * Function:   SetBWMode8190Pci()
+ *
+ * Overview:  This function is export to "HalCommon" moudule
+ *
+ * Input:		struct adapter *Adapter
+ *			enum ht_channel_width Bandwidth	20M or 40M
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Note:		We do not take j mode into consideration now
+ *---------------------------------------------------------------------------*/
+void PHY_SetBWMode8188E(struct adapter *Adapter, enum ht_channel_width Bandwidth,	/*  20M or 40M */
+			unsigned char	Offset)		/*  Upper, Lower, or Don't care */
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	enum ht_channel_width tmpBW = pHalData->CurrentChannelBW;
+
+	pHalData->CurrentChannelBW = Bandwidth;
+
+	pHalData->nCur40MhzPrimeSC = Offset;
+
+	if ((!Adapter->bDriverStopped) && (!Adapter->bSurpriseRemoved))
+		_PHY_SetBWMode92C(Adapter);
+	else
+		pHalData->CurrentChannelBW = tmpBW;
+}
+
+static void _PHY_SwChnl8192C(struct adapter *Adapter, u8 channel)
+{
+	u8 eRFPath;
+	u32 param1, param2;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+
+	if (Adapter->bNotifyChannelChange)
+		DBG_88E("[%s] ch = %d\n", __func__, channel);
+
+	/* s1. pre common command - CmdID_SetTxPowerLevel */
+	PHY_SetTxPowerLevel8188E(Adapter, channel);
+
+	/* s2. RF dependent command - CmdID_RF_WriteReg, param1=RF_CHNLBW, param2=channel */
+	param1 = RF_CHNLBW;
+	param2 = channel;
+	for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++) {
+		pHalData->RfRegChnlVal[eRFPath] = ((pHalData->RfRegChnlVal[eRFPath] & 0xfffffc00) | param2);
+		PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, param1, bRFRegOffsetMask, pHalData->RfRegChnlVal[eRFPath]);
+	}
+}
+
+void PHY_SwChnl8188E(struct adapter *Adapter, u8 channel)
+{
+	/*  Call after initialization */
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
+	u8 tmpchannel = pHalData->CurrentChannel;
+	bool  bResult = true;
+
+	if (pHalData->rf_chip == RF_PSEUDO_11N)
+		return;		/* return immediately if it is peudo-phy */
+
+	if (channel == 0)
+		channel = 1;
+
+	pHalData->CurrentChannel = channel;
+
+	if ((!Adapter->bDriverStopped) && (!Adapter->bSurpriseRemoved)) {
+		_PHY_SwChnl8192C(Adapter, channel);
+
+		if (bResult)
+			;
+		else
+			pHalData->CurrentChannel = tmpchannel;
+
+	} else {
+		pHalData->CurrentChannel = tmpchannel;
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
new file mode 100644
index 000000000000..0ed6ff67ad57
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rf6052.c
@@ -0,0 +1,569 @@
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
+/******************************************************************************
+ *
+ *
+ * Module:	rtl8192c_rf6052.c	( Source C File)
+ *
+ * Note:	Provide RF 6052 series relative API.
+ *
+ * Function:
+ *
+ * Export:
+ *
+ * Abbrev:
+ *
+ * History:
+ * Data			Who		Remark
+ *
+ * 09/25/2008	MHC		Create initial version.
+ * 11/05/2008	MHC		Add API for tw power setting.
+ *
+ *
+******************************************************************************/
+
+#define _RTL8188E_RF6052_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+
+#include <rtl8188e_hal.h>
+
+/*---------------------------Define Local Constant---------------------------*/
+/*  Define local structure for debug!!!!! */
+struct rf_shadow {
+	/*  Shadow register value */
+	u32 Value;
+	/*  Compare or not flag */
+	u8 Compare;
+	/*  Record If it had ever modified unpredicted */
+	u8 ErrorOrNot;
+	/*  Recorver Flag */
+	u8 Recorver;
+	/*  */
+	u8 Driver_Write;
+};
+
+/*---------------------------Define Local Constant---------------------------*/
+
+/*------------------------Define global variable-----------------------------*/
+
+/*------------------------Define local variable------------------------------*/
+
+/*-----------------------------------------------------------------------------
+ * Function:	RF_ChangeTxPath
+ *
+ * Overview:	For RL6052, we must change some RF settign for 1T or 2T.
+ *
+ * Input:		u16 DataRate		0x80-8f, 0x90-9f
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Revised History:
+ * When			Who		Remark
+ * 09/25/2008	MHC		Create Version 0.
+ *						Firmwaer support the utility later.
+ *
+ *---------------------------------------------------------------------------*/
+void rtl8188e_RF_ChangeTxPath(struct adapter *Adapter, u16 DataRate)
+{
+/*  We do not support gain table change inACUT now !!!! Delete later !!! */
+}	/* RF_ChangeTxPath */
+
+/*-----------------------------------------------------------------------------
+ * Function:    PHY_RF6052SetBandwidth()
+ *
+ * Overview:    This function is called by SetBWModeCallback8190Pci() only
+ *
+ * Input:       struct adapter *Adapter
+ *			WIRELESS_BANDWIDTH_E	Bandwidth	20M or 40M
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Note:		For RF type 0222D
+ *---------------------------------------------------------------------------*/
+void rtl8188e_PHY_RF6052SetBandwidth(struct adapter *Adapter,
+				     enum ht_channel_width Bandwidth)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+
+	switch (Bandwidth) {
+	case HT_CHANNEL_WIDTH_20:
+		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT(10) | BIT(11));
+		PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		break;
+	case HT_CHANNEL_WIDTH_40:
+		pHalData->RfRegChnlVal[0] = ((pHalData->RfRegChnlVal[0] & 0xfffff3ff) | BIT(10));
+		PHY_SetRFReg(Adapter, RF_PATH_A, RF_CHNLBW, bRFRegOffsetMask, pHalData->RfRegChnlVal[0]);
+		break;
+	default:
+		break;
+	}
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:	PHY_RF6052SetCckTxPower
+ *
+ * Overview:
+ *
+ * Input:       NONE
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Revised History:
+ * When			Who		Remark
+ * 11/05/2008	MHC		Simulate 8192series..
+ *
+ *---------------------------------------------------------------------------*/
+
+void
+rtl8188e_PHY_RF6052SetCckTxPower(
+		struct adapter *Adapter,
+		u8 *pPowerlevel)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct dm_priv *pdmpriv = &pHalData->dmpriv;
+	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
+	u32 TxAGC[2] = {0, 0}, tmpval = 0, pwrtrac_value;
+	bool TurboScanOff = false;
+	u8 idx1, idx2;
+	u8 *ptr;
+	u8 direction;
+	/* FOR CE ,must disable turbo scan */
+	TurboScanOff = true;
+
+	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
+		TxAGC[RF_PATH_A] = 0x3f3f3f3f;
+		TxAGC[RF_PATH_B] = 0x3f3f3f3f;
+
+		TurboScanOff = true;/* disable turbo scan */
+
+		if (TurboScanOff) {
+			for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
+				TxAGC[idx1] =
+					pPowerlevel[idx1] | (pPowerlevel[idx1]<<8) |
+					(pPowerlevel[idx1]<<16) | (pPowerlevel[idx1]<<24);
+				/*  2010/10/18 MH For external PA module. We need to limit power index to be less than 0x20. */
+				if (TxAGC[idx1] > 0x20 && pHalData->ExternalPA)
+					TxAGC[idx1] = 0x20;
+			}
+		}
+	} else {
+		/* Driver dynamic Tx power shall not affect Tx power.
+		 * It shall be determined by power training mechanism.
+i		 *  Currently, we cannot fully disable driver dynamic
+		 * tx power mechanism because it is referenced by BT
+		 * coexist mechanism.
+		 * In the future, two mechanism shall be separated from
+		 * each other and maintained independently. */
+		if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_Level1) {
+			TxAGC[RF_PATH_A] = 0x10101010;
+			TxAGC[RF_PATH_B] = 0x10101010;
+		} else if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_Level2) {
+			TxAGC[RF_PATH_A] = 0x00000000;
+			TxAGC[RF_PATH_B] = 0x00000000;
+		} else {
+			for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
+				TxAGC[idx1] =
+					pPowerlevel[idx1] | (pPowerlevel[idx1]<<8) |
+					(pPowerlevel[idx1]<<16) | (pPowerlevel[idx1]<<24);
+			}
+			if (pHalData->EEPROMRegulatory == 0) {
+				tmpval = (pHalData->MCSTxPowerLevelOriginalOffset[0][6]) +
+						(pHalData->MCSTxPowerLevelOriginalOffset[0][7]<<8);
+				TxAGC[RF_PATH_A] += tmpval;
+
+				tmpval = (pHalData->MCSTxPowerLevelOriginalOffset[0][14]) +
+						(pHalData->MCSTxPowerLevelOriginalOffset[0][15]<<24);
+				TxAGC[RF_PATH_B] += tmpval;
+			}
+		}
+	}
+	for (idx1 = RF_PATH_A; idx1 <= RF_PATH_B; idx1++) {
+		ptr = (u8 *)(&(TxAGC[idx1]));
+		for (idx2 = 0; idx2 < 4; idx2++) {
+			if (*ptr > RF6052_MAX_TX_PWR)
+				*ptr = RF6052_MAX_TX_PWR;
+			ptr++;
+		}
+	}
+	ODM_TxPwrTrackAdjust88E(&pHalData->odmpriv, 1, &direction, &pwrtrac_value);
+
+	if (direction == 1) {
+		/*  Increase TX power */
+		TxAGC[0] += pwrtrac_value;
+		TxAGC[1] += pwrtrac_value;
+	} else if (direction == 2) {
+		/*  Decrease TX power */
+		TxAGC[0] -=  pwrtrac_value;
+		TxAGC[1] -=  pwrtrac_value;
+	}
+
+	/*  rf-A cck tx power */
+	tmpval = TxAGC[RF_PATH_A]&0xff;
+	PHY_SetBBReg(Adapter, rTxAGC_A_CCK1_Mcs32, bMaskByte1, tmpval);
+	tmpval = TxAGC[RF_PATH_A]>>8;
+	PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, 0xffffff00, tmpval);
+
+	/*  rf-B cck tx power */
+	tmpval = TxAGC[RF_PATH_B]>>24;
+	PHY_SetBBReg(Adapter, rTxAGC_B_CCK11_A_CCK2_11, bMaskByte0, tmpval);
+	tmpval = TxAGC[RF_PATH_B]&0x00ffffff;
+	PHY_SetBBReg(Adapter, rTxAGC_B_CCK1_55_Mcs32, 0xffffff00, tmpval);
+}	/* PHY_RF6052SetCckTxPower */
+
+/*  */
+/*  powerbase0 for OFDM rates */
+/*  powerbase1 for HT MCS rates */
+/*  */
+static void getpowerbase88e(struct adapter *Adapter, u8 *pPowerLevelOFDM,
+			    u8 *pPowerLevelBW20, u8 *pPowerLevelBW40, u8 Channel, u32 *OfdmBase, u32 *MCSBase)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	u32 powerBase0, powerBase1;
+	u8 i, powerlevel[2];
+
+	for (i = 0; i < 2; i++) {
+		powerBase0 = pPowerLevelOFDM[i];
+
+		powerBase0 = (powerBase0<<24) | (powerBase0<<16) | (powerBase0<<8) | powerBase0;
+		*(OfdmBase+i) = powerBase0;
+	}
+	for (i = 0; i < pHalData->NumTotalRFPath; i++) {
+		/* Check HT20 to HT40 diff */
+		if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
+			powerlevel[i] = pPowerLevelBW20[i];
+		else
+			powerlevel[i] = pPowerLevelBW40[i];
+		powerBase1 = powerlevel[i];
+		powerBase1 = (powerBase1<<24) | (powerBase1<<16) | (powerBase1<<8) | powerBase1;
+		*(MCSBase+i) = powerBase1;
+	}
+}
+static void get_rx_power_val_by_reg(struct adapter *Adapter, u8 Channel,
+				    u8 index, u32 *powerBase0, u32 *powerBase1,
+				    u32 *pOutWriteVal)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &pHalData->dmpriv;
+	u8	i, chnlGroup = 0, pwr_diff_limit[4], customer_pwr_limit;
+	s8	pwr_diff = 0;
+	u32	writeVal, customer_limit, rf;
+	u8	Regulatory = pHalData->EEPROMRegulatory;
+
+	/*  Index 0 & 1= legacy OFDM, 2-5=HT_MCS rate */
+
+	for (rf = 0; rf < 2; rf++) {
+		switch (Regulatory) {
+		case 0:	/*  Realtek better performance */
+				/*  increase power diff defined by Realtek for large power */
+			chnlGroup = 0;
+			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
+				((index < 2) ? powerBase0[rf] : powerBase1[rf]);
+			break;
+		case 1:	/*  Realtek regulatory */
+			/*  increase power diff defined by Realtek for regulatory */
+			if (pHalData->pwrGroupCnt == 1)
+				chnlGroup = 0;
+			if (pHalData->pwrGroupCnt >= pHalData->PGMaxGroup) {
+				if (Channel < 3)			/*  Channel 1-2 */
+					chnlGroup = 0;
+				else if (Channel < 6)		/*  Channel 3-5 */
+					chnlGroup = 1;
+				else	 if (Channel < 9)		/*  Channel 6-8 */
+					chnlGroup = 2;
+				else if (Channel < 12)		/*  Channel 9-11 */
+					chnlGroup = 3;
+				else if (Channel < 14)		/*  Channel 12-13 */
+					chnlGroup = 4;
+				else if (Channel == 14)		/*  Channel 14 */
+					chnlGroup = 5;
+			}
+			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
+					((index < 2) ? powerBase0[rf] : powerBase1[rf]);
+			break;
+		case 2:	/*  Better regulatory */
+				/*  don't increase any power diff */
+			writeVal = ((index < 2) ? powerBase0[rf] : powerBase1[rf]);
+			break;
+		case 3:	/*  Customer defined power diff. */
+				/*  increase power diff defined by customer. */
+			chnlGroup = 0;
+
+			if (index < 2)
+				pwr_diff = pHalData->TxPwrLegacyHtDiff[rf][Channel-1];
+			else if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_20)
+				pwr_diff = pHalData->TxPwrHt20Diff[rf][Channel-1];
+
+			if (pHalData->CurrentChannelBW == HT_CHANNEL_WIDTH_40)
+				customer_pwr_limit = pHalData->PwrGroupHT40[rf][Channel-1];
+			else
+				customer_pwr_limit = pHalData->PwrGroupHT20[rf][Channel-1];
+
+			if (pwr_diff >= customer_pwr_limit)
+				pwr_diff = 0;
+			else
+				pwr_diff = customer_pwr_limit - pwr_diff;
+
+			for (i = 0; i < 4; i++) {
+				pwr_diff_limit[i] = (u8)((pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)]&(0x7f<<(i*8)))>>(i*8));
+
+				if (pwr_diff_limit[i] > pwr_diff)
+					pwr_diff_limit[i] = pwr_diff;
+			}
+			customer_limit = (pwr_diff_limit[3]<<24) | (pwr_diff_limit[2]<<16) |
+					 (pwr_diff_limit[1]<<8) | (pwr_diff_limit[0]);
+			writeVal = customer_limit + ((index < 2) ? powerBase0[rf] : powerBase1[rf]);
+			break;
+		default:
+			chnlGroup = 0;
+			writeVal = pHalData->MCSTxPowerLevelOriginalOffset[chnlGroup][index+(rf ? 8 : 0)] +
+					((index < 2) ? powerBase0[rf] : powerBase1[rf]);
+			break;
+		}
+/*  20100427 Joseph: Driver dynamic Tx power shall not affect Tx power. It shall be determined by power training mechanism. */
+/*  Currently, we cannot fully disable driver dynamic tx power mechanism because it is referenced by BT coexist mechanism. */
+/*  In the future, two mechanism shall be separated from each other and maintained independently. Thanks for Lanhsin's reminder. */
+		/* 92d do not need this */
+		if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_Level1)
+			writeVal = 0x14141414;
+		else if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_Level2)
+			writeVal = 0x00000000;
+
+		/*  20100628 Joseph: High power mode for BT-Coexist mechanism. */
+		/*  This mechanism is only applied when Driver-Highpower-Mechanism is OFF. */
+		if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT1)
+			writeVal = writeVal - 0x06060606;
+		else if (pdmpriv->DynamicTxHighPowerLvl == TxHighPwrLevel_BT2)
+			writeVal = writeVal;
+		*(pOutWriteVal+rf) = writeVal;
+	}
+}
+static void writeOFDMPowerReg88E(struct adapter *Adapter, u8 index, u32 *pValue)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	u16 regoffset_a[6] = {
+		rTxAGC_A_Rate18_06, rTxAGC_A_Rate54_24,
+		rTxAGC_A_Mcs03_Mcs00, rTxAGC_A_Mcs07_Mcs04,
+		rTxAGC_A_Mcs11_Mcs08, rTxAGC_A_Mcs15_Mcs12};
+	u16 regoffset_b[6] = {
+		rTxAGC_B_Rate18_06, rTxAGC_B_Rate54_24,
+		rTxAGC_B_Mcs03_Mcs00, rTxAGC_B_Mcs07_Mcs04,
+		rTxAGC_B_Mcs11_Mcs08, rTxAGC_B_Mcs15_Mcs12};
+	u8 i, rf, pwr_val[4];
+	u32 writeVal;
+	u16 regoffset;
+
+	for (rf = 0; rf < 2; rf++) {
+		writeVal = pValue[rf];
+		for (i = 0; i < 4; i++) {
+			pwr_val[i] = (u8)((writeVal & (0x7f<<(i*8)))>>(i*8));
+			if (pwr_val[i]  > RF6052_MAX_TX_PWR)
+				pwr_val[i]  = RF6052_MAX_TX_PWR;
+		}
+		writeVal = (pwr_val[3]<<24) | (pwr_val[2]<<16) | (pwr_val[1]<<8) | pwr_val[0];
+
+		if (rf == 0)
+			regoffset = regoffset_a[index];
+		else
+			regoffset = regoffset_b[index];
+
+		PHY_SetBBReg(Adapter, regoffset, bMaskDWord, writeVal);
+
+		/*  201005115 Joseph: Set Tx Power diff for Tx power training mechanism. */
+		if (((pHalData->rf_type == RF_2T2R) &&
+		     (regoffset == rTxAGC_A_Mcs15_Mcs12 || regoffset == rTxAGC_B_Mcs15_Mcs12)) ||
+		    ((pHalData->rf_type != RF_2T2R) &&
+		     (regoffset == rTxAGC_A_Mcs07_Mcs04 || regoffset == rTxAGC_B_Mcs07_Mcs04))) {
+			writeVal = pwr_val[3];
+			if (regoffset == rTxAGC_A_Mcs15_Mcs12 || regoffset == rTxAGC_A_Mcs07_Mcs04)
+				regoffset = 0xc90;
+			if (regoffset == rTxAGC_B_Mcs15_Mcs12 || regoffset == rTxAGC_B_Mcs07_Mcs04)
+				regoffset = 0xc98;
+			for (i = 0; i < 3; i++) {
+				if (i != 2)
+					writeVal = (writeVal > 8) ? (writeVal-8) : 0;
+				else
+					writeVal = (writeVal > 6) ? (writeVal-6) : 0;
+				rtw_write8(Adapter, (u32)(regoffset+i), (u8)writeVal);
+			}
+		}
+	}
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:	PHY_RF6052SetOFDMTxPower
+ *
+ * Overview:	For legacy and HY OFDM, we must read EEPROM TX power index for
+ *			different channel and read original value in TX power register area from
+ *			0xe00. We increase offset and original value to be correct tx pwr.
+ *
+ * Input:       NONE
+ *
+ * Output:      NONE
+ *
+ * Return:      NONE
+ *
+ * Revised History:
+ * When			Who		Remark
+ * 11/05/2008	MHC		Simulate 8192 series method.
+ * 01/06/2009	MHC		1. Prevent Path B tx power overflow or underflow dure to
+ *						A/B pwr difference or legacy/HT pwr diff.
+ *						2. We concern with path B legacy/HT OFDM difference.
+ * 01/22/2009	MHC		Support new EPRO format from SD3.
+ *
+ *---------------------------------------------------------------------------*/
+
+void
+rtl8188e_PHY_RF6052SetOFDMTxPower(
+		struct adapter *Adapter,
+		u8 *pPowerLevelOFDM,
+		u8 *pPowerLevelBW20,
+		u8 *pPowerLevelBW40,
+		u8 Channel)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	u32 writeVal[2], powerBase0[2], powerBase1[2], pwrtrac_value;
+	u8 direction;
+	u8 index = 0;
+
+	getpowerbase88e(Adapter, pPowerLevelOFDM, pPowerLevelBW20, pPowerLevelBW40, Channel, &powerBase0[0], &powerBase1[0]);
+
+	/*  2012/04/23 MH According to power tracking value, we need to revise OFDM tx power. */
+	/*  This is ued to fix unstable power tracking mode. */
+	ODM_TxPwrTrackAdjust88E(&pHalData->odmpriv, 0, &direction, &pwrtrac_value);
+
+	for (index = 0; index < 6; index++) {
+		get_rx_power_val_by_reg(Adapter, Channel, index,
+					&powerBase0[0], &powerBase1[0],
+					&writeVal[0]);
+
+		if (direction == 1) {
+			writeVal[0] += pwrtrac_value;
+			writeVal[1] += pwrtrac_value;
+		} else if (direction == 2) {
+			writeVal[0] -= pwrtrac_value;
+			writeVal[1] -= pwrtrac_value;
+		}
+		writeOFDMPowerReg88E(Adapter, index, &writeVal[0]);
+	}
+}
+
+static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
+{
+	struct bb_reg_def *pPhyReg;
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	u32 u4RegValue = 0;
+	u8 eRFPath;
+	int rtStatus = _SUCCESS;
+
+	/* 3----------------------------------------------------------------- */
+	/* 3 <2> Initialize RF */
+	/* 3----------------------------------------------------------------- */
+	for (eRFPath = 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++) {
+		pPhyReg = &pHalData->PHYRegDef[eRFPath];
+
+		/*----Store original RFENV control type----*/
+		switch (eRFPath) {
+		case RF_PATH_A:
+		case RF_PATH_C:
+			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV);
+			break;
+		case RF_PATH_B:
+		case RF_PATH_D:
+			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV<<16);
+			break;
+		}
+		/*----Set RF_ENV enable----*/
+		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV<<16, 0x1);
+		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+
+		/*----Set RF_ENV output high----*/
+		PHY_SetBBReg(Adapter, pPhyReg->rfintfo, bRFSI_RFENV, 0x1);
+		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+
+		/* Set bit number of Address and Data for RF register */
+		PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireAddressLength, 0x0);	/*  Set 1 to 4 bits for 8255 */
+		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+
+		PHY_SetBBReg(Adapter, pPhyReg->rfHSSIPara2, b3WireDataLength, 0x0);	/*  Set 0 to 12  bits for 8255 */
+		rtw_udelay_os(1);/* PlatformStallExecution(1); */
+
+		/*----Initialize RF fom connfiguration file----*/
+		switch (eRFPath) {
+		case RF_PATH_A:
+			if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, (enum rf_radio_path)eRFPath, (enum rf_radio_path)eRFPath))
+				rtStatus = _FAIL;
+			break;
+		case RF_PATH_B:
+		if (HAL_STATUS_FAILURE == ODM_ConfigRFWithHeaderFile(&pHalData->odmpriv, (enum rf_radio_path)eRFPath, (enum rf_radio_path)eRFPath))
+				rtStatus = _FAIL;
+			break;
+		case RF_PATH_C:
+			break;
+		case RF_PATH_D:
+			break;
+		}
+		/*----Restore RFENV control type----*/;
+		switch (eRFPath) {
+		case RF_PATH_A:
+		case RF_PATH_C:
+			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV, u4RegValue);
+			break;
+		case RF_PATH_B:
+		case RF_PATH_D:
+			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV<<16, u4RegValue);
+			break;
+		}
+		if (rtStatus != _SUCCESS)
+			goto phy_RF6052_Config_ParaFile_Fail;
+	}
+	return rtStatus;
+
+phy_RF6052_Config_ParaFile_Fail:
+	return rtStatus;
+}
+
+int PHY_RF6052_Config8188E(struct adapter *Adapter)
+{
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
+	int rtStatus = _SUCCESS;
+
+	/*  */
+	/*  Initialize general global value */
+	/*  */
+	/*  TODO: Extend RF_PATH_C and RF_PATH_D in the future */
+	if (pHalData->rf_type == RF_1T1R)
+		pHalData->NumTotalRFPath = 1;
+	else
+		pHalData->NumTotalRFPath = 2;
+
+	/*  */
+	/*  Config BB and RF */
+	/*  */
+	rtStatus = phy_RF6052_Config_ParaFile(Adapter);
+	return rtStatus;
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
new file mode 100644
index 000000000000..a07ad95ad84b
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c
@@ -0,0 +1,202 @@
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
+#define _RTL8188E_REDESC_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <rtl8188e_hal.h>
+
+static void process_rssi(struct adapter *padapter, struct recv_frame *prframe)
+{
+	struct rx_pkt_attrib *pattrib = &prframe->attrib;
+	struct signal_stat *signal_stat = &padapter->recvpriv.signal_strength_data;
+
+	if (signal_stat->update_req) {
+		signal_stat->total_num = 0;
+		signal_stat->total_val = 0;
+		signal_stat->update_req = 0;
+	}
+
+	signal_stat->total_num++;
+	signal_stat->total_val  += pattrib->phy_info.SignalStrength;
+	signal_stat->avg_val = signal_stat->total_val / signal_stat->total_num;
+} /*  Process_UI_RSSI_8192C */
+
+static void process_link_qual(struct adapter *padapter, struct recv_frame *prframe)
+{
+	struct rx_pkt_attrib *pattrib;
+	struct signal_stat *signal_stat;
+
+	if (prframe == NULL || padapter == NULL)
+		return;
+
+	pattrib = &prframe->attrib;
+	signal_stat = &padapter->recvpriv.signal_qual_data;
+
+	if (signal_stat->update_req) {
+		signal_stat->total_num = 0;
+		signal_stat->total_val = 0;
+		signal_stat->update_req = 0;
+	}
+
+	signal_stat->total_num++;
+	signal_stat->total_val  += pattrib->phy_info.SignalQuality;
+	signal_stat->avg_val = signal_stat->total_val / signal_stat->total_num;
+}
+
+void rtl8188e_process_phy_info(struct adapter *padapter, void *prframe)
+{
+	struct recv_frame *precvframe = (struct recv_frame *)prframe;
+
+	/*  Check RSSI */
+	process_rssi(padapter, precvframe);
+	/*  Check EVM */
+	process_link_qual(padapter,  precvframe);
+}
+
+void update_recvframe_attrib_88e(struct recv_frame *precvframe, struct recv_stat *prxstat)
+{
+	struct rx_pkt_attrib	*pattrib;
+	struct recv_stat	report;
+
+	report.rxdw0 = prxstat->rxdw0;
+	report.rxdw1 = prxstat->rxdw1;
+	report.rxdw2 = prxstat->rxdw2;
+	report.rxdw3 = prxstat->rxdw3;
+	report.rxdw4 = prxstat->rxdw4;
+	report.rxdw5 = prxstat->rxdw5;
+
+	pattrib = &precvframe->attrib;
+	memset(pattrib, 0, sizeof(struct rx_pkt_attrib));
+
+	pattrib->crc_err = (u8)((le32_to_cpu(report.rxdw0) >> 14) & 0x1);;/* u8)prxreport->crc32; */
+
+	/*  update rx report to recv_frame attribute */
+	pattrib->pkt_rpt_type = (u8)((le32_to_cpu(report.rxdw3) >> 14) & 0x3);/* prxreport->rpt_sel; */
+
+	if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
+		pattrib->pkt_len = (u16)(le32_to_cpu(report.rxdw0) & 0x00003fff);/* u16)prxreport->pktlen; */
+		pattrib->drvinfo_sz = (u8)((le32_to_cpu(report.rxdw0) >> 16) & 0xf) * 8;/* u8)(prxreport->drvinfosize << 3); */
+
+		pattrib->physt =  (u8)((le32_to_cpu(report.rxdw0) >> 26) & 0x1);/* u8)prxreport->physt; */
+
+		pattrib->bdecrypted = (le32_to_cpu(report.rxdw0) & BIT(27)) ? 0 : 1;/* u8)(prxreport->swdec ? 0 : 1); */
+		pattrib->encrypt = (u8)((le32_to_cpu(report.rxdw0) >> 20) & 0x7);/* u8)prxreport->security; */
+
+		pattrib->qos = (u8)((le32_to_cpu(report.rxdw0) >> 23) & 0x1);/* u8)prxreport->qos; */
+		pattrib->priority = (u8)((le32_to_cpu(report.rxdw1) >> 8) & 0xf);/* u8)prxreport->tid; */
+
+		pattrib->amsdu = (u8)((le32_to_cpu(report.rxdw1) >> 13) & 0x1);/* u8)prxreport->amsdu; */
+
+		pattrib->seq_num = (u16)(le32_to_cpu(report.rxdw2) & 0x00000fff);/* u16)prxreport->seq; */
+		pattrib->frag_num = (u8)((le32_to_cpu(report.rxdw2) >> 12) & 0xf);/* u8)prxreport->frag; */
+		pattrib->mfrag = (u8)((le32_to_cpu(report.rxdw1) >> 27) & 0x1);/* u8)prxreport->mf; */
+		pattrib->mdata = (u8)((le32_to_cpu(report.rxdw1) >> 26) & 0x1);/* u8)prxreport->md; */
+
+		pattrib->mcs_rate = (u8)(le32_to_cpu(report.rxdw3) & 0x3f);/* u8)prxreport->rxmcs; */
+		pattrib->rxht = (u8)((le32_to_cpu(report.rxdw3) >> 6) & 0x1);/* u8)prxreport->rxht; */
+
+		pattrib->icv_err = (u8)((le32_to_cpu(report.rxdw0) >> 15) & 0x1);/* u8)prxreport->icverr; */
+		pattrib->shift_sz = (u8)((le32_to_cpu(report.rxdw0) >> 24) & 0x3);
+	} else if (pattrib->pkt_rpt_type == TX_REPORT1) { /* CCX */
+		pattrib->pkt_len = TX_RPT1_PKT_LEN;
+		pattrib->drvinfo_sz = 0;
+	} else if (pattrib->pkt_rpt_type == TX_REPORT2) { /*  TX RPT */
+		pattrib->pkt_len = (u16)(le32_to_cpu(report.rxdw0) & 0x3FF);/* Rx length[9:0] */
+		pattrib->drvinfo_sz = 0;
+
+		/*  */
+		/*  Get TX report MAC ID valid. */
+		/*  */
+		pattrib->MacIDValidEntry[0] = le32_to_cpu(report.rxdw4);
+		pattrib->MacIDValidEntry[1] = le32_to_cpu(report.rxdw5);
+
+	} else if (pattrib->pkt_rpt_type == HIS_REPORT) { /*  USB HISR RPT */
+		pattrib->pkt_len = (u16)(le32_to_cpu(report.rxdw0) & 0x00003fff);/* u16)prxreport->pktlen; */
+	}
+}
+
+/*
+ * Notice:
+ *	Before calling this function,
+ *	precvframe->rx_data should be ready!
+ */
+void update_recvframe_phyinfo_88e(struct recv_frame *precvframe, struct phy_stat *pphy_status)
+{
+	struct adapter *padapter = precvframe->adapter;
+	struct rx_pkt_attrib *pattrib = &precvframe->attrib;
+	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
+	struct odm_phy_status_info *pPHYInfo  = (struct odm_phy_status_info *)(&pattrib->phy_info);
+	u8 *wlanhdr;
+	struct odm_per_pkt_info	pkt_info;
+	u8 *sa = NULL;
+	struct sta_priv *pstapriv;
+	struct sta_info *psta;
+
+	pkt_info.bPacketMatchBSSID = false;
+	pkt_info.bPacketToSelf = false;
+	pkt_info.bPacketBeacon = false;
+
+	wlanhdr = get_recvframe_data(precvframe);
+
+	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
+		!pattrib->icv_err && !pattrib->crc_err &&
+		!memcmp(get_hdr_bssid(wlanhdr),
+		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
+
+	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
+				 (!memcmp(get_da(wlanhdr),
+				  myid(&padapter->eeprompriv), ETH_ALEN));
+
+	pkt_info.bPacketBeacon = pkt_info.bPacketMatchBSSID &&
+				 (GetFrameSubType(wlanhdr) == WIFI_BEACON);
+
+	if (pkt_info.bPacketBeacon) {
+		if (check_fwstate(&padapter->mlmepriv, WIFI_STATION_STATE))
+			sa = padapter->mlmepriv.cur_network.network.MacAddress;
+		/* to do Ad-hoc */
+	} else {
+		sa = get_sa(wlanhdr);
+	}
+
+	pstapriv = &padapter->stapriv;
+	pkt_info.StationID = 0xFF;
+	psta = rtw_get_stainfo(pstapriv, sa);
+	if (psta)
+		pkt_info.StationID = psta->mac_id;
+	pkt_info.Rate = pattrib->mcs_rate;
+
+	ODM_PhyStatusQuery(&pHalData->odmpriv, pPHYInfo, (u8 *)pphy_status, &(pkt_info), padapter);
+
+	precvframe->psta = NULL;
+	if (pkt_info.bPacketMatchBSSID &&
+	    (check_fwstate(&padapter->mlmepriv, WIFI_AP_STATE))) {
+		if (psta) {
+			precvframe->psta = psta;
+			rtl8188e_process_phy_info(padapter, precvframe);
+		}
+	} else if (pkt_info.bPacketToSelf || pkt_info.bPacketBeacon) {
+		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
+			if (psta)
+				precvframe->psta = psta;
+		}
+		rtl8188e_process_phy_info(padapter, precvframe);
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
new file mode 100644
index 000000000000..047b53482e67
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -0,0 +1,80 @@
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
+#define _RTL8188E_SRESET_C_
+
+#include <rtl8188e_sreset.h>
+#include <rtl8188e_hal.h>
+
+void rtl8188e_silentreset_for_specific_platform(struct adapter *padapter)
+{
+}
+
+void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
+{
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
+
+	unsigned long current_time;
+	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
+	unsigned int diff_time;
+	u32 txdma_status;
+
+	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
+	if (txdma_status != 0x00) {
+		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
+		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
+		rtl8188e_silentreset_for_specific_platform(padapter);
+	}
+	/* total xmit irp = 4 */
+	current_time = jiffies;
+	if (0 == pxmitpriv->free_xmitbuf_cnt) {
+		diff_time = jiffies_to_msecs(current_time - psrtpriv->last_tx_time);
+
+		if (diff_time > 2000) {
+			if (psrtpriv->last_tx_complete_time == 0) {
+				psrtpriv->last_tx_complete_time = current_time;
+			} else {
+				diff_time = jiffies_to_msecs(current_time - psrtpriv->last_tx_complete_time);
+				if (diff_time > 4000) {
+					DBG_88E("%s tx hang\n", __func__);
+					rtl8188e_silentreset_for_specific_platform(padapter);
+				}
+			}
+		}
+	}
+}
+
+void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
+{
+	u32 rx_dma_status = 0;
+	u8 fw_status = 0;
+	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
+	if (rx_dma_status != 0x00) {
+		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
+		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
+	}
+	fw_status = rtw_read8(padapter, REG_FMETHR);
+	if (fw_status != 0x00) {
+		if (fw_status == 1)
+			DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
+		else if (fw_status == 2)
+			DBG_88E("%s REG_FW_STATUS (0x%02x), Condition_No_Match !!\n", __func__, fw_status);
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
new file mode 100644
index 000000000000..7ecbcf731ea9
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
@@ -0,0 +1,91 @@
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
+#define _RTL8188E_XMIT_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <rtl8188e_hal.h>
+
+void dump_txrpt_ccx_88e(void *buf)
+{
+	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
+
+	DBG_88E("%s:\n"
+		"tag1:%u, pkt_num:%u, txdma_underflow:%u, int_bt:%u, int_tri:%u, int_ccx:%u\n"
+		"mac_id:%u, pkt_ok:%u, bmc:%u\n"
+		"retry_cnt:%u, lifetime_over:%u, retry_over:%u\n"
+		"ccx_qtime:%u\n"
+		"final_data_rate:0x%02x\n"
+		"qsel:%u, sw:0x%03x\n",
+		__func__, txrpt_ccx->tag1, txrpt_ccx->pkt_num,
+		txrpt_ccx->txdma_underflow, txrpt_ccx->int_bt,
+		txrpt_ccx->int_tri, txrpt_ccx->int_ccx,
+		txrpt_ccx->mac_id, txrpt_ccx->pkt_ok, txrpt_ccx->bmc,
+		txrpt_ccx->retry_cnt, txrpt_ccx->lifetime_over,
+		txrpt_ccx->retry_over, txrpt_ccx_qtime_88e(txrpt_ccx),
+		txrpt_ccx->final_data_rate, txrpt_ccx->qsel,
+		txrpt_ccx_sw_88e(txrpt_ccx)
+	);
+}
+
+void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
+{
+	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
+
+	if (txrpt_ccx->int_ccx) {
+		if (txrpt_ccx->pkt_ok)
+			rtw_ack_tx_done(&adapter->xmitpriv,
+					RTW_SCTX_DONE_SUCCESS);
+		else
+			rtw_ack_tx_done(&adapter->xmitpriv,
+					RTW_SCTX_DONE_CCX_PKT_FAIL);
+	}
+}
+
+void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
+		       struct tx_desc *ptxdesc)
+{
+	u8 dmp_txpkt;
+	bool dump_txdesc = false;
+	rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(dmp_txpkt));
+
+	if (dmp_txpkt == 1) {/* dump txdesc for data frame */
+		DBG_88E("dump tx_desc for data frame\n");
+		if ((frame_tag & 0x0f) == DATA_FRAMETAG)
+			dump_txdesc = true;
+	} else if (dmp_txpkt == 2) {/* dump txdesc for mgnt frame */
+		DBG_88E("dump tx_desc for mgnt frame\n");
+		if ((frame_tag & 0x0f) == MGNT_FRAMETAG)
+			dump_txdesc = true;
+	}
+
+	if (dump_txdesc) {
+		DBG_88E("=====================================\n");
+		DBG_88E("txdw0(0x%08x)\n", ptxdesc->txdw0);
+		DBG_88E("txdw1(0x%08x)\n", ptxdesc->txdw1);
+		DBG_88E("txdw2(0x%08x)\n", ptxdesc->txdw2);
+		DBG_88E("txdw3(0x%08x)\n", ptxdesc->txdw3);
+		DBG_88E("txdw4(0x%08x)\n", ptxdesc->txdw4);
+		DBG_88E("txdw5(0x%08x)\n", ptxdesc->txdw5);
+		DBG_88E("txdw6(0x%08x)\n", ptxdesc->txdw6);
+		DBG_88E("txdw7(0x%08x)\n", ptxdesc->txdw7);
+		DBG_88E("=====================================\n");
+	}
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
new file mode 100644
index 000000000000..08dfd94163e6
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
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
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <rtl8188e_hal.h>
+#include <rtl8188e_led.h>
+
+/*  LED object. */
+
+/*  LED_819xUsb routines. */
+/*	Description: */
+/*		Turn on LED according to LedPin specified. */
+void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
+{
+	u8	LedCfg;
+
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
+		return;
+	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
+	switch (pLed->LedPin) {
+	case LED_PIN_LED0:
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0xf0)|BIT5|BIT6); /*  SW control led0 on. */
+		break;
+	case LED_PIN_LED1:
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg&0x0f)|BIT5); /*  SW control led1 on. */
+		break;
+	default:
+		break;
+	}
+	pLed->bLedOn = true;
+}
+
+/*	Description: */
+/*		Turn off LED according to LedPin specified. */
+void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
+{
+	u8	LedCfg;
+	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+
+	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
+		goto exit;
+
+	LedCfg = rtw_read8(padapter, REG_LEDCFG2);/* 0x4E */
+
+	switch (pLed->LedPin) {
+	case LED_PIN_LED0:
+		if (pHalData->bLedOpenDrain) {
+			/*  Open-drain arrangement for controlling the LED) */
+			LedCfg &= 0x90; /*  Set to software control. */
+			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT3));
+			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
+			LedCfg &= 0xFE;
+			rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
+		} else {
+			rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT3|BIT5|BIT6));
+		}
+		break;
+	case LED_PIN_LED1:
+		LedCfg &= 0x0f; /*  Set to software control. */
+		rtw_write8(padapter, REG_LEDCFG2, (LedCfg|BIT3));
+		break;
+	default:
+		break;
+	}
+exit:
+	pLed->bLedOn = false;
+}
+
+/*  Interface to manipulate LED objects. */
+/*  Default LED behavior. */
+
+/*	Description: */
+/*		Initialize all LED_871x objects. */
+void rtl8188eu_InitSwLeds(struct adapter *padapter)
+{
+	struct led_priv *pledpriv = &(padapter->ledpriv);
+
+	pledpriv->LedControlHandler = LedControl8188eu;
+
+	InitLed871x(padapter, &(pledpriv->SwLed0), LED_PIN_LED0);
+
+	InitLed871x(padapter, &(pledpriv->SwLed1), LED_PIN_LED1);
+}
+
+/*	Description: */
+/*		DeInitialize all LED_819xUsb objects. */
+void rtl8188eu_DeInitSwLeds(struct adapter *padapter)
+{
+	struct led_priv	*ledpriv = &(padapter->ledpriv);
+
+	DeInitLed871x(&(ledpriv->SwLed0));
+	DeInitLed871x(&(ledpriv->SwLed1));
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
new file mode 100644
index 000000000000..ab0853ceeb61
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -0,0 +1,136 @@
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
+#define _RTL8188EU_RECV_C_
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <recv_osdep.h>
+#include <mlme_osdep.h>
+#include <ip.h>
+#include <if_ether.h>
+#include <ethernet.h>
+
+#include <usb_ops.h>
+#include <wifi.h>
+
+#include <rtl8188e_hal.h>
+
+void rtl8188eu_init_recvbuf(struct adapter *padapter, struct recv_buf *precvbuf)
+{
+	precvbuf->transfer_len = 0;
+
+	precvbuf->len = 0;
+
+	precvbuf->ref_cnt = 0;
+
+	if (precvbuf->pbuf) {
+		precvbuf->pdata = precvbuf->pbuf;
+		precvbuf->phead = precvbuf->pbuf;
+		precvbuf->ptail = precvbuf->pbuf;
+		precvbuf->pend = precvbuf->pdata + MAX_RECVBUF_SZ;
+	}
+}
+
+int	rtl8188eu_init_recv_priv(struct adapter *padapter)
+{
+	struct recv_priv	*precvpriv = &padapter->recvpriv;
+	int	i, res = _SUCCESS;
+	struct recv_buf *precvbuf;
+
+	tasklet_init(&precvpriv->recv_tasklet,
+		     (void(*)(unsigned long))rtl8188eu_recv_tasklet,
+		     (unsigned long)padapter);
+
+	/* init recv_buf */
+	_rtw_init_queue(&precvpriv->free_recv_buf_queue);
+
+	precvpriv->pallocated_recv_buf = rtw_zmalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4);
+	if (precvpriv->pallocated_recv_buf == NULL) {
+		res = _FAIL;
+		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("alloc recv_buf fail!\n"));
+		goto exit;
+	}
+	memset(precvpriv->pallocated_recv_buf, 0, NR_RECVBUFF * sizeof(struct recv_buf) + 4);
+
+	precvpriv->precv_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_recv_buf), 4);
+
+	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
+
+	for (i = 0; i < NR_RECVBUFF; i++) {
+		INIT_LIST_HEAD(&precvbuf->list);
+		spin_lock_init(&precvbuf->recvbuf_lock);
+		precvbuf->alloc_sz = MAX_RECVBUF_SZ;
+		res = rtw_os_recvbuf_resource_alloc(padapter, precvbuf);
+		if (res == _FAIL)
+			break;
+		precvbuf->ref_cnt = 0;
+		precvbuf->adapter = padapter;
+		precvbuf++;
+	}
+	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
+	skb_queue_head_init(&precvpriv->rx_skb_queue);
+	{
+		int i;
+		size_t tmpaddr = 0;
+		size_t alignment = 0;
+		struct sk_buff *pskb = NULL;
+
+		skb_queue_head_init(&precvpriv->free_recv_skb_queue);
+
+		for (i = 0; i < NR_PREALLOC_RECV_SKB; i++) {
+			pskb = __netdev_alloc_skb(padapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ, GFP_KERNEL);
+			if (pskb) {
+				pskb->dev = padapter->pnetdev;
+				tmpaddr = (size_t)pskb->data;
+				alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
+				skb_reserve(pskb, (RECVBUFF_ALIGN_SZ - alignment));
+
+				skb_queue_tail(&precvpriv->free_recv_skb_queue, pskb);
+			}
+			pskb = NULL;
+		}
+	}
+exit:
+	return res;
+}
+
+void rtl8188eu_free_recv_priv(struct adapter *padapter)
+{
+	int	i;
+	struct recv_buf	*precvbuf;
+	struct recv_priv	*precvpriv = &padapter->recvpriv;
+
+	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
+
+	for (i = 0; i < NR_RECVBUFF; i++) {
+		rtw_os_recvbuf_resource_free(padapter, precvbuf);
+		precvbuf++;
+	}
+
+	kfree(precvpriv->pallocated_recv_buf);
+
+	if (skb_queue_len(&precvpriv->rx_skb_queue))
+		DBG_88E(KERN_WARNING "rx_skb_queue not empty\n");
+	skb_queue_purge(&precvpriv->rx_skb_queue);
+
+	if (skb_queue_len(&precvpriv->free_recv_skb_queue))
+		DBG_88E(KERN_WARNING "free_recv_skb_queue not empty, %d\n", skb_queue_len(&precvpriv->free_recv_skb_queue));
+
+	skb_queue_purge(&precvpriv->free_recv_skb_queue);
+}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
new file mode 100644
index 000000000000..7f5d677b1d6f
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -0,0 +1,703 @@
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
+#define _RTL8188E_XMIT_C_
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <wifi.h>
+#include <osdep_intf.h>
+#include <usb_ops.h>
+#include <rtl8188e_hal.h>
+
+s32	rtl8188eu_init_xmit_priv(struct adapter *adapt)
+{
+	struct xmit_priv	*pxmitpriv = &adapt->xmitpriv;
+
+	tasklet_init(&pxmitpriv->xmit_tasklet,
+		     (void(*)(unsigned long))rtl8188eu_xmit_tasklet,
+		     (unsigned long)adapt);
+	return _SUCCESS;
+}
+
+void	rtl8188eu_free_xmit_priv(struct adapter *adapt)
+{
+}
+
+static u8 urb_zero_packet_chk(struct adapter *adapt, int sz)
+{
+	u8 set_tx_desc_offset;
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	set_tx_desc_offset = (((sz + TXDESC_SIZE) %  haldata->UsbBulkOutSize) == 0) ? 1 : 0;
+
+	return set_tx_desc_offset;
+}
+
+static void rtl8188eu_cal_txdesc_chksum(struct tx_desc	*ptxdesc)
+{
+	u16	*usptr = (u16 *)ptxdesc;
+	u32 count = 16;		/*  (32 bytes / 2 bytes per XOR) => 16 times */
+	u32 index;
+	u16 checksum = 0;
+
+	/* Clear first */
+	ptxdesc->txdw7 &= cpu_to_le32(0xffff0000);
+
+	for (index = 0; index < count; index++)
+		checksum = checksum ^ le16_to_cpu(*(__le16 *)(usptr + index));
+	ptxdesc->txdw7 |= cpu_to_le32(0x0000ffff & checksum);
+}
+
+/*  Description: In normal chip, we should send some packet to Hw which will be used by Fw */
+/*			in FW LPS mode. The function is to fill the Tx descriptor of this packets, then */
+/*			Fw can tell Hw to send these packet derectly. */
+void rtl8188e_fill_fake_txdesc(struct adapter *adapt, u8 *desc, u32 BufferLen, u8  ispspoll, u8  is_btqosnull)
+{
+	struct tx_desc *ptxdesc;
+
+	/*  Clear all status */
+	ptxdesc = (struct tx_desc *)desc;
+	memset(desc, 0, TXDESC_SIZE);
+
+	/* offset 0 */
+	ptxdesc->txdw0 |= cpu_to_le32(OWN | FSG | LSG); /* own, bFirstSeg, bLastSeg; */
+
+	ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE+OFFSET_SZ)<<OFFSET_SHT)&0x00ff0000); /* 32 bytes for TX Desc */
+
+	ptxdesc->txdw0 |= cpu_to_le32(BufferLen&0x0000ffff); /*  Buffer size + command header */
+
+	/* offset 4 */
+	ptxdesc->txdw1 |= cpu_to_le32((QSLT_MGNT<<QSEL_SHT)&0x00001f00); /*  Fixed queue of Mgnt queue */
+
+	/* Set NAVUSEHDR to prevent Ps-poll AId filed to be changed to error vlaue by Hw. */
+	if (ispspoll) {
+		ptxdesc->txdw1 |= cpu_to_le32(NAVUSEHDR);
+	} else {
+		ptxdesc->txdw4 |= cpu_to_le32(BIT(7)); /*  Hw set sequence number */
+		ptxdesc->txdw3 |= cpu_to_le32((8 << 28)); /* set bit3 to 1. Suugested by TimChen. 2009.12.29. */
+	}
+
+	if (is_btqosnull)
+		ptxdesc->txdw2 |= cpu_to_le32(BIT(23)); /*  BT NULL */
+
+	/* offset 16 */
+	ptxdesc->txdw4 |= cpu_to_le32(BIT(8));/* driver uses rate */
+
+	/*  USB interface drop packet if the checksum of descriptor isn't correct. */
+	/*  Using this checksum can let hardware recovery from packet bulk out error (e.g. Cancel URC, Bulk out error.). */
+	rtl8188eu_cal_txdesc_chksum(ptxdesc);
+}
+
+static void fill_txdesc_sectype(struct pkt_attrib *pattrib, struct tx_desc *ptxdesc)
+{
+	if ((pattrib->encrypt > 0) && !pattrib->bswenc) {
+		switch (pattrib->encrypt) {
+		/* SEC_TYPE : 0:NO_ENC,1:WEP40/TKIP,2:WAPI,3:AES */
+		case _WEP40_:
+		case _WEP104_:
+			ptxdesc->txdw1 |= cpu_to_le32((0x01<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
+			break;
+		case _TKIP_:
+		case _TKIP_WTMIC_:
+			ptxdesc->txdw1 |= cpu_to_le32((0x01<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
+			break;
+		case _AES_:
+			ptxdesc->txdw1 |= cpu_to_le32((0x03<<SEC_TYPE_SHT)&0x00c00000);
+			ptxdesc->txdw2 |= cpu_to_le32(0x7 << AMPDU_DENSITY_SHT);
+			break;
+		case _NO_PRIVACY_:
+		default:
+			break;
+		}
+	}
+}
+
+static void fill_txdesc_vcs(struct pkt_attrib *pattrib, __le32 *pdw)
+{
+	switch (pattrib->vcs_mode) {
+	case RTS_CTS:
+		*pdw |= cpu_to_le32(RTS_EN);
+		break;
+	case CTS_TO_SELF:
+		*pdw |= cpu_to_le32(CTS_2_SELF);
+		break;
+	case NONE_VCS:
+	default:
+		break;
+	}
+	if (pattrib->vcs_mode) {
+		*pdw |= cpu_to_le32(HW_RTS_EN);
+		/*  Set RTS BW */
+		if (pattrib->ht_en) {
+			*pdw |= (pattrib->bwmode&HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(27)) : 0;
+
+			if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
+				*pdw |= cpu_to_le32((0x01 << 28) & 0x30000000);
+			else if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_UPPER)
+				*pdw |= cpu_to_le32((0x02 << 28) & 0x30000000);
+			else if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_DONT_CARE)
+				*pdw |= 0;
+			else
+				*pdw |= cpu_to_le32((0x03 << 28) & 0x30000000);
+		}
+	}
+}
+
+static void fill_txdesc_phy(struct pkt_attrib *pattrib, __le32 *pdw)
+{
+	if (pattrib->ht_en) {
+		*pdw |= (pattrib->bwmode&HT_CHANNEL_WIDTH_40) ?	cpu_to_le32(BIT(25)) : 0;
+
+		if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
+			*pdw |= cpu_to_le32((0x01 << DATA_SC_SHT) & 0x003f0000);
+		else if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_UPPER)
+			*pdw |= cpu_to_le32((0x02 << DATA_SC_SHT) & 0x003f0000);
+		else if (pattrib->ch_offset == HAL_PRIME_CHNL_OFFSET_DONT_CARE)
+			*pdw |= 0;
+		else
+			*pdw |= cpu_to_le32((0x03 << DATA_SC_SHT) & 0x003f0000);
+	}
+}
+
+static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bagg_pkt)
+{
+	int	pull = 0;
+	uint	qsel;
+	u8 data_rate, pwr_status, offset;
+	struct adapter		*adapt = pxmitframe->padapter;
+	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct tx_desc	*ptxdesc = (struct tx_desc *)pmem;
+	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	int	bmcst = IS_MCAST(pattrib->ra);
+
+	if (adapt->registrypriv.mp_mode == 0) {
+		if ((!bagg_pkt) && (urb_zero_packet_chk(adapt, sz) == 0)) {
+			ptxdesc = (struct tx_desc *)(pmem+PACKET_OFFSET_SZ);
+			pull = 1;
+		}
+	}
+
+	memset(ptxdesc, 0, sizeof(struct tx_desc));
+
+	/* 4 offset 0 */
+	ptxdesc->txdw0 |= cpu_to_le32(OWN | FSG | LSG);
+	ptxdesc->txdw0 |= cpu_to_le32(sz & 0x0000ffff);/* update TXPKTSIZE */
+
+	offset = TXDESC_SIZE + OFFSET_SZ;
+
+	ptxdesc->txdw0 |= cpu_to_le32(((offset) << OFFSET_SHT) & 0x00ff0000);/* 32 bytes for TX Desc */
+
+	if (bmcst)
+		ptxdesc->txdw0 |= cpu_to_le32(BMC);
+
+	if (adapt->registrypriv.mp_mode == 0) {
+		if (!bagg_pkt) {
+			if ((pull) && (pxmitframe->pkt_offset > 0))
+				pxmitframe->pkt_offset = pxmitframe->pkt_offset - 1;
+		}
+	}
+
+	/*  pkt_offset, unit:8 bytes padding */
+	if (pxmitframe->pkt_offset > 0)
+		ptxdesc->txdw1 |= cpu_to_le32((pxmitframe->pkt_offset << 26) & 0x7c000000);
+
+	/* driver uses rate */
+	ptxdesc->txdw4 |= cpu_to_le32(USERATE);/* rate control always by driver */
+
+	if ((pxmitframe->frame_tag & 0x0f) == DATA_FRAMETAG) {
+		/* offset 4 */
+		ptxdesc->txdw1 |= cpu_to_le32(pattrib->mac_id & 0x3F);
+
+		qsel = (uint)(pattrib->qsel & 0x0000001f);
+		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
+
+		ptxdesc->txdw1 |= cpu_to_le32((pattrib->raid << RATE_ID_SHT) & 0x000F0000);
+
+		fill_txdesc_sectype(pattrib, ptxdesc);
+
+		if (pattrib->ampdu_en) {
+			ptxdesc->txdw2 |= cpu_to_le32(AGG_EN);/* AGG EN */
+			ptxdesc->txdw6 = cpu_to_le32(0x6666f800);
+		} else {
+			ptxdesc->txdw2 |= cpu_to_le32(AGG_BK);/* AGG BK */
+		}
+
+		/* offset 8 */
+
+		/* offset 12 */
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum << SEQ_SHT) & 0x0FFF0000);
+
+		/* offset 16 , offset 20 */
+		if (pattrib->qos_en)
+			ptxdesc->txdw4 |= cpu_to_le32(QOS);/* QoS */
+
+		/* offset 20 */
+		if (pxmitframe->agg_num > 1)
+			ptxdesc->txdw5 |= cpu_to_le32((pxmitframe->agg_num << USB_TXAGG_NUM_SHT) & 0xFF000000);
+
+		if ((pattrib->ether_type != 0x888e) &&
+		    (pattrib->ether_type != 0x0806) &&
+		    (pattrib->ether_type != 0x88b4) &&
+		    (pattrib->dhcp_pkt != 1)) {
+			/* Non EAP & ARP & DHCP type data packet */
+
+			fill_txdesc_vcs(pattrib, &ptxdesc->txdw4);
+			fill_txdesc_phy(pattrib, &ptxdesc->txdw4);
+
+			ptxdesc->txdw4 |= cpu_to_le32(0x00000008);/* RTS Rate=24M */
+			ptxdesc->txdw5 |= cpu_to_le32(0x0001ff00);/* DATA/RTS  Rate FB LMT */
+
+			if (pattrib->ht_en) {
+				if (ODM_RA_GetShortGI_8188E(&haldata->odmpriv, pattrib->mac_id))
+					ptxdesc->txdw5 |= cpu_to_le32(SGI);/* SGI */
+			}
+			data_rate = ODM_RA_GetDecisionRate_8188E(&haldata->odmpriv, pattrib->mac_id);
+			ptxdesc->txdw5 |= cpu_to_le32(data_rate & 0x3F);
+			pwr_status = ODM_RA_GetHwPwrStatus_8188E(&haldata->odmpriv, pattrib->mac_id);
+			ptxdesc->txdw4 |= cpu_to_le32((pwr_status & 0x7) << PWR_STATUS_SHT);
+		} else {
+			/*  EAP data packet and ARP packet and DHCP. */
+			/*  Use the 1M data rate to send the EAP/ARP packet. */
+			/*  This will maybe make the handshake smooth. */
+			ptxdesc->txdw2 |= cpu_to_le32(AGG_BK);/* AGG BK */
+			if (pmlmeinfo->preamble_mode == PREAMBLE_SHORT)
+				ptxdesc->txdw4 |= cpu_to_le32(BIT(24));/*  DATA_SHORT */
+			ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
+		}
+	} else if ((pxmitframe->frame_tag&0x0f) == MGNT_FRAMETAG) {
+		/* offset 4 */
+		ptxdesc->txdw1 |= cpu_to_le32(pattrib->mac_id & 0x3f);
+
+		qsel = (uint)(pattrib->qsel&0x0000001f);
+		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
+
+		ptxdesc->txdw1 |= cpu_to_le32((pattrib->raid << RATE_ID_SHT) & 0x000f0000);
+
+		/* offset 8 */
+		/* CCX-TXRPT ack for xmit mgmt frames. */
+		if (pxmitframe->ack_report)
+			ptxdesc->txdw2 |= cpu_to_le32(BIT(19));
+
+		/* offset 12 */
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum<<SEQ_SHT)&0x0FFF0000);
+
+		/* offset 20 */
+		ptxdesc->txdw5 |= cpu_to_le32(RTY_LMT_EN);/* retry limit enable */
+		if (pattrib->retry_ctrl)
+			ptxdesc->txdw5 |= cpu_to_le32(0x00180000);/* retry limit = 6 */
+		else
+			ptxdesc->txdw5 |= cpu_to_le32(0x00300000);/* retry limit = 12 */
+
+		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
+	} else if ((pxmitframe->frame_tag&0x0f) == TXAGG_FRAMETAG) {
+		DBG_88E("pxmitframe->frame_tag == TXAGG_FRAMETAG\n");
+	} else if (((pxmitframe->frame_tag&0x0f) == MP_FRAMETAG) &&
+		   (adapt->registrypriv.mp_mode == 1)) {
+		fill_txdesc_for_mp(adapt, ptxdesc);
+	} else {
+		DBG_88E("pxmitframe->frame_tag = %d\n", pxmitframe->frame_tag);
+
+		/* offset 4 */
+		ptxdesc->txdw1 |= cpu_to_le32((4) & 0x3f);/* CAM_ID(MAC_ID) */
+
+		ptxdesc->txdw1 |= cpu_to_le32((6 << RATE_ID_SHT) & 0x000f0000);/* raid */
+
+		/* offset 8 */
+
+		/* offset 12 */
+		ptxdesc->txdw3 |= cpu_to_le32((pattrib->seqnum<<SEQ_SHT)&0x0fff0000);
+
+		/* offset 20 */
+		ptxdesc->txdw5 |= cpu_to_le32(MRateToHwRate(pmlmeext->tx_rate));
+	}
+
+	/*  2009.11.05. tynli_test. Suggested by SD4 Filen for FW LPS. */
+	/*  (1) The sequence number of each non-Qos frame / broadcast / multicast / */
+	/*  mgnt frame should be controlled by Hw because Fw will also send null data */
+	/*  which we cannot control when Fw LPS enable. */
+	/*  --> default enable non-Qos data sequense number. 2010.06.23. by tynli. */
+	/*  (2) Enable HW SEQ control for beacon packet, because we use Hw beacon. */
+	/*  (3) Use HW Qos SEQ to control the seq num of Ext port non-Qos packets. */
+	/*  2010.06.23. Added by tynli. */
+	if (!pattrib->qos_en) {
+		ptxdesc->txdw3 |= cpu_to_le32(EN_HWSEQ); /*  Hw set sequence number */
+		ptxdesc->txdw4 |= cpu_to_le32(HW_SSN);	/*  Hw set sequence number */
+	}
+
+	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
+
+	rtl8188eu_cal_txdesc_chksum(ptxdesc);
+	_dbg_dump_tx_info(adapt, pxmitframe->frame_tag, ptxdesc);
+	return pull;
+}
+
+/* for non-agg data frame or  management frame */
+static s32 rtw_dump_xframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
+{
+	s32 ret = _SUCCESS;
+	s32 inner_ret = _SUCCESS;
+	int t, sz, w_sz, pull = 0;
+	u8 *mem_addr;
+	u32 ff_hwaddr;
+	struct xmit_buf *pxmitbuf = pxmitframe->pxmitbuf;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
+	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
+	struct security_priv *psecuritypriv = &adapt->securitypriv;
+	if ((pxmitframe->frame_tag == DATA_FRAMETAG) &&
+	    (pxmitframe->attrib.ether_type != 0x0806) &&
+	    (pxmitframe->attrib.ether_type != 0x888e) &&
+	    (pxmitframe->attrib.ether_type != 0x88b4) &&
+	    (pxmitframe->attrib.dhcp_pkt != 1))
+		rtw_issue_addbareq_cmd(adapt, pxmitframe);
+	mem_addr = pxmitframe->buf_addr;
+
+	RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_dump_xframe()\n"));
+
+	for (t = 0; t < pattrib->nr_frags; t++) {
+		if (inner_ret != _SUCCESS && ret == _SUCCESS)
+			ret = _FAIL;
+
+		if (t != (pattrib->nr_frags - 1)) {
+			RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("pattrib->nr_frags=%d\n", pattrib->nr_frags));
+
+			sz = pxmitpriv->frag_len;
+			sz = sz - 4 - (psecuritypriv->sw_encrypt ? 0 : pattrib->icv_len);
+		} else {
+			/* no frag */
+			sz = pattrib->last_txcmdsz;
+		}
+
+		pull = update_txdesc(pxmitframe, mem_addr, sz, false);
+
+		if (pull) {
+			mem_addr += PACKET_OFFSET_SZ; /* pull txdesc head */
+			pxmitframe->buf_addr = mem_addr;
+			w_sz = sz + TXDESC_SIZE;
+		} else {
+			w_sz = sz + TXDESC_SIZE + PACKET_OFFSET_SZ;
+		}
+		ff_hwaddr = rtw_get_ff_hwaddr(pxmitframe);
+
+		inner_ret = rtw_write_port(adapt, ff_hwaddr, w_sz, (unsigned char *)pxmitbuf);
+
+		rtw_count_tx_stats(adapt, pxmitframe, sz);
+
+		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_write_port, w_sz=%d\n", w_sz));
+
+		mem_addr += w_sz;
+
+		mem_addr = (u8 *)RND4(((size_t)(mem_addr)));
+	}
+
+	rtw_free_xmitframe(pxmitpriv, pxmitframe);
+
+	if  (ret != _SUCCESS)
+		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_UNKNOWN);
+
+	return ret;
+}
+
+static u32 xmitframe_need_length(struct xmit_frame *pxmitframe)
+{
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
+
+	u32 len = 0;
+
+	/*  no consider fragement */
+	len = pattrib->hdrlen + pattrib->iv_len +
+		SNAP_SIZE + sizeof(u16) +
+		pattrib->pktlen +
+		((pattrib->bswenc) ? pattrib->icv_len : 0);
+
+	if (pattrib->encrypt == _TKIP_)
+		len += 8;
+
+	return len;
+}
+
+s32 rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct xmit_frame *pxmitframe = NULL;
+	struct xmit_frame *pfirstframe = NULL;
+
+	/*  aggregate variable */
+	struct hw_xmit *phwxmit;
+	struct sta_info *psta = NULL;
+	struct tx_servq *ptxservq = NULL;
+	struct list_head *xmitframe_plist = NULL, *xmitframe_phead = NULL;
+
+	u32 pbuf;	/*  next pkt address */
+	u32 pbuf_tail;	/*  last pkt tail */
+	u32 len;	/*  packet length, except TXDESC_SIZE and PKT_OFFSET */
+
+	u32 bulksize = haldata->UsbBulkOutSize;
+	u8 desc_cnt;
+	u32 bulkptr;
+
+	/*  dump frame variable */
+	u32 ff_hwaddr;
+
+	RT_TRACE(_module_rtl8192c_xmit_c_, _drv_info_, ("+xmitframe_complete\n"));
+
+	/*  check xmitbuffer is ok */
+	if (pxmitbuf == NULL) {
+		pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
+		if (pxmitbuf == NULL)
+			return false;
+	}
+
+	/* 3 1. pick up first frame */
+	do {
+		rtw_free_xmitframe(pxmitpriv, pxmitframe);
+
+		pxmitframe = rtw_dequeue_xframe(pxmitpriv, pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
+		if (pxmitframe == NULL) {
+			/*  no more xmit frame, release xmit buffer */
+			rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
+			return false;
+		}
+
+		pxmitframe->pxmitbuf = pxmitbuf;
+		pxmitframe->buf_addr = pxmitbuf->pbuf;
+		pxmitbuf->priv_data = pxmitframe;
+
+		pxmitframe->agg_num = 1; /*  alloc xmitframe should assign to 1. */
+		pxmitframe->pkt_offset = 1; /*  first frame of aggregation, reserve offset */
+
+		rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
+
+		/*  always return ndis_packet after rtw_xmitframe_coalesce */
+		rtw_os_xmit_complete(adapt, pxmitframe);
+
+		break;
+	} while (1);
+
+	/* 3 2. aggregate same priority and same DA(AP or STA) frames */
+	pfirstframe = pxmitframe;
+	len = xmitframe_need_length(pfirstframe) + TXDESC_SIZE + (pfirstframe->pkt_offset*PACKET_OFFSET_SZ);
+	pbuf_tail = len;
+	pbuf = _RND8(pbuf_tail);
+
+	/*  check pkt amount in one bulk */
+	desc_cnt = 0;
+	bulkptr = bulksize;
+	if (pbuf < bulkptr) {
+		desc_cnt++;
+	} else {
+		desc_cnt = 0;
+		bulkptr = ((pbuf / bulksize) + 1) * bulksize; /*  round to next bulksize */
+	}
+
+	/*  dequeue same priority packet from station tx queue */
+	psta = pfirstframe->attrib.psta;
+	switch (pfirstframe->attrib.priority) {
+	case 1:
+	case 2:
+		ptxservq = &(psta->sta_xmitpriv.bk_q);
+		phwxmit = pxmitpriv->hwxmits + 3;
+		break;
+	case 4:
+	case 5:
+		ptxservq = &(psta->sta_xmitpriv.vi_q);
+		phwxmit = pxmitpriv->hwxmits + 1;
+		break;
+	case 6:
+	case 7:
+		ptxservq = &(psta->sta_xmitpriv.vo_q);
+		phwxmit = pxmitpriv->hwxmits;
+		break;
+	case 0:
+	case 3:
+	default:
+		ptxservq = &(psta->sta_xmitpriv.be_q);
+		phwxmit = pxmitpriv->hwxmits + 2;
+		break;
+	}
+	spin_lock_bh(&pxmitpriv->lock);
+
+	xmitframe_phead = get_list_head(&ptxservq->sta_pending);
+	xmitframe_plist = xmitframe_phead->next;
+
+	while (xmitframe_phead != xmitframe_plist) {
+		pxmitframe = container_of(xmitframe_plist, struct xmit_frame, list);
+		xmitframe_plist = xmitframe_plist->next;
+
+		pxmitframe->agg_num = 0; /*  not first frame of aggregation */
+		pxmitframe->pkt_offset = 0; /*  not first frame of aggregation, no need to reserve offset */
+
+		len = xmitframe_need_length(pxmitframe) + TXDESC_SIZE + (pxmitframe->pkt_offset*PACKET_OFFSET_SZ);
+
+		if (_RND8(pbuf + len) > MAX_XMITBUF_SZ) {
+			pxmitframe->agg_num = 1;
+			pxmitframe->pkt_offset = 1;
+			break;
+		}
+		list_del_init(&pxmitframe->list);
+		ptxservq->qcnt--;
+		phwxmit->accnt--;
+
+		pxmitframe->buf_addr = pxmitbuf->pbuf + pbuf;
+
+		rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
+		/*  always return ndis_packet after rtw_xmitframe_coalesce */
+		rtw_os_xmit_complete(adapt, pxmitframe);
+
+		/*  (len - TXDESC_SIZE) == pxmitframe->attrib.last_txcmdsz */
+		update_txdesc(pxmitframe, pxmitframe->buf_addr, pxmitframe->attrib.last_txcmdsz, true);
+
+		/*  don't need xmitframe any more */
+		rtw_free_xmitframe(pxmitpriv, pxmitframe);
+
+		/*  handle pointer and stop condition */
+		pbuf_tail = pbuf + len;
+		pbuf = _RND8(pbuf_tail);
+
+		pfirstframe->agg_num++;
+		if (MAX_TX_AGG_PACKET_NUMBER == pfirstframe->agg_num)
+			break;
+
+		if (pbuf < bulkptr) {
+			desc_cnt++;
+			if (desc_cnt == haldata->UsbTxAggDescNum)
+				break;
+		} else {
+			desc_cnt = 0;
+			bulkptr = ((pbuf / bulksize) + 1) * bulksize;
+		}
+	} /* end while (aggregate same priority and same DA(AP or STA) frames) */
+
+	if (list_empty(&ptxservq->sta_pending.queue))
+		list_del_init(&ptxservq->tx_pending);
+
+	spin_unlock_bh(&pxmitpriv->lock);
+	if ((pfirstframe->attrib.ether_type != 0x0806) &&
+	    (pfirstframe->attrib.ether_type != 0x888e) &&
+	    (pfirstframe->attrib.ether_type != 0x88b4) &&
+	    (pfirstframe->attrib.dhcp_pkt != 1))
+		rtw_issue_addbareq_cmd(adapt, pfirstframe);
+	/* 3 3. update first frame txdesc */
+	if ((pbuf_tail % bulksize) == 0) {
+		/*  remove pkt_offset */
+		pbuf_tail -= PACKET_OFFSET_SZ;
+		pfirstframe->buf_addr += PACKET_OFFSET_SZ;
+		pfirstframe->pkt_offset--;
+	}
+
+	update_txdesc(pfirstframe, pfirstframe->buf_addr, pfirstframe->attrib.last_txcmdsz, true);
+
+	/* 3 4. write xmit buffer to USB FIFO */
+	ff_hwaddr = rtw_get_ff_hwaddr(pfirstframe);
+	rtw_write_port(adapt, ff_hwaddr, pbuf_tail, (u8 *)pxmitbuf);
+
+	/* 3 5. update statisitc */
+	pbuf_tail -= (pfirstframe->agg_num * TXDESC_SIZE);
+	pbuf_tail -= (pfirstframe->pkt_offset * PACKET_OFFSET_SZ);
+
+	rtw_count_tx_stats(adapt, pfirstframe, pbuf_tail);
+
+	rtw_free_xmitframe(pxmitpriv, pfirstframe);
+
+	return true;
+}
+
+static s32 xmitframe_direct(struct adapter *adapt, struct xmit_frame *pxmitframe)
+{
+	s32 res = _SUCCESS;
+
+	res = rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
+	if (res == _SUCCESS)
+		rtw_dump_xframe(adapt, pxmitframe);
+	else
+		DBG_88E("==> %s xmitframe_coalsece failed\n", __func__);
+	return res;
+}
+
+/*
+ * Return
+ *	true	dump packet directly
+ *	false	enqueue packet
+ */
+static s32 pre_xmitframe(struct adapter *adapt, struct xmit_frame *pxmitframe)
+{
+	s32 res;
+	struct xmit_buf *pxmitbuf = NULL;
+	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
+	struct mlme_priv *pmlmepriv = &adapt->mlmepriv;
+
+	spin_lock_bh(&pxmitpriv->lock);
+
+	if (rtw_txframes_sta_ac_pending(adapt, pattrib) > 0)
+		goto enqueue;
+
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY|_FW_UNDER_LINKING) == true)
+		goto enqueue;
+
+	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
+	if (pxmitbuf == NULL)
+		goto enqueue;
+
+	spin_unlock_bh(&pxmitpriv->lock);
+
+	pxmitframe->pxmitbuf = pxmitbuf;
+	pxmitframe->buf_addr = pxmitbuf->pbuf;
+	pxmitbuf->priv_data = pxmitframe;
+
+	if (xmitframe_direct(adapt, pxmitframe) != _SUCCESS) {
+		rtw_free_xmitbuf(pxmitpriv, pxmitbuf);
+		rtw_free_xmitframe(pxmitpriv, pxmitframe);
+	}
+
+	return true;
+
+enqueue:
+	res = rtw_xmitframe_enqueue(adapt, pxmitframe);
+	spin_unlock_bh(&pxmitpriv->lock);
+
+	if (res != _SUCCESS) {
+		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("pre_xmitframe: enqueue xmitframe fail\n"));
+		rtw_free_xmitframe(pxmitpriv, pxmitframe);
+
+		/*  Trick, make the statistics correct */
+		pxmitpriv->tx_pkts--;
+		pxmitpriv->tx_drop++;
+		return true;
+	}
+
+	return false;
+}
+
+s32 rtl8188eu_mgnt_xmit(struct adapter *adapt, struct xmit_frame *pmgntframe)
+{
+	return rtw_dump_xframe(adapt, pmgntframe);
+}
+
+/*
+ * Return
+ *	true	dump packet directly ok
+ *	false	temporary can't transmit packets to hardware
+ */
+s32 rtl8188eu_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
+{
+	return pre_xmitframe(adapt, pxmitframe);
+}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
new file mode 100644
index 000000000000..144cc5f6787d
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -0,0 +1,2334 @@
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
+#define _HCI_HAL_INIT_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <rtw_efuse.h>
+
+#include <rtl8188e_hal.h>
+#include <rtl8188e_led.h>
+#include <rtw_iol.h>
+#include <usb_ops.h>
+#include <usb_hal.h>
+#include <usb_osintf.h>
+
+#define		HAL_MAC_ENABLE	1
+#define		HAL_BB_ENABLE		1
+#define		HAL_RF_ENABLE		1
+
+static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
+{
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+
+	switch (NumOutPipe) {
+	case	3:
+		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_LQ | TX_SELE_NQ;
+		haldata->OutEpNumber = 3;
+		break;
+	case	2:
+		haldata->OutEpQueueSel = TX_SELE_HQ | TX_SELE_NQ;
+		haldata->OutEpNumber = 2;
+		break;
+	case	1:
+		haldata->OutEpQueueSel = TX_SELE_HQ;
+		haldata->OutEpNumber = 1;
+		break;
+	default:
+		break;
+	}
+	DBG_88E("%s OutEpQueueSel(0x%02x), OutEpNumber(%d)\n", __func__, haldata->OutEpQueueSel, haldata->OutEpNumber);
+}
+
+static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumInPipe, u8 NumOutPipe)
+{
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	bool			result		= false;
+
+	_ConfigNormalChipOutEP_8188E(adapt, NumOutPipe);
+
+	/*  Normal chip with one IN and one OUT doesn't have interrupt IN EP. */
+	if (1 == haldata->OutEpNumber) {
+		if (1 != NumInPipe)
+			return result;
+	}
+
+	/*  All config other than above support one Bulk IN and one Interrupt IN. */
+
+	result = Hal_MappingOutPipe(adapt, NumOutPipe);
+
+	return result;
+}
+
+static void rtl8188eu_interface_configure(struct adapter *adapt)
+{
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	struct dvobj_priv	*pdvobjpriv = adapter_to_dvobj(adapt);
+
+	if (pdvobjpriv->ishighspeed)
+		haldata->UsbBulkOutSize = USB_HIGH_SPEED_BULK_SIZE;/* 512 bytes */
+	else
+		haldata->UsbBulkOutSize = USB_FULL_SPEED_BULK_SIZE;/* 64 bytes */
+
+	haldata->interfaceIndex = pdvobjpriv->InterfaceNumber;
+
+	haldata->UsbTxAggMode		= 1;
+	haldata->UsbTxAggDescNum	= 0x6;	/*  only 4 bits */
+
+	haldata->UsbRxAggMode		= USB_RX_AGG_DMA;/*  USB_RX_AGG_DMA; */
+	haldata->UsbRxAggBlockCount	= 8; /* unit : 512b */
+	haldata->UsbRxAggBlockTimeout	= 0x6;
+	haldata->UsbRxAggPageCount	= 48; /* uint :128 b 0x0A;	10 = MAX_RX_DMA_BUFFER_SIZE/2/haldata->UsbBulkOutSize */
+	haldata->UsbRxAggPageTimeout	= 0x4; /* 6, absolute time = 34ms/(2^6) */
+
+	HalUsbSetQueuePipeMapping8188EUsb(adapt,
+				pdvobjpriv->RtNumInPipes, pdvobjpriv->RtNumOutPipes);
+}
+
+static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
+{
+	u16 value16;
+	/*  HW Power on sequence */
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	if (haldata->bMacPwrCtrlOn)
+		return _SUCCESS;
+
+	if (!HalPwrSeqCmdParsing(adapt, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_PWR_ON_FLOW)) {
+		DBG_88E(KERN_ERR "%s: run power on flow fail\n", __func__);
+		return _FAIL;
+	}
+
+	/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
+	/*  Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
+	rtw_write16(adapt, REG_CR, 0x00);  /* suggseted by zhouzhou, by page, 20111230 */
+
+		/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
+	value16 = rtw_read16(adapt, REG_CR);
+	value16 |= (HCI_TXDMA_EN | HCI_RXDMA_EN | TXDMA_EN | RXDMA_EN
+				| PROTOCOL_EN | SCHEDULE_EN | ENSEC | CALTMR_EN);
+	/*  for SDIO - Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
+
+	rtw_write16(adapt, REG_CR, value16);
+	haldata->bMacPwrCtrlOn = true;
+
+	return _SUCCESS;
+}
+
+/*  Shall USB interface init this? */
+static void _InitInterrupt(struct adapter *Adapter)
+{
+	u32 imr, imr_ex;
+	u8  usb_opt;
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	/* HISR write one to clear */
+	rtw_write32(Adapter, REG_HISR_88E, 0xFFFFFFFF);
+	/*  HIMR - */
+	imr = IMR_PSTIMEOUT_88E | IMR_TBDER_88E | IMR_CPWM_88E | IMR_CPWM2_88E;
+	rtw_write32(Adapter, REG_HIMR_88E, imr);
+	haldata->IntrMask[0] = imr;
+
+	imr_ex = IMR_TXERR_88E | IMR_RXERR_88E | IMR_TXFOVW_88E | IMR_RXFOVW_88E;
+	rtw_write32(Adapter, REG_HIMRE_88E, imr_ex);
+	haldata->IntrMask[1] = imr_ex;
+
+	/*  REG_USB_SPECIAL_OPTION - BIT(4) */
+	/*  0; Use interrupt endpoint to upload interrupt pkt */
+	/*  1; Use bulk endpoint to upload interrupt pkt, */
+	usb_opt = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
+
+	if (!adapter_to_dvobj(Adapter)->ishighspeed)
+		usb_opt = usb_opt & (~INT_BULK_SEL);
+	else
+		usb_opt = usb_opt | (INT_BULK_SEL);
+
+	rtw_write8(Adapter, REG_USB_SPECIAL_OPTION, usb_opt);
+}
+
+static void _InitQueueReservedPage(struct adapter *Adapter)
+{
+	struct hal_data_8188e		*haldata = GET_HAL_DATA(Adapter);
+	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
+	u32 numHQ	= 0;
+	u32 numLQ	= 0;
+	u32 numNQ	= 0;
+	u32 numPubQ;
+	u32 value32;
+	u8 value8;
+	bool bWiFiConfig = pregistrypriv->wifi_spec;
+
+	if (bWiFiConfig) {
+		if (haldata->OutEpQueueSel & TX_SELE_HQ)
+			numHQ =  0x29;
+
+		if (haldata->OutEpQueueSel & TX_SELE_LQ)
+			numLQ = 0x1C;
+
+		/*  NOTE: This step shall be proceed before writting REG_RQPN. */
+		if (haldata->OutEpQueueSel & TX_SELE_NQ)
+			numNQ = 0x1C;
+		value8 = (u8)_NPQ(numNQ);
+		rtw_write8(Adapter, REG_RQPN_NPQ, value8);
+
+		numPubQ = 0xA8 - numHQ - numLQ - numNQ;
+
+		/*  TX DMA */
+		value32 = _HPQ(numHQ) | _LPQ(numLQ) | _PUBQ(numPubQ) | LD_RQPN;
+		rtw_write32(Adapter, REG_RQPN, value32);
+	} else {
+		rtw_write16(Adapter, REG_RQPN_NPQ, 0x0000);/* Just follow MP Team,??? Georgia 03/28 */
+		rtw_write16(Adapter, REG_RQPN_NPQ, 0x0d);
+		rtw_write32(Adapter, REG_RQPN, 0x808E000d);/* reserve 7 page for LPS */
+	}
+}
+
+static void _InitTxBufferBoundary(struct adapter *Adapter, u8 txpktbuf_bndy)
+{
+	rtw_write8(Adapter, REG_TXPKTBUF_BCNQ_BDNY, txpktbuf_bndy);
+	rtw_write8(Adapter, REG_TXPKTBUF_MGQ_BDNY, txpktbuf_bndy);
+	rtw_write8(Adapter, REG_TXPKTBUF_WMAC_LBK_BF_HD, txpktbuf_bndy);
+	rtw_write8(Adapter, REG_TRXFF_BNDY, txpktbuf_bndy);
+	rtw_write8(Adapter, REG_TDECTRL+1, txpktbuf_bndy);
+}
+
+static void _InitPageBoundary(struct adapter *Adapter)
+{
+	/*  RX Page Boundary */
+	/*  */
+	u16 rxff_bndy = MAX_RX_DMA_BUFFER_SIZE_88E-1;
+
+	rtw_write16(Adapter, (REG_TRXFF_BNDY + 2), rxff_bndy);
+}
+
+static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
+				       u16 bkQ, u16 viQ, u16 voQ, u16 mgtQ,
+				       u16 hiQ)
+{
+	u16 value16	= (rtw_read16(Adapter, REG_TRXDMA_CTRL) & 0x7);
+
+	value16 |= _TXDMA_BEQ_MAP(beQ)	| _TXDMA_BKQ_MAP(bkQ) |
+		   _TXDMA_VIQ_MAP(viQ)	| _TXDMA_VOQ_MAP(voQ) |
+		   _TXDMA_MGQ_MAP(mgtQ) | _TXDMA_HIQ_MAP(hiQ);
+
+	rtw_write16(Adapter, REG_TRXDMA_CTRL, value16);
+}
+
+static void _InitNormalChipOneOutEpPriority(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+
+	u16 value = 0;
+	switch (haldata->OutEpQueueSel) {
+	case TX_SELE_HQ:
+		value = QUEUE_HIGH;
+		break;
+	case TX_SELE_LQ:
+		value = QUEUE_LOW;
+		break;
+	case TX_SELE_NQ:
+		value = QUEUE_NORMAL;
+		break;
+	default:
+		break;
+	}
+	_InitNormalChipRegPriority(Adapter, value, value, value, value,
+				   value, value);
+}
+
+static void _InitNormalChipTwoOutEpPriority(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	struct registry_priv *pregistrypriv = &Adapter->registrypriv;
+	u16 beQ, bkQ, viQ, voQ, mgtQ, hiQ;
+	u16 valueHi = 0;
+	u16 valueLow = 0;
+
+	switch (haldata->OutEpQueueSel) {
+	case (TX_SELE_HQ | TX_SELE_LQ):
+		valueHi = QUEUE_HIGH;
+		valueLow = QUEUE_LOW;
+		break;
+	case (TX_SELE_NQ | TX_SELE_LQ):
+		valueHi = QUEUE_NORMAL;
+		valueLow = QUEUE_LOW;
+		break;
+	case (TX_SELE_HQ | TX_SELE_NQ):
+		valueHi = QUEUE_HIGH;
+		valueLow = QUEUE_NORMAL;
+		break;
+	default:
+		break;
+	}
+
+	if (!pregistrypriv->wifi_spec) {
+		beQ	= valueLow;
+		bkQ	= valueLow;
+		viQ	= valueHi;
+		voQ	= valueHi;
+		mgtQ	= valueHi;
+		hiQ	= valueHi;
+	} else {/* for WMM ,CONFIG_OUT_EP_WIFI_MODE */
+		beQ	= valueLow;
+		bkQ	= valueHi;
+		viQ	= valueHi;
+		voQ	= valueLow;
+		mgtQ	= valueHi;
+		hiQ	= valueHi;
+	}
+	_InitNormalChipRegPriority(Adapter, beQ, bkQ, viQ, voQ, mgtQ, hiQ);
+}
+
+static void _InitNormalChipThreeOutEpPriority(struct adapter *Adapter)
+{
+	struct registry_priv *pregistrypriv = &Adapter->registrypriv;
+	u16 beQ, bkQ, viQ, voQ, mgtQ, hiQ;
+
+	if (!pregistrypriv->wifi_spec) {/*  typical setting */
+		beQ	= QUEUE_LOW;
+		bkQ	= QUEUE_LOW;
+		viQ	= QUEUE_NORMAL;
+		voQ	= QUEUE_HIGH;
+		mgtQ	= QUEUE_HIGH;
+		hiQ	= QUEUE_HIGH;
+	} else {/*  for WMM */
+		beQ	= QUEUE_LOW;
+		bkQ	= QUEUE_NORMAL;
+		viQ	= QUEUE_NORMAL;
+		voQ	= QUEUE_HIGH;
+		mgtQ	= QUEUE_HIGH;
+		hiQ	= QUEUE_HIGH;
+	}
+	_InitNormalChipRegPriority(Adapter, beQ, bkQ, viQ, voQ, mgtQ, hiQ);
+}
+
+static void _InitQueuePriority(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	switch (haldata->OutEpNumber) {
+	case 1:
+		_InitNormalChipOneOutEpPriority(Adapter);
+		break;
+	case 2:
+		_InitNormalChipTwoOutEpPriority(Adapter);
+		break;
+	case 3:
+		_InitNormalChipThreeOutEpPriority(Adapter);
+		break;
+	default:
+		break;
+	}
+}
+
+static void _InitNetworkType(struct adapter *Adapter)
+{
+	u32 value32;
+
+	value32 = rtw_read32(Adapter, REG_CR);
+	/*  TODO: use the other function to set network type */
+	value32 = (value32 & ~MASK_NETTYPE) | _NETTYPE(NT_LINK_AP);
+
+	rtw_write32(Adapter, REG_CR, value32);
+}
+
+static void _InitTransferPageSize(struct adapter *Adapter)
+{
+	/*  Tx page size is always 128. */
+
+	u8 value8;
+	value8 = _PSRX(PBP_128) | _PSTX(PBP_128);
+	rtw_write8(Adapter, REG_PBP, value8);
+}
+
+static void _InitDriverInfoSize(struct adapter *Adapter, u8 drvInfoSize)
+{
+	rtw_write8(Adapter, REG_RX_DRVINFO_SZ, drvInfoSize);
+}
+
+static void _InitWMACSetting(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	haldata->ReceiveConfig = RCR_AAP | RCR_APM | RCR_AM | RCR_AB |
+				  RCR_CBSSID_DATA | RCR_CBSSID_BCN |
+				  RCR_APP_ICV | RCR_AMF | RCR_HTC_LOC_CTRL |
+				  RCR_APP_MIC | RCR_APP_PHYSTS;
+
+	/*  some REG_RCR will be modified later by phy_ConfigMACWithHeaderFile() */
+	rtw_write32(Adapter, REG_RCR, haldata->ReceiveConfig);
+
+	/*  Accept all multicast address */
+	rtw_write32(Adapter, REG_MAR, 0xFFFFFFFF);
+	rtw_write32(Adapter, REG_MAR + 4, 0xFFFFFFFF);
+}
+
+static void _InitAdaptiveCtrl(struct adapter *Adapter)
+{
+	u16 value16;
+	u32 value32;
+
+	/*  Response Rate Set */
+	value32 = rtw_read32(Adapter, REG_RRSR);
+	value32 &= ~RATE_BITMAP_ALL;
+	value32 |= RATE_RRSR_CCK_ONLY_1M;
+	rtw_write32(Adapter, REG_RRSR, value32);
+
+	/*  CF-END Threshold */
+
+	/*  SIFS (used in NAV) */
+	value16 = _SPEC_SIFS_CCK(0x10) | _SPEC_SIFS_OFDM(0x10);
+	rtw_write16(Adapter, REG_SPEC_SIFS, value16);
+
+	/*  Retry Limit */
+	value16 = _LRL(0x30) | _SRL(0x30);
+	rtw_write16(Adapter, REG_RL, value16);
+}
+
+static void _InitEDCA(struct adapter *Adapter)
+{
+	/*  Set Spec SIFS (used in NAV) */
+	rtw_write16(Adapter, REG_SPEC_SIFS, 0x100a);
+	rtw_write16(Adapter, REG_MAC_SPEC_SIFS, 0x100a);
+
+	/*  Set SIFS for CCK */
+	rtw_write16(Adapter, REG_SIFS_CTX, 0x100a);
+
+	/*  Set SIFS for OFDM */
+	rtw_write16(Adapter, REG_SIFS_TRX, 0x100a);
+
+	/*  TXOP */
+	rtw_write32(Adapter, REG_EDCA_BE_PARAM, 0x005EA42B);
+	rtw_write32(Adapter, REG_EDCA_BK_PARAM, 0x0000A44F);
+	rtw_write32(Adapter, REG_EDCA_VI_PARAM, 0x005EA324);
+	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
+}
+
+static void _InitBeaconMaxError(struct adapter *Adapter, bool		InfraMode)
+{
+}
+
+static void _InitHWLed(struct adapter *Adapter)
+{
+	struct led_priv *pledpriv = &(Adapter->ledpriv);
+
+	if (pledpriv->LedStrategy != HW_LED)
+		return;
+
+/*  HW led control */
+/*  to do .... */
+/* must consider cases of antenna diversity/ commbo card/solo card/mini card */
+}
+
+static void _InitRDGSetting(struct adapter *Adapter)
+{
+	rtw_write8(Adapter, REG_RD_CTRL, 0xFF);
+	rtw_write16(Adapter, REG_RD_NAV_NXT, 0x200);
+	rtw_write8(Adapter, REG_RD_RESP_PKT_TH, 0x05);
+}
+
+static void _InitRxSetting(struct adapter *Adapter)
+{
+	rtw_write32(Adapter, REG_MACID, 0x87654321);
+	rtw_write32(Adapter, 0x0700, 0x87654321);
+}
+
+static void _InitRetryFunction(struct adapter *Adapter)
+{
+	u8 value8;
+
+	value8 = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL);
+	value8 |= EN_AMPDU_RTY_NEW;
+	rtw_write8(Adapter, REG_FWHW_TXQ_CTRL, value8);
+
+	/*  Set ACK timeout */
+	rtw_write8(Adapter, REG_ACKTO, 0x40);
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:	usb_AggSettingTxUpdate()
+ *
+ * Overview:	Separate TX/RX parameters update independent for TP detection and
+ *			dynamic TX/RX aggreagtion parameters update.
+ *
+ * Input:			struct adapter *
+ *
+ * Output/Return:	NONE
+ *
+ * Revised History:
+ *	When		Who		Remark
+ *	12/10/2010	MHC		Separate to smaller function.
+ *
+ *---------------------------------------------------------------------------*/
+static void usb_AggSettingTxUpdate(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	u32 value32;
+
+	if (Adapter->registrypriv.wifi_spec)
+		haldata->UsbTxAggMode = false;
+
+	if (haldata->UsbTxAggMode) {
+		value32 = rtw_read32(Adapter, REG_TDECTRL);
+		value32 = value32 & ~(BLK_DESC_NUM_MASK << BLK_DESC_NUM_SHIFT);
+		value32 |= ((haldata->UsbTxAggDescNum & BLK_DESC_NUM_MASK) << BLK_DESC_NUM_SHIFT);
+
+		rtw_write32(Adapter, REG_TDECTRL, value32);
+	}
+}	/*  usb_AggSettingTxUpdate */
+
+/*-----------------------------------------------------------------------------
+ * Function:	usb_AggSettingRxUpdate()
+ *
+ * Overview:	Separate TX/RX parameters update independent for TP detection and
+ *			dynamic TX/RX aggreagtion parameters update.
+ *
+ * Input:			struct adapter *
+ *
+ * Output/Return:	NONE
+ *
+ * Revised History:
+ *	When		Who		Remark
+ *	12/10/2010	MHC		Separate to smaller function.
+ *
+ *---------------------------------------------------------------------------*/
+static void
+usb_AggSettingRxUpdate(
+		struct adapter *Adapter
+	)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	u8 valueDMA;
+	u8 valueUSB;
+
+	valueDMA = rtw_read8(Adapter, REG_TRXDMA_CTRL);
+	valueUSB = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
+
+	switch (haldata->UsbRxAggMode) {
+	case USB_RX_AGG_DMA:
+		valueDMA |= RXDMA_AGG_EN;
+		valueUSB &= ~USB_AGG_EN;
+		break;
+	case USB_RX_AGG_USB:
+		valueDMA &= ~RXDMA_AGG_EN;
+		valueUSB |= USB_AGG_EN;
+		break;
+	case USB_RX_AGG_MIX:
+		valueDMA |= RXDMA_AGG_EN;
+		valueUSB |= USB_AGG_EN;
+		break;
+	case USB_RX_AGG_DISABLE:
+	default:
+		valueDMA &= ~RXDMA_AGG_EN;
+		valueUSB &= ~USB_AGG_EN;
+		break;
+	}
+
+	rtw_write8(Adapter, REG_TRXDMA_CTRL, valueDMA);
+	rtw_write8(Adapter, REG_USB_SPECIAL_OPTION, valueUSB);
+
+	switch (haldata->UsbRxAggMode) {
+	case USB_RX_AGG_DMA:
+		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
+		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH+1, haldata->UsbRxAggPageTimeout);
+		break;
+	case USB_RX_AGG_USB:
+		rtw_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
+		rtw_write8(Adapter, REG_USB_AGG_TO, haldata->UsbRxAggBlockTimeout);
+		break;
+	case USB_RX_AGG_MIX:
+		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, haldata->UsbRxAggPageCount);
+		rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH+1, (haldata->UsbRxAggPageTimeout & 0x1F));/* 0x280[12:8] */
+		rtw_write8(Adapter, REG_USB_AGG_TH, haldata->UsbRxAggBlockCount);
+		rtw_write8(Adapter, REG_USB_AGG_TO, haldata->UsbRxAggBlockTimeout);
+		break;
+	case USB_RX_AGG_DISABLE:
+	default:
+		/*  TODO: */
+		break;
+	}
+
+	switch (PBP_128) {
+	case PBP_128:
+		haldata->HwRxPageSize = 128;
+		break;
+	case PBP_64:
+		haldata->HwRxPageSize = 64;
+		break;
+	case PBP_256:
+		haldata->HwRxPageSize = 256;
+		break;
+	case PBP_512:
+		haldata->HwRxPageSize = 512;
+		break;
+	case PBP_1024:
+		haldata->HwRxPageSize = 1024;
+		break;
+	default:
+		break;
+	}
+}	/*  usb_AggSettingRxUpdate */
+
+static void InitUsbAggregationSetting(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	/*  Tx aggregation setting */
+	usb_AggSettingTxUpdate(Adapter);
+
+	/*  Rx aggregation setting */
+	usb_AggSettingRxUpdate(Adapter);
+
+	/*  201/12/10 MH Add for USB agg mode dynamic switch. */
+	haldata->UsbRxHighSpeedMode = false;
+}
+
+static void _InitOperationMode(struct adapter *Adapter)
+{
+}
+
+static void _InitBeaconParameters(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	rtw_write16(Adapter, REG_BCN_CTRL, 0x1010);
+
+	/*  TODO: Remove these magic number */
+	rtw_write16(Adapter, REG_TBTT_PROHIBIT, 0x6404);/*  ms */
+	rtw_write8(Adapter, REG_DRVERLYINT, DRIVER_EARLY_INT_TIME);/*  5ms */
+	rtw_write8(Adapter, REG_BCNDMATIM, BCN_DMA_ATIME_INT_TIME); /*  2ms */
+
+	/*  Suggested by designer timchen. Change beacon AIFS to the largest number */
+	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
+	rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
+
+	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
+	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE);
+	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL+2);
+	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT+2);
+	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR+1);
+}
+
+static void _BeaconFunctionEnable(struct adapter *Adapter,
+				  bool Enable, bool Linked)
+{
+	rtw_write8(Adapter, REG_BCN_CTRL, (BIT4 | BIT3 | BIT1));
+
+	rtw_write8(Adapter, REG_RD_CTRL+1, 0x6F);
+}
+
+/*  Set CCK and OFDM Block "ON" */
+static void _BBTurnOnBlock(struct adapter *Adapter)
+{
+	PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bCCKEn, 0x1);
+	PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
+}
+
+enum {
+	Antenna_Lfet = 1,
+	Antenna_Right = 2,
+};
+
+static void _InitAntenna_Selection(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+
+	if (haldata->AntDivCfg == 0)
+		return;
+	DBG_88E("==>  %s ....\n", __func__);
+
+	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0)|BIT23);
+	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT13, 0x01);
+
+	if (PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
+		haldata->CurAntenna = Antenna_A;
+	else
+		haldata->CurAntenna = Antenna_B;
+	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
+}
+
+/*-----------------------------------------------------------------------------
+ * Function:	HwSuspendModeEnable92Cu()
+ *
+ * Overview:	HW suspend mode switch.
+ *
+ * Input:		NONE
+ *
+ * Output:	NONE
+ *
+ * Return:	NONE
+ *
+ * Revised History:
+ *	When		Who		Remark
+ *	08/23/2010	MHC		HW suspend mode switch test..
+ *---------------------------------------------------------------------------*/
+enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
+{
+	u8 val8;
+	enum rt_rf_power_state rfpowerstate = rf_off;
+
+	if (adapt->pwrctrlpriv.bHWPowerdown) {
+		val8 = rtw_read8(adapt, REG_HSISR);
+		DBG_88E("pwrdown, 0x5c(BIT7)=%02x\n", val8);
+		rfpowerstate = (val8 & BIT7) ? rf_off : rf_on;
+	} else { /*  rf on/off */
+		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG)&~(BIT3));
+		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL);
+		DBG_88E("GPIO_IN=%02x\n", val8);
+		rfpowerstate = (val8 & BIT3) ? rf_on : rf_off;
+	}
+	return rfpowerstate;
+}	/*  HalDetectPwrDownMode */
+
+static u32 rtl8188eu_hal_init(struct adapter *Adapter)
+{
+	u8 value8 = 0;
+	u16  value16;
+	u8 txpktbuf_bndy;
+	u32 status = _SUCCESS;
+	struct hal_data_8188e		*haldata = GET_HAL_DATA(Adapter);
+	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
+	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
+	u32 init_start_time = jiffies;
+
+	#define HAL_INIT_PROFILE_TAG(stage) do {} while (0)
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BEGIN);
+
+	if (Adapter->pwrctrlpriv.bkeepfwalive) {
+		_ps_open_RF(Adapter);
+
+		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
+			PHY_IQCalibrate_8188E(Adapter, true);
+		} else {
+			PHY_IQCalibrate_8188E(Adapter, false);
+			haldata->odmpriv.RFCalibrateInfo.bIQKInitialized = true;
+		}
+
+		ODM_TXPowerTrackingCheck(&haldata->odmpriv);
+		PHY_LCCalibrate_8188E(Adapter);
+
+		goto exit;
+	}
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PW_ON);
+	status = rtl8188eu_InitPowerOn(Adapter);
+	if (status == _FAIL) {
+		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init power on!\n"));
+		goto exit;
+	}
+
+	/*  Save target channel */
+	haldata->CurrentChannel = 6;/* default set to 6 */
+
+	if (pwrctrlpriv->reg_rfoff) {
+		pwrctrlpriv->rf_pwrstate = rf_off;
+	}
+
+	/*  2010/08/09 MH We need to check if we need to turnon or off RF after detecting */
+	/*  HW GPIO pin. Before PHY_RFConfig8192C. */
+	/*  2010/08/26 MH If Efuse does not support sective suspend then disable the function. */
+
+	if (!pregistrypriv->wifi_spec) {
+		txpktbuf_bndy = TX_PAGE_BOUNDARY_88E;
+	} else {
+		/*  for WMM */
+		txpktbuf_bndy = WMM_NORMAL_TX_PAGE_BOUNDARY_88E;
+	}
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC01);
+	_InitQueueReservedPage(Adapter);
+	_InitQueuePriority(Adapter);
+	_InitPageBoundary(Adapter);
+	_InitTransferPageSize(Adapter);
+
+	_InitTxBufferBoundary(Adapter, 0);
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_DOWNLOAD_FW);
+	if (Adapter->registrypriv.mp_mode == 1) {
+		_InitRxSetting(Adapter);
+		Adapter->bFWReady = false;
+		haldata->fw_ractrl = false;
+	} else {
+		status = rtl8188e_FirmwareDownload(Adapter);
+
+		if (status != _SUCCESS) {
+			DBG_88E("%s: Download Firmware failed!!\n", __func__);
+			Adapter->bFWReady = false;
+			haldata->fw_ractrl = false;
+			return status;
+		} else {
+			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializeadapt8192CSdio(): Download Firmware Success!!\n"));
+			Adapter->bFWReady = true;
+			haldata->fw_ractrl = false;
+		}
+	}
+	rtl8188e_InitializeFirmwareVars(Adapter);
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MAC);
+#if (HAL_MAC_ENABLE == 1)
+	status = PHY_MACConfig8188E(Adapter);
+	if (status == _FAIL) {
+		DBG_88E(" ### Failed to init MAC ......\n ");
+		goto exit;
+	}
+#endif
+
+	/*  */
+	/* d. Initialize BB related configurations. */
+	/*  */
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BB);
+#if (HAL_BB_ENABLE == 1)
+	status = PHY_BBConfig8188E(Adapter);
+	if (status == _FAIL) {
+		DBG_88E(" ### Failed to init BB ......\n ");
+		goto exit;
+	}
+#endif
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_RF);
+#if (HAL_RF_ENABLE == 1)
+	status = PHY_RFConfig8188E(Adapter);
+	if (status == _FAIL) {
+		DBG_88E(" ### Failed to init RF ......\n ");
+		goto exit;
+	}
+#endif
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_EFUSE_PATCH);
+	status = rtl8188e_iol_efuse_patch(Adapter);
+	if (status == _FAIL) {
+		DBG_88E("%s  rtl8188e_iol_efuse_patch failed\n", __func__);
+		goto exit;
+	}
+
+	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_LLTT);
+	status =  InitLLTTable(Adapter, txpktbuf_bndy);
+	if (status == _FAIL) {
+		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init LLT table\n"));
+		goto exit;
+	}
+
+	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC02);
+	/*  Get Rx PHY status in order to report RSSI and others. */
+	_InitDriverInfoSize(Adapter, DRVINFO_SZ);
+
+	_InitInterrupt(Adapter);
+	hal_init_macaddr(Adapter);/* set mac_address */
+	_InitNetworkType(Adapter);/* set msr */
+	_InitWMACSetting(Adapter);
+	_InitAdaptiveCtrl(Adapter);
+	_InitEDCA(Adapter);
+	_InitRetryFunction(Adapter);
+	InitUsbAggregationSetting(Adapter);
+	_InitOperationMode(Adapter);/* todo */
+	_InitBeaconParameters(Adapter);
+	_InitBeaconMaxError(Adapter, true);
+
+	/*  */
+	/*  Init CR MACTXEN, MACRXEN after setting RxFF boundary REG_TRXFF_BNDY to patch */
+	/*  Hw bug which Hw initials RxFF boundary size to a value which is larger than the real Rx buffer size in 88E. */
+	/*  */
+	/*  Enable MACTXEN/MACRXEN block */
+	value16 = rtw_read16(Adapter, REG_CR);
+	value16 |= (MACTXEN | MACRXEN);
+	rtw_write8(Adapter, REG_CR, value16);
+
+	if (haldata->bRDGEnable)
+		_InitRDGSetting(Adapter);
+
+	/* Enable TX Report */
+	/* Enable Tx Report Timer */
+	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
+	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8|BIT1|BIT0));
+	/* Set MAX RPT MACID */
+	rtw_write8(Adapter,  REG_TX_RPT_CTRL+1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
+	/* Tx RPT Timer. Unit: 32us */
+	rtw_write16(Adapter, REG_TX_RPT_TIME, 0xCdf0);
+
+	rtw_write8(Adapter, REG_EARLY_MODE_CONTROL, 0);
+
+	rtw_write16(Adapter, REG_PKT_VO_VI_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
+	rtw_write16(Adapter, REG_PKT_BE_BK_LIFE_TIME, 0x0400);	/*  unit: 256us. 256ms */
+
+	_InitHWLed(Adapter);
+
+	/* Keep RfRegChnlVal for later use. */
+	haldata->RfRegChnlVal[0] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)0, RF_CHNLBW, bRFRegOffsetMask);
+	haldata->RfRegChnlVal[1] = PHY_QueryRFReg(Adapter, (enum rf_radio_path)1, RF_CHNLBW, bRFRegOffsetMask);
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_TURN_ON_BLOCK);
+	_BBTurnOnBlock(Adapter);
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_SECURITY);
+	invalidate_cam_all(Adapter);
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC11);
+	/*  2010/12/17 MH We need to set TX power according to EFUSE content at first. */
+	PHY_SetTxPowerLevel8188E(Adapter, haldata->CurrentChannel);
+
+/*  Move by Neo for USB SS to below setp */
+/* _RfPowerSave(Adapter); */
+
+	_InitAntenna_Selection(Adapter);
+
+	/*  */
+	/*  Disable BAR, suggested by Scott */
+	/*  2010.04.09 add by hpfan */
+	/*  */
+	rtw_write32(Adapter, REG_BAR_MODE_CTRL, 0x0201ffff);
+
+	/*  HW SEQ CTRL */
+	/* set 0x0 to 0xFF by tynli. Default enable HW SEQ NUM. */
+	rtw_write8(Adapter, REG_HWSEQ_CTRL, 0xFF);
+
+	if (pregistrypriv->wifi_spec)
+		rtw_write16(Adapter, REG_FAST_EDCA_CTRL, 0);
+
+	/* Nav limit , suggest by scott */
+	rtw_write8(Adapter, 0x652, 0x0);
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_HAL_DM);
+	rtl8188e_InitHalDm(Adapter);
+
+	if (Adapter->registrypriv.mp_mode == 1) {
+		Adapter->mppriv.channel = haldata->CurrentChannel;
+		MPT_InitializeAdapter(Adapter, Adapter->mppriv.channel);
+	} else {
+		/*  2010/08/11 MH Merge from 8192SE for Minicard init. We need to confirm current radio status */
+		/*  and then decide to enable RF or not.!!!??? For Selective suspend mode. We may not */
+		/*  call initstruct adapter. May cause some problem?? */
+		/*  Fix the bug that Hw/Sw radio off before S3/S4, the RF off action will not be executed */
+		/*  in MgntActSet_RF_State() after wake up, because the value of haldata->eRFPowerState */
+		/*  is the same as eRfOff, we should change it to eRfOn after we config RF parameters. */
+		/*  Added by tynli. 2010.03.30. */
+		pwrctrlpriv->rf_pwrstate = rf_on;
+
+		/*  enable Tx report. */
+		rtw_write8(Adapter,  REG_FWHW_TXQ_CTRL+1, 0x0F);
+
+		/*  Suggested by SD1 pisa. Added by tynli. 2011.10.21. */
+		rtw_write8(Adapter, REG_EARLY_MODE_CONTROL+3, 0x01);/* Pretx_en, for WEP/TKIP SEC */
+
+		/* tynli_test_tx_report. */
+		rtw_write16(Adapter, REG_TX_RPT_TIME, 0x3DF0);
+
+		/* enable tx DMA to drop the redundate data of packet */
+		rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
+		/*  2010/08/26 MH Merge from 8192CE. */
+		if (pwrctrlpriv->rf_pwrstate == rf_on) {
+			if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
+				PHY_IQCalibrate_8188E(Adapter, true);
+			} else {
+				PHY_IQCalibrate_8188E(Adapter, false);
+				haldata->odmpriv.RFCalibrateInfo.bIQKInitialized = true;
+			}
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_PW_TRACK);
+
+			ODM_TXPowerTrackingCheck(&haldata->odmpriv);
+
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_LCK);
+			PHY_LCCalibrate_8188E(Adapter);
+		}
+	}
+
+/* HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PABIAS); */
+/*	_InitPABias(Adapter); */
+	rtw_write8(Adapter, REG_USB_HRPWM, 0);
+
+	/* ack for xmit mgmt frames. */
+	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL)|BIT(12));
+
+exit:
+HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
+
+	DBG_88E("%s in %dms\n", __func__, rtw_get_passing_time_ms(init_start_time));
+
+	return status;
+}
+
+void _ps_open_RF(struct adapter *adapt)
+{
+	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
+	/* phy_SsPwrSwitch92CU(adapt, rf_on, 1); */
+}
+
+static void _ps_close_RF(struct adapter *adapt)
+{
+	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
+	/* phy_SsPwrSwitch92CU(adapt, rf_off, 1); */
+}
+
+static void CardDisableRTL8188EU(struct adapter *Adapter)
+{
+	u8 val8;
+	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+
+	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("CardDisableRTL8188EU\n"));
+
+	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
+	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
+	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8&(~BIT1));
+
+	/*  stop rx */
+	rtw_write8(Adapter, REG_CR, 0x0);
+
+	/*  Run LPS WL RFOFF flow */
+	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_LPS_ENTER_FLOW);
+
+	/*  2. 0x1F[7:0] = 0		turn off RF */
+
+	val8 = rtw_read8(Adapter, REG_MCUFWDL);
+	if ((val8 & RAM_DL_SEL) && Adapter->bFWReady) { /* 8051 RAM code */
+		/*  Reset MCU 0x2[10]=0. */
+		val8 = rtw_read8(Adapter, REG_SYS_FUNC_EN+1);
+		val8 &= ~BIT(2);	/*  0x2[10], FEN_CPUEN */
+		rtw_write8(Adapter, REG_SYS_FUNC_EN+1, val8);
+	}
+
+	/*  reset MCU ready status */
+	rtw_write8(Adapter, REG_MCUFWDL, 0);
+
+	/* YJ,add,111212 */
+	/* Disable 32k */
+	val8 = rtw_read8(Adapter, REG_32K_CTRL);
+	rtw_write8(Adapter, REG_32K_CTRL, val8&(~BIT0));
+
+	/*  Card disable power action flow */
+	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
+
+	/*  Reset MCU IO Wrapper */
+	val8 = rtw_read8(Adapter, REG_RSV_CTRL+1);
+	rtw_write8(Adapter, REG_RSV_CTRL+1, (val8&(~BIT3)));
+	val8 = rtw_read8(Adapter, REG_RSV_CTRL+1);
+	rtw_write8(Adapter, REG_RSV_CTRL+1, val8|BIT3);
+
+	/* YJ,test add, 111207. For Power Consumption. */
+	val8 = rtw_read8(Adapter, GPIO_IN);
+	rtw_write8(Adapter, GPIO_OUT, val8);
+	rtw_write8(Adapter, GPIO_IO_SEL, 0xFF);/* Reg0x46 */
+
+	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL);
+	rtw_write8(Adapter, REG_GPIO_IO_SEL, (val8<<4));
+	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL+1);
+	rtw_write8(Adapter, REG_GPIO_IO_SEL+1, val8|0x0F);/* Reg0x43 */
+	rtw_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
+	haldata->bMacPwrCtrlOn = false;
+	Adapter->bFWReady = false;
+}
+static void rtl8192cu_hw_power_down(struct adapter *adapt)
+{
+	/*  2010/-8/09 MH For power down module, we need to enable register block contrl reg at 0x1c. */
+	/*  Then enable power down control bit of register 0x04 BIT4 and BIT15 as 1. */
+
+	/*  Enable register area 0x0-0xc. */
+	rtw_write8(adapt, REG_RSV_CTRL, 0x0);
+	rtw_write16(adapt, REG_APS_FSMCO, 0x8812);
+}
+
+static u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
+{
+
+	DBG_88E("==> %s\n", __func__);
+
+	rtw_write32(Adapter, REG_HIMR_88E, IMR_DISABLED_88E);
+	rtw_write32(Adapter, REG_HIMRE_88E, IMR_DISABLED_88E);
+
+	DBG_88E("bkeepfwalive(%x)\n", Adapter->pwrctrlpriv.bkeepfwalive);
+	if (Adapter->pwrctrlpriv.bkeepfwalive) {
+		_ps_close_RF(Adapter);
+		if ((Adapter->pwrctrlpriv.bHWPwrPindetect) && (Adapter->pwrctrlpriv.bHWPowerdown))
+			rtl8192cu_hw_power_down(Adapter);
+	} else {
+		if (Adapter->hw_init_completed) {
+			CardDisableRTL8188EU(Adapter);
+
+			if ((Adapter->pwrctrlpriv.bHWPwrPindetect) && (Adapter->pwrctrlpriv.bHWPowerdown))
+				rtl8192cu_hw_power_down(Adapter);
+		}
+	}
+	return _SUCCESS;
+ }
+
+static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
+{
+	u8 i;
+	struct recv_buf *precvbuf;
+	uint	status;
+	struct intf_hdl *pintfhdl = &Adapter->iopriv.intf;
+	struct recv_priv *precvpriv = &(Adapter->recvpriv);
+	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *pmem);
+
+	_read_port = pintfhdl->io_ops._read_port;
+
+	status = _SUCCESS;
+
+	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
+		 ("===> usb_inirp_init\n"));
+
+	precvpriv->ff_hwaddr = RECV_BULK_IN_ADDR;
+
+	/* issue Rx irp to receive data */
+	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
+	for (i = 0; i < NR_RECVBUFF; i++) {
+		if (_read_port(pintfhdl, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf) == false) {
+			RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("usb_rx_init: usb_read_port error\n"));
+			status = _FAIL;
+			goto exit;
+		}
+
+		precvbuf++;
+		precvpriv->free_recv_buf_queue_cnt--;
+	}
+
+exit:
+
+	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<=== usb_inirp_init\n"));
+
+	return status;
+}
+
+static unsigned int rtl8188eu_inirp_deinit(struct adapter *Adapter)
+{
+	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("\n ===> usb_rx_deinit\n"));
+
+	rtw_read_port_cancel(Adapter);
+
+	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("\n <=== usb_rx_deinit\n"));
+
+	return _SUCCESS;
+}
+
+/*  */
+/*  */
+/*	EEPROM/EFUSE Content Parsing */
+/*  */
+/*  */
+static void _ReadLEDSetting(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
+{
+	struct led_priv *pledpriv = &(Adapter->ledpriv);
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	pledpriv->bRegUseLed = true;
+	pledpriv->LedStrategy = SW_LED_MODE1;
+	haldata->bLedOpenDrain = true;/*  Support Open-drain arrangement for controlling the LED. */
+}
+
+static void Hal_EfuseParsePIDVID_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+
+	if (!AutoLoadFail) {
+		/*  VID, PID */
+		haldata->EEPROMVID = EF2BYTE(*(__le16 *)&hwinfo[EEPROM_VID_88EU]);
+		haldata->EEPROMPID = EF2BYTE(*(__le16 *)&hwinfo[EEPROM_PID_88EU]);
+
+		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
+		haldata->EEPROMCustomerID = *(u8 *)&hwinfo[EEPROM_CUSTOMERID_88E];
+		haldata->EEPROMSubCustomerID = EEPROM_Default_SubCustomerID;
+	} else {
+		haldata->EEPROMVID			= EEPROM_Default_VID;
+		haldata->EEPROMPID			= EEPROM_Default_PID;
+
+		/*  Customer ID, 0x00 and 0xff are reserved for Realtek. */
+		haldata->EEPROMCustomerID		= EEPROM_Default_CustomerID;
+		haldata->EEPROMSubCustomerID	= EEPROM_Default_SubCustomerID;
+	}
+
+	DBG_88E("VID = 0x%04X, PID = 0x%04X\n", haldata->EEPROMVID, haldata->EEPROMPID);
+	DBG_88E("Customer ID: 0x%02X, SubCustomer ID: 0x%02X\n", haldata->EEPROMCustomerID, haldata->EEPROMSubCustomerID);
+}
+
+static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
+{
+	u16 i;
+	u8 sMacAddr[6] = {0x00, 0xE0, 0x4C, 0x81, 0x88, 0x02};
+	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(adapt);
+
+	if (AutoLoadFail) {
+		for (i = 0; i < 6; i++)
+			eeprom->mac_addr[i] = sMacAddr[i];
+	} else {
+		/* Read Permanent MAC address */
+		memcpy(eeprom->mac_addr, &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);
+	}
+	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
+		 ("Hal_EfuseParseMACAddr_8188EU: Permanent Address = %02x-%02x-%02x-%02x-%02x-%02x\n",
+		 eeprom->mac_addr[0], eeprom->mac_addr[1],
+		 eeprom->mac_addr[2], eeprom->mac_addr[3],
+		 eeprom->mac_addr[4], eeprom->mac_addr[5]));
+}
+
+static void Hal_CustomizeByCustomerID_8188EU(struct adapter *adapt)
+{
+}
+
+static void
+readAdapterInfo_8188EU(
+		struct adapter *adapt
+	)
+{
+	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(adapt);
+
+	/* parse the eeprom/efuse content */
+	Hal_EfuseParseIDCode88E(adapt, eeprom->efuse_eeprom_data);
+	Hal_EfuseParsePIDVID_8188EU(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseMACAddr_8188EU(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+
+	Hal_ReadPowerSavingMode88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_ReadTxPowerInfo88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseEEPROMVer88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	rtl8188e_EfuseParseChnlPlan(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseXtal_8188E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseCustomerID88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_ReadAntennaDiversity88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_EfuseParseBoardType88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	Hal_ReadThermalMeter_88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+
+	/*  */
+	/*  The following part initialize some vars by PG info. */
+	/*  */
+	Hal_InitChannelPlan(adapt);
+	Hal_CustomizeByCustomerID_8188EU(adapt);
+
+	_ReadLEDSetting(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+}
+
+static void _ReadPROMContent(
+	struct adapter *Adapter
+	)
+{
+	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(Adapter);
+	u8 eeValue;
+
+	/* check system boot selection */
+	eeValue = rtw_read8(Adapter, REG_9346CR);
+	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
+	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
+
+	DBG_88E("Boot from %s, Autoload %s !\n", (eeprom->EepromOrEfuse ? "EEPROM" : "EFUSE"),
+		(eeprom->bautoload_fail_flag ? "Fail" : "OK"));
+
+	Hal_InitPGData88E(Adapter);
+	readAdapterInfo_8188EU(Adapter);
+}
+
+static void _ReadRFType(struct adapter *Adapter)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+
+	haldata->rf_chip = RF_6052;
+}
+
+static int _ReadAdapterInfo8188EU(struct adapter *Adapter)
+{
+	u32 start = jiffies;
+
+	MSG_88E("====> %s\n", __func__);
+
+	_ReadRFType(Adapter);/* rf_chip -> _InitRFType() */
+	_ReadPROMContent(Adapter);
+
+	MSG_88E("<==== %s in %d ms\n", __func__, rtw_get_passing_time_ms(start));
+
+	return _SUCCESS;
+}
+
+static void ReadAdapterInfo8188EU(struct adapter *Adapter)
+{
+	/*  Read EEPROM size before call any EEPROM function */
+	Adapter->EepromAddressSize = GetEEPROMSize8188E(Adapter);
+
+	_ReadAdapterInfo8188EU(Adapter);
+}
+
+#define GPIO_DEBUG_PORT_NUM 0
+static void rtl8192cu_trigger_gpio_0(struct adapter *adapt)
+{
+}
+
+static void ResumeTxBeacon(struct adapter *adapt)
+{
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+
+	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
+	/*  which should be read from register to a global variable. */
+
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) | BIT6);
+	haldata->RegFwHwTxQCtrl |= BIT6;
+	rtw_write8(adapt, REG_TBTT_PROHIBIT+1, 0xff);
+	haldata->RegReg542 |= BIT0;
+	rtw_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
+}
+
+static void StopTxBeacon(struct adapter *adapt)
+{
+	struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+
+	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
+	/*  which should be read from register to a global variable. */
+
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl) & (~BIT6));
+	haldata->RegFwHwTxQCtrl &= (~BIT6);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT+1, 0x64);
+	haldata->RegReg542 &= ~(BIT0);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT+2, haldata->RegReg542);
+
+	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
+}
+
+static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
+{
+	u8 val8;
+	u8 mode = *((u8 *)val);
+
+	/*  disable Port0 TSF update */
+	rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
+
+	/*  set net_type */
+	val8 = rtw_read8(Adapter, MSR)&0x0c;
+	val8 |= mode;
+	rtw_write8(Adapter, MSR, val8);
+
+	DBG_88E("%s()-%d mode = %d\n", __func__, __LINE__, mode);
+
+	if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
+		StopTxBeacon(Adapter);
+
+		rtw_write8(Adapter, REG_BCN_CTRL, 0x19);/* disable atim wnd */
+	} else if ((mode == _HW_STATE_ADHOC_)) {
+		ResumeTxBeacon(Adapter);
+		rtw_write8(Adapter, REG_BCN_CTRL, 0x1a);
+	} else if (mode == _HW_STATE_AP_) {
+		ResumeTxBeacon(Adapter);
+
+		rtw_write8(Adapter, REG_BCN_CTRL, 0x12);
+
+		/* Set RCR */
+		rtw_write32(Adapter, REG_RCR, 0x7000208e);/* CBSSID_DATA must set to 0,reject ICV_ERR packet */
+		/* enable to rx data frame */
+		rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
+		/* enable to rx ps-poll */
+		rtw_write16(Adapter, REG_RXFLTMAP1, 0x0400);
+
+		/* Beacon Control related register for first time */
+		rtw_write8(Adapter, REG_BCNDMATIM, 0x02); /*  2ms */
+
+		rtw_write8(Adapter, REG_ATIMWND, 0x0a); /*  10ms */
+		rtw_write16(Adapter, REG_BCNTCFG, 0x00);
+		rtw_write16(Adapter, REG_TBTT_PROHIBIT, 0xff04);
+		rtw_write16(Adapter, REG_TSFTR_SYN_OFFSET, 0x7fff);/*  +32767 (~32ms) */
+
+		/* reset TSF */
+		rtw_write8(Adapter, REG_DUAL_TSF_RST, BIT(0));
+
+		/* BIT3 - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
+		rtw_write8(Adapter, REG_MBID_NUM, rtw_read8(Adapter, REG_MBID_NUM) | BIT(3) | BIT(4));
+
+		/* enable BCN0 Function for if1 */
+		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
+		rtw_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP|EN_BCN_FUNCTION | BIT(1)));
+
+		/* dis BCN1 ATIM  WND if if2 is station */
+		rtw_write8(Adapter, REG_BCN_CTRL_1, rtw_read8(Adapter, REG_BCN_CTRL_1) | BIT(0));
+	}
+}
+
+static void hw_var_set_macaddr(struct adapter *Adapter, u8 variable, u8 *val)
+{
+	u8 idx = 0;
+	u32 reg_macid;
+
+	reg_macid = REG_MACID;
+
+	for (idx = 0; idx < 6; idx++)
+		rtw_write8(Adapter, (reg_macid+idx), val[idx]);
+}
+
+static void hw_var_set_bssid(struct adapter *Adapter, u8 variable, u8 *val)
+{
+	u8 idx = 0;
+	u32 reg_bssid;
+
+	reg_bssid = REG_BSSID;
+
+	for (idx = 0; idx < 6; idx++)
+		rtw_write8(Adapter, (reg_bssid+idx), val[idx]);
+}
+
+static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
+{
+	u32 bcn_ctrl_reg;
+
+	bcn_ctrl_reg = REG_BCN_CTRL;
+
+	if (*((u8 *)val))
+		rtw_write8(Adapter, bcn_ctrl_reg, (EN_BCN_FUNCTION | EN_TXBCN_RPT));
+	else
+		rtw_write8(Adapter, bcn_ctrl_reg, rtw_read8(Adapter, bcn_ctrl_reg)&(~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+}
+
+static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct dm_priv	*pdmpriv = &haldata->dmpriv;
+	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+
+	switch (variable) {
+	case HW_VAR_MEDIA_STATUS:
+		{
+			u8 val8;
+
+			val8 = rtw_read8(Adapter, MSR)&0x0c;
+			val8 |= *((u8 *)val);
+			rtw_write8(Adapter, MSR, val8);
+		}
+		break;
+	case HW_VAR_MEDIA_STATUS1:
+		{
+			u8 val8;
+
+			val8 = rtw_read8(Adapter, MSR) & 0x03;
+			val8 |= *((u8 *)val) << 2;
+			rtw_write8(Adapter, MSR, val8);
+		}
+		break;
+	case HW_VAR_SET_OPMODE:
+		hw_var_set_opmode(Adapter, variable, val);
+		break;
+	case HW_VAR_MAC_ADDR:
+		hw_var_set_macaddr(Adapter, variable, val);
+		break;
+	case HW_VAR_BSSID:
+		hw_var_set_bssid(Adapter, variable, val);
+		break;
+	case HW_VAR_BASIC_RATE:
+		{
+			u16 BrateCfg = 0;
+			u8 RateIndex = 0;
+
+			/*  2007.01.16, by Emily */
+			/*  Select RRSR (in Legacy-OFDM and CCK) */
+			/*  For 8190, we select only 24M, 12M, 6M, 11M, 5.5M, 2M, and 1M from the Basic rate. */
+			/*  We do not use other rates. */
+			HalSetBrateCfg(Adapter, val, &BrateCfg);
+			DBG_88E("HW_VAR_BASIC_RATE: BrateCfg(%#x)\n", BrateCfg);
+
+			/* 2011.03.30 add by Luke Lee */
+			/* CCK 2M ACK should be disabled for some BCM and Atheros AP IOT */
+			/* because CCK 2M has poor TXEVM */
+			/* CCK 5.5M & 11M ACK should be enabled for better performance */
+
+			BrateCfg = (BrateCfg | 0xd) & 0x15d;
+			haldata->BasicRateSet = BrateCfg;
+
+			BrateCfg |= 0x01; /*  default enable 1M ACK rate */
+			/*  Set RRSR rate table. */
+			rtw_write8(Adapter, REG_RRSR, BrateCfg & 0xff);
+			rtw_write8(Adapter, REG_RRSR+1, (BrateCfg >> 8) & 0xff);
+			rtw_write8(Adapter, REG_RRSR+2, rtw_read8(Adapter, REG_RRSR+2)&0xf0);
+
+			/*  Set RTS initial rate */
+			while (BrateCfg > 0x1) {
+				BrateCfg = (BrateCfg >> 1);
+				RateIndex++;
+			}
+			/*  Ziv - Check */
+			rtw_write8(Adapter, REG_INIRTS_RATE_SEL, RateIndex);
+		}
+		break;
+	case HW_VAR_TXPAUSE:
+		rtw_write8(Adapter, REG_TXPAUSE, *((u8 *)val));
+		break;
+	case HW_VAR_BCN_FUNC:
+		hw_var_set_bcn_func(Adapter, variable, val);
+		break;
+	case HW_VAR_CORRECT_TSF:
+		{
+			u64	tsf;
+			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
+			struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+
+			tsf = pmlmeext->TSFValue - rtw_modular64(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */
+
+			if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE))
+				StopTxBeacon(Adapter);
+
+			/* disable related TSF function */
+			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(3)));
+
+			rtw_write32(Adapter, REG_TSFTR, tsf);
+			rtw_write32(Adapter, REG_TSFTR+4, tsf>>32);
+
+			/* enable related TSF function */
+			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(3));
+
+			if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE))
+				ResumeTxBeacon(Adapter);
+		}
+		break;
+	case HW_VAR_CHECK_BSSID:
+		if (*((u8 *)val)) {
+			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_DATA|RCR_CBSSID_BCN);
+		} else {
+			u32 val32;
+
+			val32 = rtw_read32(Adapter, REG_RCR);
+
+			val32 &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+
+			rtw_write32(Adapter, REG_RCR, val32);
+		}
+		break;
+	case HW_VAR_MLME_DISCONNECT:
+		/* Set RCR to not to receive data frame when NO LINK state */
+		/* reject all data frames */
+		rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
+
+		/* reset TSF */
+		rtw_write8(Adapter, REG_DUAL_TSF_RST, (BIT(0)|BIT(1)));
+
+		/* disable update TSF */
+		rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
+		break;
+	case HW_VAR_MLME_SITESURVEY:
+		if (*((u8 *)val)) { /* under sitesurvey */
+			/* config RCR to receive different BSSID & not to receive data frame */
+			u32 v = rtw_read32(Adapter, REG_RCR);
+			v &= ~(RCR_CBSSID_BCN);
+			rtw_write32(Adapter, REG_RCR, v);
+			/* reject all data frame */
+			rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
+
+			/* disable update TSF */
+			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)|BIT(4));
+		} else { /* sitesurvey done */
+			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
+			struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+
+			if ((is_client_associated_to_ap(Adapter)) ||
+			    ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE)) {
+				/* enable to rx data frame */
+				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
+
+				/* enable update TSF */
+				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+			} else if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
+				/* enable update TSF */
+				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+			}
+			if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_BCN);
+			} else {
+				if (Adapter->in_cta_test) {
+					u32 v = rtw_read32(Adapter, REG_RCR);
+					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
+					rtw_write32(Adapter, REG_RCR, v);
+				} else {
+					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_BCN);
+				}
+			}
+		}
+		break;
+	case HW_VAR_MLME_JOIN:
+		{
+			u8 RetryLimit = 0x30;
+			u8 type = *((u8 *)val);
+			struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
+
+			if (type == 0) { /*  prepare to join */
+				/* enable to rx data frame.Accept all data frame */
+				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
+
+				if (Adapter->in_cta_test) {
+					u32 v = rtw_read32(Adapter, REG_RCR);
+					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
+					rtw_write32(Adapter, REG_RCR, v);
+				} else {
+					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR)|RCR_CBSSID_DATA|RCR_CBSSID_BCN);
+				}
+
+				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
+					RetryLimit = (haldata->CustomerID == RT_CID_CCX) ? 7 : 48;
+				else /*  Ad-hoc Mode */
+					RetryLimit = 0x7;
+			} else if (type == 1) {
+				/* joinbss_event call back when join res < 0 */
+				rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
+			} else if (type == 2) {
+				/* sta add event call back */
+				/* enable update TSF */
+				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL)&(~BIT(4)));
+
+				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE))
+					RetryLimit = 0x7;
+			}
+			rtw_write16(Adapter, REG_RL, RetryLimit << RETRY_LIMIT_SHORT_SHIFT | RetryLimit << RETRY_LIMIT_LONG_SHIFT);
+		}
+		break;
+	case HW_VAR_BEACON_INTERVAL:
+		rtw_write16(Adapter, REG_BCN_INTERVAL, *((u16 *)val));
+		break;
+	case HW_VAR_SLOT_TIME:
+		{
+			u8 u1bAIFS, aSifsTime;
+			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
+			struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+
+			rtw_write8(Adapter, REG_SLOT, val[0]);
+
+			if (pmlmeinfo->WMM_enable == 0) {
+				if (pmlmeext->cur_wireless_mode == WIRELESS_11B)
+					aSifsTime = 10;
+				else
+					aSifsTime = 16;
+
+				u1bAIFS = aSifsTime + (2 * pmlmeinfo->slotTime);
+
+				/*  <Roger_EXP> Temporary removed, 2008.06.20. */
+				rtw_write8(Adapter, REG_EDCA_VO_PARAM, u1bAIFS);
+				rtw_write8(Adapter, REG_EDCA_VI_PARAM, u1bAIFS);
+				rtw_write8(Adapter, REG_EDCA_BE_PARAM, u1bAIFS);
+				rtw_write8(Adapter, REG_EDCA_BK_PARAM, u1bAIFS);
+			}
+		}
+		break;
+	case HW_VAR_RESP_SIFS:
+		/* RESP_SIFS for CCK */
+		rtw_write8(Adapter, REG_R2T_SIFS, val[0]); /*  SIFS_T2T_CCK (0x08) */
+		rtw_write8(Adapter, REG_R2T_SIFS+1, val[1]); /* SIFS_R2T_CCK(0x08) */
+		/* RESP_SIFS for OFDM */
+		rtw_write8(Adapter, REG_T2T_SIFS, val[2]); /* SIFS_T2T_OFDM (0x0a) */
+		rtw_write8(Adapter, REG_T2T_SIFS+1, val[3]); /* SIFS_R2T_OFDM(0x0a) */
+		break;
+	case HW_VAR_ACK_PREAMBLE:
+		{
+			u8 regTmp;
+			u8 bShortPreamble = *((bool *)val);
+			/*  Joseph marked out for Netgear 3500 TKIP channel 7 issue.(Temporarily) */
+			regTmp = (haldata->nCur40MhzPrimeSC)<<5;
+			if (bShortPreamble)
+				regTmp |= 0x80;
+
+			rtw_write8(Adapter, REG_RRSR+2, regTmp);
+		}
+		break;
+	case HW_VAR_SEC_CFG:
+		rtw_write8(Adapter, REG_SECCFG, *((u8 *)val));
+		break;
+	case HW_VAR_DM_FLAG:
+		podmpriv->SupportAbility = *((u8 *)val);
+		break;
+	case HW_VAR_DM_FUNC_OP:
+		if (val[0])
+			podmpriv->BK_SupportAbility = podmpriv->SupportAbility;
+		else
+			podmpriv->SupportAbility = podmpriv->BK_SupportAbility;
+		break;
+	case HW_VAR_DM_FUNC_SET:
+		if (*((u32 *)val) == DYNAMIC_ALL_FUNC_ENABLE) {
+			pdmpriv->DMFlag = pdmpriv->InitDMFlag;
+			podmpriv->SupportAbility =	pdmpriv->InitODMFlag;
+		} else {
+			podmpriv->SupportAbility |= *((u32 *)val);
+		}
+		break;
+	case HW_VAR_DM_FUNC_CLR:
+		podmpriv->SupportAbility &= *((u32 *)val);
+		break;
+	case HW_VAR_CAM_EMPTY_ENTRY:
+		{
+			u8 ucIndex = *((u8 *)val);
+			u8 i;
+			u32 ulCommand = 0;
+			u32 ulContent = 0;
+			u32 ulEncAlgo = CAM_AES;
+
+			for (i = 0; i < CAM_CONTENT_COUNT; i++) {
+				/*  filled id in CAM config 2 byte */
+				if (i == 0)
+					ulContent |= (ucIndex & 0x03) | ((u16)(ulEncAlgo)<<2);
+				else
+					ulContent = 0;
+				/*  polling bit, and No Write enable, and address */
+				ulCommand = CAM_CONTENT_COUNT*ucIndex+i;
+				ulCommand = ulCommand | CAM_POLLINIG|CAM_WRITE;
+				/*  write content 0 is equall to mark invalid */
+				rtw_write32(Adapter, WCAMI, ulContent);  /* delay_ms(40); */
+				rtw_write32(Adapter, RWCAM, ulCommand);  /* delay_ms(40); */
+			}
+		}
+		break;
+	case HW_VAR_CAM_INVALID_ALL:
+		rtw_write32(Adapter, RWCAM, BIT(31)|BIT(30));
+		break;
+	case HW_VAR_CAM_WRITE:
+		{
+			u32 cmd;
+			u32 *cam_val = (u32 *)val;
+			rtw_write32(Adapter, WCAMI, cam_val[0]);
+
+			cmd = CAM_POLLINIG | CAM_WRITE | cam_val[1];
+			rtw_write32(Adapter, RWCAM, cmd);
+		}
+		break;
+	case HW_VAR_AC_PARAM_VO:
+		rtw_write32(Adapter, REG_EDCA_VO_PARAM, ((u32 *)(val))[0]);
+		break;
+	case HW_VAR_AC_PARAM_VI:
+		rtw_write32(Adapter, REG_EDCA_VI_PARAM, ((u32 *)(val))[0]);
+		break;
+	case HW_VAR_AC_PARAM_BE:
+		haldata->AcParam_BE = ((u32 *)(val))[0];
+		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
+		break;
+	case HW_VAR_AC_PARAM_BK:
+		rtw_write32(Adapter, REG_EDCA_BK_PARAM, ((u32 *)(val))[0]);
+		break;
+	case HW_VAR_ACM_CTRL:
+		{
+			u8 acm_ctrl = *((u8 *)val);
+			u8 AcmCtrl = rtw_read8(Adapter, REG_ACMHWCTRL);
+
+			if (acm_ctrl > 1)
+				AcmCtrl = AcmCtrl | 0x1;
+
+			if (acm_ctrl & BIT(3))
+				AcmCtrl |= AcmHw_VoqEn;
+			else
+				AcmCtrl &= (~AcmHw_VoqEn);
+
+			if (acm_ctrl & BIT(2))
+				AcmCtrl |= AcmHw_ViqEn;
+			else
+				AcmCtrl &= (~AcmHw_ViqEn);
+
+			if (acm_ctrl & BIT(1))
+				AcmCtrl |= AcmHw_BeqEn;
+			else
+				AcmCtrl &= (~AcmHw_BeqEn);
+
+			DBG_88E("[HW_VAR_ACM_CTRL] Write 0x%X\n", AcmCtrl);
+			rtw_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
+		}
+		break;
+	case HW_VAR_AMPDU_MIN_SPACE:
+		{
+			u8 MinSpacingToSet;
+			u8 SecMinSpace;
+
+			MinSpacingToSet = *((u8 *)val);
+			if (MinSpacingToSet <= 7) {
+				switch (Adapter->securitypriv.dot11PrivacyAlgrthm) {
+				case _NO_PRIVACY_:
+				case _AES_:
+					SecMinSpace = 0;
+					break;
+				case _WEP40_:
+				case _WEP104_:
+				case _TKIP_:
+				case _TKIP_WTMIC_:
+					SecMinSpace = 6;
+					break;
+				default:
+					SecMinSpace = 7;
+					break;
+				}
+				if (MinSpacingToSet < SecMinSpace)
+					MinSpacingToSet = SecMinSpace;
+				rtw_write8(Adapter, REG_AMPDU_MIN_SPACE, (rtw_read8(Adapter, REG_AMPDU_MIN_SPACE) & 0xf8) | MinSpacingToSet);
+			}
+		}
+		break;
+	case HW_VAR_AMPDU_FACTOR:
+		{
+			u8 RegToSet_Normal[4] = {0x41, 0xa8, 0x72, 0xb9};
+			u8 FactorToSet;
+			u8 *pRegToSet;
+			u8 index = 0;
+
+			pRegToSet = RegToSet_Normal; /*  0xb972a841; */
+			FactorToSet = *((u8 *)val);
+			if (FactorToSet <= 3) {
+				FactorToSet = (1<<(FactorToSet + 2));
+				if (FactorToSet > 0xf)
+					FactorToSet = 0xf;
+
+				for (index = 0; index < 4; index++) {
+					if ((pRegToSet[index] & 0xf0) > (FactorToSet<<4))
+						pRegToSet[index] = (pRegToSet[index] & 0x0f) | (FactorToSet<<4);
+
+					if ((pRegToSet[index] & 0x0f) > FactorToSet)
+						pRegToSet[index] = (pRegToSet[index] & 0xf0) | (FactorToSet);
+
+					rtw_write8(Adapter, (REG_AGGLEN_LMT+index), pRegToSet[index]);
+				}
+			}
+		}
+		break;
+	case HW_VAR_RXDMA_AGG_PG_TH:
+		{
+			u8 threshold = *((u8 *)val);
+			if (threshold == 0)
+				threshold = haldata->UsbRxAggPageCount;
+			rtw_write8(Adapter, REG_RXDMA_AGG_PG_TH, threshold);
+		}
+		break;
+	case HW_VAR_SET_RPWM:
+		break;
+	case HW_VAR_H2C_FW_PWRMODE:
+		{
+			u8 psmode = (*(u8 *)val);
+
+			/*  Forece leave RF low power mode for 1T1R to prevent conficting setting in Fw power */
+			/*  saving sequence. 2010.06.07. Added by tynli. Suggested by SD3 yschang. */
+			if ((psmode != PS_MODE_ACTIVE) && (!IS_92C_SERIAL(haldata->VersionID)))
+				ODM_RF_Saving(podmpriv, true);
+			rtl8188e_set_FwPwrMode_cmd(Adapter, psmode);
+		}
+		break;
+	case HW_VAR_H2C_FW_JOINBSSRPT:
+		{
+			u8 mstatus = (*(u8 *)val);
+			rtl8188e_set_FwJoinBssReport_cmd(Adapter, mstatus);
+		}
+		break;
+#ifdef CONFIG_88EU_P2P
+	case HW_VAR_H2C_FW_P2P_PS_OFFLOAD:
+		{
+			u8 p2p_ps_state = (*(u8 *)val);
+			rtl8188e_set_p2p_ps_offload_cmd(Adapter, p2p_ps_state);
+		}
+		break;
+#endif
+	case HW_VAR_INITIAL_GAIN:
+		{
+			struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
+			u32 rx_gain = ((u32 *)(val))[0];
+
+			if (rx_gain == 0xff) {/* restore rx gain */
+				ODM_Write_DIG(podmpriv, pDigTable->BackupIGValue);
+			} else {
+				pDigTable->BackupIGValue = pDigTable->CurIGValue;
+				ODM_Write_DIG(podmpriv, rx_gain);
+			}
+		}
+		break;
+	case HW_VAR_TRIGGER_GPIO_0:
+		rtl8192cu_trigger_gpio_0(Adapter);
+		break;
+	case HW_VAR_RPT_TIMER_SETTING:
+		{
+			u16 min_rpt_time = (*(u16 *)val);
+			ODM_RA_Set_TxRPT_Time(podmpriv, min_rpt_time);
+		}
+		break;
+	case HW_VAR_ANTENNA_DIVERSITY_SELECT:
+		{
+			u8 Optimum_antenna = (*(u8 *)val);
+			u8 Ant;
+			/* switch antenna to Optimum_antenna */
+			if (haldata->CurAntenna !=  Optimum_antenna) {
+				Ant = (Optimum_antenna == 2) ? MAIN_ANT : AUX_ANT;
+				ODM_UpdateRxIdleAnt_88E(&haldata->odmpriv, Ant);
+
+				haldata->CurAntenna = Optimum_antenna;
+			}
+		}
+		break;
+	case HW_VAR_EFUSE_BYTES: /*  To set EFUE total used bytes, added by Roger, 2008.12.22. */
+		haldata->EfuseUsedBytes = *((u16 *)val);
+		break;
+	case HW_VAR_FIFO_CLEARN_UP:
+		{
+			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
+			u8 trycnt = 100;
+
+			/* pause tx */
+			rtw_write8(Adapter, REG_TXPAUSE, 0xff);
+
+			/* keep sn */
+			Adapter->xmitpriv.nqos_ssn = rtw_read16(Adapter, REG_NQOS_SEQ);
+
+			if (!pwrpriv->bkeepfwalive) {
+				/* RX DMA stop */
+				rtw_write32(Adapter, REG_RXPKT_NUM, (rtw_read32(Adapter, REG_RXPKT_NUM)|RW_RELEASE_EN));
+				do {
+					if (!(rtw_read32(Adapter, REG_RXPKT_NUM)&RXDMA_IDLE))
+						break;
+				} while (trycnt--);
+				if (trycnt == 0)
+					DBG_88E("Stop RX DMA failed......\n");
+
+				/* RQPN Load 0 */
+				rtw_write16(Adapter, REG_RQPN_NPQ, 0x0);
+				rtw_write32(Adapter, REG_RQPN, 0x80000000);
+				rtw_mdelay_os(10);
+			}
+		}
+		break;
+	case HW_VAR_CHECK_TXBUF:
+		break;
+	case HW_VAR_APFM_ON_MAC:
+		haldata->bMacPwrCtrlOn = *val;
+		DBG_88E("%s: bMacPwrCtrlOn=%d\n", __func__, haldata->bMacPwrCtrlOn);
+		break;
+	case HW_VAR_TX_RPT_MAX_MACID:
+		{
+			u8 maxMacid = *val;
+			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid+1);
+			rtw_write8(Adapter, REG_TX_RPT_CTRL+1, maxMacid+1);
+		}
+		break;
+	case HW_VAR_H2C_MEDIA_STATUS_RPT:
+		rtl8188e_set_FwMediaStatus_cmd(Adapter , (*(__le16 *)val));
+		break;
+	case HW_VAR_BCN_VALID:
+		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2, write 1 to clear, Clear by sw */
+		rtw_write8(Adapter, REG_TDECTRL+2, rtw_read8(Adapter, REG_TDECTRL+2) | BIT0);
+		break;
+	default:
+		break;
+	}
+
+}
+
+static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+
+	switch (variable) {
+	case HW_VAR_BASIC_RATE:
+		*((u16 *)(val)) = haldata->BasicRateSet;
+		__attribute__((__fallthrough__));
+	case HW_VAR_TXPAUSE:
+		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
+		break;
+	case HW_VAR_BCN_VALID:
+		/* BCN_VALID, BIT16 of REG_TDECTRL = BIT0 of REG_TDECTRL+2 */
+		val[0] = (BIT0 & rtw_read8(Adapter, REG_TDECTRL+2)) ? true : false;
+		break;
+	case HW_VAR_DM_FLAG:
+		val[0] = podmpriv->SupportAbility;
+		break;
+	case HW_VAR_RF_TYPE:
+		val[0] = haldata->rf_type;
+		break;
+	case HW_VAR_FWLPS_RF_ON:
+		{
+			/* When we halt NIC, we should check if FW LPS is leave. */
+			if (Adapter->pwrctrlpriv.rf_pwrstate == rf_off) {
+				/*  If it is in HW/SW Radio OFF or IPS state, we do not check Fw LPS Leave, */
+				/*  because Fw is unload. */
+				val[0] = true;
+			} else {
+				u32 valRCR;
+				valRCR = rtw_read32(Adapter, REG_RCR);
+				valRCR &= 0x00070000;
+				if (valRCR)
+					val[0] = false;
+				else
+					val[0] = true;
+			}
+		}
+		break;
+	case HW_VAR_CURRENT_ANTENNA:
+		val[0] = haldata->CurAntenna;
+		break;
+	case HW_VAR_EFUSE_BYTES: /*  To get EFUE total used bytes, added by Roger, 2008.12.22. */
+		*((u16 *)(val)) = haldata->EfuseUsedBytes;
+		break;
+	case HW_VAR_APFM_ON_MAC:
+		*val = haldata->bMacPwrCtrlOn;
+		break;
+	case HW_VAR_CHK_HI_QUEUE_EMPTY:
+		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION)&0x0000ff00) == 0) ? true : false;
+		break;
+	default:
+		break;
+	}
+
+}
+
+/*  */
+/*	Description: */
+/*		Query setting of specified variable. */
+/*  */
+static u8
+GetHalDefVar8188EUsb(
+		struct adapter *Adapter,
+		enum hal_def_variable eVariable,
+		void *pValue
+	)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	u8 bResult = _SUCCESS;
+
+	switch (eVariable) {
+	case HAL_DEF_UNDERCORATEDSMOOTHEDPWDB:
+		{
+			struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
+			struct sta_priv *pstapriv = &Adapter->stapriv;
+			struct sta_info *psta;
+			psta = rtw_get_stainfo(pstapriv, pmlmepriv->cur_network.network.MacAddress);
+			if (psta)
+				*((int *)pValue) = psta->rssi_stat.UndecoratedSmoothedPWDB;
+		}
+		break;
+	case HAL_DEF_IS_SUPPORT_ANT_DIV:
+		*((u8 *)pValue) = (haldata->AntDivCfg == 0) ? false : true;
+		break;
+	case HAL_DEF_CURRENT_ANTENNA:
+		*((u8 *)pValue) = haldata->CurAntenna;
+		break;
+	case HAL_DEF_DRVINFO_SZ:
+		*((u32 *)pValue) = DRVINFO_SZ;
+		break;
+	case HAL_DEF_MAX_RECVBUF_SZ:
+		*((u32 *)pValue) = MAX_RECVBUF_SZ;
+		break;
+	case HAL_DEF_RX_PACKET_OFFSET:
+		*((u32 *)pValue) = RXDESC_SIZE + DRVINFO_SZ;
+		break;
+	case HAL_DEF_DBG_DM_FUNC:
+		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
+		break;
+	case HAL_DEF_RA_DECISION_RATE:
+		{
+			u8 MacID = *((u8 *)pValue);
+			*((u8 *)pValue) = ODM_RA_GetDecisionRate_8188E(&(haldata->odmpriv), MacID);
+		}
+		break;
+	case HAL_DEF_RA_SGI:
+		{
+			u8 MacID = *((u8 *)pValue);
+			*((u8 *)pValue) = ODM_RA_GetShortGI_8188E(&(haldata->odmpriv), MacID);
+		}
+		break;
+	case HAL_DEF_PT_PWR_STATUS:
+		{
+			u8 MacID = *((u8 *)pValue);
+			*((u8 *)pValue) = ODM_RA_GetHwPwrStatus_8188E(&(haldata->odmpriv), MacID);
+		}
+		break;
+	case HW_VAR_MAX_RX_AMPDU_FACTOR:
+		*((u32 *)pValue) = MAX_AMPDU_FACTOR_64K;
+		break;
+	case HW_DEF_RA_INFO_DUMP:
+		{
+			u8 entry_id = *((u8 *)pValue);
+			if (check_fwstate(&Adapter->mlmepriv, _FW_LINKED)) {
+				DBG_88E("============ RA status check ===================\n");
+				DBG_88E("Mac_id:%d , RateID = %d, RAUseRate = 0x%08x, RateSGI = %d, DecisionRate = 0x%02x ,PTStage = %d\n",
+					entry_id,
+					haldata->odmpriv.RAInfo[entry_id].RateID,
+					haldata->odmpriv.RAInfo[entry_id].RAUseRate,
+					haldata->odmpriv.RAInfo[entry_id].RateSGI,
+					haldata->odmpriv.RAInfo[entry_id].DecisionRate,
+					haldata->odmpriv.RAInfo[entry_id].PTStage);
+			}
+		}
+		break;
+	case HW_DEF_ODM_DBG_FLAG:
+		{
+			struct odm_dm_struct *dm_ocm = &(haldata->odmpriv);
+			pr_info("dm_ocm->DebugComponents = 0x%llx\n", dm_ocm->DebugComponents);
+		}
+		break;
+	case HAL_DEF_DBG_DUMP_RXPKT:
+		*((u8 *)pValue) = haldata->bDumpRxPkt;
+		break;
+	case HAL_DEF_DBG_DUMP_TXPKT:
+		*((u8 *)pValue) = haldata->bDumpTxPkt;
+		break;
+	default:
+		bResult = _FAIL;
+		break;
+	}
+
+	return bResult;
+}
+
+/*  */
+/*	Description: */
+/*		Change default setting of specified variable. */
+/*  */
+static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	u8 bResult = _SUCCESS;
+
+	switch (eVariable) {
+	case HAL_DEF_DBG_DM_FUNC:
+		{
+			u8 dm_func = *((u8 *)pValue);
+			struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+
+			if (dm_func == 0) { /* disable all dynamic func */
+				podmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
+				DBG_88E("==> Disable all dynamic function...\n");
+			} else if (dm_func == 1) {/* disable DIG */
+				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DIG);
+				DBG_88E("==> Disable DIG...\n");
+			} else if (dm_func == 2) {/* disable High power */
+				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DYNAMIC_TXPWR);
+			} else if (dm_func == 3) {/* disable tx power tracking */
+				podmpriv->SupportAbility  &= (~DYNAMIC_RF_CALIBRATION);
+				DBG_88E("==> Disable tx power tracking...\n");
+			} else if (dm_func == 5) {/* disable antenna diversity */
+				podmpriv->SupportAbility  &= (~DYNAMIC_BB_ANT_DIV);
+			} else if (dm_func == 6) {/* turn on all dynamic func */
+				if (!(podmpriv->SupportAbility  & DYNAMIC_BB_DIG)) {
+					struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
+					pDigTable->CurIGValue = rtw_read8(Adapter, 0xc50);
+				}
+				podmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
+				DBG_88E("==> Turn on all dynamic function...\n");
+			}
+		}
+		break;
+	case HAL_DEF_DBG_DUMP_RXPKT:
+		haldata->bDumpRxPkt = *((u8 *)pValue);
+		break;
+	case HAL_DEF_DBG_DUMP_TXPKT:
+		haldata->bDumpTxPkt = *((u8 *)pValue);
+		break;
+	case HW_DEF_FA_CNT_DUMP:
+		{
+			u8 bRSSIDump = *((u8 *)pValue);
+			struct odm_dm_struct *dm_ocm = &(haldata->odmpriv);
+			if (bRSSIDump)
+				dm_ocm->DebugComponents	=	ODM_COMP_DIG|ODM_COMP_FA_CNT	;
+			else
+				dm_ocm->DebugComponents	= 0;
+		}
+		break;
+	case HW_DEF_ODM_DBG_FLAG:
+		{
+			u64	DebugComponents = *((u64 *)pValue);
+			struct odm_dm_struct *dm_ocm = &(haldata->odmpriv);
+			dm_ocm->DebugComponents = DebugComponents;
+		}
+		break;
+	default:
+		bResult = _FAIL;
+		break;
+	}
+
+	return bResult;
+}
+
+static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
+{
+	u8 init_rate = 0;
+	u8 networkType, raid;
+	u32 mask, rate_bitmap;
+	u8 shortGIrate = false;
+	int	supportRateNum = 0;
+	struct sta_info	*psta;
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct wlan_bssid_ex	*cur_network = &(pmlmeinfo->network);
+
+	if (mac_id >= NUM_STA) /* CAM_SIZE */
+		return;
+	psta = pmlmeinfo->FW_sta_info[mac_id].psta;
+	if (psta == NULL)
+		return;
+	switch (mac_id) {
+	case 0:/*  for infra mode */
+		supportRateNum = rtw_get_rateset_len(cur_network->SupportedRates);
+		networkType = judge_network_type(adapt, cur_network->SupportedRates, supportRateNum) & 0xf;
+		raid = networktype_to_raid(networkType);
+		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
+		mask |= (pmlmeinfo->HT_enable) ? update_MSC_rate(&(pmlmeinfo->HT_caps)) : 0;
+		if (support_short_GI(adapt, &(pmlmeinfo->HT_caps)))
+			shortGIrate = true;
+		break;
+	case 1:/* for broadcast/multicast */
+		supportRateNum = rtw_get_rateset_len(pmlmeinfo->FW_sta_info[mac_id].SupportedRates);
+		if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
+			networkType = WIRELESS_11B;
+		else
+			networkType = WIRELESS_11G;
+		raid = networktype_to_raid(networkType);
+		mask = update_basic_rate(cur_network->SupportedRates, supportRateNum);
+		break;
+	default: /* for each sta in IBSS */
+		supportRateNum = rtw_get_rateset_len(pmlmeinfo->FW_sta_info[mac_id].SupportedRates);
+		networkType = judge_network_type(adapt, pmlmeinfo->FW_sta_info[mac_id].SupportedRates, supportRateNum) & 0xf;
+		raid = networktype_to_raid(networkType);
+		mask = update_supported_rate(cur_network->SupportedRates, supportRateNum);
+
+		/* todo: support HT in IBSS */
+		break;
+	}
+
+	rate_bitmap = 0x0fffffff;
+	rate_bitmap = ODM_Get_Rate_Bitmap(&haldata->odmpriv, mac_id, mask, rssi_level);
+	DBG_88E("%s => mac_id:%d, networkType:0x%02x, mask:0x%08x\n\t ==> rssi_level:%d, rate_bitmap:0x%08x\n",
+		__func__, mac_id, networkType, mask, rssi_level, rate_bitmap);
+
+	mask &= rate_bitmap;
+
+	init_rate = get_highest_rate_idx(mask)&0x3f;
+
+	if (haldata->fw_ractrl) {
+		u8 arg;
+
+		arg = mac_id & 0x1f;/* MACID */
+		arg |= BIT(7);
+		if (shortGIrate)
+			arg |= BIT(5);
+		mask |= ((raid << 28) & 0xf0000000);
+		DBG_88E("update raid entry, mask=0x%x, arg=0x%x\n", mask, arg);
+		psta->ra_mask = mask;
+		mask |= ((raid << 28) & 0xf0000000);
+
+		/* to do ,for 8188E-SMIC */
+		rtl8188e_set_raid_cmd(adapt, mask);
+	} else {
+		ODM_RA_UpdateRateInfo_8188E(&(haldata->odmpriv),
+				mac_id,
+				raid,
+				mask,
+				shortGIrate
+				);
+	}
+	/* set ra_id */
+	psta->raid = raid;
+	psta->init_rate = init_rate;
+}
+
+static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
+{
+	u32 value32;
+	struct mlme_ext_priv	*pmlmeext = &(adapt->mlmeextpriv);
+	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	u32 bcn_ctrl_reg			= REG_BCN_CTRL;
+	/* reset TSF, enable update TSF, correcting TSF On Beacon */
+
+	/* BCN interval */
+	rtw_write16(adapt, REG_BCN_INTERVAL, pmlmeinfo->bcn_interval);
+	rtw_write8(adapt, REG_ATIMWND, 0x02);/*  2ms */
+
+	_InitBeaconParameters(adapt);
+
+	rtw_write8(adapt, REG_SLOT, 0x09);
+
+	value32 = rtw_read32(adapt, REG_TCR);
+	value32 &= ~TSFRST;
+	rtw_write32(adapt,  REG_TCR, value32);
+
+	value32 |= TSFRST;
+	rtw_write32(adapt, REG_TCR, value32);
+
+	/*  NOTE: Fix test chip's bug (about contention windows's randomness) */
+	rtw_write8(adapt,  REG_RXTSF_OFFSET_CCK, 0x50);
+	rtw_write8(adapt, REG_RXTSF_OFFSET_OFDM, 0x50);
+
+	_BeaconFunctionEnable(adapt, true, true);
+
+	ResumeTxBeacon(adapt);
+
+	rtw_write8(adapt, bcn_ctrl_reg, rtw_read8(adapt, bcn_ctrl_reg)|BIT(1));
+}
+
+static void rtl8188eu_init_default_value(struct adapter *adapt)
+{
+	struct hal_data_8188e *haldata;
+	struct pwrctrl_priv *pwrctrlpriv;
+	u8 i;
+
+	haldata = GET_HAL_DATA(adapt);
+	pwrctrlpriv = &adapt->pwrctrlpriv;
+
+	/* init default value */
+	haldata->fw_ractrl = false;
+	if (!pwrctrlpriv->bkeepfwalive)
+		haldata->LastHMEBoxNum = 0;
+
+	/* init dm default value */
+	haldata->odmpriv.RFCalibrateInfo.bIQKInitialized = false;
+	haldata->odmpriv.RFCalibrateInfo.TM_Trigger = 0;/* for IQK */
+	haldata->pwrGroupCnt = 0;
+	haldata->PGMaxGroup = 13;
+	haldata->odmpriv.RFCalibrateInfo.ThermalValue_HP_index = 0;
+	for (i = 0; i < HP_THERMAL_NUM; i++)
+		haldata->odmpriv.RFCalibrateInfo.ThermalValue_HP[i] = 0;
+}
+
+static u8 rtl8188eu_ps_func(struct adapter *Adapter, enum hal_intf_ps_func efunc_id, u8 *val)
+{
+	u8 bResult = true;
+	return bResult;
+}
+
+void rtl8188eu_set_hal_ops(struct adapter *adapt)
+{
+	struct hal_ops	*halfunc = &adapt->HalFunc;
+
+	adapt->HalData = rtw_zmalloc(sizeof(struct hal_data_8188e));
+	if (adapt->HalData == NULL)
+		DBG_88E("cant not alloc memory for HAL DATA\n");
+	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
+
+	halfunc->hal_power_on = rtl8188eu_InitPowerOn;
+	halfunc->hal_init = &rtl8188eu_hal_init;
+	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
+
+	halfunc->inirp_init = &rtl8188eu_inirp_init;
+	halfunc->inirp_deinit = &rtl8188eu_inirp_deinit;
+
+	halfunc->init_xmit_priv = &rtl8188eu_init_xmit_priv;
+	halfunc->free_xmit_priv = &rtl8188eu_free_xmit_priv;
+
+	halfunc->init_recv_priv = &rtl8188eu_init_recv_priv;
+	halfunc->free_recv_priv = &rtl8188eu_free_recv_priv;
+	halfunc->InitSwLeds = &rtl8188eu_InitSwLeds;
+	halfunc->DeInitSwLeds = &rtl8188eu_DeInitSwLeds;
+
+	halfunc->init_default_value = &rtl8188eu_init_default_value;
+	halfunc->intf_chip_configure = &rtl8188eu_interface_configure;
+	halfunc->read_adapter_info = &ReadAdapterInfo8188EU;
+
+	halfunc->SetHwRegHandler = &SetHwReg8188EU;
+	halfunc->GetHwRegHandler = &GetHwReg8188EU;
+	halfunc->GetHalDefVarHandler = &GetHalDefVar8188EUsb;
+	halfunc->SetHalDefVarHandler = &SetHalDefVar8188EUsb;
+
+	halfunc->UpdateRAMaskHandler = &UpdateHalRAMask8188EUsb;
+	halfunc->SetBeaconRelatedRegistersHandler = &SetBeaconRelatedRegisters8188EUsb;
+
+	halfunc->hal_xmit = &rtl8188eu_hal_xmit;
+	halfunc->mgnt_xmit = &rtl8188eu_mgnt_xmit;
+
+	halfunc->interface_ps_func = &rtl8188eu_ps_func;
+
+	rtl8188e_set_hal_ops(halfunc);
+
+}
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
new file mode 100644
index 000000000000..d31f0be4c8a6
--- /dev/null
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -0,0 +1,717 @@
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
+#define _HCI_OPS_OS_C_
+
+#include <osdep_service.h>
+#include <drv_types.h>
+#include <osdep_intf.h>
+#include <usb_ops.h>
+#include <recv_osdep.h>
+#include <rtl8188e_hal.h>
+
+static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u8 request, u16 value, u16 index, void *pdata, u16 len, u8 requesttype)
+{
+	struct adapter	*adapt = pintfhdl->padapter;
+	struct dvobj_priv  *dvobjpriv = adapter_to_dvobj(adapt);
+	struct usb_device *udev = dvobjpriv->pusbdev;
+	unsigned int pipe;
+	int status = 0;
+	u8 reqtype;
+	u8 *pIo_buf;
+	int vendorreq_times = 0;
+
+	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usbctrl_vendorreq:(adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
+		status = -EPERM;
+		goto exit;
+	}
+
+	if (len > MAX_VENDOR_REQ_CMD_SIZE) {
+		DBG_88E("[%s] Buffer len error ,vendor request failed\n", __func__);
+		status = -EINVAL;
+		goto exit;
+	}
+
+	_enter_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+
+	/*  Acquire IO memory for vendorreq */
+	pIo_buf = dvobjpriv->usb_vendor_req_buf;
+
+	if (pIo_buf == NULL) {
+		DBG_88E("[%s] pIo_buf == NULL\n", __func__);
+		status = -ENOMEM;
+		goto release_mutex;
+	}
+
+	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
+		memset(pIo_buf, 0, len);
+
+		if (requesttype == 0x01) {
+			pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
+			reqtype =  REALTEK_USB_VENQT_READ;
+		} else {
+			pipe = usb_sndctrlpipe(udev, 0);/* write_out */
+			reqtype =  REALTEK_USB_VENQT_WRITE;
+			memcpy(pIo_buf, pdata, len);
+		}
+
+		status = rtw_usb_control_msg(udev, pipe, request, reqtype, value, index, pIo_buf, len, RTW_USB_CONTROL_MSG_TIMEOUT);
+
+		if (status == len) {   /*  Success this control transfer. */
+			rtw_reset_continual_urb_error(dvobjpriv);
+			if (requesttype == 0x01)
+				memcpy(pdata, pIo_buf,  len);
+		} else { /*  error cases */
+			DBG_88E("reg 0x%x, usb %s %u fail, status:%d value=0x%x, vendorreq_times:%d\n",
+				value, (requesttype == 0x01) ? "read" : "write",
+				len, status, *(u32 *)pdata, vendorreq_times);
+
+			if (status < 0) {
+				if (status == (-ESHUTDOWN) || status == -ENODEV) {
+					adapt->bSurpriseRemoved = true;
+				} else {
+					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+					haldata->srestpriv.Wifi_Error_Status = USB_VEN_REQ_CMD_FAIL;
+				}
+			} else { /*  status != len && status >= 0 */
+				if (status > 0) {
+					if (requesttype == 0x01) {
+						/*  For Control read transfer, we have to copy the read data from pIo_buf to pdata. */
+						memcpy(pdata, pIo_buf,  len);
+					}
+				}
+			}
+
+			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
+				adapt->bSurpriseRemoved = true;
+				break;
+			}
+
+		}
+
+		/*  firmware download is checksumed, don't retry */
+		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
+			break;
+	}
+release_mutex:
+	_exit_critical_mutex(&dvobjpriv->usb_vendor_req_mutex, NULL);
+exit:
+	return status;
+}
+
+static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	u8 data = 0;
+
+
+
+	request = 0x05;
+	requesttype = 0x01;/* read_in */
+	index = 0;/* n/a */
+
+	wvalue = (u16)(addr&0x0000ffff);
+	len = 1;
+
+	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+
+
+
+	return data;
+
+}
+
+static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	__le32 data;
+
+	request = 0x05;
+	requesttype = 0x01;/* read_in */
+	index = 0;/* n/a */
+	wvalue = (u16)(addr&0x0000ffff);
+	len = 2;
+	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+
+	return (u16)(le32_to_cpu(data)&0xffff);
+}
+
+static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	__le32 data;
+
+	request = 0x05;
+	requesttype = 0x01;/* read_in */
+	index = 0;/* n/a */
+
+	wvalue = (u16)(addr&0x0000ffff);
+	len = 4;
+
+	usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+
+	return le32_to_cpu(data);
+}
+
+static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	u8 data;
+	int ret;
+
+
+	request = 0x05;
+	requesttype = 0x00;/* write_out */
+	index = 0;/* n/a */
+	wvalue = (u16)(addr&0x0000ffff);
+	len = 1;
+	data = val;
+	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+
+	return ret;
+}
+
+static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	__le32 data;
+	int ret;
+
+
+
+	request = 0x05;
+	requesttype = 0x00;/* write_out */
+	index = 0;/* n/a */
+
+	wvalue = (u16)(addr&0x0000ffff);
+	len = 2;
+
+	data = cpu_to_le32(val & 0x0000ffff);
+
+	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+
+
+
+	return ret;
+}
+
+static int usb_write32(struct intf_hdl *pintfhdl, u32 addr, u32 val)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	__le32 data;
+	int ret;
+
+
+
+	request = 0x05;
+	requesttype = 0x00;/* write_out */
+	index = 0;/* n/a */
+
+	wvalue = (u16)(addr&0x0000ffff);
+	len = 4;
+	data = cpu_to_le32(val);
+
+	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, &data, len, requesttype);
+
+
+
+	return ret;
+}
+
+static int usb_writeN(struct intf_hdl *pintfhdl, u32 addr, u32 length, u8 *pdata)
+{
+	u8 request;
+	u8 requesttype;
+	u16 wvalue;
+	u16 index;
+	u16 len;
+	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
+	int ret;
+
+
+
+	request = 0x05;
+	requesttype = 0x00;/* write_out */
+	index = 0;/* n/a */
+
+	wvalue = (u16)(addr&0x0000ffff);
+	len = length;
+	 memcpy(buf, pdata, len);
+
+	ret = usbctrl_vendorreq(pintfhdl, request, wvalue, index, buf, len, requesttype);
+
+
+
+	return ret;
+}
+
+static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
+{
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+
+	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
+		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
+		return;
+	}
+
+	/*  HISR */
+	memcpy(&(haldata->IntArray[0]), &(pbuf[USB_INTR_CONTENT_HISR_OFFSET]), 4);
+	memcpy(&(haldata->IntArray[1]), &(pbuf[USB_INTR_CONTENT_HISRE_OFFSET]), 4);
+
+	/*  C2H Event */
+	if (pbuf[0] != 0)
+		memcpy(&(haldata->C2hArray[0]), &(pbuf[USB_INTR_CONTENT_C2H_OFFSET]), 16);
+}
+
+static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
+{
+	u8	*pbuf;
+	u8	shift_sz = 0;
+	u16	pkt_cnt;
+	u32	pkt_offset, skb_len, alloc_sz;
+	s32	transfer_len;
+	struct recv_stat	*prxstat;
+	struct phy_stat	*pphy_status = NULL;
+	struct sk_buff *pkt_copy = NULL;
+	struct recv_frame	*precvframe = NULL;
+	struct rx_pkt_attrib	*pattrib = NULL;
+	struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+	struct recv_priv	*precvpriv = &adapt->recvpriv;
+	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
+
+	transfer_len = (s32)pskb->len;
+	pbuf = pskb->data;
+
+	prxstat = (struct recv_stat *)pbuf;
+	pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
+
+	do {
+		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_,
+			 ("recvbuf2recvframe: rxdesc=offsset 0:0x%08x, 4:0x%08x, 8:0x%08x, C:0x%08x\n",
+			  prxstat->rxdw0, prxstat->rxdw1, prxstat->rxdw2, prxstat->rxdw4));
+
+		prxstat = (struct recv_stat *)pbuf;
+
+		precvframe = rtw_alloc_recvframe(pfree_recv_queue);
+		if (precvframe == NULL) {
+			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvbuf2recvframe: precvframe==NULL\n"));
+			DBG_88E("%s()-%d: rtw_alloc_recvframe() failed! RX Drop!\n", __func__, __LINE__);
+			goto _exit_recvbuf2recvframe;
+		}
+
+		INIT_LIST_HEAD(&precvframe->list);
+		precvframe->precvbuf = NULL;	/* can't access the precvbuf for new arch. */
+		precvframe->len = 0;
+
+		update_recvframe_attrib_88e(precvframe, prxstat);
+
+		pattrib = &precvframe->attrib;
+
+		if ((pattrib->crc_err) || (pattrib->icv_err)) {
+			DBG_88E("%s: RX Warning! crc_err=%d icv_err=%d, skip!\n", __func__, pattrib->crc_err, pattrib->icv_err);
+
+			rtw_free_recvframe(precvframe, pfree_recv_queue);
+			goto _exit_recvbuf2recvframe;
+		}
+
+		if ((pattrib->physt) && (pattrib->pkt_rpt_type == NORMAL_RX))
+			pphy_status = (struct phy_stat *)(pbuf + RXDESC_OFFSET);
+
+		pkt_offset = RXDESC_SIZE + pattrib->drvinfo_sz + pattrib->shift_sz + pattrib->pkt_len;
+
+		if ((pattrib->pkt_len <= 0) || (pkt_offset > transfer_len)) {
+			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("recvbuf2recvframe: pkt_len<=0\n"));
+			DBG_88E("%s()-%d: RX Warning!,pkt_len<=0 or pkt_offset> transfoer_len\n", __func__, __LINE__);
+			rtw_free_recvframe(precvframe, pfree_recv_queue);
+			goto _exit_recvbuf2recvframe;
+		}
+
+		/*	Modified by Albert 20101213 */
+		/*	For 8 bytes IP header alignment. */
+		if (pattrib->qos)	/*	Qos data, wireless lan header length is 26 */
+			shift_sz = 6;
+		else
+			shift_sz = 0;
+
+		skb_len = pattrib->pkt_len;
+
+		/*  for first fragment packet, driver need allocate 1536+drvinfo_sz+RXDESC_SIZE to defrag packet. */
+		/*  modify alloc_sz for recvive crc error packet by thomas 2011-06-02 */
+		if ((pattrib->mfrag == 1) && (pattrib->frag_num == 0)) {
+			if (skb_len <= 1650)
+				alloc_sz = 1664;
+			else
+				alloc_sz = skb_len + 14;
+		} else {
+			alloc_sz = skb_len;
+			/*	6 is for IP header 8 bytes alignment in QoS packet case. */
+			/*	8 is for skb->data 4 bytes alignment. */
+			alloc_sz += 14;
+		}
+
+		pkt_copy = netdev_alloc_skb(adapt->pnetdev, alloc_sz);
+		if (pkt_copy) {
+			pkt_copy->dev = adapt->pnetdev;
+			precvframe->pkt = pkt_copy;
+			precvframe->rx_head = pkt_copy->data;
+			precvframe->rx_end = pkt_copy->data + alloc_sz;
+			skb_reserve(pkt_copy, 8 - ((size_t)(pkt_copy->data) & 7));/* force pkt_copy->data at 8-byte alignment address */
+			skb_reserve(pkt_copy, shift_sz);/* force ip_hdr at 8-byte alignment address according to shift_sz. */
+			memcpy(pkt_copy->data, (pbuf + pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
+			precvframe->rx_tail = pkt_copy->data;
+			precvframe->rx_data = pkt_copy->data;
+		} else {
+			if ((pattrib->mfrag == 1) && (pattrib->frag_num == 0)) {
+				DBG_88E("recvbuf2recvframe: alloc_skb fail , drop frag frame\n");
+				rtw_free_recvframe(precvframe, pfree_recv_queue);
+				goto _exit_recvbuf2recvframe;
+			}
+			precvframe->pkt = skb_clone(pskb, GFP_ATOMIC);
+			if (precvframe->pkt) {
+				precvframe->rx_tail = pbuf + pattrib->drvinfo_sz + RXDESC_SIZE;
+				precvframe->rx_head = precvframe->rx_tail;
+				precvframe->rx_data = precvframe->rx_tail;
+				precvframe->rx_end =  pbuf + pattrib->drvinfo_sz + RXDESC_SIZE + alloc_sz;
+			} else {
+				DBG_88E("recvbuf2recvframe: skb_clone fail\n");
+				rtw_free_recvframe(precvframe, pfree_recv_queue);
+				goto _exit_recvbuf2recvframe;
+			}
+		}
+
+		recvframe_put(precvframe, skb_len);
+
+		switch (haldata->UsbRxAggMode) {
+		case USB_RX_AGG_DMA:
+		case USB_RX_AGG_MIX:
+			pkt_offset = (u16)_RND128(pkt_offset);
+			break;
+		case USB_RX_AGG_USB:
+			pkt_offset = (u16)_RND4(pkt_offset);
+			break;
+		case USB_RX_AGG_DISABLE:
+		default:
+			break;
+		}
+		if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
+			if (pattrib->physt)
+				update_recvframe_phyinfo_88e(precvframe, (struct phy_stat *)pphy_status);
+			if (rtw_recv_entry(precvframe) != _SUCCESS) {
+				RT_TRACE(_module_rtl871x_recv_c_, _drv_err_,
+					("recvbuf2recvframe: rtw_recv_entry(precvframe) != _SUCCESS\n"));
+			}
+		} else {
+			/* enqueue recvframe to txrtp queue */
+			if (pattrib->pkt_rpt_type == TX_REPORT1) {
+				/* CCX-TXRPT ack for xmit mgmt frames. */
+				handle_txrpt_ccx_88e(adapt, precvframe->rx_data);
+			} else if (pattrib->pkt_rpt_type == TX_REPORT2) {
+				ODM_RA_TxRPT2Handle_8188E(
+							&haldata->odmpriv,
+							precvframe->rx_data,
+							pattrib->pkt_len,
+							pattrib->MacIDValidEntry[0],
+							pattrib->MacIDValidEntry[1]
+							);
+			} else if (pattrib->pkt_rpt_type == HIS_REPORT) {
+				interrupt_handler_8188eu(adapt, pattrib->pkt_len, precvframe->rx_data);
+			}
+			rtw_free_recvframe(precvframe, pfree_recv_queue);
+		}
+		pkt_cnt--;
+		transfer_len -= pkt_offset;
+		pbuf += pkt_offset;
+		precvframe = NULL;
+		pkt_copy = NULL;
+
+		if (transfer_len > 0 && pkt_cnt == 0)
+			pkt_cnt = (le32_to_cpu(prxstat->rxdw2)>>16) & 0xff;
+
+	} while ((transfer_len > 0) && (pkt_cnt > 0));
+
+_exit_recvbuf2recvframe:
+
+	return _SUCCESS;
+}
+
+void rtl8188eu_recv_tasklet(void *priv)
+{
+	struct sk_buff *pskb;
+	struct adapter *adapt = (struct adapter *)priv;
+	struct recv_priv *precvpriv = &adapt->recvpriv;
+
+	while (NULL != (pskb = skb_dequeue(&precvpriv->rx_skb_queue))) {
+		if ((adapt->bDriverStopped) || (adapt->bSurpriseRemoved)) {
+			DBG_88E("recv_tasklet => bDriverStopped or bSurpriseRemoved\n");
+			dev_kfree_skb_any(pskb);
+			break;
+		}
+		recvbuf2recvframe(adapt, pskb);
+		skb_reset_tail_pointer(pskb);
+		pskb->len = 0;
+		skb_queue_tail(&precvpriv->free_recv_skb_queue, pskb);
+	}
+}
+
+static void usb_read_port_complete(struct urb *purb, struct pt_regs *regs)
+{
+	struct recv_buf	*precvbuf = (struct recv_buf *)purb->context;
+	struct adapter	*adapt = (struct adapter *)precvbuf->adapter;
+	struct recv_priv *precvpriv = &adapt->recvpriv;
+
+	RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete!!!\n"));
+
+	precvpriv->rx_pending_cnt--;
+
+	if (adapt->bSurpriseRemoved || adapt->bDriverStopped || adapt->bReadPortCancel) {
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("usb_read_port_complete:bDriverStopped(%d) OR bSurpriseRemoved(%d)\n",
+			 adapt->bDriverStopped, adapt->bSurpriseRemoved));
+
+		precvbuf->reuse = true;
+		DBG_88E("%s() RX Warning! bDriverStopped(%d) OR bSurpriseRemoved(%d) bReadPortCancel(%d)\n",
+			__func__, adapt->bDriverStopped,
+			adapt->bSurpriseRemoved, adapt->bReadPortCancel);
+		return;
+	}
+
+	if (purb->status == 0) { /* SUCCESS */
+		if ((purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)) {
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("usb_read_port_complete: (purb->actual_length > MAX_RECVBUF_SZ) || (purb->actual_length < RXDESC_SIZE)\n"));
+			precvbuf->reuse = true;
+			rtw_read_port(adapt, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf);
+			DBG_88E("%s()-%d: RX Warning!\n", __func__, __LINE__);
+		} else {
+			rtw_reset_continual_urb_error(adapter_to_dvobj(adapt));
+
+			precvbuf->transfer_len = purb->actual_length;
+			skb_put(precvbuf->pskb, purb->actual_length);
+			skb_queue_tail(&precvpriv->rx_skb_queue, precvbuf->pskb);
+
+			if (skb_queue_len(&precvpriv->rx_skb_queue) <= 1)
+				tasklet_schedule(&precvpriv->recv_tasklet);
+
+			precvbuf->pskb = NULL;
+			precvbuf->reuse = false;
+			rtw_read_port(adapt, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf);
+		}
+	} else {
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete : purb->status(%d) != 0\n", purb->status));
+
+		DBG_88E("###=> usb_read_port_complete => urb status(%d)\n", purb->status);
+		skb_put(precvbuf->pskb, purb->actual_length);
+		precvbuf->pskb = NULL;
+
+		if (rtw_inc_and_chk_continual_urb_error(adapter_to_dvobj(adapt)))
+			adapt->bSurpriseRemoved = true;
+
+		switch (purb->status) {
+		case -EINVAL:
+		case -EPIPE:
+		case -ENODEV:
+		case -ESHUTDOWN:
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete:bSurpriseRemoved=true\n"));
+			__attribute__((__fallthrough__));
+		case -ENOENT:
+			adapt->bDriverStopped = true;
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("usb_read_port_complete:bDriverStopped=true\n"));
+			break;
+		case -EPROTO:
+		case -EOVERFLOW:
+			{
+				struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+				haldata->srestpriv.Wifi_Error_Status = USB_READ_PORT_FAIL;
+			}
+			precvbuf->reuse = true;
+			rtw_read_port(adapt, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf);
+			break;
+		case -EINPROGRESS:
+			DBG_88E("ERROR: URB IS IN PROGRESS!/n");
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static u32 usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
+{
+	struct urb *purb = NULL;
+	struct recv_buf	*precvbuf = (struct recv_buf *)rmem;
+	struct adapter		*adapter = pintfhdl->padapter;
+	struct dvobj_priv	*pdvobj = adapter_to_dvobj(adapter);
+	struct recv_priv	*precvpriv = &adapter->recvpriv;
+	struct usb_device	*pusbd = pdvobj->pusbdev;
+	int err;
+	unsigned int pipe;
+	size_t tmpaddr = 0;
+	size_t alignment = 0;
+	u32 ret = _SUCCESS;
+
+	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
+	    adapter->pwrctrlpriv.pnp_bstop_trx) {
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("usb_read_port:(adapt->bDriverStopped ||adapt->bSurpriseRemoved ||adapter->pwrctrlpriv.pnp_bstop_trx)!!!\n"));
+		return _FAIL;
+	}
+
+	if (!precvbuf) {
+		RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+			 ("usb_read_port:precvbuf==NULL\n"));
+		return _FAIL;
+	}
+
+	if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
+		precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
+		if (NULL != precvbuf->pskb)
+			precvbuf->reuse = true;
+	}
+
+		rtl8188eu_init_recvbuf(adapter, precvbuf);
+
+		/* re-assign for linux based on skb */
+		if ((!precvbuf->reuse) || (precvbuf->pskb == NULL)) {
+			precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
+			if (precvbuf->pskb == NULL) {
+				RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("init_recvbuf(): alloc_skb fail!\n"));
+				DBG_88E("#### usb_read_port() alloc_skb fail!#####\n");
+				return _FAIL;
+			}
+
+			tmpaddr = (size_t)precvbuf->pskb->data;
+			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ-1);
+			skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
+
+			precvbuf->phead = precvbuf->pskb->head;
+			precvbuf->pdata = precvbuf->pskb->data;
+			precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
+			precvbuf->pend = skb_end_pointer(precvbuf->pskb);
+			precvbuf->pbuf = precvbuf->pskb->data;
+		} else { /* reuse skb */
+			precvbuf->phead = precvbuf->pskb->head;
+			precvbuf->pdata = precvbuf->pskb->data;
+			precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
+			precvbuf->pend = skb_end_pointer(precvbuf->pskb);
+			precvbuf->pbuf = precvbuf->pskb->data;
+
+			precvbuf->reuse = false;
+		}
+
+		precvpriv->rx_pending_cnt++;
+
+		purb = precvbuf->purb;
+
+		/* translate DMA FIFO addr to pipehandle */
+		pipe = ffaddr2pipehdl(pdvobj, addr);
+
+		usb_fill_bulk_urb(purb, pusbd, pipe,
+				  precvbuf->pbuf,
+				  MAX_RECVBUF_SZ,
+				  usb_read_port_complete,
+				  precvbuf);/* context is precvbuf */
+
+		err = usb_submit_urb(purb, GFP_ATOMIC);
+		if ((err) && (err != (-EPERM))) {
+			RT_TRACE(_module_hci_ops_os_c_, _drv_err_,
+				 ("cannot submit rx in-token(err=0x%.8x), URB_STATUS =0x%.8x",
+				 err, purb->status));
+			DBG_88E("cannot submit rx in-token(err = 0x%08x),urb_status = %d\n",
+				err, purb->status);
+			ret = _FAIL;
+		}
+
+	return ret;
+}
+
+void rtl8188eu_xmit_tasklet(void *priv)
+{
+	int ret = false;
+	struct adapter *adapt = (struct adapter *)priv;
+	struct xmit_priv *pxmitpriv = &adapt->xmitpriv;
+
+	if (check_fwstate(&adapt->mlmepriv, _FW_UNDER_SURVEY))
+		return;
+
+	while (1) {
+		if ((adapt->bDriverStopped) ||
+		    (adapt->bSurpriseRemoved) ||
+		    (adapt->bWritePortCancel)) {
+			DBG_88E("xmit_tasklet => bDriverStopped or bSurpriseRemoved or bWritePortCancel\n");
+			break;
+		}
+
+		ret = rtl8188eu_xmitframe_complete(adapt, pxmitpriv, NULL);
+
+		if (!ret)
+			break;
+	}
+}
+
+void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
+{
+
+	memset((u8 *)pops, 0, sizeof(struct _io_ops));
+	pops->_read8 = &usb_read8;
+	pops->_read16 = &usb_read16;
+	pops->_read32 = &usb_read32;
+	pops->_read_mem = &usb_read_mem;
+	pops->_read_port = &usb_read_port;
+	pops->_write8 = &usb_write8;
+	pops->_write16 = &usb_write16;
+	pops->_write32 = &usb_write32;
+	pops->_writeN = &usb_writeN;
+	pops->_write_mem = &usb_write_mem;
+	pops->_write_port = &usb_write_port;
+	pops->_read_port_cancel = &usb_read_port_cancel;
+	pops->_write_port_cancel = &usb_write_port_cancel;
+
+}
+
+void rtl8188eu_set_hw_type(struct adapter *adapt)
+{
+	adapt->chip_type = RTL8188E;
+	adapt->HardwareType = HARDWARE_TYPE_RTL8188EU;
+	DBG_88E("CHIP TYPE: RTL8188E\n");
+}
-- 
2.31.1


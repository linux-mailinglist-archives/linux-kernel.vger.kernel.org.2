Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA545EF66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377552AbhKZNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377600AbhKZNsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:48:17 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24ABC0619D7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:04:22 -0800 (PST)
Received: from dslb-178-004-171-146.178.004.pools.vodafone-ip.de ([178.4.171.146] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqatn-0006Hl-CD; Fri, 26 Nov 2021 14:04:19 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 2/4] staging: r8188eu: remove _ps_open_RF
Date:   Fri, 26 Nov 2021 14:03:58 +0100
Message-Id: <20211126130400.26151-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126130400.26151-1-martin@kaiser.cx>
References: <20211125164745.8188-1-martin@kaiser.cx>
 <20211126130400.26151-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _ps_open_RF function is empty. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - remove _ps_open_RF prototype

 drivers/staging/r8188eu/hal/usb_halinit.c      | 8 --------
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 04518e9838ea..995ea4a55435 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -615,8 +615,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_BEGIN);
 
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
-		_ps_open_RF(Adapter);
-
 		if (haldata->odmpriv.RFCalibrateInfo.bIQKInitialized) {
 			PHY_IQCalibrate_8188E(Adapter, true);
 		} else {
@@ -852,12 +850,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	return status;
 }
 
-void _ps_open_RF(struct adapter *adapt)
-{
-	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
-	/* phy_SsPwrSwitch92CU(adapt, rf_on, 1); */
-}
-
 static void _ps_close_RF(struct adapter *adapt)
 {
 	/* here call with bRegSSPwrLvl 1, bRegSSPwrLvl 2 needs to be verified */
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 5848f1d4191a..176b82219459 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -331,6 +331,5 @@ void rtl8188e_read_chip_version(struct adapter *padapter);
 
 s32 rtl8188e_iol_efuse_patch(struct adapter *padapter);
 void rtw_cancel_all_timer(struct adapter *padapter);
-void _ps_open_RF(struct adapter *adapt);
 
 #endif /* __RTL8188E_HAL_H__ */
-- 
2.20.1


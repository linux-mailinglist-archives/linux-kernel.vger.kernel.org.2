Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8AA4282C8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhJJRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhJJRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:54:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290CC061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 10:52:35 -0700 (PDT)
Received: from dslb-188-104-061-167.188.104.pools.vodafone-ip.de ([188.104.61.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mZczv-0001WC-Ih; Sun, 10 Oct 2021 19:52:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/11] staging: r8188eu: RfOnOffDetect is unused
Date:   Sun, 10 Oct 2021 19:51:56 +0200
Message-Id: <20211010175204.24029-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010175204.24029-1-martin@kaiser.cx>
References: <20211010175204.24029-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the RfOnOffDetect function, which is not used.

Suggested-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c     | 18 ------------------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 94a2b3e32fe7..f6db5b05e6e7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -599,24 +599,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
 }
 
-enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
-{
-	u8 val8;
-	enum rt_rf_power_state rfpowerstate = rf_off;
-
-	if (adapt->pwrctrlpriv.bHWPowerdown) {
-		val8 = rtw_read8(adapt, REG_HSISR);
-		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
-		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
-	} else { /*  rf on/off */
-		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
-		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL);
-		DBG_88E("GPIO_IN=%02x\n", val8);
-		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
-	}
-	return rfpowerstate;
-}	/*  HalDetectPwrDownMode */
-
 u32 rtl8188eu_hal_init(struct adapter *Adapter)
 {
 	u8 value8 = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_pwrctrl.h b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
index e412ef71b54b..47a20702e376 100644
--- a/drivers/staging/r8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/r8188eu/include/rtw_pwrctrl.h
@@ -143,8 +143,6 @@ int ips_leave(struct adapter *padapter);
 
 void rtw_ps_processor(struct adapter *padapter);
 
-enum rt_rf_power_state RfOnOffDetect(struct adapter *iadapter);
-
 s32 LPS_RF_ON_check(struct adapter *adapter, u32 delay_ms);
 void LPS_Enter(struct adapter *adapter);
 void LPS_Leave(struct adapter *adapter);
-- 
2.20.1


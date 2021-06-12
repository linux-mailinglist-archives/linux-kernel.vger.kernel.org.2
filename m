Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC1A3A5000
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhFLSDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhFLSDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 14:03:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD81C061574;
        Sat, 12 Jun 2021 11:01:20 -0700 (PDT)
Received: from dslb-188-097-213-151.188.097.pools.vodafone-ip.de ([188.97.213.151] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ls7wa-0003B8-88; Sat, 12 Jun 2021 20:01:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/6] staging: rtl8188eu: remove another write-only member
Date:   Sat, 12 Jun 2021 20:00:18 +0200
Message-Id: <20210612180019.20387-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210612180019.20387-1-martin@kaiser.cx>
References: <20210612180019.20387-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bAPKThermalMeterIgnore in struct hal_data_8188e is never read and can
be removed.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/rtl8188eu/include/rtl8188e_hal.h  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 95b27b4df705..0b46af1755ed 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -567,7 +567,6 @@ void Hal_ReadThermalMeter_88E(struct adapter *Adapter, u8 *PROMContent, bool Aut
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
 
 	if (pHalData->EEPROMThermalMeter == 0xff || AutoloadFail) {
-		pHalData->bAPKThermalMeterIgnore = true;
 		pHalData->EEPROMThermalMeter = EEPROM_Default_ThermalMeter_88E;
 	}
 	DBG_88E("ThermalMeter = 0x%x\n", pHalData->EEPROMThermalMeter);
diff --git a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
index 20049bdf39f5..0bfab5990d27 100644
--- a/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/rtl8188eu/include/rtl8188e_hal.h
@@ -208,7 +208,6 @@ struct hal_data_8188e {
 
 	u8	bTXPowerDataReadFromEEPORM;
 	u8	EEPROMThermalMeter;
-	u8	bAPKThermalMeterIgnore;
 
 	bool	EepromOrEfuse;
 
-- 
2.20.1


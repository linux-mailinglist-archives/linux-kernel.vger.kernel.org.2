Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2703CCA0F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 19:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhGRRkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 13:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhGRRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 13:40:24 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638DC061762;
        Sun, 18 Jul 2021 10:37:25 -0700 (PDT)
Received: from dslb-178-004-206-019.178.004.pools.vodafone-ip.de ([178.4.206.19] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1m5Aj8-0006oR-PA; Sun, 18 Jul 2021 19:37:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 01/10] staging: rtl8188eu: merge two functions
Date:   Sun, 18 Jul 2021 19:36:01 +0200
Message-Id: <20210718173610.894-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All that rtw_hal_read_chip_info does is call _ReadPROMContent. Merge the
two functions.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 05c67e7d23ad..56de6071eb72 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -990,25 +990,18 @@ static void readAdapterInfo_8188EU(struct adapter *adapt)
 	Hal_ReadThermalMeter_88E(adapt, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 }
 
-static void _ReadPROMContent(struct adapter *Adapter)
+void rtw_hal_read_chip_info(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(Adapter);
-	u8 eeValue;
+	u8 eeValue = usb_read8(Adapter, REG_9346CR);
 
-	/* check system boot selection */
-	eeValue = usb_read8(Adapter, REG_9346CR);
-	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
-	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
+	eeprom->EepromOrEfuse = (eeValue & BOOT_FROM_EEPROM) ? true : false;
+	eeprom->bautoload_fail_flag = (eeValue & EEPROM_EN) ? false : true;
 
 	Hal_InitPGData88E(Adapter);
 	readAdapterInfo_8188EU(Adapter);
 }
 
-void rtw_hal_read_chip_info(struct adapter *Adapter)
-{
-	_ReadPROMContent(Adapter);
-}
-
 #define GPIO_DEBUG_PORT_NUM 0
 static void rtl8192cu_trigger_gpio_0(struct adapter *adapt)
 {
-- 
2.20.1


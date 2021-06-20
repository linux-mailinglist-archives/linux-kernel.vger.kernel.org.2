Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759933ADFB9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhFTR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFTRzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:55:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE6C061574;
        Sun, 20 Jun 2021 10:53:32 -0700 (PDT)
Received: from dslb-084-059-235-131.084.059.pools.vodafone-ip.de ([84.59.235.131] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lv1dS-00012S-LR; Sun, 20 Jun 2021 19:53:30 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/13] staging: rtl8188eu: remove RT_TRACE and MSG_88E prints from usb_halinit.c
Date:   Sun, 20 Jun 2021 19:52:55 +0200
Message-Id: <20210620175301.14988-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210620175301.14988-1-martin@kaiser.cx>
References: <20210620175301.14988-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eventually, all driver-specific debug prints should be removed.
Take another step in that direction.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index dcdf868b394d..3ecc0186fea0 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -664,7 +664,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PW_ON);
 	status = rtw_hal_power_on(Adapter);
 	if (status == _FAIL) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init power on!\n"));
 		goto exit;
 	}
 
@@ -704,7 +703,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 			Adapter->bFWReady = false;
 			return status;
 		}
-		RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializeadapt8192CSdio(): Download Firmware Success!!\n"));
 		Adapter->bFWReady = true;
 	}
 	rtl8188e_InitializeFirmwareVars(Adapter);
@@ -725,7 +723,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_LLTT);
 	status =  InitLLTTable(Adapter, txpktbuf_bndy);
 	if (status == _FAIL) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init LLT table\n"));
 		goto exit;
 	}
 
@@ -861,8 +858,6 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 {
 	u8 val8;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("%s\n", __func__));
-
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
 	val8 = usb_read8(Adapter, REG_TX_RPT_CTRL);
 	usb_write8(Adapter, REG_TX_RPT_CTRL, val8 & (~BIT(1)));
@@ -954,14 +949,10 @@ u32 rtw_hal_inirp_init(struct adapter *Adapter)
 
 	status = _SUCCESS;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
-		 ("===> usb_inirp_init\n"));
-
 	/* issue Rx irp to receive data */
 	precvbuf = precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
 		if (!usb_read_port(Adapter, RECV_BULK_IN_ADDR, precvbuf)) {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("usb_rx_init: usb_read_port error\n"));
 			status = _FAIL;
 			goto exit;
 		}
@@ -970,9 +961,6 @@ u32 rtw_hal_inirp_init(struct adapter *Adapter)
 	}
 
 exit:
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<=== usb_inirp_init\n"));
-
 	return status;
 }
 
@@ -1016,8 +1004,6 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 		/* Read Permanent MAC address */
 		memcpy(eeprom->mac_addr, &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);
 	}
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
-		 ("%s: Permanent Address = %pM\n", __func__, eeprom->mac_addr));
 }
 
 static void readAdapterInfo_8188EU(struct adapter *adapt)
@@ -1056,14 +1042,7 @@ static void _ReadPROMContent(struct adapter *Adapter)
 
 void rtw_hal_read_chip_info(struct adapter *Adapter)
 {
-	unsigned long start = jiffies;
-
-	MSG_88E("====> %s\n", __func__);
-
 	_ReadPROMContent(Adapter);
-
-	MSG_88E("<==== %s in %d ms\n", __func__,
-		jiffies_to_msecs(jiffies - start));
 }
 
 #define GPIO_DEBUG_PORT_NUM 0
-- 
2.20.1


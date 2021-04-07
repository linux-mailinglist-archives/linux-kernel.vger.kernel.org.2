Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40227357228
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbhDGQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhDGQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:30:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A0AC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 09:30:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so22446029ejy.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMiiVAqMb8E6MZJ5yfX6PQMS5g3j/F7PH4tzUHj6kyY=;
        b=VyrlWrvSV7yKbQGcsN3yeWJIkIXF+75yi8EBzYTWB0Fs0NnPRqNB1cDqA3Z0qLmGYK
         CE144G/9Faw7pP6e///DBiGIGSaqQSM6p8cCH7K/Kvna+HDCwAhCu8aKrs9G2TjqGJrd
         B96KnzH2H5ZJ4nya06wkRjC+mBjZA3Ju81wkOLYcZdPe+4/AZaqlR6p8F1mG/WonOpM6
         UFbxlRU8NSPvSlaK7I2e9PNdMZHna2yoFhqSWyqRevQpZeiNEDPIioN07jsU/naZ99Qd
         O3DHwy/QPO8y/Vdvs8JlBV4cxeJd2fj5kXkHsSxaCa6KI0pgSWu11Vck91DzL1AENKUM
         1A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMiiVAqMb8E6MZJ5yfX6PQMS5g3j/F7PH4tzUHj6kyY=;
        b=bW75lZPKnLQMkkhhRzIuwHpsYhQzEZ0d0qFcizkiL49cnzFNcFNGSeW+SA0C3pJeQz
         WnqJ8t7XFnqtJgFxL61hVAkcA4W/02d9WFo9aMuP56zSVfyZThAd/osat1aCj6AFf312
         yAlVMVRA7JXSEr9HSmSAaoG4Oz6c/H1/3Z28tRC/zMaCG2FFAhaiprSnz0b2s3ElF4xe
         lR6a1S3Aq5Ab2NLb/d45pZrftyCRoEKLGQK5/NNOhwpVvp9R77wU5+vrvsPDFbIB5Ac6
         4rN7kbkpBmB3aDCvYXh1LxVo2+/wwfj2Yabw/mJn5/+EhseqM+XdXNvzaE7gpKgMr8pt
         HL9Q==
X-Gm-Message-State: AOAM533RGJXzmITUH9kNLnT4AvdlxJTR/z8JBHMI/0vy6SMnrLGDGiyi
        pkRhCmjIHErXDYByhfAAmJc=
X-Google-Smtp-Source: ABdhPJyzJ5BTcEAkqyA3FXaoceXpNjAq0IACT/hoSwcrmzr/b5jBpK69ZVeZL7aqHAwOvib0CK2h/g==
X-Received: by 2002:a17:906:704a:: with SMTP id r10mr4740382ejj.312.1617813005132;
        Wed, 07 Apr 2021 09:30:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id c16sm2097703ejx.81.2021.04.07.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 09:30:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, outreachy-kernel@googlegroups.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: hal: Remove camelcase
Date:   Wed,  7 Apr 2021 18:30:00 +0200
Message-Id: <20210407163000.27611-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove camelcase. Issue detected by checkpatch.pl. For now, change only
names of static functions in order to not break the driver's code.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 44 ++++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index b1f02bb9f0a9..5e28818e58e0 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -19,7 +19,7 @@
 /*  */
 /*  Creadted by Roger, 2011.01.31. */
 /*  */
-static void HalSdioGetCmdAddr8723BSdio(
+static void hal_sdio_get_cmd_addr_8723b_sdio(
 	struct adapter *adapter,
 	u8 device_id,
 	u32 addr,
@@ -97,7 +97,7 @@ static u8 get_deviceid(u32 addr)
 
 /*
  * Ref:
- *HalSdioGetCmdAddr8723BSdio()
+ *hal_sdio_get_cmd_addr_8723b_sdio()
  */
 static u32 _cvrt2ftaddr(const u32 addr, u8 *pdevice_id, u16 *poffset)
 {
@@ -426,7 +426,7 @@ static u32 sdio_read_port(
 	psdio = &adapter_to_dvobj(adapter)->intf_data;
 	hal = GET_HAL_DATA(adapter);
 
-	HalSdioGetCmdAddr8723BSdio(adapter, addr, hal->SdioRxFIFOCnt++, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, addr, hal->SdioRxFIFOCnt++, &addr);
 
 	if (cnt > psdio->block_transfer_len)
 		cnt = _RND(cnt, psdio->block_transfer_len);
@@ -475,7 +475,7 @@ static u32 sdio_write_port(
 	}
 
 	cnt = round_up(cnt, 4);
-	HalSdioGetCmdAddr8723BSdio(adapter, addr, cnt >> 2, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, addr, cnt >> 2, &addr);
 
 	if (cnt > psdio->block_transfer_len)
 		cnt = _RND(cnt, psdio->block_transfer_len);
@@ -528,7 +528,7 @@ static s32 _sdio_local_read(
 
 	intfhdl = &adapter->iopriv.intf;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
 	if (!mac_pwr_ctrl_on)
@@ -566,7 +566,7 @@ s32 sdio_local_read(
 
 	intfhdl = &adapter->iopriv.intf;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
 	if (
@@ -612,7 +612,7 @@ s32 sdio_local_write(
 
 	intfhdl = &adapter->iopriv.intf;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
 	if (
@@ -639,24 +639,24 @@ u8 SdioLocalCmd52Read1Byte(struct adapter *adapter, u32 addr)
 	u8 val = 0;
 	struct intf_hdl *intfhdl = &adapter->iopriv.intf;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 	sd_cmd52_read(intfhdl, addr, 1, &val);
 
 	return val;
 }
 
-static u16 SdioLocalCmd52Read2Byte(struct adapter *adapter, u32 addr)
+static u16 sdio_local_cmd52_read2byte(struct adapter *adapter, u32 addr)
 {
 	__le16 val = 0;
 	struct intf_hdl *intfhdl = &adapter->iopriv.intf;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 	sd_cmd52_read(intfhdl, addr, 2, (u8 *)&val);
 
 	return le16_to_cpu(val);
 }
 
-static u32 SdioLocalCmd53Read4Byte(struct adapter *adapter, u32 addr)
+static u32 sdio_local_cmd53_read4byte(struct adapter *adapter, u32 addr)
 {
 
 	u8 mac_pwr_ctrl_on;
@@ -664,7 +664,7 @@ static u32 SdioLocalCmd53Read4Byte(struct adapter *adapter, u32 addr)
 	struct intf_hdl *intfhdl = &adapter->iopriv.intf;
 	__le32 le_tmp;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 	rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
 	if (!mac_pwr_ctrl_on || adapter_to_pwrctl(adapter)->bFwCurrentInPSMode) {
 		sd_cmd52_read(intfhdl, addr, 4, (u8 *)&le_tmp);
@@ -679,21 +679,21 @@ void SdioLocalCmd52Write1Byte(struct adapter *adapter, u32 addr, u8 v)
 {
 	struct intf_hdl *intfhdl = &adapter->iopriv.intf;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 	sd_cmd52_write(intfhdl, addr, 1, &v);
 }
 
-static void SdioLocalCmd52Write4Byte(struct adapter *adapter, u32 addr, u32 v)
+static void sdio_local_cmd52_write4byte(struct adapter *adapter, u32 addr, u32 v)
 {
 	struct intf_hdl *intfhdl = &adapter->iopriv.intf;
 	__le32 le_tmp;
 
-	HalSdioGetCmdAddr8723BSdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
+	hal_sdio_get_cmd_addr_8723b_sdio(adapter, SDIO_LOCAL_DEVICE_ID, addr, &addr);
 	le_tmp = cpu_to_le32(v);
 	sd_cmd52_write(intfhdl, addr, 4, (u8 *)&le_tmp);
 }
 
-static s32 ReadInterrupt8723BSdio(struct adapter *adapter, u32 *phisr)
+static s32 read_interrupt_8723b_sdio(struct adapter *adapter, u32 *phisr)
 {
 	u32 hisr, himr;
 	u8 val8, hisr_len;
@@ -935,7 +935,7 @@ void sd_int_dpc(struct adapter *adapter)
 		status = rtw_malloc(4);
 		if (status) {
 			addr = REG_TXDMA_STATUS;
-			HalSdioGetCmdAddr8723BSdio(adapter, WLAN_IOREG_DEVICE_ID, addr, &addr);
+			hal_sdio_get_cmd_addr_8723b_sdio(adapter, WLAN_IOREG_DEVICE_ID, addr, &addr);
 			_sd_read(intfhdl, addr, 4, status);
 			_sd_write(intfhdl, addr, 4, status);
 			DBG_8192C("%s: SDIO_HISR_TXERR (0x%08x)\n", __func__, le32_to_cpu(*(u32 *)status));
@@ -986,7 +986,7 @@ void sd_int_dpc(struct adapter *adapter)
 
 		hal->sdio_hisr ^= SDIO_HISR_RX_REQUEST;
 		do {
-			hal->SdioRxFIFOSize = SdioLocalCmd52Read2Byte(adapter, SDIO_REG_RX0_REQ_LEN);
+			hal->SdioRxFIFOSize = sdio_local_cmd52_read2byte(adapter, SDIO_REG_RX0_REQ_LEN);
 			if (hal->SdioRxFIFOSize != 0) {
 				recvbuf = sd_recv_rxfifo(adapter, hal->SdioRxFIFOSize);
 				if (recvbuf)
@@ -1002,7 +1002,7 @@ void sd_int_dpc(struct adapter *adapter)
 				break;
 
 			hisr = 0;
-			ReadInterrupt8723BSdio(adapter, &hisr);
+			read_interrupt_8723b_sdio(adapter, &hisr);
 			hisr &= SDIO_HISR_RX_REQUEST;
 			if (!hisr)
 				break;
@@ -1026,7 +1026,7 @@ void sd_int_hdl(struct adapter *adapter)
 	hal = GET_HAL_DATA(adapter);
 
 	hal->sdio_hisr = 0;
-	ReadInterrupt8723BSdio(adapter, &hal->sdio_hisr);
+	read_interrupt_8723b_sdio(adapter, &hal->sdio_hisr);
 
 	if (hal->sdio_hisr & hal->sdio_himr) {
 		u32 v32;
@@ -1036,7 +1036,7 @@ void sd_int_hdl(struct adapter *adapter)
 		/*  clear HISR */
 		v32 = hal->sdio_hisr & MASK_SDIO_HISR_CLEAR;
 		if (v32)
-			SdioLocalCmd52Write4Byte(adapter, SDIO_REG_HISR, v32);
+			sdio_local_cmd52_write4byte(adapter, SDIO_REG_HISR, v32);
 
 		sd_int_dpc(adapter);
 	}
@@ -1059,7 +1059,7 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *adapter)
 
 	hal = GET_HAL_DATA(adapter);
 
-	numof_free_page = SdioLocalCmd53Read4Byte(adapter, SDIO_REG_FREE_TXPG);
+	numof_free_page = sdio_local_cmd53_read4byte(adapter, SDIO_REG_FREE_TXPG);
 
 	memcpy(hal->SdioTxFIFOFreePage, &numof_free_page, 4);
 
-- 
2.30.2


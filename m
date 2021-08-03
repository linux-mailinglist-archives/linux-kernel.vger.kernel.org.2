Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBBD3DF836
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhHCXGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhHCXF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89FCC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so362597wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2N73B/DihbJFYmxQPqgbLioVgD2n7Pce+ipSSMRqdQc=;
        b=iSgB9D3ObYd/uv8DpDxLbLpkpCGEs/ALkm8LR2ghQD7KXQcTgV+rbkyJYxXZEW7r+J
         +oGi3AIqtcp1AVEBenHKziAjJcDzKXEgdHSI374bxqdJ61F9ANTAwJiQXWuwF/T0Pflc
         tApz5IL+mpUWIrIOdwSbN9bwILVBEyscXX2www5POVYMIJgA5OWQ01XYsHzfIOwPg9Qw
         rh4cYVl0Ks3+7B/woF8NElo5HtusBwzADmvTVrRRP4zi74zkjTxfckgNVvEvKBD8y2gB
         XDbliezbZZFt8iJs4pyO+syDGKEYF4cNbkTJ9OdAmNoiwQ5yo7lweXAcAgE5wfI+M1Qw
         NkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2N73B/DihbJFYmxQPqgbLioVgD2n7Pce+ipSSMRqdQc=;
        b=hsKzyX6CDBFJpUyhlb64co+lb/7KbQ5ySOuMo2+2Fp5y94DSDJHV7MPQwAiBvjylzE
         B78QL2NxpxjzTzmEv1tjyq80zoOiEaNoSnYB57UjFdR1sM3Vvwmz5Kt3kUd2SJWIsPhN
         VzOKsYMdp3amI7df8tL0oWd6PxIj+xx0ymcZe/LU90O0VBPyFUCieOTW+PYb5NpLvF9S
         ZiHhjTSq0WLMPzA2mIqbyPUNoKYE3yF9Hm8apEdk4i9zdz+HBIC9VgJiOXwhSlUnRYG0
         yP4WpCUgsBV+yqF6bvn/usSKWTvso1kq5Zlvx5SXHhQkNMxvqk3OaGSyh+5DBUkVDaNQ
         0BUg==
X-Gm-Message-State: AOAM533gJWtwWML8sD3YW+ht7ShcU8tlz10UVNu9SRN3IqPZJ6/vMIjS
        4Ev8RYXV5nWIkUOGx02/STDqmw==
X-Google-Smtp-Source: ABdhPJylIdAeFcP4jL7sArW7I9UGFKwc2x8XXpvMl12kjM4HwiOqH5ENokveSE9cXhakrzjnTw0Qag==
X-Received: by 2002:a1c:980e:: with SMTP id a14mr24276807wme.123.1628031943288;
        Tue, 03 Aug 2021 16:05:43 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:42 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: r8188eu: remove RT_TRACE calls from hal/usb_halinit.c
Date:   Wed,  4 Aug 2021 00:05:34 +0100
Message-Id: <20210803230535.74254-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/usb_halinit.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 27 ++---------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d985894c0f30..a94d1351f944 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -712,10 +712,8 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_PW_ON);
 	status = rtl8188eu_InitPowerOn(Adapter);
-	if (status == _FAIL) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init power on!\n"));
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	/*  Save target channel */
 	haldata->CurrentChannel = 6;/* default set to 6 */
@@ -757,7 +755,6 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 			haldata->fw_ractrl = false;
 			return status;
 		} else {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("Initializeadapt8192CSdio(): Download Firmware Success!!\n"));
 			Adapter->bFWReady = true;
 			haldata->fw_ractrl = false;
 		}
@@ -805,10 +802,8 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_INIT_LLTT);
 	status =  InitLLTTable(Adapter, txpktbuf_bndy);
-	if (status == _FAIL) {
-		RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("Failed to init LLT table\n"));
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_MISC02);
 	/*  Get Rx PHY status in order to report RSSI and others. */
@@ -968,8 +963,6 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	u8 val8;
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("CardDisableRTL8188EU\n"));
-
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
 	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
 	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8&(~BIT1));
@@ -1067,16 +1060,12 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 
 	status = _SUCCESS;
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
-		 ("===> usb_inirp_init\n"));
-
 	precvpriv->ff_hwaddr = RECV_BULK_IN_ADDR;
 
 	/* issue Rx irp to receive data */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
 		if (_read_port(pintfhdl, precvpriv->ff_hwaddr, 0, (unsigned char *)precvbuf) == false) {
-			RT_TRACE(_module_hci_hal_init_c_, _drv_err_, ("usb_rx_init: usb_read_port error\n"));
 			status = _FAIL;
 			goto exit;
 		}
@@ -1086,20 +1075,13 @@ static unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 	}
 
 exit:
-
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("<=== usb_inirp_init\n"));
-
 	return status;
 }
 
 static unsigned int rtl8188eu_inirp_deinit(struct adapter *Adapter)
 {
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("\n ===> usb_rx_deinit\n"));
-
 	rtw_read_port_cancel(Adapter);
 
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_, ("\n <=== usb_rx_deinit\n"));
-
 	return _SUCCESS;
 }
 
@@ -1156,11 +1138,6 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 		/* Read Permanent MAC address */
 		memcpy(eeprom->mac_addr, &hwinfo[EEPROM_MAC_ADDR_88EU], ETH_ALEN);
 	}
-	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_,
-		 ("Hal_EfuseParseMACAddr_8188EU: Permanent Address = %02x-%02x-%02x-%02x-%02x-%02x\n",
-		 eeprom->mac_addr[0], eeprom->mac_addr[1],
-		 eeprom->mac_addr[2], eeprom->mac_addr[3],
-		 eeprom->mac_addr[4], eeprom->mac_addr[5]));
 }
 
 static void Hal_CustomizeByCustomerID_8188EU(struct adapter *adapt)
-- 
2.31.1


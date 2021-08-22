Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ECC3F3FCB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhHVOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhHVOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F7C061757
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u22so32026389lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z01lVAIT1k9oy2LpLJeSNLj1cfkDKwsWBHgfSHlU6eM=;
        b=vAAo9fkp9On+CHXPSFzRW0LGOsJkcrysHrlBMLNG7XrhHPkuf9t4wZP060SYmS0CwJ
         xF0ma4H0eVDvXt6wy1IxCNesgcOijJn5DyK2E/4ahhiKJQ9/xBfz/vaoqHFtPDk+tYTq
         1ZHlKauX3GCYBxJlmmCF8fcN8nVPBpS6BI6vUUH6lKZLpCuj04xt019cEPBKro++A7Je
         IsOtUvaXhRDeammCdPkJ9YxNFfQxssFasaV0zWAdroavvkIFayvSbzIRXSTKxDmaeiRS
         cZORoQ7qnOHMQpQ8EYqXcxUBEG67iH19ws90KmkFPvFlSLxkZaLlfL4FWcO3+I3/gWrg
         tmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z01lVAIT1k9oy2LpLJeSNLj1cfkDKwsWBHgfSHlU6eM=;
        b=KHrx+ojx1dCUFY8WkIWTB3jdKT09BMH5j+mZcJ3IN4xqHc+4LahVpcncUe+sSdS4+S
         jTPz1Y34YHRxjgpWlCPDd6Y9Mp89VqKeZau4icfwcViPTyXxll5Nmm41hu8ZfOW6MNP6
         DKZEdxcVlZLjrm9TpYms0guaYykQmPUWPrY1Ius8VPG3C8SDeeon+9fbh1JbZKHo4PXh
         jlpQW7J3Qz0/z1+5XRI/5w0SNvHVXkJmeKsS4oHE0bncAOIWDjnxZlFP7X5IiXnamj0t
         Pl3kNkIYzQCQcqh/FKu/zr255SGmEx4k8auH2eim6qAQ/HyyEpf5SGLdGecmB96WMh92
         i/Fw==
X-Gm-Message-State: AOAM5304VvlFEte2jnCv248dcwC8yL6MfdqX5Qvps5kucwEzobiPdmGZ
        6wSKGtqcaa0Bj5eKOxhL2fQ=
X-Google-Smtp-Source: ABdhPJybDnid33aBbSIO3+zAB9wTiMkB8M9fFQ/Pgegmm9s9KjQUnoPqI+BJgagjZ1am1HfRJFna9w==
X-Received: by 2002:ac2:549c:: with SMTP id t28mr20277941lfk.412.1629642956577;
        Sun, 22 Aug 2021 07:35:56 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id d7sm1203412lfg.193.2021.08.22.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:35:56 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC v2 4/6] staging: r8188eu: add error handling of rtw_read16
Date:   Sun, 22 Aug 2021 17:35:54 +0300
Message-Id: <9383351175e4fb73f92f5c303b52176e281bf730.1629642658.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_rtw_read16 function can fail in case of usb transfer failure. But
previous function prototype wasn't designed to return an error to
caller. It can cause a lot uninit value bugs all across the driver code,
since rtw_read16() returns local stack variable to caller.

Fix it by changing the prototype of this function. Now it returns an
int: 0 on success, negative error value on failure and callers should pass
the pointer to storage location for register value.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_debug.c      |  7 +++-
 drivers/staging/r8188eu/core/rtw_io.c         |  9 ++---
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |  4 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |  4 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 29 +++++++++++----
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  5 ++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 37 ++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 19 ++++++++--
 .../staging/r8188eu/include/odm_interface.h   |  2 +-
 drivers/staging/r8188eu/include/rtw_io.h      |  6 +--
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 28 +++++++++++---
 11 files changed, 112 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 8b7d3eb12bd0..a41675e101ac 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -91,7 +91,12 @@ int proc_get_read_reg(char *page, char **start,
 				proc_get_read_addr, (u8) tmp);
 		break;
 	case 2:
-		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n", proc_get_read_addr, rtw_read16(padapter, proc_get_read_addr));
+		error = rtw_read16(padapter, proc_get_read_addr, (u16 *) &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n",
+				proc_get_read_addr, (u16) tmp);
 		break;
 	case 4:
 		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n", proc_get_read_addr, rtw_read32(padapter, proc_get_read_addr));
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 2714506c8ffb..fd64893c778d 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -45,18 +45,15 @@ int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
 	return _read8(pintfhdl, addr, data);
 }
 
-u16 _rtw_read16(struct adapter *adapter, u32 addr)
+int __must_check _rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 {
-	u16 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
+	int (*_read16)(struct intf_hdl *pintfhdl, u32 addr, u16 *data);
 
 	_read16 = pintfhdl->io_ops._read16;
 
-	r_val = _read16(pintfhdl, addr);
-
-	return r_val;
+	return _read16(pintfhdl, addr, data);
 }
 
 u32 _rtw_read32(struct adapter *adapter, u32 addr)
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index 894ab456f202..c6f7636c2174 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -653,7 +653,9 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 			status = NDIS_STATUS_NOT_ACCEPTED;
 		break;
 	case 2:
-		RegRWStruct->value = rtw_read16(Adapter, offset);
+		error = rtw_read16(Adapter, offset, (u16 *) &RegRWStruct->value);
+		if (error)
+			status = NDIS_STATUS_NOT_ACCEPTED;
 		break;
 	default:
 		width = 4;
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 9a9df98da727..669d3e5eafb6 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -10,10 +10,10 @@ int ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 *data)
 	return rtw_read8(Adapter, RegAddr, data);
 }
 
-u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
+int ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 *data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read16(Adapter, RegAddr);
+	return rtw_read16(Adapter, RegAddr, data);
 }
 
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index cfc429965b7d..94e2828c328e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -262,7 +262,11 @@ static void efuse_read_phymap_from_txpktbuf(
 			 * do not remove it as the rtw_read16() call consumes
 			 * 2 bytes from the EEPROM source.
 			 */
-			u16 lenc = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L);
+			u16 lenc;
+
+			error = rtw_read16(adapter, REG_PKTBUF_DBG_DATA_L, &lenc);
+			if (error)
+				return;
 
 			len = le32_to_cpu(lo32) & 0x0000ffff;
 
@@ -778,21 +782,27 @@ hal_EfusePowerSwitch_RTL8188E(
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
 		/*  1.2V Power: From VDDON with Power Cut(0x0000h[15]), defualt valid */
-		tmpV16 = rtw_read16(pAdapter, REG_SYS_ISO_CTRL);
-		if (!(tmpV16 & PWC_EV12V)) {
+		error = rtw_read16(pAdapter, REG_SYS_ISO_CTRL, &tmpV16);
+		if (error) {
+			return;
+		} else if (!(tmpV16 & PWC_EV12V)) {
 			tmpV16 |= PWC_EV12V;
 			rtw_write16(pAdapter, REG_SYS_ISO_CTRL, tmpV16);
 		}
 		/*  Reset: 0x0000h[28], default valid */
-		tmpV16 =  rtw_read16(pAdapter, REG_SYS_FUNC_EN);
-		if (!(tmpV16 & FEN_ELDR)) {
+		error = rtw_read16(pAdapter, REG_SYS_FUNC_EN, &tmpV16);
+		if (error) {
+			return;
+		} else if (!(tmpV16 & FEN_ELDR)) {
 			tmpV16 |= FEN_ELDR;
 			rtw_write16(pAdapter, REG_SYS_FUNC_EN, tmpV16);
 		}
 
 		/*  Clock: Gated(0x0008h[5]) 8M(0x0008h[1]) clock from ANA, default valid */
-		tmpV16 = rtw_read16(pAdapter, REG_SYS_CLKR);
-		if ((!(tmpV16 & LOADER_CLK_EN))  || (!(tmpV16 & ANA8M))) {
+		error = rtw_read16(pAdapter, REG_SYS_CLKR, &tmpV16);
+		if (error) {
+			return;
+		} else if ((!(tmpV16 & LOADER_CLK_EN))  || (!(tmpV16 & ANA8M))) {
 			tmpV16 |= (LOADER_CLK_EN | ANA8M);
 			rtw_write16(pAdapter, REG_SYS_CLKR, tmpV16);
 		}
@@ -1915,8 +1925,11 @@ u8 GetEEPROMSize8188E(struct adapter *padapter)
 {
 	u8 size = 0;
 	u32	cr;
+	int error;
 
-	cr = rtw_read16(padapter, REG_9346CR);
+	error = rtw_read16(padapter, REG_9346CR, (u16 *) &cr);
+	if (error)
+		return size;
 	/*  6: EEPROM used is 93C46, 4: boot from E-Fuse. */
 	size = (cr & BOOT_FROM_EEPROM) ? 6 : 4;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index f6d4c91a97a2..3afb66195413 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -577,11 +577,14 @@ PHY_BBConfig8188E(
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
 	u32 RegVal;
 	u8 CrystalCap;
+	int error;
 
 	phy_InitBBRFRegisterDefinition(Adapter);
 
 	/*  Enable BB and RF */
-	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
+	error = rtw_read16(Adapter, REG_SYS_FUNC_EN, (u16 *) &RegVal);
+	if (error)
+		return _FAIL;
 	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal | BIT(13) | BIT(0) | BIT(1)));
 
 	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4f1d7f9b43c3..4ecccc6499aa 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -90,6 +90,8 @@ static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	u16 value16;
 	/*  HW Power on sequence */
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(adapt);
+	int error;
+
 	if (haldata->bMacPwrCtrlOn)
 		return _SUCCESS;
 
@@ -103,7 +105,10 @@ static u32 rtl8188eu_InitPowerOn(struct adapter *adapt)
 	rtw_write16(adapt, REG_CR, 0x00);  /* suggseted by zhouzhou, by page, 20111230 */
 
 		/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
-	value16 = rtw_read16(adapt, REG_CR);
+	error = rtw_read16(adapt, REG_CR, &value16);
+	if (error)
+		return _FAIL;
+
 	value16 |= (HCI_TXDMA_EN | HCI_RXDMA_EN | TXDMA_EN | RXDMA_EN
 				| PROTOCOL_EN | SCHEDULE_EN | ENSEC | CALTMR_EN);
 	/*  for SDIO - Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
@@ -207,7 +212,14 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 				       u16 bkQ, u16 viQ, u16 voQ, u16 mgtQ,
 				       u16 hiQ)
 {
-	u16 value16	= (rtw_read16(Adapter, REG_TRXDMA_CTRL) & 0x7);
+	u16 value16;
+	int error;
+
+	error = rtw_read16(Adapter, REG_TRXDMA_CTRL, &value16);
+	if (error)
+		return;
+
+	value16 &= 0x7;
 
 	value16 |= _TXDMA_BEQ_MAP(beQ)	| _TXDMA_BKQ_MAP(bkQ) |
 		   _TXDMA_VIQ_MAP(viQ)	| _TXDMA_VOQ_MAP(voQ) |
@@ -868,7 +880,12 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	/*  Hw bug which Hw initials RxFF boundary size to a value which is larger than the real Rx buffer size in 88E. */
 	/*  */
 	/*  Enable MACTXEN/MACRXEN block */
-	value16 = rtw_read16(Adapter, REG_CR);
+	error = rtw_read16(Adapter, REG_CR, &value16);
+	if (error) {
+		status = _FAIL;
+		goto exit;
+	}
+
 	value16 |= (MACTXEN | MACRXEN);
 	rtw_write8(Adapter, REG_CR, value16);
 
@@ -937,6 +954,8 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		Adapter->mppriv.channel = haldata->CurrentChannel;
 		MPT_InitializeAdapter(Adapter, Adapter->mppriv.channel);
 	} else {
+		u16 val16;
+
 		/*  2010/08/11 MH Merge from 8192SE for Minicard init. We need to confirm current radio status */
 		/*  and then decide to enable RF or not.!!!??? For Selective suspend mode. We may not */
 		/*  call initstruct adapter. May cause some problem?? */
@@ -956,7 +975,13 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		rtw_write16(Adapter, REG_TX_RPT_TIME, 0x3DF0);
 
 		/* enable tx DMA to drop the redundate data of packet */
-		rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK) | DROP_DATA_EN));
+		error = rtw_read16(Adapter, REG_TXDMA_OFFSET_CHK, &val16);
+		if (error) {
+			status = _FAIL;
+			goto exit;
+		}
+
+		rtw_write16(Adapter, REG_TXDMA_OFFSET_CHK, (val16 | DROP_DATA_EN));
 
 		HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_IQK);
 		/*  2010/08/26 MH Merge from 8192CE. */
@@ -1982,7 +2007,9 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write8(Adapter, REG_TXPAUSE, 0xff);
 
 			/* keep sn */
-			Adapter->xmitpriv.nqos_ssn = rtw_read16(Adapter, REG_NQOS_SEQ);
+			error = rtw_read16(Adapter, REG_NQOS_SEQ, &Adapter->xmitpriv.nqos_ssn);
+			if (error)
+				return;
 
 			if (!pwrpriv->bkeepfwalive) {
 				/* RX DMA stop */
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 380d126c8b2f..58e852555f54 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -126,19 +126,30 @@ static int usb_read8(struct intf_hdl *pintfhdl, u32 addr, u8 *data)
 	return res;
 }
 
-static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
+static int usb_read16(struct intf_hdl *pintfhdl, u32 addr, u16 *data)
 {
 	u8 requesttype;
 	u16 wvalue;
 	u16 len;
-	__le32 data;
+	int res;
+	__le32 tmp;
+
+	if (WARN_ON(unlikely(!data)))
+		return -EINVAL;
 
 	requesttype = 0x01;/* read_in */
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	res = usbctrl_vendorreq(pintfhdl, wvalue, &tmp, len, requesttype);
+	if (res < 0) {
+		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 16 bytes: %d\n", res);
+	} else {
+		/* Noone cares about positive return value */
+		*data = le32_to_cpu(tmp) & 0xffff;
+		res = 0;
+	}
 
-	return (u16)(le32_to_cpu(data) & 0xffff);
+	return res;
 }
 
 static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 8e531d272927..2455dae6eebb 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -62,7 +62,7 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 int ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 *data);
 
-u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
+int ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 *data);
 
 u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
 
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index fd99b36abca6..c44554c848cf 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -86,7 +86,7 @@ struct io_queue;
 
 struct _io_ops {
 	int (*_read8)(struct intf_hdl *pintfhdl, u32 addr, u8 *data);
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
+	int (*_read16)(struct intf_hdl *pintfhdl, u32 addr, u16 *data);
 	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
 	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
@@ -249,7 +249,7 @@ void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
-u16 _rtw_read16(struct adapter *adapter, u32 addr);
+int __must_check _rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
 u32 _rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
@@ -271,7 +271,7 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 void _rtw_write_port_cancel(struct adapter *adapter);
 
 #define rtw_read8(adapter, addr, data) _rtw_read8((adapter), (addr), (data))
-#define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
+#define rtw_read16(adapter, addr, data) _rtw_read16((adapter), (addr), (data))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_mem(adapter, addr, cnt, mem)				\
 	_rtw_read_mem((adapter), (addr), (cnt), (mem))
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index c9f0772bcbe1..79f0fbaa841e 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2101,7 +2101,10 @@ static int rtw_wx_read32(struct net_device *dev,
 		sprintf(extra, "0x%02X", data32);
 		break;
 	case 2:
-		data32 = rtw_read16(padapter, addr);
+		error = rtw_read16(padapter, addr, (u16 *) &data32);
+		if (error)
+			return error;
+
 		sprintf(extra, "0x%04X", data32);
 		break;
 	case 4:
@@ -2271,7 +2274,8 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 					 (u8 *) &RegRWStruct->value);
 			break;
 		case 2:
-			RegRWStruct->value = rtw_read16(padapter, RegRWStruct->offset);
+			error = rtw_read16(padapter, RegRWStruct->offset,
+					  (u16 *) &RegRWStruct->value);
 			break;
 		case 4:
 			RegRWStruct->value = rtw_read32(padapter, RegRWStruct->offset);
@@ -3990,7 +3994,8 @@ static int rtw_dbg_port(struct net_device *dev,
 				DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, (u8) tmp);
 			break;
 		case 2:
-			DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
+			if (!rtw_read16(padapter, arg, (u16 *) &tmp))
+				DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, (u16) tmp);
 			break;
 		case 4:
 			DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
@@ -4006,8 +4011,12 @@ static int rtw_dbg_port(struct net_device *dev,
 
 			break;
 		case 2:
+			error = rtw_read16(padapter, arg, (u16 *) &tmp);
+			if (error)
+				return error;
+
 			rtw_write16(padapter, arg, extra_arg);
-			DBG_88E("rtw_write16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
+			DBG_88E("rtw_write16(0x%x) = 0x%04x\n", arg, (u16) tmp);
 			break;
 		case 4:
 			rtw_write32(padapter, arg, extra_arg);
@@ -4138,7 +4147,10 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
-			final = rtw_read16(padapter, reg);
+			error = rtw_read16(padapter, reg, &final);
+			if (error)
+				return error;
+
 			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WW_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
 			else
@@ -5387,7 +5399,11 @@ static int rtw_mp_read_reg(struct net_device *dev,
 		break;
 	case 'w':
 		/*  2 bytes */
-		sprintf(data, "%04x\n", rtw_read16(padapter, addr));
+		error = rtw_read16(padapter, addr, (u16 *) &val32);
+		if (error)
+			return error;
+
+		sprintf(data, "%04x\n", (u16) val32);
 		for (i = 0; i <= strlen(data); i++) {
 			if (i % 2 == 0) {
 				tmp[j] = ' ';
-- 
2.32.0


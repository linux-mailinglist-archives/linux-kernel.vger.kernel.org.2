Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B363F3FCA
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhHVOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhHVOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC4C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z2so32129602lft.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbkmLdE0UWQ7ckulymXciZrre8TTNhoBVRW9dwosIb8=;
        b=LGFTWxceykNv0zdd4xrmBTzkOPr3rs7ochoPB03krxlwg+IWb0993MIMoHfEv25Rvi
         v9Hkbe7MB49fDOW+Ep06TNacqCz28KzAC8Xp94cKKZ4Dz8NqSpyMXVoyxFo2TmNN1JLb
         Fv6+gY8od/h656NVDIYC9YMkbmuJ8OdkmC2Vcal2R64TtVXVSH0v+gUVhZ5+/igjJR/h
         NTcui4n0SdUmybeRGYklwMYggFNbhkmFW+jR8tk2hIPGX5X+MyEpFlQZSbrNP/y0Oh4j
         d/VdPMH9FAAyC0gpDYc+csgWhNSf743OP6AjiAuSaDpYivlRbhZNUVHLD571hl4gxx82
         f14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbkmLdE0UWQ7ckulymXciZrre8TTNhoBVRW9dwosIb8=;
        b=qtjqgsDUdwREW/ZofEeOPesGB3j/G8+ZDQMBpdB93EvmkTHy59cDdacP2FgKgZmHIk
         JrpHkp8RMYqHT/PJ/1/MR3d89w23Je9O/maP+GeSSPdrvaWCUPRmqhdqGucGWTs86sEU
         ChWV1yE/Fx+D7dm7IkGsmYGgUx+o2Nd90GMb0THfDW/xAKqNKhH9pBod5EYjAwT/adDs
         GuGZMmde7WvRY0hRiY2HTOTrL9k44KUr9YqPh0Z542g1sBA6HDoIfQfTqsYN9AR6P33v
         KiR4i60fjqRI8Y8iUZgANChScfM78csL3uLVK5CiUDU2s4wVrHvBsSLJMH/WGpVRcXk0
         XQHg==
X-Gm-Message-State: AOAM531ptUBTfta1sEMgzdRpJhdULO4Nc5L6jN2qVvG1msoUiY7tvIY2
        T+U5PF/DMitr5zuerxBxBCITKlEUX2o/F9MR
X-Google-Smtp-Source: ABdhPJwg4FcSYYqC0oq/mIsDMq19cGBL2wv2rC711YXKlT1WEoMzqGpMctJz6lOADckLlFjuipIS/A==
X-Received: by 2002:a05:6512:45b:: with SMTP id y27mr21620151lfk.619.1629642950462;
        Sun, 22 Aug 2021 07:35:50 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id v17sm1209667lfo.66.2021.08.22.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:35:50 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC v2 3/6] staging: r8188eu: add error handling of rtw_read8
Date:   Sun, 22 Aug 2021 17:35:48 +0300
Message-Id: <97f16b2d3d8d16d639d6f0ead8d79639b00405af.1629642658.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_rtw_read8 function can fail in case of usb transfer failure. But
previous function prototype wasn't designed to return an error to
caller. It can cause a lot uninit value bugs all across the driver code,
since rtw_read8() returns local stack variable to caller.

Fix it by changing the prototype of this function. Now it returns an
int: 0 on success, negative error value on failure and callers should pass
the pointer to storage location for register value.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_debug.c      |  11 +-
 drivers/staging/r8188eu/core/rtw_efuse.c      |  76 +++--
 drivers/staging/r8188eu/core/rtw_io.c         |   9 +-
 drivers/staging/r8188eu/core/rtw_mp.c         |  13 +-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |   5 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |  19 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   9 +-
 drivers/staging/r8188eu/hal/hal_com.c         |  23 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |   4 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  33 ++-
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   6 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 128 +++++++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  10 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |   8 +-
 drivers/staging/r8188eu/hal/rtl8188eu_led.c   |  18 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 267 +++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  19 +-
 .../staging/r8188eu/include/odm_interface.h   |   2 +-
 drivers/staging/r8188eu/include/rtw_io.h      |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  61 +++-
 20 files changed, 569 insertions(+), 158 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 2ee64cef73f7..8b7d3eb12bd0 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -73,8 +73,8 @@ int proc_get_read_reg(char *page, char **start,
 {
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-
-	int len = 0;
+	u32 tmp;
+	int len = 0, error;
 
 	if (proc_get_read_addr == 0xeeeeeeee) {
 		*eof = 1;
@@ -83,7 +83,12 @@ int proc_get_read_reg(char *page, char **start,
 
 	switch (proc_get_read_len) {
 	case 1:
-		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n", proc_get_read_addr, rtw_read8(padapter, proc_get_read_addr));
+		error = rtw_read8(padapter, proc_get_read_addr, (u8 *) &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n",
+				proc_get_read_addr, (u8) tmp);
 		break;
 	case 2:
 		len += snprintf(page + len, count - len, "rtw_read16(0x%x)=0x%x\n", proc_get_read_addr, rtw_read16(padapter, proc_get_read_addr));
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index decccf7622f0..b471f6446f78 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -159,6 +159,7 @@ ReadEFuseByte(
 	u32 value32;
 	u8 readbyte;
 	u16 retry;
+	int error;
 
 	if (pseudo) {
 		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
@@ -167,11 +168,17 @@ ReadEFuseByte(
 
 	/* Write Address */
 	rtw_write8(Adapter, EFUSE_CTRL + 1, (_offset & 0xff));
-	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 2);
+	error = rtw_read8(Adapter, EFUSE_CTRL + 2, &readbyte);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, EFUSE_CTRL + 2, ((_offset >> 8) & 0x03) | (readbyte & 0xfc));
 
 	/* Write bit 32 0 */
-	readbyte = rtw_read8(Adapter, EFUSE_CTRL + 3);
+	error = rtw_read8(Adapter, EFUSE_CTRL + 3, &readbyte);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, EFUSE_CTRL + 3, (readbyte & 0x7f));
 
 	/* Check bit 32 read-ready */
@@ -244,6 +251,7 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 	u8 temp = {0x00};
 	u32 k = 0;
 	u16 contentLen = 0;
+	int error;
 
 	EFUSE_GetEfuseDefinition(Adapter, EFUSE_WIFI, TYPE_EFUSE_REAL_CONTENT_LEN, (void *)&contentLen, false);
 
@@ -251,27 +259,42 @@ u8 EFUSE_Read1Byte(struct adapter *Adapter, u16 Address)
 		/* Write E-fuse Register address bit0~7 */
 		temp = Address & 0xFF;
 		rtw_write8(Adapter, EFUSE_CTRL + 1, temp);
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 2);
+		error = rtw_read8(Adapter, EFUSE_CTRL + 2, &Bytetemp);
+		if (error)
+			return 0xFF;
+
 		/* Write E-fuse Register address bit8~9 */
 		temp = ((Address >> 8) & 0x03) | (Bytetemp & 0xFC);
 		rtw_write8(Adapter, EFUSE_CTRL + 2, temp);
 
 		/* Write 0x30[31]= 0 */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
+		error = rtw_read8(Adapter, EFUSE_CTRL + 3, &Bytetemp);
+		if (error)
+			return 0xFF;
+
 		temp = Bytetemp & 0x7F;
 		rtw_write8(Adapter, EFUSE_CTRL + 3, temp);
 
 		/* Wait Write-ready (0x30[31]= 1) */
-		Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
+		error = rtw_read8(Adapter, EFUSE_CTRL + 3, &Bytetemp);
+		if (error)
+			return 0xFF;
+
 		while (!(Bytetemp & 0x80)) {
-			Bytetemp = rtw_read8(Adapter, EFUSE_CTRL + 3);
+			error = rtw_read8(Adapter, EFUSE_CTRL + 3, &Bytetemp);
+			if (error)
+				return 0xFF;
+
 			k++;
 			if (k == 1000) {
 				k = 0;
 				break;
 			}
 		}
-		data = rtw_read8(Adapter, EFUSE_CTRL);
+		error = rtw_read8(Adapter, EFUSE_CTRL, &data);
+		if (error)
+			return 0xFF;
+
 		return data;
 	} else {
 		return 0xFF;
@@ -284,6 +307,8 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 {
 	u8 tmpidx = 0;
 	u8 result;
+	u8 tmp;
+	int error;
 
 	if (pseudo) {
 		result = Efuse_Read1ByteFromFakeContent(pAdapter, addr, data);
@@ -292,16 +317,25 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
 	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
-	rtw_write8(pAdapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
-		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC));
+	error = rtw_read8(pAdapter, EFUSE_CTRL + 2, &tmp);
+	if (error)
+		return false;
 
+	rtw_write8(pAdapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) | (tmp & 0xFC));
 	rtw_write8(pAdapter, EFUSE_CTRL + 3,  0x72);/* read cmd */
 
-	while (!(0x80 & rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
-		tmpidx++;
+	do {
+		error = rtw_read8(pAdapter, EFUSE_CTRL + 3, &tmp);
+		if (error)
+			return false;
+	} while (!(0x80 & tmp) && (++tmpidx < 100));
+
 	if (tmpidx < 100) {
-		*data = rtw_read8(pAdapter, EFUSE_CTRL);
-		result = true;
+		error = rtw_read8(pAdapter, EFUSE_CTRL, data);
+		if (error)
+			result = false;
+		else
+			result = true;
 	} else {
 		*data = 0xff;
 		result = false;
@@ -314,6 +348,8 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 {
 	u8 tmpidx = 0;
 	u8 result;
+	u8 tmp;
+	int error;
 
 	if (pseudo) {
 		result = Efuse_Write1ByteToFakeContent(pAdapter, addr, data);
@@ -323,15 +359,23 @@ u8 efuse_OneByteWrite(struct adapter *pAdapter, u16 addr, u8 data, bool pseudo)
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
 	/* address */
 	rtw_write8(pAdapter, EFUSE_CTRL + 1, (u8)(addr & 0xff));
+
+	error = rtw_read8(pAdapter, EFUSE_CTRL + 2, &tmp);
+	if (error)
+		return false;
+
 	rtw_write8(pAdapter, EFUSE_CTRL + 2,
-		   (rtw_read8(pAdapter, EFUSE_CTRL + 2) & 0xFC) |
+		   (tmp & 0xFC) |
 		   (u8)((addr >> 8) & 0x03));
 	rtw_write8(pAdapter, EFUSE_CTRL, data);/* data */
 
 	rtw_write8(pAdapter, EFUSE_CTRL + 3, 0xF2);/* write cmd */
 
-	while ((0x80 &  rtw_read8(pAdapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
-		tmpidx++;
+	do {
+		error = rtw_read8(pAdapter, EFUSE_CTRL + 3, &tmp);
+		if (error)
+			return false;
+	} while (!(0x80 & tmp) && (++tmpidx < 100));
 
 	if (tmpidx < 100)
 		result = true;
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index cde0205816b1..2714506c8ffb 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,18 +34,15 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr)
+int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data)
 {
-	u8 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl *pintfhdl = &pio_priv->intf;
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
-
+	int (*_read8)(struct intf_hdl *pintfhdl, u32 addr, u8 *data);
 
 	_read8 = pintfhdl->io_ops._read8;
-	r_val = _read8(pintfhdl, addr);
 
-	return r_val;
+	return _read8(pintfhdl, addr, data);
 }
 
 u16 _rtw_read16(struct adapter *adapter, u32 addr)
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 0a0a24fd37b0..76f0bc399819 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -243,10 +243,14 @@ void GetPowerTracking(struct adapter *padapter, u8 *enable)
 static void disable_dm(struct adapter *padapter)
 {
 	u8 v8;
+	int error;
 
 	/* 3 1. disable firmware dynamic mechanism */
 	/*  disable Power Training, Rate Adaptive */
-	v8 = rtw_read8(padapter, REG_BCN_CTRL);
+	error = rtw_read8(padapter, REG_BCN_CTRL, &v8);
+	if (error)
+		return;
+
 	v8 &= ~EN_BCN_FUNCTION;
 	rtw_write8(padapter, REG_BCN_CTRL, v8);
 
@@ -363,8 +367,13 @@ s32 mp_start_test(struct adapter *padapter)
 	spin_unlock_bh(&pmlmepriv->lock);
 
 	if (res == _SUCCESS) {
+		int error;
 		/*  set MSR to WIFI_FW_ADHOC_STATE */
-		val8 = rtw_read8(padapter, MSR) & 0xFC; /*  0x0102 */
+		error = rtw_read8(padapter, MSR, &val8); /*  0x0102 */
+		if (error)
+			return _FAIL;
+
+		val8 &= 0xFC;
 		val8 |= WIFI_FW_ADHOC_STATE;
 		rtw_write8(padapter, MSR, val8); /*  Link in ad hoc network */
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index c85f8e467337..894ab456f202 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -632,6 +632,7 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 	u32		offset, width;
 	int status = NDIS_STATUS_SUCCESS;
 	struct adapter *Adapter = (struct adapter *)(poid_par_priv->adapter_context);
+	int error;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return NDIS_STATUS_NOT_ACCEPTED;
@@ -647,7 +648,9 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 
 	switch (width) {
 	case 1:
-		RegRWStruct->value = rtw_read8(Adapter, offset);
+		error = rtw_read8(Adapter, offset, (u8 *) &RegRWStruct->value);
+		if (error)
+			status = NDIS_STATUS_NOT_ACCEPTED;
 		break;
 	case 2:
 		RegRWStruct->value = rtw_read16(Adapter, offset);
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 356885e27edd..3545ad60dc00 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -660,8 +660,12 @@ static void _PHY_SaveMACRegisters(
 	u32 i;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	int error;
+
 	for (i = 0; i < (IQK_MAC_REG_NUM - 1); i++) {
-		MACBackup[i] = ODM_Read1Byte(dm_odm, MACReg[i]);
+		error = ODM_Read1Byte(dm_odm, MACReg[i], (u8 *) &MACBackup[i]);
+		if (error)
+			return;
 	}
 	MACBackup[i] = ODM_Read4Byte(dm_odm, MACReg[i]);
 }
@@ -1010,9 +1014,12 @@ static void phy_LCCalibrate_8188E(struct adapter *adapt, bool is2t)
 	u32 RF_Amode = 0, RF_Bmode = 0, LC_Cal;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(adapt);
 	struct odm_dm_struct *dm_odm = &pHalData->odmpriv;
+	int error;
 
 	/* Check continuous TX and Packet TX */
-	tmpreg = ODM_Read1Byte(dm_odm, 0xd03);
+	error = ODM_Read1Byte(dm_odm, 0xd03, &tmpreg);
+	if (error)
+		return;
 
 	if ((tmpreg & 0x70) != 0)			/* Deal with contisuous TX case */
 		ODM_Write1Byte(dm_odm, 0xd03, tmpreg & 0x8F);	/* disable all continuous TX */
@@ -1232,7 +1239,13 @@ static void phy_setrfpathswitch_8188e(struct adapter *adapt, bool main, bool is2
 
 	if (!adapt->hw_init_completed) {
 		u8 u1btmp;
-		u1btmp = ODM_Read1Byte(dm_odm, REG_LEDCFG2) | BIT(7);
+		int error;
+
+		error = ODM_Read1Byte(dm_odm, REG_LEDCFG2, &u1btmp);
+		if (error)
+			return;
+
+		u1btmp |= BIT(7);
 		ODM_Write1Byte(dm_odm, REG_LEDCFG2, u1btmp);
 		ODM_SetBBReg(dm_odm, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 	}
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 0fd11aca7ac7..74e83381ef06 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -35,6 +35,7 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 	u32 offset = 0;
 	u32 poll_count = 0; /*  polling autoload done. */
 	u32 max_poll_count = 5000;
+	int error;
 
 	do {
 		pwrcfgcmd = pwrseqcmd[aryidx];
@@ -48,7 +49,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 
 				/*  Read the value from system register */
-				value = rtw_read8(padapter, offset);
+				error = rtw_read8(padapter, offset, &value);
+				if (error)
+					return false;
 
 				value &= ~(GET_PWR_CFG_MASK(pwrcfgcmd));
 				value |= (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd));
@@ -60,7 +63,9 @@ u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 				poll_bit = false;
 				offset = GET_PWR_CFG_OFFSET(pwrcfgcmd);
 				do {
-					value = rtw_read8(padapter, offset);
+					error = rtw_read8(padapter, offset, &value);
+					if (error)
+						return false;
 
 					value &= GET_PWR_CFG_MASK(pwrcfgcmd);
 					if (value == (GET_PWR_CFG_VALUE(pwrcfgcmd) & GET_PWR_CFG_MASK(pwrcfgcmd)))
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index f09d4d49b159..833c88c85e3f 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -321,11 +321,14 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 	struct c2h_evt_hdr *c2h_evt;
 	int i;
 	u8 trigger;
+	int error;
 
 	if (!buf)
 		goto exit;
 
-	trigger = rtw_read8(adapter, REG_C2HEVT_CLEAR);
+	error = rtw_read8(adapter, REG_C2HEVT_CLEAR, &trigger);
+	if (error)
+		goto exit;
 
 	if (trigger == C2H_EVT_HOST_CLOSE)
 		goto exit; /* Not ready */
@@ -336,13 +339,21 @@ s32 c2h_evt_read(struct adapter *adapter, u8 *buf)
 
 	memset(c2h_evt, 0, 16);
 
-	*buf = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL);
-	*(buf + 1) = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1);
+	error = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL, buf);
+	if (error)
+		goto clear_evt;
+
+	error = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + 1, buf + 1);
+	if (error)
+		goto clear_evt;
 
 	/* Read the content */
-	for (i = 0; i < c2h_evt->plen; i++)
-		c2h_evt->payload[i] = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL +
-						sizeof(*c2h_evt) + i);
+	for (i = 0; i < c2h_evt->plen; i++) {
+		error = rtw_read8(adapter, REG_C2HEVT_MSG_NORMAL + sizeof(*c2h_evt) + i,
+				  c2h_evt->payload + i);
+		if (error)
+			goto clear_evt;
+	}
 
 	ret = _SUCCESS;
 
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 5a01495d74bc..9a9df98da727 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,10 +4,10 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
+int ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 *data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read8(Adapter, RegAddr);
+	return rtw_read8(Adapter, RegAddr, data);
 }
 
 u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 3e1a45030bc8..53636c0e4786 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -21,12 +21,14 @@ static u8 _is_fw_read_cmd_down(struct adapter *adapt, u8 msgbox_num)
 {
 	u8 read_down = false;
 	int	retry_cnts = 100;
-
+	int error;
 	u8 valid;
 
 	do {
-		valid = rtw_read8(adapt, REG_HMETFR) & BIT(msgbox_num);
-		if (0 == valid)
+		error = rtw_read8(adapt, REG_HMETFR, &valid);
+		if (error)
+			return read_down;
+		else if (!(valid & BIT(msgbox_num)))
 			read_down = true;
 	} while ((!read_down) && (retry_cnts--));
 
@@ -578,8 +580,9 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	bool	bSendBeacon = false;
 	bool	bcn_valid = false;
-	u8 DLBcnCount = 0;
+	u8 DLBcnCount = 0, val8;
 	u32 poll = 0;
+	int error;
 
 	DBG_88E("%s mstatus(%x)\n", __func__, mstatus);
 
@@ -596,8 +599,15 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  Disable Hw protection for a time which revserd for Hw sending beacon. */
 		/*  Fix download reserved page packet fail that access collision with the protection time. */
 		/*  2010.05.11. Added by tynli. */
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(4));
+		error = rtw_read8(adapt, REG_BCN_CTRL, &val8);
+		if (error)
+			return;
+		rtw_write8(adapt, REG_BCN_CTRL, val8 & (~BIT(3)));
+
+		error = rtw_read8(adapt, REG_BCN_CTRL, &val8);
+		if (error)
+			return;
+		rtw_write8(adapt, REG_BCN_CTRL, val8 | BIT(4));
 
 		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
 			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
@@ -639,8 +649,15 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  */
 
 		/*  Enable Bcn */
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) | BIT(3));
-		rtw_write8(adapt, REG_BCN_CTRL, rtw_read8(adapt, REG_BCN_CTRL) & (~BIT(4)));
+		error = rtw_read8(adapt, REG_BCN_CTRL, &val8);
+		if (error)
+			return;
+		rtw_write8(adapt, REG_BCN_CTRL, val8 | BIT(3));
+
+		error = rtw_read8(adapt, REG_BCN_CTRL, &val8);
+		if (error)
+			return;
+		rtw_write8(adapt, REG_BCN_CTRL, val8 & (~BIT(4)));
 
 		/*  To make sure that if there exists an adapter which would like to send beacon. */
 		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 78552303c990..5cb3d6369449 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -16,8 +16,12 @@ static void dm_CheckStatistics(struct adapter *Adapter)
 static void dm_InitGPIOSetting(struct adapter *Adapter)
 {
 	u8	tmp1byte;
+	int error;
+
+	error = rtw_read8(Adapter, REG_GPIO_MUXCFG, &tmp1byte);
+	if (error)
+		return;
 
-	tmp1byte = rtw_read8(Adapter, REG_GPIO_MUXCFG);
 	tmp1byte &= (GPIOSEL_GPIO | ~GPIOSEL_ENBT);
 
 	rtw_write8(Adapter, REG_GPIO_MUXCFG, tmp1byte);
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 393969f51206..cfc429965b7d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -13,10 +13,14 @@
 static void iol_mode_enable(struct adapter *padapter, u8 enable)
 {
 	u8 reg_0xf0 = 0;
+	int error;
 
 	if (enable) {
 		/* Enable initial offload */
-		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
+		error = rtw_read8(padapter, REG_SYS_CFG, &reg_0xf0);
+		if (error)
+			return;
+
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
 		if (!padapter->bFWReady) {
@@ -26,7 +30,10 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 
 	} else {
 		/* disable initial offload */
-		reg_0xf0 = rtw_read8(padapter, REG_SYS_CFG);
+		error = rtw_read8(padapter, REG_SYS_CFG, &reg_0xf0);
+		if (error)
+			return;
+
 		rtw_write8(padapter, REG_SYS_CFG, reg_0xf0 & ~SW_OFFLOAD_EN);
 	}
 }
@@ -35,19 +42,28 @@ static s32 iol_execute(struct adapter *padapter, u8 control)
 {
 	s32 status = _FAIL;
 	u8 reg_0x88 = 0;
-	u32 start = 0, passing_time = 0;
+	u32 start = 0;
+	int error;
 
 	control = control & 0x0f;
-	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
+	error = rtw_read8(padapter, REG_HMEBOX_E0, &reg_0x88);
+	if (error)
+		return status;
+
 	rtw_write8(padapter, REG_HMEBOX_E0,  reg_0x88 | control);
 
 	start = jiffies;
-	while ((reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0)) & control &&
-	       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
-		;
-	}
 
-	reg_0x88 = rtw_read8(padapter, REG_HMEBOX_E0);
+	do {
+		error = rtw_read8(padapter, REG_HMEBOX_E0, &reg_0x88);
+		if (error)
+			return status;
+	} while (reg_0x88 & control && rtw_get_passing_time_ms(start) < 1000);
+
+	error = rtw_read8(padapter, REG_HMEBOX_E0, &reg_0x88);
+	if (error)
+		return status;
+
 	status = (reg_0x88 & control) ? _FAIL : _SUCCESS;
 	if (reg_0x88 & control << 4)
 		status = _FAIL;
@@ -195,17 +211,20 @@ static void efuse_read_phymap_from_txpktbuf(
 	)
 {
 	u16 dbg_addr = 0;
-	u32 start  = 0, passing_time = 0;
+	u32 start  = 0;
 	u8 reg_0x143 = 0;
 	__le32 lo32 = 0, hi32 = 0;
 	u16 len = 0, count = 0;
 	int i = 0;
 	u16 limit = *size;
-
+	int error;
 	u8 *pos = content;
 
-	if (bcnhead < 0) /* if not valid */
-		bcnhead = rtw_read8(adapter, REG_TDECTRL + 1);
+	if (bcnhead < 0) { /* if not valid */
+		error = rtw_read8(adapter, REG_TDECTRL + 1, (u8 *) &bcnhead);
+		if (error)
+			return;
+	}
 
 	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
 
@@ -218,11 +237,21 @@ static void efuse_read_phymap_from_txpktbuf(
 
 		rtw_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		start = jiffies;
-		while (!(reg_0x143 = rtw_read8(adapter, REG_TXPKTBUF_DBG)) &&
-		       (passing_time = rtw_get_passing_time_ms(start)) < 1000) {
-			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, rtw_read8(adapter, 0x106));
+
+		do {
+			u8 tmp;
+
+			error = rtw_read8(adapter, REG_TXPKTBUF_DBG, &reg_0x143);
+			if (error)
+				return;
+
+			if (!rtw_read8(adapter, 0x106, &tmp))
+				DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n",
+					__func__, reg_0x143, tmp);
+
 			rtw_usleep_os(100);
-		}
+		} while (!reg_0x143 && rtw_get_passing_time_ms(start) < 1000);
+
 
 		/* data from EEPROM needs to be in LE */
 		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
@@ -371,18 +400,28 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
+	int error;
 
 	if (enable) {
 		/*  MCU firmware download enable. */
-		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		error = rtw_read8(padapter, REG_MCUFWDL, &tmp);
+		if (error)
+			return;
+
 		rtw_write8(padapter, REG_MCUFWDL, tmp | 0x01);
 
 		/*  8051 reset */
-		tmp = rtw_read8(padapter, REG_MCUFWDL + 2);
+		error = rtw_read8(padapter, REG_MCUFWDL + 2, &tmp);
+		if (error)
+			return;
+
 		rtw_write8(padapter, REG_MCUFWDL + 2, tmp & 0xf7);
 	} else {
 		/*  MCU firmware download disable. */
-		tmp = rtw_read8(padapter, REG_MCUFWDL);
+		error = rtw_read8(padapter, REG_MCUFWDL, &tmp);
+		if (error)
+			return;
+
 		rtw_write8(padapter, REG_MCUFWDL, tmp & 0xfe);
 
 		/*  Reserved for fw extension. */
@@ -452,8 +491,14 @@ static int _PageWrite(struct adapter *padapter, u32 page, void *buffer, u32 size
 {
 	u8 value8;
 	u8 u8Page = (u8)(page & 0x07);
+	int error;
 
-	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
+	error = rtw_read8(padapter, REG_MCUFWDL + 2, &value8);
+	if (error)
+		return error;
+
+	value8 &= 0xF8;
+	value8 |= u8Page;
 	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
 
 	return _BlockWrite(padapter, buffer, size);
@@ -493,8 +538,12 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 void _8051Reset88E(struct adapter *padapter)
 {
 	u8 u1bTmp;
+	int error;
+
+	error = rtw_read8(padapter, REG_SYS_FUNC_EN + 1, &u1bTmp);
+	if (error)
+		return;
 
-	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
 	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
 	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
@@ -582,7 +631,7 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 {
 	s32	rtStatus = _SUCCESS;
-	u8 writeFW_retry = 0;
+	u8 writeFW_retry = 0, tmp;
 	u32 fwdl_start_time;
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(padapter);
 	struct dvobj_priv *dvobj = adapter_to_dvobj(padapter);
@@ -591,6 +640,7 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	u8 *pFirmwareBuf;
 	u32 FirmwareLen;
 	static int log_version;
+	int error;
 
 	if (!dvobj->firmware.szFwBuffer)
 		rtStatus = load_firmware(&dvobj->firmware, device);
@@ -621,7 +671,10 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 
 	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
 	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
-	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
+	error = rtw_read8(padapter, REG_MCUFWDL, &tmp);
+	if (error) {
+		return _FAIL;
+	} else if (tmp & RAM_DL_SEL) { /* 8051 RAM code */
 		rtw_write8(padapter, REG_MCUFWDL, 0x00);
 		_8051Reset88E(padapter);
 	}
@@ -630,7 +683,11 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	fwdl_start_time = jiffies;
 	while (1) {
 		/* reset the FWDL chksum */
-		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_ChkSum_rpt);
+		error = rtw_read8(padapter, REG_MCUFWDL, &tmp);
+		if (error)
+			return _FAIL;
+
+		rtw_write8(padapter, REG_MCUFWDL, tmp | FWDL_ChkSum_rpt);
 
 		rtStatus = _WriteFW(padapter, pFirmwareBuf, FirmwareLen);
 
@@ -715,6 +772,7 @@ hal_EfusePowerSwitch_RTL8188E(
 {
 	u8 tempval;
 	u16	tmpV16;
+	int error;
 
 	if (PwrState) {
 		rtw_write8(pAdapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
@@ -741,7 +799,10 @@ hal_EfusePowerSwitch_RTL8188E(
 
 		if (bWrite) {
 			/*  Enable LDO 2.5V before read/write action */
-			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3);
+			error = rtw_read8(pAdapter, EFUSE_TEST + 3, &tempval);
+			if (error)
+				return;
+
 			tempval &= 0x0F;
 			tempval |= (VOLTAGE_V25 << 4);
 			rtw_write8(pAdapter, EFUSE_TEST + 3, (tempval | 0x80));
@@ -751,7 +812,9 @@ hal_EfusePowerSwitch_RTL8188E(
 
 		if (bWrite) {
 			/*  Disable LDO 2.5V after read/write action */
-			tempval = rtw_read8(pAdapter, EFUSE_TEST + 3);
+			error = rtw_read8(pAdapter, EFUSE_TEST + 3, &tempval);
+			if (error)
+				return;
 			rtw_write8(pAdapter, EFUSE_TEST + 3, (tempval & 0x7F));
 		}
 	}
@@ -1784,12 +1847,19 @@ void rtl8188e_stop_thread(struct adapter *padapter)
 
 static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
+	int error;
+	u8 tmp;
+
+	error = rtw_read8(adapter, rOFDM0_RxDSP + 1, &tmp);
+	if (error)
+		return;
+
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
+		rtw_write8(adapter, rOFDM0_RxDSP + 1, tmp | BIT(1));
 	} else {
 		DBG_88E("Disable notch filter\n");
-		rtw_write8(adapter, rOFDM0_RxDSP + 1, rtw_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
+		rtw_write8(adapter, rOFDM0_RxDSP + 1, tmp & ~BIT(1));
 	}
 }
 void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 30a9dca8f453..f6d4c91a97a2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -960,6 +960,7 @@ _PHY_SetBWMode92C(
 	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
 	u8 regBwOpMode;
 	u8 regRRSR_RSC;
+	int error;
 
 	if (pHalData->rf_chip == RF_PSEUDO_11N)
 		return;
@@ -975,8 +976,13 @@ _PHY_SetBWMode92C(
 	/* 3<1>Set MAC register */
 	/* 3 */
 
-	regBwOpMode = rtw_read8(Adapter, REG_BWOPMODE);
-	regRRSR_RSC = rtw_read8(Adapter, REG_RRSR + 2);
+	error = rtw_read8(Adapter, REG_BWOPMODE, &regBwOpMode);
+	if (error)
+		return;
+
+	error = rtw_read8(Adapter, REG_RRSR + 2, &regRRSR_RSC);
+	if (error)
+		return;
 
 	switch (pHalData->CurrentChannelBW) {
 	case HT_CHANNEL_WIDTH_20:
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 16fa249e35d3..39dacfb23570 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -49,13 +49,17 @@ void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 {
 	u32 rx_dma_status = 0;
 	u8 fw_status = 0;
+	int error;
+
 	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
 	if (rx_dma_status != 0x00) {
 		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 	}
-	fw_status = rtw_read8(padapter, REG_FMETHR);
-	if (fw_status != 0x00) {
+	error = rtw_read8(padapter, REG_FMETHR, &fw_status);
+	if (error) {
+		return;
+	} else if (fw_status != 0x00) {
 		if (fw_status == 1)
 			DBG_88E("%s REG_FW_STATUS (0x%02x), Read_Efuse_Fail !!\n", __func__, fw_status);
 		else if (fw_status == 2)
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_led.c b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
index 452d4bb87aba..7f793b7ce609 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_led.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_led.c
@@ -14,10 +14,15 @@
 void SwLedOn(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
+	int error;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
-	LedCfg = rtw_read8(padapter, REG_LEDCFG2);
+
+	error = rtw_read8(padapter, REG_LEDCFG2, &LedCfg);
+	if (error)
+		return;
+
 	switch (pLed->LedPin) {
 	case LED_PIN_LED0:
 		rtw_write8(padapter, REG_LEDCFG2, (LedCfg & 0xf0) | BIT(5) | BIT(6)); /*  SW control led0 on. */
@@ -37,11 +42,14 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 {
 	u8	LedCfg;
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
+	int error;
 
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		goto exit;
 
-	LedCfg = rtw_read8(padapter, REG_LEDCFG2);/* 0x4E */
+	error = rtw_read8(padapter, REG_LEDCFG2, &LedCfg);/* 0x4E */
+	if (error)
+		return;
 
 	switch (pLed->LedPin) {
 	case LED_PIN_LED0:
@@ -49,7 +57,11 @@ void SwLedOff(struct adapter *padapter, struct LED_871x *pLed)
 			/*  Open-drain arrangement for controlling the LED) */
 			LedCfg &= 0x90; /*  Set to software control. */
 			rtw_write8(padapter, REG_LEDCFG2, (LedCfg | BIT(3)));
-			LedCfg = rtw_read8(padapter, REG_MAC_PINMUX_CFG);
+
+			error = rtw_read8(padapter, REG_MAC_PINMUX_CFG, &LedCfg);
+			if (error)
+				return;
+
 			LedCfg &= 0xFE;
 			rtw_write8(padapter, REG_MAC_PINMUX_CFG, LedCfg);
 		} else {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 5cdabf43d4fd..4f1d7f9b43c3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -120,6 +120,7 @@ static void _InitInterrupt(struct adapter *Adapter)
 	u32 imr, imr_ex;
 	u8  usb_opt;
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	int error;
 
 	/* HISR write one to clear */
 	rtw_write32(Adapter, REG_HISR_88E, 0xFFFFFFFF);
@@ -135,7 +136,9 @@ static void _InitInterrupt(struct adapter *Adapter)
 	/*  REG_USB_SPECIAL_OPTION - BIT(4) */
 	/*  0; Use interrupt endpoint to upload interrupt pkt */
 	/*  1; Use bulk endpoint to upload interrupt pkt, */
-	usb_opt = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
+	error = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION, &usb_opt);
+	if (error)
+		return;
 
 	if (!adapter_to_dvobj(Adapter)->ishighspeed)
 		usb_opt = usb_opt & (~INT_BULK_SEL);
@@ -435,8 +438,12 @@ static void _InitRxSetting(struct adapter *Adapter)
 static void _InitRetryFunction(struct adapter *Adapter)
 {
 	u8 value8;
+	int error;
+
+	error = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL, &value8);
+	if (error)
+		return;
 
-	value8 = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL);
 	value8 |= EN_AMPDU_RTY_NEW;
 	rtw_write8(Adapter, REG_FWHW_TXQ_CTRL, value8);
 
@@ -499,9 +506,15 @@ usb_AggSettingRxUpdate(
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	u8 valueDMA;
 	u8 valueUSB;
+	int error;
 
-	valueDMA = rtw_read8(Adapter, REG_TRXDMA_CTRL);
-	valueUSB = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION);
+	error = rtw_read8(Adapter, REG_TRXDMA_CTRL, &valueDMA);
+	if (error)
+		return;
+
+	error = rtw_read8(Adapter, REG_USB_SPECIAL_OPTION, &valueUSB);
+	if (error)
+		return;
 
 	switch (haldata->UsbRxAggMode) {
 	case USB_RX_AGG_DMA:
@@ -589,6 +602,7 @@ static void _InitOperationMode(struct adapter *Adapter)
 static void _InitBeaconParameters(struct adapter *Adapter)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
+	int error;
 
 	rtw_write16(Adapter, REG_BCN_CTRL, 0x1010);
 
@@ -601,11 +615,25 @@ static void _InitBeaconParameters(struct adapter *Adapter)
 	/*  beacause test chip does not contension before sending beacon. by tynli. 2009.11.03 */
 	rtw_write16(Adapter, REG_BCNTCFG, 0x660F);
 
-	haldata->RegBcnCtrlVal = rtw_read8(Adapter, REG_BCN_CTRL);
-	haldata->RegTxPause = rtw_read8(Adapter, REG_TXPAUSE);
-	haldata->RegFwHwTxQCtrl = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2);
-	haldata->RegReg542 = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2);
-	haldata->RegCR_1 = rtw_read8(Adapter, REG_CR + 1);
+	error = rtw_read8(Adapter, REG_BCN_CTRL, (u8 *) &haldata->RegBcnCtrlVal);
+	if (error)
+		return;
+
+	error = rtw_read8(Adapter, REG_TXPAUSE, &haldata->RegTxPause);
+	if (error)
+		return;
+
+	error = rtw_read8(Adapter, REG_FWHW_TXQ_CTRL + 2, &haldata->RegFwHwTxQCtrl);
+	if (error)
+		return;
+
+	error = rtw_read8(Adapter, REG_TBTT_PROHIBIT + 2, &haldata->RegReg542);
+	if (error)
+		return;
+
+	error = rtw_read8(Adapter, REG_CR + 1, &haldata->RegCR_1);
+	if (error)
+		return;
 }
 
 static void _BeaconFunctionEnable(struct adapter *Adapter,
@@ -665,14 +693,27 @@ enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 {
 	u8 val8;
 	enum rt_rf_power_state rfpowerstate = rf_off;
+	int error;
 
 	if (adapt->pwrctrlpriv.bHWPowerdown) {
-		val8 = rtw_read8(adapt, REG_HSISR);
+		error = rtw_read8(adapt, REG_HSISR, &val8);
+		if (error)
+			return rfpowerstate;
+
 		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
 	} else { /*  rf on/off */
-		rtw_write8(adapt, REG_MAC_PINMUX_CFG, rtw_read8(adapt, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
-		val8 = rtw_read8(adapt, REG_GPIO_IO_SEL);
+
+		error = rtw_read8(adapt, REG_MAC_PINMUX_CFG, &val8);
+		if (error)
+			return rfpowerstate;
+
+		rtw_write8(adapt, REG_MAC_PINMUX_CFG, val8 & ~(BIT(3)));
+
+		error = rtw_read8(adapt, REG_GPIO_IO_SEL, &val8);
+		if (error)
+			return rfpowerstate;
+
 		DBG_88E("GPIO_IN=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
 	}
@@ -689,6 +730,7 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 	u32 init_start_time = jiffies;
+	int error;
 
 	#define HAL_INIT_PROFILE_TAG(stage) do {} while (0)
 
@@ -835,7 +877,11 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
-	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
+	error = rtw_read8(Adapter, REG_TX_RPT_CTRL, &value8);
+	if (error) {
+		status = _FAIL;
+		goto exit;
+	}
 	rtw_write8(Adapter,  REG_TX_RPT_CTRL, (value8 | BIT(1) | BIT(0)));
 	/* Set MAX RPT MACID */
 	rtw_write8(Adapter,  REG_TX_RPT_CTRL + 1, 2);/* FOR sta mode ,0: bc/mc ,1:AP */
@@ -962,9 +1008,13 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 {
 	u8 val8;
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	int error;
 
 	/* Stop Tx Report Timer. 0x4EC[Bit1]=b'0 */
-	val8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
+	error = rtw_read8(Adapter, REG_TX_RPT_CTRL, &val8);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_TX_RPT_CTRL, val8 & (~BIT(1)));
 
 	/*  stop rx */
@@ -975,10 +1025,15 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/*  2. 0x1F[7:0] = 0		turn off RF */
 
-	val8 = rtw_read8(Adapter, REG_MCUFWDL);
-	if ((val8 & RAM_DL_SEL) && Adapter->bFWReady) { /* 8051 RAM code */
+	error = rtw_read8(Adapter, REG_MCUFWDL, &val8);
+	if (error) {
+		return;
+	} else if ((val8 & RAM_DL_SEL) && Adapter->bFWReady) { /* 8051 RAM code */
 		/*  Reset MCU 0x2[10]=0. */
-		val8 = rtw_read8(Adapter, REG_SYS_FUNC_EN + 1);
+		error = rtw_read8(Adapter, REG_SYS_FUNC_EN + 1, &val8);
+		if (error)
+			return;
+
 		val8 &= ~BIT(2);	/*  0x2[10], FEN_CPUEN */
 		rtw_write8(Adapter, REG_SYS_FUNC_EN + 1, val8);
 	}
@@ -988,26 +1043,43 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 
 	/* YJ,add,111212 */
 	/* Disable 32k */
-	val8 = rtw_read8(Adapter, REG_32K_CTRL);
+	error = rtw_read8(Adapter, REG_32K_CTRL, &val8);
+	if (error)
+		return;
 	rtw_write8(Adapter, REG_32K_CTRL, val8 & (~BIT(0)));
 
 	/*  Card disable power action flow */
 	HalPwrSeqCmdParsing(Adapter, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, Rtl8188E_NIC_DISABLE_FLOW);
 
 	/*  Reset MCU IO Wrapper */
-	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
+	error = rtw_read8(Adapter, REG_RSV_CTRL + 1, &val8);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_RSV_CTRL + 1, (val8 & (~BIT(3))));
-	val8 = rtw_read8(Adapter, REG_RSV_CTRL + 1);
+	error = rtw_read8(Adapter, REG_RSV_CTRL + 1, &val8);
+	if (error)
+		return;
 	rtw_write8(Adapter, REG_RSV_CTRL + 1, val8 | BIT(3));
 
 	/* YJ,test add, 111207. For Power Consumption. */
-	val8 = rtw_read8(Adapter, GPIO_IN);
+	error = rtw_read8(Adapter, GPIO_IN, &val8);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, GPIO_OUT, val8);
 	rtw_write8(Adapter, GPIO_IO_SEL, 0xFF);/* Reg0x46 */
 
-	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL);
+	error = rtw_read8(Adapter, REG_GPIO_IO_SEL, &val8);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_GPIO_IO_SEL, (val8 << 4));
-	val8 = rtw_read8(Adapter, REG_GPIO_IO_SEL + 1);
+
+	error = rtw_read8(Adapter, REG_GPIO_IO_SEL + 1, &val8);
+	if (error)
+		return;
+
 	rtw_write8(Adapter, REG_GPIO_IO_SEL + 1, val8 | 0x0F);/* Reg0x43 */
 	rtw_write32(Adapter, REG_BB_PAD_CTRL, 0x00080808);/* set LNA ,TRSW,EX_PA Pin to output mode */
 	haldata->bMacPwrCtrlOn = false;
@@ -1181,9 +1253,13 @@ static void _ReadPROMContent(
 {
 	struct eeprom_priv *eeprom = GET_EEPROM_EFUSE_PRIV(Adapter);
 	u8 eeValue;
+	int error;
 
 	/* check system boot selection */
-	eeValue = rtw_read8(Adapter, REG_9346CR);
+	error = rtw_read8(Adapter, REG_9346CR, &eeValue);
+	if (error)
+		return;
+
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
 
@@ -1262,12 +1338,21 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	u8 val8;
 	u8 mode = *((u8 *)val);
+	int error;
+
+	error = rtw_read8(Adapter, REG_BCN_CTRL, &val8);
+	if (error)
+		return;
 
 	/*  disable Port0 TSF update */
-	rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
+	rtw_write8(Adapter, REG_BCN_CTRL, val8 | BIT(4));
 
 	/*  set net_type */
-	val8 = rtw_read8(Adapter, MSR) & 0x0c;
+	error = rtw_read8(Adapter, MSR, &val8);
+	if (error)
+		return;
+
+	val8 &= 0x0c;
 	val8 |= mode;
 	rtw_write8(Adapter, MSR, val8);
 
@@ -1304,14 +1389,20 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, REG_DUAL_TSF_RST, BIT(0));
 
 		/* BIT(3) - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
-		rtw_write8(Adapter, REG_MBID_NUM, rtw_read8(Adapter, REG_MBID_NUM) | BIT(3) | BIT(4));
+		error = rtw_read8(Adapter, REG_MBID_NUM, &val8);
+		if (error)
+			return;
+		rtw_write8(Adapter, REG_MBID_NUM, val8 | BIT(3) | BIT(4));
 
 		/* enable BCN0 Function for if1 */
 		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
 		rtw_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP | EN_BCN_FUNCTION | BIT(1)));
 
 		/* dis BCN1 ATIM  WND if if2 is station */
-		rtw_write8(Adapter, REG_BCN_CTRL_1, rtw_read8(Adapter, REG_BCN_CTRL_1) | BIT(0));
+		error = rtw_read8(Adapter, REG_BCN_CTRL_1, &val8);
+		if (error)
+			return;
+		rtw_write8(Adapter, REG_BCN_CTRL_1, val8 | BIT(0));
 	}
 }
 
@@ -1345,8 +1436,16 @@ static void hw_var_set_bcn_func(struct adapter *Adapter, u8 variable, u8 *val)
 
 	if (*((u8 *)val))
 		rtw_write8(Adapter, bcn_ctrl_reg, (EN_BCN_FUNCTION | EN_TXBCN_RPT));
-	else
-		rtw_write8(Adapter, bcn_ctrl_reg, rtw_read8(Adapter, bcn_ctrl_reg) & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+	else {
+		u8 tmp;
+		int error;
+
+		error = rtw_read8(Adapter, bcn_ctrl_reg, &tmp);
+		if (error)
+			return;
+
+		rtw_write8(Adapter, bcn_ctrl_reg, tmp & (~(EN_BCN_FUNCTION | EN_TXBCN_RPT)));
+	}
 }
 
 static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
@@ -1354,13 +1453,19 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	struct dm_priv	*pdmpriv = &haldata->dmpriv;
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+	int error;
+	u8 tmp;
 
 	switch (variable) {
 	case HW_VAR_MEDIA_STATUS:
 		{
 			u8 val8;
 
-			val8 = rtw_read8(Adapter, MSR) & 0x0c;
+			error = rtw_read8(Adapter, MSR, &val8);
+			if (error)
+				return;
+
+			val8 &= 0x0c;
 			val8 |= *((u8 *)val);
 			rtw_write8(Adapter, MSR, val8);
 		}
@@ -1369,7 +1474,11 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 val8;
 
-			val8 = rtw_read8(Adapter, MSR) & 0x03;
+			error = rtw_read8(Adapter, MSR, &val8);
+			if (error)
+				return;
+
+			val8 &= 0x03;
 			val8 |= *((u8 *)val) << 2;
 			rtw_write8(Adapter, MSR, val8);
 		}
@@ -1407,7 +1516,12 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  Set RRSR rate table. */
 			rtw_write8(Adapter, REG_RRSR, BrateCfg & 0xff);
 			rtw_write8(Adapter, REG_RRSR + 1, (BrateCfg >> 8) & 0xff);
-			rtw_write8(Adapter, REG_RRSR + 2, rtw_read8(Adapter, REG_RRSR + 2) & 0xf0);
+
+			error = rtw_read8(Adapter, REG_RRSR + 2, &tmp);
+			if (error)
+				return;
+
+			rtw_write8(Adapter, REG_RRSR + 2, tmp & 0xf0);
 
 			/*  Set RTS initial rate */
 			while (BrateCfg > 0x1) {
@@ -1437,13 +1551,21 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				StopTxBeacon(Adapter);
 
 			/* disable related TSF function */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(3)));
+			error = rtw_read8(Adapter, REG_BCN_CTRL, &tmp);
+			if (error)
+				return;
+
+			rtw_write8(Adapter, REG_BCN_CTRL, tmp & (~BIT(3)));
 
 			rtw_write32(Adapter, REG_TSFTR, tsf);
 			rtw_write32(Adapter, REG_TSFTR + 4, tsf >> 32);
 
 			/* enable related TSF function */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(3));
+			error =  rtw_read8(Adapter, REG_BCN_CTRL, &tmp);
+			if (error)
+				return;
+
+			rtw_write8(Adapter, REG_BCN_CTRL, tmp | BIT(3));
 
 			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				ResumeTxBeacon(Adapter);
@@ -1471,35 +1593,48 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		rtw_write8(Adapter, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
 
 		/* disable update TSF */
-		rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
+		error = rtw_read8(Adapter, REG_BCN_CTRL, &tmp);
+		if (error)
+			return;
+
+		rtw_write8(Adapter, REG_BCN_CTRL, tmp | BIT(4));
 		break;
 	case HW_VAR_MLME_SITESURVEY:
 		if (*((u8 *)val)) { /* under sitesurvey */
 			/* config RCR to receive different BSSID & not to receive data frame */
 			u32 v = rtw_read32(Adapter, REG_RCR);
+
 			v &= ~(RCR_CBSSID_BCN);
 			rtw_write32(Adapter, REG_RCR, v);
 			/* reject all data frame */
 			rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
 
 			/* disable update TSF */
-			rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
+			error = rtw_read8(Adapter, REG_BCN_CTRL, &tmp);
+			if (error)
+				return;
+			rtw_write8(Adapter, REG_BCN_CTRL, tmp | BIT(4));
 		} else { /* sitesurvey done */
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
+			error = rtw_read8(Adapter, REG_BCN_CTRL, &tmp);
+			if (error)
+				return;
+
 			if ((is_client_associated_to_ap(Adapter)) ||
 			    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
 				/* enable to rx data frame */
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+				rtw_write8(Adapter, REG_BCN_CTRL, tmp & (~BIT(4)));
 			} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+				rtw_write8(Adapter, REG_BCN_CTRL, tmp & (~BIT(4)));
 			}
+
 			if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 			} else {
@@ -1517,6 +1652,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 RetryLimit = 0x30;
 			u8 type = *((u8 *)val);
+			u8 tmp;
 			struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
 
 			if (type == 0) { /*  prepare to join */
@@ -1541,7 +1677,11 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			} else if (type == 2) {
 				/* sta add event call back */
 				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
+				error = rtw_read8(Adapter, REG_BCN_CTRL, &tmp);
+				if (error)
+					return;
+
+				rtw_write8(Adapter, REG_BCN_CTRL, tmp & (~BIT(4)));
 
 				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
 					RetryLimit = 0x7;
@@ -1671,7 +1811,11 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_ACM_CTRL:
 		{
 			u8 acm_ctrl = *((u8 *)val);
-			u8 AcmCtrl = rtw_read8(Adapter, REG_ACMHWCTRL);
+			u8 AcmCtrl;
+
+			error = rtw_read8(Adapter, REG_ACMHWCTRL, &AcmCtrl);
+			if (error)
+				return;
 
 			if (acm_ctrl > 1)
 				AcmCtrl = AcmCtrl | 0x1;
@@ -1699,6 +1843,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			u8 MinSpacingToSet;
 			u8 SecMinSpace;
+			u8 tmp;
 
 			MinSpacingToSet = *((u8 *)val);
 			if (MinSpacingToSet <= 7) {
@@ -1719,7 +1864,13 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				}
 				if (MinSpacingToSet < SecMinSpace)
 					MinSpacingToSet = SecMinSpace;
-				rtw_write8(Adapter, REG_AMPDU_MIN_SPACE, (rtw_read8(Adapter, REG_AMPDU_MIN_SPACE) & 0xf8) | MinSpacingToSet);
+
+				error = rtw_read8(Adapter, REG_AMPDU_MIN_SPACE, &tmp);
+				if (error)
+					return;
+
+				rtw_write8(Adapter, REG_AMPDU_MIN_SPACE, (tmp & 0xf8) |
+					  MinSpacingToSet);
 			}
 		}
 		break;
@@ -1868,7 +2019,13 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
-		rtw_write8(Adapter, REG_TDECTRL + 2, rtw_read8(Adapter, REG_TDECTRL + 2) | BIT(0));
+		u8 tmp;
+
+		error = rtw_read8(Adapter, REG_TDECTRL + 2, &tmp);
+		if (error)
+			return;
+
+		rtw_write8(Adapter, REG_TDECTRL + 2, tmp | BIT(0));
 		break;
 	default:
 		break;
@@ -1880,17 +2037,23 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
+	int error;
+	u8 tmp;
 
 	switch (variable) {
 	case HW_VAR_BASIC_RATE:
 		*((u16 *)(val)) = haldata->BasicRateSet;
 		fallthrough;
 	case HW_VAR_TXPAUSE:
-		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
+		error = rtw_read8(Adapter, REG_TXPAUSE, val);
 		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
-		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
+		error = rtw_read8(Adapter, REG_TDECTRL + 2, &tmp);
+		if (error)
+			break;
+
+		val[0] = (BIT(0) & tmp) ? true : false;
 		break;
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
@@ -2035,6 +2198,7 @@ static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eV
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	u8 bResult = _SUCCESS;
+	int error;
 
 	switch (eVariable) {
 	case HAL_DEF_DBG_DM_FUNC:
@@ -2058,7 +2222,10 @@ static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eV
 			} else if (dm_func == 6) {/* turn on all dynamic func */
 				if (!(podmpriv->SupportAbility  & DYNAMIC_BB_DIG)) {
 					struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
-					pDigTable->CurIGValue = rtw_read8(Adapter, 0xc50);
+
+					error = rtw_read8(Adapter, 0xc50, &pDigTable->CurIGValue);
+					if (error)
+						return _FAIL;
 				}
 				podmpriv->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
 				DBG_88E("==> Turn on all dynamic function...\n");
@@ -2168,6 +2335,8 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	u32 bcn_ctrl_reg			= REG_BCN_CTRL;
+	int error;
+	u8 tmp;
 	/* reset TSF, enable update TSF, correcting TSF On Beacon */
 
 	/* BCN interval */
@@ -2193,7 +2362,11 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	ResumeTxBeacon(adapt);
 
-	rtw_write8(adapt, bcn_ctrl_reg, rtw_read8(adapt, bcn_ctrl_reg) | BIT(1));
+	error = rtw_read8(adapt, bcn_ctrl_reg, &tmp);
+	if (error)
+		return;
+
+	rtw_write8(adapt, bcn_ctrl_reg, tmp | BIT(1));
 }
 
 static void rtl8188eu_init_default_value(struct adapter *adapt)
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 953fa05dc30c..380d126c8b2f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -101,26 +101,29 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	return status;
 }
 
-static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
+static int usb_read8(struct intf_hdl *pintfhdl, u32 addr, u8 *data)
 {
 	u8 requesttype;
 	u16 wvalue;
 	u16 len;
-	u8 data = 0;
-
+	int res;
 
+	if (WARN_ON(unlikely(!data)))
+		return -EINVAL;
 
 	requesttype = 0x01;/* read_in */
 
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
-
-
-
-	return data;
+	res = usbctrl_vendorreq(pintfhdl, wvalue, data, len, requesttype);
+	if (res < 0)
+		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 8 bytes: %d\n", res);
+	else
+		/* Noone cares about positive return value */
+		res = 0;
 
+	return res;
 }
 
 static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 6b589413d56c..8e531d272927 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -60,7 +60,7 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-u8 ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
+int ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 *data);
 
 u16 ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
 
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f1b3074fa075..fd99b36abca6 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -85,7 +85,7 @@ struct intf_hdl;
 struct io_queue;
 
 struct _io_ops {
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
+	int (*_read8)(struct intf_hdl *pintfhdl, u32 addr, u8 *data);
 	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
 	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
 	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
@@ -248,7 +248,7 @@ void unregister_intf_hdl(struct intf_hdl *pintfhdl);
 void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr);
+int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
 u16 _rtw_read16(struct adapter *adapter, u32 addr);
 u32 _rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
@@ -270,7 +270,7 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
+#define rtw_read8(adapter, addr, data) _rtw_read8((adapter), (addr), (data))
 #define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_mem(adapter, addr, cnt, mem)				\
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index ab4a9200f079..c9f0772bcbe1 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2074,6 +2074,7 @@ static int rtw_wx_read32(struct net_device *dev,
 	u32 data32;
 	u32 bytes;
 	u8 *ptmp;
+	int error;
 
 	padapter = (struct adapter *)rtw_netdev_priv(dev);
 	p = &wrqu->data;
@@ -2093,7 +2094,10 @@ static int rtw_wx_read32(struct net_device *dev,
 
 	switch (bytes) {
 	case 1:
-		data32 = rtw_read8(padapter, addr);
+		error = rtw_read8(padapter, addr, (u8 *) &data32);
+		if (error)
+			return error;
+
 		sprintf(extra, "0x%02X", data32);
 		break;
 	case 2:
@@ -2251,6 +2255,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 	u8 path;
 	u8 offset;
 	u32 value;
+	int error;
 
 	DBG_88E("%s\n", __func__);
 
@@ -2262,7 +2267,8 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 		RegRWStruct = (struct mp_rw_reg *)pdata;
 		switch (RegRWStruct->width) {
 		case 1:
-			RegRWStruct->value = rtw_read8(padapter, RegRWStruct->offset);
+			error = rtw_read8(padapter, RegRWStruct->offset,
+					 (u8 *) &RegRWStruct->value);
 			break;
 		case 2:
 			RegRWStruct->value = rtw_read16(padapter, RegRWStruct->offset);
@@ -3964,6 +3970,8 @@ static int rtw_dbg_port(struct net_device *dev,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
+	int error;
+	u32 tmp;
 
 	pdata = (u32 *)&wrqu->data;
 
@@ -3978,7 +3986,8 @@ static int rtw_dbg_port(struct net_device *dev,
 	case 0x70:/* read_reg */
 		switch (minor_cmd) {
 		case 1:
-			DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
+			if (!rtw_read8(padapter, arg, (u8 *) &tmp))
+				DBG_88E("rtw_read8(0x%x) = 0x%02x\n", arg, (u8) tmp);
 			break;
 		case 2:
 			DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, rtw_read16(padapter, arg));
@@ -3992,7 +4001,9 @@ static int rtw_dbg_port(struct net_device *dev,
 		switch (minor_cmd) {
 		case 1:
 			rtw_write8(padapter, arg, extra_arg);
-			DBG_88E("rtw_write8(0x%x) = 0x%02x\n", arg, rtw_read8(padapter, arg));
+			if (rtw_read8(padapter, arg, (u8 *) &tmp))
+				DBG_88E("rtw_write8(0x%x) = 0x%02x\n", arg, (u8) tmp);
+
 			break;
 		case 2:
 			rtw_write16(padapter, arg, extra_arg);
@@ -4096,8 +4107,10 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
-			final = rtw_read8(padapter, reg);
-			if (start_value + write_num - 1 == final)
+			error = rtw_read8(padapter, reg, &final);
+			if (error)
+				return error;
+			else if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Success, start:%u, final:%u\n", reg, write_num, start_value, final);
 			else
 				DBG_88E("continuous IOL_CMD_WB_REG to 0x%x %u times Fail, start:%u, final:%u\n", reg, write_num, start_value, final);
@@ -4423,13 +4436,16 @@ static int rtw_dbg_port(struct net_device *dev,
 
 		case 0xfd:
 			rtw_write8(padapter, 0xc50, arg);
-			DBG_88E("wr(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
+			DBG_88E_REG8("wr(0xc50) = 0x%x\n", padapter, 0xc50);
 			rtw_write8(padapter, 0xc58, arg);
-			DBG_88E("wr(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
+			error = rtw_read8(padapter, 0xc58, (u8 *) &tmp);
+			if (error)
+				return error;
+			DBG_88E("wr(0xc58) = 0x%x\n", (u8) tmp);
 			break;
 		case 0xfe:
-			DBG_88E("rd(0xc50) = 0x%x\n", rtw_read8(padapter, 0xc50));
-			DBG_88E("rd(0xc58) = 0x%x\n", rtw_read8(padapter, 0xc58));
+			DBG_88E_REG8("rd(0xc50) = 0x%x\n", padapter, 0xc50);
+			DBG_88E_REG8("rd(0xc58) = 0x%x\n", padapter, 0xc58);
 			break;
 		case 0xff:
 			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
@@ -5326,6 +5342,8 @@ static int rtw_mp_read_reg(struct net_device *dev,
 	char data[20], tmp[20];
 	u32 addr;
 	u32 ret, i = 0, j = 0, strtout = 0;
+	u32 val32;
+	int error;
 
 	if (!input)
 		return -ENOMEM;
@@ -5361,7 +5379,10 @@ static int rtw_mp_read_reg(struct net_device *dev,
 	switch (width) {
 	case 'b':
 		/*  1 byte */
-		sprintf(extra, "%d\n",  rtw_read8(padapter, addr));
+		error = rtw_read8(padapter, addr, (u8 *) &val32);
+		if (error)
+			return error;
+		sprintf(extra, "%d\n", (u8) val32);
 		wrqu->length = strlen(extra);
 		break;
 	case 'w':
@@ -5889,6 +5910,8 @@ static int rtw_mp_arx(struct net_device *dev,
 	u32 cckok = 0, cckcrc = 0, ofdmok = 0, ofdmcrc = 0, htok = 0, htcrc = 0, OFDM_FA = 0, CCK_FA = 0;
 	char	*input = kmalloc(wrqu->length, GFP_KERNEL);
 	struct adapter *padapter = rtw_netdev_priv(dev);
+	int error = 0;
+	u8 tmp;
 
 	if (!input)
 		return -ENOMEM;
@@ -5934,13 +5957,25 @@ static int rtw_mp_arx(struct net_device *dev,
 		OFDM_FA = read_bbreg(padapter, 0xda4, 0x0000FFFF);
 		OFDM_FA = read_bbreg(padapter, 0xda4, 0xFFFF0000);
 		OFDM_FA = read_bbreg(padapter, 0xda8, 0x0000FFFF);
-		CCK_FA = (rtw_read8(padapter, 0xa5b) << 8) | (rtw_read8(padapter, 0xa5c));
+
+		error = rtw_read8(padapter, 0xa5b, &tmp);
+		if (error)
+			goto end;
+
+		CCK_FA = tmp << 8;
+
+		error = rtw_read8(padapter, 0xa5c, &tmp);
+		if (error)
+			goto end;
+
+		CCK_FA |= tmp;
 
 		sprintf(extra, "Phy Received packet OK:%d CRC error:%d FA Counter: %d", cckok + ofdmok + htok, cckcrc + ofdmcrc + htcrc, OFDM_FA + CCK_FA);
 	}
 	wrqu->length = strlen(extra) + 1;
+end:
 	kfree(input);
-	return 0;
+	return error;
 }
 
 static int rtw_mp_trx_query(struct net_device *dev,
-- 
2.32.0


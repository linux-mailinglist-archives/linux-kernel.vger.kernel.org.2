Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8B43F3FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhHVOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhHVOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 10:36:47 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA6C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:36:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y6so26427856lje.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 07:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/4TW3ZqhNbMp89J0w9AYPIb+RwTPDZ1oAOoMGx1z/8=;
        b=NqK0RKI+pc0zXUg8h+wLpsNNovkrgfrBNXESh74J4YX950c1V9d8+JfDkhcU+mNdlo
         d/Uu3rLzHYUYn4pfCRDcZsmz+a8aSrAt/k29LPUk2bKmQ+q+UdgwnThvEntaacfWudzC
         GqaH8ROdrkg1teZQfOE1Pv2Wf4DkZ1+2zexNEphezBuOscluEWfju2cYAKN5h3wfLvHA
         shL0L7x1L2bYyysFge0qMQaWhGBZkjm2MXD2+XeJwmhSB7juo86lfoargOX2LwwZYuN1
         YxU4fdLpAXGblPaafMCZeFOUssuvclU674oix7sg0QhjxP+dbtgQs47Gs1s9zMWW7dl7
         TBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/4TW3ZqhNbMp89J0w9AYPIb+RwTPDZ1oAOoMGx1z/8=;
        b=meil+nXe22w0ZOQyGXq27tBzYnKIUMYhwjQDkNK9EZKBKmorWqg7MmoPiGFb/Afwqn
         yXMTAKYUo+bydlD4l5uKuwL+4FY5bZ872gGrryS3YgcTv40guP0xcCM6BobaAMPxiPuf
         CfQHHlpQk7XFhrzsGiDx7E0WoRt0Cxh4dcIwbgjEqliRWj1BPmoNQajsDsVH5n7GPNc2
         XucODO8N9jMsrzcyeP7cFCKNgzA0mJlcf1wxO8AcOnaFfpwBUOXrruZ63MDCkyc1bmct
         oqbmb7Tm0cc8FfXUPs014VVh61HrZMwoLK0xE1ywZXxmtkC2+qo6LotQVkm7TOCA7kyr
         OalQ==
X-Gm-Message-State: AOAM532YTPLYF6HVN0+ow1wNc5GDlHygu1JyO+aZDqMCcpj+uNWBeKXI
        pIUmfQQ2vGZbZWXQbYBQfzI=
X-Google-Smtp-Source: ABdhPJyJA9w9fsq+/vffolKfl4dxIIP56S9whuX81joQ/65i8oEwxLCKLxRosRn/kuAU+mmdUO7+kw==
X-Received: by 2002:a05:651c:1603:: with SMTP id f3mr23884688ljq.485.1629642963554;
        Sun, 22 Aug 2021 07:36:03 -0700 (PDT)
Received: from localhost.localdomain ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id y11sm1208993lfh.185.2021.08.22.07.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 07:36:03 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH RFC v2 5/6] staging: r8188eu: add error handling of rtw_read32
Date:   Sun, 22 Aug 2021 17:36:01 +0300
Message-Id: <9004eb2972780455db4cba9694244a2c572abba8.1629642658.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629642658.git.paskripkin@gmail.com>
References: <cover.1629642658.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_rtw_read32 function can fail in case of usb transfer failure. But
previous function prototype wasn't designed to return an error to
caller. It can cause a lot uninit value bugs all across the driver code,
since rtw_read32() returns local stack variable to caller.

Fix it by changing the prototype of this function. Now it returns an
int: 0 on success, negative error value on failure and callers should pass
the pointer to storage location for register value.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_debug.c      |  61 +++++++--
 drivers/staging/r8188eu/core/rtw_efuse.c      |  14 ++-
 drivers/staging/r8188eu/core/rtw_io.c         |   9 +-
 drivers/staging/r8188eu/core/rtw_mp.c         |  18 ++-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   |   4 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |   5 +-
 drivers/staging/r8188eu/core/rtw_sreset.c     |   9 +-
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |   8 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |   2 +-
 drivers/staging/r8188eu/hal/odm_interface.c   |   4 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  63 ++++++++--
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  12 +-
 drivers/staging/r8188eu/hal/rtl8188e_sreset.c |  14 ++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 119 +++++++++++++++---
 drivers/staging/r8188eu/hal/usb_ops_linux.c   |  19 ++-
 .../staging/r8188eu/include/odm_interface.h   |   2 +-
 drivers/staging/r8188eu/include/rtw_io.h      |   6 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  90 ++++++++-----
 18 files changed, 354 insertions(+), 105 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index a41675e101ac..c76feb44ecfa 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -99,7 +99,12 @@ int proc_get_read_reg(char *page, char **start,
 				proc_get_read_addr, (u16) tmp);
 		break;
 	case 4:
-		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n", proc_get_read_addr, rtw_read32(padapter, proc_get_read_addr));
+		error = rtw_read32(padapter, proc_get_read_addr, &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, "rtw_read32(0x%x)=0x%x\n",
+				proc_get_read_addr, tmp);
 		break;
 	default:
 		len += snprintf(page + len, count - len, "error read length=%d\n", proc_get_read_len);
@@ -315,13 +320,20 @@ int proc_get_mac_reg_dump1(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= MAC REG =======\n");
 
 	for (i = 0x0; i < 0x300; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		error = rtw_read32(padapter, i, &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -338,13 +350,20 @@ int proc_get_mac_reg_dump2(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= MAC REG =======\n");
 	memset(page, 0, count);
 	for (i = 0x300; i < 0x600; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		error = rtw_read32(padapter, i, &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -361,13 +380,20 @@ int proc_get_mac_reg_dump3(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= MAC REG =======\n");
 
 	for (i = 0x600; i < 0x800; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		error = rtw_read32(padapter, i, &tmp);
+		if (error)
+			return error;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -384,12 +410,19 @@ int proc_get_bb_reg_dump1(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= BB REG =======\n");
 	for (i = 0x800; i < 0xB00; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		error = rtw_read32(padapter, i, &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -405,12 +438,19 @@ int proc_get_bb_reg_dump2(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= BB REG =======\n");
 	for (i = 0xB00; i < 0xE00; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		error = rtw_read32(padapter, i, &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
@@ -426,12 +466,19 @@ int proc_get_bb_reg_dump3(char *page, char **start,
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	int len = 0;
 	int i, j = 1;
+	int error;
+	u32 tmp;
 
 	len += snprintf(page + len, count - len, "\n======= BB REG =======\n");
 	for (i = 0xE00; i < 0x1000; i += 4) {
 		if (j % 4 == 1)
 			len += snprintf(page + len, count - len, "0x%02x", i);
-		len += snprintf(page + len, count - len, " 0x%08x ", rtw_read32(padapter, i));
+
+		error = rtw_read32(padapter, i, &tmp);
+		if (error)
+			return len;
+
+		len += snprintf(page + len, count - len, " 0x%08x ", tmp);
 		if ((j++) % 4 == 0)
 			len += snprintf(page + len, count - len, "\n");
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index b471f6446f78..dfe60bc6a547 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -183,9 +183,15 @@ ReadEFuseByte(
 
 	/* Check bit 32 read-ready */
 	retry = 0;
-	value32 = rtw_read32(Adapter, EFUSE_CTRL);
+	error = rtw_read32(Adapter, EFUSE_CTRL, &value32);
+	if (error)
+		return;
+
 	while (!(((value32 >> 24) & 0xff) & 0x80)  && (retry < 10000)) {
-		value32 = rtw_read32(Adapter, EFUSE_CTRL);
+		error = rtw_read32(Adapter, EFUSE_CTRL, &value32);
+		if (error)
+			return;
+
 		retry++;
 	}
 
@@ -194,7 +200,9 @@ ReadEFuseByte(
 	/*  Designer says that there shall be some delay after ready bit is set, or the */
 	/*  result will always stay on last data we read. */
 	udelay(50);
-	value32 = rtw_read32(Adapter, EFUSE_CTRL);
+	error = rtw_read32(Adapter, EFUSE_CTRL, &value32);
+	if (error)
+		return;
 
 	*pbuf = (u8)(value32 & 0xff);
 }
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index fd64893c778d..df4d8ac8aadc 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -56,18 +56,15 @@ int __must_check _rtw_read16(struct adapter *adapter, u32 addr, u16 *data)
 	return _read16(pintfhdl, addr, data);
 }
 
-u32 _rtw_read32(struct adapter *adapter, u32 addr)
+int __must_check _rtw_read32(struct adapter *adapter, u32 addr, u32 *data)
 {
-	u32 r_val;
 	struct io_priv *pio_priv = &adapter->iopriv;
 	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
+	int	(*_read32)(struct intf_hdl *pintfhdl, u32 addr, u32 *data);
 
 	_read32 = pintfhdl->io_ops._read32;
 
-	r_val = _read32(pintfhdl, addr);
-
-	return r_val;
+	return _read32(pintfhdl, addr, data);
 }
 
 int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 76f0bc399819..e990e81966af 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -765,12 +765,17 @@ static u32 GetPhyRxPktCounts(struct adapter *pAdapter, u32 selbit)
 {
 	/* selection */
 	u32 phyrx_set = 0, count = 0;
+	int error;
 
 	phyrx_set = _RXERR_RPT_SEL(selbit & 0xF);
 	rtw_write32(pAdapter, REG_RXERR_RPT, phyrx_set);
 
 	/* Read packet count */
-	count = rtw_read32(pAdapter, REG_RXERR_RPT) & RXERR_COUNTER_MASK;
+	error = rtw_read32(pAdapter, REG_RXERR_RPT, &count);
+	if (error)
+		return count;
+
+	count &= RXERR_COUNTER_MASK;
 
 	return count;
 }
@@ -803,8 +808,12 @@ u32 GetPhyRxPktCRC32Error(struct adapter *pAdapter)
 static u32 rtw_GetPSDData(struct adapter *pAdapter, u32 point)
 {
 	int psd_val;
+	int error;
+
+	error = rtw_read32(pAdapter, 0x808, &psd_val);
+	if (error)
+		return 0;
 
-	psd_val = rtw_read32(pAdapter, 0x808);
 	psd_val &= 0xFFBFFC00;
 	psd_val |= point;
 
@@ -814,7 +823,10 @@ static u32 rtw_GetPSDData(struct adapter *pAdapter, u32 point)
 
 	rtw_write32(pAdapter, 0x808, psd_val);
 	mdelay(1);
-	psd_val = rtw_read32(pAdapter, 0x8B4);
+
+	error = rtw_read32(pAdapter, 0x8B4, &psd_val);
+	if (error)
+		return 0;
 
 	psd_val &= 0x0000FFFF;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index c6f7636c2174..9eaef9c73516 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -659,7 +659,9 @@ int rtl8188eu_oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 		break;
 	default:
 		width = 4;
-		RegRWStruct->value = rtw_read32(Adapter, offset);
+		error = rtw_read32(Adapter, offset, &RegRWStruct->value);
+		if (error)
+			status = NDIS_STATUS_NOT_ACCEPTED;
 		break;
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index c3897b29121c..4335907acbc3 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -55,6 +55,7 @@ int ips_leave(struct adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	int result = _SUCCESS;
 	int keyid;
+	u32 tmp;
 
 	_enter_pwrlock(&pwrpriv->lock);
 
@@ -83,7 +84,9 @@ int ips_leave(struct adapter *padapter)
 			}
 		}
 
-		DBG_88E("==> ips_leave.....LED(0x%08x)...\n", rtw_read32(padapter, 0x4c));
+		if (!rtw_read32(padapter, 0x4c, &tmp))
+			DBG_88E("==> ips_leave.....LED(0x%08x)...\n", tmp);
+
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index 8e1bc62e74e5..ec5d070e1641 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -29,13 +29,18 @@ u8 sreset_get_wifi_status(struct adapter *padapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
-
+	int error;
 	u8 status = WIFI_STATUS_SUCCESS;
 	u32 val32 = 0;
 
 	if (psrtpriv->silent_reset_inprogress)
 		return status;
-	val32 = rtw_read32(padapter, REG_TXDMA_STATUS);
+	error = rtw_read32(padapter, REG_TXDMA_STATUS, &val32);
+	if (error) {
+		psrtpriv->Wifi_Error_Status = WIFI_MAC_TXDMA_ERROR;
+		return WIFI_MAC_TXDMA_ERROR;
+	}
+
 	if (val32 == 0xeaeaeaea) {
 		psrtpriv->Wifi_Error_Status = WIFI_IF_NOT_EXIST;
 	} else if (val32 != 0) {
diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index d873672feb27..bd4580eba0a9 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -316,19 +316,19 @@ static int odm_ARFBRefresh_8188E(struct odm_dm_struct *dm_odm, struct odm_ra_inf
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & 0x0000000d;
 		break;
 	case 12:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR0);
+		ODM_Read4Byte(dm_odm, REG_ARFR0, &MaskFromReg);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 13:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR1);
+		ODM_Read4Byte(dm_odm, REG_ARFR1, &MaskFromReg);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 14:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR2);
+		ODM_Read4Byte(dm_odm, REG_ARFR2, &MaskFromReg);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	case 15:
-		MaskFromReg = ODM_Read4Byte(dm_odm, REG_ARFR3);
+		ODM_Read4Byte(dm_odm, REG_ARFR3, &MaskFromReg);
 		pRaInfo->RAUseRate = (pRaInfo->RateMask) & MaskFromReg;
 		break;
 	default:
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 3545ad60dc00..725a18dc3979 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -667,7 +667,7 @@ static void _PHY_SaveMACRegisters(
 		if (error)
 			return;
 	}
-	MACBackup[i] = ODM_Read4Byte(dm_odm, MACReg[i]);
+	ODM_Read4Byte(dm_odm, MACReg[i], MACBackup + i);
 }
 
 static void reload_adda_reg(struct adapter *adapt, u32 *ADDAReg, u32 *ADDABackup, u32 RegiesterNum)
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 669d3e5eafb6..a47319dec231 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -16,10 +16,10 @@ int ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 *data)
 	return rtw_read16(Adapter, RegAddr, data);
 }
 
-u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr)
+int ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 *data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtw_read32(Adapter, RegAddr);
+	return rtw_read32(Adapter, RegAddr, data);
 }
 
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 94e2828c328e..69649a381727 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -254,8 +254,16 @@ static void efuse_read_phymap_from_txpktbuf(
 
 
 		/* data from EEPROM needs to be in LE */
-		lo32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L));
-		hi32 = cpu_to_le32(rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H));
+		error = rtw_read32(adapter, REG_PKTBUF_DBG_DATA_L, &lo32);
+		if (error)
+			return;
+		lo32 = cpu_to_le32(lo32);
+
+
+		error = rtw_read32(adapter, REG_PKTBUF_DBG_DATA_H, &hi32);
+		if (error)
+			return;
+		hi32 = cpu_to_le32(hi32);
 
 		if (i == 0) {
 			/* Although lenc is only used in a debug statement,
@@ -375,6 +383,8 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 	u32 addr, rstatus, loop = 0;
 	u16 data_cnts = (data_len / 8) + 1;
 	u8 *pbuf = vzalloc(data_len + 10);
+	int error;
+
 	DBG_88E("###### %s ######\n", __func__);
 
 	rtw_write8(Adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
@@ -384,12 +394,25 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 			rtw_usleep_os(2);
 			loop = 0;
 			do {
-				rstatus = (reg_140 = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL) & BIT(24));
+				error = rtw_read32(Adapter, REG_PKTBUF_DBG_CTRL, &reg_140);
+				if (error)
+					return;
+
+				reg_140 &= BIT(24);
+				rstatus = reg_140;
 				if (rstatus) {
-					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L);
+					error = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_L,
+							  &fifo_data);
+					if (error)
+						return;
+
 					memcpy(pbuf + (addr * 8), &fifo_data, 4);
 
-					fifo_data = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_H);
+					error = rtw_read32(Adapter, REG_PKTBUF_DBG_DATA_H,
+							  &fifo_data);
+					if (error)
+						return;
+
 					memcpy(pbuf + (addr * 8 + 4), &fifo_data, 4);
 				}
 				rtw_usleep_os(2);
@@ -557,10 +580,14 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 {
 	u32	counter = 0;
 	u32	value32;
+	int error;
 
 	/*  polling CheckSum report */
 	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
+		error = rtw_read32(padapter, REG_MCUFWDL, &value32);
+		if (error)
+			return _FAIL;
+
 		if (value32 & FWDL_ChkSum_rpt)
 			break;
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
@@ -571,7 +598,10 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	}
 	DBG_88E("%s: Checksum report OK! REG_MCUFWDL:0x%08x\n", __func__, value32);
 
-	value32 = rtw_read32(padapter, REG_MCUFWDL);
+	error = rtw_read32(padapter, REG_MCUFWDL, &value32);
+	if (error)
+		return _FAIL;
+
 	value32 |= MCUFWDL_RDY;
 	value32 &= ~WINTINI_RDY;
 	rtw_write32(padapter, REG_MCUFWDL, value32);
@@ -581,8 +611,10 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	/*  polling for FW ready */
 	counter = 0;
 	do {
-		value32 = rtw_read32(padapter, REG_MCUFWDL);
-		if (value32 & WINTINI_RDY) {
+		error = rtw_read32(padapter, REG_MCUFWDL, &value32);
+		if (error) {
+			return _FAIL;
+		} else if (value32 & WINTINI_RDY) {
 			DBG_88E("%s: Polling FW ready success!! REG_MCUFWDL:0x%08x\n", __func__, value32);
 			return _SUCCESS;
 		}
@@ -1765,12 +1797,16 @@ static int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8
 static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 {
 	u32				value32;
-	struct HAL_VERSION		ChipVersion;
+	struct HAL_VERSION		ChipVersion = {};
 	struct hal_data_8188e	*pHalData;
+	int error;
 
 	pHalData = GET_HAL_DATA(padapter);
 
-	value32 = rtw_read32(padapter, REG_SYS_CFG);
+	error = rtw_read32(padapter, REG_SYS_CFG, &value32);
+	if (error)
+		return ChipVersion;
+
 	ChipVersion.ICType = CHIP_8188E;
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
 
@@ -1949,12 +1985,15 @@ static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
 	s32	count = 0;
 	u32	value = _LLT_INIT_ADDR(address) | _LLT_INIT_DATA(data) | _LLT_OP(_LLT_WRITE_ACCESS);
 	u16	LLTReg = REG_LLT_INIT;
+	int error;
 
 	rtw_write32(padapter, LLTReg, value);
 
 	/* polling */
 	do {
-		value = rtw_read32(padapter, LLTReg);
+		error = rtw_read32(padapter, LLTReg, &value);
+		if (error)
+			return _FAIL;
 		if (_LLT_NO_ACTIVE == _LLT_OP_VALUE(value))
 			break;
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 3afb66195413..24b2afb62d68 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -75,8 +75,12 @@ rtl8188e_PHY_QueryBBReg(
 	)
 {
 	u32 ReturnValue = 0, OriginalValue, BitShift;
+	int error;
+
+	error = rtw_read32(Adapter, RegAddr, &OriginalValue);
+	if (error)
+		return ReturnValue;
 
-	OriginalValue = rtw_read32(Adapter, RegAddr);
 	BitShift = phy_CalculateBitShift(BitMask);
 	ReturnValue = (OriginalValue & BitMask) >> BitShift;
 	return ReturnValue;
@@ -103,9 +107,13 @@ rtl8188e_PHY_QueryBBReg(
 void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	u32 OriginalValue, BitShift;
+	int error;
 
 	if (BitMask != bMaskDWord) { /* if not "double word" write */
-		OriginalValue = rtw_read32(Adapter, RegAddr);
+		error = rtw_read32(Adapter, RegAddr, &OriginalValue);
+		if (error)
+			return;
+
 		BitShift = phy_CalculateBitShift(BitMask);
 		Data = ((OriginalValue & (~BitMask)) | (Data << BitShift));
 	}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
index 39dacfb23570..a023a0669ffd 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_sreset.c
@@ -14,14 +14,16 @@ void rtl8188e_sreset_xmit_status_check(struct adapter *padapter)
 {
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
-
+	int error;
 	unsigned long current_time;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	unsigned int diff_time;
 	u32 txdma_status;
 
-	txdma_status = rtw_read32(padapter, REG_TXDMA_STATUS);
-	if (txdma_status != 0x00) {
+	error = rtw_read32(padapter, REG_TXDMA_STATUS, &txdma_status);
+	if (error) {
+		return;
+	} else if (txdma_status != 0x00) {
 		DBG_88E("%s REG_TXDMA_STATUS:0x%08x\n", __func__, txdma_status);
 		rtw_write32(padapter, REG_TXDMA_STATUS, txdma_status);
 		rtl8188e_silentreset_for_specific_platform(padapter);
@@ -51,8 +53,10 @@ void rtl8188e_sreset_linked_status_check(struct adapter *padapter)
 	u8 fw_status = 0;
 	int error;
 
-	rx_dma_status = rtw_read32(padapter, REG_RXDMA_STATUS);
-	if (rx_dma_status != 0x00) {
+	error = rtw_read32(padapter, REG_RXDMA_STATUS, &rx_dma_status);
+	if (error) {
+		return;
+	} else if (rx_dma_status != 0x00) {
 		DBG_88E("%s REG_RXDMA_STATUS:0x%08x\n", __func__, rx_dma_status);
 		rtw_write32(padapter, REG_RXDMA_STATUS, rx_dma_status);
 	}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4ecccc6499aa..3826476e3396 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -338,8 +338,12 @@ static void _InitQueuePriority(struct adapter *Adapter)
 static void _InitNetworkType(struct adapter *Adapter)
 {
 	u32 value32;
+	int error;
+
+	error = rtw_read32(Adapter, REG_CR, &value32);
+	if (error)
+		return;
 
-	value32 = rtw_read32(Adapter, REG_CR);
 	/*  TODO: use the other function to set network type */
 	value32 = (value32 & ~MASK_NETTYPE) | _NETTYPE(NT_LINK_AP);
 
@@ -381,9 +385,13 @@ static void _InitAdaptiveCtrl(struct adapter *Adapter)
 {
 	u16 value16;
 	u32 value32;
+	int error;
 
 	/*  Response Rate Set */
-	value32 = rtw_read32(Adapter, REG_RRSR);
+	error = rtw_read32(Adapter, REG_RRSR, &value32);
+	if (error)
+		return;
+
 	value32 &= ~RATE_BITMAP_ALL;
 	value32 |= RATE_RRSR_CCK_ONLY_1M;
 	rtw_write32(Adapter, REG_RRSR, value32);
@@ -482,12 +490,16 @@ static void usb_AggSettingTxUpdate(struct adapter *Adapter)
 {
 	struct hal_data_8188e	*haldata = GET_HAL_DATA(Adapter);
 	u32 value32;
+	int error;
 
 	if (Adapter->registrypriv.wifi_spec)
 		haldata->UsbTxAggMode = false;
 
 	if (haldata->UsbTxAggMode) {
-		value32 = rtw_read32(Adapter, REG_TDECTRL);
+		error = rtw_read32(Adapter, REG_TDECTRL, &value32);
+		if (error)
+			return;
+
 		value32 = value32 & ~(BLK_DESC_NUM_MASK << BLK_DESC_NUM_SHIFT);
 		value32 |= ((haldata->UsbTxAggDescNum & BLK_DESC_NUM_MASK) << BLK_DESC_NUM_SHIFT);
 
@@ -671,12 +683,18 @@ enum {
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e	*haldata	= GET_HAL_DATA(Adapter);
+	u32 val32;
+	int error;
 
 	if (haldata->AntDivCfg == 0)
 		return;
 	DBG_88E("==>  %s ....\n", __func__);
 
-	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
+	error = rtw_read32(Adapter, REG_LEDCFG0, &val32);
+	if (error)
+		return;
+
+	rtw_write32(Adapter, REG_LEDCFG0, val32 | BIT(23));
 	PHY_SetBBReg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
 
 	if (PHY_QueryBBReg(Adapter, rFPGA0_XA_RFInterfaceOE, 0x300) == Antenna_A)
@@ -737,7 +755,7 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	u8 value8 = 0;
 	u16  value16;
 	u8 txpktbuf_bndy;
-	u32 status = _SUCCESS;
+	u32 status = _SUCCESS, val32;
 	struct hal_data_8188e		*haldata = GET_HAL_DATA(Adapter);
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
@@ -1007,7 +1025,13 @@ static u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	rtw_write8(Adapter, REG_USB_HRPWM, 0);
 
 	/* ack for xmit mgmt frames. */
-	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, rtw_read32(Adapter, REG_FWHW_TXQ_CTRL) | BIT(12));
+	error = rtw_read32(Adapter, REG_FWHW_TXQ_CTRL, &val32);
+	if (error) {
+		status = _FAIL;
+		goto exit;
+	}
+
+	rtw_write32(Adapter, REG_FWHW_TXQ_CTRL, val32 | BIT(12));
 
 exit:
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
@@ -1480,6 +1504,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 	int error;
 	u8 tmp;
+	u32 val32;
 
 	switch (variable) {
 	case HW_VAR_MEDIA_STATUS:
@@ -1598,11 +1623,17 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_CHECK_BSSID:
 		if (*((u8 *)val)) {
-			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+			error = rtw_read32(Adapter, REG_RCR, &val32);
+			if (error)
+				return;
+
+			rtw_write32(Adapter, REG_RCR, val32 | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 		} else {
 			u32 val32;
 
-			val32 = rtw_read32(Adapter, REG_RCR);
+			error = rtw_read32(Adapter, REG_RCR, &val32);
+			if (error)
+				return;
 
 			val32 &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 
@@ -1627,7 +1658,11 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_MLME_SITESURVEY:
 		if (*((u8 *)val)) { /* under sitesurvey */
 			/* config RCR to receive different BSSID & not to receive data frame */
-			u32 v = rtw_read32(Adapter, REG_RCR);
+			u32 v;
+
+			error = rtw_read32(Adapter, REG_RCR, &v);
+			if (error)
+				return;
 
 			v &= ~(RCR_CBSSID_BCN);
 			rtw_write32(Adapter, REG_RCR, v);
@@ -1661,14 +1696,27 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 
 			if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
+				error = rtw_read32(Adapter, REG_RCR, &val32);
+				if (error)
+					return;
+
+				rtw_write32(Adapter, REG_RCR, val32 | RCR_CBSSID_BCN);
 			} else {
+				u32 v;
+
 				if (Adapter->in_cta_test) {
-					u32 v = rtw_read32(Adapter, REG_RCR);
+					error = rtw_read32(Adapter, REG_RCR, &v);
+					if (error)
+						return;
+
 					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 					rtw_write32(Adapter, REG_RCR, v);
 				} else {
-					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
+					error = rtw_read32(Adapter, REG_RCR, &v);
+					if (error)
+						return;
+
+					rtw_write32(Adapter, REG_RCR, v | RCR_CBSSID_BCN);
 				}
 			}
 		}
@@ -1679,17 +1727,26 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			u8 type = *((u8 *)val);
 			u8 tmp;
 			struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
+			u32 v;
 
 			if (type == 0) { /*  prepare to join */
 				/* enable to rx data frame.Accept all data frame */
 				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
 
 				if (Adapter->in_cta_test) {
-					u32 v = rtw_read32(Adapter, REG_RCR);
+					error = rtw_read32(Adapter, REG_RCR, &v);
+					if (error)
+						return;
+
 					v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 					rtw_write32(Adapter, REG_RCR, v);
 				} else {
-					rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+					error = rtw_read32(Adapter, REG_RCR, &v);
+					if (error)
+						return;
+
+					rtw_write32(Adapter, REG_RCR,
+						    v | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
 				}
 
 				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
@@ -2002,6 +2059,7 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		{
 			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
 			u8 trycnt = 100;
+			u32 v;
 
 			/* pause tx */
 			rtw_write8(Adapter, REG_TXPAUSE, 0xff);
@@ -2013,9 +2071,18 @@ static void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 			if (!pwrpriv->bkeepfwalive) {
 				/* RX DMA stop */
-				rtw_write32(Adapter, REG_RXPKT_NUM, (rtw_read32(Adapter, REG_RXPKT_NUM) | RW_RELEASE_EN));
+
+				error = rtw_read32(Adapter, REG_RXPKT_NUM, &v);
+				if (error)
+					return;
+
+				rtw_write32(Adapter, REG_RXPKT_NUM, (v | RW_RELEASE_EN));
 				do {
-					if (!(rtw_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
+					error = rtw_read32(Adapter, REG_RXPKT_NUM, &v);
+					if (error)
+						return;
+
+					if (!(v & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
 				if (trycnt == 0)
@@ -2066,6 +2133,7 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 	int error;
 	u8 tmp;
+	u32 val32;
 
 	switch (variable) {
 	case HW_VAR_BASIC_RATE:
@@ -2097,7 +2165,13 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				val[0] = true;
 			} else {
 				u32 valRCR;
-				valRCR = rtw_read32(Adapter, REG_RCR);
+
+				error = rtw_read32(Adapter, REG_RCR, &valRCR);
+				if (error) {
+					*val = false;
+					return;
+				}
+
 				valRCR &= 0x00070000;
 				if (valRCR)
 					val[0] = false;
@@ -2116,7 +2190,11 @@ static void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		*val = haldata->bMacPwrCtrlOn;
 		break;
 	case HW_VAR_CHK_HI_QUEUE_EMPTY:
-		*val = ((rtw_read32(Adapter, REG_HGQ_INFORMATION) & 0x0000ff00) == 0) ? true : false;
+		error = rtw_read32(Adapter, REG_HGQ_INFORMATION, &val32);
+		if (error || val32 & 0x0000ff00)
+			*val = false;
+		else
+			*val = true;
 		break;
 	default:
 		break;
@@ -2374,7 +2452,10 @@ static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	rtw_write8(adapt, REG_SLOT, 0x09);
 
-	value32 = rtw_read32(adapt, REG_TCR);
+	error = rtw_read32(adapt, REG_TCR, &value32);
+	if (error)
+		return;
+
 	value32 &= ~TSFRST;
 	rtw_write32(adapt,  REG_TCR, value32);
 
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 58e852555f54..bcb589777b51 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -152,21 +152,32 @@ static int usb_read16(struct intf_hdl *pintfhdl, u32 addr, u16 *data)
 	return res;
 }
 
-static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+static int usb_read32(struct intf_hdl *pintfhdl, u32 addr, u32 *data)
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
 	len = 4;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	res = usbctrl_vendorreq(pintfhdl, wvalue, &data, len, requesttype);
+	if (res < 0) {
+		dev_err(dvobj_to_dev(pintfhdl->pintf_dev), "Failed to read 32 bytes: %d\n", res);
+	} else {
+		/* Noone cares about positive return value */
+		*data = le32_to_cpu(tmp);
+		res = 0;
+	}
 
-	return le32_to_cpu(data);
+	return res;
 }
 
 static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 2455dae6eebb..bbb1045c9e7d 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -64,7 +64,7 @@ int ODM_Read1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 *data);
 
 int ODM_Read2Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u16 *data);
 
-u32 ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr);
+int ODM_Read4Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 *data);
 
 void ODM_Write1Byte(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u8 Data);
 
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index c44554c848cf..501168457518 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -87,7 +87,7 @@ struct io_queue;
 struct _io_ops {
 	int (*_read8)(struct intf_hdl *pintfhdl, u32 addr, u8 *data);
 	int (*_read16)(struct intf_hdl *pintfhdl, u32 addr, u16 *data);
-	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
+	int (*_read32)(struct intf_hdl *pintfhdl, u32 addr, u32 *data);
 	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
 	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
 	int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
@@ -250,7 +250,7 @@ void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 int __must_check _rtw_read8(struct adapter *adapter, u32 addr, u8 *data);
 int __must_check _rtw_read16(struct adapter *adapter, u32 addr, u16 *data);
-u32 _rtw_read32(struct adapter *adapter, u32 addr);
+int __must_check _rtw_read32(struct adapter *adapter, u32 addr, u32 *data);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
@@ -272,7 +272,7 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 
 #define rtw_read8(adapter, addr, data) _rtw_read8((adapter), (addr), (data))
 #define rtw_read16(adapter, addr, data) _rtw_read16((adapter), (addr), (data))
-#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
+#define rtw_read32(adapter, addr, data) _rtw_read32((adapter), (addr), (data))
 #define rtw_read_mem(adapter, addr, cnt, mem)				\
 	_rtw_read_mem((adapter), (addr), (cnt), (mem))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 79f0fbaa841e..65b240d6c544 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -2108,7 +2108,10 @@ static int rtw_wx_read32(struct net_device *dev,
 		sprintf(extra, "0x%04X", data32);
 		break;
 	case 4:
-		data32 = rtw_read32(padapter, addr);
+		error = rtw_read32(padapter, addr, &data32);
+		if (error)
+			return error;
+
 		sprintf(extra, "0x%08X", data32);
 		break;
 	default:
@@ -2278,7 +2281,7 @@ static void rtw_dbg_mode_hdl(struct adapter *padapter, u32 id, u8 *pdata, u32 le
 					  (u16 *) &RegRWStruct->value);
 			break;
 		case 4:
-			RegRWStruct->value = rtw_read32(padapter, RegRWStruct->offset);
+			error = rtw_read32(padapter, RegRWStruct->offset, &RegRWStruct->value);
 			break;
 		default:
 			break;
@@ -3818,6 +3821,8 @@ static int rtw_cta_test_start(struct net_device *dev,
 {
 	int ret = 0;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
+	int error;
+
 	DBG_88E("%s %s\n", __func__, extra);
 	if (!strcmp(extra, "1"))
 		padapter->in_cta_test = 1;
@@ -3825,12 +3830,22 @@ static int rtw_cta_test_start(struct net_device *dev,
 		padapter->in_cta_test = 0;
 
 	if (padapter->in_cta_test) {
-		u32 v = rtw_read32(padapter, REG_RCR);
+		u32 v;
+
+		error = rtw_read32(padapter, REG_RCR, &v);
+		if (error)
+			return error;
+
 		v &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);/*  RCR_ADF */
 		rtw_write32(padapter, REG_RCR, v);
 		DBG_88E("enable RCR_ADF\n");
 	} else {
-		u32 v = rtw_read32(padapter, REG_RCR);
+		u32 v;
+
+		error = rtw_read32(padapter, REG_RCR, &v);
+		if (error)
+			return error;
+
 		v |= RCR_CBSSID_DATA | RCR_CBSSID_BCN;/*  RCR_ADF */
 		rtw_write32(padapter, REG_RCR, v);
 		DBG_88E("disable RCR_ADF\n");
@@ -3900,18 +3915,23 @@ static int rtw_rereg_nd_name(struct net_device *dev,
 static void mac_reg_dump(struct adapter *padapter)
 {
 	int i, j = 1;
+
 	pr_info("\n ======= MAC REG =======\n");
 	for (i = 0x0; i < 0x300; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+
+		DBG_88E_REG32(" 0x%08x ", padapter, i);
+
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
 	for (i = 0x400; i < 0x800; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+
+		DBG_88E_REG32(" 0x%08x ", padapter, i);
+
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
@@ -3920,12 +3940,14 @@ static void mac_reg_dump(struct adapter *padapter)
 static void bb_reg_dump(struct adapter *padapter)
 {
 	int i, j = 1;
+
 	pr_info("\n ======= BB REG =======\n");
 	for (i = 0x800; i < 0x1000; i += 4) {
 		if (j % 4 == 1)
 			pr_info("0x%02x", i);
 
-		pr_info(" 0x%08x ", rtw_read32(padapter, i));
+		DBG_88E_REG32(" 0x%08x ", padapter, i);
+
 		if ((j++) % 4 == 0)
 			pr_info("\n");
 	}
@@ -3998,7 +4020,8 @@ static int rtw_dbg_port(struct net_device *dev,
 				DBG_88E("rtw_read16(0x%x) = 0x%04x\n", arg, (u16) tmp);
 			break;
 		case 4:
-			DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
+			if (!rtw_read32(padapter, arg, &val32))
+				DBG_88E("rtw_read32(0x%x) = 0x%08x\n", arg, val32);
 			break;
 		}
 		break;
@@ -4020,7 +4043,9 @@ static int rtw_dbg_port(struct net_device *dev,
 			break;
 		case 4:
 			rtw_write32(padapter, arg, extra_arg);
-			DBG_88E("rtw_write32(0x%x) = 0x%08x\n", arg, rtw_read32(padapter, arg));
+
+			if (!rtw_read32(padapter, arg, &val32))
+				DBG_88E("rtw_write32(0x%x) = 0x%08x\n", arg, val32);
 			break;
 		}
 		break;
@@ -4178,7 +4203,10 @@ static int rtw_dbg_port(struct net_device *dev,
 			if (_SUCCESS != rtw_IOL_exec_cmds_sync(padapter, xmit_frame, 5000, 0))
 				ret = -EPERM;
 
-			final = rtw_read32(padapter, reg);
+			error = rtw_read32(padapter, reg, &final);
+			if (error)
+				break;
+
 			if (start_value + write_num - 1 == final)
 				DBG_88E("continuous IOL_CMD_WD_REG to 0x%x %u times Success, start:%u, final:%u\n",
 					reg, write_num, start_value, final);
@@ -4460,30 +4488,30 @@ static int rtw_dbg_port(struct net_device *dev,
 			DBG_88E_REG8("rd(0xc58) = 0x%x\n", padapter, 0xc58);
 			break;
 		case 0xff:
-			DBG_88E("dbg(0x210) = 0x%x\n", rtw_read32(padapter, 0x210));
-			DBG_88E("dbg(0x608) = 0x%x\n", rtw_read32(padapter, 0x608));
-			DBG_88E("dbg(0x280) = 0x%x\n", rtw_read32(padapter, 0x280));
-			DBG_88E("dbg(0x284) = 0x%x\n", rtw_read32(padapter, 0x284));
-			DBG_88E("dbg(0x288) = 0x%x\n", rtw_read32(padapter, 0x288));
+			DBG_88E_REG32("dbg(0x210) = 0x%x\n", padapter, 0x210);
+			DBG_88E_REG32("dbg(0x608) = 0x%x\n", padapter, 0x608);
+			DBG_88E_REG32("dbg(0x280) = 0x%x\n", padapter, 0x280);
+			DBG_88E_REG32("dbg(0x284) = 0x%x\n", padapter, 0x284);
+			DBG_88E_REG32("dbg(0x288) = 0x%x\n", padapter, 0x288);
 
-			DBG_88E("dbg(0x664) = 0x%x\n", rtw_read32(padapter, 0x664));
+			DBG_88E_REG32("dbg(0x664) = 0x%x\n", padapter, 0x664);
 
 			DBG_88E("\n");
 
-			DBG_88E("dbg(0x430) = 0x%x\n", rtw_read32(padapter, 0x430));
-			DBG_88E("dbg(0x438) = 0x%x\n", rtw_read32(padapter, 0x438));
+			DBG_88E_REG32("dbg(0x430) = 0x%x\n", padapter, 0x430);
+			DBG_88E_REG32("dbg(0x438) = 0x%x\n", padapter, 0x438);
 
-			DBG_88E("dbg(0x440) = 0x%x\n", rtw_read32(padapter, 0x440));
+			DBG_88E_REG32("dbg(0x440) = 0x%x\n", padapter, 0x440);
 
-			DBG_88E("dbg(0x458) = 0x%x\n", rtw_read32(padapter, 0x458));
+			DBG_88E_REG32("dbg(0x458) = 0x%x\n", padapter, 0x458);
 
-			DBG_88E("dbg(0x484) = 0x%x\n", rtw_read32(padapter, 0x484));
-			DBG_88E("dbg(0x488) = 0x%x\n", rtw_read32(padapter, 0x488));
+			DBG_88E_REG32("dbg(0x484) = 0x%x\n", padapter, 0x484);
+			DBG_88E_REG32("dbg(0x488) = 0x%x\n", padapter, 0x488);
 
-			DBG_88E("dbg(0x444) = 0x%x\n", rtw_read32(padapter, 0x444));
-			DBG_88E("dbg(0x448) = 0x%x\n", rtw_read32(padapter, 0x448));
-			DBG_88E("dbg(0x44c) = 0x%x\n", rtw_read32(padapter, 0x44c));
-			DBG_88E("dbg(0x450) = 0x%x\n", rtw_read32(padapter, 0x450));
+			DBG_88E_REG32("dbg(0x444) = 0x%x\n", padapter, 0x444);
+			DBG_88E_REG32("dbg(0x448) = 0x%x\n", padapter, 0x448);
+			DBG_88E_REG32("dbg(0x44c) = 0x%x\n", padapter, 0x44c);
+			DBG_88E_REG32("dbg(0x450) = 0x%x\n", padapter, 0x450);
 			break;
 		}
 		break;
@@ -5434,7 +5462,11 @@ static int rtw_mp_read_reg(struct net_device *dev,
 		break;
 	case 'd':
 		/*  4 bytes */
-		sprintf(data, "%08x", rtw_read32(padapter, addr));
+		error = rtw_read32(padapter, addr, &val32);
+		if (error)
+			return error;
+
+		sprintf(data, "%08x", val32);
 		/* add read data format blank */
 		for (i = 0; i <= strlen(data); i++) {
 			if (i % 2 == 0) {
@@ -6154,14 +6186,14 @@ static int rtw_mp_dump(struct net_device *dev,
 		for (i = 0x0; i < 0x300; i += 4) {
 			if (j % 4 == 1)
 				DBG_88E("0x%02x", i);
-			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
+			DBG_88E_REG32(" 0x%08x ", padapter, i);
 			if ((j++) % 4 == 0)
 				DBG_88E("\n");
 		}
 		for (i = 0x400; i < 0x1000; i += 4) {
 			if (j % 4 == 1)
 				DBG_88E("0x%02x", i);
-			DBG_88E(" 0x%08x ", rtw_read32(padapter, i));
+			DBG_88E_REG32(" 0x%08x ", padapter, i);
 			if ((j++) % 4 == 0)
 				DBG_88E("\n");
 		}
-- 
2.32.0


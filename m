Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B0D3545A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhDEQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhDEQuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E45AC061788
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a12so1669833wrq.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=El+h1g7J56Ymv1kQGVvoZkaOuZsbdf2IWCZLaLKfDPE=;
        b=Rgwy/YLxvlXc61Uk7LuChba8qFwyQe24EWQRBrFRNncJHYTQ+kvGv11TOxSrdTO4VA
         YnmF9RHV5LNhvYoGgwj/BZNUwZRngYCnQ+V64c5oGToWIcJgmujivexv7h3Htez8MTN7
         ZBjjQWr1pdYnSMzUP1OkAfc7vLnq0LrxB3uHZFbXWw6yLvuSmhVyELHiRTGtMole7yMR
         j4N03F5Pna73CUwPa+ZttOuIc918OrMzR3dyfBp8wy8Rv3LKcET2c5AOp6Pk8PgKWJWI
         7G/i65nlndgzQZ6acxGIotPa2zHrDgElq6uhCBpQAgOiGmZ2Ym029a+OvnfQlpZk/1G8
         s0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=El+h1g7J56Ymv1kQGVvoZkaOuZsbdf2IWCZLaLKfDPE=;
        b=T4mXp2lfcZ9rOMDkEA33zzL5AiWS4ONH9IQkBm9DPIx+tl08RYfim0FU4FOfKKEdrw
         /dCvy8Y3XRZCp0vlYNV/JJ+wJSQzBnDWfnVu1JZH8q1EkxcTixtzeQlSyJtz1gLFOj7y
         erhMIDuUcpUu/w6QsslU8UW3W91ZQCLCo8cR0UyZ0s9vrV1Ipv10FrpCGgandqCu4gh5
         z1VZYme8Vnbzi+e1exNB8AQ4WrgW84IDWoUvIUTmZPkqQ80mJz2ybbeh8ZZVC4NAAQJr
         qphyAywocU6VCN+nIzAq4ESqm2WvWJKQf6DxyntW4Jx8+961uPujeUavm1YbFrStrqu4
         S3JQ==
X-Gm-Message-State: AOAM530jR3pljndmr2FuuUoV9sF7/iwUCiNV7Ss2QIEPVNUoc1dxtJie
        ZpYDgFNcwH2E3VP9CjvrODY=
X-Google-Smtp-Source: ABdhPJyfosisWAFnoJ1iBMR4TmF+VFClWO0hqq+W2jwlkIQSZjYSqaJmJbCIfO6wVx6CvVXyyfW3xg==
X-Received: by 2002:adf:e7d2:: with SMTP id e18mr4324754wrn.396.1617641415014;
        Mon, 05 Apr 2021 09:50:15 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id 89sm22763873wrp.9.2021.04.05.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 02/10] staging: rtl8723bs: remove commented out RT_TRACE logs in hal/ and os_dep/
Date:   Mon,  5 Apr 2021 18:49:49 +0200
Message-Id: <85338f2b2cffb530efbd987064d146fc2be49c72.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all commented out TR_TRACE calls.

Remove all of the RT_TRACE logs in hal/ and os_dep/ file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 3 ---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c    | 1 -
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 8 --------
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c   | 2 --
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 6 ------
 5 files changed, 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 12f0e3601531..c36513812d9d 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1847,7 +1847,6 @@ void PHY_IQCalibrate_8723B(
 				bResult = FAIL;
 				break;
 			}
-			/* RT_TRACE(_module_mp_, _drv_notice_, ("Switch to S1 TxIQC(offset, data) = (0x%X, 0x%X)\n", offset, data)); */
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
@@ -1864,7 +1863,6 @@ void PHY_IQCalibrate_8723B(
 				bResult = FAIL;
 				break;
 			}
-			/* RT_TRACE(_module_mp_, _drv_notice_, ("Switch to S1 RxIQC (offset, data) = (0x%X, 0x%X)\n", offset, data)); */
 			PHY_SetBBReg(pDM_Odm->Adapter, offset, bMaskDWord, data);
 		}
 
@@ -1950,7 +1948,6 @@ void PHY_IQCalibrate_8723B(
 			}
 		}
 	}
-/* 	RT_TRACE(COMP_INIT, DBG_LOUD, ("Release Mutex in IQCalibrate\n")); */
 
 	for (i = 0; i < 4; i++) {
 		RegE94 = result[i][0];
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 9b16265b543d..f52cc4e7a6e6 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1785,7 +1785,6 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	/*
 	if (band_type == BAND_ON_5G && pwr_lmt == MAX_POWER_INDEX) {
 		if (idx_bandwidth == 0 || idx_bandwidth == 1) {
-			RT_TRACE(COMP_INIT, DBG_LOUD, ("No power limit table of the specified band %d, bandwidth %d, ratesection %d, rf path %d\n",
 				 idx_band, idx_bandwidth,
 				 idx_rate_sctn, rf_path));
 			if (idx_rate_sctn == 2)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index b90b225d9589..39fb659bc06f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2583,7 +2583,6 @@ void Hal_EfuseParseEEPROMVer_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail)
 		pHalData->EEPROMVersion = hwinfo[EEPROM_VERSION_8723B];
 	else
@@ -2662,7 +2661,6 @@ void Hal_EfuseParseCustomerID_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail)
 		pHalData->EEPROMCustomerID = hwinfo[EEPROM_CustomID_8723B];
 	else
@@ -2683,7 +2681,6 @@ void Hal_EfuseParseXtal_8723B(
 {
 	struct hal_com_data	*pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	if (!AutoLoadFail) {
 		pHalData->CrystalCap = hwinfo[EEPROM_XTAL_8723B];
 		if (pHalData->CrystalCap == 0xFF)
@@ -2699,7 +2696,6 @@ void Hal_EfuseParseThermalMeter_8723B(
 {
 	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-/* 	RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("%s(): AutoLoadFail = %d\n", __func__, AutoLoadFail)); */
 	/*  */
 	/*  ThermalMeter from EEPROM */
 	/*  */
@@ -3001,8 +2997,6 @@ static void rtl8723b_fill_default_txdesc(
 
 		ptxdesc->usb_txagg_num = pxmitframe->agg_num;
 	} else if (pxmitframe->frame_tag == MGNT_FRAMETAG) {
-/* 		RT_TRACE(_module_hal_xmit_c_, _drv_notice_, ("%s: MGNT_FRAMETAG\n", __func__)); */
-
 		ptxdesc->macid = pattrib->mac_id; /*  CAM_ID(MAC_ID) */
 		ptxdesc->qsel = pattrib->qsel;
 		ptxdesc->rate_id = pattrib->raid; /*  Rate ID */
@@ -3776,9 +3770,7 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 				ulCommand = ulCommand | CAM_POLLINIG | CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
 				rtw_write32(padapter, WCAMI, ulContent);  /* mdelay(40); */
-				/* RT_TRACE(COMP_SEC, DBG_LOUD, ("CAM_empty_entry(): WRITE A4: %lx\n", ulContent)); */
 				rtw_write32(padapter, RWCAM, ulCommand);  /* mdelay(40); */
-				/* RT_TRACE(COMP_SEC, DBG_LOUD, ("CAM_empty_entry(): WRITE A0: %lx\n", ulCommand)); */
 			}
 		}
 		break;
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index 73b47f053549..38228b46b1ee 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -74,7 +74,6 @@ void PHY_RF6052SetBandwidth8723B(
 		break;
 
 	default:
-		/* RT_TRACE(COMP_DBG, DBG_LOUD, ("PHY_SetRF8225Bandwidth(): unknown Bandwidth: %#X\n", Bandwidth)); */
 		break;
 	}
 
@@ -153,7 +152,6 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 
 	ODM_ConfigRFWithTxPwrTrackHeaderFile(&pHalData->odmpriv);
 
-	/* RT_TRACE(COMP_INIT, DBG_LOUD, ("<---phy_RF6052_Config_ParaFile()\n")); */
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index cf8e783dc35c..5b3976216d71 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -4178,7 +4178,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct iw_point *dwrq = (struct iw_point *)awrq;
 
-	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, ("+rtw_wx_set_priv\n")); */
 	if (dwrq->length == 0)
 		return -EFAULT;
 
@@ -4192,11 +4191,6 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		return -EFAULT;
 	}
 
-
-	/* RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_notice_, */
-	/* 	 ("rtw_wx_set_priv: %s req =%s\n", */
-	/* 	  dev->name, ext)); */
-
 	#ifdef DEBUG_RTW_WX_SET_PRIV
 	ext_dbg = vmalloc(len);
 	if (!ext_dbg) {
-- 
2.20.1


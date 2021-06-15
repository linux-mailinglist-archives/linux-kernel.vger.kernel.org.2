Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD03A72EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbhFOAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:20:14 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]:45941 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhFOAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:20:01 -0400
Received: by mail-qv1-f51.google.com with SMTP id g12so21409023qvx.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwOELmtLxu68pFbUKJxhyd0VbB5JTvE3+073VOmdQck=;
        b=CH64OQ5e85iDdQUl9b8JX4Jiu7J/XvwtxlNb6XOgjgYTjZ+Teg+E/GmNCA9XWW84Dg
         +LbGZE7Grle+PRkx4yuzFyBrnv3nEik4vF0+ti+dJrC7456tmI5DvDIzo6T1l/ebrdPu
         FQryJHWDoOLrK9x1Qvo6jtrL2F9A8yb53CrEsqqHgn9Y0Es7zwfcQ+odKaRJCDONM6GK
         0kD45FaZk1FnxEi90KDTUXD5qJF7w6s09HylT6kymJ91XiOKdN4/zB0EsnfB/U4AgcSK
         a6okG4GwntURx37EEdjLotuPKxlTtpBHOXW6GkWpb3bhn2H3urYRuXpazw0lZ06mBocR
         D+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwOELmtLxu68pFbUKJxhyd0VbB5JTvE3+073VOmdQck=;
        b=YuF6Ql2/f7UcshrwZIsZ1wC3IFRqT4y8KF4hFDf584XbTwq6XtJb/OJlXltYD7asDi
         t/90HvhyMCGhuWqNPhh8+a/iSWGiXBl+GaKYtzaR/4PnRVzhCANzGEHhrLhe5LREa+KI
         Hg4Uv87ZootDKi22ljvSAIHW9M3WObUi6k4TUzzrgs4RfWMXTKY52ZMNW+s1Bo3em7Ow
         mDnUuhEcNCOl9p3PFg221px5Ie6JEZV7GTMzYm+h+R65TfEC1sEN6HuLlobGhUCa6nA2
         2ogh8H0jnL269QDjudeFDkyYThMvdhHSp0v1Zlt82FvR+nGh27A+ifO6GeepzDTAXUAy
         4UvQ==
X-Gm-Message-State: AOAM531ZLW7yssB810jg/IAqBwh0xxk50qkZddMDKEGTjDznofnJ+Xri
        7+0J0IB8jITG2ELEV/KwW49fqw==
X-Google-Smtp-Source: ABdhPJwIw283geUeayV9RQ+FKAe5ZiHp4UFuuuzardosLujjFgeuxWKuIP3xs+I4td1anJBdrlWJ3A==
X-Received: by 2002:a0c:e18d:: with SMTP id p13mr1808849qvl.16.1623716212369;
        Mon, 14 Jun 2021 17:16:52 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:52 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 22/28] staging: rtl8188eu: remove all DBG_88E calls from hal/usb_halinit.c
Date:   Tue, 15 Jun 2021 01:15:01 +0100
Message-Id: <20210615001507.1171-23-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/usb_halinit.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself. Also remove unused jiffies variable from the start of
rtl8188eu_hal_init.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 51 +--------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index e3f3868b0b65..0c3f11411eae 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -35,7 +35,6 @@ static void _ConfigNormalChipOutEP_8188E(struct adapter *adapt, u8 NumOutPipe)
 	default:
 		break;
 	}
-	DBG_88E("%s OutEpQueueSel(0x%02x), OutEpNumber(%d)\n", __func__, haldata->OutEpQueueSel, haldata->OutEpNumber);
 }
 
 static bool HalUsbSetQueuePipeMapping8188EUsb(struct adapter *adapt, u8 NumInPipe, u8 NumOutPipe)
@@ -90,10 +89,8 @@ u32 rtw_hal_power_on(struct adapter *adapt)
 		return _SUCCESS;
 
 	if (!rtl88eu_pwrseqcmdparsing(adapt, PWR_CUT_ALL_MSK,
-				      Rtl8188E_NIC_PWR_ON_FLOW)) {
-		DBG_88E(KERN_ERR "%s: run power on flow fail\n", __func__);
+				      Rtl8188E_NIC_PWR_ON_FLOW))
 		return _FAIL;
-	}
 
 	/*  Enable MAC DMA/WMAC/SCHEDULE/SEC block */
 	/*  Set CR bit10 to enable 32k calibration. Suggested by SD1 Gimmy. Added by tynli. 2011.08.31. */
@@ -594,7 +591,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 
 	if (haldata->AntDivCfg == 0)
 		return;
-	DBG_88E("==>  %s ....\n", __func__);
 
 	usb_write32(Adapter, REG_LEDCFG0, usb_read32(Adapter, REG_LEDCFG0) | BIT(23));
 	phy_set_bb_reg(Adapter, rFPGA0_XAB_RFParameter, BIT(13), 0x01);
@@ -603,7 +599,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 		haldata->CurAntenna = Antenna_A;
 	else
 		haldata->CurAntenna = Antenna_B;
-	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
 }
 
 /*-----------------------------------------------------------------------------
@@ -629,12 +624,10 @@ enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
 
 	if (adapt->pwrctrlpriv.bHWPowerdown) {
 		val8 = usb_read8(adapt, REG_HSISR);
-		DBG_88E("pwrdown, 0x5c(BIT(7))=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(7)) ? rf_off : rf_on;
 	} else { /*  rf on/off */
 		usb_write8(adapt, REG_MAC_PINMUX_CFG, usb_read8(adapt, REG_MAC_PINMUX_CFG) & ~(BIT(3)));
 		val8 = usb_read8(adapt, REG_GPIO_IO_SEL);
-		DBG_88E("GPIO_IN=%02x\n", val8);
 		rfpowerstate = (val8 & BIT(3)) ? rf_on : rf_off;
 	}
 	return rfpowerstate;
@@ -649,7 +642,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	struct hal_data_8188e *haldata = Adapter->HalData;
 	struct pwrctrl_priv		*pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
-	unsigned long init_start_time = jiffies;
 
 	#define HAL_INIT_PROFILE_TAG(stage) do {} while (0)
 
@@ -709,7 +701,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 		status = rtl88eu_download_fw(Adapter);
 
 		if (status) {
-			DBG_88E("%s: Download Firmware failed!!\n", __func__);
 			Adapter->bFWReady = false;
 			return status;
 		}
@@ -726,10 +717,8 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_EFUSE_PATCH);
 	status = rtl8188e_iol_efuse_patch(Adapter);
-	if (status == _FAIL) {
-		DBG_88E("%s  rtl8188e_iol_efuse_patch failed\n", __func__);
+	if (status == _FAIL)
 		goto exit;
-	}
 
 	_InitTxBufferBoundary(Adapter, txpktbuf_bndy);
 
@@ -865,9 +854,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 exit:
 	HAL_INIT_PROFILE_TAG(HAL_INIT_STAGES_END);
 
-	DBG_88E("%s in %dms\n", __func__,
-		jiffies_to_msecs(jiffies - init_start_time));
-
 	return status;
 }
 
@@ -942,12 +928,9 @@ static void rtl8192cu_hw_power_down(struct adapter *adapt)
 
 u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
 {
-	DBG_88E("==> %s\n", __func__);
-
 	usb_write32(Adapter, REG_HIMR_88E, IMR_DISABLED_88E);
 	usb_write32(Adapter, REG_HIMRE_88E, IMR_DISABLED_88E);
 
-	DBG_88E("bkeepfwalive(%x)\n", Adapter->pwrctrlpriv.bkeepfwalive);
 	if (Adapter->pwrctrlpriv.bkeepfwalive) {
 		if ((Adapter->pwrctrlpriv.bHWPwrPindetect) && (Adapter->pwrctrlpriv.bHWPowerdown))
 			rtl8192cu_hw_power_down(Adapter);
@@ -1018,9 +1001,6 @@ static void Hal_EfuseParsePIDVID_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 		haldata->EEPROMCustomerID		= EEPROM_Default_CustomerID;
 		haldata->EEPROMSubCustomerID	= EEPROM_Default_SubCustomerID;
 	}
-
-	DBG_88E("VID = 0x%04X, PID = 0x%04X\n", haldata->EEPROMVID, haldata->EEPROMPID);
-	DBG_88E("Customer ID: 0x%02X, SubCustomer ID: 0x%02X\n", haldata->EEPROMCustomerID, haldata->EEPROMSubCustomerID);
 }
 
 static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
@@ -1070,9 +1050,6 @@ static void _ReadPROMContent(struct adapter *Adapter)
 	eeprom->EepromOrEfuse		= (eeValue & BOOT_FROM_EEPROM) ? true : false;
 	eeprom->bautoload_fail_flag	= (eeValue & EEPROM_EN) ? false : true;
 
-	DBG_88E("Boot from %s, Autoload %s !\n", (eeprom->EepromOrEfuse ? "EEPROM" : "EFUSE"),
-		(eeprom->bautoload_fail_flag ? "Fail" : "OK"));
-
 	Hal_InitPGData88E(Adapter);
 	readAdapterInfo_8188EU(Adapter);
 }
@@ -1137,8 +1114,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 variable, u8 *val)
 	val8 |= mode;
 	usb_write8(Adapter, MSR, val8);
 
-	DBG_88E("%s()-%d mode = %d\n", __func__, __LINE__, mode);
-
 	if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
 		StopTxBeacon(Adapter);
 
@@ -1259,7 +1234,6 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			/*  For 8190, we select only 24M, 12M, 6M, 11M, 5.5M, 2M, and 1M from the Basic rate. */
 			/*  We do not use other rates. */
 			hal_set_brate_cfg(val, &BrateCfg);
-			DBG_88E("HW_VAR_BASIC_RATE: BrateCfg(%#x)\n", BrateCfg);
 
 			/* 2011.03.30 add by Luke Lee */
 			/* CCK 2M ACK should be disabled for some BCM and Atheros AP IOT */
@@ -1541,7 +1515,6 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			else
 				AcmCtrl &= (~AcmHw_BeqEn);
 
-			DBG_88E("[HW_VAR_ACM_CTRL] Write 0x%X\n", AcmCtrl);
 			usb_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
 		}
 		break;
@@ -1685,8 +1658,6 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 					if (!(usb_read32(Adapter, REG_RXPKT_NUM) & RXDMA_IDLE))
 						break;
 				} while (trycnt--);
-				if (trycnt == 0)
-					DBG_88E("Stop RX DMA failed......\n");
 
 				/* RQPN Load 0 */
 				usb_write16(Adapter, REG_RQPN_NPQ, 0x0);
@@ -1699,13 +1670,11 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 		break;
 	case HW_VAR_APFM_ON_MAC:
 		haldata->bMacPwrCtrlOn = *val;
-		DBG_88E("%s: bMacPwrCtrlOn=%d\n", __func__, haldata->bMacPwrCtrlOn);
 		break;
 	case HW_VAR_TX_RPT_MAX_MACID:
 		{
 			u8 maxMacid = *val;
 
-			DBG_88E("### MacID(%d),Set Max Tx RPT MID(%d)\n", maxMacid, maxMacid + 1);
 			usb_write8(Adapter, REG_TX_RPT_CTRL + 1, maxMacid + 1);
 		}
 		break;
@@ -1835,20 +1804,6 @@ u8 rtw_hal_get_def_var(struct adapter *Adapter, enum hal_def_variable eVariable,
 		*((u32 *)pValue) = MAX_AMPDU_FACTOR_64K;
 		break;
 	case HW_DEF_RA_INFO_DUMP:
-		{
-			u8 entry_id = *((u8 *)pValue);
-
-			if (check_fwstate(&Adapter->mlmepriv, _FW_LINKED)) {
-				DBG_88E("============ RA status check ===================\n");
-				DBG_88E("Mac_id:%d , RateID = %d, RAUseRate = 0x%08x, RateSGI = %d, DecisionRate = 0x%02x ,PTStage = %d\n",
-					entry_id,
-					haldata->odmpriv.RAInfo[entry_id].RateID,
-					haldata->odmpriv.RAInfo[entry_id].RAUseRate,
-					haldata->odmpriv.RAInfo[entry_id].RateSGI,
-					haldata->odmpriv.RAInfo[entry_id].DecisionRate,
-					haldata->odmpriv.RAInfo[entry_id].PTStage);
-			}
-		}
 		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
@@ -1912,8 +1867,6 @@ void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 	}
 
 	rate_bitmap = ODM_Get_Rate_Bitmap(odmpriv, mac_id, mask, rssi_level);
-	DBG_88E("%s => mac_id:%d, networkType:0x%02x, mask:0x%08x\n\t ==> rssi_level:%d, rate_bitmap:0x%08x\n",
-		__func__, mac_id, networkType, mask, rssi_level, rate_bitmap);
 
 	mask &= rate_bitmap;
 
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5864F3DF837
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhHCXGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhHCXFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D4C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 16:05:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k4so180840wrc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0Jq8y64wYt8IiQ4pYcT3bBk2fDWTRj+O3SywM33NEA=;
        b=KExo1FvD5nfpg4xOJo5bO9G0+M9p5sbEnbC/Guq8Wu4J3rtElaTCvj/VPG4R7Zf3gM
         2yYsNBW2LOGMFXO5eKbjCTWeB+7Jx5FxjevtXtewCfUeElBmeNVJaDEuDS0ldnL3i2AT
         bThQiRhhfv+iDPrDQX7PEduGpo01R75mJS67ZaKuMCixGHrvOYN4IIjqQInKRcTA/Vcc
         /Ywv6cSe6uIQFBfPvUoR88iaEQNYcoU8qH2Uh3ccCjjhhapkMySAS3EiFPOFIRCi/jcQ
         DLBIpC2G+/BAKcVfV0ubPSsfXcTpu0F39PWEPKrR7i3L55s2nipuRPQIBqCt+ct5u+r+
         9ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0Jq8y64wYt8IiQ4pYcT3bBk2fDWTRj+O3SywM33NEA=;
        b=LnjDfMDjWB7jhNgljaWYfgPqqsgeJLpulr1oROi/qpiI6blddO6QZx4lyr+42vjfFJ
         0znA1vVLHljEeYOU8pctjtvHQGIiLZMyvh7GAfVrpJXUqd15X6sG6Td0KsF9q3qq4Pud
         k9Fqi5MaUM+iQVJHl3JnkvKcCxS7yuPil741Rrk29zxEAYu66az/E92DC59SPaMdf8xf
         X3vX2brsm6HQBBMC4fiNQ9cQM9lj+CtQSsC5c1iZg1Bqn3HAjQ8ppCCItid7yMXOaS60
         9i1YPvnRUMbFEcbJ3AmGEa0aj7iwtGwmji+LFX6VwJuofWWA4xVJnNDoVMLzZdJzKabD
         wcoQ==
X-Gm-Message-State: AOAM5319APJDuA++SnwvsksjHozpDYXNpvSFnJTd2Xt/XwJEYU0jYaVx
        wU9d5PWEvhtQFpbByImcIqsOWg==
X-Google-Smtp-Source: ABdhPJx6Cw7atJMCXCfQcxtLU8Qn6yLP8bP1kglPPYsrgpNOlWVmO2FUgSiLs/n1ixDQs1BTdr7Ygw==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr26047429wrw.29.1628031941469;
        Tue, 03 Aug 2021 16:05:41 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id i29sm330045wmb.20.2021.08.03.16.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 16:05:40 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: r8188eu: remove RT_TRACE calls from hal/rtl8188e_hal_init.c
Date:   Wed,  4 Aug 2021 00:05:32 +0100
Message-Id: <20210803230535.74254-6-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210803230535.74254-1-phil@philpotter.co.uk>
References: <20210803230535.74254-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from hal/rtl8188e_hal_init.c, so that ultimately
the macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 1a7a62dd8504..5855ceb45472 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -409,12 +409,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	blockCount_p1 = buffSize / blockSize_p1;
 	remainSize_p1 = buffSize % blockSize_p1;
 
-	if (blockCount_p1) {
-		RT_TRACE(_module_hal_init_c_, _drv_notice_,
-			 ("_BlockWrite: [P1] buffSize(%d) blockSize_p1(%d) blockCount_p1(%d) remainSize_p1(%d)\n",
-			 buffSize, blockSize_p1, blockCount_p1, remainSize_p1));
-	}
-
 	for (i = 0; i < blockCount_p1; i++) {
 		ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + i * blockSize_p1), blockSize_p1, (bufferPtr + i * blockSize_p1));
 		if (ret == _FAIL)
@@ -428,12 +422,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 		blockCount_p2 = remainSize_p1/blockSize_p2;
 		remainSize_p2 = remainSize_p1%blockSize_p2;
 
-		if (blockCount_p2) {
-				RT_TRACE(_module_hal_init_c_, _drv_notice_,
-					 ("_BlockWrite: [P2] buffSize_p2(%d) blockSize_p2(%d) blockCount_p2(%d) remainSize_p2(%d)\n",
-					 (buffSize-offset), blockSize_p2, blockCount_p2, remainSize_p2));
-		}
-
 		for (i = 0; i < blockCount_p2; i++) {
 			ret = rtw_writeN(padapter, (FW_8188E_START_ADDRESS + offset + i*blockSize_p2), blockSize_p2, (bufferPtr + offset + i*blockSize_p2));
 
@@ -448,10 +436,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 
 		blockCount_p3 = remainSize_p2 / blockSize_p3;
 
-		RT_TRACE(_module_hal_init_c_, _drv_notice_,
-			 ("_BlockWrite: [P3] buffSize_p3(%d) blockSize_p3(%d) blockCount_p3(%d)\n",
-			 (buffSize-offset), blockSize_p3, blockCount_p3));
-
 		for (i = 0; i < blockCount_p3; i++) {
 			ret = rtw_write8(padapter, (FW_8188E_START_ADDRESS + offset + i), *(bufferPtr + offset + i));
 
@@ -502,7 +486,6 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 		if (ret == _FAIL)
 			goto exit;
 	}
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("_WriteFW Done- for Normal chip.\n"));
 exit:
 	return ret;
 }
@@ -578,7 +561,6 @@ static int load_firmware(struct rt_firmware *pFirmware, struct device *device)
 	}
 	if (fw->size > FW_8188E_SIZE) {
 		rtStatus = _FAIL;
-		RT_TRACE(_module_hal_init_c_, _drv_err_, ("Firmware size exceed 0x%X. Check it.\n", FW_8188E_SIZE));
 		goto Exit;
 	}
 
@@ -610,7 +592,6 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	u32 FirmwareLen;
 	static int log_version;
 
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("+%s\n", __func__));
 	if (!dvobj->firmware.szFwBuffer)
 		rtStatus = load_firmware(&dvobj->firmware, device);
 	if (rtStatus == _FAIL) {
@@ -672,7 +653,6 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 		DBG_88E("DL Firmware failed!\n");
 		goto Exit;
 	}
-	RT_TRACE(_module_hal_init_c_, _drv_info_, ("Firmware is ready to run!\n"));
 
 Exit:
 	return rtStatus;
@@ -1896,7 +1876,6 @@ static s32 _LLTWrite(struct adapter *padapter, u32 address, u32 data)
 			break;
 
 		if (count > POLLING_LLT_THRESHOLD) {
-			RT_TRACE(_module_hal_init_c_, _drv_err_, ("Failed to polling write LLT done at address %d!\n", address));
 			status = _FAIL;
 			break;
 		}
@@ -1955,7 +1934,6 @@ Hal_InitPGData88E(struct adapter *padapter)
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
 		}
 	} else {/* autoload fail */
-		RT_TRACE(_module_hci_hal_init_c_, _drv_notice_, ("AutoLoad Fail reported from CR9346!!\n"));
 		/* update to default value 0xFF */
 		if (!is_boot_from_eeprom(padapter))
 			EFUSE_ShadowMapUpdate(padapter, EFUSE_WIFI, false);
@@ -2246,9 +2224,6 @@ void Hal_EfuseParseEEPROMVer88E(struct adapter *padapter, u8 *hwinfo, bool AutoL
 	} else {
 		pHalData->EEPROMVersion = 1;
 	}
-	RT_TRACE(_module_hci_hal_init_c_, _drv_info_,
-		 ("Hal_EfuseParseEEPROMVer(), EEVer = %d\n",
-		 pHalData->EEPROMVersion));
 }
 
 void rtl8188e_EfuseParseChnlPlan(struct adapter *padapter, u8 *hwinfo, bool AutoLoadFail)
-- 
2.31.1


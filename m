Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACB4401FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbhIFS1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbhIFS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC2DC0612A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s25so10591162edw.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca/jPcESGAma5shg4L8aeWp4njEIw1RS5+IbIZkKvEY=;
        b=eTbq/i92Bm1WneJhZB7cJBUNuGGsUYDW6f+b56sXQLaVifKPA+PyOvAkQmpgJomGUD
         nAFZEafoc9trLj+0WMFFj9nsQyHhV6q+Ucyho2W8BcAc7zlhaCtl0RJLDk8MKj8xzvef
         Pcmn+DMjnsn1+RuVWLMLvyAG9o6MEP1+uP3ZcnAEiWUDhhULmTWl9Hdr/2QLxouu7l+R
         STIHpp0LUoWO6+j/u/7jo9VaT8wgCE/nxX59T55IqGvZPLKT6FXE5M+R+MAVBKtoqLnl
         xuMmFfhrsGDmJnArxmMu6LrbxRMiVgzN5yFohNZUNNLtvxIiRUayeV+w/lv+utBdwNfq
         GUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca/jPcESGAma5shg4L8aeWp4njEIw1RS5+IbIZkKvEY=;
        b=QmVUasORolqFAGJPtl36AHfFHnMCDKucbVOSIRNmXn1aTn2WXjVgAOv/gdtfHkoFuH
         shv6CYHoxibDHeBR0oSS81XVBWerbB7COG7BFnN30huvj82OMoF3wzklUuLHX5t6xdbk
         0xrFNJHzuAGJzgPrjpQST1F5P1IklHmdXaZWWBEGXJSZxutrsoQnJtCDHX8bQ0MFDiYO
         Uo2w/Y64Qt0f+g5pLBQcUjbf1xttDzNhoEvZQyBthOrk/jzenXpF/YNsa76AhoT/n/2T
         XfrGcYEHHtfeXF2++fW2rOcqkLyYvoGk97L6GCG2/3ddliqCNDnUmFY+Z6LSvizqSSXv
         gJYA==
X-Gm-Message-State: AOAM531akN0sbsJwrIgePvCYDuaHL//J/zD4++5ssWjxlKGz+/298dAf
        tWrKSWwaqzYqhLbaolz7qRU=
X-Google-Smtp-Source: ABdhPJzf2+ULd4LyO9hvx0jJTK+rM9NXIkksA7o9Fr+jpfeIMMlvtTSRU0CJadH+vd5rBGOJj09QaQ==
X-Received: by 2002:aa7:c311:: with SMTP id l17mr14396103edq.320.1630952718264;
        Mon, 06 Sep 2021 11:25:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 23/40] staging: r8188eu: remove wrapper Efuse_PowerSwitch()
Date:   Mon,  6 Sep 2021 20:24:21 +0200
Message-Id: <20210906182438.5417-24-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove wrapper Efuse_PowerSwitch() and call rtl8188e_EfusePowerSwitch()
directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 55 ++++++---------------
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c |  8 +--
 drivers/staging/r8188eu/include/rtw_efuse.h |  1 -
 3 files changed, 18 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 8388ec60d21d..1aeddfa2f14d 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -58,33 +58,6 @@ Efuse_Write1ByteToFakeContent(
 	return true;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	Efuse_PowerSwitch
- *
- * Overview:	When we want to enable write operation, we should change to
- *				pwr on state. When we stop write, we should switch to 500k mode
- *				and disable LDO 2.5V.
- *
- * Input:       NONE
- *
- * Output:      NONE
- *
- * Return:      NONE
- *
- * Revised History:
- * When			Who		Remark
- * 11/17/2008	MHC		Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-void
-Efuse_PowerSwitch(
-		struct adapter *pAdapter,
-		u8 write,
-		u8 PwrState)
-{
-	rtl8188e_EfusePowerSwitch(pAdapter, write, PwrState);
-}
-
 /*-----------------------------------------------------------------------------
  * Function:	efuse_GetCurrentSize
  *
@@ -431,7 +404,7 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 		rw8 = &efuse_read8;
 	}
 
-	Efuse_PowerSwitch(padapter, write, true);
+	rtl8188e_EfusePowerSwitch(padapter, write, true);
 
 	/*  e-fuse one byte read / write */
 	for (i = 0; i < cnts; i++) {
@@ -445,7 +418,7 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 			break;
 	}
 
-	Efuse_PowerSwitch(padapter, write, false);
+	rtl8188e_EfusePowerSwitch(padapter, write, false);
 
 	return res;
 }
@@ -459,9 +432,9 @@ u16 efuse_GetMaxSize(struct adapter *padapter)
 /*  */
 u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
 {
-	Efuse_PowerSwitch(padapter, false, true);
+	rtl8188e_EfusePowerSwitch(padapter, false, true);
 	*size = Efuse_GetCurrentSize(padapter, EFUSE_WIFI, false);
-	Efuse_PowerSwitch(padapter, false, false);
+	rtl8188e_EfusePowerSwitch(padapter, false, false);
 
 	return _SUCCESS;
 }
@@ -475,11 +448,11 @@ u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
 
-	Efuse_PowerSwitch(padapter, false, true);
+	rtl8188e_EfusePowerSwitch(padapter, false, true);
 
 	efuse_ReadEFuse(padapter, EFUSE_WIFI, addr, cnts, data, false);
 
-	Efuse_PowerSwitch(padapter, false, false);
+	rtl8188e_EfusePowerSwitch(padapter, false, false);
 
 	return _SUCCESS;
 }
@@ -493,11 +466,11 @@ u8 rtw_BT_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	if ((addr + cnts) > mapLen)
 		return _FAIL;
 
-	Efuse_PowerSwitch(padapter, false, true);
+	rtl8188e_EfusePowerSwitch(padapter, false, true);
 
 	efuse_ReadEFuse(padapter, EFUSE_BT, addr, cnts, data, false);
 
-	Efuse_PowerSwitch(padapter, false, false);
+	rtl8188e_EfusePowerSwitch(padapter, false, false);
 
 	return _SUCCESS;
 }
@@ -524,7 +497,7 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 	if (ret == _FAIL)
 		goto exit;
 
-	Efuse_PowerSwitch(padapter, true, true);
+	rtl8188e_EfusePowerSwitch(padapter, true, true);
 
 	offset = (addr >> 3);
 	word_en = 0xF;
@@ -587,7 +560,7 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 		memset(newdata, 0xFF, PGPKT_DATA_SIZE);
 	} while (1);
 
-	Efuse_PowerSwitch(padapter, true, false);
+	rtl8188e_EfusePowerSwitch(padapter, true, false);
 exit:
 	kfree(map);
 	return ret;
@@ -616,7 +589,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 	if (ret == _FAIL)
 		goto exit;
 
-	Efuse_PowerSwitch(padapter, true, true);
+	rtl8188e_EfusePowerSwitch(padapter, true, true);
 
 	offset = (addr >> 3);
 	word_en = 0xF;
@@ -679,7 +652,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 		memset(newdata, 0xFF, PGPKT_DATA_SIZE);
 	} while (1);
 
-	Efuse_PowerSwitch(padapter, true, false);
+	rtl8188e_EfusePowerSwitch(padapter, true, false);
 
 exit:
 
@@ -768,13 +741,13 @@ static void Efuse_ReadAllMap(struct adapter *pAdapter, u8 efuseType, u8 *Efuse,
 {
 	u16 mapLen = 0;
 
-	Efuse_PowerSwitch(pAdapter, false, true);
+	rtl8188e_EfusePowerSwitch(pAdapter, false, true);
 
 	EFUSE_GetEfuseDefinition(pAdapter, efuseType, TYPE_EFUSE_MAP_LEN, (void *)&mapLen, pseudo);
 
 	efuse_ReadEFuse(pAdapter, efuseType, 0, mapLen, Efuse, pseudo);
 
-	Efuse_PowerSwitch(pAdapter, false, false);
+	rtl8188e_EfusePowerSwitch(pAdapter, false, false);
 }
 
 /*-----------------------------------------------------------------------------
diff --git a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
index c85f8e467337..7cb3f55ff58e 100644
--- a/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
+++ b/drivers/staging/r8188eu/core/rtw_mp_ioctl.c
@@ -973,19 +973,19 @@ int rtl8188eu_oid_rt_pro_rw_efuse_pgpkt_hdl(struct oid_par_priv *poid_par_priv)
 	_irqlevel_changed_(&oldirql, LOWER);
 
 	if (poid_par_priv->type_of_oid == QUERY_OID) {
-		Efuse_PowerSwitch(Adapter, false, true);
+		rtl8188e_EfusePowerSwitch(Adapter, false, true);
 		if (Efuse_PgPacketRead(Adapter, ppgpkt->offset, ppgpkt->data, false))
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 		else
 			status = NDIS_STATUS_FAILURE;
-		Efuse_PowerSwitch(Adapter, false, false);
+		rtl8188e_EfusePowerSwitch(Adapter, false, false);
 	} else {
-		Efuse_PowerSwitch(Adapter, true, true);
+		rtl8188e_EfusePowerSwitch(Adapter, true, true);
 		if (Efuse_PgPacketWrite(Adapter, ppgpkt->offset, ppgpkt->word_en, ppgpkt->data, false))
 			*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 		else
 			status = NDIS_STATUS_FAILURE;
-		Efuse_PowerSwitch(Adapter, true, false);
+		rtl8188e_EfusePowerSwitch(Adapter, true, false);
 	}
 
 	_irqlevel_changed_(&oldirql, RAISE);
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index b3ff46db2091..18fb9a4d9a0e 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -119,7 +119,6 @@ void EFUSE_GetEfuseDefinition(struct adapter *adapt, u8 type, u8 type1,
 u8 efuse_OneByteRead(struct adapter *adapter, u16 addr, u8 *data, bool test);
 u8 efuse_OneByteWrite(struct adapter *adapter, u16 addr, u8 data, bool	test);
 
-void Efuse_PowerSwitch(struct adapter *adapt,u8 bWrite,u8  PwrState);
 int Efuse_PgPacketRead(struct adapter *adapt, u8 offset, u8 *data, bool test);
 int Efuse_PgPacketWrite(struct adapter *adapter, u8 offset, u8 word, u8 *data,
 			bool test);
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B06402036
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbhIFTFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbhIFTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B1C0613C1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:15 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ia27so15092779ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HM0U8aFAgyxYkE6pP3iIT4ysY9lJ8YRKLSjNY12/S5U=;
        b=k+ERlf7N6CImlG/BnP9qmfyvgRtud9iTlFQfbcI6AaMa+VImVY70nKv2BFqt4hqmFr
         IwGQulK6D/SJKsR2Wtp+3J6F40udNd4QyN/lGzrgy4Ehvvb8a6YQUXmXT3KVtQEiYSMH
         f1VggSixvNT3luCI4Zn7WD1jWgnAXdzKXagCwcqFh1jdrn7Cyn2e1Ks/zCNcJVp9aMoh
         zWqFwlen1h8qz4DgtaJQFQoaOBGadg9Q0Hg97tZc9CQH+32LkLL6z7yZtkCbnAraLPvw
         2zgdj1j1UtkYQt25H8TH87rX2hKyuZF+DepVezAmEtG1IiGTT1eMid9J8enu4F1qeinn
         aYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HM0U8aFAgyxYkE6pP3iIT4ysY9lJ8YRKLSjNY12/S5U=;
        b=Vlb92oymD1OIEBJbtQCGKtOWDbNSUG+lW6JSGqRjBzbh0V81GpcrS9r1g+mvWmFiCr
         yulAfqmykFnfLS3CJbIIWFyT3BIk12WNX5KibFI2NVWH9l9vgfqRPyVsfErH+t4SqyqY
         rUAT/64D3mUPb7XVPMWaPNpIJGqdEypZnf1V3hl8Eai9IzXlobs7Yg9g+ssDq9qD5IeQ
         izZrThI82oUlWikfNpLXdGYqwXRQAZUT5LBybjImSjXOlpQfpJuwpeAd23TIaFt3yhnT
         PysFKIVixkwqP1tcp7BwxTiuQVcyOOu+nTJIq4YiJLVZkG3FO2Nzrwf/bJwwwbOhtdH7
         ckmg==
X-Gm-Message-State: AOAM5335MzQvoL9uFW+GWi61g3NUz19TCXGsivrY9n3JBQ9T7EMeZODl
        YS041ZOO/C3W0x6+368nkjI=
X-Google-Smtp-Source: ABdhPJzreOz0KWGKSBg8URpKj5232g+puUsZxNZnz6gYbJoX30KxAjCl/6BNaZxgkmps+EijEomZZg==
X-Received: by 2002:a17:906:130a:: with SMTP id w10mr14763960ejb.89.1630954993916;
        Mon, 06 Sep 2021 12:03:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:13 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 39/40] staging: r8188eu: remove SetBeaconRelatedRegistersHandler from hal_ops
Date:   Mon,  6 Sep 2021 21:02:22 +0200
Message-Id: <20210906190223.11396-40-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove SetBeaconRelatedRegistersHandler from hal_ops and remove its
wrapper rtw_hal_bcn_related_reg_setting().
Call SetBeaconRelatedRegisters8188EUsb() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c       | 6 ------
 drivers/staging/r8188eu/hal/usb_halinit.c    | 3 +--
 drivers/staging/r8188eu/include/hal_intf.h   | 5 ++---
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index cd4f1ae61dca..c2f664bdb979 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1525,7 +1525,7 @@ void correct_TSF(struct adapter *padapter, struct mlme_ext_priv *pmlmeext)
 
 void beacon_timing_control(struct adapter *padapter)
 {
-	rtw_hal_bcn_related_reg_setting(padapter);
+	SetBeaconRelatedRegisters8188EUsb(padapter);
 }
 
 static struct adapter *pbuddy_padapter;
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 17ac271e2417..d38a8134b243 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -180,12 +180,6 @@ void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 					      bitmask, data);
 }
 
-void rtw_hal_bcn_related_reg_setting(struct adapter *adapt)
-{
-	if (adapt->HalFunc.SetBeaconRelatedRegistersHandler)
-		adapt->HalFunc.SetBeaconRelatedRegistersHandler(adapt);
-}
-
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt)
 {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 2c010f12118a..4d60b5156995 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2147,7 +2147,7 @@ static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_l
 	psta->init_rate = init_rate;
 }
 
-static void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
+void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 {
 	u32 value32;
 	struct mlme_ext_priv	*pmlmeext = &adapt->mlmeextpriv;
@@ -2231,7 +2231,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->SetHalDefVarHandler = &SetHalDefVar8188EUsb;
 
 	halfunc->UpdateRAMaskHandler = &UpdateHalRAMask8188EUsb;
-	halfunc->SetBeaconRelatedRegistersHandler = &SetBeaconRelatedRegisters8188EUsb;
 
 	halfunc->hal_xmit = &rtl8188eu_hal_xmit;
 	halfunc->mgnt_xmit = &rtl8188eu_mgnt_xmit;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9b0a44659f57..668a21cbe71e 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -149,7 +149,6 @@ struct hal_ops {
 
 	void	(*UpdateRAMaskHandler)(struct adapter *padapter,
 				       u32 mac_id, u8 rssi_level);
-	void	(*SetBeaconRelatedRegistersHandler)(struct adapter *padapter);
 
 	s32	(*hal_xmit)(struct adapter *padapter,
 			    struct xmit_frame *pxmitframe);
@@ -205,6 +204,8 @@ int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en
 
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 
+void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt);
+
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
@@ -232,8 +233,6 @@ void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
 			   struct adapter *src_adapt);
 
-void rtw_hal_bcn_related_reg_setting(struct adapter *padapter);
-
 u32	rtw_hal_read_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask);
 void	rtw_hal_write_bbreg(struct adapter *padapter, u32 RegAddr, u32 BitMask,
 			    u32 Data);
-- 
2.33.0


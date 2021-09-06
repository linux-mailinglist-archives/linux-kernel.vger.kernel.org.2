Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78430401FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbhIFS2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244730AbhIFS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625C2C0612A3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a25so14980129ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rDU/Aka2Jxuf6M2FTahHDgy7VZclBVFd9XLtJVQxGI=;
        b=HH32OtePnoDD33mrzpeNN62Gvy4klcIm5zMAZmlfv+ghYKPtC3Ccrwq7b2km1SMGVv
         2p3o0qeyeLGkldeH4NrB3DX+eVECy9aKsX63WieDComyqhufAvhG/xXN+JZXJ8chicpy
         ZxVET6amT+QGjg9EeLaFuo8JvDwDI4B866htOk+LsQ2buK0RztFFDS+TQGZvecbHTqg2
         9lr+CSAxsMn5FsyInxxpBdtrdntN/o9/mONTsjNFlzagWgiXxV0/2hQX+DB6G8d0IEGk
         YO9qyk3OaXuw+Sniddnn3ZGayeHlSy/vNxq291UdppbgmwRFqRLG6c//Dc94/iA2fL3n
         NE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rDU/Aka2Jxuf6M2FTahHDgy7VZclBVFd9XLtJVQxGI=;
        b=rVg1bTRftGuiTAExkpr2k0OSuhO3suzGpoiX4wk1saYwX7bB04suPCGwKn7sztVcbo
         OuqvT0cYjR5n9sVW0vCtu1zDKyK2oSG0yiGOruyVQqfxrBACZcduOsLRov2ueN1+j6xo
         CG2s9ysG5jcxseR5ufNemO1hedtUEfEi8IEEkpdiOa144gv1WBCdgFAcLT6Lh/2v8kPu
         NbAHkoRMQVm7y3qedcl50SifIsMcpkBk1b4GJq+711fN7IvR7JvqY8OvePqOtumcdBab
         KeGaJM32mh3sB9xeffynAr33dx6gbyYSbNRy2vIECVFZO+BCaMJWZWd5CAg0Dp7Vk/Qx
         aF7w==
X-Gm-Message-State: AOAM533b+8Wnob7wa5lzbce4PtdTedvBDEm/zmhCm0qfNoKdTArg+Zlm
        Qyi86C7CNca8RItYdPyJswM=
X-Google-Smtp-Source: ABdhPJyJfuKpLPxrs6gxAiO0N01xvXdfQLM1g/qkbGdryaAM4HqjlBXKrRjVlEj31TFiC74Iw6aKXw==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr14805866ejc.196.1630952730826;
        Mon, 06 Sep 2021 11:25:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 40/40] staging: r8188eu: remove UpdateHalRAMask8188EUsb from hal_ops
Date:   Mon,  6 Sep 2021 20:24:38 +0200
Message-Id: <20210906182438.5417-41-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove UpdateHalRAMask8188EUsb hal_ops and call
UpdateHalRAMask8188EUsb() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c     | 4 +---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index d38a8134b243..92c55b9ab244 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -139,9 +139,7 @@ void rtw_hal_update_ra_mask(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 			add_RATid(adapt, psta, 0);/* todo: based on rssi_level*/
 #endif
 	} else {
-		if (adapt->HalFunc.UpdateRAMaskHandler)
-			adapt->HalFunc.UpdateRAMaskHandler(adapt, mac_id,
-							      rssi_level);
+		UpdateHalRAMask8188EUsb(adapt, mac_id, rssi_level);
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4d60b5156995..37a976c56f06 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2064,7 +2064,7 @@ static u8 SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eV
 	return bResult;
 }
 
-static void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
+void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level)
 {
 	u8 init_rate = 0;
 	u8 networkType, raid;
@@ -2230,8 +2230,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->GetHalDefVarHandler = &GetHalDefVar8188EUsb;
 	halfunc->SetHalDefVarHandler = &SetHalDefVar8188EUsb;
 
-	halfunc->UpdateRAMaskHandler = &UpdateHalRAMask8188EUsb;
-
 	halfunc->hal_xmit = &rtl8188eu_hal_xmit;
 	halfunc->mgnt_xmit = &rtl8188eu_mgnt_xmit;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 668a21cbe71e..727ef8511f64 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -147,9 +147,6 @@ struct hal_ops {
 				       enum hal_def_variable eVariable,
 				       void *pValue);
 
-	void	(*UpdateRAMaskHandler)(struct adapter *padapter,
-				       u32 mac_id, u8 rssi_level);
-
 	s32	(*hal_xmit)(struct adapter *padapter,
 			    struct xmit_frame *pxmitframe);
 	s32 (*mgnt_xmit)(struct adapter *padapter,
@@ -205,6 +202,7 @@ int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en
 void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 
 void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt);
+void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level);
 
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE5402013
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbhIFS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245395AbhIFSzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF99C0612AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc21so15076017ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEOqP/a3Ml1D77dDy56BnF0eXKCaiuHX10tPsGM0jZI=;
        b=gXHrWgcTjmYIP9h/1MUFGP23ooK7oJB1S9bb9I5agj6bWOlkgW9+PeUc9QGcZE5thR
         +/NRFfKMEY2e6jvVypDErmLNMqY6M67/3wTgcQBMY1zHkmRf0tgnH/0Pnev5xO5LrC9L
         RqpNWx1nbQiJEfn6E11HSa1nXm4gC7D0Gwn4Af4RUksS4d+F49bdHhCecB0gUlAnEM2j
         WkxRilOKRpl0Gvyc37fVJjnhll+ptBvrJUivHGWA4ydV0FDjqcJ1/9LaX9Tn81lwPH8u
         qghPhU771lR7FaypZ06wYKPclEQDsegAt33SAufJ8khAvVnj7P5HB2kPcVhodc2M9l7d
         bPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEOqP/a3Ml1D77dDy56BnF0eXKCaiuHX10tPsGM0jZI=;
        b=JWDZ9YZPYbdB9NKUkqpakfa8FNdQwTVQQO6RRAeOrh7Pv9TVg3BwsdRiJnCgOAP/cC
         Jw0g+xn2z+eG1hzixUcS9CX3ChW2vnPaxojhFPhSQrz0zyACOnc3OhrrUjzMRf8qqLbm
         UEfXrLekCW1eg1HiLNGQ44hXrRtlRpgR2Zp+zSn/jxFGQkkP7V6NDjUB0WFYkCobJk/U
         aD/5ZBxT6xeDk8Uc4dG9cJhnzF1JyWub7fKihi7zeLAwt/bbb21CBq/i9i5rnfzIm5NV
         f+fz23O2PkUyZyEp1IJDn14NZC66timceBB8WDEJU/kxUzbLbCiOaWho0onvPRbhqDGt
         S5yA==
X-Gm-Message-State: AOAM530dJMv+4hgVSgwCbxBAa5BsaOlYRZLtVRLF/rXxj37+/xgWo9Gm
        xQPjPRn+L0ei0zPQrTf7Zgo=
X-Google-Smtp-Source: ABdhPJyNGxde4Rqxy8rBXI0pzw4vSOiSkFjx7G5QHDyJfoWT6ZOmXqqOZnJGOrUwemmzTkA/OfrHKw==
X-Received: by 2002:a17:906:ae4f:: with SMTP id lf15mr15309553ejb.124.1630954471876;
        Mon, 06 Sep 2021 11:54:31 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:31 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 40/40] staging: r8188eu: remove UpdateHalRAMask8188EUsb from hal_ops
Date:   Mon,  6 Sep 2021 20:53:27 +0200
Message-Id: <20210906185327.10326-41-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove UpdateHalRAMask8188EUsb from hal_ops and call
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


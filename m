Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBF401FA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbhIFS1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244515AbhIFS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:25 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B3C06179A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc21so14952965ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZcdw5/FHSKxoWTT6jITNvbxxtZhx7qTeSob97p9cnI=;
        b=lEZQxbPD4s1FL5ItOlSIf/0JIChYFd+8+gE24pLxUY7ykaNMPLXk+krR+a9y+auLqp
         4s3T2ckO97vy7ZFWeBdVTWEZ7GsS5EMK0VnTjmbhWAa5hR6V+Nnzk9S/68Q/XYmKmdPz
         vnezCsimLgTd9NrkGdN14bzQXf/RuXzlaOcwz+ayvLpgTOFPOV+wzBb2zef5TJPV1fQy
         OzaRLhQM1RfTO5WDgwUS575sBh4E0s1095XVnreV35wQYZ6dFgBKQExdXf7hXFUEwgOD
         R2LToiKwPkUU/EdFYneihn2v6V7XhDT1+4cNwVjz62at58BSvOjUL3g8Z2K70FHpJgUi
         A0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZcdw5/FHSKxoWTT6jITNvbxxtZhx7qTeSob97p9cnI=;
        b=oY0UuziN7GhStbP4oHxl9zEyg7mf/TRds/rD4UcmH4IcrDKKze28xyahuYY2iwuhc4
         tc8R2YiN9byRai0a3AMfZHJioYLQdUpx00BzoEk6RjEmKspPUyLc/iMJ4fPUYFTiq0RS
         soScPMXAH4wDdbP8kT2jiSk6yS6hS7Vjfqw0jlWBHjijrzVpqEVAJxlCQIVS8JwtTWpK
         W5KtKmvevFWTUiur8Y6pM+wPaWIx87UWhbbBSbFp2XgyKrDX4cs1oSYGfCBa0vO7rOgM
         CD/4V6AS6yPlSsw8XvLwQme6Kq/lRSb9cbNV9UgZbF1kg9S/+xrVZnpRQI41c3zzMMnm
         7Sfg==
X-Gm-Message-State: AOAM53247wO/mRFEHBdgXhBO+Pu3ZNijGqDZkaO6yzvTT5PzoPlw28CZ
        uwe/FDRT8pOMVD9axZic5Zh9pKjQLVSjPw==
X-Google-Smtp-Source: ABdhPJxpHw4xyHlJs6EME4SeBK1lPPO2WrnQONVI48Y2lxAbGTUYIv5HLFwIQO1mFCBfIygku7thyg==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr14804940ejc.196.1630952713120;
        Mon, 06 Sep 2021 11:25:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/40] staging: r8188eu: remove sreset_reset_value from hal_ops
Date:   Mon,  6 Sep 2021 20:24:14 +0200
Message-Id: <20210906182438.5417-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_reset_value from hal_ops and remove its wrapper
rtw_hal_sreset_reset_value(). Call sreset_reset_value() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 +-
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 712e497f77ab..e5267c23ab86 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -227,12 +227,6 @@ void rtw_hal_sreset_reset(struct adapter *adapt)
 		adapt->HalFunc.silentreset(adapt);
 }
 
-void rtw_hal_sreset_reset_value(struct adapter *adapt)
-{
-	if (adapt->HalFunc.sreset_reset_value)
-		adapt->HalFunc.sreset_reset_value(adapt);
-}
-
 void rtw_hal_sreset_xmit_status_check(struct adapter *adapt)
 {
 	if (adapt->HalFunc.sreset_xmit_status_check)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 82de4eaedf1a..222e66656aa9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,7 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->sreset_reset_value = &sreset_reset_value;
 	pHalFunc->silentreset = &rtl8188e_silentreset_for_specific_platform;
 	pHalFunc->sreset_xmit_status_check = &rtl8188e_sreset_xmit_status_check;
 	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1cc97dcb06bc..946896698655 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	void (*sreset_reset_value)(struct adapter *padapter);
 	void (*silentreset)(struct adapter *padapter);
 	void (*sreset_xmit_status_check)(struct adapter *padapter);
 	void (*sreset_linked_status_check) (struct adapter *padapter);
@@ -274,7 +273,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *src);
 
 void rtw_hal_sreset_reset(struct adapter *padapter);
-void rtw_hal_sreset_reset_value(struct adapter *padapter);
 void rtw_hal_sreset_xmit_status_check(struct adapter *padapter);
 void rtw_hal_sreset_linked_status_check(struct adapter *padapter);
 u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 333005c13061..28f6028d7335 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -816,7 +816,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING);
 
-	rtw_hal_sreset_reset_value(padapter);
+	sreset_reset_value(padapter);
 	pwrctrlpriv->pwr_state_check_cnts = 0;
 
 	/* mlmeextpriv */
-- 
2.33.0


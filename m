Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47740202E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbhIFTFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbhIFTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3BC0617AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eb14so10614660edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZcdw5/FHSKxoWTT6jITNvbxxtZhx7qTeSob97p9cnI=;
        b=SwJbbko4wJjVNSD9Yss02cryI0RsB92WR1ky6wzwfOHkesZEFLEvCutwrUBHPrDr6y
         dRICPujFWoZnC2lNZXUchu9WOhDkA/gDzSu53v5q+3J/Y1tRZwZrGMvfHPrdB7fFurX4
         JUeAzeNU6EQ2xSe7DGvv6qvhxLnW0CdPRl/iM7Agv9ktakltJrZK6mNd84drRP3WPhJQ
         2Xpzg75/j8QTrq5kpp0TpPu0VjDlTnpaVnpoo+zWQcYTI1BVwDAIKZmejG0v7p/LtGj5
         8lc9Axlr2v0EeJMCEOCOOyh0xumIWej37/3+mMZHNJmyPRCtZ43N4jcQhYauMVj3Fzk/
         EBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZcdw5/FHSKxoWTT6jITNvbxxtZhx7qTeSob97p9cnI=;
        b=jXCv9ZsoIzaPXVexXXcO3n0x4REmu34HjBHzjboi5OBWRsG1gnzOhpHxyNcDTDD+37
         bkuXV0hXijLOlfb6jYmAusm6+7dVopCAddeWrubzF0p4babv59KqRWjIN3767l/asrcc
         iLIJDQCJfAoJsuYD9ky1LC+KS74LMFJMrO+5+x2vvYrCahH4PImoGFAwyIZmzHHmSHpw
         yDptWUo6sm9O6UChc41mb02PgzH/LbD4bkrhU3qUe1bvtZLsd9gedobk3VzXjOsTS6Q2
         D11s3vdX0wXfJOQwTdvvyWQGQ22UsxU+2CHjQysONyWHDejfKdcAuPXqtLuyXNPQDPNG
         Sr2w==
X-Gm-Message-State: AOAM533o1w/WOfboDG9O4/sEnRwjJriNHs8NQvt4s3TFClhWA+YRZ+Fy
        ejzmdbk4x61WpZwPo2uN1ew=
X-Google-Smtp-Source: ABdhPJwnXc+DQ4TXSXn6luVfGW7e0dZDci1UyK4aHEc3Ccj4dgt/BPER1kfCFfDBxaqdl4YUGeLa0g==
X-Received: by 2002:aa7:c04a:: with SMTP id k10mr14995609edo.32.1630954977134;
        Mon, 06 Sep 2021 12:02:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 16/40] staging: r8188eu: remove sreset_reset_value from hal_ops
Date:   Mon,  6 Sep 2021 21:01:59 +0200
Message-Id: <20210906190223.11396-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
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


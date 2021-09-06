Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B34E402030
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbhIFTF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245355AbhIFTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C82C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dm15so10622209edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWKIkb6qgsNd1sghd+Gu94KZJMj3gN+DQLl2UZMTmdk=;
        b=kA6rRAWAw8ITTs1/xvT8KBL+Svn0youmgQljH1vzQ29tRLaPZNAF1zX9IyMQEmt5Cb
         ebaa5MAo2LSQ+Wu/LmNr2qDu8FJsFFw7u0+hRmNaoHD3fanqw7xJZYDM86/OJoka1C9a
         sMROREaRCwy0otNTcjYGuB+t4a7f2P5Gl+8QT84GTWBlUsZm3B6T4w2pMtsez7b/zi2A
         IRKJDfITdS/BBzQ2+YKONtmoAGk1fY2OnyjHsTMyAwC+c4aqBaRpnyC7u2jSRjOUuT23
         5wUuCxIhIYZjy5pfAwbxDUsLhzN6Htz+mtSlOX1binS77xwHhl2Ikjm4g/VLnaEnH6Y/
         R2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWKIkb6qgsNd1sghd+Gu94KZJMj3gN+DQLl2UZMTmdk=;
        b=s4NrgSIsI2V2NqQjGrCuCAeONox7S96XWl8VC5Q/zILHMugiqDZ0Y55dzMdvrdXXQH
         bST8UaRwnq0zHQEqYSInY705sRkq62e7xhid9/n9xlevtlUjnj7vJFuB6Mg5Z+COVwoY
         O00KMliJ0nXXR8tJurKW0dBPvugBJuheK6jk827/UdK2ZK6wZpQB7OxynTJCRNmii1Id
         qY8zj7HI8Dkjq4WBA8LavOZH+1m137IKCgGELZCiu9PzQUfoZkjISONGjaPsjPowGcMJ
         BQnMxGDl4q0rIhMECboZ9ueKi8FjRMpuxFtId8Eq56Rq9/SlP4wSGqxzEuTJchXRUjev
         kmxQ==
X-Gm-Message-State: AOAM531VkU0bD0JNLnoBV8WdXo86frJyuy03U4nN9NmuFrLX54+9qkwg
        W3kmtCDrfQgbZIEpBvRAkfk=
X-Google-Smtp-Source: ABdhPJy9T10Hhmo4mmab6+qjWMmlVJXec2ubUDpi7LJbhpRv0MmC4XuAbpUjVApqzpRZ2by0k7w3KA==
X-Received: by 2002:aa7:c857:: with SMTP id g23mr14798876edt.219.1630954978639;
        Mon, 06 Sep 2021 12:02:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:58 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 18/40] staging: r8188eu: remove sreset_xmit_status_check from hal_ops
Date:   Mon,  6 Sep 2021 21:02:01 +0200
Message-Id: <20210906190223.11396-19-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_xmit_status_check from hal_ops and remove its wrapper
rtw_hal_sreset_xmit_status_check().
Call rtl8188e_sreset_xmit_status_check() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c          | 3 ++-
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 67b4fe1304a5..a52c17dd2e5a 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -10,6 +10,7 @@
 #include "../include/rtw_br_ext.h"
 #include "../include/rtw_mlme_ext.h"
 #include "../include/rtl8188e_dm.h"
+#include "../include/rtl8188e_sreset.h"
 
 /*
 Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
@@ -1492,7 +1493,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
 		expire_timeout_chk(padapter);
 #endif
 
-	rtw_hal_sreset_xmit_status_check(padapter);
+	rtl8188e_sreset_xmit_status_check(padapter);
 
 	linked_status_chk(padapter);
 	traffic_status_watchdog(padapter);
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 51f6160f7dec..b1a71a8fdf38 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -221,12 +221,6 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
 		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
 }
 
-void rtw_hal_sreset_xmit_status_check(struct adapter *adapt)
-{
-	if (adapt->HalFunc.sreset_xmit_status_check)
-		adapt->HalFunc.sreset_xmit_status_check(adapt);
-}
-
 void rtw_hal_sreset_linked_status_check(struct adapter *adapt)
 {
 	if (adapt->HalFunc.sreset_linked_status_check)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f9852eae7c74..9b44fd2d93d7 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,7 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->sreset_xmit_status_check = &rtl8188e_sreset_xmit_status_check;
 	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
 	pHalFunc->sreset_get_wifi_status  = &sreset_get_wifi_status;
 
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1a85f11ba596..2f4bc16aeabd 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	void (*sreset_xmit_status_check)(struct adapter *padapter);
 	void (*sreset_linked_status_check) (struct adapter *padapter);
 	u8 (*sreset_get_wifi_status)(struct adapter *padapter);
 
@@ -271,7 +270,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
 
-void rtw_hal_sreset_xmit_status_check(struct adapter *padapter);
 void rtw_hal_sreset_linked_status_check(struct adapter *padapter);
 u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
 
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A233540204B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbhIFTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbhIFTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F8C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:03:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id me10so15092859ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6Mu2rmKCPwNJW+9zwnqhgEVtP2V6TMjoxJ0ql5/F1I=;
        b=SsGA7mGdYdfka07aHK4d5uNfcgUJReukPnA3PWYbyEtl72JoIXuZ2+WeO+EjceJpmV
         8cHN3fiuW8N0zRgOyybGRPJ9qHxOSquPHzhmsL+mz/bTZ+3vV+BNiw7yubd7yQASsGDq
         qB7pLUCcwxERifOdgwFUM+GqgQqTZze5LcQ4J6BTJdh6wOfU1Q8M9Ilq4Sxvs+OdxKsR
         zW1PMgtR0yu6K4pbfmFPLL59bCWI07FwFnMY4bq9e4/x0b7BwCdPVKd8wDuLt/NziZ4F
         /LNa8cup2yFzxR3e6U2pzxtZBbcBd3Rv8xOTkaI6/1c2WmqFheiHfzziNUH0xSaVp+mj
         ascQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6Mu2rmKCPwNJW+9zwnqhgEVtP2V6TMjoxJ0ql5/F1I=;
        b=uNfRUVNKTzKP2VbKFiRzIrvWkRpMYMqX5af4dazLf7DZ9+/Ld/OgRIc8PBPw8ZL5+r
         y4X2Bmrz167/O4TgnW9so620CcNzjkfKs8mArHHF6UV5Mxr8xRsMrRYNy8pfS3m18AS7
         FfL+w2vxr2e66Os0rBqnwm664olQVcN6On9RIcmQeoCpf39WbyT33z0Hql0xtu74B99x
         E5aXj4H9ZIHvnwdgwYIJRHBtRfxrDbQowt5XYip1knMxB/kXwOBOonkvdelnwVB14tUq
         TS9VMJwFBIe4vu0KC8oP1hrIX20Xpzw6crYAKL4ymZX5HVt9ZYezfi2mNQ5+tZM7q7W7
         ELXg==
X-Gm-Message-State: AOAM531wNB1MqHB7CrLxh96ed1/WY38bH7RfsxPzjFfU2L8LSu/3FACi
        SjHAqpTN4p+nZP8+LsaqChU=
X-Google-Smtp-Source: ABdhPJzsm6NRHl91spuvCjrwcjxme2cWypCSSFtIeOMG3X1WXHnUni4B/6qYZi2BMbuGu33/6tPMQg==
X-Received: by 2002:a17:906:7fc4:: with SMTP id r4mr15777617ejs.75.1630954991801;
        Mon, 06 Sep 2021 12:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:11 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 36/40] staging: r8188eu: remove hal_notch_filter from hal_ops
Date:   Mon,  6 Sep 2021 21:02:19 +0200
Message-Id: <20210906190223.11396-37-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_notch_filter from hal_ops and remove its wrapper
rtw_hal_notch_filter(). Call hal_notch_filter_8188e() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 +-------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 6 ++----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 4a9820c2b36e..4394c6825f1a 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -24,7 +24,7 @@ uint	 rtw_hal_init(struct adapter *adapt)
 		adapt->hw_init_completed = true;
 
 		if (adapt->registrypriv.notch_filter == 1)
-			rtw_hal_notch_filter(adapt, 1);
+			hal_notch_filter_8188e(adapt, 1);
 	} else {
 		adapt->hw_init_completed = false;
 		DBG_88E("rtw_hal_init: hal__init fail\n");
@@ -201,9 +201,3 @@ int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 							   bndy_cnt);
 	return _FAIL;
 }
-
-void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
-{
-	if (adapter->HalFunc.hal_notch_filter)
-		adapter->HalFunc.hal_notch_filter(adapter, enable);
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f87cfa0e404a..9a76e9aaa2d0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1748,7 +1748,7 @@ void rtl8188e_clone_haldata(struct adapter *dst_adapter, struct adapter *src_ada
 	memcpy(dst_adapter->HalData, src_adapter->HalData, dst_adapter->hal_data_sz);
 }
 
-static void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
+void hal_notch_filter_8188e(struct adapter *adapter, bool enable)
 {
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
@@ -1768,8 +1768,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
 
 	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
-
-	pHalFunc->hal_notch_filter = &hal_notch_filter_8188e;
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index fdde4b2b8ec4..35201286704f 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -172,8 +172,6 @@ struct hal_ops {
 	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
 				  struct xmit_frame *frame, u32 max_wait,
 				  u32 bndy_cnt);
-
-	void (*hal_notch_filter)(struct adapter *adapter, bool enable);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -207,6 +205,8 @@ u16 rtl8188e_EfuseGetCurrentSize(struct adapter *pAdapter, u8 efuseType, bool bP
 int rtl8188e_Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data, bool bPseudoTest);
 int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *data, bool bPseudoTest);
 
+void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
+
 void	rtw_hal_free_data(struct adapter *padapter);
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
@@ -249,8 +249,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt);
 
-void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
-
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240C8425144
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbhJGKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbhJGKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:41:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38767C061764
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 03:39:52 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m22so17735557wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 03:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPa9QDbMW8Q2aontKUtW/T0f3VKdCCK0/90A5i4Dj/w=;
        b=MVHAhDkbQ7419WNhQKoC6Ym6Rp7tVSZwtKWH4hBYCiiX9HUceAiw14FEKiXJF4qki2
         pJRywCZfHu7WX5Ebj0UC5BaFs63Q8Qy7MdDJegDg8Mhh3qXl1F9L6SMUjLpn2/Da0S1a
         CG0KdXUQqsKgpU8GT/Ql+CGqAJz1RZ3XEUicKLtkC3XRP7MmPpybe41blJlHnuiiqNMC
         R6q2Sk0vde40+djpXCa1UpPETJt8GlsUqGTgcBMOBs9qvSIo3T8LZd5cDfk62U4G/Qyj
         iIX5b38Vn3YRQKHLTqQPBZx66KEgAK455Fep1F2wvf1F+QkcCJna/W2TOyaSEHLt9vEA
         CDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPa9QDbMW8Q2aontKUtW/T0f3VKdCCK0/90A5i4Dj/w=;
        b=dXVX4hpjTWFCo8B3GbgQegq3WK2dvvOZWJAYlatPyGkypJo/t8Xaox55LWt/juE6Lp
         lWRA14PqsA5CIkuMN+1bn9dII2gMwUYQaUBb/xTvog3GHKWapP1hVnVrNaINiD2rogn2
         1MUP3FCmvcVbXLZf9Thz2sgMnbB/9yIY+g11aEMitDQ6wJqtr5AlKGUMHtd52e+vsB9t
         IrfLmQpr9MKZFI2JT4gA4nu89gugA8mlEOQBhqkU8VlJmBqHJLFM1qZc0qjtYo+FYLd7
         /1z+WyGJlAtwDUHNOadvkFFPK+CAUTCipxMnl8fXCRQIrapOlUMA7tGPllqFb8Pm3elb
         Re+g==
X-Gm-Message-State: AOAM533Zd9PWUx9qWh3rYT6jsWpZYCYNjUciwSrsDa6qcbNRT/TxjvXZ
        bZLjO+xHd7fNPd5yOeygIdc=
X-Google-Smtp-Source: ABdhPJyyAOLiRYOkFNXUu/V/yfEBtasOR7Zxy7ymQyNPgYACGzNKLKDpjaS696+vquRcTymAehgWaQ==
X-Received: by 2002:a05:6000:1681:: with SMTP id y1mr4262487wrd.340.1633603190909;
        Thu, 07 Oct 2021 03:39:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d0b])
        by smtp.gmail.com with ESMTPSA id n14sm10224853wms.0.2021.10.07.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:39:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: remove hal_ops
Date:   Thu,  7 Oct 2021 12:39:42 +0200
Message-Id: <20211007103943.8433-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007103943.8433-1-straube.linux@gmail.com>
References: <20211007103943.8433-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last pointer hal_deinit from struct hal_ops and call
rtl8188eu_hal_deinit() directly. Remove the now empty struct
hal_ops.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c      | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 6 +-----
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/include/hal_intf.h  | 5 +----
 4 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 30ddf174e4df..4e4f4d1c680d 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -31,7 +31,7 @@ uint rtw_hal_deinit(struct adapter *adapt)
 {
 	uint	status = _SUCCESS;
 
-	status = adapt->HalFunc.hal_deinit(adapt);
+	status = rtl8188eu_hal_deinit(adapt);
 
 	if (status == _SUCCESS)
 		adapt->hw_init_completed = false;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 07a29a7cf61d..b4fbbfd0112a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -978,7 +978,7 @@ static void CardDisableRTL8188EU(struct adapter *Adapter)
 	Adapter->bFWReady = false;
 }
 
-static u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
+u32 rtl8188eu_hal_deinit(struct adapter *Adapter)
 {
 
 	DBG_88E("==> %s\n", __func__);
@@ -2133,12 +2133,8 @@ void rtl8188eu_init_default_value(struct adapter *adapt)
 
 void rtl8188eu_set_hal_ops(struct adapter *adapt)
 {
-	struct hal_ops	*halfunc = &adapt->HalFunc;
-
 	adapt->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
 	if (!adapt->HalData)
 		DBG_88E("cant not alloc memory for HAL DATA\n");
 	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
-
-	halfunc->hal_deinit = &rtl8188eu_hal_deinit;
 }
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 6d63429d06c6..2c7f1effee6b 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -228,7 +228,6 @@ struct adapter {
 
 	void *HalData;
 	u32 hal_data_sz;
-	struct hal_ops	HalFunc;
 
 	s32	bDriverStopped;
 	s32	bSurpriseRemoved;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1810197e81f6..c962cd353f43 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -121,10 +121,6 @@ enum hal_odm_variable {
 
 typedef s32 (*c2h_id_filter)(u8 id);
 
-struct hal_ops {
-	u32	(*hal_deinit)(struct adapter *padapter);
-};
-
 #define RF_CHANGE_BY_INIT	0
 #define RF_CHANGE_BY_IPS	BIT(28)
 #define RF_CHANGE_BY_PS		BIT(29)
@@ -175,6 +171,7 @@ uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
 
 u32 rtl8188eu_hal_init(struct adapter *Adapter);
+u32 rtl8188eu_hal_deinit(struct adapter *Adapter);
 
 void rtw_hal_update_ra_mask(struct adapter *padapter, u32 mac_id, u8 level);
 void	rtw_hal_clone_data(struct adapter *dst_adapt,
-- 
2.33.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B9401F99
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244747AbhIFS0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbhIFS0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78913C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r7so10511161edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tDGXKtpZmrXTW/NI9hHWNVg4jLQ4sKJiRKhYqlYVho=;
        b=FaBxzlIxaSIfrMJfo9diJRL42XzNxUCclJ05q/z7H3ymKYNdrnomHCXDSS9qsEQW3Q
         5Bw1dDmQ9gx3rsTRAxmm/b9JjSyWydmmv2fLn8GdGycN+JDLgSEfIlEz3pfigHqX4hrI
         EgrGzLORDq39jCM5vVbwODL6S5xdaX19nNwdaTLrNix1n4AR6m8W1AlCGWdyiMIJe4mj
         PuQjs+vFVxPpxf1Zw/W92s4Q8deY320F9iENruZcvX9B+40E7ryYpWUp172Dy1B4Ckd8
         XISblNa7IEzjvhbjSz1lU8FOFZOiglJK+tmvU42Wzsm07gqD1d4wBvmeGBIX6dcqu+fI
         zZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tDGXKtpZmrXTW/NI9hHWNVg4jLQ4sKJiRKhYqlYVho=;
        b=mRIXRvyV8RYDtIzCGGbqiCrJFy9u8aKXPOGxn434sZ/pd+3JxmtNlPt54kZz5asTeg
         KRnv16S/pZn92ZJ6QB9aqCup4Y7DVcggS+iSI16Wr2nHjceis732eaPJQ6IKXNNPo3LS
         MxuC7QyEsiKVUqxu0ZY7fty2KCADaXm9wnh5bUCYb3gb8aqOPd747eWuTeHpLGoSJtYY
         VXrSUwYsoYl25zy4RQJRqJnZVDQUvW6/I9aLpYDZC5OriUxlFtSFGTHavWbT3zQOYlgz
         qjS2hHj/WjGUK6OuIhys7eWOxBE5c9trJO7uPxpkVZs6oememzHKkIfCBzRop9HIxth7
         tVYA==
X-Gm-Message-State: AOAM531SXXHgfTN/yJdwwS5ZFuAkJY8yqFsVGP3WylNVlFZAGjzSEST2
        RJ7EGgaG8+85aO6htnGzwYw=
X-Google-Smtp-Source: ABdhPJztXwlCwhj/HQrizTF01WNhCnTa0ALa0EkTC+BUonIxuYs6t2Fy+br8Izjhi036xCQ5DRd/cw==
X-Received: by 2002:a05:6402:b7c:: with SMTP id cb28mr14408933edb.152.1630952708101;
        Mon, 06 Sep 2021 11:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/40] staging: r8188eu: remove hal_dm_watchdog from hal_ops
Date:   Mon,  6 Sep 2021 20:24:07 +0200
Message-Id: <20210906182438.5417-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal_dm_watchdog from hal_ops and remove its wrapper
rtw_hal_dm_watchdog(). Call rtl8188e_HalDmWatchDog directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c          | 3 ++-
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 drivers/staging/r8188eu/include/hal_intf.h      | 3 ---
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 738e1ec749be..67b4fe1304a5 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -9,6 +9,7 @@
 #include "../include/mlme_osdep.h"
 #include "../include/rtw_br_ext.h"
 #include "../include/rtw_mlme_ext.h"
+#include "../include/rtl8188e_dm.h"
 
 /*
 Caller and the rtw_cmd_thread can protect cmd_q by spin_lock.
@@ -1496,7 +1497,7 @@ static void dynamic_chk_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
 	linked_status_chk(padapter);
 	traffic_status_watchdog(padapter);
 
-	rtw_hal_dm_watchdog(padapter);
+	rtl8188e_HalDmWatchDog(padapter);
 }
 
 static void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 45166f160756..9374e5ecb13b 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -229,12 +229,6 @@ void rtw_hal_set_chan(struct adapter *adapt, u8 channel)
 		adapt->HalFunc.set_channel_handler(adapt, channel);
 }
 
-void rtw_hal_dm_watchdog(struct adapter *adapt)
-{
-	if (adapt->HalFunc.hal_dm_watchdog)
-		adapt->HalFunc.hal_dm_watchdog(adapt);
-}
-
 void rtw_hal_bcn_related_reg_setting(struct adapter *adapt)
 {
 	if (adapt->HalFunc.SetBeaconRelatedRegistersHandler)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index ca020f2ed7a2..844a18117f09 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1787,8 +1787,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8188E;
 	pHalFunc->set_channel_handler = &PHY_SwChnl8188E;
 
-	pHalFunc->hal_dm_watchdog = &rtl8188e_HalDmWatchDog;
-
 	pHalFunc->Add_RateATid = &rtl8188e_Add_RateATid;
 	pHalFunc->run_thread = &rtl8188e_start_thread;
 	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 44a8943eadfe..caf759a9eb48 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -148,8 +148,6 @@ struct hal_ops {
 				      u8 Offset);
 	void	(*set_channel_handler)(struct adapter *padapter, u8 channel);
 
-	void	(*hal_dm_watchdog)(struct adapter *padapter);
-
 	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
 				   u8 *val);
 	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
@@ -289,7 +287,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 void	rtw_hal_set_bwmode(struct adapter *padapter,
 			   enum ht_channel_width Bandwidth, u8 Offset);
 void	rtw_hal_set_chan(struct adapter *padapter, u8 channel);
-void	rtw_hal_dm_watchdog(struct adapter *padapter);
 
 u8	rtw_hal_antdiv_before_linked(struct adapter *padapter);
 void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
-- 
2.33.0


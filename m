Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DB401FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbhIFS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbhIFS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53794C0617AE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a25so14978949ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWKIkb6qgsNd1sghd+Gu94KZJMj3gN+DQLl2UZMTmdk=;
        b=lRcAPcA6b3ccY6o5bVmDpbWojoIq6LbdvasAZJTTcVWRETUEWHHH9Yz/NC/4lr822M
         gN8hT5VhRmWnRtWkIvoEffDXpS1Ti4zLhB3gmhA/QAFFqtw1KxvZLdh7hGMJCPITdkMO
         Ks1v9XXJpl/KY1mJ17ODz9So6l9o8jH2Arfi3ZE/xj1MZfb4dNjPton2AnilB+J5GvCR
         VmUlBNELFdRJCa28X2L0MGs4H2VPSWs9j7wiJoZjISTGmjPlBYHloSemjl/jnZ5yWCy/
         M8lL8KLeYpLc/gX8pCZXzEsxbonGZXLxizaN30ku0EzgGp+8aO/v8jkJm4EVCGyb6uX3
         OnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWKIkb6qgsNd1sghd+Gu94KZJMj3gN+DQLl2UZMTmdk=;
        b=Q4eejWbSghC7QZPO4lW9hVTGBcrd5E0kDndpZp35PvxauDY3om9KEDjhGOGmMTnZ8+
         IldRE4mSG9xWKKLRT/B+P+M8OirvdEF3XZl9BiUI0Ip17d1B5gAvbKAzq9Rtb/tYKBd4
         w4Q5xUzuxgFcilh2O9NKXoUtQpJfsRCKEoltITzfs+zjmKKhKtjakPsl1p0zdf2miZXb
         TBvYUZirfKC5loeIMrIzlnxJBmVUl3bKVj7ih4yxNao7O5+npFqThWCnlQfd4xC4h67p
         NWRVZAeFWG+uRQMtYZvZ2cjPi0LNdQADNuUWU0t0xX/nEqpzmtZc+VMIvfeiTtCDfAoT
         Zk1w==
X-Gm-Message-State: AOAM531/LsqOtXj2WeUELLNVDplKmRpnqFDBwOnfNUJ6SFBxWxZ8cWWh
        1etrEz/6DdVBLkVAGefuE9o=
X-Google-Smtp-Source: ABdhPJxaYjBpHxfGnFM7wqVs2mO1t7rUnqEYu+MUTJ9mXLabf3HiSuPpQrFbnEfajPbzn1fZLap91w==
X-Received: by 2002:a17:907:2a51:: with SMTP id fe17mr14642315ejc.179.1630952714701;
        Mon, 06 Sep 2021 11:25:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 18/40] staging: r8188eu: remove sreset_xmit_status_check from hal_ops
Date:   Mon,  6 Sep 2021 20:24:16 +0200
Message-Id: <20210906182438.5417-19-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
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


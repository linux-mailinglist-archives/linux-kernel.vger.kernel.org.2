Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5C401257
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 03:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhIFBDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 21:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbhIFBCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:02:24 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC4EC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 18:01:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so3764760wmn.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 18:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svuMkq/iSGidGJwBYySx/N7vsIDaTwSiATHKDu8rmok=;
        b=c1uWKiuZxUZ/13e39ESsBJHBW+SmsCoXZbmHRhGpVUFPH6hSREJUEuyzO3uUj5Tq0p
         G2KKwpHqI3LUHiNPtHRIAmvDq5vzVDjdZ1wxq1WSwJV6QRtUPThdjaCxshDciivHRGoD
         NcXu+h0BzlOPlfyc+GD0GY3KefmNkxuEpp6cVRlwuy+THyVq5+ZcU2kNv48ljIivk7Ar
         L29NPySINsomWZByFrz3K1wqMF4mDlOckI7t5lkPCXQRTmZEQVzZ/LCDX80j4+4pVuuN
         koxMgj1dp4+D3ZX2I/ZRd2ez8fWX+veCaSn1RkQZfW7qDcXUzB0ocGMtDimpTR7gfCpa
         dh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svuMkq/iSGidGJwBYySx/N7vsIDaTwSiATHKDu8rmok=;
        b=MKptC/MsDR+dUnK7ptg6kLSTO7KfbLaE7eurcnrqJrCUgPPyma1rE7OkdodM3/b+MW
         OyIOu3nld6uS5lysxuxbLILb5NFQIYocCnjL6Uj5JQi8su3984VZcDWkqeDHXkw5VIBX
         87J1TS639FzZQcCKxT+ArxNdYrrHbEkibpZ07l66oAJrw8w42FQ+YhdBnhsUDDGcHlwS
         hKt1LZgsnrNBWOPQU3aLUQcjlBiUqFuvnUNyDxmgAtLFOKr4OibwrrHeZty0KUVKFniz
         a9vlQF7DkDha0Wop3MlZjpB4k3pFOh8HIqR9Gwfqq0jot4//RE0876GF3GvpPoXH6lda
         hJMQ==
X-Gm-Message-State: AOAM531z/xyoIqrW2+BkhsEK6r11xne/QYg72hDNlN89THQ7j2Z+naUE
        pkfbOjskwkhtrYyK9duE8ejjtLtbdsJDcA==
X-Google-Smtp-Source: ABdhPJzfPf60rf8BEHnC2ksfbo07SevhySnXq9JqQTb69JO+Y/2sgXY/R//7CYIMR/Y1/vTv3gQR2Q==
X-Received: by 2002:a1c:23d2:: with SMTP id j201mr8722886wmj.163.1630890079490;
        Sun, 05 Sep 2021 18:01:19 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm5151232wrc.26.2021.09.05.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 18:01:19 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 13/14] staging: r8188eu: remove rtw_hal_c2h_id_filter_ccx function
Date:   Mon,  6 Sep 2021 02:01:05 +0100
Message-Id: <20210906010106.898-14-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906010106.898-1-phil@philpotter.co.uk>
References: <20210906010106.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_hal_c2h_id_filter_ccx from hal/hal_intf.c and its one caller
from core/rtw_cmd.c. This function is a wrapper function which returns
the c2h_id_filter_ccx function pointer of struct hal_ops unconditionally.
As this function pointer is never set, and the function call's return
value is subsequently called inside an if condition, this could lead to
an attempt to deference a NULL pointer, which would crash the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     | 9 ++-------
 drivers/staging/r8188eu/hal/hal_intf.c     | 5 -----
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index fee4208dacba..738e1ec749be 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1865,7 +1865,6 @@ static void c2h_wk_callback(struct work_struct *work)
 	struct evt_priv *evtpriv = container_of(work, struct evt_priv, c2h_wk);
 	struct adapter *adapter = container_of(evtpriv, struct adapter, evtpriv);
 	struct c2h_evt_hdr *c2h_evt;
-	c2h_id_filter ccx_id_filter = rtw_hal_c2h_id_filter_ccx(adapter);
 
 	evtpriv->c2h_wk_alive = true;
 
@@ -1895,14 +1894,10 @@ static void c2h_wk_callback(struct work_struct *work)
 			continue;
 		}
 
-		if (ccx_id_filter(c2h_evt->id)) {
-			kfree(c2h_evt);
-		} else {
 #ifdef CONFIG_88EU_P2P
-			/* Enqueue into cmd_thread for others */
-			rtw_c2h_wk_cmd(adapter, (u8 *)c2h_evt);
+		/* Enqueue into cmd_thread for others */
+		rtw_c2h_wk_cmd(adapter, (u8 *)c2h_evt);
 #endif
-		}
 	}
 
 	evtpriv->c2h_wk_alive = false;
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index b4fea82bce87..ac4bbaecf8b0 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -386,8 +386,3 @@ void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
 	if (adapter->HalFunc.hal_notch_filter)
 		adapter->HalFunc.hal_notch_filter(adapter, enable);
 }
-
-c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
-{
-	return adapter->HalFunc.c2h_id_filter_ccx;
-}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 002bcb338cab..6deecbbc284d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -345,7 +345,6 @@ int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 
 void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
 
-c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter);
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
-- 
2.31.1


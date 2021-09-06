Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59E401FEE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244849AbhIFSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbhIFSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167EFC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i21so15112904ejd.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGfAkjZZ48GEEgIScm6nSlR9T8fsWGbKvoUwEaQLs2M=;
        b=Xui5eKILlPhqU71UuFJWcRxsf9aHXMk8pq+9LS7ghDkELAr/M/pWDGf/h7LbM9nEvB
         BHKKFvH5RcePlIGhPnW7dQnt/jpBv6+vih1FspE4HZ7XApEB5KH9Eq4KcjtUuNn4eyPP
         2k8YmPU4HMISECPeJTCV9BEyxaEA8QonBTAa3y1pqbqj9JdJqyEM1qYlW5SnzfhW5BZ/
         gnssaqYT+S1sqPzdu/bUGLRc55e//qG44IsS/dXhe81A7t/1FjJ4aeqN1aA8C+t+LZEm
         NOy5XWwS3u8Rd1Kf6h+3sVPNOS+KxkYhPdEomg0A5VljCjLgJJ60nFWVOoshB2YvLRoo
         v6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGfAkjZZ48GEEgIScm6nSlR9T8fsWGbKvoUwEaQLs2M=;
        b=ksOOACHbWpwa1cGxBvJiaMzYDtfDcCyeov1DHPuefufMrUuwdd8PO6X76vtG7dVXMy
         BPEPYRq+3OljLbs53Nz/5YFKzPvn4455yo0wDCDUg9aRASVOG3Yo0pm4HLl/uGzj6+XN
         VYHQqz53EfT/VEaKvF3REini0UZp/2C72ZheQZdBZERBqHkBl+hOMgTfjncB+njGfj8y
         tdwSDBY7jdSckmKpQfD5TnNxvaIYGYNAuH/8Qx05J7ahC/1Xh98NAKp1DsyQLcXaep6H
         3MbPToPBTRoV7hjHrZhdXbNLIHFo26HFCQcnKMEtEOv8P8sUuixhGyLU3e76uRF/UFap
         GJ+Q==
X-Gm-Message-State: AOAM530OIqP4H5Vt9G7AXueejcAejZiwI4FRVyC6sdDB6sveTetcgJrY
        BTs6fpUPpITkFA/Y8CZdVIw=
X-Google-Smtp-Source: ABdhPJwy8aLQNiybhhj47x1c7TYiNViTPrxczswLgWLW5IZK7p7oZ4hGJxwJVntvme+CoS7EuOje4A==
X-Received: by 2002:a17:906:24c1:: with SMTP id f1mr14973278ejb.314.1630954444623;
        Mon, 06 Sep 2021 11:54:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 03/40] staging: r8188eu: remove dm_init from hal_ops
Date:   Mon,  6 Sep 2021 20:52:50 +0200
Message-Id: <20210906185327.10326-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dm_init from hal_ops and remove its wrapper rtw_hal_dm_init().
Call rtl8188e_init_dm_priv() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 3 ++-
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 3c4c719fe9bc..a3b3dd11ba6e 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -12,12 +12,6 @@ void rtw_hal_free_data(struct adapter *adapt)
 		adapt->HalFunc.free_hal_data(adapt);
 }
 
-void rtw_hal_dm_init(struct adapter *adapt)
-{
-	if (adapt->HalFunc.dm_init)
-		adapt->HalFunc.dm_init(adapt);
-}
-
 void rtw_hal_dm_deinit(struct adapter *adapt)
 {
 	/*  cancel dm  timer */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 09f7bc010ba7..765c8c4321f1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1784,7 +1784,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->dm_init = &rtl8188e_init_dm_priv;
 	pHalFunc->dm_deinit = &rtl8188e_deinit_dm_priv;
 
 	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8188E;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index a3da6e04d481..7d502701be27 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -143,7 +143,6 @@ struct hal_ops {
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
 
-	void	(*dm_init)(struct adapter *padapter);
 	void	(*dm_deinit)(struct adapter *padapter);
 
 	void	(*set_bwmode_handler)(struct adapter *padapter,
@@ -251,7 +250,6 @@ void rtl8188eu_init_default_value(struct adapter *adapt);
 
 void	rtw_hal_free_data(struct adapter *padapter);
 
-void rtw_hal_dm_init(struct adapter *padapter);
 void rtw_hal_dm_deinit(struct adapter *padapter);
 
 u32 rtw_hal_power_on(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 43deffc29833..c5dc02d30349 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -12,6 +12,7 @@
 #include "../include/usb_osintf.h"
 #include "../include/rtw_br_ext.h"
 #include "../include/rtl8188e_led.h"
+#include "../include/rtl8188e_dm.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
@@ -886,7 +887,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	ret8 = rtw_init_default_value(padapter);
 
-	rtw_hal_dm_init(padapter);
+	rtl8188e_init_dm_priv(padapter);
 	rtl8188eu_InitSwLeds(padapter);
 
 	rtw_hal_sreset_init(padapter);
-- 
2.33.0


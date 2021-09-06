Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87785402020
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbhIFTD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243216AbhIFTDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:03:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2319C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g22so10607462edy.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGfAkjZZ48GEEgIScm6nSlR9T8fsWGbKvoUwEaQLs2M=;
        b=G04PZwg5wPM8fpOzxTmZ9/ago02fjLB9SbsxNKjvvuWzYs0cI2iiwfTHbSjiq2pbgh
         frfR6wZmpeoIfDXI8KCmmwDB70A/D9F/5+6bQrUDNvBnuH3c2lTni7vqGaO0m1Qv3dyn
         ypSQalVG7i/aFzjotPlqyRCRwC/nanOhaBoG0lRbKrhBeJc6DPmgduThgjONOSBOo8q/
         Gli1Ib+qfyqsb7Nd+ooCauPg1sM+9L6fBo9KWTNN+U4rdK/KoFTob4Ynfw3UwXaIxsWT
         79cm1w39o+HOQUbYis23qog6BD/yBBn9xZ5PZ+MKn9M3t4vXnaAgLU1LcCP/t77AjSM1
         sTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGfAkjZZ48GEEgIScm6nSlR9T8fsWGbKvoUwEaQLs2M=;
        b=Epqmcp3CsgXcg8GzDhIiJgltoY67xJYIjh8zo0+BTYqyHBV6OQ+v1vvVOndpNkoy+d
         JZlibnm5adHe3ipXqKxLjCmit8f6zB42KTbVk+mEvsf86CixhHYXcPG8LYis2GfPhmmy
         G9IKHzb7T9CmxhdI6ekyPsfumA3O0IUv8yCfbnDTTVHMaUagg/SSnpUXwNmpeLp36QtV
         8u3ZQqtybciyaW1upB+t65igoIcw6WUgfNS4HJQO42cUr/aAuIjO/LkH+eH0yYuGFA1w
         0PTHCAr5DyJHy9Q4lxn0NcUIX70d7rAZxVKmCVld+FtlEOwxgypGFopeqwvyZJAs6ZbZ
         Wo+Q==
X-Gm-Message-State: AOAM531QDgRgx60ygAyk/XSR/cFgcMwk8P5nRlmxyL/OcsXCKI/UfjKm
        Nioo0RYxfaa5VxPhabx94jk=
X-Google-Smtp-Source: ABdhPJzeLOOZYfbnKTXPdrEXtqUI2mz+MJqVlAy7Yo/YmMFXW8QUD6FJLghldXdoEy3Xu2jf3XHOfg==
X-Received: by 2002:a05:6402:2050:: with SMTP id bc16mr14475578edb.92.1630954967535;
        Mon, 06 Sep 2021 12:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 03/40] staging: r8188eu: remove dm_init from hal_ops
Date:   Mon,  6 Sep 2021 21:01:46 +0200
Message-Id: <20210906190223.11396-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
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


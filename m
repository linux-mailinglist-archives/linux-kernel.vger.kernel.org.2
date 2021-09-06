Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4C401FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbhIFS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbhIFS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53184C061796
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eb14so10506483edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvIFJOwmdqhe9fWIYbbg4Sju3/CvE6FlpBQTOPepHeY=;
        b=Zlxg9p3Q9AnTQ4VnSKiWf5gYzI5RmFgkNJBF6wpSWW9vyavQj940jb0t5ADsLzuYa6
         wMMwKdL1bXlx1UO++BaNW0cY5L+Nn3PIZGx6v3Q6/WOEB7AzHeEGUK7WM/37gSUYZdZC
         xuLSVYQZsPfGvjlfnbRyPzS+EjkX1/O1kB+Dq328aKv7CY9LQ5GpPveBTYDdZMzQbpRz
         m3tGKhmQMRbRs3LNReS4D90myeU8LLfFRAkZWHeE/uLRG5EJpJfE8AY69Iw0OttZmCnq
         lU7iEUVck5elBnS8Ndmvm0IHcX9LXCfYAQWfV/qY3MpXCNJsBvmtr9PsS2FGGJNfTyvV
         6vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvIFJOwmdqhe9fWIYbbg4Sju3/CvE6FlpBQTOPepHeY=;
        b=XDB+a81i6sA20tS69v7PTaZ1U/aM7r5WEEo78TFuFGQdiDlkLodTK8HTukavEt6koU
         OWNb+/+DRc8jlBgvAthh1P54GYM+Wl5tf9VZYQmuzlSUxsV6jBXs5gFR6Ee3IfW2EBYZ
         wOoZGlv6/jAu1Jd9QU1wRjZmOT7cN5NCRLvMjdRn4rJSvn9Hvrph07Hz5EiF0x9SBt9+
         VRG7MSPhYtG/kVdRb3f/l86u5ZgIkd8RF1OR3MYVnx35RVl+yXq8uPBgt5Su7kDepZ8J
         HQzwAdzE+81oNBeou4JYBDdvsuvhLczDdXPolEIsacD/ZaW/9AeQTK4wYmJDLwkgecrq
         6TdA==
X-Gm-Message-State: AOAM530II67Ec8TpOo2henk6cAyla4S1vcL0N5AZCqsfdgvXfEMuOQ1+
        kLTonORDevEJEDwSlpP8m3c=
X-Google-Smtp-Source: ABdhPJwoZAqAIxhdfe3OTrJ20OYR8+HarSoTmhX/CUmZ2M09FLZ4Yn2Bwx3p9vOOm1zShBvJGCdjzQ==
X-Received: by 2002:a05:6402:b85:: with SMTP id cf5mr14423934edb.153.1630952712421;
        Mon, 06 Sep 2021 11:25:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:12 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/40] staging: r8188eu: remove sreset_init_value from hal_ops
Date:   Mon,  6 Sep 2021 20:24:13 +0200
Message-Id: <20210906182438.5417-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_init_value from hal_ops and remove its wrapper
rtw_hal_sreset_init(). Call sreset_init_value() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 3 ++-
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 58ece9a1232c..712e497f77ab 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -221,12 +221,6 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
 		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
 }
 
-void rtw_hal_sreset_init(struct adapter *adapt)
-{
-	if (adapt->HalFunc.sreset_init_value)
-		adapt->HalFunc.sreset_init_value(adapt);
-}
-
 void rtw_hal_sreset_reset(struct adapter *adapt)
 {
 	if (adapt->HalFunc.silentreset)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 207fb182ee6c..82de4eaedf1a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,7 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->sreset_init_value = &sreset_init_value;
 	pHalFunc->sreset_reset_value = &sreset_reset_value;
 	pHalFunc->silentreset = &rtl8188e_silentreset_for_specific_platform;
 	pHalFunc->sreset_xmit_status_check = &rtl8188e_sreset_xmit_status_check;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 63842cd469c5..1cc97dcb06bc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	void (*sreset_init_value)(struct adapter *padapter);
 	void (*sreset_reset_value)(struct adapter *padapter);
 	void (*silentreset)(struct adapter *padapter);
 	void (*sreset_xmit_status_check)(struct adapter *padapter);
@@ -274,7 +273,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
 				     struct wlan_bssid_ex *src);
 
-void rtw_hal_sreset_init(struct adapter *padapter);
 void rtw_hal_sreset_reset(struct adapter *padapter);
 void rtw_hal_sreset_reset_value(struct adapter *padapter);
 void rtw_hal_sreset_xmit_status_check(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 039c05ffbc57..333005c13061 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -13,6 +13,7 @@
 #include "../include/rtw_br_ext.h"
 #include "../include/rtl8188e_led.h"
 #include "../include/rtl8188e_dm.h"
+#include "../include/rtw_sreset.h"
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
@@ -890,7 +891,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 	rtl8188e_init_dm_priv(padapter);
 	rtl8188eu_InitSwLeds(padapter);
 
-	rtw_hal_sreset_init(padapter);
+	sreset_init_value(padapter);
 
 	spin_lock_init(&padapter->br_ext_lock);
 
-- 
2.33.0


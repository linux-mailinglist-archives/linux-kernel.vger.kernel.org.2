Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBB540202D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344385AbhIFTFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbhIFTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:04:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17EEC0617AD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:02:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bt14so15153339ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvIFJOwmdqhe9fWIYbbg4Sju3/CvE6FlpBQTOPepHeY=;
        b=oBU3ueicqgU+nUjILJaEEJhQpLSH3qGtpOZp6lkcaych6ImmXlOhdUjTRs2RJrRx98
         S++ObbenHgFGzzkKzhqwAvg/WrxkY0IFpINhimVZHaPPhv+QOBes55DLdrQbbRy050KJ
         WS20tRTsRLokBG5wYRq2EJeUgCz8X/fKSfOpxI0wrJmvFKnftTsa5HPkyW2J0FuoSvzC
         p3DL35+qsiCE1v+tCXDvOIyhfHegqjJum56o9DmB+VrU4I2oFl56aUFFJs0SuJ0tCSZb
         Rq27zMZ2+mnSHQH7iK9jeVqkAmcZOWskdlOsMBhzg20nxg2i+W601JvVsVKwzr1b7loJ
         UhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvIFJOwmdqhe9fWIYbbg4Sju3/CvE6FlpBQTOPepHeY=;
        b=qLi3sScRWSXmLE0GfuTs1GBH1BslgoH14JIeU+8hPOBrc3tYiQFNT0648VF9Smp/OY
         LI7DBMPPeq9gDgSVfnBNsB3BzLdWKjkz07X1qAlZrgkVm6c7oskyExgKhCvtdTt7lxyP
         G2LW4NNX7YC2ZlL0tZ6M+P/wuB5QpcpO1mi+JFR5qKFFGDkDCVDzHl0EeMmgtzgRNHGs
         Q0Wxj59X5a36TTdYH53qvhlTJfF4BlNaoq3hWi4i0UEsJu86gbF4X0B/R5MiZtCVOeoM
         UIbNIIitk6LKyXApqz64githRPC17mhgJlg5OAyXsFiDSn3jMxaFGEBWyoxXnwf3lus9
         i1Tw==
X-Gm-Message-State: AOAM531S59lSsE2N9UHnFusQ2n1EtdOvARqP9RqCChIgVgmoADk/l3Fq
        NdSMWl6HXkj2SxgTyni2d+c=
X-Google-Smtp-Source: ABdhPJytcQKBdQaHYHIWF8iJOBnmH6VCHhu22kZuKchFCiRFwUsjVv67Vd7wQvD7zc1b6YrVDUHSQw==
X-Received: by 2002:a17:906:74d:: with SMTP id z13mr15031545ejb.127.1630954976401;
        Mon, 06 Sep 2021 12:02:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id k15sm4372018ejb.92.2021.09.06.12.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:02:56 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 15/40] staging: r8188eu: remove sreset_init_value from hal_ops
Date:   Mon,  6 Sep 2021 21:01:58 +0200
Message-Id: <20210906190223.11396-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906190223.11396-1-straube.linux@gmail.com>
References: <20210906190223.11396-1-straube.linux@gmail.com>
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


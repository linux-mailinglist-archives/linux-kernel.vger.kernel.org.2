Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B52401FB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245300AbhIFS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244613AbhIFS0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC80C06179A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so10496954edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++7rcOxzBk8va3/DYXrf6o67DHlI7ctJumJgiu/evKA=;
        b=So7pzaAViwPfhFdLmD1v6xf18tVYXGRJctI1GjLyO2uQRzCo1CGfL2jC1d0Rnr/o4g
         0tp9tRLNkCiDLm6nvelf29AOnQFIDEA94Pg72pbldibMtVILaLrPVLdJhkFug8bP12gv
         iz3RCWRAQysrmvUB3OhDh5OkBOVxhx2dZ49rxwGIgpcl2fN95cIGHnWylpHuHMEU/XNd
         4LoU8THgYF6nRzWDUSOh8367rXx6INWNrZ86cM9lMnx+Aa4Xlk59iPTt5oXIdYA9iqId
         13tJ/QYp9iuRxcyBPdOp09jUCqOVcraQUnTJBqyLw4K62cEdVVPYLmboE+71mF83Ls/c
         NIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++7rcOxzBk8va3/DYXrf6o67DHlI7ctJumJgiu/evKA=;
        b=kRoLr19xXe+1ouaGndfA4Slm44AwaidnVDWSkUPrG7pbbmJG/0S/LuhFbuhbtsjjLc
         3Izm/7k5Bia2cx8O4P8NQ10ICvxxkkDsY3aCixCaSYsFyCwrNBsRoWSsMwVJgUByN7IU
         AkSh0K+xwP2WOXQqIvc24c2imQPPm+oFAveKElRd20z77x30c8NzUFCa3MG2wej9gPkW
         m4EK0D5m0GBuWNX179Mw9x6I5PkDxXLTQOiZLs/kSp0tykQUIVrEcfTjl6xowJiLXfoM
         WkPi7NLAw6Nf86GbVZ3htY6qHPmqsNaA9QghHG8km5MCilEwZKahCEUZuUUiXZ7KByTZ
         TptA==
X-Gm-Message-State: AOAM533jQykcn8a6/jkZldZrRxZqCAnCUkyqxguvZACA3vku5C9h/g0x
        DtNTDMalPmnrNEh4nernZSA=
X-Google-Smtp-Source: ABdhPJy5NTQhibXkv2KoRzhyZGWdA3d8kZa1dh+KmhiCt+jiDo+aSjDhRceJIsdmatUaetfK6PgsvQ==
X-Received: by 2002:aa7:cd92:: with SMTP id x18mr14407729edv.325.1630952725703;
        Mon, 06 Sep 2021 11:25:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 33/40] staging: r8188eu: remove AntDivCompareHandler from hal_ops
Date:   Mon,  6 Sep 2021 20:24:31 +0200
Message-Id: <20210906182438.5417-34-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove AntDivCompareHandler hal_ops and remove its wrapper
rtw_hal_antdiv_rssi_compared(). Call AntDivCompare8188E() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c         | 3 ++-
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 --------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 8 --------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d330f58ab3ad..848b1d4bf398 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -14,6 +14,7 @@
 #include "../include/wlan_bssdef.h"
 #include "../include/rtw_ioctl_set.h"
 #include "../include/usb_osintf.h"
+#include "../include/rtl8188e_dm.h"
 
 extern unsigned char	MCS_rate_2R[16];
 extern unsigned char	MCS_rate_1R[16];
@@ -469,7 +470,7 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 	u8 sq_final;
 	long rssi_final;
 
-	rtw_hal_antdiv_rssi_compared(padapter, dst, src); /* this will update src.Rssi, need consider again */
+	AntDivCompare8188E(padapter, dst, src); /* this will update src.Rssi, need consider again */
 
 	/* The rule below is 1/5 for sample value, 4/5 for history value */
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) && is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 1bec02b1dede..e723742dab51 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -206,14 +206,6 @@ void rtw_hal_bcn_related_reg_setting(struct adapter *adapt)
 		adapt->HalFunc.SetBeaconRelatedRegistersHandler(adapt);
 }
 
-void rtw_hal_antdiv_rssi_compared(struct adapter *adapt,
-				  struct wlan_bssid_ex *dst,
-				  struct wlan_bssid_ex *src)
-{
-	if (adapt->HalFunc.AntDivCompareHandler)
-		adapt->HalFunc.AntDivCompareHandler(adapt, dst, src);
-}
-
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 62fd62ced0e5..84449d8111c0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1773,7 +1773,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->run_thread = &rtl8188e_start_thread;
 	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
 
-	pHalFunc->AntDivCompareHandler = &AntDivCompare8188E;
 	pHalFunc->read_bbreg = &rtl8188e_PHY_QueryBBReg;
 	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 929e861cc81b..2c6a3d1f0077 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -156,10 +156,6 @@ struct hal_ops {
 	void	(*run_thread)(struct adapter *adapter);
 	void	(*cancel_thread)(struct adapter *adapter);
 
-	void	(*AntDivCompareHandler)(struct adapter *adapter,
-					struct wlan_bssid_ex *dst,
-					struct wlan_bssid_ex *src);
-
 	s32	(*hal_xmit)(struct adapter *padapter,
 			    struct xmit_frame *pxmitframe);
 	s32 (*mgnt_xmit)(struct adapter *padapter,
@@ -255,10 +251,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
 
-void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
-				     struct wlan_bssid_ex *dst,
-				     struct wlan_bssid_ex *src);
-
 int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 		    u32 max_wating_ms, u32 bndy_cnt);
 
-- 
2.33.0


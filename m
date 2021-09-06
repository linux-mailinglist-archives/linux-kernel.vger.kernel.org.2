Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3250F40200C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbhIFS4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245188AbhIFSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a25so15101379ejv.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/E76js6TBfOzgnGGToEEuG6uYwpd6xQ5NNXwfApcz3s=;
        b=K6S1TDzeJvUbK3rQ5yY1QKW9plPHElJXdeWDkD53sBTkHR5jNRK5suMYU05UWWM3a5
         X9g1QVJFeUKBsASP1s6FBxShaKlYIBrtXqQEyWn22GOG1Cu5+cPThzhdK4hYz/n/TGec
         IwI9t0avsL+tOBk+sFiPGAjYZ+LcmL81yrz1dxNAighVe67OLDfnayw8QM5jSRDxY9Ad
         X6fGXHBL791tni0XUvCJ1Hr9AeWbokwF0Y6kW7r5OrMKYHdXBc1UOYxxs+fV5+kyk4G4
         OlgJeoMBf55s0wAVwgr+vyQ02gUfqJ9CPo5iSlPlyApCbhLLxMHAiJ3GiEp654mpnAc0
         4Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/E76js6TBfOzgnGGToEEuG6uYwpd6xQ5NNXwfApcz3s=;
        b=RNN4vLEw3e/v5Vm//NdJvghEI5Nvg0TeylgE63CqCp9O4xJr/6YcC35sgs2gcomqLE
         v+wxDdoszvio4UJrlfKYghOt7UXUZirR9aL0XGorKnxrPEy5bCcngEsXkFZ+myesEtA5
         g3A1fH3wTcGHjQlMUP80NU1TNroZbAsX8WSQtiO4JhKav9rbT3YJ/4dh708FzihwOsAY
         jVKeaZSBYpprex17yALBpuXatsg3exRq+SthPeUDdWmfKS2bS9BZOztLwg2ajgKg4HPM
         BPg4XfTLY2BGEY3Vzdu0f2R9d2bFYOfXZxQ/eJhNzG64//8Rn1gcoONGODvstYf1VTR9
         gwNw==
X-Gm-Message-State: AOAM5317OU71RkO9KEbVjZXUPntVBCQvgsfX4Rqj222FZ5D+BeM7VYgL
        BOBSKGGH7H+5uMgTmuD95m4=
X-Google-Smtp-Source: ABdhPJx6gVFN15DFikezZAza7b7M5Mr0ZliOAoIrAH8b0FDcgDbnoMYVdH5I8RM6Wod9m+DTMFFYlg==
X-Received: by 2002:a17:906:c52:: with SMTP id t18mr14828029ejf.148.1630954466821;
        Mon, 06 Sep 2021 11:54:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:26 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 33/40] staging: r8188eu: remove AntDivCompareHandler from hal_ops
Date:   Mon,  6 Sep 2021 20:53:20 +0200
Message-Id: <20210906185327.10326-34-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove AntDivCompareHandler from hal_ops and remove its wrapper
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A04401FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbhIFSzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbhIFSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:55:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0EEC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:54:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z19so10579597edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZcdw5/FHSKxoWTT6jITNvbxxtZhx7qTeSob97p9cnI=;
        b=gFF2lpOFLerV4CjjVuKBegI/peDL1FQP0gtrfAa4Nj7krvVdLWi8idBOpIyMupwLsr
         IG/krOkpDLBXOlP1CuFLjyikup+gSC2AwrJ/ycOWLpPRKkAlE0wxPFQLKNq1YvZqhLk2
         jn5bgroCqK6F+1ZVnV8MEFV/cEWr5sbMlR6wKB34f0HmbGj+ryt+7+2djqnqMrPuXLFH
         A2dG+5A2gHSonC5Wz5jttm7dRLYoFPYnwaifGCmQ9Nsyh0qi5Xxjza/nanEZffyuhDqX
         m1kDkEI1n3EkUNRPc+0AceIk7FI8dJCGXmsvf4v7Mbw2PbqZWsb27dQHuBP5AwZW7EkB
         GKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZcdw5/FHSKxoWTT6jITNvbxxtZhx7qTeSob97p9cnI=;
        b=HbmP+HvyTIjBIUDzejP8qy5/0KC5ucSXeUPPlovEM0JhmS7wcQ/DYm/7ot14pAFaQ6
         Iyi1CzcKkcS3bch9WM7KDq2nuvcvp36Kn/tjTM7yHKIJcsFsnviR4XB/3yHZrZQ5z3zj
         gNlyfx8g1G7SL91FDLJq9pu4e9iJ0tz7SxS3FjH531upftyJdgbPYETdAstgWqIJ6f7R
         RGj+/C7P2nn37CUHpBHFEhb7Y+q8Vv0Qq3XnSe/9cPD0pCDw7ac33KeTzmvAIMmryc5H
         KWTEQMuDvDztAcaRvRc4kNkGOQb9ZtVepzl5NBSQEN4RGo38Cv/n1qHOp+qiDnGBpsJk
         MKPA==
X-Gm-Message-State: AOAM531cN0CwDRs6eaYXb6H7yYWHPtMg7PlCEiz8ptJq/G3PzKosKPj6
        vLjJLo4e55eJ9EvrN+c+1Ks=
X-Google-Smtp-Source: ABdhPJwIC6XR3GrW1F+/yKypLz2QZqJ9THIh7oyZRNLmqreeuuu7B9T43EAv2q1NEkaJjf+Qhgk+ew==
X-Received: by 2002:aa7:c44e:: with SMTP id n14mr14686675edr.66.1630954454560;
        Mon, 06 Sep 2021 11:54:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id kk2sm4329128ejc.114.2021.09.06.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:54:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 16/40] staging: r8188eu: remove sreset_reset_value from hal_ops
Date:   Mon,  6 Sep 2021 20:53:03 +0200
Message-Id: <20210906185327.10326-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906185327.10326-1-straube.linux@gmail.com>
References: <20210906185327.10326-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove sreset_reset_value from hal_ops and remove its wrapper
rtw_hal_sreset_reset_value(). Call sreset_reset_value() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c       | 2 +-
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 712e497f77ab..e5267c23ab86 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -227,12 +227,6 @@ void rtw_hal_sreset_reset(struct adapter *adapt)
 		adapt->HalFunc.silentreset(adapt);
 }
 
-void rtw_hal_sreset_reset_value(struct adapter *adapt)
-{
-	if (adapt->HalFunc.sreset_reset_value)
-		adapt->HalFunc.sreset_reset_value(adapt);
-}
-
 void rtw_hal_sreset_xmit_status_check(struct adapter *adapt)
 {
 	if (adapt->HalFunc.sreset_xmit_status_check)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 82de4eaedf1a..222e66656aa9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1803,7 +1803,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->Efuse_PgPacketWrite = &rtl8188e_Efuse_PgPacketWrite;
 	pHalFunc->Efuse_WordEnableDataWrite = &rtl8188e_Efuse_WordEnableDataWrite;
 
-	pHalFunc->sreset_reset_value = &sreset_reset_value;
 	pHalFunc->silentreset = &rtl8188e_silentreset_for_specific_platform;
 	pHalFunc->sreset_xmit_status_check = &rtl8188e_sreset_xmit_status_check;
 	pHalFunc->sreset_linked_status_check  = &rtl8188e_sreset_linked_status_check;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1cc97dcb06bc..946896698655 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -193,7 +193,6 @@ struct hal_ops {
 					     u16 efuse_addr, u8 word_en,
 					     u8 *data, bool bPseudoTest);
 
-	void (*sreset_reset_value)(struct adapter *padapter);
 	void (*silentreset)(struct adapter *padapter);
 	void (*sreset_xmit_status_check)(struct adapter *padapter);
 	void (*sreset_linked_status_check) (struct adapter *padapter);
@@ -274,7 +273,6 @@ void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *src);
 
 void rtw_hal_sreset_reset(struct adapter *padapter);
-void rtw_hal_sreset_reset_value(struct adapter *padapter);
 void rtw_hal_sreset_xmit_status_check(struct adapter *padapter);
 void rtw_hal_sreset_linked_status_check(struct adapter *padapter);
 u8   rtw_hal_sreset_get_wifi_status(struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 333005c13061..28f6028d7335 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -816,7 +816,7 @@ u8 rtw_reset_drv_sw(struct adapter *padapter)
 
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING);
 
-	rtw_hal_sreset_reset_value(padapter);
+	sreset_reset_value(padapter);
 	pwrctrlpriv->pwr_state_check_cnts = 0;
 
 	/* mlmeextpriv */
-- 
2.33.0


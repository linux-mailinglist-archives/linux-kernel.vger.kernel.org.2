Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8014072B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhIJUwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 16:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhIJUv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 16:51:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624AAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z4so4365785wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yF3yOtB0yqHUzFlw5iqMDJ+Yaofiw8C8Ph6FyiLzwB0=;
        b=fyw5YaVsYUnVOfuVl0+bNW0yDsX1Shfryivm+FY8GGKZraM1hW5G/dpWlSUUS3ywe6
         mQmBEAYfY7ObutS5X4c9ozRWJPa8fcUhIT7SDeK3W5/9QxzabXmKNWdL/eHx+nvmEar2
         U68B+8ahyL44mhHYQxn1Ij+n/4ypwRvjNk1/IaQpeMj7aRWgPGEYMTiqpIQTO9Efybgq
         JyM21ds8kUdT1cqJ5CfC955WhiN8t3h2l7Ug43rbWgFLxquJt9s8nw0UChOVGD8Fhj+6
         AoabMtyrsiIPTlT5UvSej1KfFPjqVNMOWBvVszGGmNtleZrhElxWLVRYCfQVKd7TrX1a
         tHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yF3yOtB0yqHUzFlw5iqMDJ+Yaofiw8C8Ph6FyiLzwB0=;
        b=1DCUiiKbtwM0hYHQ/U9/DYcJSCEFLTS5pfAJqheF+XhTsAATukXh+frwihFpftNA81
         G5mdcayKjyPv21S1nsOP6rjEAwsSrHSlKBwzKkCqrIFO0ll9AvhWBUF9FdiX8Yirca8W
         v0JWsg2ETAWmzVcGHHbLVEJAenKDHE99Vqkaemz3uG22j8hk5hAcluRMR73+zodke38B
         XsKpw76QX7vmtzqk/R2jRQxlde6DyBfge/n2wyylTWcesa82R/dotUbGdgLyNsByVXZn
         VmSWIIuhl7FI+R5Uj86fJJbfAadzw8Dq4ido2rbRMwPcwK4w1dk4PbT0QBflgCHjAmsb
         WivA==
X-Gm-Message-State: AOAM53315BgFl7fUqGfztaPEL5iIFfRfUVWAIuD8LCyyB12sIn5Y8A7+
        k+aoBPSGvvq0pDVjdBfP+bg=
X-Google-Smtp-Source: ABdhPJzMpGqYsjeyITxiPjzfWxhb7QzGs3hl+xTa9YhAsxiWJBnrOceoJHa8kxNfr3I2Vp+tLqHQ1A==
X-Received: by 2002:adf:906a:: with SMTP id h97mr3488561wrh.220.1631307046091;
        Fri, 10 Sep 2021 13:50:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id g11sm5592427wrx.30.2021.09.10.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:50:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: r8188eu: remove mgnt_xmit from struct hal_ops
Date:   Fri, 10 Sep 2021 22:50:27 +0200
Message-Id: <20210910205033.3778-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910205033.3778-1-straube.linux@gmail.com>
References: <20210910205033.3778-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove mgnt_xmit from struct hal_ops and its wrapper
rtw_hal_mgnt_xmit(). Call rtl8188eu_mgnt_xmit() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 +++---
 drivers/staging/r8188eu/core/rtw_mp.c       | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c      | 8 --------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c  | 2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c   | 1 -
 drivers/staging/r8188eu/include/hal_intf.h  | 4 ----
 6 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index abbf541618ed..a01e6f822cc0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -4258,7 +4258,7 @@ void dump_mgntframe(struct adapter *padapter, struct xmit_frame *pmgntframe)
 	if (padapter->bSurpriseRemoved || padapter->bDriverStopped)
 		return;
 
-	rtw_hal_mgnt_xmit(padapter, pmgntframe);
+	rtl8188eu_mgnt_xmit(padapter, pmgntframe);
 }
 
 s32 dump_mgntframe_and_wait(struct adapter *padapter, struct xmit_frame *pmgntframe, int timeout_ms)
@@ -4273,7 +4273,7 @@ s32 dump_mgntframe_and_wait(struct adapter *padapter, struct xmit_frame *pmgntfr
 	rtw_sctx_init(&sctx, timeout_ms);
 	pxmitbuf->sctx = &sctx;
 
-	ret = rtw_hal_mgnt_xmit(padapter, pmgntframe);
+	ret = rtl8188eu_mgnt_xmit(padapter, pmgntframe);
 
 	if (ret == _SUCCESS)
 		ret = rtw_sctx_wait(&sctx);
@@ -4294,7 +4294,7 @@ s32 dump_mgntframe_and_wait_ack(struct adapter *padapter, struct xmit_frame *pmg
 	pxmitpriv->ack_tx = true;
 
 	pmgntframe->ack_report = 1;
-	if (rtw_hal_mgnt_xmit(padapter, pmgntframe) == _SUCCESS) {
+	if (rtl8188eu_mgnt_xmit(padapter, pmgntframe) == _SUCCESS) {
 		ret = rtw_ack_tx_wait(pxmitpriv, timeout_ms);
 	}
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 82268f754da0..8b53a460edf8 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -498,7 +498,7 @@ void PhySetTxPowerLevel(struct adapter *pAdapter)
 /*  */
 static void dump_mpframe(struct adapter *padapter, struct xmit_frame *pmpframe)
 {
-	rtw_hal_mgnt_xmit(padapter, pmpframe);
+	rtl8188eu_mgnt_xmit(padapter, pmpframe);
 }
 
 static struct xmit_frame *alloc_mp_xmitframe(struct xmit_priv *pxmitpriv)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index ee92af81ea05..98f33747c680 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -96,14 +96,6 @@ s32 rtw_hal_xmit(struct adapter *adapt, struct xmit_frame *pxmitframe)
 	return false;
 }
 
-s32 rtw_hal_mgnt_xmit(struct adapter *adapt, struct xmit_frame *pmgntframe)
-{
-	s32 ret = _FAIL;
-	if (adapt->HalFunc.mgnt_xmit)
-		ret = adapt->HalFunc.mgnt_xmit(adapt, pmgntframe);
-	return ret;
-}
-
 s32 rtw_hal_init_xmit_priv(struct adapter *adapt)
 {
 	if (adapt->HalFunc.init_xmit_priv)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index f5268d295278..6cdc2e40aad4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -561,7 +561,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	pattrib->pktlen = pattrib->last_txcmdsz;
 	memcpy(pmgntframe->buf_addr, ReservedPagePacket, TotalPacketLen);
 
-	rtw_hal_mgnt_xmit(adapt, pmgntframe);
+	rtl8188eu_mgnt_xmit(adapt, pmgntframe);
 
 	DBG_88E("%s: Set RSVD page location to Fw\n", __func__);
 	FillH2CCmd_88E(adapt, H2C_COM_RSVD_PAGE, sizeof(RsvdPageLoc), (u8 *)&RsvdPageLoc);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index c5347c5459d6..4b732efeef39 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -2229,7 +2229,6 @@ void rtl8188eu_set_hal_ops(struct adapter *adapt)
 	halfunc->SetHalDefVarHandler = &SetHalDefVar8188EUsb;
 
 	halfunc->hal_xmit = &rtl8188eu_hal_xmit;
-	halfunc->mgnt_xmit = &rtl8188eu_mgnt_xmit;
 
 	rtl8188e_set_hal_ops(halfunc);
 }
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index c1e120593574..d50dc2554d61 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -149,8 +149,6 @@ struct hal_ops {
 
 	s32	(*hal_xmit)(struct adapter *padapter,
 			    struct xmit_frame *pxmitframe);
-	s32 (*mgnt_xmit)(struct adapter *padapter,
-			 struct xmit_frame *pmgntframe);
 
 	u32	(*read_bbreg)(struct adapter *padapter, u32 RegAddr,
 			      u32 BitMask);
@@ -218,8 +216,6 @@ u32	rtw_hal_inirp_init(struct adapter *padapter);
 u32	rtw_hal_inirp_deinit(struct adapter *padapter);
 
 s32	rtw_hal_xmit(struct adapter *padapter, struct xmit_frame *pxmitframe);
-s32	rtw_hal_mgnt_xmit(struct adapter *padapter,
-			  struct xmit_frame *pmgntframe);
 
 s32	rtw_hal_init_xmit_priv(struct adapter *padapter);
 
-- 
2.33.0


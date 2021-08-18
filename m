Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9373F0ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbhHRXtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbhHRXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:49:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3A1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v4so6006866wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hc/AjRtYf53PrsXKf9Go/RtxM0gmE52yZYa9qXr7rjM=;
        b=X00iRnXV7mCjkYVVEAaX0o32GqoQt58VLe9BBga7PJgR2n3V62khs9nMOt9L/ZHLKK
         /39CZAGpJZhS46QIj8+ytJOK91RB4fqrIUvI5Xx8bQ4NPR0NIGTUCp5+vc5UVPL1xd2b
         S9e+4CU3sq9QIqQFD0fiMXEZDvzFd7U/VRmwSoWkCm+IPvInmdciZHVEed7X8NR76wsb
         UZ10uZxhP8b+E7G7u8PLsZpZ/lMFJ5VssOLjVZPBaStil0i04aV+unas9pzUP7rTo4Yb
         +Zyfi9ZdzRJqr1rX5WuK5wQkVOlxpTt3T8PVrhvL/u1Y4TTY906mlKvt65HCzubmpM8h
         nL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hc/AjRtYf53PrsXKf9Go/RtxM0gmE52yZYa9qXr7rjM=;
        b=kNJzniKWbrtWHUghFKFFX8wWYzKQ7+C4TOo3eMmCkLOdLxzj8nu7I7ttkIoPKt09Yl
         a5y88KytzzziJpDZQoHuHvqGLkTFdqdTfAJHxgR6Wo9TDM7t7sjjTTKgbeXB3scfQpMS
         t9CioEv72Y/p932HcDgktk1wCrSwpn38Sf6WsnongZnLd1Qz9+tVozvWf9CMgDIHYOUr
         886HCVRwX130NAkcBFkPViE9mGCcJ1sZS0FP6pmQaOfb4+/lNxmvti627tqGwORJ9HT5
         fZ+Ys5bEuElXrd9O118gixuPLiuoPinkWdLGZOgAAa2ZGLKpFcovmivzn9LlbQN8T/Iz
         3ZrQ==
X-Gm-Message-State: AOAM531GHqebhSMyW+77e8NODux0iaCJx/i5P2ghI2IqIQ7bh7y5eOAg
        39pcXJ5iu0e2GU/8/s4Vfm30vw==
X-Google-Smtp-Source: ABdhPJxzTpM52DRhfqtay6EcrmH5Q0PNWXmbgXenCmeQI319KzgZuLmdb2NrPhX5X8F71AA9rYeCzg==
X-Received: by 2002:adf:e845:: with SMTP id d5mr75860wrn.228.1629330538330;
        Wed, 18 Aug 2021 16:48:58 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1205916wrt.77.2021.08.18.16.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:48:57 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 4/7] staging: r8188eu: convert all rtw_zvmalloc calls to vzalloc calls
Date:   Thu, 19 Aug 2021 00:48:50 +0100
Message-Id: <20210818234853.208448-5-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234853.208448-1-phil@philpotter.co.uk>
References: <20210818234853.208448-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all rtw_zvmalloc calls within the driver to use the existing
kernel vzalloc function, which has the same semantics. Also rewrite the
two places where it is mentioned in comments to say vzalloc, and remove
the redundant cast to struct adapter * in ./os_dep/usb_intf.c as vzalloc
returns void *.

The reason for the conversion is that rtw_zvmalloc is just a
preprocessor definition for _rtw_zvmalloc which itself is just an inline
wrapper around vmalloc which then zeroes the memory out. As vzalloc does
the same thing via usage of __GFP_ZERO, this code is redundant and can
subsequently be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme.c         | 4 ++--
 drivers/staging/r8188eu/core/rtw_mp.c           | 2 +-
 drivers/staging/r8188eu/core/rtw_recv.c         | 2 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c      | 2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c         | 8 ++++----
 drivers/staging/r8188eu/hal/odm_interface.c     | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 2 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c       | 2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 858a582e674f..c41312660054 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -38,7 +38,7 @@ int _rtw_init_mlme_priv(struct adapter *padapter)
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	int	res = _SUCCESS;
 
-	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by rtw_zvmalloc(). */
+	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
 	pmlmepriv->nic_hdl = (u8 *)padapter;
 
@@ -55,7 +55,7 @@ int _rtw_init_mlme_priv(struct adapter *padapter)
 
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 
-	pbuf = rtw_zvmalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
+	pbuf = vzalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
 
 	if (!pbuf) {
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 07d9245fa05f..93bb683b628f 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -930,7 +930,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 	/*  Init xmit extension buff */
 	_rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
 
-	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
+	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 0e137aee0aa4..52236bae8693 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -58,7 +58,7 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	rtw_os_recv_resource_init(precvpriv, padapter);
 
-	precvpriv->pallocated_frame_buf = rtw_zvmalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
+	precvpriv->pallocated_frame_buf = vzalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
 
 	if (!precvpriv->pallocated_frame_buf) {
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 9628d095a487..f6dffed53a60 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -60,7 +60,7 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	struct sta_info *psta;
 	s32 i;
 
-	pstapriv->pallocated_stainfo_buf = rtw_zvmalloc(sizeof(struct sta_info) * NUM_STA + 4);
+	pstapriv->pallocated_stainfo_buf = vzalloc(sizeof(struct sta_info) * NUM_STA + 4);
 
 	if (!pstapriv->pallocated_stainfo_buf)
 		return _FAIL;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 69f997f44c07..e1de7448771c 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -46,7 +46,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	u32 max_xmit_extbuf_size = MAX_XMIT_EXTBUF_SZ;
 	u32 num_xmit_extbuf = NR_XMIT_EXTBUFF;
 
-	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by rtw_zvmalloc(). */
+	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
 	spin_lock_init(&pxmitpriv->lock);
 	sema_init(&pxmitpriv->xmit_sema, 0);
@@ -72,7 +72,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	Please also apply  free_txobj to link_up all the xmit_frames...
 	*/
 
-	pxmitpriv->pallocated_frame_buf = rtw_zvmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
+	pxmitpriv->pallocated_frame_buf = vzalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
 
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
@@ -109,7 +109,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	_rtw_init_queue(&pxmitpriv->free_xmitbuf_queue);
 	_rtw_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 
-	pxmitpriv->pallocated_xmitbuf = rtw_zvmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
+	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
@@ -150,7 +150,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	/*  Init xmit extension buff */
 	_rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
 
-	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
+	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 239a9703bb34..5a01495d74bc 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -79,7 +79,7 @@ u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32
 /*  ODM Memory relative API. */
 void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length)
 {
-	*pPtr = rtw_zvmalloc(length);
+	*pPtr = vzalloc(length);
 }
 
 /*  length could be ignored, used to detect memory leakage. */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 78e58f9150f3..393969f51206 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -341,7 +341,7 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 	u32 fifo_data, reg_140;
 	u32 addr, rstatus, loop = 0;
 	u16 data_cnts = (data_len / 8) + 1;
-	u8 *pbuf = rtw_zvmalloc(data_len + 10);
+	u8 *pbuf = vzalloc(data_len + 10);
 	DBG_88E("###### %s ######\n", __func__);
 
 	rtw_write8(Adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 800f493f1000..8a797bfcb7f5 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -152,7 +152,7 @@ struct net_device *rtw_alloc_etherdev(int sizeof_priv)
 
 	pnpi = netdev_priv(pnetdev);
 
-	pnpi->priv = rtw_zvmalloc(sizeof_priv);
+	pnpi->priv = vzalloc(sizeof_priv);
 	if (!pnpi->priv) {
 		free_netdev(pnetdev);
 		pnetdev = NULL;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 0f28ed77ef65..e002070f7fba 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -569,7 +569,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	struct net_device *pnetdev = NULL;
 	int status = _FAIL;
 
-	padapter = (struct adapter *)rtw_zvmalloc(sizeof(*padapter));
+	padapter = vzalloc(sizeof(*padapter));
 	if (!padapter)
 		goto exit;
 	padapter->dvobj = dvobj;
-- 
2.31.1


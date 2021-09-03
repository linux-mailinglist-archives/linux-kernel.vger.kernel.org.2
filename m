Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A00E4005DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbhICTfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhICTfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:35:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B5C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:34:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s10so324715lfr.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peCcaeM8c7cWLf96b5sbNnvu2tAd4n6WEj9yJgkNbbU=;
        b=q1ylvYlUEdtmJD4xxyE+w6T5vzJsfuBKW6GkML/+Clfg3PGqAN10vCGcuxNFG07HRC
         wvbwjJcduCsHLFQmJXGnvJxYnbwAZU1R2w1NpOh9HYFgIjMt2MMaoJNwLDRVnUmbe9Cu
         12bHdWe8mXiqxt4ofeE/by0U8nYyaMjsMUn2cE2Y8/Dx6KP0pFORbp6THFi0bNyQJkUS
         y0Rir8gx/vXgNMZaRAX5Yy+soPk1URos+8prDeVWM3sn7W0fKcCnXtGCsmcP91wdkVX9
         rUxwNZcbhdN+Xtc1n+hDHJbsFblk2RJUdethBBNOWnxeOOUOUDFmV6zu1LfujSrp9T1e
         qayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peCcaeM8c7cWLf96b5sbNnvu2tAd4n6WEj9yJgkNbbU=;
        b=mTSNhWbYq9Iw4wgqYdQSFQOEVBHuOMC3udMmKbNlKxrFLfBkyDgrbtyEIaqwX/DdeZ
         KfvN4tsx49A9yKfFw++vfTiXVOfjSaeCF/A351hUZMkl9hhkUwkSeqfEtAeNPb49DNsR
         +ZKtbsIXKtukeOOEb9Dnd2msP5XANLf0pfMe+xCafQ3DGmkEOqeOD7SA8oYFM726jmev
         JsPlVpKqTy/OlWeOlla0g9l7Mwl4uSm8r7eDJukWLwJqJvCN2nZVDQ9xclpsisR7HIFA
         hDP26NX5OCPMAVo9v74Va1+rYnL0uk1AYSn5V3DGQr91Y0k4wcgz3G5lQmHEHeJT9vj/
         7TWw==
X-Gm-Message-State: AOAM530HouMhsERkVCW90ddo8CEKoT1QY45FefL/CONQPnpreHYFXqbJ
        g6Z2TQ3QRooghHESMOhGl3oPeOnC95OXJsUq
X-Google-Smtp-Source: ABdhPJzdV2ZH+K0hm46Sc+1sz+EDe0iD3QZWgYC3PnIe4mxqL1178AfV6a1yV0IBivFpw4IP9zEV9g==
X-Received: by 2002:a05:6512:3d19:: with SMTP id d25mr338983lfv.549.1630697643877;
        Fri, 03 Sep 2021 12:34:03 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id j13sm31914lfu.214.2021.09.03.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:34:03 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: remove _rtw_mutex_{init,free}
Date:   Fri,  3 Sep 2021 22:33:56 +0300
Message-Id: <20210903193356.31927-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing Fabio's patch I hit lockdep warning about possible
deadlock:

[  252.063305] WARNING: possible recursive locking detected
[  252.063642] 5.14.0+ #9 Tainted: G         C
[  252.063946] --------------------------------------------
[  252.064282] ip/335 is trying to acquire lock:
[  252.064560] ffff888009ebad28 (pmutex){+.+.}-{4:4}, at: usbctrl_vendorreq+0xc5/0x4a0 [r8188eu]
[  252.065168]
[  252.065168] but task is already holding lock:
[  252.065536] ffffffffc021b3b8 (pmutex){+.+.}-{4:4}, at:  netdev_open+0x3a/0x5f [r8188eu]
[  252.066085]
[  252.066085] other info that might help us debug this:
[  252.066494]  Possible unsafe locking scenario:
[  252.066494]
[  252.066866]        CPU0
[  252.067025]        ----
[  252.067184]   lock(pmutex);
[  252.067367]   lock(pmutex);

There is one problem with this warning: there is no pmutex in this
driver, *BUT* all mutexes are initialized via private _rtw_mutex_init
API, which had struct mutex *pmutex argument.

So, all mutexes in this driver had same name in lockdep map. Of course,
lockdep will complain about any nested locking.

Fix it by open-coding _rtw_mutex_{init,free} wrappers, because we do not
need them at all.

Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sreset.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c         |  4 ++--
 drivers/staging/r8188eu/include/osdep_service.h |  2 --
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 10 ----------
 drivers/staging/r8188eu/os_dep/usb_intf.c       |  8 ++++----
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sreset.c b/drivers/staging/r8188eu/core/rtw_sreset.c
index c831033d20a9..1787c2d7ea5f 100644
--- a/drivers/staging/r8188eu/core/rtw_sreset.c
+++ b/drivers/staging/r8188eu/core/rtw_sreset.c
@@ -8,7 +8,7 @@ void sreset_init_value(struct adapter *padapter)
 	struct hal_data_8188e	*pHalData = GET_HAL_DATA(padapter);
 	struct sreset_priv *psrtpriv = &pHalData->srestpriv;
 
-	_rtw_mutex_init(&psrtpriv->silentreset_mutex);
+	mutex_init(&psrtpriv->silentreset_mutex);
 	psrtpriv->silent_reset_inprogress = false;
 	psrtpriv->wifi_error_status = WIFI_STATUS_SUCCESS;
 	psrtpriv->last_tx_time = 0;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index bcc4d65cdcee..875d1bf1679c 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -196,7 +196,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->voq_cnt = 0;
 
 	pxmitpriv->ack_tx = false;
-	_rtw_mutex_init(&pxmitpriv->ack_tx_mutex);
+	mutex_init(&pxmitpriv->ack_tx_mutex);
 	rtw_sctx_init(&pxmitpriv->ack_tx_ops, 0);
 
 	rtw_hal_init_xmit_priv(padapter);
@@ -243,7 +243,7 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 
 	rtw_free_hwxmits(padapter);
 
-	_rtw_mutex_free(&pxmitpriv->ack_tx_mutex);
+	mutex_destroy(&pxmitpriv->ack_tx_mutex);
 }
 
 static void update_attrib_vcs_info(struct adapter *padapter, struct xmit_frame *pxmitframe)
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 029aa4e92c9b..05bac61c3a19 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -155,8 +155,6 @@ extern unsigned char RSN_TKIP_CIPHER[4];
 void *rtw_malloc2d(int h, int w, int size);
 
 u32  _rtw_down_sema(struct semaphore *sema);
-void _rtw_mutex_init(struct mutex *pmutex);
-void _rtw_mutex_free(struct mutex *pmutex);
 
 void _rtw_init_queue(struct __queue *pqueue);
 
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 95ac6086370b..4328992907f2 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -67,16 +67,6 @@ u32 _rtw_down_sema(struct semaphore *sema)
 		return _SUCCESS;
 }
 
-void	_rtw_mutex_init(struct mutex *pmutex)
-{
-	mutex_init(pmutex);
-}
-
-void	_rtw_mutex_free(struct mutex *pmutex)
-{
-	mutex_destroy(pmutex);
-}
-
 void	_rtw_init_queue(struct __queue *pqueue)
 {
 	INIT_LIST_HEAD(&pqueue->queue);
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index bb85ab77fd26..8a981a30ea1f 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -116,7 +116,7 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 {
 	u8 rst = _SUCCESS;
 
-	_rtw_mutex_init(&dvobj->usb_vendor_req_mutex);
+	mutex_init(&dvobj->usb_vendor_req_mutex);
 
 	dvobj->usb_alloc_vendor_req_buf = kzalloc(MAX_USB_IO_CTL_SIZE, GFP_KERNEL);
 	if (!dvobj->usb_alloc_vendor_req_buf) {
@@ -132,7 +132,7 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
 static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
 {
 	kfree(dvobj->usb_alloc_vendor_req_buf);
-	_rtw_mutex_free(&dvobj->usb_vendor_req_mutex);
+	mutex_destroy(&dvobj->usb_vendor_req_mutex);
 }
 
 static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
@@ -760,7 +760,7 @@ static int __init rtw_drv_entry(void)
 {
 	DBG_88E(DRV_NAME " driver version=%s\n", DRIVERVERSION);
 
-	_rtw_mutex_init(&usb_drv->hw_init_mutex);
+	mutex_init(&usb_drv->hw_init_mutex);
 
 	usb_drv->drv_registered = true;
 	return usb_register(&usb_drv->usbdrv);
@@ -773,7 +773,7 @@ static void __exit rtw_drv_halt(void)
 	usb_drv->drv_registered = false;
 	usb_deregister(&usb_drv->usbdrv);
 
-	_rtw_mutex_free(&usb_drv->hw_init_mutex);
+	mutex_destroy(&usb_drv->hw_init_mutex);
 	DBG_88E("-rtw_drv_halt\n");
 }
 
-- 
2.33.0


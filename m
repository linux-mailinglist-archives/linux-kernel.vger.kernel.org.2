Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68BF400B64
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhIDMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhIDMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:48:57 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E2C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:47:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k13so3919499lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uFT/AySo/zccMbK2kvcH3TQnn4RaVKtWcnFWmGCOV10=;
        b=Gfs/BDDV/RxhY+rktK1VaxsTtCOKQaZFlmESdWuXDffNt763ixqWkm0ZVvUEg6PHsj
         8eNgRT3gA9Ly1T2hL0rkqx1ROW/1+wA4JklbcACO6u1ek5PTXDutHzZuA9cAo9S/5y3L
         477qxJdb2sCrW8bSWHMCplajvWMcjC1u2GqGBsLkeRcvmO6Qvlqf19Kk/Ux5d9zER/LX
         r1K8Uo3I50hL2Kqt27O80taD9sxN4vtV7b5TawKVKO96k0lylqkJ0K4+dT98NSsjsNdk
         iZj0R6R+JAj7VsNkSJV3ZFYh23wHo4HC7dJI5Of5mopFBIpsmN/bJ6aK6qYn9Yor+ml5
         jAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFT/AySo/zccMbK2kvcH3TQnn4RaVKtWcnFWmGCOV10=;
        b=bumVl9g0ntSjeyy3tvi9oH+HTwMqnpMDt2+3nVPnNKFniCQPMvE5JUFXVe34txrnFZ
         hFU25Hkd14ZN+DYxnRDLUv31e3vY1VUuIBuJXYRrd7bFj2HLUqpiwojj8QqboVUGYT2g
         efreIvSgTUcChFFTl0EuLRQAFh3VQnzzP29nUb/FgPFvHbZ0lssCJAZIOOPKYV2S4dcU
         xH7xq4L9s7VP9Y8fznXdyKL1ZSLvmaQQ/ea1kVInT3UGBhVBY9+pvd+2Xuk1HC9nJT1I
         VLiXTfoGz+DmyZdl9+Kk6BwnW1yV5xfp8tJcM/PEyC0LJVanhkZ/NZQuLtcHf4ovm2Bp
         0wRA==
X-Gm-Message-State: AOAM532y5DqG+NEMuxDvQOr78ehqa8wyti8CXUHsYP+AOXJ1vmx5/RoM
        Vj65Ylrpgj9GHyYTQ8noe5Tqe5+ZDQE5OQ==
X-Google-Smtp-Source: ABdhPJy8WLdZA1Rfh8zTvfMH+hnILpyNtJkHeYyHwzVvl+k4vQlIRvNbUHU289sPDe8G0jLg7OV4Jw==
X-Received: by 2002:a05:6512:c3:: with SMTP id c3mr2957853lfp.364.1630759673536;
        Sat, 04 Sep 2021 05:47:53 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id bi38sm235212lfb.11.2021.09.04.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:47:53 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2] staging: r8188eu: remove _rtw_mutex_{init,free}
Date:   Sat,  4 Sep 2021 15:47:47 +0300
Message-Id: <20210904124747.30050-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YTMhcMSqWCepQMMT@kroah.com>
References: <YTMhcMSqWCepQMMT@kroah.com>
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
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes in v2:
	Removed Fixes tag (suggested by Greg)

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
index 46fe62c7c32c..bbb9889c4b89 100644
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


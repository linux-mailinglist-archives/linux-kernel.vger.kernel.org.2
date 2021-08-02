Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571B3DE004
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhHBT1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhHBT1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:27:47 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC1FC061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:27:37 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u10so25364345oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBbLHPhZ18bzPWo02CdFqnHqISrb5NOz6HLB+bg+dnU=;
        b=i//q+R+qnPajXGIWxR0PulC2FkZ1YN+ZLpGhZd+OKA3oUCKKRyq6/PbXXBUCgzctVW
         v22XT1uoOg2F6CuYyTLI/PnkzKo5Gge4GY0rOuKOfXLdV4Gd1BRJ3w1QtGAa2U4k866z
         bifepIFAsiZVfy/4m7LFMq+IbE/qaFFxHKRjvBr2dWe5z7th9F2oO54OJbfvyG/yKMF8
         2bdMyeC4MPJn0OHHlhGHBlkauwRljI3Lr7j6iFN84Iwf/KjvH+vbdswQCOeUgFzMbFOR
         D8x4cf0QdAd1vpEd1n0ZB72lv0BjYxRpv88Yjg2d3QPMow/gdd9xx/l9c9FiYJ5BynLx
         2Gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FBbLHPhZ18bzPWo02CdFqnHqISrb5NOz6HLB+bg+dnU=;
        b=TLmbG/2RMQykm1fZXc2vV3kviO681KSAWjReyZeTYMkYQrfOorcwdiD/B41VbrcMGi
         wWK+TGS3MkGQQ4QVZAT7hjluB7h/VQ7drNh7h7vvTtfOgxCywTUepJbr9ZTM68D85Skr
         4QEbg27UbAlfppw9Wnach4hTDNCOYGWcdqL9ZK4ySY05yVLWpe7Kg5hexwa30IUOZjJu
         g+Eah14Yetnkrk1WIWeoeJvJf3dufpNXDB042bVFoZrDkkA5OvvuWiJwWh68x/sjfiDZ
         e7BiRoPPf5hpDxRitKW7m+GWVDMn8zpNLh9W3+en9LJYtlYi10WFBT/C+ifOARy0O5JN
         qwLQ==
X-Gm-Message-State: AOAM530OP5t40sDm6FMRDTuvaDp9I34DN7ZMRuA1hSXwuH7HINgcsK61
        Q/AX2+KYhITGgwywL8/16v8=
X-Google-Smtp-Source: ABdhPJzIJsIvsWUkzT1yw/gBl+raeHLkPZ+++BHaiHkiK4SfvzaIpRe7HakDszUClTTyGnnbdEsY8w==
X-Received: by 2002:aca:fdc1:: with SMTP id b184mr11762639oii.101.1627932457228;
        Mon, 02 Aug 2021 12:27:37 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id i188sm1981035oih.7.2021.08.02.12.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:27:36 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 5/6] staging: r8188eu: Remove all calls to _rtw_spinlock_free()
Date:   Mon,  2 Aug 2021 14:27:20 -0500
Message-Id: <20210802192721.23110-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
References: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is empty, thus all calls to it can be removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no change
---
 drivers/staging/r8188eu/core/rtw_cmd.c        |  3 --
 drivers/staging/r8188eu/core/rtw_mlme.c       |  3 --
 drivers/staging/r8188eu/core/rtw_recv.c       |  5 ----
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 28 -------------------
 drivers/staging/r8188eu/core/rtw_xmit.c       | 14 ----------
 .../staging/r8188eu/include/osdep_service.h   |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 --
 .../staging/r8188eu/os_dep/osdep_service.c    |  4 ---
 8 files changed, 60 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 35222a10b10c..566b4e04a3ee 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -96,15 +96,12 @@ void _rtw_free_cmd_priv (struct	cmd_priv *pcmdpriv)
 {
 
 	if (pcmdpriv) {
-		_rtw_spinlock_free(&(pcmdpriv->cmd_queue.lock));
-
 		if (pcmdpriv->cmd_allocated_buf)
 			kfree(pcmdpriv->cmd_allocated_buf);
 
 		if (pcmdpriv->rsp_allocated_buf)
 			kfree(pcmdpriv->rsp_allocated_buf);
 	}
-
 }
 
 /*
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c3763d9e448a..2b8f6b4388e1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -87,9 +87,6 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 
 static void rtw_mfree_mlme_priv_lock (struct mlme_priv *pmlmepriv)
 {
-	_rtw_spinlock_free(&pmlmepriv->lock);
-	_rtw_spinlock_free(&(pmlmepriv->free_bss_pool.lock));
-	_rtw_spinlock_free(&(pmlmepriv->scanned_queue.lock));
 }
 
 #if defined (CONFIG_88EU_AP_MODE)
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 08e095cd08b8..a4cb08d41b8c 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -98,11 +98,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 static void rtw_mfree_recv_priv_lock(struct recv_priv *precvpriv)
 {
-	_rtw_spinlock_free(&precvpriv->lock);
-	_rtw_spinlock_free(&precvpriv->free_recv_queue.lock);
-	_rtw_spinlock_free(&precvpriv->recv_pending_queue.lock);
-
-	_rtw_spinlock_free(&precvpriv->free_recv_buf_queue.lock);
 }
 
 void _rtw_free_recv_priv (struct recv_priv *precvpriv)
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 3b1a6a689d95..29df34fd74f1 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -130,32 +130,16 @@ inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int
 void	_rtw_free_sta_xmit_priv_lock(struct sta_xmit_priv *psta_xmitpriv);
 void	_rtw_free_sta_xmit_priv_lock(struct sta_xmit_priv *psta_xmitpriv)
 {
-
-	_rtw_spinlock_free(&psta_xmitpriv->lock);
-
-	_rtw_spinlock_free(&(psta_xmitpriv->be_q.sta_pending.lock));
-	_rtw_spinlock_free(&(psta_xmitpriv->bk_q.sta_pending.lock));
-	_rtw_spinlock_free(&(psta_xmitpriv->vi_q.sta_pending.lock));
-	_rtw_spinlock_free(&(psta_xmitpriv->vo_q.sta_pending.lock));
-
 }
 
 static void	_rtw_free_sta_recv_priv_lock(struct sta_recv_priv *psta_recvpriv)
 {
-
-	_rtw_spinlock_free(&psta_recvpriv->lock);
-
-	_rtw_spinlock_free(&(psta_recvpriv->defrag_q.lock));
-
 }
 
 void rtw_mfree_stainfo(struct sta_info *psta);
 void rtw_mfree_stainfo(struct sta_info *psta)
 {
 
-	if (&psta->lock != NULL)
-		 _rtw_spinlock_free(&psta->lock);
-
 	_rtw_free_sta_xmit_priv_lock(&psta->sta_xmitpriv);
 	_rtw_free_sta_recv_priv_lock(&psta->sta_recvpriv);
 
@@ -188,18 +172,6 @@ static void rtw_mfree_sta_priv_lock(struct sta_priv *pstapriv)
 #endif
 
 	 rtw_mfree_all_stainfo(pstapriv); /* be done before free sta_hash_lock */
-
-	_rtw_spinlock_free(&pstapriv->free_sta_queue.lock);
-
-	_rtw_spinlock_free(&pstapriv->sta_hash_lock);
-	_rtw_spinlock_free(&pstapriv->wakeup_q.lock);
-	_rtw_spinlock_free(&pstapriv->sleep_q.lock);
-
-#ifdef CONFIG_88EU_AP_MODE
-	_rtw_spinlock_free(&pstapriv->asoc_list_lock);
-	_rtw_spinlock_free(&pstapriv->auth_list_lock);
-	_rtw_spinlock_free(&pacl_list->acl_node_q.lock);
-#endif
 }
 
 u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 87aa45c0305a..60cb91d1057a 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -212,17 +212,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 static void  rtw_mfree_xmit_priv_lock (struct xmit_priv *pxmitpriv)
 {
-	_rtw_spinlock_free(&pxmitpriv->lock);
-
-	_rtw_spinlock_free(&pxmitpriv->be_pending.lock);
-	_rtw_spinlock_free(&pxmitpriv->bk_pending.lock);
-	_rtw_spinlock_free(&pxmitpriv->vi_pending.lock);
-	_rtw_spinlock_free(&pxmitpriv->vo_pending.lock);
-	_rtw_spinlock_free(&pxmitpriv->bm_pending.lock);
-
-	_rtw_spinlock_free(&pxmitpriv->free_xmit_queue.lock);
-	_rtw_spinlock_free(&pxmitpriv->free_xmitbuf_queue.lock);
-	_rtw_spinlock_free(&pxmitpriv->pending_xmitbuf_queue.lock);
 }
 
 void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
@@ -256,9 +245,6 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 
 	vfree(pxmitpriv->pallocated_xmitbuf);
 
-	/*  free xmit extension buff */
-	_rtw_spinlock_free(&pxmitpriv->free_xmit_extbuf_queue.lock);
-
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
 	for (i = 0; i < num_xmit_extbuf; i++) {
 		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 39c7c5534b55..c92284811827 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -222,7 +222,6 @@ void *rtw_malloc2d(int h, int w, int size);
 u32  _rtw_down_sema(struct semaphore *sema);
 void _rtw_mutex_init(struct mutex *pmutex);
 void _rtw_mutex_free(struct mutex *pmutex);
-void _rtw_spinlock_free(spinlock_t *plock);
 
 void _rtw_init_queue(struct __queue *pqueue);
 
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5f1ec883d6ed..935e35c82666 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -979,8 +979,6 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 	}
 	#endif
 
-	_rtw_spinlock_free(&padapter->br_ext_lock);
-
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
 	rtw_free_cmd_priv(&padapter->cmdpriv);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index b1ccd620baab..e6904d2e0358 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -94,10 +94,6 @@ void	_rtw_mutex_free(struct mutex *pmutex)
 	mutex_destroy(pmutex);
 }
 
-void	_rtw_spinlock_free(spinlock_t *plock)
-{
-}
-
 void	_rtw_init_queue(struct __queue *pqueue)
 {
 	INIT_LIST_HEAD(&(pqueue->queue));
-- 
2.32.0


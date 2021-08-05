Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8643E1B74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbhHEShu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbhHEShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:45 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8521C061799
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:37:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n16so8644009oij.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fx50+vdw5VycJPR5WsQjw0aa5H3GzAfxX0IToXn05Cc=;
        b=nk5/c6LUnd5jDxVC8OGB5PpQ3eLGmmYVybG3zmhxqtti6Y1vk6nAuDXA7TtzhT0ftM
         u1xtoPF8YOyOPOzdec7w3EquJsRvNM1mtkLgRg/38HH3D5FXUBBUhqgIZXVk5OxaTb1Y
         0YzakocJ8u8OCZD0Yw6I2zf1D5Oi45FLVWikD+OGvx/L+bNpPo+ThIDD6cIYBmuJrtDM
         i7W2G4xUTo8V1OAXOIH2CVRupAAIylv/Crl9GO/TzsyEypV8skuWkYJW/BAXWgV1nk5/
         JTnTZYK6Qx6rCs24qOxbuj1zZupBFz+FIPNaryVjiL/aKnpDbC2+mrn2CuifKnGh2g6b
         X1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fx50+vdw5VycJPR5WsQjw0aa5H3GzAfxX0IToXn05Cc=;
        b=HA7NQSUWAcP6nNFnwxe8/H07BgbJsS3OmWNjcZ+tJepWZkFug+vAqDR7I+cEiSILUi
         ESIJqYwJVDdAszBlM2Cny6vImNw3eOwaDWHJiY7vGNpCGF7bbklIJTh01QuC+V2SKoB1
         WNkAkK1uDxct2SDNnozEaDvhRHeKrDRVSvMXarmOCU6YQMRG3ob6MFjCzZg3MvyAkRXn
         z4cmbIt+Vzfz4sM5RaiOnZmAadGYYgSZIsYT373mHXoGQyU+t41M3mfG9cL7EN7lZ6Zq
         NmKniv4xCA2CAZCntAbsk2oV9TUhgphT6ltn62CBSgEDrBo26swn50OZx3A2vAjjhkMC
         0SwQ==
X-Gm-Message-State: AOAM532KKqk/pUm78/tqcxSCqSVNkfTDXxcoaYuoShnYyBdhiULblviq
        tMuerQF756au0JzO1c4IWRsyd9HMjKs=
X-Google-Smtp-Source: ABdhPJyWWRnrYU0XjNfSiDLaYWNtK7y+X8O6GUSl00Fq5RwIL8T53o2AD9k/M965sR0J9vohp+J6Kw==
X-Received: by 2002:a05:6808:1582:: with SMTP id t2mr4616216oiw.173.1628188650189;
        Thu, 05 Aug 2021 11:37:30 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id q32sm1156726oiw.37.2021.08.05.11.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:37:29 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/5] staging: r8188eu: Remove all calls to _rtw_spinlock_free()
Date:   Thu,  5 Aug 2021 13:37:15 -0500
Message-Id: <20210805183717.23007-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
References: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This routine is empty, thus all calls to it can be removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
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
index d7d33e201f37..720b534c29ad 100644
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
index 72570aede776..4ffed8a35054 100644
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
index 6f6caf727f3b..47e19c506584 100644
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
index 2f1d1bfb6f73..b7c39d5e316c 100644
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
 
-	if (&psta->lock)
-		 _rtw_spinlock_free(&psta->lock);
-
 	_rtw_free_sta_xmit_priv_lock(&psta->sta_xmitpriv);
 	_rtw_free_sta_recv_priv_lock(&psta->sta_recvpriv);
 
@@ -166,18 +150,6 @@ static void rtw_mfree_sta_priv_lock(struct sta_priv *pstapriv)
 #ifdef CONFIG_88EU_AP_MODE
 	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
 #endif
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
index 05396cc2e82a..edd5746be556 100644
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
index 1ff0980e6bfb..cb876b50d68c 100644
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
index d3603e34eeb4..db6ee1dca48e 100644
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


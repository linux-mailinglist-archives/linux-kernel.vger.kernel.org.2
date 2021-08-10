Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA843DF7FC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhHCWhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233675AbhHCWhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:37:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BE7861103;
        Tue,  3 Aug 2021 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030209;
        bh=LOooI3TFDSlzMRmAvFd69bhLUM3YuQh6tVf2v0LeW8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFlu01Rlh1o1KmEBHJCwH1fJi0mRV11XC1qAb8VqcK6AV3E1kZZOP+bOuHo9wH3AW
         w/GHIc50SzYOJ8NHQ708v70eBZiYzTM76E1Pz7/QLnk31i1Tf340/ETinjXzUmuYPS
         CkpiRyLAnYjLOU8DIgGHVkSBYE6XJZViJpQ85CO5SxSpKp0/mC8R41AqUkvxagCx7W
         wQFD7YCwDWtwZC6Mqaalt0gVaCFkw27eE/obcCru0Y8gF4urCO0oCxgLYjiUwda9UP
         WpDheivuHcz+D0eAfWDiTbi3SgVrZdf7kpmjP2zMl/qSMThip6v9Eh/uevAXLscJ+D
         XgrSGs67YXEJw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/4] staging: r8188eu: Remove _rtw_spinlock_free()
Date:   Tue,  3 Aug 2021 15:36:06 -0700
Message-Id: <20210803223609.1627280-2-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc0
In-Reply-To: <20210803223609.1627280-1-nathan@kernel.org>
References: <20210803223609.1627280-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/staging/r8188eu/core/rtw_sta_mgt.c:156:13: warning: comparison
of address of 'psta->lock' not equal to a null pointer is always true
[-Wtautological-pointer-compare]
        if (&psta->lock != NULL)
             ~~~~~~^~~~    ~~~~
1 warning generated.

rtw_mfree_stainfo() is not called anywhere so this entire function can
be removed. Upon further inspection, _rtw_spinlock_free() is an empty
function so completely remove its use from the driver. Functions that
only call _rtw_spinlock_free() are eliminated as a byproduct.

rtw_mfree_all_stainfo() was eliminated because it would be the only
function left in rtw_mfree_sta_priv_lock() but it only iterates through
free_sta_queue, not doing anything else.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 -
 drivers/staging/r8188eu/core/rtw_mlme.c       | 16 +---
 drivers/staging/r8188eu/core/rtw_recv.c       | 11 ---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 77 -------------------
 drivers/staging/r8188eu/core/rtw_xmit.c       | 19 -----
 .../staging/r8188eu/include/osdep_service.h   |  1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 -
 .../staging/r8188eu/os_dep/osdep_service.c    |  4 -
 8 files changed, 2 insertions(+), 130 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4e17972ee66e..cb7d730286fe 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -96,8 +96,6 @@ void _rtw_free_cmd_priv (struct	cmd_priv *pcmdpriv)
 {
 
 	if (pcmdpriv) {
-		_rtw_spinlock_free(&(pcmdpriv->cmd_queue.lock));
-
 		if (pcmdpriv->cmd_allocated_buf)
 			kfree(pcmdpriv->cmd_allocated_buf);
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index a6d62074289f..fa4df4a3a2df 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -85,13 +85,6 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 	return res;
 }
 
-static void rtw_mfree_mlme_priv_lock (struct mlme_priv *pmlmepriv)
-{
-	_rtw_spinlock_free(&pmlmepriv->lock);
-	_rtw_spinlock_free(&(pmlmepriv->free_bss_pool.lock));
-	_rtw_spinlock_free(&(pmlmepriv->scanned_queue.lock));
-}
-
 #if defined (CONFIG_88EU_AP_MODE)
 static void rtw_free_mlme_ie_data(u8 **ppie, u32 *plen)
 {
@@ -126,13 +119,8 @@ void _rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
 
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 
-	if (pmlmepriv) {
-		rtw_mfree_mlme_priv_lock (pmlmepriv);
-
-		if (pmlmepriv->free_bss_buf) {
-			rtw_vmfree(pmlmepriv->free_bss_buf, MAX_BSS_CNT * sizeof(struct wlan_network));
-		}
-	}
+	if (pmlmepriv && pmlmepriv->free_bss_buf)
+		rtw_vmfree(pmlmepriv->free_bss_buf, MAX_BSS_CNT * sizeof(struct wlan_network));
 
 }
 
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 610cc699caf9..1889a7935c97 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -96,23 +96,12 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	return res;
 }
 
-static void rtw_mfree_recv_priv_lock(struct recv_priv *precvpriv)
-{
-	_rtw_spinlock_free(&precvpriv->lock);
-	_rtw_spinlock_free(&precvpriv->free_recv_queue.lock);
-	_rtw_spinlock_free(&precvpriv->recv_pending_queue.lock);
-
-	_rtw_spinlock_free(&precvpriv->free_recv_buf_queue.lock);
-}
-
 void _rtw_free_recv_priv (struct recv_priv *precvpriv)
 {
 	struct adapter	*padapter = precvpriv->adapter;
 
 	rtw_free_uc_swdec_pending_queue(padapter);
 
-	rtw_mfree_recv_priv_lock(precvpriv);
-
 	rtw_os_recv_resource_free(precvpriv);
 
 	if (precvpriv->pallocated_frame_buf) {
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index feaf39fddf7c..f51d2f78e292 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -127,81 +127,6 @@ inline struct sta_info *rtw_get_stainfo_by_offset(struct sta_priv *stapriv, int
 	return (struct sta_info *)(stapriv->pstainfo_buf + offset * sizeof(struct sta_info));
 }
 
-void	_rtw_free_sta_xmit_priv_lock(struct sta_xmit_priv *psta_xmitpriv);
-void	_rtw_free_sta_xmit_priv_lock(struct sta_xmit_priv *psta_xmitpriv)
-{
-
-	_rtw_spinlock_free(&psta_xmitpriv->lock);
-
-	_rtw_spinlock_free(&(psta_xmitpriv->be_q.sta_pending.lock));
-	_rtw_spinlock_free(&(psta_xmitpriv->bk_q.sta_pending.lock));
-	_rtw_spinlock_free(&(psta_xmitpriv->vi_q.sta_pending.lock));
-	_rtw_spinlock_free(&(psta_xmitpriv->vo_q.sta_pending.lock));
-
-}
-
-static void	_rtw_free_sta_recv_priv_lock(struct sta_recv_priv *psta_recvpriv)
-{
-
-	_rtw_spinlock_free(&psta_recvpriv->lock);
-
-	_rtw_spinlock_free(&(psta_recvpriv->defrag_q.lock));
-
-}
-
-void rtw_mfree_stainfo(struct sta_info *psta);
-void rtw_mfree_stainfo(struct sta_info *psta)
-{
-
-	if (&psta->lock != NULL)
-		 _rtw_spinlock_free(&psta->lock);
-
-	_rtw_free_sta_xmit_priv_lock(&psta->sta_xmitpriv);
-	_rtw_free_sta_recv_priv_lock(&psta->sta_recvpriv);
-
-}
-
-/*  this function is used to free the memory of lock || sema for all stainfos */
-void rtw_mfree_all_stainfo(struct sta_priv *pstapriv);
-void rtw_mfree_all_stainfo(struct sta_priv *pstapriv)
-{
-	struct list_head *plist, *phead;
-	struct sta_info *psta = NULL;
-
-	spin_lock_bh(&pstapriv->sta_hash_lock);
-
-	phead = get_list_head(&pstapriv->free_sta_queue);
-	plist = phead->next;
-
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, list);
-		plist = plist->next;
-	}
-
-	spin_unlock_bh(&pstapriv->sta_hash_lock);
-}
-
-static void rtw_mfree_sta_priv_lock(struct sta_priv *pstapriv)
-{
-#ifdef CONFIG_88EU_AP_MODE
-	struct wlan_acl_pool *pacl_list = &pstapriv->acl_list;
-#endif
-
-	 rtw_mfree_all_stainfo(pstapriv); /* be done before free sta_hash_lock */
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
-}
-
 u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 {
 	struct list_head *phead, *plist;
@@ -230,8 +155,6 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		spin_unlock_bh(&pstapriv->sta_hash_lock);
 		/*===============================*/
 
-		rtw_mfree_sta_priv_lock(pstapriv);
-
 		if (pstapriv->pallocated_stainfo_buf)
 			rtw_vmfree(pstapriv->pallocated_stainfo_buf, sizeof(struct sta_info)*NUM_STA+4);
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4a5393184737..499bb8ce0290 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -210,21 +210,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	return res;
 }
 
-static void  rtw_mfree_xmit_priv_lock (struct xmit_priv *pxmitpriv)
-{
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
-}
-
 void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 {
 	int i;
@@ -236,8 +221,6 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 
 	rtw_hal_free_xmit_priv(padapter);
 
-	rtw_mfree_xmit_priv_lock(pxmitpriv);
-
 	if (pxmitpriv->pxmit_frame_buf == NULL)
 		return;
 
@@ -259,8 +242,6 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 		rtw_vmfree(pxmitpriv->pallocated_xmitbuf, NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
 	/*  free xmit extension buff */
-	_rtw_spinlock_free(&pxmitpriv->free_xmit_extbuf_queue.lock);
-
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
 	for (i = 0; i < num_xmit_extbuf; i++) {
 		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index ac0bd5cd0f82..df7f293981e7 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -230,7 +230,6 @@ void *rtw_malloc2d(int h, int w, int size);
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
index 71d4fa25db86..a23f5e448bf4 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -118,10 +118,6 @@ void	_rtw_mutex_free(struct mutex *pmutex)
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
2.33.0.rc0


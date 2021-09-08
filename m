Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51942403FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 21:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352213AbhIHTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352355AbhIHToX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 15:44:23 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4D9C061757
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 12:43:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t19so6565934lfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=189MdnhePWLJPMkACEX8Z9x1UdbaCYdMgunmwYT+k/g=;
        b=KffUi6XYRQrvIRNfhFYpHgnQTMkYvrBZmeeCYH3uaadAktUFBbeD91neaYpyj4lVn8
         tIlLiATxLrJcjiNsnuNylZTRu5S3TfGnAzCMw5kNlNtTJmjl2L/Dvf6pQlDjlWkdXe/r
         q86pWsvEa1MULsXlHiD2FSZCVxBQKPZ+1qx5R4he6a30X3JOw6t4lytEVhuIcdE7m3tM
         lx49rT7DxGWl08qQNqmunof15loYz/4tEED+h2S/6Baoo0ODmVtOaYAO8IhumGKy3SIh
         tQK9k9KQG5MQ+1MtBAWG3s99zncBSz7FvQrR+yQ4rSsX9hsb/mfV21Ww7NgHC/Nl3by3
         FbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=189MdnhePWLJPMkACEX8Z9x1UdbaCYdMgunmwYT+k/g=;
        b=bndU/LqhqlrbodgOkjpam+WYAbhFdSFaApX9dNj9GVWm6ihrc6Pc2gS0fRxtN8Vq3l
         dh7sflAExDndxsOYvX9VgicvOSICz/71T1dZ0x08H9THrd8Eqq23jo/vG4zkneUONHqd
         7c1hDp1nW8p6XKAPPVzAXObo8PBwplkei9TYR6MFSQLSSfJlunj4IoE3oTgBV1FNjCv0
         I/VJ8GPrWw/m3OcVZFsRZhU4CikUcardsSBUBAQKkguSaGSYfW353e2LtXOLF4yFCBQi
         9G1OxYDSVe3IXZoAAiEBYiIEKzSKf9i1X8nTzhP0Qtqvw0jUt/hcLzoGd688JDuyB9i0
         nxfA==
X-Gm-Message-State: AOAM533VvmoQ12AnWAh5QMmGSau8xOVkbNj6xnlTcKpe/uyypj9LhDAp
        fnALRn/bQdp1cwxtcOglzuhtdpQ5cQ9fYQX1
X-Google-Smtp-Source: ABdhPJxT0KvcJfub8tHQAPkVGdlFV0djuHgxxjZd6jl6Re5OPnx4ipjItcYG3+BS+yfHgtWNrCmUqg==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr2451510lfy.146.1631130193095;
        Wed, 08 Sep 2021 12:43:13 -0700 (PDT)
Received: from localhost.localdomain ([46.235.67.70])
        by smtp.gmail.com with ESMTPSA id c22sm277476lfm.113.2021.09.08.12.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 12:43:12 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v2] staging: r8188eu: make _rtw_init_queue a macro
Date:   Wed,  8 Sep 2021 22:43:09 +0300
Message-Id: <20210908194309.9086-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210908173307.9018-1-paskripkin@gmail.com>
References: <20210908173307.9018-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing latest updates I hit lockdep warning:

[   42.694425] ============================================
[   42.694785] WARNING: possible recursive locking detected
[   42.695120] 5.14.0+ #25 Tainted: G         C
[   42.695422] --------------------------------------------
[   42.695747] RTW_CMD_THREAD/317 is trying to acquire lock:
[   42.696078] ffffc900006c90b0 (&pqueue->lock){+.-.}-{3:3}, at: _rtw_alloc_network+0x1e/0x321 [r8188eu]
[   42.696686]
[   42.696686] but task is already holding lock:
[   42.697148] ffffc900006c9100 (&pqueue->lock){+.-.}-{3:3}, at: rtw_update_scanned_network+0x31/0x76b [r8188eu]
[   42.697758]
[   42.697758] other info that might help us debug this:
[   42.698326]  Possible unsafe locking scenario:
[   42.698326]
[   42.698696]        CPU0
[   42.698847]        ----
[   42.698997]   lock(&pqueue->lock);
[   42.699209]   lock(&pqueue->lock);
[   42.699418]
[   42.699418]  *** DEADLOCK ***
[   42.699418]
[   42.699768]  May be due to missing lock nesting notation

It's false positive, since all queue spinlocks are initialized via
private API which has pqueue as agrument. Fix it by making
_rtw_init_queue a macro instead of function + removed unneeded _ prefix.

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes in v2:
	&(ptr)->name -> &((ptr)->name). reported by Fabio M. De Francesco

---
 drivers/staging/r8188eu/core/rtw_ap.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       |  4 ++--
 drivers/staging/r8188eu/core/rtw_mp.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  8 +++----
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 10 ++++-----
 drivers/staging/r8188eu/core/rtw_xmit.c       | 22 +++++++++----------
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  2 +-
 .../staging/r8188eu/include/osdep_service.h   |  6 ++++-
 .../staging/r8188eu/os_dep/osdep_service.c    |  6 -----
 10 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1c07ad28b242..ace11dde980d 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -19,7 +19,7 @@ void init_mlme_ap_info(struct adapter *padapter)
 	spin_lock_init(&pmlmepriv->bcn_update_lock);
 
 	/* for ACL */
-	_rtw_init_queue(&pacl_list->acl_node_q);
+	rtw_init_queue(&pacl_list->acl_node_q);
 
 	start_ap_mode(padapter);
 }
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 738e1ec749be..2b7e76a682c7 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -23,7 +23,7 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
 	sema_init(&pcmdpriv->terminate_cmdthread_sema, 0);
 
-	_rtw_init_queue(&pcmdpriv->cmd_queue);
+	rtw_init_queue(&pcmdpriv->cmd_queue);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 37578638bb76..f311d6870196 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -48,8 +48,8 @@ int _rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
 	spin_lock_init(&pmlmepriv->lock);
-	_rtw_init_queue(&pmlmepriv->free_bss_pool);
-	_rtw_init_queue(&pmlmepriv->scanned_queue);
+	rtw_init_queue(&pmlmepriv->free_bss_pool);
+	rtw_init_queue(&pmlmepriv->scanned_queue);
 
 	set_scanned_network_val(pmlmepriv, 0);
 
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index dabdd0406f30..bd797192f3d4 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -889,7 +889,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 	}
 
 	/*  Init xmit extension buff */
-	_rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
+	rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
 
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index ba69cf9facfe..85510d598242 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -31,7 +31,7 @@ void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 
 	spin_lock_init(&psta_recvpriv->lock);
 
-	_rtw_init_queue(&psta_recvpriv->defrag_q);
+	rtw_init_queue(&psta_recvpriv->defrag_q);
 
 }
 
@@ -45,9 +45,9 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	spin_lock_init(&precvpriv->lock);
 
-	_rtw_init_queue(&precvpriv->free_recv_queue);
-	_rtw_init_queue(&precvpriv->recv_pending_queue);
-	_rtw_init_queue(&precvpriv->uc_swdec_pending_queue);
+	rtw_init_queue(&precvpriv->free_recv_queue);
+	rtw_init_queue(&precvpriv->recv_pending_queue);
+	rtw_init_queue(&precvpriv->uc_swdec_pending_queue);
 
 	precvpriv->adapter = padapter;
 
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index c3600cb1790a..cd09c3503d93 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -18,7 +18,7 @@ static void _rtw_init_stainfo(struct sta_info *psta)
 	spin_lock_init(&psta->lock);
 	INIT_LIST_HEAD(&psta->list);
 	INIT_LIST_HEAD(&psta->hash_list);
-	_rtw_init_queue(&psta->sleep_q);
+	rtw_init_queue(&psta->sleep_q);
 	psta->sleepq_len = 0;
 
 	_rtw_init_sta_xmit_priv(&psta->sta_xmitpriv);
@@ -68,13 +68,13 @@ u32	_rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
 		((size_t)(pstapriv->pallocated_stainfo_buf) & 3);
 
-	_rtw_init_queue(&pstapriv->free_sta_queue);
+	rtw_init_queue(&pstapriv->free_sta_queue);
 
 	spin_lock_init(&pstapriv->sta_hash_lock);
 
 	pstapriv->asoc_sta_count = 0;
-	_rtw_init_queue(&pstapriv->sleep_q);
-	_rtw_init_queue(&pstapriv->wakeup_q);
+	rtw_init_queue(&pstapriv->sleep_q);
+	rtw_init_queue(&pstapriv->wakeup_q);
 
 	psta = (struct sta_info *)(pstapriv->pstainfo_buf);
 
@@ -221,7 +221,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 			preorder_ctrl->wend_b = 0xffff;
 			preorder_ctrl->wsize_b = 64;/* 64; */
 
-			_rtw_init_queue(&preorder_ctrl->pending_recvframe_queue);
+			rtw_init_queue(&preorder_ctrl->pending_recvframe_queue);
 
 			rtw_init_recv_timer(preorder_ctrl);
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 875d1bf1679c..59ff83f50188 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -17,7 +17,7 @@ static void _init_txservq(struct tx_servq *ptxservq)
 {
 
 	INIT_LIST_HEAD(&ptxservq->tx_pending);
-	_rtw_init_queue(&ptxservq->sta_pending);
+	rtw_init_queue(&ptxservq->sta_pending);
 	ptxservq->qcnt = 0;
 
 }
@@ -52,18 +52,18 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	sema_init(&pxmitpriv->terminate_xmitthread_sema, 0);
 
 	/*
-	Please insert all the queue initializaiton using _rtw_init_queue below
+	Please insert all the queue initializaiton using rtw_init_queue below
 	*/
 
 	pxmitpriv->adapter = padapter;
 
-	_rtw_init_queue(&pxmitpriv->be_pending);
-	_rtw_init_queue(&pxmitpriv->bk_pending);
-	_rtw_init_queue(&pxmitpriv->vi_pending);
-	_rtw_init_queue(&pxmitpriv->vo_pending);
-	_rtw_init_queue(&pxmitpriv->bm_pending);
+	rtw_init_queue(&pxmitpriv->be_pending);
+	rtw_init_queue(&pxmitpriv->bk_pending);
+	rtw_init_queue(&pxmitpriv->vi_pending);
+	rtw_init_queue(&pxmitpriv->vo_pending);
+	rtw_init_queue(&pxmitpriv->bm_pending);
 
-	_rtw_init_queue(&pxmitpriv->free_xmit_queue);
+	rtw_init_queue(&pxmitpriv->free_xmit_queue);
 
 	/*
 	Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
@@ -105,8 +105,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->frag_len = MAX_FRAG_THRESHOLD;
 
 	/* init xmit_buf */
-	_rtw_init_queue(&pxmitpriv->free_xmitbuf_queue);
-	_rtw_init_queue(&pxmitpriv->pending_xmitbuf_queue);
+	rtw_init_queue(&pxmitpriv->free_xmitbuf_queue);
+	rtw_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
@@ -147,7 +147,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
 
 	/*  Init xmit extension buff */
-	_rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
+	rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
 
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 2da7bde80cc0..9c191b7ffbf1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -39,7 +39,7 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 		     (unsigned long)padapter);
 
 	/* init recv_buf */
-	_rtw_init_queue(&precvpriv->free_recv_buf_queue);
+	rtw_init_queue(&precvpriv->free_recv_buf_queue);
 
 	precvpriv->pallocated_recv_buf = kzalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4,
 						 GFP_KERNEL);
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index b832849bc308..86140ca3a115 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -143,7 +143,11 @@ void *rtw_malloc2d(int h, int w, int size);
 
 u32  _rtw_down_sema(struct semaphore *sema);
 
-void _rtw_init_queue(struct __queue *pqueue);
+#define rtw_init_queue(q)					\
+	do {							\
+		INIT_LIST_HEAD(&((q)->queue));			\
+		spin_lock_init(&((q)->lock));			\
+	} while (0)
 
 u32  rtw_systime_to_ms(u32 systime);
 u32  rtw_ms_to_systime(u32 ms);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 4328992907f2..4fda24bd9de4 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -67,12 +67,6 @@ u32 _rtw_down_sema(struct semaphore *sema)
 		return _SUCCESS;
 }
 
-void	_rtw_init_queue(struct __queue *pqueue)
-{
-	INIT_LIST_HEAD(&pqueue->queue);
-	spin_lock_init(&pqueue->lock);
-}
-
 inline u32 rtw_systime_to_ms(u32 systime)
 {
 	return systime * 1000 / HZ;
-- 
2.33.0


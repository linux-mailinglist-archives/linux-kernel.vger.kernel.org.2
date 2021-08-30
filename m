Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCB3FB1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhH3HLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 03:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbhH3HLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 03:11:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82163C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso13912121wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 00:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oj/tUh+pe4OAovZ0Fi4zbnQcTpGjr+/IUBcUMUGaB+E=;
        b=Yzpa061DMKEee7iJTpOVKs/ABgOWL7wPyYPIw7R8gUtIU4kpFG0Mt0lHiQexppaO82
         dQf1AOMZJ/kbm43z3OouPWwn1HFBYpahRaORH7RkWaAg1sowNSszrezMSIfFLVRd4boO
         RjF2EakodkINkOnz+bLDUNvAAiqmp9W3GtR3UxH9rQ9mmGC6aMzqwq5CbbJEhPzYGhBZ
         UdhLubK44Jg88DvPfcpGt2tapDVc0yQkCABVsaF680VQ3n2yuFDScEFmYgqO/ZAvhOdn
         bMuggqkoXe48VgtWc2BQia0wNnVdDS+YLHET9p6kqhoE5jPoLS5fDRWScpvpXWnrtyOd
         dfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oj/tUh+pe4OAovZ0Fi4zbnQcTpGjr+/IUBcUMUGaB+E=;
        b=evkaWYSCR9yTh6BIbPFi8la65JW8ZCPMwhN4GBjKkTTDTlC0ghWA5hcAG+nZwh436D
         MWa4pWkoH3uat8u/BsI+8vf2eiKNZr2YHdPJ3eXRorqDG37232RmG1UF/jlnIuf/iB+Z
         qkA3MoTur3wy19Z60JjLeZAQo8dbf+jKOIbeABNHsEPOG5iDlrP7X/1XAFRby70Z544/
         Y2oIeG3IT+vXuHI/7u53IUvYAyYKayyWKDNtZv/n5m0gD7KLe9y4m4QNe+RT3HwGI1Rx
         3EGHiFEYHFfU5wJ0jaeakfU+uIzwCGNKzMb5dwFcPo9ic/5Tn12tWHks0qOIi2o7JqPo
         Ueeg==
X-Gm-Message-State: AOAM531GmoaAi67XHJ7munOndWeKYZeYahbjuwPb1v+deILgk0R94D3t
        dEIlb9BTunJrjjQ51r75BUI=
X-Google-Smtp-Source: ABdhPJwUmivDsXpHov9SC/LsYOdRsyjboAqUr3dDANw2XvaCMuDzhbqq0lrlwhX+i7hsubp9PBE3Yw==
X-Received: by 2002:a1c:a5ca:: with SMTP id o193mr30752376wme.160.1630307417142;
        Mon, 30 Aug 2021 00:10:17 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id u16sm14260106wmc.41.2021.08.30.00.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 00:10:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: unwrap initialization of queues
Date:   Mon, 30 Aug 2021 09:09:23 +0200
Message-Id: <c2c3a18cc2b883feab74f150ccbaa4f2cc11995c.1630307025.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1630307025.git.fabioaiuto83@gmail.com>
References: <cover.1630307025.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unwrap initialization of queues to avoid false positive
lockdep warning:

[   27.350258] ============================================
[   27.350267] WARNING: possible recursive locking detected
[   27.350276] 5.14.0-rc6+ #16 Tainted: G         C OE
[   27.350288] --------------------------------------------
[   27.350295] RTW_CMD_THREAD/679 is trying to acquire lock:
[   27.350306] ffffa846c03290c8 (&(pqueue->lock)){+.-.}-{2:2},
		at: rtw_alloc_network+0x1b/0xa0 [r8723bs]
[   27.350441]
               but task is already holding lock:
[   27.350448] ffffa846c0329118 (&(pqueue->lock)){+.-.}-{2:2},
		at: rtw_update_scanned_network+0x33/0x1d0 [r8723bs]
[   27.350573]
               other info that might help us debug this:
[   27.350581]  Possible unsafe locking scenario:

[   27.350588]        CPU0
[   27.350594]        ----
[   27.350600]   lock(&(pqueue->lock));
[   27.350614]   lock(&(pqueue->lock));
[   27.350627]
                *** DEADLOCK ***

[   27.350634]  May be due to missing lock nesting notation

[   27.350641] 2 locks held by RTW_CMD_THREAD/679:
[   27.350652]  #0: ffffa846c0329038 (&pmlmepriv->lock){+...}-{2:2},
	at: rtw_survey_event_callback+0x2d/0xe0 [r8723bs]
[   27.350780]  #1: ffffa846c0329118 (&(pqueue->lock)){+.-.}-{2:2},
	at: rtw_update_scanned_network+0x33/0x1d0 [r8723bs]
[   27.350907]
               stack backtrace:
[   27.350916] CPU: 3 PID: 679 Comm: RTW_CMD_THREAD Tainted: G
		C OE     5.14.0-rc6+ #16
[   27.350933] Hardware name: LENOVO 80NR/Madrid, BIOS DACN25WW
		08/20/2015
[   27.350943] Call Trace:
[   27.350959]  dump_stack_lvl+0x56/0x6f
[   27.350982]  __lock_acquire.cold.79+0x137/0x298
[   27.351012]  lock_acquire+0xb4/0x2c0
[   27.351031]  ? rtw_alloc_network+0x1b/0xa0 [r8723bs]
[   27.351140]  ? rtw_update_scanned_network+0x33/0x1d0 [r8723bs]
[   27.351254]  _raw_spin_lock_bh+0x34/0x40
[   27.351271]  ? rtw_alloc_network+0x1b/0xa0 [r8723bs]
[   27.351378]  rtw_alloc_network+0x1b/0xa0 [r8723bs]
[   27.351488]  rtw_update_scanned_network+0xa5/0x1d0 [r8723bs]
[   27.351605]  rtw_survey_event_callback+0x54/0xe0 [r8723bs]
[   27.351719]  mlme_evt_hdl+0x4e/0x70 [r8723bs]
[   27.351839]  rtw_cmd_thread+0x16c/0x3d0 [r8723bs]
[   27.351945]  ? rtw_stop_cmd_thread+0x50/0x50 [r8723bs]
[   27.352045]  kthread+0x136/0x160
[   27.352064]  ? set_kthread_struct+0x40/0x40
[   27.352083]  ret_from_fork+0x22/0x30

This happens because the wrapping function _rtw_init_queues()
bring lockdep considering all queues as a single one. But
all queues are different with their own lock.

Applied the following semantic patch:

@@
expression a;
@@

-       _rtw_init_queue(&a);
+       INIT_LIST_HEAD(&a.queue);
+       spin_lock_init(&a.lock);

Reported-by: Hans De Goede <hdegoede@redhat.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       |  3 +-
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 ++--
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 12 ++++---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 15 ++++++---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     | 33 ++++++++++++-------
 .../staging/rtl8723bs/hal/rtl8723bs_recv.c    |  6 ++--
 7 files changed, 52 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 6064dd6a76b4..79fbf14287b1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -18,7 +18,8 @@ void init_mlme_ap_info(struct adapter *padapter)
 	spin_lock_init(&pmlmepriv->bcn_update_lock);
 
 	/* for ACL */
-	_rtw_init_queue(&pacl_list->acl_node_q);
+	INIT_LIST_HEAD(&pacl_list->acl_node_q.queue);
+	spin_lock_init(&pacl_list->acl_node_q.lock);
 
 	/* pmlmeext->bstart_bss = false; */
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index d494c06dab96..76418c525b5c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -166,7 +166,8 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
-	_rtw_init_queue(&(pcmdpriv->cmd_queue));
+	INIT_LIST_HEAD(&(pcmdpriv->cmd_queue).queue);
+	spin_lock_init(&(pcmdpriv->cmd_queue).lock);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index ab6a24d70cc9..d4650ef3dbe8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -27,8 +27,10 @@ int	rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
 
 	spin_lock_init(&pmlmepriv->lock);
-	_rtw_init_queue(&pmlmepriv->free_bss_pool);
-	_rtw_init_queue(&pmlmepriv->scanned_queue);
+	INIT_LIST_HEAD(&pmlmepriv->free_bss_pool.queue);
+	spin_lock_init(&pmlmepriv->free_bss_pool.lock);
+	INIT_LIST_HEAD(&pmlmepriv->scanned_queue.queue);
+	spin_lock_init(&pmlmepriv->scanned_queue.lock);
 
 	set_scanned_network_val(pmlmepriv, 0);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 5b0a596eefb7..105fe0e3482a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -25,7 +25,8 @@ void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 	/* for (i = 0; i<MAX_RX_NUMBLKS; i++) */
 	/* _rtw_init_queue(&psta_recvpriv->blk_strms[i]); */
 
-	_rtw_init_queue(&psta_recvpriv->defrag_q);
+	INIT_LIST_HEAD(&psta_recvpriv->defrag_q.queue);
+	spin_lock_init(&psta_recvpriv->defrag_q.lock);
 }
 
 signed int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
@@ -36,9 +37,12 @@ signed int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *pada
 
 	spin_lock_init(&precvpriv->lock);
 
-	_rtw_init_queue(&precvpriv->free_recv_queue);
-	_rtw_init_queue(&precvpriv->recv_pending_queue);
-	_rtw_init_queue(&precvpriv->uc_swdec_pending_queue);
+	INIT_LIST_HEAD(&precvpriv->free_recv_queue.queue);
+	spin_lock_init(&precvpriv->free_recv_queue.lock);
+	INIT_LIST_HEAD(&precvpriv->recv_pending_queue.queue);
+	spin_lock_init(&precvpriv->recv_pending_queue.lock);
+	INIT_LIST_HEAD(&precvpriv->uc_swdec_pending_queue.queue);
+	spin_lock_init(&precvpriv->uc_swdec_pending_queue.lock);
 
 	precvpriv->adapter = padapter;
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 67ca219f95bf..bf090f3b1db6 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -19,7 +19,8 @@ void _rtw_init_stainfo(struct sta_info *psta)
 	/* INIT_LIST_HEAD(&psta->sleep_list); */
 	/* INIT_LIST_HEAD(&psta->wakeup_list); */
 
-	_rtw_init_queue(&psta->sleep_q);
+	INIT_LIST_HEAD(&psta->sleep_q.queue);
+	spin_lock_init(&psta->sleep_q.lock);
 	psta->sleepq_len = 0;
 
 	_rtw_init_sta_xmit_priv(&psta->sta_xmitpriv);
@@ -62,14 +63,17 @@ u32 _rtw_init_sta_priv(struct	sta_priv *pstapriv)
 	pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
 		((SIZE_PTR)(pstapriv->pallocated_stainfo_buf) & 3);
 
-	_rtw_init_queue(&pstapriv->free_sta_queue);
+	INIT_LIST_HEAD(&pstapriv->free_sta_queue.queue);
+	spin_lock_init(&pstapriv->free_sta_queue.lock);
 
 	spin_lock_init(&pstapriv->sta_hash_lock);
 
 	/* _rtw_init_queue(&pstapriv->asoc_q); */
 	pstapriv->asoc_sta_count = 0;
-	_rtw_init_queue(&pstapriv->sleep_q);
-	_rtw_init_queue(&pstapriv->wakeup_q);
+	INIT_LIST_HEAD(&pstapriv->sleep_q.queue);
+	spin_lock_init(&pstapriv->sleep_q.lock);
+	INIT_LIST_HEAD(&pstapriv->wakeup_q.queue);
+	spin_lock_init(&pstapriv->wakeup_q.lock);
 
 	psta = (struct sta_info *)(pstapriv->pstainfo_buf);
 
@@ -242,7 +246,8 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 			/* preorder_ctrl->wsize_b = (NR_RECVBUFF-2); */
 			preorder_ctrl->wsize_b = 64;/* 64; */
 
-			_rtw_init_queue(&preorder_ctrl->pending_recvframe_queue);
+			INIT_LIST_HEAD(&preorder_ctrl->pending_recvframe_queue.queue);
+			spin_lock_init(&preorder_ctrl->pending_recvframe_queue.lock);
 
 			rtw_init_recv_timer(preorder_ctrl);
 		}
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 79e4d7df1ef5..3eb6db2f26bb 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -13,7 +13,8 @@ static u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
 static void _init_txservq(struct tx_servq *ptxservq)
 {
 	INIT_LIST_HEAD(&ptxservq->tx_pending);
-	_rtw_init_queue(&ptxservq->sta_pending);
+	INIT_LIST_HEAD(&ptxservq->sta_pending.queue);
+	spin_lock_init(&ptxservq->sta_pending.lock);
 	ptxservq->qcnt = 0;
 }
 
@@ -49,13 +50,19 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->adapter = padapter;
 
-	_rtw_init_queue(&pxmitpriv->be_pending);
-	_rtw_init_queue(&pxmitpriv->bk_pending);
-	_rtw_init_queue(&pxmitpriv->vi_pending);
-	_rtw_init_queue(&pxmitpriv->vo_pending);
-	_rtw_init_queue(&pxmitpriv->bm_pending);
+	INIT_LIST_HEAD(&pxmitpriv->be_pending.queue);
+	spin_lock_init(&pxmitpriv->be_pending.lock);
+	INIT_LIST_HEAD(&pxmitpriv->bk_pending.queue);
+	spin_lock_init(&pxmitpriv->bk_pending.lock);
+	INIT_LIST_HEAD(&pxmitpriv->vi_pending.queue);
+	spin_lock_init(&pxmitpriv->vi_pending.lock);
+	INIT_LIST_HEAD(&pxmitpriv->vo_pending.queue);
+	spin_lock_init(&pxmitpriv->vo_pending.lock);
+	INIT_LIST_HEAD(&pxmitpriv->bm_pending.queue);
+	spin_lock_init(&pxmitpriv->bm_pending.lock);
 
-	_rtw_init_queue(&pxmitpriv->free_xmit_queue);
+	INIT_LIST_HEAD(&pxmitpriv->free_xmit_queue.queue);
+	spin_lock_init(&pxmitpriv->free_xmit_queue.lock);
 
 	/*
 	 * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
@@ -96,8 +103,10 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->frag_len = MAX_FRAG_THRESHOLD;
 
 	/* init xmit_buf */
-	_rtw_init_queue(&pxmitpriv->free_xmitbuf_queue);
-	_rtw_init_queue(&pxmitpriv->pending_xmitbuf_queue);
+	INIT_LIST_HEAD(&pxmitpriv->free_xmitbuf_queue.queue);
+	spin_lock_init(&pxmitpriv->free_xmitbuf_queue.lock);
+	INIT_LIST_HEAD(&pxmitpriv->pending_xmitbuf_queue.queue);
+	spin_lock_init(&pxmitpriv->pending_xmitbuf_queue.lock);
 
 	pxmitpriv->pallocated_xmitbuf = vzalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
@@ -145,7 +154,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
 
 	/* init xframe_ext queue,  the same count as extbuf  */
-	_rtw_init_queue(&pxmitpriv->free_xframe_ext_queue);
+	INIT_LIST_HEAD(&pxmitpriv->free_xframe_ext_queue.queue);
+	spin_lock_init(&pxmitpriv->free_xframe_ext_queue.lock);
 
 	pxmitpriv->xframe_ext_alloc_addr = vzalloc(NR_XMIT_EXTBUFF * sizeof(struct xmit_frame) + 4);
 
@@ -178,7 +188,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	pxmitpriv->free_xframe_ext_cnt = NR_XMIT_EXTBUFF;
 
 	/*  Init xmit extension buff */
-	_rtw_init_queue(&pxmitpriv->free_xmit_extbuf_queue);
+	INIT_LIST_HEAD(&pxmitpriv->free_xmit_extbuf_queue.queue);
+	spin_lock_init(&pxmitpriv->free_xmit_extbuf_queue.lock);
 
 	pxmitpriv->pallocated_xmit_extbuf = vzalloc(NR_XMIT_EXTBUFF * sizeof(struct xmit_buf) + 4);
 
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 418016930728..c0a1a6fbeb91 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -378,8 +378,10 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	precvpriv = &padapter->recvpriv;
 
 	/* 3 1. init recv buffer */
-	_rtw_init_queue(&precvpriv->free_recv_buf_queue);
-	_rtw_init_queue(&precvpriv->recv_buf_pending_queue);
+	INIT_LIST_HEAD(&precvpriv->free_recv_buf_queue.queue);
+	spin_lock_init(&precvpriv->free_recv_buf_queue.lock);
+	INIT_LIST_HEAD(&precvpriv->recv_buf_pending_queue.queue);
+	spin_lock_init(&precvpriv->recv_buf_pending_queue.lock);
 
 	n = NR_RECVBUFF * sizeof(struct recv_buf) + 4;
 	precvpriv->pallocated_recv_buf = rtw_zmalloc(n);
-- 
2.20.1


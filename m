Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E1737539B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhEFMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhEFMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:15:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6178C0613ED;
        Thu,  6 May 2021 05:14:52 -0700 (PDT)
Received: from ipservice-092-217-072-007.092.217.pools.vodafone-ip.de ([92.217.72.7] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lectz-0005c3-Sg; Thu, 06 May 2021 14:14:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] staging: rtl8188eu: remove nic_hdl from struct mlme_priv
Date:   Thu,  6 May 2021 14:14:10 +0200
Message-Id: <20210506121410.17613-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210505202622.11087-1-martin@kaiser.cx>
References: <20210505202622.11087-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mlme_priv is an element of struct adapter. Use container_of
to get a pointer to the enclosing struct.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - rebased against current staging-testing branch

 drivers/staging/rtl8188eu/core/rtw_mlme.c    | 5 +----
 drivers/staging/rtl8188eu/include/rtw_mlme.h | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 049e25455849..159465b073c2 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -32,8 +32,6 @@ int rtw_init_mlme_priv(struct adapter *padapter)
 
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
-	pmlmepriv->nic_hdl = (u8 *)padapter;
-
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = 0;
 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
@@ -1446,7 +1444,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 {
 	int ret;
 	struct list_head *phead;
-	struct adapter *adapter;
+	struct adapter *adapter = container_of(pmlmepriv, struct adapter, mlmepriv);
 	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct wlan_network *pnetwork = NULL;
 	struct wlan_network *candidate = NULL;
@@ -1454,7 +1452,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
-	adapter = (struct adapter *)pmlmepriv->nic_hdl;
 	list_for_each(pmlmepriv->pscanned, phead) {
 		pnetwork = list_entry(pmlmepriv->pscanned,
 				      struct wlan_network, list);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index 1b74b32b8a81..f5e805c13442 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -111,8 +111,6 @@ struct mlme_priv {
 	u8 to_join; /* flag */
 	u8 to_roaming; /*  roaming trying times */
 
-	u8 *nic_hdl;
-
 	struct list_head *pscanned;
 	struct __queue free_bss_pool;
 	struct __queue scanned_queue;
-- 
2.20.1


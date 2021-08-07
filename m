Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAD73E34AE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhHGKOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhHGKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BD6C0617B9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id w5so198227ejq.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+x0I7hPWkCmEDLJ+zw5aCUBeHw5a2dhPwAN7ub/WpE=;
        b=q4Mg7devFtt+LoY9wkJ0gem1QhF7Jwlz2ozN+fWrMmNLB8a0e21M0X+dddtjaMr4q4
         sZ86kdhnqYSnhSMyxUiNGfSTzm7M/8MEIvg0MazbYlZ4kSDWUMuiBC9sfFLwAjDHJYxh
         rrhdsme8MwM5LJsmCldnSh386DCD0KZD3+IJNQiRr3+pgBG5aRHA0UyUBdnK24mJlm9V
         +SmBBMBEqi4FWDJ6JWAohwoD+jMLfukCalNqD5kR4+zKdr5xbC1LUEWzog0WNFSwJ1gd
         Y3eBNcjm8GgXnUjutJZLdXqCw1aib4Zbt2quIdPmdPsWuf2Zabe0wfs4P6gQcq7PYOY2
         z4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+x0I7hPWkCmEDLJ+zw5aCUBeHw5a2dhPwAN7ub/WpE=;
        b=EKylAiqgC4zP4xDI98F4n3TZImyRD+jnm/zfvo0hxDZ8Q3p0WklrTK2k/apup9fUrn
         Cf035v+g201U+6oTljNUZUNJFbdBQ9a/AMppFyxB75CrzXk7Z5C3tm2A9hKPi+n8Cy6h
         VM7Nm/Jm2GVK0068qvAHnXdZP8kf13W6PolLK1hLQPzkQKsptDnQzuWdfajJjK5nGInp
         gv7DvjHxcWwQAFCxF/cE8hoNc2DLwSqSf+cRw1tFamFIQHgWNWrRT9TZ8k2HIFpo9UU5
         ghvUFAqU77vTJmzST8V+yLsn6LwciEj//VMJwP3pSqIXTvX6ZbtLBECiklJYUtcvI04g
         tjkw==
X-Gm-Message-State: AOAM533bAmiraI7j/zkRZBNXmDUev2tOX6XczdRwzL5R5Ur4Rw1WD2oR
        JW5edSQgFSx6AH9BQ8klzG8=
X-Google-Smtp-Source: ABdhPJxa9sUrO/YdzOkL9lMAWSLfIr/oIK8o7IapCGBIrKwAgERA61RMEI8/OWqXeRi8JDMzdxSuqw==
X-Received: by 2002:a17:907:7251:: with SMTP id ds17mr13945339ejc.43.1628331140137;
        Sat, 07 Aug 2021 03:12:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/17] staging: r8188eu: remove remaining unnecessary parentheses in core dir
Date:   Sat,  7 Aug 2021 12:11:19 +0200
Message-Id: <20210807101119.16085-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove remaining unnecessary parentheses in core dir reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c    |  6 +++---
 drivers/staging/r8188eu/core/rtw_debug.c     | 14 +++++++-------
 drivers/staging/r8188eu/core/rtw_ieee80211.c |  4 ++--
 drivers/staging/r8188eu/core/rtw_iol.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_mp.c        | 10 +++++-----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 28f0452d6ccb..e13f134a497b 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -319,7 +319,7 @@ static inline void __network_hash_link(struct adapter *priv,
 static inline void __network_hash_unlink(struct nat25_network_db_entry *ent)
 {
 	/*  Caller must spin_lock already! */
-	*(ent->pprev_hash) = ent->next_hash;
+	*ent->pprev_hash = ent->next_hash;
 	if (ent->next_hash)
 		ent->next_hash->pprev_hash = ent->pprev_hash;
 	ent->next_hash = NULL;
@@ -853,7 +853,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			} else {	/*  session phase */
 				DEBUG_INFO("NAT25: Insert PPPoE, insert session packet to %s\n", skb->dev->name);
 
-				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &(ph->sid));
+				__nat25_generate_pppoe_network_addr(networkAddr, skb->data, &ph->sid);
 
 				__nat25_db_network_insert(priv, skb->data+ETH_ALEN, networkAddr);
 
@@ -921,7 +921,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			} else {
 				if (ph->sid != 0) {
 					DEBUG_INFO("NAT25: Lookup PPPoE, lookup session packet from %s\n", skb->dev->name);
-					__nat25_generate_pppoe_network_addr(networkAddr, skb->data+ETH_ALEN, &(ph->sid));
+					__nat25_generate_pppoe_network_addr(networkAddr, skb->data+ETH_ALEN, &ph->sid);
 					__nat25_db_network_lookup_and_replace(priv, skb, networkAddr);
 					__nat25_db_print(priv);
 				} else {
diff --git a/drivers/staging/r8188eu/core/rtw_debug.c b/drivers/staging/r8188eu/core/rtw_debug.c
index 30ef77842787..e7b088563738 100644
--- a/drivers/staging/r8188eu/core/rtw_debug.c
+++ b/drivers/staging/r8188eu/core/rtw_debug.c
@@ -133,7 +133,7 @@ int proc_get_fwstate(char *page, char **start,
 {
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	int len = 0;
 
@@ -168,7 +168,7 @@ int proc_get_mlmext_state(char *page, char **start,
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	int len = 0;
 
@@ -184,7 +184,7 @@ int proc_get_qos_option(char *page, char **start,
 {
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	int len = 0;
 
@@ -200,7 +200,7 @@ int proc_get_ht_option(char *page, char **start,
 {
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	int len = 0;
 	len += snprintf(page + len, count - len, "ht_option=%d\n", pmlmepriv->htpriv.ht_option);
@@ -230,9 +230,9 @@ int proc_get_ap_info(char *page, char **start,
 	struct sta_info *psta;
 	struct net_device *dev = data;
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct wlan_network *cur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	int len = 0;
 
@@ -830,7 +830,7 @@ int proc_get_all_sta_info(char *page, char **start,
 	spin_lock_bh(&pstapriv->sta_hash_lock);
 
 	for (i = 0; i < NUM_STA; i++) {
-		phead = &(pstapriv->sta_hash[i]);
+		phead = &pstapriv->sta_hash[i];
 		plist = phead->next;
 
 		while (phead != plist) {
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index ff77e686721c..55d2b8f90d91 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -414,11 +414,11 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv)
 	}
 
 	/* DS parameter set */
-	ie = rtw_set_ie(ie, _DSSET_IE_, 1, (u8 *)&(pdev_network->Configuration.DSConfig), &sz);
+	ie = rtw_set_ie(ie, _DSSET_IE_, 1, (u8 *)&pdev_network->Configuration.DSConfig, &sz);
 
 	/* IBSS Parameter Set */
 
-	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&(pdev_network->Configuration.ATIMWindow), &sz);
+	ie = rtw_set_ie(ie, _IBSS_PARA_IE_, 2, (u8 *)&pdev_network->Configuration.ATIMWindow, &sz);
 
 	if (rateLen > 8)
 		ie = rtw_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rateLen - 8), (pdev_network->SupportedRates + 8), &sz);
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 0e5ce12d4b57..927b8c919fa7 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -8,7 +8,7 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 	struct xmit_frame	*xmit_frame;
 	struct xmit_buf	*xmitbuf;
 	struct pkt_attrib	*pattrib;
-	struct xmit_priv	*pxmitpriv = &(adapter->xmitpriv);
+	struct xmit_priv	*pxmitpriv = &adapter->xmitpriv;
 
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
 	if (!xmit_frame) {
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index def0c250a4ac..7f7a7eddda4a 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -577,7 +577,7 @@ static int mp_xmit_packet_thread(void *context)
 	pmp_priv = (struct mp_priv *)context;
 	pmptx = &pmp_priv->tx;
 	padapter = pmp_priv->papdater;
-	pxmitpriv = &(padapter->xmitpriv);
+	pxmitpriv = &padapter->xmitpriv;
 
 	thread_enter("RTW_MP_THREAD");
 
@@ -596,7 +596,7 @@ static int mp_xmit_packet_thread(void *context)
 		}
 
 		memcpy((u8 *)(pxmitframe->buf_addr+TXDESC_OFFSET), pmptx->buf, pmptx->write_size);
-		memcpy(&(pxmitframe->attrib), &(pmptx->attrib), sizeof(struct pkt_attrib));
+		memcpy(&pxmitframe->attrib, &pmptx->attrib, sizeof(struct pkt_attrib));
 
 		dump_mpframe(padapter, pxmitframe);
 
@@ -625,7 +625,7 @@ static int mp_xmit_packet_thread(void *context)
 void fill_txdesc_for_mp(struct adapter *padapter, struct tx_desc *ptxdesc)
 {
 	struct mp_priv *pmp_priv = &padapter->mppriv;
-	memcpy(ptxdesc, &(pmp_priv->tx.desc), TXDESC_SIZE);
+	memcpy(ptxdesc, &pmp_priv->tx.desc, TXDESC_SIZE);
 }
 
 void SetPacketTx(struct adapter *padapter)
@@ -676,7 +676,7 @@ void SetPacketTx(struct adapter *padapter)
 	pmp_priv->tx.buf = (u8 *)N_BYTE_ALIGMENT((size_t)(pmp_priv->tx.pallocated_buf), XMITBUF_ALIGN_SZ);
 	ptr = pmp_priv->tx.buf;
 
-	desc = &(pmp_priv->tx.desc);
+	desc = &pmp_priv->tx.desc;
 	memset(desc, 0, TXDESC_SIZE);
 	pkt_start = ptr;
 	pkt_end = pkt_start + pkt_size;
@@ -954,7 +954,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 			goto exit;
 		}
 
-		list_add_tail(&pxmitbuf->list, &(pxmitpriv->free_xmit_extbuf_queue.queue));
+		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);
 		pxmitbuf++;
 	}
 
-- 
2.32.0


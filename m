Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BF83DCACB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhHAIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhHAIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 04:46:59 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F058C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 01:46:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b128so8568242wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Feq6kKajdQ/yOlneqiRaGIDZWkDkSRZ3LvIOdAe0NwQ=;
        b=J/CDbfTyV5o4i0LxL+LSB3/9vggDcHIpYIamBGhv5VXcG/fV7qn6jPptzQXrVeFdsJ
         MDvgK/8X5wNIYTWkfXpbJfMEdMfVaRnr5eSzfpOZGhRgSPtDaMFMjJXfTyqgyZX/Z5WA
         o+r+7veJAhfb982yU30fwTob2QAKus6e9MhfdqFiETdEaTINtRjX8//LG/u9BAPRViZ1
         R1xk1iD10Z5cgudJmVJVMW5Np+261s83RpfnU5ck/HkfreWoqsauhDBr1fc4/5+oGZ8w
         zTjKZ9QlLyZnZZ9XfwyKJpQLOYG+LH4pUvN58qtUHBEPUUFW8M5jL4bviw7tuWzYmCrt
         mUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Feq6kKajdQ/yOlneqiRaGIDZWkDkSRZ3LvIOdAe0NwQ=;
        b=t8+M0wRYVVqbRror4/amaVZGqEQZTvx3fbG5bKQ5as/CIIlUQEpxAezahPXACb3Aht
         KsveKPmInPNM3tvT4mwGH159dS4DVXfL2fUvlcUWZXMTISngIEouGg5PIlPtMQ9VYZBG
         5RnJ4jCrdKq0S8OVGSn0LhC51y0dQIRezG/wGjGeK+f4o/369tWQ1DZhyes1S5Brh5s5
         C5eRJOKHZif1BKByPs8FFq9Ah0tF2rUN5RK51uTD62F1CStzjCeyNFlXjlYW8L1se6P2
         scDZMM9GsufS1EwStoe35RJfCRxFUBlxFVkyA2g5xS+lXg/P2+/TrILWpRRt4dS1t3uS
         rmuQ==
X-Gm-Message-State: AOAM532XrlbeeJS/TzCypBqn5/ILbrqs2wNRmzzGyhlnb87c2OfI9cCF
        sbfq4DKEjX0VY5L6dX0RmHg=
X-Google-Smtp-Source: ABdhPJy/ojTcKMfbVmOjS5M16wV8Dqrhl7aWu89rB6mGWpkhHzxqiWTTxV0wbAn0JoxCZ7FRTDH0NA==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr11388614wmj.91.1627807608616;
        Sun, 01 Aug 2021 01:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4bf9])
        by smtp.gmail.com with ESMTPSA id p15sm6754975wmi.29.2021.08.01.01.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 01:46:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: clean up comparsions to NULL in core directory
Date:   Sun,  1 Aug 2021 10:46:14 +0200
Message-Id: <20210801084614.4328-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801084614.4328-1-straube.linux@gmail.com>
References: <20210801084614.4328-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up comparsions to NULL in the core directory reported by
checkpatch.

x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c        |  22 +--
 drivers/staging/r8188eu/core/rtw_br_ext.c    |  28 ++--
 drivers/staging/r8188eu/core/rtw_cmd.c       | 158 +++++++++----------
 drivers/staging/r8188eu/core/rtw_efuse.c     |   4 +-
 drivers/staging/r8188eu/core/rtw_ieee80211.c |  10 +-
 drivers/staging/r8188eu/core/rtw_io.c        |   2 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c |  10 +-
 drivers/staging/r8188eu/core/rtw_iol.c       |   4 +-
 drivers/staging/r8188eu/core/rtw_mlme.c      |  44 +++---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 134 ++++++++--------
 drivers/staging/r8188eu/core/rtw_mp.c        |  12 +-
 drivers/staging/r8188eu/core/rtw_p2p.c       |  16 +-
 drivers/staging/r8188eu/core/rtw_recv.c      |  44 +++---
 drivers/staging/r8188eu/core/rtw_security.c  |  14 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   |   8 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c |  10 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      |  40 ++---
 17 files changed, 280 insertions(+), 280 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 0bb545135206..d7b1a071928c 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -67,7 +67,7 @@ static void update_BCNTIM(struct adapter *padapter)
 		tim_bitmap_le = cpu_to_le16(pstapriv->tim_bitmap);
 
 		p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, _TIM_IE_, &tim_ielen, pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_);
-		if (p != NULL && tim_ielen > 0) {
+		if (p && tim_ielen > 0) {
 			tim_ielen += 2;
 			premainder_ie = p+tim_ielen;
 			tim_ie_offset = (int)(p - pie);
@@ -83,7 +83,7 @@ static void update_BCNTIM(struct adapter *padapter)
 
 			/*  get supported rates len */
 			p = rtw_get_ie(pie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_, &tmp_len, (pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_));
-			if (p !=  NULL)
+			if (p)
 				offset += tmp_len+2;
 
 			/* DS Parameter Set IE, len = 3 */
@@ -164,7 +164,7 @@ void rtw_add_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork, u8
 		i += (pIE->Length + 2);
 	}
 
-	if (p != NULL && ielen > 0) {
+	if (p && ielen > 0) {
 		ielen += 2;
 
 		premainder_ie = p+ielen;
@@ -211,7 +211,7 @@ void rtw_remove_bcn_ie(struct adapter *padapter, struct wlan_bssid_ex *pnetwork,
 
 	p = rtw_get_ie(pie + _FIXED_IE_LENGTH_, index, &ielen,
 		       pnetwork->IELength - _FIXED_IE_LENGTH_);
-	if (p != NULL && ielen > 0) {
+	if (p && ielen > 0) {
 		ielen += 2;
 
 		premainder_ie = p+ielen;
@@ -909,14 +909,14 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	memset(supportRate, 0, NDIS_802_11_LENGTH_RATES_EX);
 	/*  get supported rates */
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _SUPPORTEDRATES_IE_, &ie_len, (pbss_network->IELength - _BEACON_IE_OFFSET_));
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate, p+2, ie_len);
 		supportRateNum = ie_len;
 	}
 
 	/* get ext_supported rates */
 	p = rtw_get_ie(ie + _BEACON_IE_OFFSET_, _EXT_SUPPORTEDRATES_IE_, &ie_len, pbss_network->IELength - _BEACON_IE_OFFSET_);
-	if (p !=  NULL) {
+	if (p) {
 		memcpy(supportRate+supportRateNum, p+2, ie_len);
 		supportRateNum += ie_len;
 	}
@@ -978,7 +978,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 			}
 			break;
 		}
-		if ((p == NULL) || (ie_len == 0))
+		if (!p || ie_len == 0)
 			break;
 	}
 
@@ -1002,7 +1002,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 				break;
 			}
 
-			if ((p == NULL) || (ie_len == 0))
+			if (!p || ie_len == 0)
 				break;
 		}
 	}
@@ -1089,7 +1089,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
 	if (!psta) {
 		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
-		if (psta == NULL)
+		if (!psta)
 			return _FAIL;
 	}
 
@@ -1292,7 +1292,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 
 	pwps_ie = rtw_get_wps_ie(ie+_FIXED_IE_LENGTH_, ielen-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
-	if (pwps_ie == NULL || wps_ielen == 0)
+	if (!pwps_ie || wps_ielen == 0)
 		return;
 
 	wps_offset = (uint)(pwps_ie-ie);
@@ -1308,7 +1308,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	}
 
 	pwps_ie_src = pmlmepriv->wps_beacon_ie;
-	if (pwps_ie_src == NULL)
+	if (!pwps_ie_src)
 		return;
 
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 8f434768dd15..89fce9a5f783 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -336,7 +336,7 @@ static inline void __network_hash_link(struct adapter *priv,
 {
 	/*  Caller must spin_lock already! */
 	ent->next_hash = priv->nethash[hash];
-	if (ent->next_hash != NULL)
+	if (ent->next_hash)
 		ent->next_hash->pprev_hash = &ent->next_hash;
 	priv->nethash[hash] = ent;
 	ent->pprev_hash = &priv->nethash[hash];
@@ -346,7 +346,7 @@ static inline void __network_hash_unlink(struct nat25_network_db_entry *ent)
 {
 	/*  Caller must spin_lock already! */
 	*(ent->pprev_hash) = ent->next_hash;
-	if (ent->next_hash != NULL)
+	if (ent->next_hash)
 		ent->next_hash->pprev_hash = ent->pprev_hash;
 	ent->next_hash = NULL;
 	ent->pprev_hash = NULL;
@@ -360,7 +360,7 @@ static int __nat25_db_network_lookup_and_replace(struct adapter *priv,
 	spin_lock_bh(&priv->br_ext_lock);
 
 	db = priv->nethash[__nat25_network_hash(networkAddr)];
-	while (db != NULL) {
+	while (db) {
 		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
 			if (!__nat25_has_expired(priv, db)) {
 				/*  replace the destination mac address */
@@ -411,7 +411,7 @@ static void __nat25_db_network_insert(struct adapter *priv,
 	spin_lock_bh(&priv->br_ext_lock);
 	hash = __nat25_network_hash(networkAddr);
 	db = priv->nethash[hash];
-	while (db != NULL) {
+	while (db) {
 		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
 			memcpy(db->macAddr, macAddr, ETH_ALEN);
 			db->ageing_timer = jiffies;
@@ -421,7 +421,7 @@ static void __nat25_db_network_insert(struct adapter *priv,
 		db = db->next_hash;
 	}
 	db = (struct nat25_network_db_entry *) rtw_malloc(sizeof(*db));
-	if (db == NULL) {
+	if (!db) {
 		spin_unlock_bh(&priv->br_ext_lock);
 		return;
 	}
@@ -452,7 +452,7 @@ void nat25_db_cleanup(struct adapter *priv)
 	for (i = 0; i < NAT25_HASH_SIZE; i++) {
 		struct nat25_network_db_entry *f;
 		f = priv->nethash[i];
-		while (f != NULL) {
+		while (f) {
 			struct nat25_network_db_entry *g;
 
 			g = f->next_hash;
@@ -479,7 +479,7 @@ void nat25_db_expire(struct adapter *priv)
 		struct nat25_network_db_entry *f;
 		f = priv->nethash[i];
 
-		while (f != NULL) {
+		while (f) {
 			struct nat25_network_db_entry *g;
 			g = f->next_hash;
 
@@ -506,7 +506,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 	unsigned char networkAddr[MAX_NETWORK_ADDR_LEN];
 	unsigned int tmp;
 
-	if (skb == NULL)
+	if (!skb)
 		return -1;
 
 	if ((method <= NAT25_MIN) || (method >= NAT25_MAX))
@@ -675,7 +675,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		}
 
 		/*   IPX   */
-		if (ipx != NULL) {
+		if (ipx) {
 			switch (method) {
 			case NAT25_CHECK:
 				if (!memcmp(skb->data+ETH_ALEN, ipx->ipx_source.node, ETH_ALEN))
@@ -732,7 +732,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			default:
 				return -1;
 			}
-		} else if (ea != NULL) {
+		} else if (ea) {
 			/* Sanity check fields. */
 			if (ea->hw_len != ETH_ALEN || ea->pa_len != AARP_PA_ALEN) {
 				DEBUG_WARN("NAT25: Appletalk AARP Sanity check fail!\n");
@@ -775,7 +775,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 			default:
 				return -1;
 			}
-		} else if (ddp != NULL) {
+		} else if (ddp) {
 			switch (method) {
 			case NAT25_CHECK:
 				return -1;
@@ -900,7 +900,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 					int offset = 0;
 
 					ptr = __nat25_find_pppoe_tag(ph, ntohs(PTT_RELAY_SID));
-					if (ptr == NULL) {
+					if (!ptr) {
 						DEBUG_ERR("Fail to find PTT_RELAY_SID in FADO!\n");
 						return -1;
 					}
@@ -1132,7 +1132,7 @@ struct dhcpMessage {
 
 void dhcp_flag_bcast(struct adapter *priv, struct sk_buff *skb)
 {
-	if (skb == NULL)
+	if (!skb)
 		return;
 
 	if (!priv->ethBrExtInfo.dhcp_bcst_disable) {
@@ -1182,7 +1182,7 @@ void *scdb_findEntry(struct adapter *priv, unsigned char *macAddr,
 	__nat25_generate_ipv4_network_addr(networkAddr, (unsigned int *)ipAddr);
 	hash = __nat25_network_hash(networkAddr);
 	db = priv->nethash[hash];
-	while (db != NULL) {
+	while (db) {
 		if (!memcmp(db->networkAddr, networkAddr, MAX_NETWORK_ADDR_LEN)) {
 			return (void *)db;
 		}
diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 4e17972ee66e..c432cc6e1b4d 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -33,7 +33,7 @@ int	_rtw_init_cmd_priv (struct	cmd_priv *pcmdpriv)
 	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
 					      GFP_KERNEL);
 
-	if (pcmdpriv->cmd_allocated_buf == NULL) {
+	if (!pcmdpriv->cmd_allocated_buf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -42,7 +42,7 @@ int	_rtw_init_cmd_priv (struct	cmd_priv *pcmdpriv)
 
 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);
 
-	if (pcmdpriv->rsp_allocated_buf == NULL) {
+	if (!pcmdpriv->rsp_allocated_buf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -85,7 +85,7 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
 		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
-		if (c2h != NULL && c2h != (void *)pevtpriv)
+		if (c2h && c2h != (void *)pevtpriv)
 			kfree(c2h);
 	}
 	RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("-rtw_free_evt_priv\n"));
@@ -121,7 +121,7 @@ int	_rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
 {
 	unsigned long flags;
 
-	if (obj == NULL)
+	if (!obj)
 		goto exit;
 
 	spin_lock_irqsave(&queue->lock, flags);
@@ -207,7 +207,7 @@ u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 	int res = _FAIL;
 	struct adapter *padapter = pcmdpriv->padapter;
 
-	if (cmd_obj == NULL)
+	if (!cmd_obj)
 		goto exit;
 
 	cmd_obj->padapter = padapter;
@@ -253,7 +253,7 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 		kfree(pcmd->parmbuf);
 	}
 
-	if (pcmd->rsp != NULL) {
+	if (pcmd->rsp) {
 		if (pcmd->rspsz != 0) {
 			/* free rsp in cmd_obj */
 			kfree(pcmd->rsp);
@@ -337,7 +337,7 @@ int rtw_cmd_thread(void *context)
 		/* call callback function for post-processed */
 		if (pcmd->cmdcode < ARRAY_SIZE(rtw_cmd_callback)) {
 			pcmd_callback = rtw_cmd_callback[pcmd->cmdcode].callback;
-			if (pcmd_callback == NULL) {
+			if (!pcmd_callback) {
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, ("mlme_cmd_hdl(): pcmd_callback = 0x%p, cmdcode = 0x%x\n", pcmd_callback, pcmd->cmdcode));
 				rtw_free_cmd_obj(pcmd);
 			} else {
@@ -358,7 +358,7 @@ int rtw_cmd_thread(void *context)
 	/*  free all cmd_obj resources */
 	do {
 		pcmd = rtw_dequeue_cmd(pcmdpriv);
-		if (pcmd == NULL)
+		if (!pcmd)
 			break;
 
 		/* DBG_88E("%s: leaving... drop cmdcode:%u\n", __func__, pcmd->cmdcode); */
@@ -380,13 +380,13 @@ u8 rtw_setstandby_cmd(struct adapter *padapter, uint action)
 	u8 ret = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		ret = _FAIL;
 		goto exit;
 	}
 
 	psetusbsuspend = kzalloc(sizeof(struct usb_suspend_parm), GFP_ATOMIC);
-	if (psetusbsuspend == NULL) {
+	if (!psetusbsuspend) {
 		kfree(ph2c);
 		ret = _FAIL;
 		goto exit;
@@ -426,11 +426,11 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	}
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL)
+	if (!ph2c)
 		return _FAIL;
 
 	psurveyPara = kzalloc(sizeof(struct sitesurvey_parm), GFP_ATOMIC);
-	if (psurveyPara == NULL) {
+	if (!psurveyPara) {
 		kfree(ph2c);
 		return _FAIL;
 	}
@@ -499,13 +499,13 @@ u8 rtw_setdatarate_cmd(struct adapter *padapter, u8 *rateset)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pbsetdataratepara = kzalloc(sizeof(struct setdatarate_parm), GFP_ATOMIC);
-	if (pbsetdataratepara == NULL) {
+	if (!pbsetdataratepara) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -528,13 +528,13 @@ u8 rtw_setbasicrate_cmd(struct adapter *padapter, u8 *rateset)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 	pssetbasicratepara = kzalloc(sizeof(struct setbasicrate_parm), GFP_ATOMIC);
 
-	if (pssetbasicratepara == NULL) {
+	if (!pssetbasicratepara) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -565,13 +565,13 @@ u8 rtw_setphy_cmd(struct adapter *padapter, u8 modem, u8 ch)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 		}
 	psetphypara = kzalloc(sizeof(struct setphy_parm), GFP_ATOMIC);
 
-	if (psetphypara == NULL) {
+	if (!psetphypara) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -598,13 +598,13 @@ u8 rtw_setbbreg_cmd(struct adapter *padapter, u8 offset, u8 val)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 		}
 	pwritebbparm = kzalloc(sizeof(struct writeBB_parm), GFP_ATOMIC);
 
-	if (pwritebbparm == NULL) {
+	if (!pwritebbparm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -629,13 +629,13 @@ u8 rtw_getbbreg_cmd(struct adapter  *padapter, u8 offset, u8 *pval)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 		}
 	prdbbparm = kzalloc(sizeof(struct readBB_parm), GFP_ATOMIC);
 
-	if (prdbbparm == NULL) {
+	if (!prdbbparm) {
 		kfree(ph2c);
 		return _FAIL;
 	}
@@ -663,13 +663,13 @@ u8 rtw_setrfreg_cmd(struct adapter  *padapter, u8 offset, u32 val)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 	pwriterfparm = kzalloc(sizeof(struct writeRF_parm), GFP_ATOMIC);
 
-	if (pwriterfparm == NULL) {
+	if (!pwriterfparm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -694,13 +694,13 @@ u8 rtw_getrfreg_cmd(struct adapter  *padapter, u8 offset, u8 *pval)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	prdrfparm = kzalloc(sizeof(struct readRF_parm), GFP_ATOMIC);
-	if (prdrfparm == NULL) {
+	if (!prdrfparm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -762,7 +762,7 @@ u8 rtw_createbss_cmd(struct adapter  *padapter)
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_, (" createbss for SSid:%s\n", pmlmepriv->assoc_ssid.Ssid));
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -787,7 +787,7 @@ u8 rtw_createbss_cmd_ex(struct adapter  *padapter, unsigned char *pbss, unsigned
 	u8	res = _SUCCESS;
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -831,7 +831,7 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 
 	pcmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("rtw_joinbss_cmd: memory allocate for cmd_obj fail!!!\n"));
 		goto exit;
@@ -856,8 +856,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 	}
 
 	psecnetwork = (struct wlan_bssid_ex *)&psecuritypriv->sec_bss;
-	if (psecnetwork == NULL) {
-		if (pcmd != NULL)
+	if (!psecnetwork) {
+		if (pcmd)
 			kfree(pcmd);
 
 		res = _FAIL;
@@ -954,7 +954,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 
 	/* prepare cmd parameter */
 	param = kzalloc(sizeof(*param), GFP_ATOMIC);
-	if (param == NULL) {
+	if (!param) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -963,7 +963,7 @@ u8 rtw_disassoc_cmd(struct adapter *padapter, u32 deauth_timeout_ms, bool enqueu
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		cmdobj = kzalloc(sizeof(*cmdobj), GFP_ATOMIC);
-		if (cmdobj == NULL) {
+		if (!cmdobj) {
 			res = _FAIL;
 			kfree(param);
 			goto exit;
@@ -991,13 +991,13 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infra n
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = false;
 		goto exit;
 	}
 	psetop = kzalloc(sizeof(struct setopmode_parm), GFP_KERNEL);
 
-	if (psetop == NULL) {
+	if (!psetop) {
 		kfree(ph2c);
 		res = false;
 		goto exit;
@@ -1026,20 +1026,20 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, u8 *psta, u8 unicast_key)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	psetstakey_para = kzalloc(sizeof(struct set_stakey_parm), GFP_KERNEL);
-	if (psetstakey_para == NULL) {
+	if (!psetstakey_para) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
 	}
 
 	psetstakey_rsp = kzalloc(sizeof(struct set_stakey_rsp), GFP_KERNEL);
-	if (psetstakey_rsp == NULL) {
+	if (!psetstakey_rsp) {
 		kfree(ph2c);
 		kfree(psetstakey_para);
 		res = _FAIL;
@@ -1085,14 +1085,14 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue)
 		clear_cam_entry(padapter, entry);
 	} else {
 		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		psetstakey_para = kzalloc(sizeof(struct set_stakey_parm),
 					  GFP_ATOMIC);
-		if (psetstakey_para == NULL) {
+		if (!psetstakey_para) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
@@ -1100,7 +1100,7 @@ u8 rtw_clearstakey_cmd(struct adapter *padapter, u8 *psta, u8 entry, u8 enqueue)
 
 		psetstakey_rsp = kzalloc(sizeof(struct set_stakey_rsp),
 					 GFP_ATOMIC);
-		if (psetstakey_rsp == NULL) {
+		if (!psetstakey_rsp) {
 			kfree(ph2c);
 			kfree(psetstakey_para);
 			res = _FAIL;
@@ -1132,13 +1132,13 @@ u8 rtw_setrttbl_cmd(struct adapter  *padapter, struct setratable_parm *prate_tab
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 	psetrttblparm = kzalloc(sizeof(struct setratable_parm), GFP_KERNEL);
 
-	if (psetrttblparm == NULL) {
+	if (!psetrttblparm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1162,13 +1162,13 @@ u8 rtw_getrttbl_cmd(struct adapter  *padapter, struct getratable_rsp *pval)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 	pgetrttblparm = kzalloc(sizeof(struct getratable_parm), GFP_KERNEL);
 
-	if (pgetrttblparm == NULL) {
+	if (!pgetrttblparm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1201,20 +1201,20 @@ u8 rtw_setassocsta_cmd(struct adapter  *padapter, u8 *mac_addr)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	psetassocsta_para = kzalloc(sizeof(struct set_assocsta_parm), GFP_ATOMIC);
-	if (psetassocsta_para == NULL) {
+	if (!psetassocsta_para) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
 	}
 
 	psetassocsta_rsp = kzalloc(sizeof(struct set_assocsta_rsp), GFP_ATOMIC);
-	if (psetassocsta_rsp == NULL) {
+	if (!psetassocsta_rsp) {
 		kfree(ph2c);
 		kfree(psetassocsta_para);
 		return _FAIL;
@@ -1241,13 +1241,13 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	paddbareq_parm = kzalloc(sizeof(struct addBaReq_parm), GFP_ATOMIC);
-	if (paddbareq_parm == NULL) {
+	if (!paddbareq_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1276,13 +1276,13 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1316,7 +1316,7 @@ u8 rtw_set_ch_cmd(struct adapter *padapter, u8 ch, u8 bw, u8 ch_offset, u8 enque
 
 	/* prepare cmd parameter */
 	set_ch_parm = kzalloc(sizeof(*set_ch_parm), GFP_ATOMIC);
-	if (set_ch_parm == NULL) {
+	if (!set_ch_parm) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -1327,7 +1327,7 @@ u8 rtw_set_ch_cmd(struct adapter *padapter, u8 ch, u8 bw, u8 ch_offset, u8 enque
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-		if (pcmdobj == NULL) {
+		if (!pcmdobj) {
 			kfree(set_ch_parm);
 			res = _FAIL;
 			goto exit;
@@ -1371,7 +1371,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 	/* prepare cmd parameter */
 	setChannelPlan_param = kzalloc(sizeof(struct SetChannelPlan_param),
 				       GFP_KERNEL);
-	if (setChannelPlan_param == NULL) {
+	if (!setChannelPlan_param) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -1380,7 +1380,7 @@ u8 rtw_set_chplan_cmd(struct adapter *padapter, u8 chplan, u8 enqueue)
 	if (enqueue) {
 		/* need enqueue, prepare cmd_obj and enqueue */
 		pcmdobj = kzalloc(sizeof(struct	cmd_obj), GFP_KERNEL);
-		if (pcmdobj == NULL) {
+		if (!pcmdobj) {
 			kfree(setChannelPlan_param);
 			res = _FAIL;
 			goto exit;
@@ -1416,13 +1416,13 @@ u8 rtw_led_blink_cmd(struct adapter *padapter, struct LED_871x *pLed)
 	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_led_blink_cmd\n"));
 
 	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (pcmdobj == NULL) {
+	if (!pcmdobj) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	ledBlink_param = kzalloc(sizeof(struct LedBlink_param), GFP_ATOMIC);
-	if (ledBlink_param == NULL) {
+	if (!ledBlink_param) {
 		kfree(pcmdobj);
 		res = _FAIL;
 		goto exit;
@@ -1449,14 +1449,14 @@ u8 rtw_set_csa_cmd(struct adapter *padapter, u8 new_ch_no)
 	RT_TRACE(_module_rtl871x_cmd_c_, _drv_notice_, ("+rtw_set_csa_cmd\n"));
 
 	pcmdobj = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (pcmdobj == NULL) {
+	if (!pcmdobj) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	setChannelSwitch_param = kzalloc(sizeof(struct	SetChannelSwitch_param),
 					 GFP_ATOMIC);
-	if (setChannelSwitch_param == NULL) {
+	if (!setChannelSwitch_param) {
 		kfree(pcmdobj);
 		res = _FAIL;
 		goto exit;
@@ -1614,14 +1614,14 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
 
 	if (enqueue) {
 		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm),
 					     GFP_ATOMIC);
-		if (pdrvextra_cmd_parm == NULL) {
+		if (!pdrvextra_cmd_parm) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
@@ -1657,14 +1657,14 @@ u8 rtw_rpt_timer_cfg_cmd(struct adapter *padapter, u16 min_time)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm),
 				     GFP_ATOMIC);
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1699,14 +1699,14 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
 
 	if (enqueue) {
 		ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm),
 					     GFP_KERNEL);
-		if (pdrvextra_cmd_parm == NULL) {
+		if (!pdrvextra_cmd_parm) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
@@ -1744,13 +1744,13 @@ u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
 		return res;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1779,13 +1779,13 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	u8	res = _SUCCESS;
 
 	ppscmd = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ppscmd == NULL) {
+	if (!ppscmd) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ppscmd);
 		res = _FAIL;
 		goto exit;
@@ -1852,13 +1852,13 @@ u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -1884,13 +1884,13 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
 	u8	res = _SUCCESS;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	pdrvextra_cmd_parm = kzalloc(sizeof(struct drvextra_cmd_parm), GFP_ATOMIC);
-	if (pdrvextra_cmd_parm == NULL) {
+	if (!pdrvextra_cmd_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
@@ -2103,7 +2103,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		psta = rtw_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
 		if (!psta) {
 			psta = rtw_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
-			if (psta == NULL) {
+			if (!psta) {
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nCan't alloc sta_info when createbss_cmd_callback\n"));
 				goto createbss_cmd_fail ;
 			}
@@ -2114,9 +2114,9 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 
 		pwlan = _rtw_alloc_network(pmlmepriv);
 		spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
-		if (pwlan == NULL) {
+		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
-			if (pwlan == NULL) {
+			if (!pwlan) {
 				RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\n Error:  can't get pwlan in rtw_joinbss_event_callback\n"));
 				spin_unlock_bh(&(pmlmepriv->scanned_queue.lock));
 				goto createbss_cmd_fail;
@@ -2151,7 +2151,7 @@ void rtw_setstaKey_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *pc
 	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: rtw_setstaKey_cmdrsp_callback => can't get sta_info\n\n"));
 		goto exit;
 	}
@@ -2168,7 +2168,7 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *)(pcmd->rsp);
 	struct sta_info *psta = rtw_get_stainfo(pstapriv, passocsta_parm->addr);
 
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nERROR: setassocsta_cmdrsp_callbac => can't get sta_info\n\n"));
 		goto exit;
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index e84540a7d2c5..9e9085aab952 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -534,7 +534,7 @@ u8 rtw_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 		return _FAIL;
 
 	map = rtw_zmalloc(mapLen);
-	if (map == NULL)
+	if (!map)
 		return _FAIL;
 
 	ret = rtw_efuse_map_read(padapter, 0, mapLen, map);
@@ -626,7 +626,7 @@ u8 rtw_BT_efuse_map_write(struct adapter *padapter, u16 addr, u16 cnts, u8 *data
 		return _FAIL;
 
 	map = rtw_zmalloc(mapLen);
-	if (map == NULL)
+	if (!map)
 		return _FAIL;
 
 	ret = rtw_BT_efuse_map_read(padapter, 0, mapLen, map);
diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index f5ea93e2fff9..2c626dda3e5d 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -705,7 +705,7 @@ u8 rtw_is_wps_ie(u8 *ie_ptr, uint *wps_ielen)
 	u8 match = false;
 	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
 
-	if (ie_ptr == NULL)
+	if (!ie_ptr)
 		return match;
 
 	eid = ie_ptr[0];
@@ -1075,7 +1075,7 @@ u8 key_2char2num(u8 hch, u8 lch)
 void rtw_macaddr_cfg(u8 *mac_addr)
 {
 	u8 mac[ETH_ALEN];
-	if (mac_addr == NULL)
+	if (!mac_addr)
 		return;
 
 	if (rtw_initmac) {	/* Users specify the mac address */
@@ -1183,7 +1183,7 @@ u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen)
 	u8 *p2p_ie_ptr;
 	u8 eid, p2p_oui[4] = {0x50, 0x6F, 0x9A, 0x09};
 
-	if (p2p_ielen != NULL)
+	if (p2p_ielen)
 		*p2p_ielen = 0;
 
 	while (cnt < in_len) {
@@ -1195,9 +1195,9 @@ u8 *rtw_get_p2p_ie(u8 *in_ie, int in_len, u8 *p2p_ie, uint *p2p_ielen)
 		if ((eid == _VENDOR_SPECIFIC_IE_) && !memcmp(&in_ie[cnt+2], p2p_oui, 4)) {
 			p2p_ie_ptr = in_ie + cnt;
 
-			if (p2p_ie != NULL)
+			if (p2p_ie)
 				memcpy(p2p_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
-			if (p2p_ielen != NULL)
+			if (p2p_ielen)
 				*p2p_ielen = in_ie[cnt + 1] + 2;
 			return p2p_ie_ptr;
 		} else {
diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 2c8e7707c9fa..85d1f7deda23 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -294,7 +294,7 @@ int rtw_init_io_priv(struct adapter *padapter, void (*set_intf_ops)(struct _io_o
 	struct io_priv	*piopriv = &padapter->iopriv;
 	struct intf_hdl *pintf = &piopriv->intf;
 
-	if (set_intf_ops == NULL)
+	if (!set_intf_ops)
 		return _FAIL;
 
 	piopriv->padapter = padapter;
diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 778da7c86995..3e2add5409cc 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -435,7 +435,7 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("+rtw_set_802_11_bssid_list_scan(), fw_state =%x\n", get_fwstate(pmlmepriv)));
 
-	if (padapter == NULL) {
+	if (!padapter) {
 		res = false;
 		goto exit;
 	}
@@ -568,7 +568,7 @@ u8 rtw_set_802_11_remove_wep(struct adapter *padapter, u32 keyindex)
 {
 	u8 ret = _SUCCESS;
 
-	if (keyindex >= 0x80000000 || padapter == NULL) {
+	if (keyindex >= 0x80000000 || !padapter) {
 		ret = false;
 		goto exit;
 	} else {
@@ -622,7 +622,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		pbssid = get_bssid(&padapter->mlmepriv);
 		stainfo = rtw_get_stainfo(&padapter->stapriv, pbssid);
 
-		if ((stainfo != NULL) && (padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X)) {
+		if (stainfo && padapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 				 ("OID_802_11_ADD_KEY:(stainfo!=NULL)&&(Adapter->securitypriv.dot11AuthAlgrthm==dot11AuthAlgrthm_8021X)\n"));
 			encryptionalgo = stainfo->dot118021XPrivacy;
@@ -641,7 +641,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 			 ("rtw_set_802_11_add_key: (Adapter->securitypriv.dot11AuthAlgrthm==%d)!\n",
 			 padapter->securitypriv.dot11AuthAlgrthm));
 
-		if ((stainfo != NULL))
+		if (stainfo)
 			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_,
 				 ("rtw_set_802_11_add_key: (stainfo->dot118021XPrivacy==%d)!\n",
 				 stainfo->dot118021XPrivacy));
@@ -898,7 +898,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		pbssid = get_bssid(&padapter->mlmepriv);
 		stainfo = rtw_get_stainfo(&padapter->stapriv, pbssid);
 
-		if (stainfo != NULL) {
+		if (stainfo) {
 			memset(&stainfo->dot118021x_UncstKey, 0, 16);/*  clear keybuffer */
 
 			memcpy(&stainfo->dot118021x_UncstKey, key->KeyMaterial, 16);
diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 0382ff524657..0e5ce12d4b57 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -11,13 +11,13 @@ struct xmit_frame	*rtw_IOL_accquire_xmit_frame(struct adapter  *adapter)
 	struct xmit_priv	*pxmitpriv = &(adapter->xmitpriv);
 
 	xmit_frame = rtw_alloc_xmitframe(pxmitpriv);
-	if (xmit_frame == NULL) {
+	if (!xmit_frame) {
 		DBG_88E("%s rtw_alloc_xmitframe return null\n", __func__);
 		goto exit;
 	}
 
 	xmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-	if (xmitbuf == NULL) {
+	if (!xmitbuf) {
 		DBG_88E("%s rtw_alloc_xmitbuf return null\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, xmit_frame);
 		xmit_frame = NULL;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d692f1477cc8..af4b7053686f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -58,7 +58,7 @@ int	_rtw_init_mlme_priv (struct adapter *padapter)
 
 	pbuf = rtw_zvmalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
 
-	if (pbuf == NULL) {
+	if (!pbuf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -143,7 +143,7 @@ void _rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
 int	_rtw_enqueue_network(struct __queue *queue, struct wlan_network *pnetwork)
 {
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		goto exit;
 
 	spin_lock_bh(&queue->lock);
@@ -215,7 +215,7 @@ void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwor
 	u32 lifetime = SCANQUEUE_LIFETIME;
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		return;
 
 	if (pnetwork->fixed)
@@ -240,7 +240,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 {
 	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
 
-	if (pnetwork == NULL)
+	if (!pnetwork)
 		return;
 	if (pnetwork->fixed)
 		return;
@@ -470,7 +470,7 @@ struct	wlan_network	*rtw_get_oldest_wlan_network(struct __queue *scanned_queue)
 		pwlan = container_of(plist, struct wlan_network, list);
 
 		if (!pwlan->fixed) {
-			if (oldest == NULL || time_after(oldest->last_scanned, pwlan->last_scanned))
+			if (!oldest || time_after(oldest->last_scanned, pwlan->last_scanned))
 				oldest = pwlan;
 		}
 
@@ -588,7 +588,7 @@ void rtw_update_scanned_network(struct adapter *adapter, struct wlan_bssid_ex *t
 
 			pnetwork = rtw_alloc_network(pmlmepriv); /*  will update scan_time */
 
-			if (pnetwork == NULL) {
+			if (!pnetwork) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("\n\n\nsomething wrong here\n\n\n"));
 				goto exit;
 			}
@@ -663,7 +663,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen) != NULL)
+		if (rtw_get_wps_ie(pnetwork->network.IEs+_FIXED_IE_LENGTH_, pnetwork->network.IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -1039,7 +1039,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	psta = rtw_get_stainfo(pstapriv, pnetwork->network.MacAddress);
-	if (psta == NULL)
+	if (!psta)
 		psta = rtw_alloc_stainfo(pstapriv, pnetwork->network.MacAddress);
 
 	if (psta) { /* update ptarget_sta */
@@ -1231,7 +1231,7 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 			/* s3. find ptarget_sta & update ptarget_sta after update cur_network only for station mode */
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
 				ptarget_sta = rtw_joinbss_update_stainfo(adapter, pnetwork);
-				if (ptarget_sta == NULL) {
+				if (!ptarget_sta) {
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't update stainfo when joinbss_event callback\n"));
 					spin_unlock_bh(&pmlmepriv->scanned_queue.lock);
 					goto ignore_joinbss_callback;
@@ -1301,7 +1301,7 @@ static u8 search_max_mac_id(struct adapter *padapter)
 #if defined (CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		for (aid = (pstapriv->max_num_sta); aid > 0; aid--) {
-			if (pstapriv->sta_aid[aid-1] != NULL)
+			if (pstapriv->sta_aid[aid-1])
 				break;
 		}
 		mac_id = aid + 1;
@@ -1323,7 +1323,7 @@ void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta,
 	u16 media_status_rpt;
 	u8 macid;
 
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	macid = search_max_mac_id(adapter);
@@ -1355,13 +1355,13 @@ void rtw_stassoc_event_callback(struct adapter *adapter, u8 *pbuf)
 #endif
 	/* for AD-HOC mode */
 	psta = rtw_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta != NULL) {
+	if (psta) {
 		/* the sta have been in sta_info_queue => do nothing */
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Error: rtw_stassoc_event_callback: sta has been in sta_hash_queue\n"));
 		return; /* between drv has received this event before and  fw have not yet to set key to CAM_ENTRY) */
 	}
 	psta = rtw_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Can't alloc sta_info when rtw_stassoc_event_callback\n"));
 		return;
 	}
@@ -1657,7 +1657,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 			goto exit;
 	}
 
-	if (*candidate == NULL || (*candidate)->network.Rssi < competitor->network.Rssi) {
+	if (!*candidate || (*candidate)->network.Rssi < competitor->network.Rssi) {
 		*candidate = competitor;
 		updated = true;
 	}
@@ -1698,7 +1698,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	pmlmepriv->pscanned = phead->next;
 	while (phead != pmlmepriv->pscanned) {
 		pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
-		if (pnetwork == NULL) {
+		if (!pnetwork) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("%s return _FAIL:(pnetwork==NULL)\n", __func__));
 			ret = _FAIL;
 			goto exit;
@@ -1706,7 +1706,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		pmlmepriv->pscanned = pmlmepriv->pscanned->next;
 		rtw_check_join_candidate(pmlmepriv, &candidate, pnetwork);
 	}
-	if (candidate == NULL) {
+	if (!candidate) {
 		DBG_88E("%s: return _FAIL(candidate==NULL)\n", __func__);
 		ret = _FAIL;
 		goto exit;
@@ -1751,13 +1751,13 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 	int		res = _SUCCESS;
 
 	pcmd = (struct	cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
 
 	psetauthparm = (struct setauth_parm *)rtw_zmalloc(sizeof(struct setauth_parm));
-	if (psetauthparm == NULL) {
+	if (!psetauthparm) {
 		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
@@ -1789,12 +1789,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	int	res = _SUCCESS;
 
 	pcmd = (struct	cmd_obj *)rtw_zmalloc(sizeof(struct	cmd_obj));
-	if (pcmd == NULL) {
+	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
 	psetkeyparm = (struct setkey_parm *)rtw_zmalloc(sizeof(struct setkey_parm));
-	if (psetkeyparm == NULL) {
+	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
 		goto exit;
@@ -2276,7 +2276,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 	else
 		psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
-	if (psta == NULL)
+	if (!psta)
 		return;
 
 	phtpriv = &psta->htpriv;
@@ -2308,7 +2308,7 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 
 	struct wlan_network *pnetwork;
 
-	if (tgt_network != NULL)
+	if (tgt_network)
 		pnetwork = tgt_network;
 	else
 		pnetwork = &pmlmepriv->cur_network;
diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 1160b7caffdd..00650888a2e3 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -289,7 +289,7 @@ static void init_channel_list(struct adapter *padapter, struct rt_channel_info *
 			    ((BW40MINUS == o->bw) || (BW40PLUS == o->bw)))
 				continue;
 
-			if (reg == NULL) {
+			if (!reg) {
 				reg = &channel_list->reg_class[cla];
 				cla++;
 				reg->reg_class = o->op_class;
@@ -442,7 +442,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	}
 	ptable += index;
 
-	if (psta != NULL) {
+	if (psta) {
 		if (GetRetry(pframe)) {
 			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum) {
 				/* drop the duplicate management frame */
@@ -570,7 +570,7 @@ unsigned int OnProbeReq(struct adapter *padapter, struct recv_frame *precv_frame
 			len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_);
 
 	/* check (wildcard) SSID */
-	if (p != NULL) {
+	if (p) {
 		if (is_valid_p2p_probereq)
 			goto _issue_probersp;
 
@@ -685,7 +685,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 
 		if (((pmlmeinfo->state&0x03) == WIFI_FW_STATION_STATE) && (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS)) {
 			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
-			if (psta != NULL) {
+			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
 						DBG_88E_LEVEL(_drv_info_, "ap has changed, disconnect now\n ");
@@ -700,7 +700,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			}
 		} else if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
 			psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
-			if (psta != NULL) {
+			if (psta) {
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
 				if ((sta_rx_pkts(psta) & 0xf) == 0)
@@ -781,11 +781,11 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 	}
 
 	pstat = rtw_get_stainfo(pstapriv, sa);
-	if (pstat == NULL) {
+	if (!pstat) {
 		/*  allocate a new one */
 		DBG_88E("going to alloc stainfo for sa=%pM\n", sa);
 		pstat = rtw_alloc_stainfo(pstapriv, sa);
-		if (pstat == NULL) {
+		if (!pstat) {
 			DBG_88E(" Exceed the upper limit of supported clients...\n");
 			status = _STATS_UNABLE_HANDLE_STA_;
 			goto auth_fail;
@@ -850,7 +850,7 @@ unsigned int OnAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + 4 + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&ie_len,
 					len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_ - 4);
 
-			if ((p == NULL) || (ie_len <= 0)) {
+			if (!p || ie_len <= 0) {
 				DBG_88E("auth rejected because challenge failure!(1)\n");
 				status = _STATS_CHALLENGE_FAIL_;
 				goto auth_fail;
@@ -947,7 +947,7 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, _CHLGETXT_IE_, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (p == NULL)
+			if (!p)
 				goto authclnt_fail;
 
 			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
@@ -1065,7 +1065,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 	/*  checking SSID */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
 		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (p == NULL)
+	if (!p)
 		status = _STATS_FAILURE_;
 
 	if (ie_len == 0) { /*  broadcast ssid, however it is not allowed in assocreq */
@@ -1084,7 +1084,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 	/*  check if the supported rate is ok */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SUPPORTEDRATES_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (p == NULL) {
+	if (!p) {
 		DBG_88E("Rx a sta assoc-req which supported rate is empty!\n");
 		/*  use our own rate set as statoin used */
 		/* memcpy(supportRate, AP_BSSRATE, AP_BSSRATE_LEN); */
@@ -1098,7 +1098,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 
 		p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _EXT_SUPPORTEDRATES_IE_, &ie_len,
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-		if (p !=  NULL) {
+		if (p) {
 			if (supportRateNum <= sizeof(supportRate)) {
 				memcpy(supportRate+supportRateNum, p+2, ie_len);
 				supportRateNum += ie_len;
@@ -1173,7 +1173,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		goto OnAssocReqFail;
 
 	pstat->flags &= ~(WLAN_STA_WPS | WLAN_STA_MAYBE_WPS);
-	if (wpa_ie == NULL) {
+	if (!wpa_ie) {
 		if (elems.wps_ie) {
 			DBG_88E("STA included WPS IE in "
 				   "(Re)Association Request - assume WPS is "
@@ -1243,7 +1243,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		p = pframe + WLAN_HDR_A3_LEN + ie_offset; ie_len = 0;
 		for (;;) {
 			p = rtw_get_ie(p, _VENDOR_SPECIFIC_IE_, &ie_len, pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-			if (p != NULL) {
+			if (p) {
 				if (!memcmp(p+2, WMM_IE, 6)) {
 					pstat->flags |= WLAN_STA_WME;
 
@@ -1357,7 +1357,7 @@ unsigned int OnAssocReq(struct adapter *padapter, struct recv_frame *precv_frame
 		DBG_88E("  old AID %d\n", pstat->aid);
 	} else {
 		for (pstat->aid = 1; pstat->aid <= NUM_STA; pstat->aid++)
-			if (pstapriv->sta_aid[pstat->aid - 1] == NULL)
+			if (!pstapriv->sta_aid[pstat->aid - 1])
 				break;
 
 		/* if (pstat->aid > NUM_STA) { */
@@ -1753,7 +1753,7 @@ unsigned int OnAction_back(struct adapter *padapter, struct recv_frame *precv_fr
 	addr = GetAddr2Ptr(pframe);
 	psta = rtw_get_stainfo(pstapriv, addr);
 
-	if (psta == NULL)
+	if (!psta)
 		return _SUCCESS;
 
 	frame_body = (unsigned char *)(pframe + sizeof(struct rtw_ieee80211_hdr_3addr));
@@ -1839,7 +1839,7 @@ void issue_p2p_GO_request(struct adapter *padapter, u8 *raddr)
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	DBG_88E("[%s] In\n", __func__);
@@ -2177,7 +2177,7 @@ static void issue_p2p_GO_response(struct adapter *padapter, u8 *raddr, u8 *frame
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	DBG_88E("[%s] In, result=%d\n", __func__,  result);
@@ -2536,7 +2536,7 @@ static void issue_p2p_GO_confirm(struct adapter *padapter, u8 *raddr, u8 result)
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	DBG_88E("[%s] In\n", __func__);
@@ -2700,7 +2700,7 @@ void issue_p2p_invitation_request(struct adapter *padapter, u8 *raddr)
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -2948,7 +2948,7 @@ void issue_p2p_invitation_response(struct adapter *padapter, u8 *raddr, u8 dialo
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -3141,7 +3141,7 @@ void issue_p2p_provision_request(struct adapter *padapter, u8 *pssid, u8 ussidle
 	struct wifidirect_info	*pwdinfo = &(padapter->wdinfo);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	DBG_88E("[%s] In\n", __func__);
@@ -3254,7 +3254,7 @@ void issue_probersp_p2p(struct adapter *padapter, unsigned char *da)
 	u32					wpsielen = 0, p2pielen = 0;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -3502,7 +3502,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -3571,7 +3571,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 	/*	Value: */
 	wpsie[wpsielen++] = WPS_VERSION_1;	/*	Version 1.0 */
 
-	if (pmlmepriv->wps_probe_req_ie == NULL) {
+	if (!pmlmepriv->wps_probe_req_ie) {
 		/*	UUID-E */
 		/*	Type: */
 		*(__be16 *)(wpsie + wpsielen) = cpu_to_be16(WPS_ATTR_UUID_E);
@@ -3749,7 +3749,7 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 
 	pframe = rtw_set_ie(pframe, _VENDOR_SPECIFIC_IE_, p2pielen, (unsigned char *)p2pie, &pattrib->pktlen);
 
-	if (pmlmepriv->wps_probe_req_ie != NULL) {
+	if (pmlmepriv->wps_probe_req_ie) {
 		/* WPS IE */
 		memcpy(pframe, pmlmepriv->wps_probe_req_ie, pmlmepriv->wps_probe_req_ie_len);
 		pattrib->pktlen += pmlmepriv->wps_probe_req_ie_len;
@@ -4282,13 +4282,13 @@ struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv)
 	struct xmit_buf				*pxmitbuf;
 
 	pmgntframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		DBG_88E("%s, alloc xmitframe fail\n", __func__);
 		return NULL;
 	}
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
-	if (pxmitbuf == NULL) {
+	if (!pxmitbuf) {
 		DBG_88E("%s, alloc xmitbuf fail\n", __func__);
 		rtw_free_xmitframe(pxmitpriv, pmgntframe);
 		return NULL;
@@ -4450,7 +4450,7 @@ void issue_beacon(struct adapter *padapter, int timeout_ms)
 #endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
@@ -4679,7 +4679,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 #endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL) {
+	if (!pmgntframe) {
 		DBG_88E("%s, alloc mgnt frame fail\n", __func__);
 		return;
 	}
@@ -4718,7 +4718,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		pwps_ie = rtw_get_wps_ie(cur_network->IEs+_FIXED_IE_LENGTH_, cur_network->IELength-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 		/* inerset & update wps_probe_resp_ie */
-		if ((pmlmepriv->wps_probe_resp_ie != NULL) && pwps_ie && (wps_ielen > 0)) {
+		if (pmlmepriv->wps_probe_resp_ie && pwps_ie && wps_ielen > 0) {
 			uint wps_offset, remainder_ielen;
 			u8 *premainder_ie;
 
@@ -4836,7 +4836,7 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+issue_probereq\n"));
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -4972,7 +4972,7 @@ void issue_auth(struct adapter *padapter, struct sta_info *psta, unsigned short
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -5111,7 +5111,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 	DBG_88E("%s\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -5193,7 +5193,7 @@ void issue_asocrsp(struct adapter *padapter, unsigned short status, struct sta_i
 				break;
 			}
 
-			if ((pbuf == NULL) || (ie_len == 0))
+			if (!pbuf || ie_len == 0)
 				break;
 		}
 	}
@@ -5249,7 +5249,7 @@ void issue_assocreq(struct adapter *padapter)
 #endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -5343,13 +5343,13 @@ void issue_assocreq(struct adapter *padapter)
 
 	/* RSN */
 	p = rtw_get_ie((pmlmeinfo->network.IEs + sizeof(struct ndis_802_11_fixed_ie)), _RSN_IE_2_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
-	if (p != NULL)
+	if (p)
 		pframe = rtw_set_ie(pframe, _RSN_IE_2_, ie_len, (p + 2), &(pattrib->pktlen));
 
 	/* HT caps */
 	if (padapter->mlmepriv.htpriv.ht_option) {
 		p = rtw_get_ie((pmlmeinfo->network.IEs + sizeof(struct ndis_802_11_fixed_ie)), _HT_CAPABILITY_IE_, &ie_len, (pmlmeinfo->network.IELength - sizeof(struct ndis_802_11_fixed_ie)));
-		if ((p != NULL) && (!(is_ap_in_tkip(padapter)))) {
+		if (p && !is_ap_in_tkip(padapter)) {
 			memcpy(&(pmlmeinfo->HT_caps), (p + 2), sizeof(struct HT_caps_element));
 
 			/* to disable 40M Hz support while gd_bw_40MHz_en = 0 */
@@ -5581,7 +5581,7 @@ static int _issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned
 	pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -5640,7 +5640,7 @@ int issue_nulldata(struct adapter *padapter, unsigned char *da, unsigned int pow
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	/* da == NULL, assum it's null data for sta to ap*/
-	if (da == NULL)
+	if (!da)
 		da = get_my_bssid(&(pmlmeinfo->network));
 
 	do {
@@ -5691,7 +5691,7 @@ static int _issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16
 	DBG_88E("%s\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -5763,7 +5763,7 @@ int issue_qos_nulldata(struct adapter *padapter, unsigned char *da, u16 tid, int
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	/* da == NULL, assum it's null data for sta to ap*/
-	if (da == NULL)
+	if (!da)
 		da = get_my_bssid(&(pmlmeinfo->network));
 
 	do {
@@ -5821,7 +5821,7 @@ static int _issue_deauth(struct adapter *padapter, unsigned char *da, unsigned s
 #endif /* CONFIG_88EU_P2P */
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	/* update attribute */
@@ -5922,7 +5922,7 @@ void issue_action_spct_ch_switch (struct adapter *padapter, u8 *ra, u8 new_ch, u
 		FUNC_NDEV_ARG(padapter->pnetdev), ra, new_ch, ch_offset);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -5992,7 +5992,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 	DBG_88E("%s, category=%d, action=%d, status=%d\n", __func__, category, action, status);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -6039,7 +6039,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr, unsigned ch
 			pframe = rtw_set_fixed_ie(pframe, 2, (unsigned char *)(&(le_tmp)), &(pattrib->pktlen));
 
 			psta = rtw_get_stainfo(pstapriv, raddr);
-			if (psta != NULL) {
+			if (psta) {
 				start_seq = (psta->sta_xmitpriv.txseq_tid[status & 0x07]&0xfff) + 1;
 
 				DBG_88E("BA_starting_seqctrl=%d for TID=%d\n", start_seq, status & 0x07);
@@ -6131,7 +6131,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 	action = ACT_PUBLIC_BSSCOEXIST;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -6191,7 +6191,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 			pbss_network = (struct wlan_bssid_ex *)&pnetwork->network;
 
 			p = rtw_get_ie(pbss_network->IEs + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->IELength - _FIXED_IE_LENGTH_);
-			if ((p == NULL) || (len == 0)) { /* non-HT */
+			if (!p || len == 0) { /* non-HT */
 				if ((pbss_network->Configuration.DSConfig <= 0) || (pbss_network->Configuration.DSConfig > 14))
 					continue;
 
@@ -6245,7 +6245,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 			return _SUCCESS;
 
 	psta = rtw_get_stainfo(pstapriv, addr);
-	if (psta == NULL)
+	if (!psta)
 		return _SUCCESS;
 
 	if (initiator == 0) { /*  recipient */
@@ -6531,7 +6531,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SSID_IE_, &len, bssid->IELength - ie_offset);
-	if (p == NULL) {
+	if (!p) {
 		DBG_88E("marc: cannot find SSID for survey event\n");
 		return _FAIL;
 	}
@@ -6552,7 +6552,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	/* checking rate info... */
 	i = 0;
 	p = rtw_get_ie(bssid->IEs + ie_offset, _SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
-	if (p != NULL) {
+	if (p) {
 		if (len > NDIS_802_11_LENGTH_RATES_EX) {
 			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
@@ -6562,7 +6562,7 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	}
 
 	p = rtw_get_ie(bssid->IEs + ie_offset, _EXT_SUPPORTEDRATES_IE_, &len, bssid->IELength - ie_offset);
-	if (p != NULL) {
+	if (p) {
 		if (len > (NDIS_802_11_LENGTH_RATES_EX-i)) {
 			DBG_88E("%s()-%d: IE too long (%d) for survey event\n", __func__, __LINE__, len);
 			return _FAIL;
@@ -6991,12 +6991,12 @@ void report_survey_event(struct adapter *padapter, struct recv_frame *precv_fram
 	pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct survey_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -7043,12 +7043,12 @@ void report_surveydone_event(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct surveydone_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -7089,12 +7089,12 @@ void report_join_res(struct adapter *padapter, int res)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct joinbss_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -7140,12 +7140,12 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr, unsi
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct stadel_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -7194,12 +7194,12 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr, int
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	pcmd_obj = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (pcmd_obj == NULL)
+	if (!pcmd_obj)
 		return;
 
 	cmdsz = (sizeof(struct stassoc_event) + sizeof(struct C2HEvent_Header));
 	pevtcmd = (u8 *)rtw_zmalloc(cmdsz);
-	if (pevtcmd == NULL) {
+	if (!pevtcmd) {
 		kfree(pcmd_obj);
 		return;
 	}
@@ -7484,7 +7484,7 @@ void linked_status_chk(struct adapter *padapter)
 
 		rx_chk_limit = 4;
 		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress);
-		if (psta != NULL) {
+		if (psta) {
 			bool is_p2p_enable = false;
 			#ifdef CONFIG_88EU_P2P
 			is_p2p_enable = !rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE);
@@ -7617,11 +7617,11 @@ void survey_timer_hdl(struct adapter *padapter)
 		}
 
 		ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL)
+		if (!ph2c)
 			goto exit_survey_timer_hdl;
 
 		psurveyPara = (struct sitesurvey_parm *)rtw_zmalloc(sizeof(struct sitesurvey_parm));
-		if (psurveyPara == NULL) {
+		if (!psurveyPara) {
 			kfree(ph2c);
 			goto exit_survey_timer_hdl;
 		}
@@ -8194,13 +8194,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	int len_diff = 0;
 
 	ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-	if (ph2c == NULL) {
+	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
 	ptxBeacon_parm = (struct Tx_Beacon_param *)rtw_zmalloc(sizeof(struct Tx_Beacon_param));
-	if (ptxBeacon_parm == NULL) {
+	if (!ptxBeacon_parm) {
 		kfree(ph2c);
 		res = _FAIL;
 		goto exit;
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index 1b4e9bbc394b..1065e9e8a015 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -382,7 +382,7 @@ s32 mp_start_test(struct adapter *padapter)
 		rtw_free_stainfo(padapter, psta);
 
 	psta = rtw_alloc_stainfo(&padapter->stapriv, bssid.MacAddress);
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_mp_, _drv_err_, ("mp_start_test: Can't alloc sta_info!\n"));
 		pmlmepriv->fw_state = pmppriv->prev_fw_state;
 		res = _FAIL;
@@ -547,11 +547,11 @@ static struct xmit_frame *alloc_mp_xmitframe(struct xmit_priv *pxmitpriv)
 	struct xmit_buf	*pxmitbuf;
 
 	pmpframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (pmpframe == NULL)
+	if (!pmpframe)
 		return NULL;
 
 	pxmitbuf = rtw_alloc_xmitbuf(pxmitpriv);
-	if (pxmitbuf == NULL) {
+	if (!pxmitbuf) {
 		rtw_free_xmitframe(pxmitpriv, pmpframe);
 		return NULL;
 	}
@@ -585,7 +585,7 @@ static int mp_xmit_packet_thread(void *context)
 	/* DBG_88E("%s:pkTx Start\n", __func__); */
 	while (1) {
 		pxmitframe = alloc_mp_xmitframe(pxmitpriv);
-		if (pxmitframe == NULL) {
+		if (!pxmitframe) {
 			if (pmptx->stop ||
 			    padapter->bSurpriseRemoved ||
 			    padapter->bDriverStopped) {
@@ -670,7 +670,7 @@ void SetPacketTx(struct adapter *padapter)
 	pmp_priv->tx.write_size = pkt_size;
 	pmp_priv->tx.buf_size = pkt_size + XMITBUF_ALIGN_SZ;
 	pmp_priv->tx.pallocated_buf = rtw_zmalloc(pmp_priv->tx.buf_size);
-	if (pmp_priv->tx.pallocated_buf == NULL) {
+	if (!pmp_priv->tx.pallocated_buf) {
 		DBG_88E("%s: malloc(%d) fail!!\n", __func__, pmp_priv->tx.buf_size);
 		return;
 	}
@@ -938,7 +938,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 
 	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
-	if (pxmitpriv->pallocated_xmit_extbuf  == NULL) {
+	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 30823bfdd1b5..ce30161535c1 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -128,7 +128,7 @@ static void issue_group_disc_req(struct wifidirect_info *pwdinfo, u8 *da)
 	DBG_88E("[%s]\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -187,7 +187,7 @@ static void issue_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *da, u8 s
 	DBG_88E("[%s]\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -257,7 +257,7 @@ static void issue_p2p_provision_resp(struct wifidirect_info *pwdinfo, u8 *raddr,
 	struct mlme_ext_priv	*pmlmeext = &(padapter->mlmeextpriv);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -336,7 +336,7 @@ static void issue_p2p_presence_resp(struct wifidirect_info *pwdinfo, u8 *da, u8
 	DBG_88E("[%s]\n", __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -792,13 +792,13 @@ u32 process_probe_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 	if (rtw_p2p_chk_role(pwdinfo, P2P_ROLE_DEVICE) || rtw_p2p_chk_role(pwdinfo, P2P_ROLE_GO)) {
 		p2pie = rtw_get_p2p_ie(pframe + WLAN_HDR_A3_LEN + _PROBEREQ_IE_OFFSET_, len - WLAN_HDR_A3_LEN - _PROBEREQ_IE_OFFSET_, NULL, &p2pielen);
 		if (p2pie) {
-			if ((p != NULL) && !memcmp((void *)(p+2), (void *)pwdinfo->p2p_wildcard_ssid, 7)) {
+			if (p && !memcmp((void *)(p+2), (void *)pwdinfo->p2p_wildcard_ssid, 7)) {
 				/* todo: */
 				/* Check Requested Device Type attributes in WSC IE. */
 				/* Check Device ID attribute in P2P IE */
 
 				ret = true;
-			} else if ((p != NULL) && (ssid_len == 0)) {
+			} else if (p && ssid_len == 0) {
 				ret = true;
 			}
 		} else {
@@ -1700,13 +1700,13 @@ u8 p2p_ps_wk_cmd(struct adapter *padapter, u8 p2p_ps_state, u8 enqueue)
 
 	if (enqueue) {
 		ph2c = (struct cmd_obj *)rtw_zmalloc(sizeof(struct cmd_obj));
-		if (ph2c == NULL) {
+		if (!ph2c) {
 			res = _FAIL;
 			goto exit;
 		}
 
 		pdrvextra_cmd_parm = (struct drvextra_cmd_parm *)rtw_zmalloc(sizeof(struct drvextra_cmd_parm));
-		if (pdrvextra_cmd_parm == NULL) {
+		if (!pdrvextra_cmd_parm) {
 			kfree(ph2c);
 			res = _FAIL;
 			goto exit;
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 610cc699caf9..37cf22569c59 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -60,7 +60,7 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 	precvpriv->pallocated_frame_buf = rtw_zvmalloc(NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
 
-	if (precvpriv->pallocated_frame_buf == NULL) {
+	if (!precvpriv->pallocated_frame_buf) {
 		res = _FAIL;
 		goto exit;
 	}
@@ -141,7 +141,7 @@ struct recv_frame *_rtw_alloc_recvframe (struct __queue *pfree_recv_queue)
 
 		list_del_init(&hdr->list);
 		padapter = hdr->adapter;
-		if (padapter != NULL) {
+		if (padapter) {
 			precvpriv = &padapter->recvpriv;
 			if (pfree_recv_queue == &precvpriv->free_recv_queue)
 				precvpriv->free_recvframe_cnt--;
@@ -194,7 +194,7 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
 
 	list_add_tail(&(precvframe->list), get_list_head(pfree_recv_queue));
 
-	if (padapter != NULL) {
+	if (padapter) {
 		if (pfree_recv_queue == &precvpriv->free_recv_queue)
 				precvpriv->free_recvframe_cnt++;
 	}
@@ -212,7 +212,7 @@ int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
 	list_del_init(&(precvframe->list));
 	list_add_tail(&(precvframe->list), get_list_head(queue));
 
-	if (padapter != NULL) {
+	if (padapter) {
 		if (queue == &precvpriv->free_recv_queue)
 			precvpriv->free_recvframe_cnt++;
 	}
@@ -347,7 +347,7 @@ static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvfr
 			 prxattrib->ra[0], prxattrib->ra[1], prxattrib->ra[2], prxattrib->ra[3], prxattrib->ra[4], prxattrib->ra[5]));
 
 		/* calculate mic code */
-		if (stainfo != NULL) {
+		if (stainfo) {
 			if (IS_MCAST(prxattrib->ra)) {
 				mickey = &psecuritypriv->dot118021XGrprxmickey[prxattrib->key_index].skey[0];
 
@@ -541,7 +541,7 @@ static struct recv_frame *portctrl(struct adapter *adapter, struct recv_frame *p
 		 adapter->securitypriv.dot11AuthAlgrthm));
 
 	if (auth_alg == 2) {
-		if ((psta != NULL) && (psta->ieee8021x_blocked)) {
+		if (psta && psta->ieee8021x_blocked) {
 			/* blocked */
 			/* only accept EAPOL frame */
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("########portctrl:psta->ieee8021x_blocked==1\n"));
@@ -805,7 +805,7 @@ int sta2sta_data_frame(struct adapter *adapter, struct recv_frame *precv_frame,
 	else
 		*psta = rtw_get_stainfo(pstapriv, sta_addr); /*  get ap_info */
 
-	if (*psta == NULL) {
+	if (!*psta) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under sta2sta_data_frame ; drop pkt\n"));
 		if (adapter->registrypriv.mp_mode == 1) {
 			if (check_fwstate(pmlmepriv, WIFI_MP_STATE) == true)
@@ -874,7 +874,7 @@ static int ap2sta_data_frame (
 		else
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get ap_info */
 
-		if (*psta == NULL) {
+		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("ap2sta: can't get psta under STATION_MODE ; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
@@ -901,7 +901,7 @@ static int ap2sta_data_frame (
 		memcpy(pattrib->bssid,  mybssid, ETH_ALEN);
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-		if (*psta == NULL) {
+		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under MP_MODE ; drop pkt\n"));
 			ret = _FAIL;
 			goto exit;
@@ -913,7 +913,7 @@ static int ap2sta_data_frame (
 	} else {
 		if (!memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && (!bmcast)) {
 			*psta = rtw_get_stainfo(pstapriv, pattrib->bssid); /*  get sta_info */
-			if (*psta == NULL) {
+			if (!*psta) {
 				DBG_88E("issue_deauth to the ap =%pM for the reason(7)\n", (pattrib->bssid));
 
 				issue_deauth(adapter, pattrib->bssid, WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA);
@@ -947,7 +947,7 @@ static int sta2ap_data_frame(struct adapter *adapter,
 		}
 
 		*psta = rtw_get_stainfo(pstapriv, pattrib->src);
-		if (*psta == NULL) {
+		if (!*psta) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("can't get psta under AP_MODE; drop pkt\n"));
 			DBG_88E("issue_deauth to sta=%pM for the reason(7)\n", (pattrib->src));
 
@@ -1011,7 +1011,7 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 		aid = GetAid(pframe);
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 
-		if ((psta == NULL) || (psta->aid != aid))
+		if (!psta || psta->aid != aid)
 			return _FAIL;
 
 		/* for rx pkt statistics */
@@ -1119,7 +1119,7 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 	RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("+validate_recv_mgnt_frame\n"));
 
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
-	if (precv_frame == NULL) {
+	if (!precv_frame) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_notice_, ("%s: fragment packet\n", __func__));
 		return _SUCCESS;
 	}
@@ -1164,7 +1164,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	psa = get_sa(ptr);
 	pbssid = get_hdr_bssid(ptr);
 
-	if (pbssid == NULL) {
+	if (!pbssid) {
 		ret = _FAIL;
 		goto exit;
 	}
@@ -1207,7 +1207,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 		goto exit;
 	}
 
-	if (psta == NULL) {
+	if (!psta) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, (" after to_fr_ds_chk; psta==NULL\n"));
 		ret = _FAIL;
 		goto exit;
@@ -1547,7 +1547,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 
 	psta_addr = pfhdr->attrib.ta;
 	psta = rtw_get_stainfo(pstapriv, psta_addr);
-	if (psta == NULL) {
+	if (!psta) {
 		u8 type = GetFrameType(pfhdr->rx_data);
 		if (type != WIFI_DATA_TYPE) {
 			psta = rtw_get_bcmc_stainfo(padapter);
@@ -1565,7 +1565,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 	if (ismfrag == 1) {
 		/* 0~(n-1) fragment frame */
 		/* enqueue to defraf_g */
-		if (pdefrag_q != NULL) {
+		if (pdefrag_q) {
 			if (fragnum == 0) {
 				/* the first fragment */
 				if (!list_empty(&pdefrag_q->queue)) {
@@ -1594,7 +1594,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 	if ((ismfrag == 0) && (fragnum != 0)) {
 		/* the last fragment frame */
 		/* enqueue the last fragment */
-		if (pdefrag_q != NULL) {
+		if (pdefrag_q) {
 			phead = get_list_head(pdefrag_q);
 			list_add_tail(&pfhdr->list, phead);
 
@@ -1611,7 +1611,7 @@ struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_fr
 		}
 	}
 
-	if ((prtnframe != NULL) && (prtnframe->attrib.privacy)) {
+	if (prtnframe && prtnframe->attrib.privacy) {
 		/* after defrag we must check tkip mic code */
 		if (recvframe_chkmic(padapter,  prtnframe) == _FAIL) {
 			RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chkmic(padapter,  prtnframe)==_FAIL\n"));
@@ -2054,20 +2054,20 @@ static int recv_func_posthandle(struct adapter *padapter, struct recv_frame *prf
 	rtw_led_control(padapter, LED_CTL_RX);
 
 	prframe = decryptor(padapter, prframe);
-	if (prframe == NULL) {
+	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("decryptor: drop pkt\n"));
 		ret = _FAIL;
 		goto _recv_data_drop;
 	}
 
 	prframe = recvframe_chk_defrag(padapter, prframe);
-	if (prframe == NULL) {
+	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("recvframe_chk_defrag: drop pkt\n"));
 		goto _recv_data_drop;
 	}
 
 	prframe = portctrl(padapter, prframe);
-	if (prframe == NULL) {
+	if (!prframe) {
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_err_, ("portctrl: drop pkt\n"));
 		ret = _FAIL;
 		goto _recv_data_drop;
diff --git a/drivers/staging/r8188eu/core/rtw_security.c b/drivers/staging/r8188eu/core/rtw_security.c
index 2c1b9a6dcdf2..66c730a5d754 100644
--- a/drivers/staging/r8188eu/core/rtw_security.c
+++ b/drivers/staging/r8188eu/core/rtw_security.c
@@ -95,7 +95,7 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return;
 
 	hw_hdr_offset = TXDESC_SIZE +
@@ -542,7 +542,7 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	u32	res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_SIZE +
@@ -555,7 +555,7 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		else
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
-		if (stainfo != NULL) {
+		if (stainfo) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_tkip_encrypt: stainfo!= NULL!!!\n"));
 
 			if (IS_MCAST(pattrib->ra))
@@ -631,7 +631,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 	/* 4 start to decrypt recvframe */
 	if (prxattrib->encrypt == _TKIP_) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
-		if (stainfo != NULL) {
+		if (stainfo) {
 			if (IS_MCAST(prxattrib->ra)) {
 				if (!psecuritypriv->binstallGrpkey) {
 					res = _FAIL;
@@ -1202,7 +1202,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 /*	uint	offset = 0; */
 	u32 res = _SUCCESS;
 
-	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
+	if (!((struct xmit_frame *)pxmitframe)->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_SIZE +
@@ -1217,7 +1217,7 @@ u32	rtw_aes_encrypt(struct adapter *padapter, u8 *pxmitframe)
 		else
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
-		if (stainfo != NULL) {
+		if (stainfo) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_encrypt: stainfo!= NULL!!!\n"));
 
 			if (IS_MCAST(pattrib->ra))
@@ -1456,7 +1456,7 @@ u32	rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
 	/* 4 start to encrypt each fragment */
 	if ((prxattrib->encrypt == _AES_)) {
 		stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
-		if (stainfo != NULL) {
+		if (stainfo) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("rtw_aes_decrypt: stainfo!= NULL!!!\n"));
 
 			if (IS_MCAST(prxattrib->ra)) {
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index feaf39fddf7c..93cd1db1ba2a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -153,7 +153,7 @@ void rtw_mfree_stainfo(struct sta_info *psta);
 void rtw_mfree_stainfo(struct sta_info *psta)
 {
 
-	if (&psta->lock != NULL)
+	if (&psta->lock)
 		 _rtw_spinlock_free(&psta->lock);
 
 	_rtw_free_sta_xmit_priv_lock(&psta->sta_xmitpriv);
@@ -333,7 +333,7 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	struct	xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct	sta_priv *pstapriv = &padapter->stapriv;
 
-	if (psta == NULL)
+	if (!psta)
 		goto exit;
 
 	pfree_sta_queue = &pstapriv->free_sta_queue;
@@ -488,7 +488,7 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	u8 *addr;
 	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	if (hwaddr == NULL)
+	if (!hwaddr)
 		return NULL;
 
 	if (IS_MCAST(hwaddr))
@@ -528,7 +528,7 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
 
-	if (psta == NULL) {
+	if (!psta) {
 		res = _FAIL;
 		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
 		goto exit;
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 15edccef9f1d..db133ffad8f9 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -740,7 +740,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
 
-	if (pIE == NULL)
+	if (!pIE)
 		return;
 
 	if (!phtpriv->ht_option)
@@ -787,7 +787,7 @@ void HT_info_handler(struct adapter *padapter, struct ndis_802_11_var_ie *pIE)
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv			*phtpriv = &pmlmepriv->htpriv;
 
-	if (pIE == NULL)
+	if (!pIE)
 		return;
 
 	if (!phtpriv->ht_option)
@@ -986,7 +986,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 
 	/* checking SSID */
 	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-	if (p == NULL) {
+	if (!p) {
 		DBG_88E("%s marc: cannot find SSID for survey event\n", __func__);
 		hidden_ssid = true;
 	} else {
@@ -1590,7 +1590,7 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
 	pIE = (struct ndis_802_11_var_ie *)rtw_get_ie(pvar_ie, _SUPPORTEDRATES_IE_, &ie_len, var_ie_len);
-	if (pIE == NULL)
+	if (!pIE)
 		return _FAIL;
 
 	memcpy(pmlmeinfo->FW_sta_info[cam_idx].SupportedRates, pIE->data, ie_len);
@@ -1657,7 +1657,7 @@ int rtw_handle_dualmac(struct adapter *adapter, bool init)
 	int status = _SUCCESS;
 
 	if (init) {
-		if (pbuddy_padapter == NULL) {
+		if (!pbuddy_padapter) {
 			pbuddy_padapter = adapter;
 			DBG_88E("%s(): pbuddy_padapter == NULL, Set pbuddy_padapter\n", __func__);
 		} else {
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4a5393184737..3b61eb651ee4 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -74,7 +74,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_frame_buf = rtw_zvmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
 
-	if (pxmitpriv->pallocated_frame_buf  == NULL) {
+	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_frame fail!\n"));
 		res = _FAIL;
@@ -112,7 +112,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_xmitbuf = rtw_zvmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
 
-	if (pxmitpriv->pallocated_xmitbuf  == NULL) {
+	if (!pxmitpriv->pallocated_xmitbuf) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_buf fail!\n"));
 		res = _FAIL;
 		goto exit;
@@ -154,7 +154,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->pallocated_xmit_extbuf = rtw_zvmalloc(num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
 
-	if (pxmitpriv->pallocated_xmit_extbuf  == NULL) {
+	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("alloc xmit_extbuf fail!\n"));
 		res = _FAIL;
 		goto exit;
@@ -238,7 +238,7 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 
 	rtw_mfree_xmit_priv_lock(pxmitpriv);
 
-	if (pxmitpriv->pxmit_frame_buf == NULL)
+	if (!pxmitpriv->pxmit_frame_buf)
 		return;
 
 	for (i = 0; i < NR_XMITFRAME; i++) {
@@ -509,7 +509,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		psta = rtw_get_bcmc_stainfo(padapter);
 	} else {
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
-		if (psta == NULL) { /*  if we cannot get psta => drrp the pkt */
+		if (!psta) { /*  if we cannot get psta => drrp the pkt */
 			RT_TRACE(_module_rtl871x_xmit_c_, _drv_alert_, ("\nupdate_attrib => get sta_info fail, ra: %pM\n", (pattrib->ra)));
 			res = _FAIL;
 			goto exit;
@@ -656,7 +656,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 	if (pattrib->encrypt == _TKIP_) {/* if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_PRIVACY_) */
 		/* encode mic code */
-		if (stainfo != NULL) {
+		if (stainfo) {
 			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
 					   0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
 					   0x0, 0x0};
@@ -992,10 +992,10 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 	psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
 
-	if (psta == NULL)
+	if (!psta)
 		return _FAIL;
 
-	if (pxmitframe->buf_addr == NULL) {
+	if (!pxmitframe->buf_addr) {
 		DBG_88E("==> %s buf_addr == NULL\n", __func__);
 		return _FAIL;
 	}
@@ -1033,7 +1033,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 		/* adding icv, if necessary... */
 		if (pattrib->iv_len) {
-			if (psta != NULL) {
+			if (psta) {
 				switch (pattrib->encrypt) {
 				case _WEP40_:
 				case _WEP104_:
@@ -1177,7 +1177,7 @@ void rtw_update_protection(struct adapter *padapter, u8 *ie, uint ie_len)
 	case AUTO_VCS:
 	default:
 		perp = rtw_get_ie(ie, _ERPINFO_IE_, &erp_len, ie_len);
-		if (perp == NULL) {
+		if (!perp) {
 			pxmitpriv->vcs = NONE_VCS;
 		} else {
 			protection = (*(perp + 2)) & BIT(1);
@@ -1236,7 +1236,7 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		list_del_init(&(pxmitbuf->list));
 	}
 
-	if (pxmitbuf !=  NULL) {
+	if (pxmitbuf) {
 		pxmitpriv->free_xmit_extbuf_cnt--;
 
 		pxmitbuf->priv_data = NULL;
@@ -1258,7 +1258,7 @@ s32 rtw_free_xmitbuf_ext(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	struct __queue *pfree_queue = &pxmitpriv->free_xmit_extbuf_queue;
 	unsigned long flags;
 
-	if (pxmitbuf == NULL)
+	if (!pxmitbuf)
 		return _FAIL;
 
 	spin_lock_irqsave(&pfree_queue->lock, flags);
@@ -1296,7 +1296,7 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		list_del_init(&(pxmitbuf->list));
 	}
 
-	if (pxmitbuf !=  NULL) {
+	if (pxmitbuf) {
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
 		if (pxmitbuf->sctx) {
@@ -1314,7 +1314,7 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 	unsigned long flags;
 
-	if (pxmitbuf == NULL)
+	if (!pxmitbuf)
 		return _FAIL;
 
 	if (pxmitbuf->sctx) {
@@ -1377,7 +1377,7 @@ struct xmit_frame *rtw_alloc_xmitframe(struct xmit_priv *pxmitpriv)/* _queue *pf
 		list_del_init(&(pxframe->list));
 	}
 
-	if (pxframe !=  NULL) { /* default value setting */
+	if (pxframe) { /* default value setting */
 		pxmitpriv->free_xmitframe_cnt--;
 
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_info_, ("rtw_alloc_xmitframe():free_xmitframe_cnt=%d\n", pxmitpriv->free_xmitframe_cnt));
@@ -1408,7 +1408,7 @@ s32 rtw_free_xmitframe(struct xmit_priv *pxmitpriv, struct xmit_frame *pxmitfram
 	struct adapter *padapter = pxmitpriv->adapter;
 	struct sk_buff *pndis_pkt = NULL;
 
-	if (pxmitframe == NULL) {
+	if (!pxmitframe) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("====== rtw_free_xmitframe():pxmitframe == NULL!!!!!!!!!!\n"));
 		goto exit;
 	}
@@ -1598,7 +1598,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 	}
 
-	if (psta == NULL) {
+	if (!psta) {
 		res = _FAIL;
 		DBG_88E("rtw_xmit_classifier: psta == NULL\n");
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("rtw_xmit_classifier: psta == NULL\n"));
@@ -1727,7 +1727,7 @@ static int rtw_br_client_tx(struct adapter *padapter, struct sk_buff **pskb)
 				}
 
 				newskb = skb_copy(skb, GFP_ATOMIC);
-				if (newskb == NULL) {
+				if (!newskb) {
 					DEBUG_ERR("TX DROP: skb_copy fail!\n");
 					return -1;
 				}
@@ -1847,7 +1847,7 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	s32 res;
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
-	if (pxmitframe == NULL) {
+	if (!pxmitframe) {
 		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit: no more pxmitframe\n"));
 		DBG_88E("DBG_TX_DROP_FRAME %s no more pxmitframe\n", __func__);
 		return -1;
@@ -1912,7 +1912,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	else
 		psta = rtw_get_stainfo(pstapriv, pattrib->ra);
 
-	if (psta == NULL)
+	if (!psta)
 		return ret;
 
 	if (pattrib->triggered == 1) {
-- 
2.32.0


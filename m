Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA283E4A4D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhHIQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhHIQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52425C0617A5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:50:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k29so9524465wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wi9hit69AMU9xd7kbX7D4SFkU3MLCw+kNRZsei2hvrY=;
        b=mxKDnnmrf5NenEJrM+A6IyVbvoh4RWmOw3zqNoFl24tbrNnuPO3Rhxj0ZoyKo97ojs
         JHuvK/2t37RxbguYilsdqmyTub4Ad2mcZDGdIikT6ko1uKEYlVnq7hi9pjmOrU56BIQ9
         R530zJSZXBI9xVH9sQXtKDtEi7Ki79d7hrFu30bZSLdG4QTAnO4OjoApZ8bdNYPzL3lF
         dEEMrNn3ti2vBZL527QpTtkz6Jotb4cGOKrjiNrlGSEPLCqLYf9xt/iQtk5kTZIbwXl1
         LUbOG+gqNTwCDBMFyXsbOy2lfM2MdGqJb6PSZeZDKjlfIcitCYGw8GIKBVKAC9suvq0E
         t9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wi9hit69AMU9xd7kbX7D4SFkU3MLCw+kNRZsei2hvrY=;
        b=boHALfASFifSbVfjbXD8+oS4cGo/BiJVVnDBUJ3vwQJ90FI0fwVh7e01A6EAgr2XDH
         C6vz1L4viQfVUPbPZP4JH8pacutFLWPIYI5RteGGXEwZ1efcWwzwK1lak5RNtagy3gru
         dnZDGytuZWb+ia8FE1c5CpPOK31xcyjKpMRgsA4msnzrislYc6y9A555xHLlmLOdvkfw
         zgQX/EQfzrmwvu9aA8n2KG9+iAjNGTcvfc4/KEiG5RzbREasM4EIecIVV6fKtCwcQuWL
         UncZCOZRb2+efghzhtatrQuTzJyXwCuHGLYjsI/7txSTaGXxx0WkOMrnpb1dVZPA3eOh
         wi0A==
X-Gm-Message-State: AOAM5310xxqriuWqF6enR1hktneie+Bd1dB36ZV/caBcrNJgA2rbh03R
        GlTMrLz4kANVZ89p+yhSJho=
X-Google-Smtp-Source: ABdhPJzQRUKR84eAghjTIjQX6/HaJ5yUh8mhMppVXdql05mPpiBVho9vz2SlQWJApth9+gvEq+nxzQ==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr25717698wro.416.1628527857933;
        Mon, 09 Aug 2021 09:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::996b])
        by smtp.gmail.com with ESMTPSA id q5sm20484469wrx.33.2021.08.09.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 09:50:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 15/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_ioctl_set.c
Date:   Mon,  9 Aug 2021 18:50:05 +0200
Message-Id: <20210809165007.23204-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210809165007.23204-1-straube.linux@gmail.com>
References: <20210809165007.23204-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses in core/rtw_ioctl_set.c reported by
checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 41c14a4cff1f..35a4a9e222e6 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -40,8 +40,8 @@ u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	u8 *pibss = NULL;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct __queue *queue	= &(pmlmepriv->scanned_queue);
+	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	u8 ret = _SUCCESS;
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
@@ -88,7 +88,7 @@ u8 rtw_do_join(struct adapter *padapter)
 				/*  submit createbss_cmd to change to a ADHOC_MASTER */
 
 				/* pmlmepriv->lock has been acquired by caller... */
-				struct wlan_bssid_ex    *pdev_network = &(padapter->registrypriv.dev_network);
+				struct wlan_bssid_ex    *pdev_network = &padapter->registrypriv.dev_network;
 
 				pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
@@ -301,7 +301,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 {
 	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct	wlan_network	*cur_network = &pmlmepriv->cur_network;
-	enum ndis_802_11_network_infra *pold_state = &(cur_network->network.InfrastructureMode);
+	enum ndis_802_11_network_infra *pold_state = &cur_network->network.InfrastructureMode;
 
 	if (*pold_state != networktype) {
 		spin_lock_bh(&pmlmepriv->lock);
@@ -435,7 +435,7 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 {
 	int		keyid, res;
-	struct security_priv *psecuritypriv = &(padapter->securitypriv);
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u8		ret = _SUCCESS;
 
 	keyid = wep->KeyIndex & 0x3fffffff;
@@ -457,7 +457,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		break;
 	}
 
-	memcpy(&(psecuritypriv->dot11DefKey[keyid].skey[0]), &(wep->KeyMaterial), wep->KeyLength);
+	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0], &wep->KeyMaterial, wep->KeyLength);
 
 	psecuritypriv->dot11DefKeylen[keyid] = wep->KeyLength;
 
@@ -481,7 +481,7 @@ u8 rtw_set_802_11_remove_wep(struct adapter *padapter, u32 keyindex)
 		goto exit;
 	} else {
 		int res;
-		struct security_priv *psecuritypriv = &(padapter->securitypriv);
+		struct security_priv *psecuritypriv = &padapter->securitypriv;
 		if (keyindex < 4) {
 			memset(&psecuritypriv->dot11DefKey[keyindex], 0, 16);
 			res = rtw_set_key(padapter, psecuritypriv, keyindex, 0);
@@ -628,7 +628,7 @@ u8 rtw_set_802_11_add_key(struct adapter *padapter, struct ndis_802_11_key *key)
 		wep->KeyLength = key->KeyLength;
 
 		memcpy(wep->KeyMaterial, key->KeyMaterial, key->KeyLength);
-		memcpy(&(padapter->securitypriv.dot11DefKey[keyindex].skey[0]), key->KeyMaterial, key->KeyLength);
+		memcpy(&padapter->securitypriv.dot11DefKey[keyindex].skey[0], key->KeyMaterial, key->KeyLength);
 
 		padapter->securitypriv.dot11DefKeylen[keyindex] = key->KeyLength;
 		padapter->securitypriv.dot11PrivacyKeyIndex = keyindex;
@@ -776,7 +776,7 @@ u16 rtw_get_cur_max_rate(struct adapter *adapter)
 	u8	*p;
 	u16	rate = 0, max_rate = 0;
 	struct mlme_ext_priv	*pmlmeext = &adapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
+	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
 	struct wlan_bssid_ex  *pcur_bss = &pmlmepriv->cur_network.network;
-- 
2.32.0


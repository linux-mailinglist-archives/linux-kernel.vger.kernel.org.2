Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326723E34B1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhHGKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhHGKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:12:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A76C0617B0
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:12:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k9so16824322edr.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wi9hit69AMU9xd7kbX7D4SFkU3MLCw+kNRZsei2hvrY=;
        b=R47B4dfRhMeda84TI9bbPHV12ixTE+GvAjOuwpLhQbcOaCLm17pV6380OglPJFB5I+
         QSGAbijn4gsZW1/bXJoqSDchYEN24uZ+iHhfILI2R276VRPgQUDTjEfNByIowfAb7/Nk
         akb+94a/M6gNC88nYcrrUY/IxK+sxxFDsgUA+ghKMC0IHeNs9nN8+xT4+akLT3wr1n10
         cQiqb4J6T0wNmPkdF9Vi+HPj6t/AzjdA0RcKJNY94bOOD9m2rWKVezYlf604ChKuxbh1
         q84idcVnpFpw+pPQUbXwSaDM53qpdsYu6Xkr64NRcxyFEocwgCp+0lbs9vDBir0XYGTO
         vzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wi9hit69AMU9xd7kbX7D4SFkU3MLCw+kNRZsei2hvrY=;
        b=qI0hFpdfidQL6FUVIyEihPbLVfndtPZbr0/dMrw2wO3HFBG+3iHsGGyM0BxSNKBR12
         X53TaO2ist3+EEMJFtnoSpeVv1ZKHztb/kdajV8Oo6QEGC1ll4WCdRlXod7feuk8YK8/
         3zMUqh1Wp6i/xeW81OvoRg+smdZ0Stx/LBADmb3Qy5PXXYNCqxY70XWvB5+duUy/tdIp
         kl8YdMMQ4fNGM8YNYAzV5J10SisWquXOmifO7aLFcBPoHjagI4v2p1i5pe9rrYoUmHBm
         QQgjC9ZIFcn9gW3gfO+m9MjymRuPvK+CVY2Vpfo57Ce2U4vyQfN52NZs0FZWS0YxK6xJ
         i0sA==
X-Gm-Message-State: AOAM5318gvgm9XkI3QQx2JP8gv3oJLBZCixnFwXbMyWeVC+HgQA/ZS1L
        +VAFL2Ar2bwM4KvbelWwZjh/k8PNcJ4=
X-Google-Smtp-Source: ABdhPJwnVaiAsLy/Y6Xjga1e21Da57aJUA0j5uMfgUzqb4MXRkCTDZLovE+89PxFPgc26YML0oIisw==
X-Received: by 2002:a05:6402:35c7:: with SMTP id z7mr17947338edc.85.1628331138455;
        Sat, 07 Aug 2021 03:12:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::a83e])
        by smtp.gmail.com with ESMTPSA id u4sm3662514eje.81.2021.08.07.03.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:12:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/17] staging: r8188eu: remove unnecessary parentheses in core/rtw_ioctl_set.c
Date:   Sat,  7 Aug 2021 12:11:17 +0200
Message-Id: <20210807101119.16085-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807101119.16085-1-straube.linux@gmail.com>
References: <20210807101119.16085-1-straube.linux@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF3356DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbhDGNvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352630AbhDGNuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:50:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA2C0613DC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:50:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z24-20020a1cf4180000b029012463a9027fso618916wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddVg2tAyiEVLdr3nG/jK5ReME/H0+9JWB1za2BbgEqo=;
        b=eOTb48E5b4E8fjpUG+5nELfnWkBIPCHILXeSzepW5sZV8pFzIvKyuR2TceI61+OAuU
         eHDwGGutzqK5mlUg4vPUwaJvPKl2tp6Lb6aK1SWnCiq8v9g/5rF/BHo43EEei0pxd5iK
         nGjG6hUrz/0MNdRPIKt/yn9UpKmu4B/DH4Kfj7kSezRbZMbu+q8fYAf732vKCAJxjTlr
         G7nV1nO8gf17+ruKGSeyUmRYYzIKY+vGaM7jboiL5XtJ9DuGwlAktdTF/Rr2naOswrHv
         Rk2GTvWVjvoN38cznLn1WtxhMUo5O+6Huab75wCpZ8O9pe6eKXyCMobZKfXXnatnelG0
         oThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddVg2tAyiEVLdr3nG/jK5ReME/H0+9JWB1za2BbgEqo=;
        b=S8jLrchPBU7FrB8m+k2G1HFN36+kdjzOdyevk7fyfNFNsNLR7p8m2/FbdgrAo9auH1
         ssw+8LPhMazNdvXom31wk4aVpaNG69Am92jgB3bg5QtOjuqXKwhM40QKbc0PfkLkHZE+
         Kpzq+1wZ8iNlwO7nfkU/OCef8L8nAJh8vDK+ZPgkAiMMoUICQF931BFkjmwRcJhn9h1x
         inxss3wpiRlaQjRRSRGL7Kff3narMOEj4R5oL+QxDRR4aF+UXD8zob9DZGgzBfssx4Ji
         DOknhKjUK1JatTxNAKLjS1HiJpDjjai532r15GwOQHFWcRumNPYpNH44lg2hgDUhPXy9
         Gu6g==
X-Gm-Message-State: AOAM530ZgNM5IZ4EvZbLtOaRqLpzMOwj01ZOsZ7Ke/pUTWcanqVLeNcz
        e83+ClKh/LtEF2wLce89vEs=
X-Google-Smtp-Source: ABdhPJzy3bAtdH+jPRprxEHkRW0BSE5XC8/hcpbtDqEdRvmuHiUY92u8peOzFHgWsPqICaKL5R7q9Q==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr3227659wmi.85.1617803420805;
        Wed, 07 Apr 2021 06:50:20 -0700 (PDT)
Received: from agape ([5.171.81.68])
        by smtp.gmail.com with ESMTPSA id q19sm8466119wmc.44.2021.04.07.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:50:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 15/19] staging: rtl8723bs: rewrite comparison to null
Date:   Wed,  7 Apr 2021 15:49:39 +0200
Message-Id: <572f96dcb6217fd3e6ea23c37b55b0ebb3231f14.1617802415.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617802415.git.fabioaiuto83@gmail.com>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fi following post-commit checkpatch issues:

CHECK: Comparison to NULL could be written "!p"
290: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:978:
+			if (p == NULL)
--
CHECK: Comparison to NULL could be written "!pmgntframe"
328: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2016:
+	if (pmgntframe == NULL)
--
CHECK: Comparison to NULL could be written "!pmgntframe"
361: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:2378:
+	if (pmgntframe == NULL)
--
CHECK: Comparison to NULL could be written "!pmgntframe"
391: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:3478:
+	if (pmgntframe == NULL)
--
CHECK: Comparison to NULL could be written "!p"
427: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:4071:
+	if (p == NULL)
--
CHECK: Comparison to NULL could be written "!BIP_AAD"
781: FILE: drivers/staging/rtl8723bs/core/rtw_security.c:1690:
+	if (BIP_AAD == NULL)
--
CHECK: Comparison to NULL could be written "!pwep"
1773: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3062:
+			if (pwep == NULL)
--
CHECK: Comparison to NULL could be written "!pmlmepriv->wps_beacon_ie"
1784: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3510:
+		if (pmlmepriv->wps_beacon_ie == NULL)
--
CHECK: Comparison to NULL could be written "!pmlmepriv->wps_probe_resp_ie"
1795: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3544:
+		if (pmlmepriv->wps_probe_resp_ie == NULL)
--
CHECK: Comparison to NULL could be written "!pmlmepriv->wps_assoc_resp_ie"
1807: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3574:
+		if (pmlmepriv->wps_assoc_resp_ie == NULL)
--
CHECK: Comparison to NULL could be written "!pbuf"
1818: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3928:
+	if (pbuf == NULL)
--
CHECK: Comparison to NULL could be written "!if1"
1944: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:392:
+	if (if1 == NULL)

CHECK: Using comparison to false is error prone
402: FILE: drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:3890:
+	if (false == bxmitok)
--
CHECK: Using comparison to true is error prone
671: FILE: drivers/staging/rtl8723bs/core/rtw_recv.c:365:
+				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true))
--
CHECK: Using comparison to true is error prone
1051: FILE: drivers/staging/rtl8723bs/core/rtw_xmit.c:1174:
+	if (padapter->securitypriv.binstallBIPkey != true)
--
CHECK: Using comparison to false is error prone
1632: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2194:
+	if (false == bMatched)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     | 12 ++++++------
 drivers/staging/rtl8723bs/core/rtw_recv.c         |  2 +-
 drivers/staging/rtl8723bs/core/rtw_security.c     |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c         |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 10 +++++-----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      |  2 +-
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1ed43423f2de..7f998a2f8001 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -975,7 +975,7 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_, WLAN_EID_CHALLENGE, (int *)&len,
 				pkt_len - WLAN_HDR_A3_LEN - _AUTH_IE_OFFSET_);
 
-			if (p == NULL)
+			if (!p)
 				goto authclnt_fail;
 
 			memcpy((void *)(pmlmeinfo->chg_txt), (void *)(p + 2), len);
@@ -2013,7 +2013,7 @@ static struct xmit_frame *_alloc_mgtxmitframe(struct xmit_priv *pxmitpriv, bool
 	else
 		pmgntframe = rtw_alloc_xmitframe_ext(pxmitpriv);
 
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		goto exit;
 
 	pxmitbuf = rtw_alloc_xmitbuf_ext(pxmitpriv);
@@ -2375,7 +2375,7 @@ void issue_probersp(struct adapter *padapter, unsigned char *da, u8 is_valid_p2p
 		return;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -3475,7 +3475,7 @@ void issue_action_SA_Query(struct adapter *padapter, unsigned char *raddr, unsig
 	__le16 le_tmp;
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
-	if (pmgntframe == NULL)
+	if (!pmgntframe)
 		return;
 
 	/* update attribute */
@@ -3887,7 +3887,7 @@ unsigned int send_beacon(struct adapter *padapter)
 	}
 
 
-	if (false == bxmitok)
+	if (!bxmitok)
 		return _FAIL;
 	else
 		return _SUCCESS;
@@ -4068,7 +4068,7 @@ u8 collect_bss_info(struct adapter *padapter, union recv_frame *precv_frame, str
 
 	/*  checking SSID */
 	p = rtw_get_ie(bssid->IEs + ie_offset, WLAN_EID_SSID, &len, bssid->IELength - ie_offset);
-	if (p == NULL)
+	if (!p)
 		return _FAIL;
 
 	if (*(p + 1)) {
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index 866b8c540c0c..18ad719c9826 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -362,7 +362,7 @@ static signed int recvframe_chkmic(struct adapter *adapter,  union recv_frame *p
 				if ((IS_MCAST(prxattrib->ra) == true)  && (prxattrib->key_index != pmlmeinfo->key_index))
 					brpt_micerror = false;
 
-				if ((prxattrib->bdecrypted == true) && (brpt_micerror == true))
+				if ((prxattrib->bdecrypted) && (brpt_micerror))
 					rtw_handle_tkip_mic_err(adapter, (u8)IS_MCAST(prxattrib->ra));
 
 				res = _FAIL;
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index bb15b5af744c..9587d89a6b24 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1687,7 +1687,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	ori_len = pattrib->pkt_len-WLAN_HDR_A3_LEN+BIP_AAD_SIZE;
 	BIP_AAD = rtw_zmalloc(ori_len);
 
-	if (BIP_AAD == NULL)
+	if (!BIP_AAD)
 		return _FAIL;
 
 	/* PKT start */
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index af69f2da6ecd..77378f7d6b9e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -1171,7 +1171,7 @@ s32 rtw_mgmt_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, s
 		goto xmitframe_coalesce_success;
 
 	/* IGTK key is not install, it may not support 802.11w */
-	if (padapter->securitypriv.binstallBIPkey != true)
+	if (!padapter->securitypriv.binstallBIPkey)
 		goto xmitframe_coalesce_success;
 
 	/* station mode doesn't need TX BIP, just ready the code */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index ca58ea6c4fb8..f96322bdf510 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2191,7 +2191,7 @@ static int cfg80211_rtw_del_pmksa(struct wiphy *wiphy,
 		}
 	}
 
-	if (false == bMatched)
+	if (!bMatched)
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 40adecbb66d6..679deb781321 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -3059,7 +3059,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL)
+			if (!pwep)
 				goto exit;
 
 			pwep->KeyLength = wep_key_len;
@@ -3507,7 +3507,7 @@ static int rtw_set_wps_beacon(struct net_device *dev, struct ieee_param *param,
 	if (ie_len > 0) {
 		pmlmepriv->wps_beacon_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_beacon_ie_len = ie_len;
-		if (pmlmepriv->wps_beacon_ie == NULL)
+		if (!pmlmepriv->wps_beacon_ie)
 			return -EINVAL;
 
 		memcpy(pmlmepriv->wps_beacon_ie, param->u.bcn_ie.buf, ie_len);
@@ -3541,7 +3541,7 @@ static int rtw_set_wps_probe_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_probe_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_probe_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_probe_resp_ie == NULL)
+		if (!pmlmepriv->wps_probe_resp_ie)
 			return -EINVAL;
 
 		memcpy(pmlmepriv->wps_probe_resp_ie, param->u.bcn_ie.buf, ie_len);
@@ -3571,7 +3571,7 @@ static int rtw_set_wps_assoc_resp(struct net_device *dev, struct ieee_param *par
 	if (ie_len > 0) {
 		pmlmepriv->wps_assoc_resp_ie = rtw_malloc(ie_len);
 		pmlmepriv->wps_assoc_resp_ie_len = ie_len;
-		if (pmlmepriv->wps_assoc_resp_ie == NULL)
+		if (!pmlmepriv->wps_assoc_resp_ie)
 			return -EINVAL;
 
 		memcpy(pmlmepriv->wps_assoc_resp_ie, param->u.bcn_ie.buf, ie_len);
@@ -3925,7 +3925,7 @@ static int rtw_test(
 	len = wrqu->data.length;
 
 	pbuf = rtw_zmalloc(len);
-	if (pbuf == NULL)
+	if (!pbuf)
 		return -ENOMEM;
 
 	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 7010bdd0e69d..5de4c70aab6a 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -389,7 +389,7 @@ static int rtw_drv_init(
 		goto exit;
 
 	if1 = rtw_sdio_if1_init(dvobj, id);
-	if (if1 == NULL)
+	if (!if1)
 		goto free_dvobj;
 
 	/* dev_alloc_name && register_netdev */
-- 
2.20.1


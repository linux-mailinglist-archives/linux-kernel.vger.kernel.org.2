Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94499460B89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 01:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbhK2A0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 19:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbhK2AYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 19:24:05 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBDAC061746
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:48 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v22so14754049qtx.8
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dmq6BjcJsvem8AuaFDAueLmAS6KG11bvtni3oFFMHh0=;
        b=SEChp+xeR7cX7aKi/xM8MWUbwdNtWc7+GRybaSyjcjaxvfy36RM7f43zftxvGT54oE
         kMxb+woKl5PMVzCE6C9GSbF5A2KbVWzlBbBjozIwvgqwxbxEjnCAPKujUzGylHTnReqD
         Dgd7cyDnSwnEbXzmqCQN95w1BMMc2I0zrU4VdkNBPnN0drYgLEPevJQoZruUOYCL8+Uo
         nnybFc0HfIT/XR3NQAkC+y1K211qpMTV+3b47X9htxsdc9J/uc1ZTHc87fNe/FM7USX8
         jkDLG9xXbrl6HNVYBCrp/bCC4PlN2RNLZnWnr9fqbpsBWtdkOCEvLjCoO8TYRFX6fgmC
         i8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dmq6BjcJsvem8AuaFDAueLmAS6KG11bvtni3oFFMHh0=;
        b=xT3UJFtnr6rqZU1k0qsUZj3jQI13l8v18z7PTu962hSnhucUFB58Z3ALLJHu73MzWk
         fwpROS9DQPV9vq2YD5UxdyMYk3C1T6EKcJVFo3GGRLFBVZL+5OlPbCONWR9RXQTpJ/UQ
         hxtScHS+UJwSPzCNlFJew8ye7prnpLFgGbuoU+GiD6Kl6LJNV4zwm0T7ZodygP1gH0Ge
         WJVqH/17ZugsYcJTQ3SpnLmT16FP5FrZifZ6nRzV8M1Ci5ST3aUZjSlNh1HX4CPFkUvj
         2R5fG4CnHc6Ku+H9poIqL3bvsR/9t7wKVU1I2Zhej+1FAQbwQsHNxKeZN6GVWHI+nwZj
         yfIQ==
X-Gm-Message-State: AOAM531pM+Z81BmhxFs0DKESdsOp4j3x1ftjmUVrliIhdDfqCfbhXDVn
        luzcMa+4CaOiWZTUqaT1cW+ZJQ==
X-Google-Smtp-Source: ABdhPJwvcPN+Mk2r6ldpHCMpiYw6L8r8pCXoXqI2CCZ7kzHm+X+nBrUF/LdrCWgJf00McwTVapp05A==
X-Received: by 2002:ac8:5841:: with SMTP id h1mr30819326qth.517.1638145247501;
        Sun, 28 Nov 2021 16:20:47 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id n74sm5681022qkn.83.2021.11.28.16.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:20:47 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: r8188eu: convert DBG_88E_LEVEL calls in core/rtw_mlme_ext.c
Date:   Mon, 29 Nov 2021 00:20:35 +0000
Message-Id: <20211129002041.865-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129002041.865-1-phil@philpotter.co.uk>
References: <20211129002041.865-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all DBG_88E_LEVEL macro calls in core/rtw_mlme_ext.c to plain
netdev_dbg calls, as although the information is potentially useful, we
should be exposing it using standard kernel debugging functionality.

Also fix some indentation issues in the block of one such call, and
remove usage of FUNC_ADPT_FMT/FUNC_ADPT_ARG macros in another, as
netdev_dbg provides equivalent functionality.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 46 ++++++++++++---------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 55c3d4a6faeb..b2ea9c6dc537 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -653,9 +653,11 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
-						DBG_88E_LEVEL(_drv_info_, "ap has changed, disconnect now\n ");
-						receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 0);
-						return _SUCCESS;
+					netdev_dbg(padapter->pnetdev,
+						   "ap has changed, disconnect now\n");
+					receive_disconnect(padapter,
+							   pmlmeinfo->network.MacAddress, 0);
+					return _SUCCESS;
 				}
 				/* update WMM, ERP in the beacon */
 				/* todo: the timer is used instead of the number of the beacon received */
@@ -929,7 +931,7 @@ unsigned int OnAuthClient(struct adapter *padapter, struct recv_frame *precv_fra
 	}
 
 	if (go2asoc) {
-		DBG_88E_LEVEL(_drv_info_, "auth success, start assoc\n");
+		netdev_dbg(padapter->pnetdev, "auth success, start assoc\n");
 		start_clnt_assoc(padapter);
 		return _SUCCESS;
 	}
@@ -1501,8 +1503,9 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		DBG_88E_LEVEL(_drv_always_, "ap recv deauth reason code(%d) sta:%pM\n",
-			      reason, GetAddr2Ptr(pframe));
+		netdev_dbg(padapter->pnetdev,
+			   "ap recv deauth reason code(%d) sta:%pM\n",
+			   reason, GetAddr2Ptr(pframe));
 
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
@@ -1538,8 +1541,9 @@ unsigned int OnDeAuth(struct adapter *padapter, struct recv_frame *precv_frame)
 			}
 		}
 
-		DBG_88E_LEVEL(_drv_always_, "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
-			      reason, GetAddr3Ptr(pframe), ignore_received_deauth);
+		netdev_dbg(padapter->pnetdev,
+			   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
+			   reason, GetAddr3Ptr(pframe), ignore_received_deauth);
 
 		if (!ignore_received_deauth)
 			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
@@ -1574,8 +1578,9 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		DBG_88E_LEVEL(_drv_always_, "ap recv disassoc reason code(%d) sta:%pM\n",
-			      reason, GetAddr2Ptr(pframe));
+		netdev_dbg(padapter->pnetdev,
+			   "ap recv disassoc reason code(%d) sta:%pM\n",
+			   reason, GetAddr2Ptr(pframe));
 
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
@@ -1594,8 +1599,9 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 
 		return _SUCCESS;
 	} else {
-		DBG_88E_LEVEL(_drv_always_, "ap recv disassoc reason code(%d) sta:%pM\n",
-			      reason, GetAddr3Ptr(pframe));
+		netdev_dbg(padapter->pnetdev,
+			   "ap recv disassoc reason code(%d) sta:%pM\n",
+			   reason, GetAddr3Ptr(pframe));
 
 		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
@@ -6491,7 +6497,7 @@ void start_clnt_auth(struct adapter *padapter)
 	/*	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
 	issue_deauth(padapter, (&pmlmeinfo->network)->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
 
-	DBG_88E_LEVEL(_drv_info_, "start auth\n");
+	netdev_dbg(padapter->pnetdev, "start auth\n");
 	issue_auth(padapter, NULL, 0);
 
 	set_link_timer(pmlmeext, REAUTH_TO);
@@ -7236,8 +7242,8 @@ void linked_status_chk(struct adapter *padapter)
 			if (rx_chk == _FAIL) {
 				pmlmeext->retry++;
 				if (pmlmeext->retry > rx_chk_limit) {
-					DBG_88E_LEVEL(_drv_always_, FUNC_ADPT_FMT" disconnect or roaming\n",
-						      FUNC_ADPT_ARG(padapter));
+					netdev_dbg(padapter->pnetdev,
+						   "disconnect or roaming\n");
 					receive_disconnect(padapter, pmlmeinfo->network.MacAddress,
 							   WLAN_REASON_EXPIRATION_CHK);
 					return;
@@ -7762,8 +7768,9 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	/* write cam */
 	ctrl = BIT(15) | ((pparm->algorithm) << 2) | pparm->keyid;
 
-	DBG_88E_LEVEL(_drv_info_, "set group key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) "
-			"keyid:%d\n", pparm->algorithm, pparm->keyid);
+	netdev_dbg(padapter->pnetdev,
+		   "set group key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) keyid:%d\n",
+		   pparm->algorithm, pparm->keyid);
 	write_cam(padapter, pparm->keyid, ctrl, null_sta, pparm->key);
 
 	return H2C_SUCCESS;
@@ -7792,8 +7799,9 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 	cam_id = 4;
 
-	DBG_88E_LEVEL(_drv_info_, "set pairwise key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) camid:%d\n",
-		      pparm->algorithm, cam_id);
+	netdev_dbg(padapter->pnetdev,
+		   "set pairwise key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) camid:%d\n",
+		   pparm->algorithm, cam_id);
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
-- 
2.33.1


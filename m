Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28A3B2414
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFWXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:51:28 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF77C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:10 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r20so3521186qtp.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Cio/o/UPnfZZDbda7tiIMQy0nC96qD442oe0ej5cDs=;
        b=woamOu7oQu4dNOLO3jPBVaWmTyEOvu5wNLbngnrfTf/QKH0pHpq4Y5/L0joHa1xv+A
         VIHJ+hzBa6WLISACmuaPM56Tc8Gu/ueTm0GvNIr1d4s3rkW8RY0U95RLU/yGlflLgxbd
         0z+0sXPFlpNB2cvm7Hzy7+w5luurO3enQmqloBsFZPF/xmj85KTjJ2+o7T6L4UXG6CCs
         /3PnydsOf6QV7hmLyLIB89FasvXjxD3zUeXholYYhry93YpxPI1wHHlR3g6qVTYuz91u
         fJXClZbraM0XhhG2jA/hgnsSjYb+1wsTYKTEz4OtnQGahqa8rnTN0xMCYUdcuHQu0ml0
         uDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Cio/o/UPnfZZDbda7tiIMQy0nC96qD442oe0ej5cDs=;
        b=td2ADj7EffvbPw5V6QNn039LENl+eR1KTXOdXntUieTinPajP7M41FAZHwOUFqpaBh
         QkRL/aqJhwA3eco+KPS/wAstXRmZ4I2InldP4V1l10w73E2gzdaEDr4cIlg++CLwh1VX
         fJFVsX7oVYmHW5R+X7kR3oXmJso/dQy8nIBBvATxdrmNdslZ2pEntxfLnPceDQriwwXn
         uI4T8aBQyi3bkQw2u2YFMbdFcnVmcSfeyAoD9r4ieOi82oWC1/9LHWr4/autUAbVykv7
         gOmq92pXiXumH3oAf+sWvQThgnoSc++i6OK0BO9luXP9tc52ftFDlVnAs+HUiFvFVVk3
         yGXA==
X-Gm-Message-State: AOAM532/2uRjTzxM/Cdm+QGcqmPcvFZbLDXpK7I833pet747j9ZHqvS+
        uYvRDMFzPKNqcLM6xthAbOadyw==
X-Google-Smtp-Source: ABdhPJzWU/YR/H378s5fSBx/a2mPw14440kYh0RrM8P4oOPwJHbe68+CSURid5URsiPN9pOS6FeK3Q==
X-Received: by 2002:a05:622a:391:: with SMTP id j17mr2298941qtx.217.1624492149287;
        Wed, 23 Jun 2021 16:49:09 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id w2sm992387qto.50.2021.06.23.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 16:49:08 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 2/9] staging: rtl8188eu: remove all DBG_88E_LEVEL calls from core/rtw_mlmw_ext.c
Date:   Thu, 24 Jun 2021 00:48:55 +0100
Message-Id: <20210623234902.7411-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623234902.7411-1-phil@philpotter.co.uk>
References: <20210623234902.7411-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E_LEVEL calls from core/rtw_mlmw_ext.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 21 -------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index c6410030dcbf..2c5f9ee2cf82 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -2190,7 +2190,6 @@ static void start_clnt_auth(struct adapter *padapter)
 	/*	For the Win8 P2P connection, it will be hard to have a successful connection if this Wi-Fi doesn't connect to it. */
 	issue_deauth(padapter, (&pmlmeinfo->network)->MacAddress, WLAN_REASON_DEAUTH_LEAVING);
 
-	DBG_88E_LEVEL(_drv_info_, "start auth\n");
 	issue_auth(padapter, NULL, 0);
 
 	set_link_timer(pmlmeext, REAUTH_TO);
@@ -2481,7 +2480,6 @@ static unsigned int OnBeacon(struct adapter *padapter,
 			if (psta) {
 				ret = rtw_check_bcn_info(padapter, pframe, len);
 				if (!ret) {
-					DBG_88E_LEVEL(_drv_info_, "ap has changed, disconnect now\n ");
 					receive_disconnect(padapter, pmlmeinfo->network.MacAddress, 65535);
 					return _SUCCESS;
 				}
@@ -2738,7 +2736,6 @@ static unsigned int OnAuthClient(struct adapter *padapter,
 	}
 
 	if (go2asoc) {
-		DBG_88E_LEVEL(_drv_info_, "auth success, start assoc\n");
 		start_clnt_assoc(padapter);
 		return _SUCCESS;
 	}
@@ -3248,9 +3245,6 @@ static unsigned int OnDeAuth(struct adapter *padapter,
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		DBG_88E_LEVEL(_drv_always_, "ap recv deauth reason code(%d) sta:%pM\n",
-			      reason, GetAddr2Ptr(pframe));
-
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
 			u8 updated = 0;
@@ -3269,9 +3263,6 @@ static unsigned int OnDeAuth(struct adapter *padapter,
 		return _SUCCESS;
 	}
 #endif
-	DBG_88E_LEVEL(_drv_always_, "sta recv deauth reason code(%d) sta:%pM\n",
-		      reason, GetAddr3Ptr(pframe));
-
 	receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
@@ -3299,9 +3290,6 @@ static unsigned int OnDisassoc(struct adapter *padapter,
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
 
-		DBG_88E_LEVEL(_drv_always_, "ap recv disassoc reason code(%d) sta:%pM\n",
-			      reason, GetAddr2Ptr(pframe));
-
 		psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
 		if (psta) {
 			u8 updated = 0;
@@ -3320,9 +3308,6 @@ static unsigned int OnDisassoc(struct adapter *padapter,
 		return _SUCCESS;
 	}
 #endif
-	DBG_88E_LEVEL(_drv_always_, "ap recv disassoc reason code(%d) sta:%pM\n",
-		      reason, GetAddr3Ptr(pframe));
-
 	receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
@@ -4461,8 +4446,6 @@ void linked_status_chk(struct adapter *padapter)
 			if (rx_chk == _FAIL) {
 				pmlmeext->retry++;
 				if (pmlmeext->retry > rx_chk_limit) {
-					DBG_88E_LEVEL(_drv_always_, FUNC_ADPT_FMT" disconnect or roaming\n",
-						      FUNC_ADPT_ARG(padapter));
 					receive_disconnect(padapter, pmlmeinfo->network.MacAddress,
 							   WLAN_REASON_EXPIRATION_CHK);
 					return;
@@ -4976,8 +4959,6 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
 	/* write cam */
 	ctrl = BIT(15) | ((pparm->algorithm) << 2) | pparm->keyid;
 
-	DBG_88E_LEVEL(_drv_info_, "set group key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) "
-			"keyid:%d\n", pparm->algorithm, pparm->keyid);
 	write_cam(padapter, pparm->keyid, ctrl, null_sta, pparm->key);
 
 	return H2C_SUCCESS;
@@ -5006,8 +4987,6 @@ u8 set_stakey_hdl(struct adapter *padapter, u8 *pbuf)
 
 	cam_id = 4;
 
-	DBG_88E_LEVEL(_drv_info_, "set pairwise key to hw: alg:%d(WEP40-1 WEP104-5 TKIP-2 AES-4) camid:%d\n",
-		      pparm->algorithm, cam_id);
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		struct sta_info *psta;
 		struct sta_priv *pstapriv = &padapter->stapriv;
-- 
2.31.1


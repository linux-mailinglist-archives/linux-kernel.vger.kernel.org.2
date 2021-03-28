Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3BD34BD44
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhC1QfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1QfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 12:35:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7188C061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 09:35:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m12so14803498lfq.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0ehMJS4X44VeO6a7OrN01uA4bYk3Kd4mEn9HL4pEt0=;
        b=NRJPzUklUiTmytIdxs5EjpqEGva8UvKDcImWfRlCkL/FY/ZoGf91a/g6FEIfYJT3lF
         bmvRQgG5refi7DGlRfCU11o02aMUQYN7ANh2TJPTp38Uq9fAiPZ9AcZGdZgPvK9kTNjr
         nmq7NUanItd7/LoJUT7/5JlEirkrGvumj05bNgEFZ/Hyld/gcws53LslnlLeT8Wr6Bsf
         kATHAipIzcYcNzMMsM7TGMDAvLCT12ML1h0ylgxPknZ/bmoBHecT9WXyQxhQElvEBwaG
         O/iu1s6GGNdNuEzF2q+ccnCRDNUs7KvXqIvPlmRl2M6npMAFgkS8P0DYu2Y/wivUFqTl
         eldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0ehMJS4X44VeO6a7OrN01uA4bYk3Kd4mEn9HL4pEt0=;
        b=ZRjUtCw/N4dCiptVrYXrDMGzbabro9ZiCKtSsuROvJTRR9OJHOhMbRPxpvjZHb5ELd
         BbuTo813PpTmHV79BMyrB7MD1zDMqYTkvF24Y5s4Cqo4pzdqGqK+stw7PeriLGtY0RUy
         2y2EMWpO2S7aHYeq3l1GkMy91n9WyFSoWLLrMk2HFLKZzvnqlNmMlUOyTHPt0d675h5v
         lkUBsoMPpjY8a3gPOfobAz8KedB85t75Rg/uTaN0MQYz8GvwKzsLIed43LycQ3fan47G
         dy6/V/7a1wEWSnq7n05cuKYzHtc4MD0kRBe22apJyzU6p/975g4gzaZsKG4epj5i1x5L
         CU/w==
X-Gm-Message-State: AOAM531ltRbrGemCvKkVMMnyPt9RsztU7R2mTeHoPhdxTWc4Yp8jeS0x
        +L0Z6J6tkrI0I7SMUir9Ia0=
X-Google-Smtp-Source: ABdhPJzH8BalufhVytwo2U2kFlrcdWwlVICUJWzqeLuK1kAVr2HSdyiPttOc4e3K47BzbGCPCGAUSA==
X-Received: by 2002:ac2:446d:: with SMTP id y13mr13835988lfl.365.1616949302470;
        Sun, 28 Mar 2021 09:35:02 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id d4sm1525802lfs.45.2021.03.28.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 09:35:02 -0700 (PDT)
Received: (nullmailer pid 53216 invoked by uid 1000);
        Sun, 28 Mar 2021 16:34:31 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 2/2] staging:r8188eu: remove dummy handlers from OnAction()
Date:   Sun, 28 Mar 2021 19:33:25 +0300
Message-Id: <20210328163323.53163-2-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210328163323.53163-1-insafonov@gmail.com>
References: <20210328163323.53163-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on_action_spct() do nothing, because rtw_get_stainfo() has no side
effects. Other action handlers are trivial.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 95 -------------------
 1 file changed, 95 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 4d741737d671..fca02f17ba98 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -3517,56 +3517,6 @@ static unsigned int OnAtim(struct adapter *padapter,
 	return _SUCCESS;
 }
 
-static unsigned int on_action_spct(struct adapter *padapter,
-				   struct recv_frame *precv_frame)
-{
-	struct sta_info *psta = NULL;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	u8 *pframe = precv_frame->pkt->data;
-	u8 *frame_body = pframe + sizeof(struct ieee80211_hdr_3addr);
-	u8 category;
-	u8 action;
-
-	DBG_88E(FUNC_NDEV_FMT"\n", FUNC_NDEV_ARG(padapter->pnetdev));
-
-	psta = rtw_get_stainfo(pstapriv, GetAddr2Ptr(pframe));
-
-	if (!psta)
-		goto exit;
-
-	category = frame_body[0];
-	if (category != RTW_WLAN_CATEGORY_SPECTRUM_MGMT)
-		goto exit;
-
-	action = frame_body[1];
-	switch (action) {
-	case WLAN_ACTION_SPCT_MSR_REQ:
-	case WLAN_ACTION_SPCT_MSR_RPRT:
-	case WLAN_ACTION_SPCT_TPC_REQ:
-	case WLAN_ACTION_SPCT_TPC_RPRT:
-		break;
-	case WLAN_ACTION_SPCT_CHL_SWITCH:
-		break;
-	default:
-		break;
-	}
-
-exit:
-	return _FAIL;
-}
-
-static unsigned int OnAction_qos(struct adapter *padapter,
-				 struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
-static unsigned int OnAction_dls(struct adapter *padapter,
-				 struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
 static unsigned int OnAction_back(struct adapter *padapter,
 				  struct recv_frame *precv_frame)
 {
@@ -3756,24 +3706,6 @@ static unsigned int on_action_public(struct adapter *padapter,
 	return ret;
 }
 
-static unsigned int OnAction_ht(struct adapter *padapter,
-				struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
-static unsigned int OnAction_wmm(struct adapter *padapter,
-				 struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
-static unsigned int OnAction_p2p(struct adapter *padapter,
-				 struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
 static unsigned int DoReserved(struct adapter *padapter,
 			       struct recv_frame *precv_frame)
 {
@@ -3792,39 +3724,12 @@ static unsigned int OnAction(struct adapter *padapter,
 	category = frame_body[0];
 
 	switch (category) {
-	case RTW_WLAN_CATEGORY_SPECTRUM_MGMT:
-		on_action_spct(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_QOS:
-		OnAction_qos(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_DLS:
-		OnAction_dls(padapter, precv_frame);
-		break;
 	case RTW_WLAN_CATEGORY_BACK:
 		OnAction_back(padapter, precv_frame);
 		break;
 	case RTW_WLAN_CATEGORY_PUBLIC:
 		on_action_public(padapter, precv_frame);
 		break;
-	case RTW_WLAN_CATEGORY_RADIO_MEASUREMENT:
-		DoReserved(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_FT:
-		DoReserved(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_HT:
-		OnAction_ht(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_SA_QUERY:
-		DoReserved(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_WMM:
-		OnAction_wmm(padapter, precv_frame);
-		break;
-	case RTW_WLAN_CATEGORY_P2P:
-		OnAction_p2p(padapter, precv_frame);
-		break;
 	default:
 		break;
 	}
-- 
2.26.2


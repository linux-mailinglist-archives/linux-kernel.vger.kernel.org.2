Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A072C35293B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhDBKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhDBKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:01:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEAFC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:01:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z1so4936480edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fb7aKRZia33F9MimRyqKtx0GJE/NU3HcWly69zkCQ40=;
        b=hxUdxXvpTDgN0CRWnvcWr+iW+nJHRpS0EOQMGOlIubT+OHj4t38KAXVnu3ZFNp997d
         XENfvEbhxn708/HeEAUMZPFQcaZB0GjB5EJlMpXZ39jD0cg5x/8Q04N52xNos9mSDyjY
         reI8kq1R08zrtKE+8cvCwCEDqwai0LghDu3QLGJVpLA2Br6aGYEatCOjPV3IT873YZnf
         PofjOC9GMKG68kdn8Kaf6VL5vZqmmlW1sSSvh8XtKWdOL7mwSPs2jrY8EeDpldzD1nm9
         HhZntJARSTEiZ34lhUKqctL1wRmqy0iA1pRt3h3DvQ0fwqnjxABa1V2rftHmFGULyakG
         FZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fb7aKRZia33F9MimRyqKtx0GJE/NU3HcWly69zkCQ40=;
        b=fiL3EfGsbPHFdsYqZLD969g/eDZfDSXy1UM0Pu/QEF4jvc+w0uFsGk5xjrtcNxqd8H
         qchQ4niV57Hp2nWCxW+zi9fZDjbR248Ph+PUi9i8V3HLU+LgRLSDXp6Y6qplaQLNjrHp
         oSxsPZWaBrkfsl3+fHKAs1VNEl7RJcKvB6IRZ9fqmU9l2uZvBYw/FwHPVWXSIUC5outv
         3z+E3mY4w3atrrvAQFLk1yjSgn9X+PC1aULOsvZhQCGnkJ2xwHKoQpc4AT/B2JojjxRM
         yrJrnqOyOFD7xqI9jglLKlU8DVu9Wq3K33XPTxiKRvby+PnPEffvUdbScgos70KhYlWl
         qfdw==
X-Gm-Message-State: AOAM531b5A6jJZaejpSod52vnDjbYB1qzmvRnwVJLm9HLEE4Vr46QtpY
        8VCr+PWzB9p+eF8mVgxL8CY=
X-Google-Smtp-Source: ABdhPJxkH7sx0jv+07xxiOmgY7SjIpuBsKNr9CjwbGJY71XGIOb0i9189VKDIAMi1Qhd4v9dxp66Yw==
X-Received: by 2002:a50:fd83:: with SMTP id o3mr15017073edt.90.1617357716546;
        Fri, 02 Apr 2021 03:01:56 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id s18sm5268551edc.21.2021.04.02.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:01:56 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/16] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
Date:   Fri,  2 Apr 2021 12:01:26 +0200
Message-Id: <3a78c9b4fe140d01677d2da34847757a100c1edf.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE calls in core/rtw_mlme.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 29d4b7493784..4289bf40aa73 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -356,7 +356,6 @@ static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
 {
-	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_network ==> ssid = %s\n\n" , pnetwork->network.Ssid.Ssid)); */
 	_rtw_free_network_nolock(&(padapter->mlmepriv), pnetwork);
 	rtw_cfg80211_unlink_bss(padapter, pnetwork);
 }
@@ -393,8 +392,6 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("(%s,%d)(%s,%d)\n", */
-	/* 		a->Ssid.Ssid, a->Ssid.SsidLength, b->Ssid.Ssid, b->Ssid.SsidLength)); */
 	return (a->Ssid.SsidLength == b->Ssid.SsidLength)
 		&&  !memcmp(a->Ssid.Ssid, b->Ssid.Ssid, a->Ssid.SsidLength);
 }
@@ -551,8 +548,6 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 		&(pmlmepriv->cur_network.network));
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
-		/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,"Same Network\n"); */
-
 		/* if (pmlmepriv->cur_network.network.IELength<= pnetwork->IELength) */
 		{
 			update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
@@ -778,7 +773,6 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,"rtw_survey_event_callback : WIFI_ADHOC_MASTER_STATE\n\n"); */
 		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
-- 
2.20.1


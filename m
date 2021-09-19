Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4417A410C31
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 17:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhISPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhISPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 11:39:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447BAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g16so24122136wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X3UWpCSNmsPFcEE2dg01xA2FSf6npjuEkkQp7voZ20Y=;
        b=k0YLcV35tEI1HwCkTVPwgyFoLSYiQ+t+ryPXnTjaEPya5SL3v3H/dU5CP3MSmsShOu
         34C6onhfdAn8xeEr+kpZZw66eDnYrKkSh+X3XtSB6LzRo0AONDEnTn+RpzD8Xr0UzDdJ
         gogiqUpGDBda0p53mJmFxV1AJIzzHvyNCx76tdNXo1tTx6A1+lwbvAZJqCKS0YGGSPmW
         CEDoqJQvzLBmWdnqfkpABOpNLvPfrYt94kuNOXlJ9K1+hd4liOHT053ZKnDbIlJA/Uxp
         zG7GqkO2hiL220KxksrCKlJOtoXwbdET/a0BMhyIl9ruMFAsSBU+nF+MLsD7blMQpBGf
         U0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3UWpCSNmsPFcEE2dg01xA2FSf6npjuEkkQp7voZ20Y=;
        b=ysq4IeKrBCMKVRBaxgbg84gnItlPS8+55rYeK6A4ECvliY3WktRJz9eA4mMYq8Kdm4
         yauz1jJFMcaE1ruyfN335f/qxIfXmaAEPqrKKBGRCoAuEoHw07kXKGM4w1ZhSAA0nP4Y
         fU96bRR3F8RwpusGROdtxUJkw68zNnOMCvhLJILpYFTpYVjRgFb2pN1TnTZQm/AcKGqN
         1qiJFkbFWsu1yJ2lZuBrBmTmSsjfgG3RkU0M+cIrs8N9yV7ib3lUaEn9Ka5KRk+qwO+X
         6gceVRhyRTRL4j5HGJjtLUPiChQYxOcbuAUbogKcMrWEyZblqSZKgDUXvqp6n6PK+uPa
         6Rrg==
X-Gm-Message-State: AOAM533V3ohce7qk+rfP4OenbsHJgbRk+kzWVIPkDhPvT3YHY68wKuSw
        ZRoJ9Li5CBCXWszk6N+YLrU=
X-Google-Smtp-Source: ABdhPJxfyckddlvQrjiTqzdQc/l+v2z0KoQLn+JchjDJhUkYw2aMqFPeKIPTBtgpSQ/90ch0JAvYvw==
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr23306015wrc.30.1632065860957;
        Sun, 19 Sep 2021 08:37:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l15sm16614501wme.42.2021.09.19.08.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 08:37:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: remove rtw_ap_inform_ch_switch()
Date:   Sun, 19 Sep 2021 17:36:57 +0200
Message-Id: <20210919153659.20826-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919153659.20826-1-straube.linux@gmail.com>
References: <20210919153659.20826-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_ap_inform_ch_switch() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c    | 35 ------------------------
 drivers/staging/r8188eu/include/rtw_ap.h |  1 -
 2 files changed, 36 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index fff957fcaf40..4f4ec4528016 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1526,41 +1526,6 @@ u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 	return beacon_updated;
 }
 
-int rtw_ap_inform_ch_switch(struct adapter *padapter, u8 new_ch, u8 ch_offset)
-{
-	struct list_head *phead, *plist;
-	int ret = 0;
-	struct sta_info *psta = NULL;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-
-	if ((pmlmeinfo->state & 0x03) != WIFI_FW_AP_STATE)
-		return ret;
-
-	DBG_88E(FUNC_NDEV_FMT" with ch:%u, offset:%u\n",
-		FUNC_NDEV_ARG(padapter->pnetdev), new_ch, ch_offset);
-
-	spin_lock_bh(&pstapriv->asoc_list_lock);
-	phead = &pstapriv->asoc_list;
-	plist = phead->next;
-
-	/* for each sta in asoc_queue */
-	while (phead != plist) {
-		psta = container_of(plist, struct sta_info, asoc_list);
-		plist = plist->next;
-
-		issue_action_spct_ch_switch(padapter, psta->hwaddr, new_ch, ch_offset);
-		psta->expire_to = ((pstapriv->expire_to * 2) > 5) ? 5 : (pstapriv->expire_to * 2);
-	}
-	spin_unlock_bh(&pstapriv->asoc_list_lock);
-
-	issue_action_spct_ch_switch(padapter, bc_addr, new_ch, ch_offset);
-
-	return ret;
-}
-
 int rtw_sta_flush(struct adapter *padapter)
 {
 	struct list_head *phead, *plist;
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index 4055d908c309..dac091443ba1 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -31,7 +31,6 @@ void sta_info_update(struct adapter *padapter, struct sta_info *psta);
 u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 	       bool active, u16 reason);
 int rtw_sta_flush(struct adapter *padapter);
-int rtw_ap_inform_ch_switch(struct adapter *padapter, u8 new_ch, u8 ch_offset);
 void start_ap_mode(struct adapter *padapter);
 void stop_ap_mode(struct adapter *padapter);
 void update_bmc_sta(struct adapter *padapter);
-- 
2.33.0


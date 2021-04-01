Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889CE3511E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhDAJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbhDAJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:21:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BAC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:21:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq27so1825868ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fb7aKRZia33F9MimRyqKtx0GJE/NU3HcWly69zkCQ40=;
        b=ZrgESLFsAK/I5YdTjFJcN6S1sL7ga1/Ju5srZpT4TDi30/8vhYpnqHmPtk0dtVlq1K
         Xtx9zGWO7fBc3LeZSUn7slsTRoCrykjS3YLHAOGONcJO7PKuyJfR9ea/jhIahnK1Vdr5
         Gu9ePH2JRZPoS/gZBCJkRpbXWYLxd1V3ARhi3qrC7GmbzlG7el0BqDYXgIMKtDbF+ZvT
         8IlvKOSDCD9tslZtypNzAsRJmt7qRlmzCT2hBzDD4XS9mSrShwqKEo5u6aHdrQHcuUYQ
         MphBLaAq/PVOdlG8BHid2KWquPdqLDHpqzronUljhraAk3iB1dOSUnjRGjUAEkteyPNq
         nI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fb7aKRZia33F9MimRyqKtx0GJE/NU3HcWly69zkCQ40=;
        b=WAhWgPcnmZvGyxeE+FlGVB8d5loFWR7nTtN7y+qQCaG8dWeyxViBsIwotuqh6s1ymn
         9vOUfrHIiHh8o0RCRwfduCXPMTxbZM80HYk6RUb3/LCpS+8q2IoW5v/w+9zpokz8pfXw
         hmu34Ou9PZrr64OIofRr64GZBzcb+NqrqXs/OMEQwPp0LfhA0U7ok3wnASqY33bwWCg0
         S9tgFTIBc5yieDDVMTfh7cPiK6dPBHXFKAjft0hzhbdt/FByYdOHw89h+L0gsOyXNVX+
         9lnzmom3paunt2zx7+kIbuWqoanSd8nbhhDPjQXZCuX66jzZJQxeFeTAJ7iMfEnhf8/H
         drdQ==
X-Gm-Message-State: AOAM530gIyt3ylJP4sxktNk7CisPKUDgS6DO75ewM+AgMEWbdkukflcb
        tQ0H9xkN03yV7YVQ+WUPibg=
X-Google-Smtp-Source: ABdhPJxzUFzf3LuBwbenlOXntUDj1cuDkgWfZjolSKCRPSOvmk8Su+hxZ80VLMl5wsTwgw6z0VLlsw==
X-Received: by 2002:a17:907:9858:: with SMTP id jj24mr8013624ejc.212.1617268899096;
        Thu, 01 Apr 2021 02:21:39 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id q19sm2466141ejy.50.2021.04.01.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:21:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/49] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
Date:   Thu,  1 Apr 2021 11:20:40 +0200
Message-Id: <46befb76185ddf72644aadba920e7f8e8c6dce6b.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
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


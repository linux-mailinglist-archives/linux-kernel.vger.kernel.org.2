Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393B6352E57
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbhDBRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhDBRan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122AEC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo2668282wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fb7aKRZia33F9MimRyqKtx0GJE/NU3HcWly69zkCQ40=;
        b=VYRjqcOu64KeZaDCf7m4jqYTM4EWIV7istNdRwPrQHnhW+8gpaoUJ8qY3ACtgrCaDV
         xW7dg+rY5uiXI71dmbxIwE4MIJ9uGPdFquakgZY5hJP+qFk4y3E+SJc3K5Bo/sfNZYNE
         gR29gmYTInPvqEeOxGB1Ctr8Efy4vxFt5jKr5G9i2Gg6aMV+VOGfEDb8MMQW55rl1vOH
         n2TierQfiVOBON6nzVduhh5I3+ozcIE/CZDKNEJvhYp8t+seEOuJ5VFDxlKVU1Cgu0aP
         q1fG1LmH4IfbSEEfp9udUrsXHY9g0i63IZU4vseRXleb8X4AX5UesaeeTBcEzhRlB/AB
         fYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fb7aKRZia33F9MimRyqKtx0GJE/NU3HcWly69zkCQ40=;
        b=BQARC0dF94j5BOF/+ApifL1hUFNwQij4Dq9RQAbr7+U+Ah634M8HApZn+Qh+JLg1oX
         2v1fLwhWYfC3aa+RlpqXy6/nvGmAQycqWTBpf5SpCXty8Ciakct1TSWblWkfsIaTnOeV
         Y1qVHi2064VeWPL1eGumpyYNSUGd2+IHrj6Ox8MIcsTs+s4i5HOk5qw7VbDNDitCCz3c
         7hZoY8kW1KcSAmsfgidgNkW2kWiS2JKUM6dQokESnt7wW7wNRmP22FFK6aC0IgXG5Q4x
         K46bAjSSfYJ3+kUBfGcxRou+V17Jk4XRkMBnikqafdUYqMyZTnDX5OaR6C4KKN3quUXc
         5QLw==
X-Gm-Message-State: AOAM53364YtKVKIoRnWIG2UNwNYKf5LMGe2RQf9ElBT6q6KVmKI8UU6o
        k2qF6LZIO4Yfo4kqhk6aSMk=
X-Google-Smtp-Source: ABdhPJxRf8RPP05vPvtCyfS9OTXn5rOs0Jl+q6ZQUFNfdMZURqbCJAmt3pCGztq47NjwskB+5tVghA==
X-Received: by 2002:a05:600c:204f:: with SMTP id p15mr13752334wmg.165.1617384639794;
        Fri, 02 Apr 2021 10:30:39 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id b16sm13707346wmd.38.2021.04.02.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 14/30] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
Date:   Fri,  2 Apr 2021 19:29:56 +0200
Message-Id: <7f0542dbda31a2176b8d12465eb43ef056999dbc.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
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


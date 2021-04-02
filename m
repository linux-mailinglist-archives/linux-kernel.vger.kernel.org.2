Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA496352940
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhDBKCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhDBKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:02:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA65C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:02:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so6767831ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAPYh3wLO5wVpTnW+OZ78M9DCvkkaloWIctMWkpD8UY=;
        b=H7IbB81sFSE/r72039HgrP8rJYdRed9FialbbcCuV0LLtT3Ub2caoOOcq/mn7w9yAo
         3tl5lsSM8iLU3X7HkyunAYmBqfMeg5gyvcqRusD1u7+GFOn7vC66meZ3S/QDQdVsqz4v
         ZJ6wVuiVqCvPUh9gwNobFiEODcuXDwnOLiF2SbUdYuds5bSBs7d/94aC0iropPaokltU
         wI3STTEdT4HURlu2gSTUd+Mzh5E+IsNm/+1Ytg679+NREkpI/Uv+5JBMP4HNKRqKJD7V
         KNHMqUSW/ZV/Vy8o6NrLgsV+yk9t6gfYL/olL41ma/+D7F1XR+G7d9AZlx9B6ueNbEON
         KWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAPYh3wLO5wVpTnW+OZ78M9DCvkkaloWIctMWkpD8UY=;
        b=WR0gtQ+drgivWAMwQijkFgTfpMcTLb5NwA+v97b6gqGrNvebLkSeojI2ytzoE61jMX
         Mij2+YyyUb1EXPmjkGTmdCh9Jsitl6ZKXVfHWXWYC49OM1fOJMa0laDqZsz6APdsUFwN
         wWKvnOlleo21JhMMpRDyoxIS+iPsQ0AusILH+zSqYoq+tBUPOP8AjF1EbQhLe/sr+7cD
         r30jRTJrbz9/Sw0tThHjHmo1ittgRV2PvElu3r3SmHIftr3pzQYmVFBEX7JFCMag0Bm7
         Nydy//lvXCl/iyluRfIrNpUMRPfNPTrWQXjNKIbnUvmkmi8DiMFAWNQGj76qB07/Cut1
         l+0g==
X-Gm-Message-State: AOAM5327ALWtgopr9FhoqWmOSrfwpK48aYj5txM38aQG1HEKYlwfHhe0
        PgMRaia630YOYUth3BUlons=
X-Google-Smtp-Source: ABdhPJxqEzs4K39MM6JVgNxw+VAPU+ByhtPr6VE0CFEa9Zfq7afF0dFv0e+SXH5NHtMHwQ3/m/mDpg==
X-Received: by 2002:a17:906:cecc:: with SMTP id si12mr13368786ejb.461.1617357720076;
        Fri, 02 Apr 2021 03:02:00 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id t6sm5148814edq.48.2021.04.02.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:01:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/16] staging: rtl8723bs: tidy up some error handling
Date:   Fri,  2 Apr 2021 12:01:28 +0200
Message-Id: <1d50d74e8d93f0db7124d3effb676b5405affc02.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the RT_TRACE() output is not useful so we want to delete it. In this case
there is no cleanup for rtw_cleanbss_cmd() required or even possible. I've
deleted the RT_TRACE() output and added a goto unlock to show
that we can't continue if rtw_createbss_cmd() fails.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index e8a39519fed8..e6bced0269b1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -815,6 +815,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 				if (rtw_select_and_join_from_scanned_queue(pmlmepriv) == _SUCCESS) {
 					_set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 				} else {
+					u8 ret = _SUCCESS;
 					struct wlan_bssid_ex    *pdev_network = &(adapter->registrypriv.dev_network);
 					u8 *pibss = adapter->registrypriv.dev_network.MacAddress;
 
@@ -828,10 +829,11 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 					pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 
-					if (rtw_createbss_cmd(adapter) != _SUCCESS)
-						;
-
 					pmlmepriv->to_join = false;
+
+					ret = rtw_createbss_cmd(adapter);
+					if (ret != _SUCCESS)
+						goto unlock;
 				}
 			}
 		} else {
@@ -877,7 +879,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 	}
 
 	/* DBG_871X("scan complete in %dms\n", jiffies_to_msecs(jiffies - pmlmepriv->scan_start_time)); */
-
+unlock:
 	spin_unlock_bh(&pmlmepriv->lock);
 
 	rtw_os_xmit_schedule(adapter);
@@ -1564,6 +1566,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 		rtw_free_stainfo(adapter,  psta);
 
 		if (adapter->stapriv.asoc_sta_count == 1) {/* a sta + bc/mc_stainfo (not Ibss_stainfo) */
+			u8 ret = _SUCCESS;
 			/* rtw_indicate_disconnect(adapter);removed@20091105 */
 			spin_lock_bh(&(pmlmepriv->scanned_queue.lock));
 			/* free old ibss network */
@@ -1591,12 +1594,14 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 				_clr_fwstate_(pmlmepriv, WIFI_ADHOC_STATE);
 			}
 
-			if (rtw_createbss_cmd(adapter) != _SUCCESS)
-				;
+			ret = rtw_createbss_cmd(adapter);
+			if (ret != _SUCCESS)
+				goto unlock;
 		}
 
 	}
 
+unlock:
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7C4150FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbhIVUHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbhIVUHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:07 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EEBC061762
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q11so10344112wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pikKkKyV9neSxxsD6Rq5EII7Lyu/8RY9WBWekMxOm8=;
        b=PnTRsbFQmubYYS/U0sALN3rgpe/fATZ3/BCTeTpQZnCydNqLH6oTNTfsIC5LjHd3/s
         7/TeQU7E5vjdmWuZKe95xO6OEZ7UvIpjOFQYiAn0b3TOvdcO8zx1Br0Yg7iJ4alP7w4m
         C4Eo6xHLOUF8F6G+NeVvxWE0JjJXcG6uG+/POcgKHNXb9mx0jl7cnmdrC0OaKpLS/Jvr
         aVA1N3gI6BK7eUDAGln/NV1uVh0earjMLtBKM9SDE3GHJxR+gBxpV/Ckwue7pjlSoiDh
         M3rnlq3RfxM/8OkkO/DawctMMzwMiDgPqpoP0uWF2fj6gIRavC1hTPt80IisdF8FXXpc
         F0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pikKkKyV9neSxxsD6Rq5EII7Lyu/8RY9WBWekMxOm8=;
        b=cQD95IKxrgbW0lYxUJ2DhDIPEIZc8YwOf9RQfvN0BeVRu35ey/Yd+bV01PecNY/7xC
         T7VA2i+YRxfx9IHuyA2pQn3OWg20jLXyIF3e5uQCose+EgRGbhf8fNfZWm/s7U9psgxS
         +OLgeIHr9TjahhIy0rlVuvAE+7ydKd9E3kJ88ri7A8wWUUb7veIS+XtP7RHjxKfH66OB
         CNktELL31xdw/mM1TYWvLR3977NbPe++leDbZzUdvJBbKFopslDSHlbDjwl9Y6HgKXQ+
         T5/u5LXRBv1H5N8gZU8sjafEK02TeBRzNLw1LJVySPElJnDxh2uBdrUKpoF1AXxrZEcv
         zMTg==
X-Gm-Message-State: AOAM532idbNOibsBS9y5IoX/KeYgwmIv46x/H86hmH1Ouf0nAqQT36gk
        8/nWLP7NoeH6ouSAeYbr2HQ=
X-Google-Smtp-Source: ABdhPJxsYvWeMWgFIbkvnjFnQJNJBiFocKL9WCLEFj3rus6Y4BytM6egNAJRGC0MPQYVuF0yQfVQpQ==
X-Received: by 2002:a05:6000:1379:: with SMTP id q25mr846259wrz.429.1632341136052;
        Wed, 22 Sep 2021 13:05:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/47] staging: r8188eu: remove rtw_scan_abort()
Date:   Wed, 22 Sep 2021 22:03:45 +0200
Message-Id: <20210922200420.9693-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_scan_abort() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 23 ----------------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  1 -
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 456933475c16..f1bc4b2e930d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -897,29 +897,6 @@ inline void rtw_indicate_scan_done(struct adapter *padapter, bool aborted)
 	rtw_os_indicate_scan_done(padapter, aborted);
 }
 
-void rtw_scan_abort(struct adapter *adapter)
-{
-	u32 start;
-	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
-	struct mlme_ext_priv	*pmlmeext = &adapter->mlmeextpriv;
-
-	start = jiffies;
-	pmlmeext->scan_abort = true;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY) &&
-	       rtw_get_passing_time_ms(start) <= 200) {
-		if (adapter->bDriverStopped || adapter->bSurpriseRemoved)
-			break;
-		DBG_88E(FUNC_NDEV_FMT"fw_state=_FW_UNDER_SURVEY!\n", FUNC_NDEV_ARG(adapter->pnetdev));
-		msleep(20);
-	}
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
-		if (!adapter->bDriverStopped && !adapter->bSurpriseRemoved)
-			DBG_88E(FUNC_NDEV_FMT"waiting for scan_abort time out!\n", FUNC_NDEV_ARG(adapter->pnetdev));
-		rtw_indicate_scan_done(adapter, true);
-	}
-	pmlmeext->scan_abort = false;
-}
-
 static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, struct wlan_network *pnetwork)
 {
 	int i;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 9dc9f9b94850..e8d51f495702 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -557,7 +557,6 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue);
 void rtw_indicate_disconnect(struct adapter *adapter);
 void rtw_indicate_connect(struct adapter *adapter);
 void rtw_indicate_scan_done( struct adapter *padapter, bool aborted);
-void rtw_scan_abort(struct adapter *adapter);
 
 int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie,
 			uint in_len);
-- 
2.33.0


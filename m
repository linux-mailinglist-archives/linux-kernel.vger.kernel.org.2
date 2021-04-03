Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F380353341
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbhDCJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbhDCJPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:15:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E6CC0613AD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q26so847566wrz.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIfS7OWNyn+ExLRfzsdJaFoZLyhYN11InQC07hnzCO8=;
        b=Q/dHkeQTkcVv+uIV+IFICfDM5WLJn1BqucLkdzSxqtjueu8CeWLK8MND8vI8ayen5g
         6wtcRNZanK1CCy5pfi7Cd+UIxCPodVdTHa8NMKa0MGGvWJvx+8X0Vz5hQKcTE+v4VGWg
         hL9EghrpycPgJUpB3Vq2Q3O9C8MmwUvlVGHTAbI5wx3KlvyKiDJotKZHkdag5JYMmhIU
         4JtBdUwVXdNj93nxqyGm3MlURRIVudTo8IYqGGImQQibbx9muKhaEL2ucgYRxu4JLn7U
         ijqqexp9z1eR8Qj5HAdsL4zBI18nPrjGiiJzxcqBAJKqAxI7CLzzV4Mq0PY14rMUZYfR
         WLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIfS7OWNyn+ExLRfzsdJaFoZLyhYN11InQC07hnzCO8=;
        b=WVY090aOlD7Kh2iqBWO9DmsPOFZ5cOFgqvzsrTZTUcxzCo8bHXDJncsBwJD9fs6VNi
         zEHtg7iqHNWbi8KL8BUwYZKIhuZD/F9lyLeyonF9xOdgSMqj9tOhLGXMBWI6pXblXoN9
         GEXm9X3/5CrKVlcmceMXKLm64imNwPsoMGzQLhOLezw9ZkdKOhTGYwa9Z9mLb+/T9XI7
         UXa3sdbHNzyOJpP4wjje2zotfRYYF1xiP8Bo6sgnZ8zKv9AQyWe8/Trp/HrfnPab1a4L
         51ZIRCOS12wV6zqqqn41tx6NVvYT5SNUzdGv7CG+vo0SOxmgPgC0o9u9XK0kFuZ+mUtI
         2vDQ==
X-Gm-Message-State: AOAM531x2hJ6h3PoiwOT6ItQozREsmANfpoEq1TWSQhPmPGN0yrE2mhw
        JrE3Zd0xWRHRGW7uZGVZ+m4=
X-Google-Smtp-Source: ABdhPJzEwmtgT6xUe6Ag+IStt0KSjGvOMzJQeAOamsxNi/fZYSOZmZ4FpkvOvTt3xZ8YJfRAmm2Otw==
X-Received: by 2002:adf:a703:: with SMTP id c3mr19537409wrd.72.1617441298125;
        Sat, 03 Apr 2021 02:14:58 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id i7sm1469381wru.41.2021.04.03.02.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 28/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
Date:   Sat,  3 Apr 2021 11:13:50 +0200
Message-Id: <fde460021dacc0b131b2a8f3cc8dddc171d7f459.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all of the RT_TRACE logs in the core/rtw_sta_mgt.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 25 --------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index f96dd0b40e04..7dcac4dd9de2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -216,10 +216,7 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 
 		index = wifi_mac_hash(hwaddr);
 
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_, ("rtw_alloc_stainfo: index  = %x", index));
-
 		if (index >= NUM_STA) {
-			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("ERROR => rtw_alloc_stainfo: index >= NUM_STA"));
 			spin_unlock_bh(&(pstapriv->sta_hash_lock));
 			psta = NULL;
 			goto exit;
@@ -242,17 +239,6 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 		for (i = 0; i < 16; i++)
 			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i], &wRxSeqInitialValue, 2);
 
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
-			 ("alloc number_%d stainfo  with hwaddr = %x %x %x %x %x %x \n",
-			  pstapriv->asoc_sta_count,
-			  hwaddr[0],
-			  hwaddr[1],
-			  hwaddr[2],
-			  hwaddr[3],
-			  hwaddr[4],
-			  hwaddr[5])
-		);
-
 		init_addba_retry_timer(pstapriv->padapter, psta);
 
 		/* for A-MPDU Rx reordering buffer control */
@@ -363,16 +349,6 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	list_del_init(&psta->hash_list);
-	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
-		 ("\n free number_%d stainfo  with hwaddr = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x \n",
-		  pstapriv->asoc_sta_count,
-		  psta->hwaddr[0],
-		  psta->hwaddr[1],
-		  psta->hwaddr[2],
-		  psta->hwaddr[3],
-		  psta->hwaddr[4],
-		  psta->hwaddr[5])
-	);
 	pstapriv->asoc_sta_count--;
 
 	/*  re-init sta_info; 20061114 will be init in alloc_stainfo */
@@ -543,7 +519,6 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	if (!psta) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
 		goto exit;
 	}
 
-- 
2.20.1


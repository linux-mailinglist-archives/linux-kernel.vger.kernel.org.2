Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72E34FD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhCaJlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbhCaJkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x21so21515178eds.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwTgoBA0eOBLs5AzNjX8YYxLxe5sNbz7ch4RSMNui4c=;
        b=NM6BmaQ3dQ+dnOhb8q1nKbXhls9SOcjs2zwweJLz6191qtj0GZkzIydaUcMLzopbLT
         RiDRv21RiI7r1XzzrOha6enXVB7ohNCOoWPrrTJaZ5mx3dDkxjCzVxtPwyMOtbF0u4TK
         osNZqS/Ivg83+7e4V9V/3ua//gIoy3wAOUAqTMWEjHKiGKSlIY9zA3nPvEUJ8RgDNgYM
         OhFReGYQKvlJ53eObuuidHQXSowiSWOf/MLzS/xFwkPjOp2hh3i3bVH+0DRiH3LhA12c
         nZQOuxPrI/clU9MHzp5b4AYtHqZ9vkdVxE4ROSRgk93bY85F9s2P9EaXIOi9uf2jf62/
         zB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwTgoBA0eOBLs5AzNjX8YYxLxe5sNbz7ch4RSMNui4c=;
        b=c+k6XKQiJJ5KFTLDn4rUmROrvX+nBKnDIfC2O1uaOTosOGMLSInMzzlFwEcmmADZC7
         i+gFFMN97KobghRrFRb1rNLEJII6SOAejlBSEf0oa5FIhqcpr9BUaHenfnWJK5N2wVsN
         HamWpDuixFkESlzAsOyH61YkfU63vx8nMSOYMDUI42op81yqCoL0iR3k8fxLTL4fpurv
         rFzeuJtlIUBD4tOd5QWbzx4YBciulTsWjc4KydDHjNmeNT1FLWvc8WeXNKbIprs+jJrg
         /PRZFOC6qw5PMQ45Y7BI+xwmagHKiSxynCxuLGWA/1ig3zid+XrL6vQGlRLyTFUQWyl9
         TnTA==
X-Gm-Message-State: AOAM530XiHVOZOzYGkZYRFMelSRpQXotUHK5yRDOWnH7wdsZ7rAhXWvQ
        QSakdnbXlAcx4ei8KmgvZZw=
X-Google-Smtp-Source: ABdhPJzc2iwnKPdlGHOWz6FJwbLh+RrvP5Y0I6oqSsfIJ3immDjKhznqP43LOAdXV8saz91erT05EA==
X-Received: by 2002:a50:ed90:: with SMTP id h16mr2554746edr.101.1617183638965;
        Wed, 31 Mar 2021 02:40:38 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id r10sm825095eju.66.2021.03.31.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 14/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_sta_mgt.c
Date:   Wed, 31 Mar 2021 11:39:42 +0200
Message-Id: <630742d4ff8fb1f54e949d3979ddad699064d039.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 45 ++++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index f96dd0b40e04..7febeff7308d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -216,10 +216,11 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
 
 		index = wifi_mac_hash(hwaddr);
 
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_, ("rtw_alloc_stainfo: index  = %x", index));
+		pr_info("%s %s: index  = %x", DRIVER_PREFIX, __func__, index);
 
 		if (index >= NUM_STA) {
-			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("ERROR => rtw_alloc_stainfo: index >= NUM_STA"));
+			pr_err("%s ERROR => %s: index >= NUM_STA",
+			       DRIVER_PREFIX, __func__);
 			spin_unlock_bh(&(pstapriv->sta_hash_lock));
 			psta = NULL;
 			goto exit;
@@ -242,16 +243,15 @@ struct	sta_info *rtw_alloc_stainfo(struct	sta_priv *pstapriv, u8 *hwaddr)
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
+		pr_info("%s alloc number_%d stainfo  with hwaddr = %x %x %x %x %x %x\n",
+			DRIVER_PREFIX,
+			pstapriv->asoc_sta_count,
+			hwaddr[0],
+			hwaddr[1],
+			hwaddr[2],
+			hwaddr[3],
+			hwaddr[4],
+			hwaddr[5]);
 
 		init_addba_retry_timer(pstapriv->padapter, psta);
 
@@ -363,16 +363,15 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
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
+	pr_err("%s free number_%d stainfo  with hwaddr = 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n",
+	       DRIVER_PREFIX,
+	       pstapriv->asoc_sta_count,
+	       psta->hwaddr[0],
+	       psta->hwaddr[1],
+	       psta->hwaddr[2],
+	       psta->hwaddr[3],
+	       psta->hwaddr[4],
+	       psta->hwaddr[5]);
 	pstapriv->asoc_sta_count--;
 
 	/*  re-init sta_info; 20061114 will be init in alloc_stainfo */
@@ -543,7 +542,7 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	if (!psta) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
+		pr_err("%s rtw_alloc_stainfo fail", DRIVER_PREFIX);
 		goto exit;
 	}
 
-- 
2.20.1


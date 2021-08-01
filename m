Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCF53DCD2C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhHATFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhHATE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3702C061799
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b11so13451196wrx.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXbrVUeSVUKGA1kFryhIbtHmRoYkiOzY/emxjEyZSbE=;
        b=QCQASC0tb4YFQbCXtokWNVndupjqwzfeMbPmnyJaajvdQpXj1cHRUCtgNCkXb11dFy
         Qbupueh9DHPGabEbl0be8oB+w18QardcHkd0yNYSZIajNhNSkUJVjaOOivc1RoXAx0DW
         1iEa1QkQKwHp8JS9lXhlbSH5gTYQZf/TSwlpKa30FoCSHcNA2mISVCvzd/UP8seUnpGk
         gEf7u8kO7fZOeeG3jKs71UIOY2ZvsknF3pKU77Hql9XE2ryY/Vrz5KQ+VTueosIDFUrP
         YSv2tUnDVz7wyfSZR3i3yLq9oLOY6A3VROlZqglohc6g9Jmyz8+vnYZF6HzMWkOACtjj
         R+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXbrVUeSVUKGA1kFryhIbtHmRoYkiOzY/emxjEyZSbE=;
        b=TzfFlZOOTt/A5GfrbJkvetf8sgavq9ewiCc/K/D7m9WEW4QzwhKxIvXcA/33BHgz4P
         KJ5TSn+8ahR1puSE1b719i46eWr3svIk++w3lk+1ibKV2yyIdFK0N76Jk/UxH0ICXCGz
         JWQd1GjjTmX9N7zDfUhj7z9ZpGm1w34Ah+iI+t7sTKlH8AobHDdlb5hvglAjsO6+BWcq
         cYgINL5mQ7yUUlkuD95/QMNrgoIQbJV2lybYdYLVlEe+cEl4EQ1+8HAjDckqIVcBffgQ
         16VtE6YoFD5KF6NlbtuRWpKbwOd1nzgA35u2vPMPl+m+InjPs0r0bKhv7gmCi00a4xp5
         nKcQ==
X-Gm-Message-State: AOAM533GYeWzi7ZAW+YZ5bbTUnQlwucigho6hCWLh378Sla6SPGbmDfJ
        HPaWMoBLKSop/HbgC8hdd/lXAg==
X-Google-Smtp-Source: ABdhPJz+6fbJwnohCVf6kR/Vy6SNZJto5RNld4vjC1noxVINo6RrsZMF8iZDg0YoVFRHr4TJd/3YSw==
X-Received: by 2002:adf:f383:: with SMTP id m3mr13503528wro.81.1627844688247;
        Sun, 01 Aug 2021 12:04:48 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:47 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 11/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
Date:   Sun,  1 Aug 2021 20:04:33 +0100
Message-Id: <20210801190437.82017-12-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_sta_mgt.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index feaf39fddf7c..3905c28b6b3c 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -263,9 +263,7 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		_rtw_init_stainfo(psta);
 		memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
 		index = wifi_mac_hash(hwaddr);
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_, ("rtw_alloc_stainfo: index=%x", index));
 		if (index >= NUM_STA) {
-			RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("ERROR => rtw_alloc_stainfo: index >= NUM_STA"));
 			psta = NULL;
 			goto exit;
 		}
@@ -287,10 +285,6 @@ struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		for (i = 0; i < 16; i++)
 			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i], &wRxSeqInitialValue, 2);
 
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
-			 ("alloc number_%d stainfo  with hwaddr = %pM\n",
-			 pstapriv->asoc_sta_count, hwaddr));
-
 		init_addba_retry_timer(pstapriv->padapter, psta);
 
 		/* for A-MPDU Rx reordering buffer control */
@@ -364,7 +358,6 @@ u32	rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	list_del_init(&psta->hash_list);
-	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("\n free number_%d stainfo  with hwaddr=0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n", pstapriv->asoc_sta_count, psta->hwaddr[0], psta->hwaddr[1], psta->hwaddr[2], psta->hwaddr[3], psta->hwaddr[4], psta->hwaddr[5]));
 	pstapriv->asoc_sta_count--;
 
 	/*  re-init sta_info; 20061114 */
@@ -530,7 +523,6 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	if (psta == NULL) {
 		res = _FAIL;
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_, ("rtw_alloc_stainfo fail"));
 		goto exit;
 	}
 
-- 
2.31.1


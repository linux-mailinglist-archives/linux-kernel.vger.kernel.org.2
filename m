Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FF352E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhDBRcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbhDBRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:31:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105D3C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:31:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so5319649wrd.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uET64dyZ9Hm0pwJAXZNONIy0WBkkm1uCrrvEqR1Lv8=;
        b=EdZ4T8kCkGQWsUjwwMiXJ+ArUG4AHL+mxDqYIsUNGiM2I6JwVQ8sSz8R+S9hs2MWWn
         BpyBwjyS+LWHFoR+eQNiQp8CdxlEAhJmtU2G+izqVFIJdeGeQxqGCAOD844RYPINa8Ew
         m+/Wepcm+3ryMg17aZibaU40fsal3pcFCvpgk1+1dZgQqo1bFeHIdG+uN/rUdWDA6Y+a
         jeeqTT0Trv6QiHKwmrCtuYk/2oq6B8e8jzyfpeeSJR1hUi4CbMIvSzM2tn/SLQrZzLKs
         t6aaHZQbxQk0DafsJb1QEfnwWeamUWgakEpCYA/TecJBOdgjYqcz4bEQw7XC7nyPBtja
         E4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uET64dyZ9Hm0pwJAXZNONIy0WBkkm1uCrrvEqR1Lv8=;
        b=CMvAVraTRqc/vKZYvT7Ok4nB47Aa+ZxNB6sAvPzCfJhrYCKygtJ2Oh3D1IPeTBJDua
         HrdEfYfSGb5ZUfU5N3H5VA2Dvo+pv1YlZeBZOZCZHQK6gs6Y0eS2MpZuPwHTJlP9ntgW
         q7I1VYXE7a3p+lyNHkKsTYoIVp/vXgapk4YDuU4mqk1SSP3vHD5sCcBjDA10HbWfosri
         2/+sG7cE7gZ4LDL0/fXFMbdR8s+1FY65uIIxu5dhu0XtC0Dz0Q2JTnF/9rxZ+ultPhNM
         FCgPW+JSEHYfae4I68Qzk8rJQEYDXKg/9+Jws/HJAkpBQx6vF9TgjYYRBUHRm8blkGgn
         PnvQ==
X-Gm-Message-State: AOAM530KIJsQ+3zjWoVS9v5W3iFvjb+pZiYb2/KJmDubNA5NZJiMMWmd
        wqeWGylSySASutbm3Oeslfg=
X-Google-Smtp-Source: ABdhPJzN8/LNAs3/FSP/OHMq6Eg+6+96zMNcmfYfHaeDbqkc3h0iFhObtuxxZ0InfTIQGkHOCCLS7g==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr16344148wrp.252.1617384662833;
        Fri, 02 Apr 2021 10:31:02 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id p27sm13450012wmi.12.2021.04.02.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:31:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 28/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
Date:   Fri,  2 Apr 2021 19:30:10 +0200
Message-Id: <4b3db6e98b192adcfeb0d9a20a6d24f65cd54105.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

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


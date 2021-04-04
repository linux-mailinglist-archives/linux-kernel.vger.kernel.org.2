Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A03353871
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhDDOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhDDOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:10:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042CAC0617AB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:10:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5-20020a05600c0245b029011a8273f85eso344639wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIfS7OWNyn+ExLRfzsdJaFoZLyhYN11InQC07hnzCO8=;
        b=mbQSz06ndqEcA6auN/I5ySJRcWqY8lQFJ3nUXJU4AdlavPCwzDyZ/XTvH6eZapybFg
         0di0j+aj7RNUhvu4tMS/ZOY+Oi+6r4XgKTLMMj+sp+Auhy9PwwnlFs3yTULFiyzAUCJ5
         mnr56tTHlsyQGjvBRs6rRmdKeI2GLco3VBYeRp5g7r/mx/j7KvfXuBT/AFD6yGTJt/fv
         astjLLNuCTYbVGQz+ssM4pDZ46SNM5NIpdj8voyCRTZsgMyYPiKqowvNNRw4ZKeELLCA
         85IDstL6yIDq8+tk/pATeznJSOsSlufJs4Krbby1VHRzjl2pWKSjpjkgmpAscmo29J+F
         oaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIfS7OWNyn+ExLRfzsdJaFoZLyhYN11InQC07hnzCO8=;
        b=JD58gqP3KiG3guyXE0bTIo98x8In6MA88DTeaIVe2vUoyH14yfSWRw9yR9M+3Yt+Yz
         hDWHQ7wzdKVvvySnG9V0xBFdJfoVGN89UjPs8ixekU1aQ3u6ywhONzZyD8IHToKBQ+Qb
         ykJ63sdm1VLve+fSe6DUCIw8kMAmrTQa5D5pMSG+N3p3z25dEzYf7k+N5Vz+tO2qchOi
         ABWl/T7TvXIyJJ9tCnUK0Zn2X+XAlDbfARkBxf91L0GzVnmAQmQ6/JCqedz24NZjbsU3
         uqnRrMowD2NM9FYFGy8b+ZiZlJI5V+wN1F+9xuDqiAqGB2g8s+QGw8H9VnKngRBkRQky
         /0Nw==
X-Gm-Message-State: AOAM531RswvXrW1JkgX8gBdZ0G2aBvyCDRBVWcnqrB76Nf3fGUOYAZIK
        Gv9YcaPNmiq8MjbQcJw1lGE=
X-Google-Smtp-Source: ABdhPJy3z++HwqlFb5IRmtBeIOlAxTlPtpscongQ+p4UzBq0xCAk4zm/MRSa7HnthMNhlPO/Ot1Hkw==
X-Received: by 2002:a05:600c:19cf:: with SMTP id u15mr21211654wmq.7.1617545436768;
        Sun, 04 Apr 2021 07:10:36 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id v185sm9836976wmb.25.2021.04.04.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:10:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 28/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
Date:   Sun,  4 Apr 2021 16:09:44 +0200
Message-Id: <155cff4252d13a4eefe12a397e1623fb9ab46f15.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617545239.git.fabioaiuto83@gmail.com>
References: <cover.1617545239.git.fabioaiuto83@gmail.com>
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


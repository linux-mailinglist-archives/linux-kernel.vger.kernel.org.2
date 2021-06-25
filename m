Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377B93B39F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbhFYAK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbhFYAKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C3AC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q190so17374500qkd.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9HXLuVJMBfkOLzdHoGxnO6Harm4a4VlL+MT9SSRGjE=;
        b=p4d4PA8Rr4uMRNIvZBUYukiTciA/BxQ2LPDJskggM5bJtxgEkPQ05GD6SzkrvoTAWh
         12jLc6NuV9y0OyxdEfFYbD6WLKxi40fzej/0mZJk+uJIAfzMle138A/LJkyF3MEJFCEw
         rq9hYFRmY/lARp14YJm57Srejgd97z1ptwedLb7OcY6JmYtjtMwcl/gWa84wK6atXXDq
         Z/21jetjx36aDstJEZCIE86fgkf8zLvOiCqNQcYmjD/fUfGb3+kKOCaLf4N3NNFqs1lQ
         gfJ+Yw4AQnykAqRsJXIUW2sjpxjCtKWD8QOabsYXHrwg6FKOW/0QLuRjYeKEJ2RMKO/G
         fFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9HXLuVJMBfkOLzdHoGxnO6Harm4a4VlL+MT9SSRGjE=;
        b=t33wkSmpTTeWpoQE+/YDA+9eH8/REZjcwOABdndL9cZG7NEoysS+vRRP3hqIIxfv+t
         ipDOi3Nrm55/WSPALbcKzbcuJMuIBCe7bEbwwcBF2tuHwokcRRDHuAhG2OKKusGu3/RC
         +coQfd8M8WXPG7dZO6iB3yglXqUnMaBgBr1A6iGxKT6SrolvQHNwDr05jP4Dvmhi/iNe
         U6yFl4F5ARNEXA0B3feyE/kPJcJYSKccwJxGgO1OC4Z8CygmCH7r0yW8zzckIHyVsJDy
         /0OhvsxYMO7gW0Xoq7DGgA+XRmoXdNp7NZTD+1kuCklnIx+2FC08WxIE1OVFLE1NtdCW
         8MVg==
X-Gm-Message-State: AOAM531v9ct0IEljFSTdYR7jEk4fUlv1asgKCBLC7R+XzieV+1bvnEr5
        Pfjo3uTxRl5pKJL7ZWqs/q/ZPw==
X-Google-Smtp-Source: ABdhPJze/8+le6yvQg4AvNeTbXrJvUn+BCqWQl89m8kKF3b9cOj5JBu5TB+BzC+zoVGYoiC7/9CVjw==
X-Received: by 2002:ae9:e8d5:: with SMTP id a204mr8784868qkg.245.1624579691365;
        Thu, 24 Jun 2021 17:08:11 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:11 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 07/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_sta_mgt.c
Date:   Fri, 25 Jun 2021 01:07:40 +0100
Message-Id: <20210625000756.6313-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_sta_mgt.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 21 ++------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index cd48e6f2a6f6..19eddf573fd8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -179,13 +179,8 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 	_rtw_init_stainfo(psta);
 	memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
 	index = wifi_mac_hash(hwaddr);
-	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
-		 ("%s: index=%x", __func__, index));
-	if (index >= NUM_STA) {
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
-			 ("ERROR => %s: index >= NUM_STA", __func__));
+	if (index >= NUM_STA)
 		return NULL;
-	}
 	phash_list = &pstapriv->sta_hash[index];
 
 	spin_lock_bh(&pstapriv->sta_hash_lock);
@@ -205,10 +200,6 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i],
 		       &wRxSeqInitialValue, 2);
 
-	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_info_,
-		 ("alloc number_%d stainfo  with hwaddr = %pM\n",
-		  pstapriv->asoc_sta_count, hwaddr));
-
 	init_addba_retry_timer(pstapriv->padapter, psta);
 
 	/* for A-MPDU Rx reordering buffer control */
@@ -279,11 +270,6 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 	spin_unlock_bh(&pxmitpriv->lock);
 
 	list_del_init(&psta->hash_list);
-	RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
-		 ("\n free number_%d stainfo with hwaddr=0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x 0x%.2x\n",
-		 pstapriv->asoc_sta_count, psta->hwaddr[0], psta->hwaddr[1],
-		 psta->hwaddr[2], psta->hwaddr[3], psta->hwaddr[4],
-		 psta->hwaddr[5]));
 	pstapriv->asoc_sta_count--;
 
 	/*  re-init sta_info; 20061114 */
@@ -438,11 +424,8 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	psta = rtw_alloc_stainfo(pstapriv, bc_addr);
 
-	if (!psta) {
-		RT_TRACE(_module_rtl871x_sta_mgt_c_, _drv_err_,
-			 ("rtw_alloc_stainfo fail"));
+	if (!psta)
 		return _FAIL;
-	}
 
 	/*  default broadcast & multicast use macid 1 */
 	psta->mac_id = 1;
-- 
2.31.1


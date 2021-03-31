Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785134FD57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhCaJmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbhCaJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72D9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bf3so21519902edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8n3ZwrC13ezuBVNAF/vXFI5bhVOgwsL7vX2B5CS7LuE=;
        b=AI5LgzhvLvWU1w28pHDAUeMGQ3Nq8rtFmseICL0hDSqnGt04bmGUVaN5K3ee0j1JEE
         C/NvnPU/zGG9cCDfPZ5BiF2c3191reo2TjLgP1r0ace4aCjA13KoHmoTqnIoXSB9ZLpy
         svQQou07kIpvJc9aFkT327QD5T/b7MxDOSysE8tMoC9sTzSxZ6FD3rxr/+/agxNVgWGR
         /lQSZciUzptWWqy1k62XLWHju58pO662K43drNLOt4OwfJL+Um9rO+3q+Cw/jR4m961P
         wIKSeRjHAk25pbwoUFqWM/OgO9Vb0zyxHc8VvwobeTXIlsNyv0gjLxwQX51fyuS2NS3i
         AfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8n3ZwrC13ezuBVNAF/vXFI5bhVOgwsL7vX2B5CS7LuE=;
        b=pzvCsPMzHbJHQI1EzrYVGms3GM28v9CNPZtpTuNiwyHUzDXFx6JWINsH0Vxe1XSips
         9T5siXyYIcnV/0er99JJHmfD6rbfG2k3Lasbd+AFhQKjLiG4AwGnmN1yLoGS0BcRLqgu
         gJ/dD8S/ehXtkZ09zP84QUJZ0g90If8W6F2T7igUTn0/7arigxEKNNxGc1TvD6NF83pM
         VnPFoJWI/3d45yBsG6H2uEncaLycEu2lriLMyA0oKZ6qiSES4sQBM6hv4K6QuMbyF5mW
         dKpgkLEpjULTMznTjFcw2me3yoJkiA7l+ObBUfWMvkrrp+Op1nxuv7F8ax4i7DGlwx2W
         8uew==
X-Gm-Message-State: AOAM533si1TJGVlIzW/OpQ3MaqPTsYZXGtfQDDoOgWduQAdHN6R1bggi
        7EMNreU6AUpwHxgAbATNCB8=
X-Google-Smtp-Source: ABdhPJxewNfOpoC32UN0+VBTKT6CMvHuag33jLmJfshVhr8zOJI5fb/lHXkm62FeLTX64+FPEYWXpg==
X-Received: by 2002:a05:6402:32a:: with SMTP id q10mr2561825edw.15.1617183682524;
        Wed, 31 Mar 2021 02:41:22 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id lu5sm814729ejb.97.2021.03.31.02.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 38/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/xmit_linux.c
Date:   Wed, 31 Mar 2021 11:40:06 +0200
Message-Id: <79fb0daed5d94bd92739cdf5985193a53834d3e1.1617183374.git.fabioaiuto83@gmail.com>
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
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
index 216b2f62eefd..50c381d7e734 100644
--- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
@@ -196,10 +196,10 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	s32 res = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("+xmit_enry\n"));
+	pr_info("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	if (rtw_if_up(padapter) == false) {
-		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("rtw_xmit_entry: rtw_if_up fail\n"));
+		pr_err("%s %s: rtw_if_up fail\n", DRIVER_PREFIX, __func__);
 		#ifdef DBG_TX_DROP_FRAME
 		DBG_871X("DBG_TX_DROP_FRAME %s if_up fail\n", __func__);
 		#endif
@@ -232,13 +232,15 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
 		goto drop_packet;
 	}
 
-	RT_TRACE(_module_xmit_osdep_c_, _drv_info_, ("rtw_xmit_entry: tx_pkts =%d\n", (u32)pxmitpriv->tx_pkts));
+	pr_info("%s %s: tx_pkts =%d\n", DRIVER_PREFIX, __func__,
+		(u32)pxmitpriv->tx_pkts);
 	goto exit;
 
 drop_packet:
 	pxmitpriv->tx_drop++;
 	dev_kfree_skb_any(pkt);
-	RT_TRACE(_module_xmit_osdep_c_, _drv_notice_, ("rtw_xmit_entry: drop, tx_drop =%d\n", (u32)pxmitpriv->tx_drop));
+	pr_notice("%s %s: drop, tx_drop =%d\n", DRIVER_PREFIX,
+		  __func__, (u32)pxmitpriv->tx_drop);
 
 exit:
 	return 0;
-- 
2.20.1


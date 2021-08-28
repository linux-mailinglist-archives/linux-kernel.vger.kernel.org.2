Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AC3FA557
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 13:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhH1LLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhH1LLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 07:11:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B4C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:58 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fz10so6456542pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plYRYTqUUFSzAFVzV7cfqMcFyLCLsZfoGtDYWiyJWFk=;
        b=Vp5uPO6kvb0NngbsoEoLcvI+7eyinFZMjM46948dtH07TDYiW0BQ6xr1UTQ0waWndp
         m4jCQu+vkVpv8HN1DH0FqzFmQUI5g23cuGkdiMHJxLuzjevfTDYNO/scWEnJ0QC+V7CU
         lPxgDj5TncK6fk2uq1Kh3tecjQrqaBPtu39aKj2YUHC1Ff441j+yRzR17DX04HWpmAdl
         bXJzO0HluTqiExXfZ70V2pAaJeGGZ3QQpj5h38G1YUI9ovFbHoSic0SLmtzEM+nqOc0c
         U98GL88RAmswaOTjMGR63zqTXlwb8MN+F25hnuJXqeIowXI0zbK2/tr3fdq9NgNb+e0D
         bcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plYRYTqUUFSzAFVzV7cfqMcFyLCLsZfoGtDYWiyJWFk=;
        b=edWQXADFgPDGu6KnD8SVKei9CKIj6oqL5+K5YL5k8RpAhRYcg/loLNouyIv6S0mD2Y
         gSw/RkHETocz9OdmgyGjuwtw4QaSvsRHUJefYNzYS/XDRbaLDIasFz6xuVH4MEKkl3pP
         3xk/n/9hQZF9sKhWbcq8x58/4i5uNGiVktNLuLYtkNP0ktz7cgMikAniwxXOOGB34682
         oGcsP1UQ4wfdWVh65KERsKHUd9Xu6yAeRIBQYclQS6HKIvSloiV79KKxLJBLnp20WB+R
         IwtqyRkJGtvZyVRyWsllDyDgmc1+XUryPFF+4aRRQz2kRpg+wnBgUICdRd86lQ2A0zSD
         w8xA==
X-Gm-Message-State: AOAM530VfL9R9JpeJTzHhRjqguOg/+0q97QwlU5gNVKqwmYTOItvI1jt
        hudtiLzn1/J2bRUyeHJlVeE=
X-Google-Smtp-Source: ABdhPJz7RH9YRchqoNkWpECvsbcuBGFEa+zzDcohGqE3t6tY1OYaoPQQchjsuO0gJw2PH3ZIKqw+ww==
X-Received: by 2002:a17:90b:1952:: with SMTP id nk18mr28843980pjb.193.1630149057820;
        Sat, 28 Aug 2021 04:10:57 -0700 (PDT)
Received: from xps.yggdrasil ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id y64sm10205379pgy.32.2021.08.28.04.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 04:10:57 -0700 (PDT)
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] staging: r8188eu: incorrect type in assignment
Date:   Sat, 28 Aug 2021 16:40:46 +0530
Message-Id: <74c156553614f44a900e987f1185f3388dd740f6.1630148641.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630148641.git.aakashhemadri123@gmail.com>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
> rtw_br_ext.c:516:57: warning: incorrect type in assignment
    (different base types)
> rtw_br_ext.c:516:57:    expected unsigned short
> rtw_br_ext.c:516:57:    got restricted __be16 [usertype]

*pMagic holds __be16 change it's type to __be16

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_br_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
index 38f1bd591da9..bce73e8cbd52 100644
--- a/drivers/staging/r8188eu/core/rtw_br_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
@@ -474,7 +474,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 		/*                Handle PPPoE frame                 */
 		/*---------------------------------------------------*/
 		struct pppoe_hdr *ph = (struct pppoe_hdr *)(skb->data + ETH_HLEN);
-		unsigned short *pMagic;
+		__be16 *pMagic;
 
 		switch (method) {
 		case NAT25_CHECK:
@@ -512,7 +512,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
 						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
 
 						/*  insert the magic_code+client mac in relay tag */
-						pMagic = (unsigned short *)tag->tag_data;
+						pMagic = (__be16 *)tag->tag_data;
 						*pMagic = htons(MAGIC_CODE);
 						memcpy(tag->tag_data+MAGIC_CODE_LEN, skb->data+ETH_ALEN, ETH_ALEN);
 
-- 
2.32.0


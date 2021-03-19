Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED65341243
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCSBoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbhCSBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:43:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:43:38 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x14so1391813qki.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtYe40cMvpJ5jW+cxbW4Q+QoxKOLjta5r1ofkTXrT5c=;
        b=fjD+Nbvw1GiY2cjJRBQ2po42ta5HsUJafxM9qRNADnvSwx4n/aUQwWp3IR1QLGpa6p
         iKWaS7ROFEBBNlvzZdzOB4+XeOs+JA9xELijHXmk0iP8MCoi7tGK/rnbN6xMdre7UbwS
         rUfbgXtI9cEXizYn5FiwmReZqM4xh6JPUQmnuA4HBN130unkbGiP07Hbu9DFE3F6f7tE
         ZCLcPm5UqUyWuPVhRJM5lM9gSgYQcYWzc2tC1bzk/wj58o63GYiTNnYhw9H+xDjFTI/t
         /Cm9Gh/xUfXmw2dOOMXFCfTCMtz4ewRcv4p6Ot3n+9cSwp4R8cGuKvax/V3+BjuaqZIV
         hsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtYe40cMvpJ5jW+cxbW4Q+QoxKOLjta5r1ofkTXrT5c=;
        b=lkIQBwfLNJNpppdnRJ4N2KLjF6ychHxLzYONNnz7F4c/N1KmEmb9h0Pn89ZLH+AV9o
         uTepL79tTy8NloyvjfgVtmbwtmE0T2gVxg4h9mHP1LXLPkk7fEE/woVm/K0i1GwapDNj
         vpIOIwiLtjYabAU0RV9WKnMC1+uNNiJwT1hz7K3pqSsHm7OIQBIFmO0lnXPOSHUBsQ+i
         mDNnimSBWMU9fKTcFsg4H6+/IMT8aQm8zTeuEMNZe+QwjrWoLyvIVKjGIh/2c1H5FNhJ
         JoNh7TwTlJuxUl3277GQYdX4EsnVOi6aETjrvMxXr1UrxGOOtHBsXtoTrXzj7AF0zx1a
         cr8A==
X-Gm-Message-State: AOAM532Bt5ndIopHIgihaQwHtDb2lBi84WV7ne0g/5/WfLc1BnJTNe3V
        1i1wPv0kIS17vOm4xrh5XqY=
X-Google-Smtp-Source: ABdhPJwjQoVoFuwgNAjbpcHou4wIwDyctQhezSdONC/uCtzIchh2AGBI66dG+FmreNw/Vohbs1ViEA==
X-Received: by 2002:a37:94f:: with SMTP id 76mr7835587qkj.222.1616118218167;
        Thu, 18 Mar 2021 18:43:38 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id o125sm3168515qkf.87.2021.03.18.18.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 18:43:37 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, insafonov@gmail.com,
        dinghao.liu@zju.edu.cn, dan.carpenter@oracle.com,
        yepeilin.cs@gmail.com, unixbhaskar@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] staging: rtl8188eu: Fix a typo
Date:   Fri, 19 Mar 2021 07:11:20 +0530
Message-Id: <20210319014120.6474-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/pasive/passive/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index f87dd71934c3..96d15fca48b0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -37,7 +37,7 @@ int rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = 0;
 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
-	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
+	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this varable to "active_mode" (Jeff) */

 	spin_lock_init(&pmlmepriv->lock);
 	_rtw_init_queue(&pmlmepriv->free_bss_pool);
--
2.26.2


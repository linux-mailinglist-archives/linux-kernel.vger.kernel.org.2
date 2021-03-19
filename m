Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8642F342653
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 20:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhCSTgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:36:40 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:36:39 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id t16so5601881qvr.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfIIG363a9greQETBbL5KuvjZaQwrTTY2HzKwrfTXhQ=;
        b=h6YjDbAdHtnMbaNTzDNBQaJTm49gL8a+aROrZ+/jMyaO3SHT2b5DVS7mAzMlEji7bb
         3LlhxjuzEbGtd98pV1ZeMXUP/lRE7aBBTlmW1XXMEPxteyx830VixF+yMOzQiKbpm9PZ
         eWA/I5gE82PN+6j9gPRwc+MDDEiwvmV2qGyUksJbvFtIVUS1r/QhTOL3Q9SOQegHygxa
         mUChaBClh3mlbhyEojNXw5mZyKyy2npkUfYEaU9RZa6TSHhKhPexwnyOI7KfwkKrBzGK
         M8HMrQHptlr4zJ7NaMkSXb9Pt2SIFqkktbMw4ReNS4N3/eVHy1vxQoJYHmXr5OWDgR2F
         uX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfIIG363a9greQETBbL5KuvjZaQwrTTY2HzKwrfTXhQ=;
        b=pcWi2uOmhSH49zcsfZbrSRoxoU7AemAhOd1aIwYxy+c67X0Uc7b1pUA3znDRBBizVW
         tmj4smaEg5RXXwDabDO33nhEMXLK5wXqzKqs6VXaebLiDqueTWseDZYGr2Exy6gONdPs
         hGM3RzlcD3wp+LBt4o4+81SxSOPiX7V5gfgUjkhPwP1YlkgnVR3zxIpCbVkvKztexk8h
         6vMcU+1lx0ookwHfet7kdScmxJJJgs4Nk4VwCiRT10JmbWReoac5pZUajpsGFY/ub2xR
         KASj45nr1uWveBxni6jTqd/sgZkxAAI+wF7bi9lKK5pwN0aVHP/hcwkNB2Fzm7aXvGA8
         Qh9g==
X-Gm-Message-State: AOAM532k23UBcTv0heVOWdWG0TMnGppqsUZY1tcRaFNMT05d5yB9bae2
        6MyrRBqkCcbvj/03hPkrZAD/FZKtIutwhGn5
X-Google-Smtp-Source: ABdhPJwaJEhjQuNSnl5UQ/yu8LAxjDUNoX6fWEQUAA0HaA9ltv4J3bgjIzPYuFsm+J5E48ijbwO/PA==
X-Received: by 2002:a0c:9b88:: with SMTP id o8mr11033766qve.28.1616182599056;
        Fri, 19 Mar 2021 12:36:39 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id j12sm4455999qtn.36.2021.03.19.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:36:38 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, insafonov@gmail.com,
        dan.carpenter@oracle.com, unixbhaskar@gmail.com,
        yepeilin.cs@gmail.com, dinghao.liu@zju.edu.cn,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH V2] staging: rtl8188eu: Fix couple of typos
Date:   Sat, 20 Mar 2021 01:04:14 +0530
Message-Id: <20210319193414.10393-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/pasive/passive/
s/varable/variable/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1:
  Randy's suggestion incorporated.

 drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index f87dd71934c3..b6ac5b8915b1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -37,7 +37,7 @@ int rtw_init_mlme_priv(struct adapter *padapter)
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = 0;
 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
-	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
+	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this variable to "active_mode" (Jeff) */

 	spin_lock_init(&pmlmepriv->lock);
 	_rtw_init_queue(&pmlmepriv->free_bss_pool);
--
2.26.2


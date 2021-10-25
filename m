Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F3438E90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhJYFB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJYFB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:01:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A3EC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:59:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r5so2495476pls.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Oj6YG+UlK0BMEsdxLQ+T4Tix49m1GM1wb9CYFVKaWKs=;
        b=Xs/SmSSe9dVc+xLlPgbcLjZwe1Qt2jRxYUfaenKnlQLSWEzGYl3A3BQ0SeP4NRPhUL
         YwOpI5IJub93JnWyb3mmMobKtuTQjItwtU+Dl1Iv9Fb8VkILoohNNMkCwmgCQf71m+DS
         /powvxRclzw+zYfh2RFctqFzFPFGSootaFM9+A0ViRhGaPrAe/3NkXQAidATfPcVTGD7
         cvqlqpfo2ZzfOBlQBDq685ZHMZnU3ES/NoTprV2/+/pF007L/cdZTL2AvvYgfztTSXtD
         Armm+nUa1AZpAE5lmcSvFU0LXIFMdSEa/3WYDlkYGfc0gu8s+9aOdKRbrxS5nZw2sRMJ
         NS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Oj6YG+UlK0BMEsdxLQ+T4Tix49m1GM1wb9CYFVKaWKs=;
        b=04Q21BT0Tj//kg0KIyopDATn8wUP84oDR9lEDKpId/+3l5rF+/TkbOQ0aG5HsSMlwQ
         +x4asx0VFSwUALjW896haZ9SozLUuKecrzZ/DQWHfmUHPJKZ8Tl0NRIyyqK0deoPecMy
         SRa3jzf0nANozwxN66HD1MWRUqlR137N2cQ0bzniXcZCTi5iRtiFuPRV9pCFIdBD5u43
         u0l4aNsJyunOQvTM0R7x7qdq3yfECZdaBHMkRJY+YlHaq/XN0GtAjx5RSdJYPfcWqZ48
         2Z5eDCtmQpjTefG7NyTJIxQYEd/X322nfqlob2hdI6AE3l6+64ZqCEbmWpof29uACvHl
         ItwQ==
X-Gm-Message-State: AOAM5304nzgc1Bq2PpQ60cpgwT8UoPWS8XoNCkEUIBN3GU2IVbMVfIPK
        XiUedKL9NEBfhSlOOM77gDz432f65gY=
X-Google-Smtp-Source: ABdhPJyjYb/DGDbMmIHgrxoGNgXujXBJlrSpqm+WDbSqOpr/weri4sUBP3gcRbXO6tA98JtdfOJz5g==
X-Received: by 2002:a17:90a:7e93:: with SMTP id j19mr33055907pjl.172.1635137944352;
        Sun, 24 Oct 2021 21:59:04 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.95.3])
        by smtp.gmail.com with ESMTPSA id q16sm19639434pfu.36.2021.10.24.21.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:59:04 -0700 (PDT)
Date:   Mon, 25 Oct 2021 10:28:54 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: avoid use of goto statement
Message-ID: <YXY5jtR6neQ+ad+C@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the goto statement from _rtw_init_cmd_priv(). In this function
goto statement can be replace by return statement. By replacing the
goto statement with return statement local variable "res" is also
not required.As on goto label exit, function only return it is not
performing any cleanup.Avoiding goto will simplify the function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index e17332677daa..22046bd5cf82 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -19,7 +19,6 @@ No irqsave is necessary.

 static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 {
-	int res = _SUCCESS;

 	sema_init(&pcmdpriv->cmd_queue_sema, 0);
 	/* sema_init(&(pcmdpriv->cmd_done_sema), 0); */
@@ -34,28 +33,23 @@ static int _rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	pcmdpriv->cmd_allocated_buf = kzalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
 					      GFP_KERNEL);

-	if (!pcmdpriv->cmd_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->cmd_allocated_buf)
+		return _FAIL;

 	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ - ((size_t)(pcmdpriv->cmd_allocated_buf) & (CMDBUFF_ALIGN_SZ - 1));

 	pcmdpriv->rsp_allocated_buf = kzalloc(MAX_RSPSZ + 4, GFP_KERNEL);

-	if (!pcmdpriv->rsp_allocated_buf) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!pcmdpriv->rsp_allocated_buf)
+		return _FAIL;

 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((size_t)(pcmdpriv->rsp_allocated_buf) & 3);

 	pcmdpriv->cmd_issued_cnt = 0;
 	pcmdpriv->cmd_done_cnt = 0;
 	pcmdpriv->rsp_cnt = 0;
-exit:

-	return res;
+	return _SUCCESS;
 }

 static void c2h_wk_callback(struct work_struct *work);
--
2.33.0


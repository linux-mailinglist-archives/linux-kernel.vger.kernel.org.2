Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD57F415125
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbhIVUJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhIVUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:09:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so10540312wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N48xzJX83krJz5vioP0fMzs94uTfOkuwlYCRYiwT9ok=;
        b=bhUehmFBdrPbCuDxYZxUb3RwTBf/Y1AT+fq43j5FYYykOi8MRRnWP32MSJ4Qfc96RM
         Th3zj22e7wUiKExGgQvl7vCQ/09ysiOvWd4WQi6s16f7neWhOclB2LyVbviwHfNVVKbh
         o+JnFzSOzHJTPOEQEYfF0m30bjLm53So+rW0TkB3SaBmC5FAcDdFXX/DvL9ttbz8aDwD
         hUQuPDTMdiYD8LZp0fPcWqUQlDmpCy+n3YER4IF7edbmO727ytM1lKlFazXeBAixC3g5
         hzI+xlsk0GjKOrFKou0MWGgBP8TlnIiADNs98vCBADYWXPRE+ieTcTVWgFPJaL2Usort
         bIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N48xzJX83krJz5vioP0fMzs94uTfOkuwlYCRYiwT9ok=;
        b=rPNNNrjfbOP2xzjvxO7x3DTpt6sjqbeUjNrCOeSmXakuPpjO0Q/iY8V3JR0NNi+Z7E
         CCH77n11KziIlXOJw7CSS42QCwjWtcKWon9sd5s0OdSlNwhp5TGrMrI8qU2OdZeAO5Fw
         r8MQChMX5isHcRbMUOSTkyWnZIaqfxVO8k+LpIM56JEJQA4UeHPEqfgZUjs/h9f4KQar
         iDIqo3MshU/gw8RQ+hYi5aZsvayP/j+3VPF+XosiRA4hLz7WkmyRsToOUyn39oXibBHD
         9Mubljhs7XjsdKD6UNPk7nIqgsJiNd7FPaOBW1tzBT+gJab+ZZCbMLcNBesGpxmB5E08
         Bkhw==
X-Gm-Message-State: AOAM532P/zYW0n2sYdwOzvNhrjSqa1Q1NReVAUSDhxHCEMZu8plSvd4v
        AwusbJyMB6wBf4cLLef2ylE=
X-Google-Smtp-Source: ABdhPJxgFBsdlNvO/nD+r27Wo2kkQVsiUvsdR6QzHw925+S6Iqo1RLqTBcPMSA9tDGJ2hgEGvvgODg==
X-Received: by 2002:adf:d1e9:: with SMTP id g9mr919303wrd.200.1632341166053;
        Wed, 22 Sep 2021 13:06:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:06:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 47/47] staging: r8188eu: remove rtw_sctx_done()
Date:   Wed, 22 Sep 2021 22:04:20 +0200
Message-Id: <20210922200420.9693-48-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_sctx_done() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c    | 5 -----
 drivers/staging/r8188eu/include/rtw_xmit.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 6213244450e7..896ed91d3814 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -2188,11 +2188,6 @@ void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 	}
 }
 
-void rtw_sctx_done(struct submit_ctx **sctx)
-{
-	rtw_sctx_done_err(sctx, RTW_SCTX_DONE_SUCCESS);
-}
-
 int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms)
 {
 	struct submit_ctx *pack_tx_ops = &pxmitpriv->ack_tx_ops;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 01e8b90becf5..ea8e82e0b4be 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -185,7 +185,6 @@ enum {
 void rtw_sctx_init(struct submit_ctx *sctx, int timeout_ms);
 int rtw_sctx_wait(struct submit_ctx *sctx);
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status);
-void rtw_sctx_done(struct submit_ctx **sctx);
 
 struct xmit_buf {
 	struct list_head list;
-- 
2.33.0


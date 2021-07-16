Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC203CB5F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhGPKZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbhGPKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:25:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA9DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so6553727wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+agN8Y7YKzZWGYmosJCMKjDZQDR4OYf00Q82/uMWOlg=;
        b=MOrqkMTRaghA4zePX8fRMewT5cG3NtLKJzS7iORpeQbcGZqwTYyZCtkxuk2rmNk0Ud
         djO3kn4BW1OIclMYeYfeHmGGbHvAV3vxxRIQFWFGQI3+6qfgDH/6vzD8WIn2ZgPZ2YGG
         7VCJ/kdpZhu1Fs9zeX1ssJZEYGjYnz04CfnR2KJDmNiSL02A5ncCqCaeFAPYAK4Vj8r5
         0EHWwTzmSJT/LXy096e6SydUisLTV6va0I8EBMhJoszJKXvhTDpagssqecy9J/QWpZiZ
         t9hi8nEZDokN4SbyG1sbLgskvyuzQCoXUcEr0qgmPoIaAUfuWmfLQM0GZTEhy4XB/UJM
         Fcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+agN8Y7YKzZWGYmosJCMKjDZQDR4OYf00Q82/uMWOlg=;
        b=YpOY0vzaC/b+oXson9WghOQwhawp8cdafCkVfX1+8DpelXc3bY929sfSYBzy2tmlUV
         JY3RrhGiiTJgUASD5tovD2g4LptQrffxnwoOPJ9uwsiqcqKQyc7swJuQFzH87nN8fLgY
         p2pLLrrHfsVVdqttFtRzAszh/sjVwyV7M8QGVhtt/B2K40Kj2uorYPemxOSfqr+BUbW8
         H6Lgz4Q3u/WHZvcui1nx3yK5Ek3QQtD0q0TPWhWePBrs1CyXrPB9GIZlRyMd7VJjvX+j
         B7IIuZnsana4o3CsGKZRA4eEJC1sdbcCrgcRpH/PdU2CW7eUxRGaaZJX+j8h6XTozlFS
         ZR+w==
X-Gm-Message-State: AOAM530M0/G3JCzRFIBlsiSIoo4GvuODd/RYuw5Yyn3faivriwjYBAUX
        j1624qydTWkFVboSZgB5dURlcw==
X-Google-Smtp-Source: ABdhPJwNc+AyvJtfQ9kkcmoxhYtdC+xXLCIe0+rEhwDGj7Jiug7pX6oKrAKZ8OzjWmM5DCK45wh0CQ==
X-Received: by 2002:a7b:c1cd:: with SMTP id a13mr15467463wmj.75.1626430956488;
        Fri, 16 Jul 2021 03:22:36 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g15sm7421796wmh.44.2021.07.16.03.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:22:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] slimbus: messaging: start transaction ids from 1 instead of zero
Date:   Fri, 16 Jul 2021 11:21:20 +0100
Message-Id: <20210716102123.26861-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
References: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As tid is unsigned its hard to figure out if the tid is valid or
invalid. So Start the transaction ids from 1 instead of zero
so that we could differentiate between a valid tid and invalid tids

This is useful in cases where controller would add a tid for controller
specific transfers.

Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/messaging.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index f2b5d347d227..6097ddc43a35 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -66,7 +66,7 @@ int slim_alloc_txn_tid(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	int ret = 0;
 
 	spin_lock_irqsave(&ctrl->txn_lock, flags);
-	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 0,
+	ret = idr_alloc_cyclic(&ctrl->tid_idr, txn, 1,
 				SLIM_MAX_TIDS, GFP_ATOMIC);
 	if (ret < 0) {
 		spin_unlock_irqrestore(&ctrl->txn_lock, flags);
-- 
2.21.0


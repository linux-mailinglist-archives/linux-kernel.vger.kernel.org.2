Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0984E30ADD9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhBAR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhBAR3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:29:35 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19721C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:28:56 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id y17so16360071ili.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nmi+suSrpZfRwUpuA9SDfz6AzQTTcweGvCEfMikGM/s=;
        b=SCjwns0xGu4PCRVAJxUo4cKOUR203WZ9Rix9ZEVp+QhKiTx9EOir+C4rbRwdem6Q+W
         szdAGcuBPF8xNcHUvWeTrt53S6TtRwh086q5BVt7Lwz+n6qfiZkjvaCjBcGoQVip/Tv9
         ZeCUTwIbbAqlDUFA35dg9xRJupeMAdjl5qHMpssAtmNMGQkHZ2TSJYBIaPsrRpQs4z10
         9AwkcdrDmMHUFN06WBX1Gvn39GbTH0ZcL3T+qwLm3ZnQ3qjqphmvgv+K2g1SYlYYJGYQ
         M6QlS7HoNWNSTa+sZtjFNjBPXQA+IO5Oi4fPOgZXWUqa9I0w6NVofqT4iao6epSrkbtR
         M38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nmi+suSrpZfRwUpuA9SDfz6AzQTTcweGvCEfMikGM/s=;
        b=lZUAHH3ZmiKVOIl9MB/7N6FGtP7Ec9GZpSNf3DtrVB23YrV72toc2Jpb4WOHBbiQdo
         PCHTITGZKRb/WEXywrTu04LWKtkUMYo5JO7wMme+9G4ibyRsRJOBpIbzfTFLzQXt4i30
         2OzjQStO358e56d0qxXjSJHjVkBCpPeai79UoLrOr2UzcjdOf+7UiqZz3e6pcMpU8Eey
         JIFptZjlgjBxt23gZNW6c0tIn7xIsJMLfV2Mf4eIkADJD/b9fOgUhXCKoxGpxrcTeTIa
         9H0A2V14SO9sp7OVrVPCHd2ROL6iU5KzxYEDOHNu+/N9sgRbIouuIM5WTH0VHSVPgCGv
         0TAg==
X-Gm-Message-State: AOAM530GXtcAe3dAp2Wiv3q02G6tZ0KbPwFCVm095hTmKJ/WGZpZkmxN
        npcjzMx2CrLny+HcPGG6QhnJYw==
X-Google-Smtp-Source: ABdhPJwOFE77Qq2RHPXQ2uk/QvWZ6WlhvXTdG9EhrlX/ynsXUW0mTEzCGhIVOSWEjt3mZWdVxeXu7A==
X-Received: by 2002:a05:6e02:19cc:: with SMTP id r12mr14043945ill.4.1612200535576;
        Mon, 01 Feb 2021 09:28:55 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id v2sm9529856ilj.19.2021.02.01.09.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:28:54 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     willemdebruijn.kernel@gmail.com, elder@kernel.org,
        evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/7] net: ipa: don't thaw channel if error starting
Date:   Mon,  1 Feb 2021 11:28:44 -0600
Message-Id: <20210201172850.2221624-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210201172850.2221624-1-elder@linaro.org>
References: <20210201172850.2221624-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs starting a channel, don't "thaw" it.
We should assume the channel remains in a non-started state.

Update the comment in gsi_channel_stop(); calls to this function
are no longer retried.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index f79cf3c327c1c..4a3e125e898f6 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -885,7 +885,9 @@ int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 
 	mutex_unlock(&gsi->mutex);
 
-	gsi_channel_thaw(channel);
+	/* Thaw the channel if successful */
+	if (!ret)
+		gsi_channel_thaw(channel);
 
 	return ret;
 }
@@ -910,7 +912,7 @@ int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
 
 	mutex_unlock(&gsi->mutex);
 
-	/* Thaw the channel if we need to retry (or on error) */
+	/* Re-thaw the channel if an error occurred while stopping */
 	if (ret)
 		gsi_channel_thaw(channel);
 
-- 
2.27.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3F9308E74
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhA2UZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbhA2UWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:22:03 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBCC061797
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:29 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u8so5548473ior.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBeIWIoL4lPuHMIewwlmHC2HR0MCP9P0drFvCV7BbtI=;
        b=M/Ac5MurdUC/9plj3pZACJ+JA8zznucmWbj1AaldW7yCA9ngrjrkzXzJzEvC5KtarH
         YzVQUuEyIxHvy4AfU+DmcgW7y957rDp2Ny/yc1r53wNwtK7bGTwKpabKM4uJPM3Ahg08
         BRm+3pvP2LOp8HIG3etB69TmMoNeiH4H1oLeoaJjtJl/nOq8bIOnsSJFiC93pnJTwUTC
         Eyot0H9zGfWFkE5A/RWF7YnmQtwyusKuDtSy4JYOTkA6dfvI+3DL+3hLPM9PUqfsNj6p
         1WvwcbNpn7NKnRXtV1itl8mDeyVRzYNIaq61ETfAIu4hFb8lKa9okO4qYZDV5GULaQPn
         rZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBeIWIoL4lPuHMIewwlmHC2HR0MCP9P0drFvCV7BbtI=;
        b=KAONOLf/UVW5gLJzOp6H/Zam7vn9wFV9BEkUmg4keL+HPWsaRRECrAzXDM5NVi99t0
         hFo4ptL6azWT0EAFcJ6OmWPwmlV7DKllvfpDT0qnDAS1p9+Mab9ppfSyjNYOF5JyPs2U
         w6s+XDbR/Xjufq0tMDmeqZFJKCZ8MvN1yzZdsAPf7yZGv9mwkI3PXpQW9/M2fjz99GRU
         BiFnDAFhubOQXIQgxZctEQ/Zc5kMYuR7EuUjD/pRra8CUpYntXhdFvMLqoJSQief6bAA
         /B2/UVNp4S9awAUyN7EvMBvepacxbF7h20knrUiJVuljQVxWUbgOkYmnuosAznQ5+vVz
         ejNQ==
X-Gm-Message-State: AOAM531Oag2L0DncONAo+FfVDDbbGUb2uHPh2wQVsSV6nc8mcj3u8M7U
        Dtm1kNScVCCjVPYoVJdqtmoUfNyUZhdLsA==
X-Google-Smtp-Source: ABdhPJxQxobB4kniGzBmeBuz9P8MqRdPlwo2Fp9dng1UIv95gYWaDFnj70nI2afzo18Ox1BPOW72Fw==
X-Received: by 2002:a02:ca17:: with SMTP id i23mr5513738jak.25.1611951628546;
        Fri, 29 Jan 2021 12:20:28 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h23sm4645738ila.15.2021.01.29.12.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:20:28 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/9] net: ipa: disable IEOB interrupt after channel stop
Date:   Fri, 29 Jan 2021 14:20:15 -0600
Message-Id: <20210129202019.2099259-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129202019.2099259-1-elder@linaro.org>
References: <20210129202019.2099259-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the I/O completion interrupt on a channel *after* we
successfully stop it rather than before.  This ensures a completion
occurring just before the channel is stopped triggers an interrupt.

Enable the interrupt *before* starting a channel rather than after,
to be symmetric.  A stopped channel won't generate any completion
interrupts anyway.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 565c785e33a25..1a02936b4db06 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -860,16 +860,18 @@ static int __gsi_channel_start(struct gsi_channel *channel, bool start)
 	struct gsi *gsi = channel->gsi;
 	int ret;
 
+	gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+
 	mutex_lock(&gsi->mutex);
 
 	ret = start ? gsi_channel_start_command(channel) : 0;
 
 	mutex_unlock(&gsi->mutex);
 
-	if (!ret) {
-		gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+	if (ret)
+		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
+	else
 		napi_enable(&channel->napi);
-	}
 
 	return ret;
 }
@@ -909,14 +911,13 @@ static int __gsi_channel_stop(struct gsi_channel *channel, bool stop)
 
 	gsi_channel_trans_quiesce(channel);
 	napi_disable(&channel->napi);
-	gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
 
 	ret = stop ? gsi_channel_stop_retry(channel) : 0;
 
-	if (ret) {
-		gsi_irq_ieob_enable_one(gsi, channel->evt_ring_id);
+	if (ret)
 		napi_enable(&channel->napi);
-	}
+	else
+		gsi_irq_ieob_disable_one(gsi, channel->evt_ring_id);
 
 	return ret;
 }
-- 
2.27.0


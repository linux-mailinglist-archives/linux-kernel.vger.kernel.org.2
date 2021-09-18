Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2DE4106FB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhIROF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhIROFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:05:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E223C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:04:29 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 70so6533975wme.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpjBJY1Cq+qltZ9DGxMp7uTj8fnDmJWHBXHXLgVRsKM=;
        b=MzEmML0mVi4/gcsHx77eWSdixfhaarBPpCLf54PiSlHKdzLhiPu/D4hrvEViMczsIM
         roHH4SkoHHvpI2476uD+TCS1h32/naCa5ZOmmaxHjBuFiHn7blck4IlYdnXW1iTUJHvb
         kV0wcfliPMdpEaYt1OSQEPK7VAGS8RiNg4njbsVmVgSMLvzOeJ2DSs/s//PMV6PvKZwf
         191hRhCLLNLwp5TSNkGzNhywPH+DOp2OG6FxgCaE8Nk3W26XmDjHhdKH9YT9h6l3vwJg
         mPN87/rDY+mXnXisWvtYvIC9VJJ5auitMDdInxvSEeAtJsmZFvZPMyfKHxI/gXaVgNZ+
         2peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DpjBJY1Cq+qltZ9DGxMp7uTj8fnDmJWHBXHXLgVRsKM=;
        b=TQKnHP+SEQa+vxISEh+CeUo1GCT0hZTO8KFV5oVI9P/aStWgg3aJ01s8v4/t633pBL
         Pw7Ybogk5wn70idxtWAENVaMce5x2bUy7gygrZtpS2VFXO3nbFSGLTYFUTDCNGKMBDSv
         HRL7jZC5yCezXe0niP48c/xsbSYbbwGxKblTeFj7HCIePMsl7UadGVwQyCN8qv4359lJ
         La1+Pi4jcAx7RQIccrHGXtsZ0fAW3iGOUNBy207Wnesf2yrr+QOUrzf5WDtRmMv2zQo9
         H7fpTO4m/zqUTaaRpcs55a1WtR+ikpyft76eO6Er6mguAQef/VpycGkKEf8+PSiU3cLW
         P8QA==
X-Gm-Message-State: AOAM531wktmw9NeTuACL2rSQvAgDJ8ojcB/CBYUECW9KWn7PM/avkS8g
        b2rnd0GRzh2AzU3tOQeJtg==
X-Google-Smtp-Source: ABdhPJzKFMpBEx1H5UuJ71s4zcPrWpC8AQ1cTfNrTu4hwch0/BFCFMtPRqMdq86Y3t9dmHls7ipAsg==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr15404422wmj.70.1631973867807;
        Sat, 18 Sep 2021 07:04:27 -0700 (PDT)
Received: from alex-ThinkPad-E480.. (ip5b434083.dynamic.kabel-deutschland.de. [91.67.64.131])
        by smtp.googlemail.com with ESMTPSA id x5sm11764429wmk.32.2021.09.18.07.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 07:04:27 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] drm: bridge: it66121: Fix return value it66121_probe
Date:   Sat, 18 Sep 2021 16:04:20 +0200
Message-Id: <20210918140420.231346-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it66121_probe returns -EPROBE_DEFER if the there is no remote
endpoint found in the device tree which doesn't seem helpful, since this
is not going to change later and it is never checked if the next bridge
has been initialized yet. It will fail in that case later while doing
drm_bridge_attach for the next bridge in it66121_bridge_attach.

Since the bindings documentation for it66121 bridge driver states
there has to be a remote endpoint defined, its safe to return -EINVAL
in that case.
This additonally adds a check, if the remote endpoint is enabled and
returns -EPROBE_DEFER, if the remote bridge hasn't been initialized
(yet).

Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 2f2a09adb4bc..4e945efc8eb9 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -918,11 +918,23 @@ static int it66121_probe(struct i2c_client *client,
 		return -EINVAL;
 
 	ep = of_graph_get_remote_node(dev->of_node, 1, -1);
-	if (!ep)
-		return -EPROBE_DEFER;
+	if (!ep) {
+		dev_err(ctx->dev, "The endpoint is unconnected\n");
+		return -EINVAL;
+	}
+
+	if (!of_device_is_available(ep)) {
+		of_node_put(ep);
+		dev_err(ctx->dev, "The remote device is disabled\n");
+		return -ENODEV;
+	}
 
 	ctx->next_bridge = of_drm_find_bridge(ep);
 	of_node_put(ep);
+	if (!ctx->next_bridge) {
+		dev_dbg(ctx->dev, "Next bridge not found, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
 
 	i2c_set_clientdata(client, ctx);
 	mutex_init(&ctx->lock);
-- 
2.30.2


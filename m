Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293BE31A0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBLOg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhBLOfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:35:39 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54EC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:34:12 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f20so9448811ioo.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ljog9ADMI3z+A1fikGBkRhxkobB8HTkMuLZ8xQG2g7c=;
        b=bZPMogVKVXPc4UeEnREVxKL+YxfNYWyThw2gIao1s47oH9l7EXzOZD1o3VNMOVNub2
         MYRhBbFNh/F3dU11b3M8E1W7d0aplL/ybV3BQ0+l1yIJ+P4rCdJ9Sv1DJyHp0vS4kVPR
         yCQOx3PoTBXERzgBVuslsb2CVrgvOlP3uz8dirHkfIn3OcezU48qv+1eSjI8zUVcb28q
         epbNpllF8SZPHQdNzV7XDpFcHvvKhJTlz09vVyMKkHk1NX/wyrMS1YGwGry2t3amriAV
         ynFcFU+9cy//KT2wgJIFa+5w4VqxFnNAkcks8NAZelHuHlusfacvZLbMaucZZbSr1cBB
         MXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ljog9ADMI3z+A1fikGBkRhxkobB8HTkMuLZ8xQG2g7c=;
        b=RYmReQ8vU2kfpIQ/ITsY2CBV2ZuH/YrXwACfDVLSfCUNVR1QOqOS/OoenSogXWvSG6
         E88cfAFPQKa3mDVT8FbmRd9DsoMqIIiYPtkGZfop9fCYWPX6OBtsGHpg1MyYEUOCmi6H
         s6vJk9kH0YoDjFMxZfaOp/cOSSgiDDfXwjQx5XuGEHccPXttO3hx4Tp7YWlUsEa+M335
         ugkYZVVRa9tU+q3KciEbNvs3zhXb5RonSiXCpfCtQ8y45vnTTJNJoI6diyzAU93TPU0f
         tiZVXNYHDCcie8Pa6HpE4ZbNw55eq6nZtPVz2plea9htrHxz2wwvDsYuH1WufmqQUyuM
         lKcw==
X-Gm-Message-State: AOAM533goe3RrbDWQiXbNjV3f0TCZcT/ZwaJsczw8ZOaieuP/fr+lrWe
        rvWCK3/4X+DKVhWmGQx2QidShw==
X-Google-Smtp-Source: ABdhPJxOiDYHCC21oqnaEphmZFEC1hNzb9Z3mfQ6lzO0cR4BT7/b5e1SCSw2tr/OYgjRQqeBKUs//A==
X-Received: by 2002:a6b:da03:: with SMTP id x3mr2259297iob.127.1613140451517;
        Fri, 12 Feb 2021 06:34:11 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j12sm4387878ila.75.2021.02.12.06.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:34:11 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 5/5] net: ipa: introduce gsi_channel_initialized()
Date:   Fri, 12 Feb 2021 08:34:02 -0600
Message-Id: <20210212143402.2691-6-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210212143402.2691-1-elder@linaro.org>
References: <20210212143402.2691-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a simple helper function that indicates whether a channel has
been initialized.  This abstacts/hides the details of how this is
determined.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 9c977f80109a9..390d3403386aa 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -175,6 +175,12 @@ static u32 gsi_channel_id(struct gsi_channel *channel)
 	return channel - &channel->gsi->channel[0];
 }
 
+/* An initialized channel has a non-null GSI pointer */
+static bool gsi_channel_initialized(struct gsi_channel *channel)
+{
+	return !!channel->gsi;
+}
+
 /* Update the GSI IRQ type register with the cached value */
 static void gsi_irq_type_update(struct gsi *gsi, u32 val)
 {
@@ -1638,8 +1644,8 @@ static int gsi_channel_setup_one(struct gsi *gsi, u32 channel_id)
 	u32 evt_ring_id = channel->evt_ring_id;
 	int ret;
 
-	if (!channel->gsi)
-		return 0;	/* Ignore uninitialized channels */
+	if (!gsi_channel_initialized(channel))
+		return 0;
 
 	ret = gsi_evt_ring_alloc_command(gsi, evt_ring_id);
 	if (ret)
@@ -1675,8 +1681,8 @@ static void gsi_channel_teardown_one(struct gsi *gsi, u32 channel_id)
 	struct gsi_channel *channel = &gsi->channel[channel_id];
 	u32 evt_ring_id = channel->evt_ring_id;
 
-	if (!channel->gsi)
-		return;		/* Ignore uninitialized channels */
+	if (!gsi_channel_initialized(channel))
+		return;
 
 	netif_napi_del(&channel->napi);
 
@@ -1770,8 +1776,8 @@ static int gsi_channel_setup(struct gsi *gsi)
 	while (channel_id < GSI_CHANNEL_COUNT_MAX) {
 		struct gsi_channel *channel = &gsi->channel[channel_id++];
 
-		if (!channel->gsi)
-			continue;	/* Ignore uninitialized channels */
+		if (!gsi_channel_initialized(channel))
+			continue;
 
 		ret = -EINVAL;
 		dev_err(gsi->dev, "channel %u not supported by hardware\n",
@@ -2089,8 +2095,8 @@ static int gsi_channel_init_one(struct gsi *gsi,
 /* Inverse of gsi_channel_init_one() */
 static void gsi_channel_exit_one(struct gsi_channel *channel)
 {
-	if (!channel->gsi)
-		return;		/* Ignore uninitialized channels */
+	if (!gsi_channel_initialized(channel))
+		return;
 
 	if (channel->command)
 		ipa_cmd_pool_exit(channel);
-- 
2.20.1


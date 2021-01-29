Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22113308E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhA2U16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbhA2UVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:21:25 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F25C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p72so10611753iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LCw8t3dNLb85N9LUx0CmQJolraUZfpfFkvo2+8sOa0o=;
        b=g2i4IwJ+Kj8enui+8IT7o5h9xAiJjUactPE+pJmvcAY7VNWDwx/jQ2ubO5SGGU2Rmd
         l/fDq7rjrUXlJyU35nRapnL0exdNhPeD6v2WiVNScBZUf9o+F5VCCW5VmPvZxHxcIDB4
         IQf65oz5qpCDZKu2dUBvfr0T6Iacjk8Qp2jsqgVvyhQmKPg0zbYXkX6x4eYq6KufgK4o
         Z8/67LJISEBEiSL5Nlsc0g5Vk88Mk68BVTxcz3CEz22Zr+b2OWuWJqmxL72b8UQxRuWf
         O4qcac3ZSCyWk9PtrVnpx3kgSev0bZe+Gn+e0G+MlAfhzJ8gle1AHSB3LBTB5NtD8jly
         aCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LCw8t3dNLb85N9LUx0CmQJolraUZfpfFkvo2+8sOa0o=;
        b=uCc67mhGLUmAXxZmuL+yIZItdkSC4k0d5qhe9mfMCoK6Q9cybefjOpvm1D1KreuVfo
         qSkPtzqUO3iit8rcqC83RJmso/49ie2zb9x50TpWcWNS9toMZd7nfroWFSvQ7eBLJsvZ
         m1lJ0E1xwMd8cf7TCScpvAL2M0j7kNVaR3JRU9rxoPqtVYosVwpw0t5nBp7je2RoFcSj
         MfHWd8kPER3a2VGZMHIwNJ0tjH5Ma7GeFrjGUL4P3axhPjwrNy1FCZtDEYJnlyTHKAIx
         h6FKxKttHyE3sxOAPaRGxAha9UHYn9gD0FtPLxZVmM8UiAX+aIycCO6vAXXGxCExJnE0
         Lbfw==
X-Gm-Message-State: AOAM5301SqfOW9RWs6faaItMhS3XRbGvnTLrkT502RpTxmnuYCXS6of4
        mU7d6MGhwkaMbkz0tC0eAjbriA==
X-Google-Smtp-Source: ABdhPJwEPu3+q3wOtNmhi0OavTcDqf0tLsgVDEnMvJryLK9+j9CtD/JnDfWM6yR+o11zak3wx4cYNQ==
X-Received: by 2002:a05:6602:4b:: with SMTP id z11mr4864766ioz.47.1611951625315;
        Fri, 29 Jan 2021 12:20:25 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h23sm4645738ila.15.2021.01.29.12.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:20:24 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/9] net: ipa: introduce gsi_channel_stop_retry()
Date:   Fri, 29 Jan 2021 14:20:12 -0600
Message-Id: <20210129202019.2099259-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129202019.2099259-1-elder@linaro.org>
References: <20210129202019.2099259-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new helper function that encapsulates issuing a set of
channel stop commands, retrying if appropriate, with a short delay
between attempts.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 4a3e125e898f6..bd1bf388d9892 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -892,15 +892,12 @@ int gsi_channel_start(struct gsi *gsi, u32 channel_id)
 	return ret;
 }
 
-/* Stop a started channel */
-int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
+static int gsi_channel_stop_retry(struct gsi_channel *channel)
 {
-	struct gsi_channel *channel = &gsi->channel[channel_id];
 	u32 retries = GSI_CHANNEL_STOP_RETRIES;
+	struct gsi *gsi = channel->gsi;
 	int ret;
 
-	gsi_channel_freeze(channel);
-
 	mutex_lock(&gsi->mutex);
 
 	do {
@@ -912,6 +909,19 @@ int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
 
 	mutex_unlock(&gsi->mutex);
 
+	return ret;
+}
+
+/* Stop a started channel */
+int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
+
+	gsi_channel_freeze(channel);
+
+	ret = gsi_channel_stop_retry(channel);
+
 	/* Re-thaw the channel if an error occurred while stopping */
 	if (ret)
 		gsi_channel_thaw(channel);
-- 
2.27.0


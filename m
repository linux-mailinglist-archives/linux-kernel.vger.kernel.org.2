Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B780C453135
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhKPLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbhKPLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE36C061206
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:46 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b12so37029235wrh.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCyiK2qb1OjrBa7Q9ogzPGmxQZdO6zxp4f+nX7Gvr4E=;
        b=u6/Qx08ym6n6+0pUi+ZienjvfVY6wB8yIHLTbnMTgv7QVxP1X06PdXFX49aFXg7MsS
         AJ8edlpHH13EpEx9wHGZTcPgw2z7V0mLdKZxj7f45/axbn4TlfcSlH7tlvQf5IEATzvK
         9GyoBcLGAmfA+BbRUBQqCeHjLGYEUORtXVpMFCDGKC/k4SaDl3DAoMBd5mlwbPAPP2OV
         +y6N90ugvsOpv2HyWHT8F48vjTRXuTp6BVBScBDoMiP8lqHQcyu2MbCRmOKSmsarphR/
         K7onfMqMVg1Mf64/n09e73BbGTTU/ZkICTgwxD66ydERajc6G7tWjY+AKCMkCmf+ebrD
         AKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCyiK2qb1OjrBa7Q9ogzPGmxQZdO6zxp4f+nX7Gvr4E=;
        b=D678Ew06Yj4CJXZW22Q1sL+36dh+AaiTog3aJHivmeQB1Kqg3d/zem7pEuwNvWwmj0
         M3yBbZ57V/00MxlbrxjwCJlI2QHs2Ll3BAU2Qmqm3UZ4qsnuR0CdVHobjy/M3F4GjcSN
         Ocp+Wynl8zVlhd04YdeBIDg+uhpmcNH6mKOjcjxy12rknz1MJAlIC3ATB4UqF4PGSmPC
         1Rs9vUuLlujzh13JRPJ6oJJ1LdRcnGY7+GQzYNcK6j3W4VyJ8C3K5t7TWeCB9rgC3cEk
         8BQpWYpdTHxMGIYWZ3lyWy5bcZpsVmGXUnIi2WShaIvoCkvnAIrmkN9itUGTOJtR63Xt
         DL+w==
X-Gm-Message-State: AOAM532DBcwxm6qbI6dU5rImuKPYHJyNArkp7cIwXLJmDcc2FbieSIC6
        6VBo90iJAceZQlL2fY49g9V4fg==
X-Google-Smtp-Source: ABdhPJx0GNuuzjNB7ahnQqiG73+rs0tCtV7xxD5YuCivQQd6CQJJj5Ln6VGpFzV7oqg7gSFeCeG0fg==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr8737472wrc.67.1637063264689;
        Tue, 16 Nov 2021 03:47:44 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id l8sm2260523wmc.40.2021.11.16.03.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:47:44 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/5] ASoC: qdsp6: q6routing: validate port id before setting up route
Date:   Tue, 16 Nov 2021 11:47:21 +0000
Message-Id: <20211116114721.12517-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
References: <20211116114721.12517-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate port id before it starts sending commands to dsp this would
make error handling simpler.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 243b8179e59d..cd74681e811e 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -372,6 +372,12 @@ int q6routing_stream_open(int fedai_id, int perf_mode,
 	}
 
 	session = &routing_data->sessions[stream_id - 1];
+	if (session->port_id < 0) {
+		dev_err(routing_data->dev, "Routing not setup for MultiMedia%d Session\n",
+			session->fedai_id);
+		return -EINVAL;
+	}
+
 	pdata = &routing_data->port_data[session->port_id];
 
 	mutex_lock(&routing_data->lock);
-- 
2.21.0


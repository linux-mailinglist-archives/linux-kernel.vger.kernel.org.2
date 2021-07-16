Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0BE3CB5F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 12:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbhGPKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbhGPKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:25:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2DC061764
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t5so11452517wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phsqVDKt7cS5gPFlQtF9euIsqh6Lyd2uhcBMlgfbuug=;
        b=RtMIQpqgVXDnA7mNNctHnw56XAzb+jtElYAMhxhCoKj31wcOD2of9eOV5AF5H2iw0t
         5PnhV/EhLW5DTYV9G8tA46UxrsZpjxQ7MZvbzbR3U5fi+VhV3FDD3D9qLDuzkDzKnyig
         4TJwJp2TVuO7zP/kEEd2ZSYh1rDmw+MK6ji2Onh96ti5KlcyVCNkHVH282Vd9393OIt+
         ROyoCwrwwx5pwJjHKJzAHgLsQtldUdSDOZ8qDUJ/qXUy22iNNjbuyMrt1q/sOwwumgj6
         cIrObp9ZMrjQJs4OJTLiAfmvR9TF8B2++M4n6VvldrpIKKZR5QuX1Dj3gkJbQvJQHu/y
         AlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phsqVDKt7cS5gPFlQtF9euIsqh6Lyd2uhcBMlgfbuug=;
        b=EHNI4Co3dsVvsVTcsPWFa8L7EoR6gMZ60nqXBoSXxXqTPiskczl6jzgx0qe5toecTw
         W7fWlD2TCibqeqg69RwYescJcXBREIWYahKWv0Q2R1/xNjblWpjR/pMnUdsVD6tAE0p4
         oUkB4VBsDPmygrpwC5S619NYPZJaI5NpHlfY76yvdPe1Wqb4tEZ3GGaOZR0dt+x5ZTaj
         QszdCYQkbPsdtaHImYUWKIBdZGuJODW7qyRZNlqm3WUnKoHjN/UWEGrgmoMeiUvPaZMK
         FmRTGDXJ5xcbS3BwF/ovfgVGf6ewRaD1vmoLQw4V6mHx+599y0J1rmw6Nc25WDNcLzex
         0vmA==
X-Gm-Message-State: AOAM532Ka7YUK8tuRBoM8oV+yhV9pr3OlCMniHxoeDKbbRWsK/qltTCb
        a8Gx5caCxfuR3D9jhnw0Q2QOMQ==
X-Google-Smtp-Source: ABdhPJxjZzopWWGCvCIFeBejgXYqA5vngsb3D5YCPozsZs+/7/AGqcMT6p2CiHWlc5BZ8MP4jg8kVw==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr11523289wrr.296.1626430959130;
        Fri, 16 Jul 2021 03:22:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g15sm7421796wmh.44.2021.07.16.03.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 03:22:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] slimbus: ngd: reset dma setup during runtime pm
Date:   Fri, 16 Jul 2021 11:21:23 +0100
Message-Id: <20210716102123.26861-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
References: <20210716102123.26861-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend/resume NGD remote instance is power cycled along
with remotely controlled bam dma engine.
So Reset the dma configuration during this suspend resume path
so that we are not dealing with any stale dma setup.

Without this transactions timeout after first suspend resume path.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f3ee8e036372..7040293c2ee8 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1080,7 +1080,8 @@ static void qcom_slim_ngd_setup(struct qcom_slim_ngd_ctrl *ctrl)
 {
 	u32 cfg = readl_relaxed(ctrl->ngd->base);
 
-	if (ctrl->state == QCOM_SLIM_NGD_CTRL_DOWN)
+	if (ctrl->state == QCOM_SLIM_NGD_CTRL_DOWN ||
+		ctrl->state == QCOM_SLIM_NGD_CTRL_ASLEEP)
 		qcom_slim_ngd_init_dma(ctrl);
 
 	/* By default enable message queues */
@@ -1131,6 +1132,7 @@ static int qcom_slim_ngd_power_up(struct qcom_slim_ngd_ctrl *ctrl)
 			dev_info(ctrl->dev, "Subsys restart: ADSP active framer\n");
 			return 0;
 		}
+		qcom_slim_ngd_setup(ctrl);
 		return 0;
 	}
 
@@ -1618,6 +1620,7 @@ static int __maybe_unused qcom_slim_ngd_runtime_suspend(struct device *dev)
 	struct qcom_slim_ngd_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret = 0;
 
+	qcom_slim_ngd_exit_dma(ctrl);
 	if (!ctrl->qmi.handle)
 		return 0;
 
-- 
2.21.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6563E2712
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbhHFJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244406AbhHFJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:17:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F800C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 02:16:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p5so10201161wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P17OeSiwNU27tPgzIXbVaCeJQjA2Rn8XgRVpE6+nR8Q=;
        b=hwATRVzGY1MjEK9PKMjeKcQc8kTgnMbjTwOt54o80ZKcWiuvv7ji8lT4fr1+5FCbLB
         LALOGZyytElaOH589hrZKAf3ty5yd4TzFn+FiMrtk81opkB1GU5Z4YqHOZmMcMOsMRqL
         2O0B7sq6Wc+bLmhtBExf/XhSdwd4xEZvSMEriiiXTheeomulez9olz/O8F6pjR3JxnuB
         W2LsyDk2rPIm57peb9aELWMawJCKxQbLcRXmpCw11SAddMmgP13mKv/5O6b7o81elxRa
         j8TmEAyOoNIPnVnDSnQbSCHaYrVgtX7MDpwMn01ifOaG7tpJAsO+HYqH+G4fV6my987Z
         uG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P17OeSiwNU27tPgzIXbVaCeJQjA2Rn8XgRVpE6+nR8Q=;
        b=lFqIF8ZXcsbVMqDN+MCtkcWvYSQEx5gpO+SbJYkjlV20B1uWDvjqX1KnlJS/AC3wEA
         gpDDkffrJcioz2ASwtWL32p8z/8aPbPFo2X4IvKTlotK4wpp7+GS+kZTSt5BEQWbXltB
         BLYJ56/fAGj70LagDId+XJXeR/+bNAHtAQrc+K32ZB8ouha7PCxQSN0uPAPWXrNmBRjn
         BEPSdl5ybXT5/vENCONwZYx3RJwQR1FP9gWQaFpyxY40+bKDbwMY46dFXaOYUEiD2hxj
         +uLmhayaBbYfYruQ2dX80evU7SoGLaOgxsKVMLWXsZ+Gs4zZZ0wtyoNVO9J2jCNO9V0a
         OMQQ==
X-Gm-Message-State: AOAM5328aCkX2fHhj5zOK2uhtvNAm0GT5O7E0luxvv9/4uOrjDzs5GAC
        /6MdmK64jLIa7INixHU16OR1Eg==
X-Google-Smtp-Source: ABdhPJzcm2YoYm6lErUH3LSK5+EUjRTOeqF2oyhvnHcIIWLlNSsmUIpVgoUpGRiNv0DQpkU/Y3En9A==
X-Received: by 2002:a5d:6891:: with SMTP id h17mr9284173wru.324.1628241409049;
        Fri, 06 Aug 2021 02:16:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id w3sm7811760wmi.44.2021.08.06.02.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:16:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 4/4] slimbus: ngd: reset dma setup during runtime pm
Date:   Fri,  6 Aug 2021 10:16:39 +0100
Message-Id: <20210806091639.532-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
References: <20210806091639.532-1-srinivas.kandagatla@linaro.org>
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
Cc: <stable@vger.kernel.org>
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


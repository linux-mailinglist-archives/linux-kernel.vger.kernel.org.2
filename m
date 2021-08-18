Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA23F0BFB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHRTmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbhHRTlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:18 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E7C061796
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:43 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 18so3237798pfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cmK65pjDZ5qVva3XgHDw9o42yw29z316T7tmW/1Nv3w=;
        b=CBQFS/CzM+VLJ7KH3den7IQN+mjUpqRxz1yp5Z0iSkaB7Z2oiisIToaj+Ceb88d0qD
         pJQvEHjY/laBj7w96Z9tKCmmPS+ymHrQQN+rLzZcqm9McHz4HLHFC8qOEkpr2ZKuRYF7
         6fFe5kIMAG46U/prB5iMwp7JyRBOHlH63GmEUDS+jFQNNkQQ9/dfGbYf44RDfZUNVvPU
         aoBHzNo+KdxtrYgBdEeqG2sXp8R86zmH0MXA82oL9c4B6x7lSdL7s+nMtXR3yqtA5Lcz
         NsQpn7OeUruJa/qTk2LR0IPWcSJQSedGLvsRSG7R1Hwkoj3FV4ZIzPun+9pdvCK6AfKs
         tyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cmK65pjDZ5qVva3XgHDw9o42yw29z316T7tmW/1Nv3w=;
        b=fCxSOHTE9YPxakupVf1K/hWwiUFWXijzGezjqVSPGLcuH6BJSrWSgBkkPyL4IqpWjI
         Zd7pIBP60hKG2GyljT+cJOk6wQDiBAlYh+uFNmNOYaiz28nxApa9if4l1qvjvEmfJgbi
         2lngeRtF/d0h1Ckm8OK9i4p1lHtcGrx/Rkd3aUTIIhthph6hP/M3TTVzjjoRIPYyqno2
         XHKgVBbrrEEEpnN/d5YCHZ6Yr9Okip4TplR4HowT0wXZ7uvwh5EC6/zxkf+i1ep55+H+
         R/LZwM3vkS0kkvqpd4Iph5+QyrUawzs9h/sLeFYW3+wqyfSH3sumt0nhsTN+DKgAfhiJ
         47gw==
X-Gm-Message-State: AOAM532mvdaNBrVzIqnGkfodoocBnBZlohmC8Cx38AoR34W8T3bYLiDs
        Wq3/gWTNjEtVt23TW/jNXCv9Bw==
X-Google-Smtp-Source: ABdhPJyuphotIJTx3zPxZtcqORfr/6ytao/jspVrVoIuvWpMuoTn/WCdN7FYtCks3g2Bf1T0NqOnHQ==
X-Received: by 2002:a65:641a:: with SMTP id a26mr10470079pgv.340.1629315642726;
        Wed, 18 Aug 2021 12:40:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] coresight: Replace deprecated CPU-hotplug functions.
Date:   Wed, 18 Aug 2021 13:40:22 -0600
Message-Id: <20210818194022.379573-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818194022.379573-1-mathieu.poirier@linaro.org>
References: <20210818194022.379573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-15-bigeasy@linutronix.de
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 9731d3a96073..00de46565bc4 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -588,11 +588,11 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->base = base;
 
-	get_online_cpus();
+	cpus_read_lock();
 	per_cpu(debug_drvdata, drvdata->cpu) = drvdata;
 	ret = smp_call_function_single(drvdata->cpu, debug_init_arch_data,
 				       drvdata, 1);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	if (ret) {
 		dev_err(dev, "CPU%d debug arch init failed\n", drvdata->cpu);
-- 
2.25.1


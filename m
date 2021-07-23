Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6653D3DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGWQOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhGWQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:14:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42BC0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 9-20020a05600c26c9b02901e44e9caa2aso2003270wmv.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ABwZIw+GuHuxpYSzBenQkHeYDXmCXaPxspUFiSW1wck=;
        b=pw2y8LlVvafgqp8yk4yW9Qv9oeKP51Ef8Vn63xUM2CjX6emH9TU0tPDxmLvEyr2Qdb
         1tSMUbNeLfMNfdxTlwl3O0DjOWN9O8CZO23WlwyBjSJ4OwNBs2fhrV4SD7YBN5xBbDLI
         0H36RkQmnKQb6Jb5pgrwxD54NQ+YcUHQQXVlKYlHt7DZ+cnC3lcdw6mATvjeArGlZgks
         uFNBSnHpIjGTDvOjhNa+Sxj/X6zKRwiTNeNFhRVhTeqmdFqPVYZeWr8S718OiQZ6lrlP
         bYZxbavryyjRsZbbcsw5FIQiMajT4u1QIDIdBhcj+THiAIKTHr9sfxgwoPoU+zX1l55Y
         Kq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ABwZIw+GuHuxpYSzBenQkHeYDXmCXaPxspUFiSW1wck=;
        b=RwPBL8aAwbL1wB96E5GL6WPFkyCSEu3tAg+XAUedzi30t3Pk1SeQlrnBjX5GeD1mSo
         pEMhHB+9Yfz99ncor2v/Q2j82pA1JCW5GvZFkdW5lLSuqX2f2ce3CWv3vrZ4zigwVMJ9
         SbBwvxWVMrMFoM1BvLIM2AOv7E6TyWgS/SzwASa5x6+BRNnIB6S0B6zX1VowIqU9imnO
         lmwPSl/5lX5mpbrXTfSNrvrXDK73bxtV7ZIT8paKqWGTG4h3jyMu8vpEZPyy1YiMdwY+
         9/nd4I0d3elpn3Q/nlmguKHknQEo8m6UQHj6mPWY/woZibaLm15ZThKMgEZywSfjKgWP
         WtQg==
X-Gm-Message-State: AOAM530G3ZXOOm3wM1TRJTSFhFl9V4Zh12C/Kcx2bYSr4uAo7p73m2O2
        Pay9bEnDdxtpa6upPBPX374l8g==
X-Google-Smtp-Source: ABdhPJw3zayoDJdZLmgCzJQSMtm4EIMSBkw8dYeqlowjoDLt6ghMV+fSGyqbWNtMWgETJIo25l879w==
X-Received: by 2002:a7b:ca59:: with SMTP id m25mr14941497wml.74.1627059291665;
        Fri, 23 Jul 2021 09:54:51 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:fdab:eb9d:1515:bff3])
        by smtp.gmail.com with ESMTPSA id z11sm33193225wru.65.2021.07.23.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:54:51 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v9 06/10] coresight: etm-perf: Update to activate selected configuration
Date:   Fri, 23 Jul 2021 17:54:40 +0100
Message-Id: <20210723165444.1048-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723165444.1048-1-mike.leach@linaro.org>
References: <20210723165444.1048-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add calls to activate the selected configuration as perf starts
and stops the tracing session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 +++++++++++++-
 drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index e42ab919ddc3..8ebd728d3a80 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -215,6 +215,10 @@ static void free_event_data(struct work_struct *work)
 	/* Free the sink buffers, if there are any */
 	free_sink_buffer(event_data);
 
+	/* clear any configuration we were using */
+	if (event_data->cfg_hash)
+		cscfg_deactivate_config(event_data->cfg_hash);
+
 	for_each_cpu(cpu, mask) {
 		struct list_head **ppath;
 
@@ -292,7 +296,7 @@ static bool sinks_compatible(struct coresight_device *a,
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	u32 id;
+	u32 id, cfg_hash;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
@@ -310,6 +314,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
+	/* check if user wants a coresight configuration selected */
+	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
+	if (cfg_hash) {
+		if (cscfg_activate_config(cfg_hash))
+			goto err;
+		event_data->cfg_hash = cfg_hash;
+	}
+
 	mask = &event_data->mask;
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index ba617fe2217e..468f7799ab4f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -49,12 +49,14 @@ struct etm_filters {
  * @work:		Handle to free allocated memory outside IRQ context.
  * @mask:		Hold the CPU(s) this event was set for.
  * @snk_config:		The sink configuration.
+ * @cfg_hash:		The hash id of any coresight config selected.
  * @path:		An array of path, each slot for one CPU.
  */
 struct etm_event_data {
 	struct work_struct work;
 	cpumask_t mask;
 	void *snk_config;
+	u32 cfg_hash;
 	struct list_head * __percpu *path;
 };
 
-- 
2.17.1


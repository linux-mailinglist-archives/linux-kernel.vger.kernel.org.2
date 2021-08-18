Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2668A3F0BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhHRTlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhHRTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:41:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31134C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j12-20020a17090aeb0c00b00179530520b3so9715442pjz.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+QlnDDrnRdRrKZAGMdLO6WKB+rMMxSNRXmdszPCoIE=;
        b=dU4GAPUJOpLXrKMiaNhn9vplv92ORlF/7RIrHvm2DNUjSKWp+FxhQM8sVz9IZXfCxt
         QIBR9+wd1UhVIX32Plbi5rWZJKTPgJq3jmJWtJpnlVvEk3GRyYOpTjCwT8efcn3/Vlx0
         deHL9wbqlxiAOuFzwuQvnGOYHiQPEfNPGHLRo9qG6d2H6DCx/mi2tvnW8thXPlgNtwz1
         dp9KrvYjTHDG1fVZDhzKGP4ZBwHqbb60hL3nGWpvNZiq28UDSWSz0l+d6K7vQ61nrSKf
         HJkj23af/UA/Uc8MeEQ/j3xekmROQWJ7kvXrA6KDuEAil1h5oLMpna271QLCiE2JO0jb
         irqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+QlnDDrnRdRrKZAGMdLO6WKB+rMMxSNRXmdszPCoIE=;
        b=TBRVn8q2tEoPT8Z7wseFgPAjn+kuw8EQxQlo1bpoJHYy2q5nv5Z45Pw2tTr/Ydt/Xw
         ZRBFwfV+WOOfrstXemkcjZqSzb6p/D1MGMC7rfNFoLDWz4rpZgYh/9V/WNNHZ6hgtGle
         jlQg29jc4kjJIoyoCYXuST3ZpZu1UxHK9ix9A/61ZtIwQz5avjxOi8rb81AGYlJZZAVA
         aNz/MS2KiD3bFU8iN8HXqKvWuDOiK+2//O3zKnxGmRHppnYehm433Iwgov+ZhyF9m3vf
         QttnfpHs1NVD9u5ke8szw1gmawcNuLWat4LUrwFPiHIJl+fCiHvfkVuYwM/1xrq8vf9G
         0CiA==
X-Gm-Message-State: AOAM533y0ekFkRuL2T7+TWBhKG5mVd4g8Y5CcQDW57apusv2lqjOiZTj
        EeNCjmQ8N7uV/5zPO0OOBXgnLg==
X-Google-Smtp-Source: ABdhPJzSSWvJ/RzvV/sO08EXugFwMlNtHmSTPShBKCAqiafr17w1iRzvCZ/DiLRnY5OlDHOVV8JxCQ==
X-Received: by 2002:a17:90a:4a88:: with SMTP id f8mr11118902pjh.226.1629315633797;
        Wed, 18 Aug 2021 12:40:33 -0700 (PDT)
Received: from p14s.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id k12sm2960137pjg.6.2021.08.18.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 12:40:33 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] coresight: etm-perf: Update to activate selected configuration
Date:   Wed, 18 Aug 2021 13:40:17 -0600
Message-Id: <20210818194022.379573-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818194022.379573-1-mathieu.poirier@linaro.org>
References: <20210818194022.379573-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Leach <mike.leach@linaro.org>

Add calls to activate the selected configuration as perf starts
and stops the tracing session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210723165444.1048-7-mike.leach@linaro.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.25.1


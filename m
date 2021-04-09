Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA08F359C42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhDIKiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhDIKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:37:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED06C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:37:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x7so5127814wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qp1rtf5vTNCYxLgq97ox1ro8HilwNvlQ34tjmWDteno=;
        b=DK8bsDntN96oRvUkF9iEDcAceSeWoIcgxD+QOlopBiQ/wuGreTAxX14IbOQZ8a5i40
         tNL9N8hEJRyjMCzVxdPZhUhM9bcGMb26Sl1R6Ib9ngMxhOGDxl7o6WSKYp31JPYH0b89
         16XwlA9oZ7HdIDqVXI7vjJTvk5qdcQ4rNXXxGy+X637XrUYtMNVjhjZFXkRsTPOVrdgr
         hoC7A/Vn00+SP79Cbc/hsmVThCHTzC8Bwv3fcXaZhGLDZXDaTySxM64vs3zoPrNkvh+T
         +tQUC36+cPI1376sxz9/Tbly1f8k047MPHxfb0XjZ3+qceJmLcfKjPFnlyGCbGvUPPC5
         0waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qp1rtf5vTNCYxLgq97ox1ro8HilwNvlQ34tjmWDteno=;
        b=hj907r07tePRfTTbm5hWIuK1m9qulcx+uYEc76vLcpp3Q08MJhxfE617waKEZsFxxj
         Aa9lWDhZhvftpLjMc74RHKnOrnzjxzTBqNvfWOdul9CmHLuWiJly0m7o8s4D5hVEgoWQ
         DfjAbpGXzY4Qb90ktRjSfeHb6gy5BrRcWnYD0yZ3HT85ZSoTih7EqnwYfH1KDo2v8OPS
         ZRtYbaWkdQIO2HcPDn00jo2l+yyijYmXtaQqOl/uS0E98U8W3K1Si3HAbw3Do0paINcC
         ZmOdAtGmT9sfqvt+oU+KcsOwF4fTHK4bbFOckPTaXDmnYjLugVQCbk+wtLuoGm+IBUw+
         mKYg==
X-Gm-Message-State: AOAM533zqY9sNM4GiWef21b4i8ZyR2z3Z63Dw8SKxGmxf3WE6Kbhoj3C
        YRdsbcZK7NMswFM2B2T5NKvU5w==
X-Google-Smtp-Source: ABdhPJz7V8dFxlm9+ChNTIOoyYI7hSdLsVhYqkUY4KZxO3f4cGVfSTY65g1HbYj0aarYOuOnivVE/w==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr16284801wrq.324.1617964656304;
        Fri, 09 Apr 2021 03:37:36 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:20a6:106c:24d6:628])
        by smtp.gmail.com with ESMTPSA id w7sm4087650wro.43.2021.04.09.03.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:37:35 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v6 06/10] coresight: etm-perf: Update to activate selected configuration
Date:   Fri,  9 Apr 2021 11:37:18 +0100
Message-Id: <20210409103722.26290-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210409103722.26290-1-mike.leach@linaro.org>
References: <20210409103722.26290-1-mike.leach@linaro.org>
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
index 26b4bca156aa..560baefdfed8 100644
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


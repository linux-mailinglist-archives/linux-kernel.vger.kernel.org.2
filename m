Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679EE3BE8D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhGGNdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhGGNcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:32:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC17C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 06:30:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u8so3054098wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ABwZIw+GuHuxpYSzBenQkHeYDXmCXaPxspUFiSW1wck=;
        b=baO9xBkf/3/zuaZch/wmriHOBT+x6aCt380iKirtgC0QxJk7tlBLFND/6+xC/fIPxl
         Q0K5S9Xua9ReDU8UUoXnUrxbjCrwGwVkBA0ZM3GFGxSPW36tdaqPZsTA/6czWTkaNAKH
         hbOV0XFTHNAviGtMTMD2BlPW09z5K+wLpsIeaXXSzKOb15tWqeLGG5Fk96Iaeax9WrNo
         HR7nqb7jxmHGbnSR6WPg8NKiPQRyz9RBF4NNW8dxopok3VSnlbi8LDZUxK/cjdDfHOhu
         Np1rbk7DaeQiLXIwd9Ub9NwOmVzKoM6SVYpP9yDpJ5oF9/zcVs2svwpMc2Ks+VwNc4+6
         TbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ABwZIw+GuHuxpYSzBenQkHeYDXmCXaPxspUFiSW1wck=;
        b=ZpO5JB3s0fvawoAPsa75Gfh9ktpBf98NW0QTL0fnx+BL+xp/JzcDFavMQqg1nOMcWR
         MouWBpa0CQvD50muldw/r4VYZsm1Kr17T/kgYmCiCNWKHF84G5UdhVmtvRiuWakfWsqb
         bqNIptQE/4L/CdCbbHadt9VNoTMIb/FXuRpTn06rfGEgitG0T9CmdvCNUUx5XGoY1ixC
         M1vn9jvi/pTKeAJid17ur9dNTWiHTRthdKtPSqfwnEZUiNe6VMusONeQ/ljQeche5BGR
         Hvl1v10D46GiNk+wPNKRla0X4qEAEPqwdE8TYpj5gx4n5oI9GDWi1umdqRAKPsa56/BT
         DSZw==
X-Gm-Message-State: AOAM530Amoo0e6R8H+8+vvrFWd8H9FeWWkHjHrz241bVHwF5Hl5o5JX0
        jtrqSbLYquo93V8Ti72qqiUaeA==
X-Google-Smtp-Source: ABdhPJxLjxjycRqSHqFy45TDhxhHGbiXtzuCE92KCHdesAYiHTt4YPM15c6EbuIsisD8dzXRGYQkuA==
X-Received: by 2002:adf:d212:: with SMTP id j18mr28219934wrh.150.1625664609349;
        Wed, 07 Jul 2021 06:30:09 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id l16sm6632403wmj.47.2021.07.07.06.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:30:09 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Cc:     leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v8 06/10] coresight: etm-perf: Update to activate selected configuration
Date:   Wed,  7 Jul 2021 14:29:59 +0100
Message-Id: <20210707133003.5414-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707133003.5414-1-mike.leach@linaro.org>
References: <20210707133003.5414-1-mike.leach@linaro.org>
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


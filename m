Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4035FB88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353251AbhDNTUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353231AbhDNTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:19:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B60C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:12 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so17186811wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qp1rtf5vTNCYxLgq97ox1ro8HilwNvlQ34tjmWDteno=;
        b=yz3jNvqKpyMyEfgR81XsaWyGFfxC77h2/q4tnUpvVy1V80bTfLwd6chrspXEkrxvFU
         VAOBD+Tb27lAvw3ipOMRkbVzSn89z477PTtJhgVFxHDiL3euYLTqOxtXfnn99Fc/NJYT
         T3RbZHtofcibb2rM3XUqclT5y/yy9LilKmV4ivIx1MvfhYi7NKdMpIE+gOdu1pbDFPAl
         EfUEMk4tzY7ASCae5ciJAxHNqsMLkDnq9ljXczMr+DH3f7b8ZCstWoDXAzfKTROkMIzH
         WQLJTGh+GLCiWeH6vngUkiNkB4GpTkStXDJd2eYhlClI5RhFEnwOVdFm8iBEmYHa/4LF
         KM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qp1rtf5vTNCYxLgq97ox1ro8HilwNvlQ34tjmWDteno=;
        b=svHVBZBGgLnkh5cKTKePDRE3rEyPblo2NZbME2/ku5cRZ+G0EwtbP8m8lWw7GfuDaz
         KqnePRR3HKp99pJ6+MdZRmcHCmnwjCxiREkBGKj68PmZCuyAO0jUkTIvCyyu+BdE2nsz
         s6EWi7qKGCB96twjzh7bGB1CsqENe/MHlYCnqPnnPaSg5eVmMvpbzssG8Wd0HRPP3DEn
         WkE2PeH4zfGnT/mubFoNPxEaulSwZPRWx9Gt/Wclo/LC2+ohDHiNJo/SMLzwaz5m/Klp
         k420q7vwX8p8dJbACvgAZsASZccjy0/lzF97h2TTAObDDlSb3d1Uv8RTpo3TyY+fv/7n
         nHMQ==
X-Gm-Message-State: AOAM532X+JuOWTBsHbYOs574u9Uucq7X2YUgQ2T2FrPV0qBmHXxzNrb0
        t0S7rrnhxbRLYWI5iawD9tcSgQ==
X-Google-Smtp-Source: ABdhPJwq1IQoqE7/mmybFnQ9IpYRleea4gq55kbZKh4LVZhLh5cQ9efS2H/C4DTU95M15AYAxU+IMA==
X-Received: by 2002:adf:fdca:: with SMTP id i10mr23520500wrs.55.1618427951061;
        Wed, 14 Apr 2021 12:19:11 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id a3sm327073wru.40.2021.04.14.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:19:10 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 06/10] coresight: etm-perf: Update to activate selected configuration
Date:   Wed, 14 Apr 2021 20:18:59 +0100
Message-Id: <20210414191903.18349-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210414191903.18349-1-mike.leach@linaro.org>
References: <20210414191903.18349-1-mike.leach@linaro.org>
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


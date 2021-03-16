Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1350433DC32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhCPSIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbhCPSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:06:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0038C0613E0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e10so10948569wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p7Tdc5TFfUaWBO+WOQMArho6SVfz49w0iPPF+CGCt68=;
        b=LbSB0k4BPxDrtm7z61uvfrT8hqKUJ2vlBupky7lx/hOVIWEomY9AL9CKEdNxyFloqD
         npahqll8zvyRpGks8ygToy7yPSkFkofuwULOCCR0fsDP74hl/Tj5JG6F/BKpTwS2cCpK
         U7t1XisOtFYZBQoLfawkCAWKzUBQ/pNFd8rAjdhcDErsPwdrfSbCv7WK9fQqcQ/tKPcB
         rZB47M0kbXGbMmMKYjOLCqsLWgEP1bggXeAw750Uldsqz9CdYRc62EgGlaRg5+5Q6uKE
         O4ryqe8kCUb8exOFMMBI4l6giCbgJzmESgO7xKddG0P1PcqVHaJH8KD5sb8sEBGwyKJS
         9Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p7Tdc5TFfUaWBO+WOQMArho6SVfz49w0iPPF+CGCt68=;
        b=odQuhYjbobTbO1uXk6QRcA+o3djwck56REZ4uaM+ttgKwdzG+C3AR1NzP7KUz/57oQ
         8TNy8ks4Hb/iVwYShv0MUS2Vce+jPQXrAjDDcE4NpcYZyTGmzjQIQ82tOHg4s1cFv+WO
         ZzVGIKYF6B3x4ynkRGBMZVudmk69H07VZWEkQgSm1o4gBpSXDCj3SRjn3zaga/ZuWhAO
         pCO4kTIpmdB7XSyx3vVfP6s5DDMNmInH3uk5/A04moaPU808su//7wyWE2T9wweRP45Q
         shx/9sUulovYwcABW1l/C6PEIL9YOv9HmJexIkxrchBQXUtIruL5KZHm0a2bTJb5pfxh
         zvaA==
X-Gm-Message-State: AOAM532JSh/vzAX6/fvwQvy7HIbKIrY5BXrM56zuXySB2IOs2MVIV/ia
        rUj354tv6n1ybUAkuU93Ll+K8g==
X-Google-Smtp-Source: ABdhPJwMwie0bKXU7zrbfSHtNY1rBP8NFRNmAb2kjq0nsUzm74MGuXfv31TZpWVYSxZhlsYUjaX39A==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr286521wrn.338.1615917847473;
        Tue, 16 Mar 2021 11:04:07 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6801:1801:84a6:25fa:dde:ecca])
        by smtp.gmail.com with ESMTPSA id d13sm23927858wro.23.2021.03.16.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:04:07 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v5 06/10] coresight: etm-perf: Update to activate selected configuration
Date:   Tue, 16 Mar 2021 18:03:56 +0000
Message-Id: <20210316180400.7184-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316180400.7184-1-mike.leach@linaro.org>
References: <20210316180400.7184-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add calls to activate the selected configuration as perf starts
and stops the tracing session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 +++++++++++++-
 drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 66bda452a2f4..9128f59864a8 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -196,6 +196,10 @@ static void free_event_data(struct work_struct *work)
 	/* Free the sink buffers, if there are any */
 	free_sink_buffer(event_data);
 
+	/* clear any configuration we were using */
+	if (event_data->cfg_hash)
+		cscfg_deactivate_config(event_data->cfg_hash);
+
 	for_each_cpu(cpu, mask) {
 		struct list_head **ppath;
 
@@ -254,7 +258,7 @@ static void etm_free_aux(void *data)
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	u32 id;
+	u32 id, cfg_hash;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
@@ -271,6 +275,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = coresight_get_sink_by_id(id);
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


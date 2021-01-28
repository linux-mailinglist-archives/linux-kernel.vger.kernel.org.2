Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02F7307CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhA1Rq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhA1RMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:12:37 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE29C061354
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:51 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q7so6129149wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 09:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+TM9hQ1DCJj1Sx/zagtZCNZZA06suw1HBUOznUqWnA=;
        b=xeH6+PqnSwdFzNGKTcQbFpzFKsvKrtJYhBbpBUoGwEoVk9Nu187EGduv0Val+EEydR
         FTbhLt+r55QSSFP3sBPaEooIRS66ZFU3ZCSi+KaKx3xQwNmZCAf/xOr9QPisBl+t7o51
         ajxUggYGA/m+CcHHYfkbp8lljAGJXjNLOinVWRb5Lz5rQNxIYO/hrSIF9Y+X/AUQJoa5
         sFVADuSotuGNMT3AAogpXpHEzT6Hi7kKIuymUyoYFUVWAZDmWIGvm8PXzyngPvw9+CbK
         JoshzZyyQjDgT83RoUhiFCEK0Jn0Cwoio2nRKezetqEaFBKDAC0ToGSZkdT7viGMeou7
         WICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+TM9hQ1DCJj1Sx/zagtZCNZZA06suw1HBUOznUqWnA=;
        b=UEicmyMZ6kxGeNL9WbkFW1NmXIy/lhOls8lArTSBC3LEisUWv2ZmFxo5x4UuH+6yI1
         RB+7uPL2hwMW4E2vZ0NOMNWbHZyh2ZE8o200T+99Uzaoabjy/uhMKZX7r0DBn5t9JWHe
         Q3Mr/NTU4uk+SgSHM4rVOw1RLXbZ7ikHPNdTEaaK4+jwEkrPk0hFRuOHqoZqYPvB7Q1j
         o+vCVCADjzrqagewYez1NO83PTBf+nucm6G7p81T2Xgo+4xq73g3jmONn7XVVfL73aPA
         FgaxrDLkyOp43ik0B8XHL59MPuCGjqtY6XGa1wkF6Jk134+B9rCYXJnlBBG39m96eohJ
         qFoQ==
X-Gm-Message-State: AOAM532hARoMbqDZcvob9tP14hdxFq8qgz0okv7OGiLYYqqeK+ma2ox4
        oYm992Dsu+7/Um1BfEIAlwhPvA==
X-Google-Smtp-Source: ABdhPJx+v2AUO/iuiXfbbphnaUYMs9oQHxAlDN6mlYMQjMSSZnB+sJvQovAD9V+CE3S69fwEl2l9IQ==
X-Received: by 2002:adf:e48b:: with SMTP id i11mr32322wrm.406.1611853790592;
        Thu, 28 Jan 2021 09:09:50 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6801:1801:40:2fca:953a:e6ba])
        by smtp.gmail.com with ESMTPSA id p15sm7622355wrt.15.2021.01.28.09.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 09:09:50 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-doc@vger.kernel.org,
        suzuki.poulose@arm.com
Cc:     yabinc@google.com, corbet@lwn.net, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, tingwei@codeaurora.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v4 06/10] coresight: etm-perf: Update to activate selected configuration
Date:   Thu, 28 Jan 2021 17:09:32 +0000
Message-Id: <20210128170936.9222-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210128170936.9222-1-mike.leach@linaro.org>
References: <20210128170936.9222-1-mike.leach@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add calls to activate the selected configuration as perf starts
and stops the tracing session.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 14 +++++++++++++-
 drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index e270bb1e0f7d..5c1aeddabc59 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -178,6 +178,10 @@ static void free_event_data(struct work_struct *work)
 	/* Free the sink buffers, if there are any */
 	free_sink_buffer(event_data);
 
+	/* clear any configuration we were using */
+	if (event_data->config_id_hash)
+		cscfg_deactivate_config(event_data->config_id_hash);
+
 	for_each_cpu(cpu, mask) {
 		struct list_head **ppath;
 
@@ -236,7 +240,7 @@ static void etm_free_aux(void *data)
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
-	u32 id;
+	u32 id, config_id;
 	int cpu = event->cpu;
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
@@ -253,6 +257,14 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = coresight_get_sink_by_id(id);
 	}
 
+	/* check if user wants a coresight configuration selected */
+	config_id = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
+	if (config_id) {
+		if (cscfg_activate_config(config_id))
+			goto err;
+		event_data->config_id_hash = config_id;
+	}
+
 	mask = &event_data->mask;
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3646a3837a0b..751d768939d8 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -49,12 +49,14 @@ struct etm_filters {
  * @work:		Handle to free allocated memory outside IRQ context.
  * @mask:		Hold the CPU(s) this event was set for.
  * @snk_config:		The sink configuration.
+ * @config_id_hash:	The id of any coresight config selected.
  * @path:		An array of path, each slot for one CPU.
  */
 struct etm_event_data {
 	struct work_struct work;
 	cpumask_t mask;
 	void *snk_config;
+	u32 config_id_hash;
 	struct list_head * __percpu *path;
 };
 
-- 
2.17.1


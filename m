Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26D13945B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbhE1QRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbhE1QRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:17:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DABC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:16:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id s4so1835590plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+tAACSiahm/3bs5QyHkgVkOiDzxcYl6AR00a4SXPyA=;
        b=DMBbK/3FdRkBNsXYjrHYxhpz+cpO4xoNu51B9B+KILxtBH7zeHAiPXTs8bgG2shCmY
         huJxTQsT3I4OOJ1KiNLd7FrCH1u++zokheKEvPOkj1TnzD9nqznY03CuJIMhyolVb5UW
         QUAT+x1A4CwJT6pxPGYVHLvXaAtx4VH0ZIppJwSUaW6GL/qaku99A1SezAk2Wv0hfRmE
         eOb/ZrT44TUTWf0MOJVq5dfSJciA0MrIFrzTVH5v/pc1ZsU8UvZ7kMrjP2nxhpxI3S3L
         slLg4ifDakQBJMPBFr4H2Jwtp5eiSua0s6dX/k5ZSXxPqLJWotLktncPg+4n3yXjXffx
         plow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+tAACSiahm/3bs5QyHkgVkOiDzxcYl6AR00a4SXPyA=;
        b=WYt2U7VAWyFpq+1wVWI5uKDRUQMcxF/8xq1taoXAEprLpV9/CW39sUc+4iLm5xPnX+
         8HZg8Pewd0Tt20BjQXz0Pzx2QN4i8eXwBWJUMkZJxJjgwKGFwxe8yTjt6pjnnwOj0VaS
         U/4cwK9aXWx9Gfdo70A+LaKaULVZIxWK8tCaVoqV0MnEKK9fM+Mx/gb+29byu1rcrMk1
         ujuzo0wt6aRR2RCWfLY1QVxzqQkhrxr9UCkQxBX/IIkX1VkPqzKnjBV85yZmE4zDTU6g
         NbKYUfE0BpKriLhvMda+cw1uR/1HdHSbSbryUWBZIk/LZdGVt4i7i24NdyfklC/bQSC2
         kbBA==
X-Gm-Message-State: AOAM531lmU71swhhco3aLrDQq3Kd51QHUtovaiN9WhgNf3aB+gSwPVNL
        XgEXjPdsDtKSb++DYhzOgvtZyg==
X-Google-Smtp-Source: ABdhPJxp/UoP5wXTVBLkZnpvdt5dCtJPyVsBdueMl6crk5z5hQy/GERw2/4jzCQ29gVMQVESpwxMjg==
X-Received: by 2002:a17:90b:1003:: with SMTP id gm3mr5256275pjb.126.1622218568621;
        Fri, 28 May 2021 09:16:08 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id d15sm1132273pgu.84.2021.05.28.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:16:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
Date:   Sat, 29 May 2021 00:15:51 +0800
Message-Id: <20210528161552.654907-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528161552.654907-1-leo.yan@linaro.org>
References: <20210528161552.654907-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable the Arm CoreSight PMU event, the context for AUX ring buffer
is prepared in the structure perf_output_handle, and its field "head"
points the head of the AUX ring buffer and it is updated after filling
AUX trace data into buffer.

Current code uses an extra field etr_perf_buffer::head to maintain the
header for the AUX ring buffer, thus it's not necessary and it's better
to directly perf_output_handle::head.

This patch removes the header etr_perf_buffer::head and directly used
perf_output_handle::head as the header for AUX ring buffer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..b22823d67680 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -32,7 +32,6 @@ struct etr_flat_buf {
  * @etr_buf		- Actual buffer used by the ETR
  * @pid			- The PID this etr_perf_buffer belongs to.
  * @snaphost		- Perf session mode
- * @head		- handle->head at the beginning of the session.
  * @nr_pages		- Number of pages in the ring buffer.
  * @pages		- Array of Pages in the ring buffer.
  */
@@ -41,7 +40,6 @@ struct etr_perf_buffer {
 	struct etr_buf		*etr_buf;
 	pid_t			pid;
 	bool			snapshot;
-	unsigned long		head;
 	int			nr_pages;
 	void			**pages;
 };
@@ -1437,16 +1435,16 @@ static void tmc_free_etr_buffer(void *config)
  * buffer to the perf ring buffer.
  */
 static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
+				     unsigned long head,
 				     unsigned long src_offset,
 				     unsigned long to_copy)
 {
 	long bytes;
 	long pg_idx, pg_offset;
-	unsigned long head = etr_perf->head;
 	char **dst_pages, *src_buf;
 	struct etr_buf *etr_buf = etr_perf->etr_buf;
 
-	head = etr_perf->head;
+	head = PERF_IDX2OFF(head, etr_perf);
 	pg_idx = head >> PAGE_SHIFT;
 	pg_offset = head & (PAGE_SIZE - 1);
 	dst_pages = (char **)etr_perf->pages;
@@ -1553,7 +1551,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	/* Insert barrier packets at the beginning, if there was an overflow */
 	if (lost)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, offset);
-	tmc_etr_sync_perf_buffer(etr_perf, offset, size);
+	tmc_etr_sync_perf_buffer(etr_perf, handle->head, offset, size);
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
@@ -1605,8 +1603,6 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		goto unlock_out;
 	}
 
-	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
-
 	/*
 	 * No HW configuration is needed if the sink is already in
 	 * use for this session.
-- 
2.25.1


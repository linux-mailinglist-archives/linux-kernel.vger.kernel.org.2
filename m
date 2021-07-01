Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814333B8FD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbhGAJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhGAJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:38:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58746C0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 02:35:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so5564189pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOBrU4X33EUBp4V/EjniBEwO3Y3JQt4rdTBeDxZ3ZjU=;
        b=Ro1G/8XHQBw9DM1CucpCzm+2U1QDj91479BVtMly5lyOWUDTY/gPVNDj97n77bym64
         xe5oz7XC98GOW2PI1+kHWmhbfS2iLsEFoDZwnuOeQ536ORkNb2sHJc06VrmFtwkvChMb
         YUccL9tiXyZPPjdBBFLjCFI3bdhxycwVeiPxufhb14Q1lP3juZGmR7rzoCX2ClH4QrTY
         6uOh8pDKBwDsLBPKl6wDKUNOLznX1Op8pDrIErSrd+LgTM6KkqX59zxYwt05aI4uEmDj
         PHkjKAY1rDlw40WmUXZ2KIhG9HxRMhvoXMLZxPYcxX13DX5uKkyBSWmWV4z2XaxNetKq
         k7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOBrU4X33EUBp4V/EjniBEwO3Y3JQt4rdTBeDxZ3ZjU=;
        b=akohAP+UwWNzPrFpYhlZLTvjRHuAsF3MUpe7C8ImWAg/EJS6ygV6dRoyu6o1Rq6W0I
         1LpSucqvdb1Uf6ZYX8AuZtmLwxCYgJOG1oPbX/ZPgWYG66IjGxtevvDClFoA5PS3kX2k
         0zES8FPg7pcONlIeCE8fYikcAGmwUj0kAnSbWVh83Y3IPlB500ybyqjDyi4IeHG6+GOW
         5DJQwae8sqkaU7Vtk4qePaPqN+EwfPx4XBCBwO1/B5Fs8PvCXUo4tHjgwvCIYG9rbYlD
         GeSrfpMzzCgOKO7eBAI7heMmLF+Mh/O/RkZeZtbhXD2M3o8ZE1Bu739bdx5Yc/hfgQdO
         LYzA==
X-Gm-Message-State: AOAM533jqkXPMWLDVq4+1VfL+uPNMMZdhA6aZJH0PihbTWisSdC9Epl9
        kfkze6qTjiGGApH0W5ep5XLfkA==
X-Google-Smtp-Source: ABdhPJwyKN/fMqHSiLSCFqje5xm7IfEYxX+ShLy7fld0Zm0G/MU9egeg+lMdTInUJSZ9GL2RV2WHvg==
X-Received: by 2002:a17:902:8308:b029:129:220a:c455 with SMTP id bd8-20020a1709028308b0290129220ac455mr4895871plb.74.1625132149791;
        Thu, 01 Jul 2021 02:35:49 -0700 (PDT)
Received: from localhost ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id c184sm24002494pfa.38.2021.07.01.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:35:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/3] coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
Date:   Thu,  1 Jul 2021 17:35:35 +0800
Message-Id: <20210701093537.90759-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701093537.90759-1-leo.yan@linaro.org>
References: <20210701093537.90759-1-leo.yan@linaro.org>
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
header for the AUX ring buffer which is not necessary; alternatively,
it's better to directly perf_output_handle::head.

This patch removes the field etr_perf_buffer::head and directly used
perf_output_handle::head for the head of AUX ring buffer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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


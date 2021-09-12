Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860DD407D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbhILNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhILNAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 09:00:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1804DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 05:59:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso4681219pji.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNDitdpFQYqRsx0NDA3UD5VzmjF/KpbCascgW18kvig=;
        b=VMfTM1vJQ5NjyWNtyqdZIf7pRJirf0q/HLIqkW5Gy0QsAWjsmbOaNzYEbdy3eOdG+Y
         xA4yRFy5OEu47iY49H0lNUqxficuk7MODA5Lsi++4PvTKtuWtqWLIglZu2ErA4S7WOff
         Iirv02bxvEkphm+PvmAfTKCjtoKR2gGJ2+jeCtfwn29E5IwRpcyFK2OJT0UFFFob6/XV
         ILoQrY1Tsj6IeiiKT0T1N/LV7JiKMgYV7K4Ub/hR7w3HGy5GcfdXRnUW+7wHVAUl5HKq
         Z5HXCljmCwjdi/OWBv7Ie2zK9TftgrFhu4MIMa9T62LvipZJUUA9HmvUtSeliWG68OiR
         bWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNDitdpFQYqRsx0NDA3UD5VzmjF/KpbCascgW18kvig=;
        b=pOhniKW4YTqsDuSWXEuYdRqgXLxO9fvY8cn9WDWPUquN2t0wA4V2YtdOmFOGa2CyXG
         NDHtuuQVk2xbCST3y0oHiG/Hrr+t0+i8JGXxvwqWVgJ4bg5Uvn75+ocVFGxpBzsLD7de
         seyu9yO3ShMVl9sPvpnIkUmS9521ipK1dKsv+Njk5KbtUbgHtJ6ATWl0kZC9gINq0on3
         UxV33yynJhDZx8kZLE5nFyvJGqfWgdLOV/tZRY425pXekErovJfWNxXbMxOxpx0IDVh5
         O7k+flq9RARzgsYA1gIZfIAR0rivsfKCqOtzHpL7Oe7ViBeN/UFWMfXo1ug/8cR7BhmV
         oTYw==
X-Gm-Message-State: AOAM532MbZtPvJGIr++E/m5GQIW3zX+O5JbFF/z5PPQlmjeQQVo/sWOU
        p5UlSwFxuoLaD5veqZBRFY2c0Q==
X-Google-Smtp-Source: ABdhPJwxQmnS3rXkItLBmb3jygB8KnsmsAtAxIw8FaqjSEool+xQT9rlkAAPTm6qnq0/Ndeo3brpiw==
X-Received: by 2002:a17:90a:9a2:: with SMTP id 31mr7471192pjo.58.1631451575885;
        Sun, 12 Sep 2021 05:59:35 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id b20sm4043332pfo.3.2021.09.12.05.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 05:59:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/2] coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
Date:   Sun, 12 Sep 2021 20:57:47 +0800
Message-Id: <20210912125748.2816606-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912125748.2816606-1-leo.yan@linaro.org>
References: <20210912125748.2816606-1-leo.yan@linaro.org>
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
it's better to directly use perf_output_handle::head.

This patch removes the field etr_perf_buffer::head and directly uses
perf_output_handle::head for the head of AUX ring buffer.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a049b525a274..d23c7690f29a 100644
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
@@ -1455,16 +1453,16 @@ static void tmc_free_etr_buffer(void *config)
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
@@ -1571,7 +1569,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	/* Insert barrier packets at the beginning, if there was an overflow */
 	if (lost)
 		tmc_etr_buf_insert_barrier_packet(etr_buf, offset);
-	tmc_etr_sync_perf_buffer(etr_perf, offset, size);
+	tmc_etr_sync_perf_buffer(etr_perf, handle->head, offset, size);
 
 	/*
 	 * In snapshot mode we simply increment the head by the number of byte
@@ -1623,8 +1621,6 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		goto unlock_out;
 	}
 
-	etr_perf->head = PERF_IDX2OFF(handle->head, etr_perf);
-
 	/*
 	 * No HW configuration is needed if the sink is already in
 	 * use for this session.
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD5A400FDB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhIENN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 09:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhIENNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 09:13:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC67C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 06:12:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i24so3404839pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNDitdpFQYqRsx0NDA3UD5VzmjF/KpbCascgW18kvig=;
        b=gMn8AVq4zKDEv2qIUktb9zStZXvW2NtVJoW9uMns6QIUjAu+rMmezD7NX0LQAw8bMK
         yXX+LqNiDYxuJcJ1jLU2fBAqjSdBUpaUnG0IKpcQQyRyqK8BA2FtUZaSUkg8R5h7cIMq
         WXiJdsxrO5bCaARO35sHATTBzY47ErgcYb49VIaT4FKfqUJMQV0orPe8Fm+nrLCg6wGl
         T5aYLNvChfPme9U7pZArO+xROFXuSNzG/JKKXNG9K5r22IYwDTwID2M29b9b9k4y2TZv
         D1/l2k6hZzXNR1lDWtUuGdKFErsv8CRVUATF2IEVOGaOkSb61dOs2J913tPl0+yJksr8
         yQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNDitdpFQYqRsx0NDA3UD5VzmjF/KpbCascgW18kvig=;
        b=M1t4x2UCtocEDyK9hXEVlEDpIfppua76NGdmhHi+z2CXYbKP/dbT4bI3q3SPHPjgTF
         NbsdGuHgNsa1p489OKvwKyWvszEw6cU1gk+Lz6SSZCwLxhKF1yLfJYSxTQFMqpPoMZuk
         SSMUY/YUio9JJwxa9g25AX0NVlz9l/XUj+LsTvF1RjGBI+ajVKMxw+xkb8I48HeRF9rN
         OrPnnGuxoCMYVmb9uIbuUDy/ICVm4AxmQKqosZ+1UN++gQ406SYhLxJ/qPA905MrKURU
         fuLLnq2MzV8S/AgB7mzXqpzOORgY3vB/NMuZrbYriaxvieJFCHYQ5TtbEF5+lnSPRAVK
         T5eQ==
X-Gm-Message-State: AOAM532wDcDmuZdIuI+l4syg83Hegi1lpwJ44fUPfaa9lJ/35+SivK6F
        pIM6kqNgh3DyxrtgmdSADGX1QA==
X-Google-Smtp-Source: ABdhPJyGoj06EAOX1zYXZ26Y72c2cYa/YUXqCbNIE4wsRBlEHdp8h2AHHA16zkisciOIJvvBwR+Kww==
X-Received: by 2002:a05:6a00:170d:b0:3f3:bcdb:4883 with SMTP id h13-20020a056a00170d00b003f3bcdb4883mr7592412pfc.68.1630847572273;
        Sun, 05 Sep 2021 06:12:52 -0700 (PDT)
Received: from localhost ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id g6sm4876530pfb.143.2021.09.05.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 06:12:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/2] coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
Date:   Sun,  5 Sep 2021 21:12:36 +0800
Message-Id: <20210905131237.1035322-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210905131237.1035322-1-leo.yan@linaro.org>
References: <20210905131237.1035322-1-leo.yan@linaro.org>
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


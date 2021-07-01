Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E833B8FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhGAJiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbhGAJiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:38:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8BC0617A8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 02:35:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id o18so4907148pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDDpm/dgelMrBHHum/u63M7DrWlUVDkZCNCbaXlSjZQ=;
        b=MYgymzoqyQLGPkTbVGm6NKk2dqZwDQHLFeazE2fE7D7W+8YeFX0WY7BVaXQGqA4i3L
         EUghuyJPZ1o0j6Vq/ma5t5h+Lj+JXfcg6LNpm6gI8lwWP3ejDyGRfwsfKXMBbZALA1Ho
         Yh0lO2cQC1OPKQRp9RFvXYBzyQYqa/F5Cco9Z2ZwWk73eU5VuT3a6zUUk1nWUD4oHeY1
         qFAZFYha5LjkqFB6xc0z0D/3rdk9QQeo/7lVprr8gM/BGwlpKw1Mh3aAaNsx2KddJNfq
         HGNQjZbdT3TaT3qIM1M/cxM5NVvknkxA/FMffi/5Dmwg655o4/P+nAohWZCGNVKKz8bk
         bUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDDpm/dgelMrBHHum/u63M7DrWlUVDkZCNCbaXlSjZQ=;
        b=RXnv+8/fd1mjuKTZmCZPXD3fknivfwcT4m5byCnwvUdhPtifUo4/Kt163F9KEhDmVp
         o+GVoGOJOY3jcv7n/CM3cmBSJMWsVlF3z5LYeAQCnFnO6T5cdjjbQqzsHTd4UoWXPZ4g
         801gsvyibiHM/lSMVENRrOuw+z3TW687L4Xi7cGarfyCzpN34t7TQt97f6u04ICdX1aq
         nNQoViEOvF0rn/swMEvkQ0nk+eZ0+nMjK+BzmQRCFcHPkwurnuymbE/S97g2p25KKnoR
         WTFp1jQJpsqzea6HnWyHEwVeFTTcxvll6EXqX8BEFVFgth72bINA37at6mjFbGWAoShY
         mbYA==
X-Gm-Message-State: AOAM531xVdG1l3U3ww2CBSel3ApOKCzgwpzqWo3+otYVVNcip+zrSaXq
        29EW43pp77flL3JJNUnkzGdrvA==
X-Google-Smtp-Source: ABdhPJzfEo67wRZrhzqrJLBqArAerh2kWDlR1v/0ST8x3XabgE5TiG8nLXTQaMKbQNBStUg/rB4HPA==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr38547801pgb.174.1625132153364;
        Thu, 01 Jul 2021 02:35:53 -0700 (PDT)
Received: from localhost ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id cl14sm1773806pjb.40.2021.07.01.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:35:52 -0700 (PDT)
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
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Subject: [PATCH v2 2/3] perf cs-etm: Remove callback cs_etm_find_snapshot()
Date:   Thu,  1 Jul 2021 17:35:36 +0800
Message-Id: <20210701093537.90759-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701093537.90759-1-leo.yan@linaro.org>
References: <20210701093537.90759-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
main purpose is to find the correct AUX trace data and returns "head"
and "old" (we can call "old" as "old head") to the caller, the caller
__auxtrace_mmap__read() uses these two pointers to decide the AUX trace
data size.

This patch removes cs_etm_find_snapshot() with below reasons:

- The first thing in cs_etm_find_snapshot() is to check if the head has
  wrapped around, if it is not, directly bails out.  The checking is
  pointless, this is because the "head" and "old" pointers both are
  monotonical increasing so they never wrap around.

- cs_etm_find_snapshot() adjusts the "head" and "old" pointers and
  assumes the AUX ring buffer is fully filled with the hardware trace
  data, so it always subtracts the difference "mm->len" from "head" to
  get "old".  Let's imagine the snapshot is taken in very short
  interval, the tracers only fill a small chunk of the trace data into
  the AUX ring buffer, in this case, it's wrongly to copy the whole the
  AUX ring buffer to perf file.

- As the "head" and "old" pointers are monotonically increased, the
  function __auxtrace_mmap__read() handles these two pointers properly.
  It calculates the reminders for these two pointers, and the size is
  clamped to be never more than "snapshot_size".  We can simply reply on
  the function __auxtrace_mmap__read() to calculate the correct result
  for data copying, it's not necessary to add Arm CoreSight specific
  callback.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 133 ------------------------------
 1 file changed, 133 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d942f118d32c..85168d87b2d7 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -38,8 +38,6 @@ struct cs_etm_recording {
 	struct auxtrace_record	itr;
 	struct perf_pmu		*cs_etm_pmu;
 	struct evlist		*evlist;
-	int			wrapped_cnt;
-	bool			*wrapped;
 	bool			snapshot_mode;
 	size_t			snapshot_size;
 };
@@ -734,135 +732,6 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	return 0;
 }
 
-static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
-{
-	bool *wrapped;
-	int cnt = ptr->wrapped_cnt;
-
-	/* Make @ptr->wrapped as big as @idx */
-	while (cnt <= idx)
-		cnt++;
-
-	/*
-	 * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
-	 * cross compilation problems where the host's system supports
-	 * reallocarray() but not the target.
-	 */
-	wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
-	if (!wrapped)
-		return -ENOMEM;
-
-	wrapped[cnt - 1] = false;
-	ptr->wrapped_cnt = cnt;
-	ptr->wrapped = wrapped;
-
-	return 0;
-}
-
-static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
-				      size_t buffer_size, u64 head)
-{
-	u64 i, watermark;
-	u64 *buf = (u64 *)buffer;
-	size_t buf_size = buffer_size;
-
-	/*
-	 * We want to look the very last 512 byte (chosen arbitrarily) in
-	 * the ring buffer.
-	 */
-	watermark = buf_size - 512;
-
-	/*
-	 * @head is continuously increasing - if its value is equal or greater
-	 * than the size of the ring buffer, it has wrapped around.
-	 */
-	if (head >= buffer_size)
-		return true;
-
-	/*
-	 * The value of @head is somewhere within the size of the ring buffer.
-	 * This can be that there hasn't been enough data to fill the ring
-	 * buffer yet or the trace time was so long that @head has numerically
-	 * wrapped around.  To find we need to check if we have data at the very
-	 * end of the ring buffer.  We can reliably do this because mmap'ed
-	 * pages are zeroed out and there is a fresh mapping with every new
-	 * session.
-	 */
-
-	/* @head is less than 512 byte from the end of the ring buffer */
-	if (head > watermark)
-		watermark = head;
-
-	/*
-	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
-	 */
-	watermark >>= 3;
-	buf_size >>= 3;
-
-	/*
-	 * If we find trace data at the end of the ring buffer, @head has
-	 * been there and has numerically wrapped around at least once.
-	 */
-	for (i = watermark; i < buf_size; i++)
-		if (buf[i])
-			return true;
-
-	return false;
-}
-
-static int cs_etm_find_snapshot(struct auxtrace_record *itr,
-				int idx, struct auxtrace_mmap *mm,
-				unsigned char *data,
-				u64 *head, u64 *old)
-{
-	int err;
-	bool wrapped;
-	struct cs_etm_recording *ptr =
-			container_of(itr, struct cs_etm_recording, itr);
-
-	/*
-	 * Allocate memory to keep track of wrapping if this is the first
-	 * time we deal with this *mm.
-	 */
-	if (idx >= ptr->wrapped_cnt) {
-		err = cs_etm_alloc_wrapped_array(ptr, idx);
-		if (err)
-			return err;
-	}
-
-	/*
-	 * Check to see if *head has wrapped around.  If it hasn't only the
-	 * amount of data between *head and *old is snapshot'ed to avoid
-	 * bloating the perf.data file with zeros.  But as soon as *head has
-	 * wrapped around the entire size of the AUX ring buffer it taken.
-	 */
-	wrapped = ptr->wrapped[idx];
-	if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
-		wrapped = true;
-		ptr->wrapped[idx] = true;
-	}
-
-	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
-		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
-
-	/* No wrap has occurred, we can just use *head and *old. */
-	if (!wrapped)
-		return 0;
-
-	/*
-	 * *head has wrapped around - adjust *head and *old to pickup the
-	 * entire content of the AUX buffer.
-	 */
-	if (*head >= mm->len) {
-		*old = *head - mm->len;
-	} else {
-		*head += mm->len;
-		*old = *head - mm->len;
-	}
-
-	return 0;
-}
-
 static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
@@ -900,7 +769,6 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 
-	zfree(&ptr->wrapped);
 	free(ptr);
 }
 
@@ -928,7 +796,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
 	ptr->itr.recording_options	= cs_etm_recording_options;
 	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
 	ptr->itr.info_fill		= cs_etm_info_fill;
-	ptr->itr.find_snapshot		= cs_etm_find_snapshot;
 	ptr->itr.snapshot_start		= cs_etm_snapshot_start;
 	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
 	ptr->itr.reference		= cs_etm_reference;
-- 
2.25.1


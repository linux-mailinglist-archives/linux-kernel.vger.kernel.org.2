Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A873D403E4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbhIHRZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhIHRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:25:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7007DC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:24:23 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so2650732pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHmGIOB1NHQy8ecOuiu9k+eNtsh1TK6SDUwkj58c7UY=;
        b=cOXfog/jv853BRLqDnKD86aRE3wO62YCoFAd15w/jyBa3mfpR0uStjWFoyxIlLjGVB
         q8XaD0jvT2gnaLh6P1iXVEbH17if5S006cVAJvQJaiGFvlJePTeu3KwdYld6GgXjWCqg
         5cr6jOHmblvoIVCpd91ubPvF/mEwcMtiE6BmHEEeAPnhLRKRC2rdmmFsl8ip5poF851C
         5noLcdvavWAxVUwq+krowAZhwx6f7wneGUD6ESPKaOBjnL9Ilo927d1SJMq0tEdf8I1F
         p1wTcr8ab05xhF5DfXZ7Fm3fOL4LdyaBFQzN8ZU0yxYOKLT5yUl3/JQg/TvBbsPkzTI2
         Nq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vHmGIOB1NHQy8ecOuiu9k+eNtsh1TK6SDUwkj58c7UY=;
        b=vDq+IkN0o9+vdLk0SUEOuQOf1Yw2wS0hPXQVTiZT8AEum9vobKTB+afuRKi0lV4sxz
         RXmNey1qE0VTDRL50YFKY1g0ZF9EfC9WriBB96bezWRVA7/lAoiIJ+RlFOvlEGvxL3zw
         gcstYdq+KFuyL+eUW6PcXH2M8mYInHeprVP6eUQtTk1VcDNJVMBmV17KKjXd1CAngZ+n
         MjuKi4ts1PWgGz87Ydo/OGl5LHNMIOoGpQqou392osflGLtT+BQ90DTNUJgKuiYBHZq9
         qF5Yc9xKGojo8Y1xcnDYVRj5PUXd5CfLnoJvlnV3lm1EMRK0XLdf2in0zXFsLhyThpS+
         IL9g==
X-Gm-Message-State: AOAM530Camo7kUYeoy1IEs1BM2TsSuDhBdEzKjgaA5/sV1QrPaZAK6Oz
        hyDtVFMkyCclg0l5fvaILes=
X-Google-Smtp-Source: ABdhPJzgNg/ubJR8s1atOpkAegUo0wB9DE1acYb2UDn+pbdS5Kcb/PUlPzNiQWgnMcUrVvN2oggz3A==
X-Received: by 2002:a63:a54f:: with SMTP id r15mr4769413pgu.11.1631121862940;
        Wed, 08 Sep 2021 10:24:22 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:f1e5:4c1a:8029:e4d1])
        by smtp.gmail.com with ESMTPSA id v7sm2610321pjk.37.2021.09.08.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:24:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH v2] perf/core: Add a new read format to get a number of lost samples
Date:   Wed,  8 Sep 2021 10:24:20 -0700
Message-Id: <20210908172420.879240-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to know an accurate number of samples even if it's
lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
might be shared with other events.  So it's hard to know per-event
lost count.

Add event->lost_samples field and PERF_FORMAT_LOST to retrieve it from
userspace.

Original-patch-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      |  2 ++
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 22 +++++++++++++++++++---
 kernel/events/ring_buffer.c     |  5 ++++-
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..189a471fba42 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -756,6 +756,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic64_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bf8143505c49..f72008949ff0 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -299,6 +299,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		lost;         } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -306,6 +307,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	lost;         } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -315,8 +317,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0e125ae2fa92..8708325ee4a2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1841,6 +1841,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 	if (event->attr.read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
+	if (event->attr.read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
 	if (event->attr.read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
@@ -5255,11 +5258,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_ID)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_ID)
+			values[n++] = atomic64_read(&sub->lost_samples);
 	}
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
@@ -5316,7 +5323,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5326,6 +5333,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -5664,6 +5673,7 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
 	default:
 		return -ENOTTY;
 	}
@@ -6835,7 +6845,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6849,6 +6859,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&event->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6859,7 +6871,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6877,6 +6889,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = atomic64_read(&leader->lost_samples);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6890,6 +6904,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = atomic64_read(&sub->lost_samples);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..727ca8f4caad 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic64_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic64_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
-- 
2.33.0.309.g3052b89438-goog


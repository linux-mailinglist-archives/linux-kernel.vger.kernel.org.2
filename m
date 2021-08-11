Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F63E8A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhHKGWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhHKGWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:22:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD28C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:21:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7983660pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K9I/88TeAnuctbwS5Yv4ovCvKiz2sqaoKEvkjlujzRQ=;
        b=UdbF+/YVy2lYJ99ttOf6uJGSTzTZ8HMlI5KV5SQjQRwsmLgo0wXuiu9haHhlfw+dff
         vzPcZLoCR6Y5r2boSnEcHBTEtqIEbyGeCs/FGb+b6DK5/e5STwTGQeuuTWFkHTPayTce
         sdWmZ+f5zYGpwLSpr/OpP78O6n6KVfkm6AyphLRIvQi8jlFoByuerYqfyo3kX5uL3za6
         EzXoImmJwtNqf/YU0Pn6Go09R2VAUj6nLUS6sFelveUW8LBr6Bwq2V7kDWoRYtSQi8UK
         CTTwPoEvM0/wfC05SKIgWaLhFJUddwx17DF/Z8xREMjW7ls/y0GtBQyVystc5siMjyhM
         Nmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=K9I/88TeAnuctbwS5Yv4ovCvKiz2sqaoKEvkjlujzRQ=;
        b=RF2L7Zu4eZz7BlTaal2eNgcIaTvhaBha+9CQZa/siFOk4uPLhuQdEqDP3Vo3s3Aldf
         wzXY1DfoOIPv0Ch5QZeH8BfmL4eIQ1Mv3F7kvODATlQqGqKa5TpIKwseUWLiz/VwB8RQ
         0pYf0wfz8kUpdtJEC+rZP3ylRx3SXwFqvekmzTITbTqkblcJQNu9VaFGRI9YTRBAB644
         RmMDRspNJXvC/eX5IYaWjYEAKW8zDQy6rW+bcWRpbz/q/2IWLlTGlIgfNQ8Kk842npOw
         ZUuhxVbAY3LCzyjQ+QWz/gwvzftmwLK4/LeUh0SYUnI//+f32a9kD+ZY7Af42nWDRR7s
         /Tlg==
X-Gm-Message-State: AOAM5337bBuLvHrt5nPfqyj7BON0LoJxw/4bCefNRN4qGyhgVBecJwj1
        +401l5I9VkiuKG0Tvh1lCwM=
X-Google-Smtp-Source: ABdhPJxtuCQYDbKsbcOYEhIS6dnSokiT7b253Bxvf8e3eMpcV13EY0AAcPE2xr9qhVKvC4TtC++OuA==
X-Received: by 2002:a17:90a:a63:: with SMTP id o90mr19266814pjo.167.1628662897959;
        Tue, 10 Aug 2021 23:21:37 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:a1a:ce43:c895:6a75])
        by smtp.gmail.com with ESMTPSA id g13sm19757624pfj.128.2021.08.10.23.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 23:21:37 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>, gmx@google.com
Subject: [RFC] perf/core: Add an ioctl to get a number of lost samples
Date:   Tue, 10 Aug 2021 23:21:35 -0700
Message-Id: <20210811062135.1332927-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to know an accurate number of samples even if it's
lost.  Currenlty PERF_RECORD_LOST is generated for a ring-buffer which
might be shared with other events.  So it's hard to know per-event
lost count.

Add event->lost_samples field and PERF_EVENT_IOC_LOST_SAMPLES to
retrieve it from userspace.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      | 2 ++
 include/uapi/linux/perf_event.h | 1 +
 kernel/events/core.c            | 9 +++++++++
 kernel/events/ring_buffer.c     | 5 ++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..44d72079c77a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -756,6 +756,8 @@ struct perf_event {
 	struct pid_namespace		*ns;
 	u64				id;
 
+	atomic_t			lost_samples;
+
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index bf8143505c49..24397799127d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -505,6 +505,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_LOST_SAMPLES		_IOR('$', 12, __u64 *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0e125ae2fa92..a4d6736b6594 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5664,6 +5664,15 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_LOST_SAMPLES: {
+		u64 lost = atomic_read(&event->lost_samples);
+
+		if (copy_to_user((void __user *)arg, &lost, sizeof(lost)))
+			return -EFAULT;
+		return 0;
+	}
+
 	default:
 		return -ENOTTY;
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..06d7dacb05da 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -172,8 +172,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 		goto out;
 
 	if (unlikely(rb->paused)) {
-		if (rb->nr_pages)
+		if (rb->nr_pages) {
 			local_inc(&rb->lost);
+			atomic_inc(&event->lost_samples);
+		}
 		goto out;
 	}
 
@@ -254,6 +256,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 fail:
 	local_inc(&rb->lost);
+	atomic_inc(&event->lost_samples);
 	perf_output_put_handle(handle);
 out:
 	rcu_read_unlock();
-- 
2.32.0.605.g8dce9f2422-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266B53371D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhCKLys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 06:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhCKLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:54:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:54:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w8so3345225pjf.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 03:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0LAPp05B9Of2Cekjfja2CVWXsh48Q69XFsKQ7FfpaEk=;
        b=qjBRK6vD16OB4ysOZKXj+r5V8X9qzNCDSmoP5i/NaJBhxAHMAgs/UvI38BtJ3pIoGz
         I7gQ6yOQMEegLop2ub81rwUVyR6e1bWxglZslEoXDqOKZdabLDNOgl4uMLl+Hsv1DfXm
         r4cVA56vh9iu10w0DgeQ4EwWWIndq75NrWjBS3x8fVRI8dQguB5vyiGUpYG4Uw5r9/yD
         pjh3Px4lUUa2O953QhkE077wJxIS0v4U+DjAJsL6Rot5irDhwqhd0EcZCBUVPRpoSqMT
         nYHazi5ADftQAuKZ9yMbY0XJcr+AlCXlDDT5f+1obawl33aO5qWrNgknpFcTeyElahof
         +FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0LAPp05B9Of2Cekjfja2CVWXsh48Q69XFsKQ7FfpaEk=;
        b=t9XwZsG6R5sj4APxrka/puIkE79CbcuHmLGNQn2H0PO6evbAyQE3acETa6TMLVQi1E
         8gA9oGr7ij8xFwbGbInHFz508BLa3Iv3WBGYbj3mKvdjE1a6E4Zj0M1K/u17sd5trwoL
         VzT9W0Xp/JQVzQilDrL50RuSXQ4HiaGm+4hipGnMMre4epa4ENpOQ0DqY4LlKZUD5E24
         7NlkPIA2ZNuIwAeseJv88KUqsjsRZYNDDJU89XnbYQWVJY39AqnOvjCjpRUDLKCYzfY9
         InkQB6Tm+g/+nxZCBBAlLLwoXHYoxzKvwGk3ybSc989IOA41S794MFYjT0QWV3Jl6O7I
         dKLw==
X-Gm-Message-State: AOAM531/RMNSwtivosB4QAVjV94vDY9YkIqjorHLlq7o+ZnA2mVIrA9G
        rjLOviXschPuUZFRjzGfgC4=
X-Google-Smtp-Source: ABdhPJyOeBJf+B/2g7MHCxX9uQTOrVIUX6BjtmqFp5y9Dzq2LS9i1h6YhQUjn5QYh2UUX6D842Oybg==
X-Received: by 2002:a17:90b:110c:: with SMTP id gi12mr8577862pjb.48.1615463660061;
        Thu, 11 Mar 2021 03:54:20 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id i14sm2233742pjh.17.2021.03.11.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:54:19 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        David Rientjes <rientjes@google.com>,
        Namhyung Kim <namhyung@google.com>
Subject: [PATCH 1/2] perf core: Add a kmem_cache for struct perf_event
Date:   Thu, 11 Mar 2021 20:54:12 +0900
Message-Id: <20210311115413.444407-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@google.com>

The kernel can allocate a lot of struct perf_event when profiling. For
example, 256 cpu x 8 events x 20 cgroups = 40K instances of the struct
would be allocated on a large system.

The size of struct perf_event in my setup is 1152 byte. As it's
allocated by kmalloc, the actual allocation size would be rounded up
to 2K.

Then there's 896 byte (~43%) of waste per instance resulting in total
~35MB with 40K instances. We can create a dedicated kmem_cache to
avoid such a big unnecessary memory consumption.

With this change, I can see below (note this machine has 112 cpus).

  # grep perf_event /proc/slabinfo
  perf_event    224    784   1152    7    2 : tunables   24   12    8 : slabdata    112    112      0

The sixth column is pages-per-slab which is 2, and the fifth column is
obj-per-slab which is 7.  Thus actually it can use 1152 x 7 = 8064
byte in the 8K, and wasted memory is (8192 - 8064) / 7 = ~18 byte per
instance.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5206097d4d3d..10f2548211d0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -402,6 +402,7 @@ static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
 static cpumask_var_t perf_online_mask;
+static struct kmem_cache *perf_event_cache;
 
 /*
  * perf event paranoia level:
@@ -4591,7 +4592,7 @@ static void free_event_rcu(struct rcu_head *head)
 	if (event->ns)
 		put_pid_ns(event->ns);
 	perf_event_free_filter(event);
-	kfree(event);
+	kmem_cache_free(perf_event_cache, event);
 }
 
 static void ring_buffer_attach(struct perf_event *event,
@@ -11251,7 +11252,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 			return ERR_PTR(-EINVAL);
 	}
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	event = kmem_cache_zalloc(perf_event_cache, GFP_KERNEL);
 	if (!event)
 		return ERR_PTR(-ENOMEM);
 
@@ -11455,7 +11456,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		put_pid_ns(event->ns);
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
-	kfree(event);
+	kmem_cache_free(perf_event_cache, event);
 
 	return ERR_PTR(err);
 }
@@ -13087,6 +13088,8 @@ void __init perf_event_init(void)
 	ret = init_hw_breakpoint();
 	WARN(ret, "hw_breakpoint initialization failed with: %d", ret);
 
+	perf_event_cache = KMEM_CACHE(perf_event, SLAB_PANIC);
+
 	/*
 	 * Build time assertion that we keep the data_head at the intended
 	 * location.  IOW, validation we got the __reserved[] size right.
-- 
2.31.0.rc2.261.g7f71774620-goog


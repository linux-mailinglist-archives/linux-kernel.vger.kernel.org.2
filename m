Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B2308700
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhA2H5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhA2H5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:57:25 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F83C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:58:03 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d13so4821607plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgLFqgY10G509SKNPn2DfB44h7Jcfjh++XfHDN+BOH4=;
        b=ATsDGvcW8umaYbsz3PSi01wZuOY6rRhVGIm4prJitwfNIc9LeRu9QH5DAxMVUPAT1E
         A6vmKPknPyLGeXq0iIOroeVgz+gB+4O8NWEDFpiHIYUdaSphLb6HcUMIuczQDz2iwPnB
         mdsab9lz0YtekFf22ObvxY7cBVTnM37jEWSlBqXXnCwGlvZm7DHK23TJQux25688haG5
         pl4E/+Z1YpkN0PuS8/ahnrraeI6wUFVOREOQqF5KumnS2SOom5ybnkPGQhgObZM3b5dP
         31X662mhCx9ec0GrsaLSMRZfJn7lEIFiRtClad7e2nQOw6IrJMz8zPlOPeDpiBnEVlsV
         vLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lgLFqgY10G509SKNPn2DfB44h7Jcfjh++XfHDN+BOH4=;
        b=bQSD4E/9uyyDtMD+HBfQ+ihXIi7Z8S02OrULxKUTZ7PPnvsvHft6fSFiV02fYF5hq6
         lXtO7Y5Xf+0Xtj6KOd0z9cTaprRIVAsw91KENr+AovBuWQIlCTOp4rhX96DQs7xx52IZ
         1vQ+6ygsSqSq/y0KDVMQUuPB+lAI1lYDvu1hpg5NrwrJK0iszNtXeps0STKLAbQdx+lt
         yl2pHYhq3tpx1DLBkcOHs6iUADPxZ8gCMt+JFrn4rN0I1Ai3BX/ClZeqHP2fNnePgXZv
         JE09GF1gXXpsahghqxAtKnxxYggoWsrAdCEfpE9cjOnHxWmDYlD99HeQnoZaNLD6DYyD
         qXaw==
X-Gm-Message-State: AOAM533sU5yn+XDzbi5QF0HIb8mPkEyaDOZ56363SQyP0I6BMVUQlHzS
        1jrvuMR1/yiOEYvdfNM08tU=
X-Google-Smtp-Source: ABdhPJzfP/Zm0kKGEEqT0Cc+2CR1HqB3X+flKoM8qsczWffa98vlMar/H0sH+YRkLUFz3DOm0+JvBg==
X-Received: by 2002:a17:90a:e551:: with SMTP id ei17mr3358840pjb.179.1611907082914;
        Thu, 28 Jan 2021 23:58:02 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id j10sm6893368pjy.9.2021.01.28.23.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:58:02 -0800 (PST)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2] perf/core: Wake up tasks for failing pinned events
Date:   Fri, 29 Jan 2021 16:57:57 +0900
Message-Id: <20210129075757.1720900-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now we don't get any notice for pinned events when it's failed
to be scheduled and make it in an error state not try to schedule it
again.  That means we won't get any samples for the event.

It's possible we can detect it by reading the file, but usually we
only monitor it via mmap-ed ring buffers.  Let's poke the tasks
waiting for poll(2) so that they can respond to the event.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f579bc76..0b3b3e97243b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -733,6 +733,7 @@ struct perf_event {
 	int				pending_wakeup;
 	int				pending_kill;
 	int				pending_disable;
+	int				pending_pin_error;
 	struct irq_work			pending;
 
 	atomic_t			event_limit;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d18791a72d..f8e9db30a573 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3675,6 +3675,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+			event->pending_pin_error = 1;
+			irq_work_queue(&event->pending);
 		}
 
 		*can_add_hw = 0;
@@ -5288,6 +5290,9 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 	if (is_event_hup(event))
 		return events;
 
+	if (event->attr.pinned && event->state == PERF_EVENT_STATE_ERROR)
+		return EPOLLERR;
+
 	/*
 	 * Pin the event->rb by taking event->mmap_mutex; otherwise
 	 * perf_event_set_output() can swizzle our rb and make us miss wakeups.
@@ -6333,6 +6338,11 @@ static void perf_pending_event(struct irq_work *entry)
 		perf_event_wakeup(event);
 	}
 
+	if (event->pending_pin_error) {
+		event->pending_pin_error = 0;
+		wake_up_all(&event->waitq);
+	}
+
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 }
-- 
2.30.0.365.g02bc693789-goog


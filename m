Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F397D3B094A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhFVPl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:41:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232210AbhFVPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0iEASLL8r/ZfSP91MzS7ctdRrTddO9FBRfKpjnL0AM=;
        b=Q4pkiMm77IYzwGIje45Kwv259lkBWNKNgWJ8A+uRjvj14TIU1EgvVp3yX/Q2Jmg4CoeZZT
        rWTgewDBCY86yGHsmOtO5fCdYQNRXMdcEBW8K+6Ki+ZwdNgzPk56GdMI/x0TPri6YAJi5m
        oZCepwPkd2zHHJS+6gcQcRd8VR6w6Tk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-2OSN0KlGPby3ruCXT7QMyg-1; Tue, 22 Jun 2021 11:39:29 -0400
X-MC-Unique: 2OSN0KlGPby3ruCXT7QMyg-1
Received: by mail-wr1-f71.google.com with SMTP id k25-20020a5d52590000b0290114dee5b660so9915965wrc.16
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0iEASLL8r/ZfSP91MzS7ctdRrTddO9FBRfKpjnL0AM=;
        b=bYAvgRA3i9sDLhakXNjtEOqybj1mLvbcZ/dEXUO1YjwO7eBnPzEU2kPEP7KnV9sKuX
         H6wSfizoTmMD+Jnf5zSWqc0T7+f0y9Z3DuxX9sLEptgyxoffnLNJmG2m+8WB1c8D9N8B
         P7aIAHZAIQSK8R6sOLwGDFUf4EsEUqYaSVxFdaEeRK23iqwqTrEqlprelYx3T20JSquB
         PZYvQ43WMP2PMEhkt1sLHtpZ6ZxAk34Z/GTTXUpo3OXf41DG32alNCo0wqAW9OA80Fl/
         bWfjlglJ7upCjMtxTD6cpBNxmRWRXymYwonW5fDfd9ab6cCfmIcm65YxukmEFeaa08b3
         GE7Q==
X-Gm-Message-State: AOAM5312AmiyJO65rODVkzeFLyuMKXg0Qu26UbVPpbC7PJjonDNIpONa
        fhHg/b3yyn59aW0V142ff/2bQqwUFysxV2y7hk/+40xapppbrKAf71ll/2gdKK7lR8kFj083E8N
        JtSgOSxmDwFGKs+ASABDptKsD
X-Received: by 2002:adf:de0e:: with SMTP id b14mr5677609wrm.229.1624376368546;
        Tue, 22 Jun 2021 08:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPaO3SssQpK06XhsVZKTlxizzIHvPg/I7/2ndnDMYMc/+Oq8AVmriiAKSamEIKfFK5DzqpUw==
X-Received: by 2002:adf:de0e:: with SMTP id b14mr5677590wrm.229.1624376368401;
        Tue, 22 Jun 2021 08:39:28 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:28 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 03/10] perf: Add new read_format bit to read build id faults
Date:   Tue, 22 Jun 2021 17:39:11 +0200
Message-Id: <20210622153918.688500-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's now possible to retrieve build id faults stats by read
syscall on events with perf_event_attr::build_id set.

Adding PERF_FORMAT_BUILD_ID_FAULTS read_format bit to get
the value of build_id_faults through the read syscall.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/perf_event.h | 17 ++++++++++-------
 kernel/events/core.c            | 21 ++++++++++++++++++---
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..2424ba7f95fb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -296,16 +296,18 @@ enum {
  *
  * struct read_format {
  *	{ u64		value;
- *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
- *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
- *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		time_enabled;    } && PERF_FORMAT_TOTAL_TIME_ENABLED
+ *	  { u64		time_running;    } && PERF_FORMAT_TOTAL_TIME_RUNNING
+ *	  { u64		id;              } && PERF_FORMAT_ID
+ *	  { u64		build_id_faults; } && PERF_FORMAT_BUILD_ID_FAULTS
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
- *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
- *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
+ *	  { u64		time_enabled;    } && PERF_FORMAT_TOTAL_TIME_ENABLED
+ *	  { u64		time_running;    } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
- *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	id;              } && PERF_FORMAT_ID
+ *	    { u64	build_id_faults; } && PERF_FORMAT_BUILD_ID_FAULTS
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -315,8 +317,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_BUILD_ID_FAULTS		= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f1630c06195..f3cd06012115 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1840,6 +1840,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 	if (event->attr.read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
+	if (event->attr.read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		entry += sizeof(u64);
+
 	if (event->attr.read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
@@ -5247,11 +5250,15 @@ static int __perf_read_group_add(struct perf_event *leader,
 	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		values[n++] = local64_read(&leader->build_id_faults);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+			values[n++] = local64_read(&sub->build_id_faults);
 	}
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
@@ -5308,7 +5315,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5318,6 +5325,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = running;
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		values[n++] = local64_read(&event->build_id_faults);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6820,7 +6829,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[4];
+	u64 values[5];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6834,6 +6843,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	}
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(event);
+	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		values[n++] = local64_read(&event->build_id_faults);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6844,7 +6855,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6862,6 +6873,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
+	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+		values[n++] = local64_read(&leader->build_id_faults);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6875,6 +6888,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
+		if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
+			values[n++] = local64_read(&sub->build_id_faults);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
-- 
2.31.1


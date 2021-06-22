Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE023B094B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFVPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232220AbhFVPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDygSEWeE37oXpQgtmE5d+CzWyO9bVgcAMYrTvTb5CE=;
        b=Y5wsMfXzUZoCOxn3XV8lCc6rSSxZOWnbVWnrYoJNMMJwroM2dUNkXLQuNyaTtyLshoBHat
        7VjZ4nycUYRVR/9UH5ts3bH+Uf/8XM0IuuyQCPMclOo4k/mnoYjB2b41EuaLcMldVjlS2S
        oaKXxuK6SadMZNaAXsKSgr/IsMF4q8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-1r-i0D8pOraO7KIdWBXHBA-1; Tue, 22 Jun 2021 11:39:31 -0400
X-MC-Unique: 1r-i0D8pOraO7KIdWBXHBA-1
Received: by mail-wr1-f71.google.com with SMTP id u18-20020a5d6ad20000b0290123314c5505so1042779wrw.20
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDygSEWeE37oXpQgtmE5d+CzWyO9bVgcAMYrTvTb5CE=;
        b=DqLjroQeUnPJk05FDVnDqX+a0FB7Gj5BwjoDqvzqV5jrk3JruqP3qP/mNdULV1yKp7
         M0PQSDDv6LIaDu5B42Uw0eA4epzotPDqpm1BonYu8HOLwzr44r9B1lnPy825/pPGHakN
         Nni0rILpNOdVrGw0vXiDt1V33Fv8BCkyeNU+Nr3Gq/37XbnHstUIJ2bs9lkp6xuHtvpm
         bYxR0A1YTlQ3i7W7nBFMull/JsRuDpUrmHFaNRKMGiQjrTeOSPBSy1O5BbfaH2Akf2ru
         e/NIbB/qDX/4LuOz+h6etbTjYCOEf2lUumHwpnhuGwdX1IY+t5wQP17pSZ8l2r/a6HnU
         cicQ==
X-Gm-Message-State: AOAM533pOvXuo5PF5kapdnpQr82u3nQIUZd47Gn0BpsQesZeBCAMa22Z
        gWvc7Dry2hDDoBJ3Pi4sBJdnsh4W5YYwUYCaIm4g6hK6aYpuCKToqGkUMtWV6eNNSKef3riYrzc
        ehOgONrMeP3RA1rdg8UAKOP4V
X-Received: by 2002:a5d:6485:: with SMTP id o5mr5550005wri.91.1624376370191;
        Tue, 22 Jun 2021 08:39:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw77MiMwcCJbolgemnaTd0aSNLc384Yr0np5HYyjsRx/UIpHjdKxzD9l5q+EkHORis/JDZd8w==
X-Received: by 2002:a5d:6485:: with SMTP id o5mr5549992wri.91.1624376370047;
        Tue, 22 Jun 2021 08:39:30 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:29 -0700 (PDT)
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
Subject: [PATCH 04/10] perf: Add new read_format bit to read lost events
Date:   Tue, 22 Jun 2021 17:39:12 +0200
Message-Id: <20210622153918.688500-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622153918.688500-1-jolsa@kernel.org>
References: <20210622153918.688500-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's now possible to retrieve lost stats by read
syscall on events.

Adding PERF_FORMAT_LOST read_format bit to get the
value of lost events through the read syscall.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 21 ++++++++++++++++++---
 kernel/events/ring_buffer.c     |  3 +++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5110a998f59b..209c66a01797 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -670,6 +670,7 @@ struct perf_event {
 	local64_t			count;
 	atomic64_t			child_count;
 	local64_t			build_id_faults;
+	local64_t			lost;
 
 	/*
 	 * These are the total time in nanoseconds that the event
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 2424ba7f95fb..e742c8f43a18 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -300,6 +300,7 @@ enum {
  *	  { u64		time_running;    } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;              } && PERF_FORMAT_ID
  *	  { u64		build_id_faults; } && PERF_FORMAT_BUILD_ID_FAULTS
+ *	  { u64		lost;            } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -308,6 +309,7 @@ enum {
  *	  { u64		value;
  *	    { u64	id;              } && PERF_FORMAT_ID
  *	    { u64	build_id_faults; } && PERF_FORMAT_BUILD_ID_FAULTS
+ *	    { u64	lost;            } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -318,8 +320,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
 	PERF_FORMAT_BUILD_ID_FAULTS		= 1U << 4,
+	PERF_FORMAT_LOST			= 1U << 5,
 
-	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 6,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f3cd06012115..ba02ce9e9134 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1843,6 +1843,9 @@ static void __perf_event_read_size(struct perf_event *event, int nr_siblings)
 	if (event->attr.read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 		entry += sizeof(u64);
 
+	if (event->attr.read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
 	if (event->attr.read_format & PERF_FORMAT_GROUP) {
 		nr += nr_siblings;
 		size += sizeof(u64);
@@ -5252,6 +5255,8 @@ static int __perf_read_group_add(struct perf_event *leader,
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 		values[n++] = local64_read(&leader->build_id_faults);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = local64_read(&leader->lost);
 
 	for_each_sibling_event(sub, leader) {
 		values[n++] += perf_event_count(sub);
@@ -5259,6 +5264,8 @@ static int __perf_read_group_add(struct perf_event *leader,
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 			values[n++] = local64_read(&sub->build_id_faults);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = local64_read(&sub->lost);
 	}
 
 	raw_spin_unlock_irqrestore(&ctx->lock, flags);
@@ -5315,7 +5322,7 @@ static int perf_read_one(struct perf_event *event,
 				 u64 read_format, char __user *buf)
 {
 	u64 enabled, running;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = __perf_event_read_value(event, &enabled, &running);
@@ -5327,6 +5334,8 @@ static int perf_read_one(struct perf_event *event,
 		values[n++] = primary_event_id(event);
 	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 		values[n++] = local64_read(&event->build_id_faults);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = local64_read(&event->lost);
 
 	if (copy_to_user(buf, values, n * sizeof(u64)))
 		return -EFAULT;
@@ -6829,7 +6838,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 				 u64 enabled, u64 running)
 {
 	u64 read_format = event->attr.read_format;
-	u64 values[5];
+	u64 values[6];
 	int n = 0;
 
 	values[n++] = perf_event_count(event);
@@ -6845,6 +6854,8 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 		values[n++] = primary_event_id(event);
 	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 		values[n++] = local64_read(&event->build_id_faults);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = local64_read(&event->lost);
 
 	__output_copy(handle, values, n * sizeof(u64));
 }
@@ -6855,7 +6866,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
-	u64 values[6];
+	u64 values[7];
 	int n = 0;
 
 	values[n++] = 1 + leader->nr_siblings;
@@ -6875,6 +6886,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 		values[n++] = local64_read(&leader->build_id_faults);
+	if (read_format & PERF_FORMAT_LOST)
+		values[n++] = local64_read(&leader->lost);
 
 	__output_copy(handle, values, n * sizeof(u64));
 
@@ -6890,6 +6903,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_BUILD_ID_FAULTS)
 			values[n++] = local64_read(&sub->build_id_faults);
+		if (read_format & PERF_FORMAT_LOST)
+			values[n++] = local64_read(&sub->lost);
 
 		__output_copy(handle, values, n * sizeof(u64));
 	}
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..51738bc7cf44 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -248,6 +248,9 @@ __perf_output_begin(struct perf_output_handle *handle,
 		perf_event_header__init_id(&lost_event.header, data, event);
 		perf_output_put(handle, lost_event);
 		perf_event__output_id_sample(event, handle, data);
+
+		/* Keep track of lost events in event for PERF_FORMAT_LOST */
+		local64_add(lost_event.lost, &event->lost);
 	}
 
 	return 0;
-- 
2.31.1


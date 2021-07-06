Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B893BD9FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhGFPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232764AbhGFPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Y33i+uSFsLOB+NUbcpIV2KAt1WulzlUDozIH51BtmQ=;
        b=LpU3rthvjPm8leIOOf63s7+TgnJdkBIpfZGWAXV4OsvwrMrG8xs9uIn1AnxztykLvei+g4
        NGDu8zub3IC6FHxWEb8JPueYdJ/p506BIsynjnJPoL1dRLqCovKNqdU50i5rT0Ra2VHwGa
        NuA8q+6Ee6G5m3OcgWegkrF8XOsYA+w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-5ZqkQwGwMlCIxfaGwQ2Jbw-1; Tue, 06 Jul 2021 11:17:52 -0400
X-MC-Unique: 5ZqkQwGwMlCIxfaGwQ2Jbw-1
Received: by mail-wr1-f72.google.com with SMTP id g4-20020a5d64e40000b029013398ce8904so2619240wri.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Y33i+uSFsLOB+NUbcpIV2KAt1WulzlUDozIH51BtmQ=;
        b=rlK/2br2LY15joOL8amkyU3VDrZGyflnF9cYeUx1mlFxT+hQQ+f0iRqZEA43G6Ze3E
         36heigoLXNhCBJ1YV4/QPw/a3IaYDUS6zi0JUiEqBzKMVP+Osa0/m83UAhm77ccLfpFK
         vzY0c64MIGWYUPsiKaPgVWnJV2nORgInJlIwFLkzADEd4t00mnxPmpLZKqmpaDpDyL86
         1qKJwTZ2QaRb2KY/4dS5CT6V18d7GFxKmKgB6TkWD10b5tDr4RDrrps7Irwwc4DUs5pA
         /bgLa6Ez4eXOz/Pl1X/FhO4D773neOe3/597SymhefgFPrHwvRCgcMYxJm1m8nWDDdG2
         7CMA==
X-Gm-Message-State: AOAM5307Vv0c+LxRJ5OjL3UVTRL8niCdOp3FDgEugHxtNZzK7t3CEBhx
        kLeFHf2q5PcIQMQ93X9u5mP8wadP4D18Do65T9wHFoMQvEsoEXBu579aktwImyppkXWmywBUpq5
        PnWxIBMIGHH8t2+GPwyLTSAg/
X-Received: by 2002:a5d:400a:: with SMTP id n10mr22624252wrp.268.1625584671297;
        Tue, 06 Jul 2021 08:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Z4DnxZmw93z5YgcDJUqtdkicaLdBMg0wkfh/AVp4Be2+ob8pTpwKNe7gFTjPu2GEMj5htA==
X-Received: by 2002:a5d:400a:: with SMTP id n10mr22624226wrp.268.1625584671116;
        Tue, 06 Jul 2021 08:17:51 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id a4sm16868490wru.55.2021.07.06.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:50 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 6/7] libperF: Add group support to perf_evsel__open
Date:   Tue,  6 Jul 2021 17:17:03 +0200
Message-Id: <20210706151704.73662-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210706151704.73662-1-jolsa@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to set group_fd in perf_evsel__open
call and make it to follow the group setup.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/evsel.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 3e6638d27c45..9ebf7122d476 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -17,6 +17,7 @@
 #include <linux/string.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <asm/bug.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
@@ -76,6 +77,25 @@ sys_perf_event_open(struct perf_event_attr *attr,
 	return syscall(__NR_perf_event_open, attr, pid, cpu, group_fd, flags);
 }
 
+static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread)
+{
+	struct perf_evsel *leader = evsel->leader;
+	int fd;
+
+	if (evsel == leader)
+		return -1;
+
+	/*
+	 * Leader must be already processed/open,
+	 * if not it's a bug.
+	 */
+	BUG_ON(!leader->fd);
+
+	fd = FD(leader, cpu, thread);
+	BUG_ON(fd == -1);
+	return fd;
+}
+
 int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 		     struct perf_thread_map *threads)
 {
@@ -111,11 +131,13 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
 
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 		for (thread = 0; thread < threads->nr; thread++) {
-			int fd;
+			int fd, group_fd;
+
+			group_fd = get_group_fd(evsel, cpu, thread);
 
 			fd = sys_perf_event_open(&evsel->attr,
 						 threads->map[thread].pid,
-						 cpus->map[cpu], -1, 0);
+						 cpus->map[cpu], group_fd, 0);
 
 			if (fd < 0)
 				return -errno;
-- 
2.31.1


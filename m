Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9182335F8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352623AbhDNQIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:08:18 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:42967 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351422AbhDNQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:08:14 -0400
Received: by mail-oi1-f173.google.com with SMTP id n140so21096288oig.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I82KJz3L0Cy+wmA8GvlMQIQpHUIgg9NcbppPZv/xIZo=;
        b=OJeOJZgaOFYVJIAqeo/UfPu6PjMc3r0ulotkqdjBwxW2DKPBwJ5g9JtN/0G4MzwrP5
         8kWz4jvWynhNmq66273+N6ZOE6LiDT1uHOFHUEm7nreJlxPPSXDKryV/4FacwSKI9CUl
         t906HBN/ZnRUXqTbJn7twoeuY3UIpuNk+D3iTOXTftBJPSWSVvk9r3jAIuGLvg3tPCGU
         RATWu+vTV/hy07xHFo5dBQZ4VxDFV+t+L12P8yRDRwGObB2g6Fjni9i4qStvkYVykMwf
         lp9MauIfPa+yXSSgBJkEJyzVwB8GzCSR2vuPiVsBKySRfUYlB3bWk7y+fLTIS7x7Zniv
         HfEg==
X-Gm-Message-State: AOAM533+hnbEld+XEX0v5zYRXi+UtCr1+0F9O+Zx0c2L7DDBc2lssunv
        94YmJGZr/o2rptPwW2hhCw==
X-Google-Smtp-Source: ABdhPJwMU+lUYLR+ykXQkGiNph6Eq0KJVAs071VLf1N3xP1MAuADEaU7soTA1KJuEczMn2BJxDc64g==
X-Received: by 2002:aca:b787:: with SMTP id h129mr2990029oif.58.1618416473071;
        Wed, 14 Apr 2021 09:07:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t19sm4471239otm.40.2021.04.14.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:07:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v8 2/4] libperf: Add evsel mmap support
Date:   Wed, 14 Apr 2021 11:07:37 -0500
Message-Id: <20210414155412.3697605-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414155412.3697605-1-robh@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support usersapce access, an event must be mmapped. While
there's already mmap support for evlist, the usecase is a bit different
than the self monitoring with userspace access. So let's add new
perf_evsel__mmap()/perf_evsel_munmap() functions to mmap/munmap an
evsel. This allows implementing userspace access as a fastpath for
perf_evsel__read().

The mmapped address is returned by perf_evsel__mmap_base() which
primarily for users/tests to check if userspace access is enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v8:
 - Add perf_evsel__munmap()
 - munmap in event of an error in perf_evsel__mmap()
 - Ensure repeated calls to perf_evsel__mmap return error
v7:
 - Add NULL fd check to perf_evsel__mmap
v6:
 - split mmap struct into it's own xyarray
v5:
 - Create an mmap for every underlying event opened. Due to this, we
   need a different way to get the mmap ptr, so perf_evsel__mmap_base()
   is introduced.
v4:
 - Change perf_evsel__mmap size to pages instead of bytes
v3:
 - New patch split out from user access patch
---
 tools/lib/perf/Documentation/libperf.txt |  3 +
 tools/lib/perf/evsel.c                   | 76 ++++++++++++++++++++++++
 tools/lib/perf/include/internal/evsel.h  |  1 +
 tools/lib/perf/include/perf/evsel.h      |  3 +
 tools/lib/perf/libperf.map               |  3 +
 5 files changed, 86 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 0c74c30ed23a..63ae5e0195ce 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -136,6 +136,9 @@ SYNOPSIS
                        struct perf_thread_map *threads);
   void perf_evsel__close(struct perf_evsel *evsel);
   void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
+  void perf_evsel__munmap(struct perf_evsel *evsel);
+  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
   int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
                        struct perf_counts_values *count);
   int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 4dc06289f4c7..cd203998e875 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -11,10 +11,12 @@
 #include <stdlib.h>
 #include <internal/xyarray.h>
 #include <internal/cpumap.h>
+#include <internal/mmap.h>
 #include <internal/threadmap.h>
 #include <internal/lib.h>
 #include <linux/string.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>

 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -38,6 +40,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 }

 #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+#define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)

 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 {
@@ -55,6 +58,13 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 	return evsel->fd != NULL ? 0 : -ENOMEM;
 }

+static int perf_evsel__alloc_mmap(struct perf_evsel *evsel, int ncpus, int nthreads)
+{
+	evsel->mmap = xyarray__new(ncpus, nthreads, sizeof(struct perf_mmap));
+
+	return evsel->mmap != NULL ? 0 : -ENOMEM;
+}
+
 static int
 sys_perf_event_open(struct perf_event_attr *attr,
 		    pid_t pid, int cpu, int group_fd,
@@ -156,6 +166,72 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
 	perf_evsel__close_fd_cpu(evsel, cpu);
 }

+void perf_evsel__munmap(struct perf_evsel *evsel)
+{
+	int cpu, thread;
+
+	if (evsel->fd == NULL || evsel->mmap == NULL)
+		return;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+			int fd = FD(evsel, cpu, thread);
+			struct perf_mmap *map = MMAP(evsel, cpu, thread);
+
+			if (fd < 0)
+				continue;
+
+			perf_mmap__munmap(map);
+		}
+	}
+
+	xyarray__delete(evsel->mmap);
+	evsel->mmap = NULL;
+}
+
+int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
+{
+	int ret, cpu, thread;
+	struct perf_mmap_param mp = {
+		.prot = PROT_READ | PROT_WRITE,
+		.mask = (pages * page_size) - 1,
+	};
+
+	if (evsel->fd == NULL || evsel->mmap)
+		return -EINVAL;
+
+	if (perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->fd), xyarray__max_y(evsel->fd)) < 0)
+		return -ENOMEM;
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+			int fd = FD(evsel, cpu, thread);
+			struct perf_mmap *map = MMAP(evsel, cpu, thread);
+
+			if (fd < 0)
+				continue;
+
+			perf_mmap__init(map, NULL, false, NULL);
+
+			ret = perf_mmap__mmap(map, &mp, fd, cpu);
+			if (ret) {
+				perf_evsel__munmap(evsel);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
+{
+	if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
+		return NULL;
+
+	return MMAP(evsel, cpu, thread)->base;
+}
+
 int perf_evsel__read_size(struct perf_evsel *evsel)
 {
 	u64 read_format = evsel->attr.read_format;
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 1ffd083b235e..1c067d088bc6 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -41,6 +41,7 @@ struct perf_evsel {
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
+	struct xyarray		*mmap;
 	struct xyarray		*sample_id;
 	u64			*id;
 	u32			 ids;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index c82ec39a4ad0..60eae25076d3 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -27,6 +27,9 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
 LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
+LIBPERF_API void perf_evsel__munmap(struct perf_evsel *evsel);
+LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 7be1af8a546c..c0c7ceb11060 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -23,6 +23,9 @@ LIBPERF_0.0.1 {
 		perf_evsel__disable;
 		perf_evsel__open;
 		perf_evsel__close;
+		perf_evsel__mmap;
+		perf_evsel__munmap;
+		perf_evsel__mmap_base;
 		perf_evsel__read;
 		perf_evsel__cpus;
 		perf_evsel__threads;
--
2.27.0

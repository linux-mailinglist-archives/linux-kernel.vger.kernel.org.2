Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04223B3D41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhFYHU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhFYHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:20:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6637DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v12so4260738plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PM1wZmAIHYz3Iis81HxDB87rTu4gqdEfBRbfTe1Bky0=;
        b=kuBDYtdjaS1cgSR+dF12K+5Fth8f3GTPOjtKncqZQVAB5V38YBuRQ5hzr7R6wWZ1h+
         n/ko7Q4UEB7rVrfL2W8dybXZtYpdPbTZlgfroiYzXaghg3DdnUa9YRIXJ9K5sl+Bdahq
         42Z/la8uCtrTlp3ribTiy2KfinBg+z/0ggkrhO/ypIvUYF0RKrWJkouXLrzTAfTdW2OB
         9NRUjNoJojfXLfjSam9vPKx/04sgTIPO+Wl7UKDZ/oEBTdZU1VFUi+EXDPl6q5/N44Xy
         XITfVbETGC5qODnP4kTqndrxCxjtzsj+/oexIAecQQm2CEnwbt4tzhUeAmOL/nGs/nWX
         ndSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PM1wZmAIHYz3Iis81HxDB87rTu4gqdEfBRbfTe1Bky0=;
        b=B0YNOmcq5tLciFivueoX8hJZYZe5ob1+koBFm3AYbLq3hKT8KRHoJXTf0uE8Y2rRDD
         y+m4WnMxvLIPsssfQ5tU+M+IwaxL5f46DpkZahH/Y8LbnhHSVx+RGAMRg/5h/EgsetHL
         5ufr1m72zAda5OvL2vtlM9rBgZelMTygToNSC+2S8ZeLZIor1jNPRlCbr/ebCgqI0mSZ
         GMLItd9XqElIN5+7RKCE4Pk7M+6Moc5WtyQyemmbw8oaRtLEEdGBCt7ICh2ZMnxXOGJ+
         sIfN9y1RLHOzRPfCeZ8ptm2+cljuD6+Phod6n6s4SOg9RY+6eM/eykzHMyqj9mDv9AYR
         U2mw==
X-Gm-Message-State: AOAM532TUYswFq2i6a/60dbFCI0Z4qgC4RzDHV0Kx6tvlBTE0CFA9ePB
        zde507N9a8ozuBd7CiG5g6o=
X-Google-Smtp-Source: ABdhPJwPfEn3bG2BdIIFlBtlLZ+fV5B0Vr0zvv2Lq/GPlf938reqJmdbUMAeYWsQJ61QlIHZ/oxwRA==
X-Received: by 2002:a17:90a:3d09:: with SMTP id h9mr19040156pjc.78.1624605512985;
        Fri, 25 Jun 2021 00:18:32 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:1b9c:b593:f9be:6b24])
        by smtp.gmail.com with ESMTPSA id c68sm4759176pfc.75.2021.06.25.00.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:18:32 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 3/4] perf tools: Move common bpf functions to bpf_counter.h
Date:   Fri, 25 Jun 2021 00:18:25 -0700
Message-Id: <20210625071826.608504-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210625071826.608504-1-namhyung@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some helper functions will be used for cgroup counting too.
Move them to a header file for sharing.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter.c | 52 -----------------------------------
 tools/perf/util/bpf_counter.h | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 974f10e356f0..1af81e882eb6 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -7,12 +7,8 @@
 #include <unistd.h>
 #include <sys/file.h>
 #include <sys/time.h>
-#include <sys/resource.h>
 #include <linux/err.h>
 #include <linux/zalloc.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
 #include <api/fs/fs.h>
 #include <perf/bpf_perf.h>
 
@@ -37,13 +33,6 @@ static inline void *u64_to_ptr(__u64 ptr)
 	return (void *)(unsigned long)ptr;
 }
 
-static void set_max_rlimit(void)
-{
-	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
-
-	setrlimit(RLIMIT_MEMLOCK, &rinf);
-}
-
 static struct bpf_counter *bpf_counter_alloc(void)
 {
 	struct bpf_counter *counter;
@@ -297,33 +286,6 @@ struct bpf_counter_ops bpf_program_profiler_ops = {
 	.install_pe = bpf_program_profiler__install_pe,
 };
 
-static __u32 bpf_link_get_id(int fd)
-{
-	struct bpf_link_info link_info = {0};
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.id;
-}
-
-static __u32 bpf_link_get_prog_id(int fd)
-{
-	struct bpf_link_info link_info = {0};
-	__u32 link_info_len = sizeof(link_info);
-
-	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
-	return link_info.prog_id;
-}
-
-static __u32 bpf_map_get_id(int fd)
-{
-	struct bpf_map_info map_info = {0};
-	__u32 map_info_len = sizeof(map_info);
-
-	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
-	return map_info.id;
-}
-
 static bool bperf_attr_map_compatible(int attr_map_fd)
 {
 	struct bpf_map_info map_info = {0};
@@ -385,20 +347,6 @@ static int bperf_lock_attr_map(struct target *target)
 	return map_fd;
 }
 
-/* trigger the leader program on a cpu */
-static int bperf_trigger_reading(int prog_fd, int cpu)
-{
-	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
-			    .ctx_in = NULL,
-			    .ctx_size_in = 0,
-			    .flags = BPF_F_TEST_RUN_ON_CPU,
-			    .cpu = cpu,
-			    .retval = 0,
-		);
-
-	return bpf_prog_test_run_opts(prog_fd, &opts);
-}
-
 static int bperf_check_target(struct evsel *evsel,
 			      struct target *target,
 			      enum bperf_filter_type *filter_type,
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index d6d907c3dcf9..185555a9c1db 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -3,6 +3,10 @@
 #define __PERF_BPF_COUNTER_H 1
 
 #include <linux/list.h>
+#include <sys/resource.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
 
 struct evsel;
 struct target;
@@ -76,4 +80,52 @@ static inline int bpf_counter__install_pe(struct evsel *evsel __maybe_unused,
 
 #endif /* HAVE_BPF_SKEL */
 
+static inline void set_max_rlimit(void)
+{
+	struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
+
+	setrlimit(RLIMIT_MEMLOCK, &rinf);
+}
+
+static inline __u32 bpf_link_get_id(int fd)
+{
+	struct bpf_link_info link_info = {0};
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.id;
+}
+
+static inline __u32 bpf_link_get_prog_id(int fd)
+{
+	struct bpf_link_info link_info = {0};
+	__u32 link_info_len = sizeof(link_info);
+
+	bpf_obj_get_info_by_fd(fd, &link_info, &link_info_len);
+	return link_info.prog_id;
+}
+
+static inline __u32 bpf_map_get_id(int fd)
+{
+	struct bpf_map_info map_info = {0};
+	__u32 map_info_len = sizeof(map_info);
+
+	bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
+	return map_info.id;
+}
+
+/* trigger the leader program on a cpu */
+static inline int bperf_trigger_reading(int prog_fd, int cpu)
+{
+	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
+			    .ctx_in = NULL,
+			    .ctx_size_in = 0,
+			    .flags = BPF_F_TEST_RUN_ON_CPU,
+			    .cpu = cpu,
+			    .retval = 0,
+		);
+
+	return bpf_prog_test_run_opts(prog_fd, &opts);
+}
+
 #endif /* __PERF_BPF_COUNTER_H */
-- 
2.32.0.93.g670b81a890-goog


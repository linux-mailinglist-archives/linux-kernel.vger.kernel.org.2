Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD09323862
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhBXIMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhBXILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:11:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8382C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:11:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o6so815084pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dzvWe5KYzVxUDj8aZ56OYFB3s0MdfMluOZxbIUvjdKI=;
        b=F9knFy/Bn6JVHhao8AV+fSuRF26TCbFpNtORzP6hvfmQc+wBIaCrF9CSEswXZp4uTt
         Z2e+qY/YR59SG27gDDUQVhwIzblj7OAwDP1DEqmUPXnnq1Y2k1GHxsB48L3ZBW81Q8Bw
         OqgWjpqYgP7GjbJhwJf+K3Qke8kPGzX81tNiSUob21MYZBBI0rjlXGr+9eMChaSkAcqL
         LRzCRaJCO/zkY/6bOE4RDHxHRVKVPgRu9EorwIUVmdUHL20iiyfGz8hny+67HW49o59f
         eFuGuQJRwqLdl/s76SIer0OKHEOSpDtItxXgjZWd0zRPGLgW7FopJ1KaAhQHzReiP7jy
         ki2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dzvWe5KYzVxUDj8aZ56OYFB3s0MdfMluOZxbIUvjdKI=;
        b=oQ+LJAR/HBsn0ANDESyYyOkEsd4Z5NBYmCJqO/s5oeEObKoOkmnnGBJVJLXxQeMvfz
         GFAORghC86UPYF1+fVKc3c0lqSM7pT6dNv4kij3gnCYtipCL76ui36qPEXrFl6zMzfav
         8aIbg9ocjVvGD40EGeaneEkoSBhjxK7MFSVEuAXGOUgxOAgP9eNk3UVdymjqlZWXW8GP
         iT1zFJaxLIuU686LdMMBsq9xNIYuUpFLFGWf+B2wYt9mrc5Z2mWYz5IgIGfbnTl6cpIq
         Vh2eKp2QOnf2dkJDlEwQ9ZuJrap9SBSKvXI9BcJuXuW0QrpiBe3trEo4zGSNNmXdfB1S
         28Sg==
X-Gm-Message-State: AOAM533kitNc6TBrkER5+AcRGs+PKpWSNq+3D2TE+mAwXkf/7sO2jEAU
        uAjjddRQG/N4IP6m/AgVnt8=
X-Google-Smtp-Source: ABdhPJwx5vZ2+QpNSX0+vHXXEhu+QdKePj0H3G9iMzWEZZvnDzvHjPzbAU2SdbEhE8XcLTJz8VLfJQ==
X-Received: by 2002:a17:90b:fce:: with SMTP id gd14mr3272496pjb.64.1614154269299;
        Wed, 24 Feb 2021 00:11:09 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id y68sm1607780pgy.5.2021.02.24.00.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:11:08 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] libperf: Add perf_evlist__reset_id_hash()
Date:   Wed, 24 Feb 2021 17:11:02 +0900
Message-Id: <20210224081103.715233-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the perf_evlist__reset_id_hash() function to libperf API so that
it can be called to reset the hash table.  This is necessary for perf
stat to run the workload multiple times.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c              | 13 +++++++++----
 tools/lib/perf/include/perf/evlist.h |  2 ++
 tools/lib/perf/libperf.map           |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 17465d454a0e..a0aaf385cbb5 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -26,13 +26,10 @@
 
 void perf_evlist__init(struct perf_evlist *evlist)
 {
-	int i;
-
-	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
-		INIT_HLIST_HEAD(&evlist->heads[i]);
 	INIT_LIST_HEAD(&evlist->entries);
 	evlist->nr_entries = 0;
 	fdarray__init(&evlist->pollfd, 64);
+	perf_evlist__reset_id_hash(evlist);
 }
 
 static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
@@ -237,6 +234,14 @@ static void perf_evlist__id_hash(struct perf_evlist *evlist,
 	hlist_add_head(&sid->node, &evlist->heads[hash]);
 }
 
+void perf_evlist__reset_id_hash(struct perf_evlist *evlist)
+{
+	int i;
+
+	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
+		INIT_HLIST_HEAD(&evlist->heads[i]);
+}
+
 void perf_evlist__id_add(struct perf_evlist *evlist,
 			 struct perf_evsel *evsel,
 			 int cpu, int thread, u64 id)
diff --git a/tools/lib/perf/include/perf/evlist.h b/tools/lib/perf/include/perf/evlist.h
index 0a7479dc13bf..0085732e8cd9 100644
--- a/tools/lib/perf/include/perf/evlist.h
+++ b/tools/lib/perf/include/perf/evlist.h
@@ -46,4 +46,6 @@ LIBPERF_API struct perf_mmap *perf_evlist__next_mmap(struct perf_evlist *evlist,
 	     (pos) != NULL;						\
 	     (pos) = perf_evlist__next_mmap((evlist), (pos), overwrite))
 
+LIBPERF_API void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 7be1af8a546c..285100143d89 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__munmap;
 		perf_evlist__filter_pollfd;
 		perf_evlist__next_mmap;
+		perf_evlist__reset_id_hash;
 		perf_mmap__consume;
 		perf_mmap__read_init;
 		perf_mmap__read_done;
-- 
2.30.0.617.g56c4b15f3c-goog


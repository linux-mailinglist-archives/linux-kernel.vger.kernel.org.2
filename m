Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5119324999
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhBYDwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBYDwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:52:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D9AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:51:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z7so2456815plk.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=quSx8/uQGkwusmv7fj0KAjzmnoX+tiB0/dVFr2vJaOM=;
        b=mmLJ0Ij3UEDcXh0b6sKryq1pIZ39U7u56VQ4qu9hF+OS5utG0XxnUF/TLAukRlq23T
         2TqYh09L2hmXJO4Ud+2sv66/KTbmeeTENzFLInlj5v3HHif0pC/HODQeJJirAvZkHaW6
         9J7PXa6XV3wurXy8rvGD1AZqeN4PWeCUykLjVX45UvEPL6xFJ0IhX39H7nbsoWUxIK67
         xusyNfHPeaBMFuegGLe4VqSAApArKoT+a0Lii5up2kDcBNh5PhN5RqXgdVB2su5PhM0b
         SA2IFkI6giQs2vpmDqfzF+AhFEhW96YGF4XMoun/Ft/2JcfdMqXk6YibJthJLLomWM97
         k1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=quSx8/uQGkwusmv7fj0KAjzmnoX+tiB0/dVFr2vJaOM=;
        b=VtQRkGkSc9/d2gYySx0edxb1T5YooPxTY/i3l8BdRTnt2UbECvJDPyAc/kVo742cm+
         enr/ZqFF8EzN+4rW57omjT7WT2dFVu0h6QOEh3oAmnaSGdwwbOhpu0hRQy2kTAnF8yQ7
         +X/d+hjo4dTJJrpN5IWO2GwZANevM9KjT8UpwyjtTaT1AppYBx4A3+erV5rTyW9fh2CW
         JNHWPuB1aJlbp9kqgiwOiHmXk3DVbYgsJVhFfvRt6NRoXXTKYOuggdegTKMh0Q3pqkTL
         UyeGfei63+rtLL11QIlORgrZKnsGRoX8/O30UGxk7n60Pttq0K3LAn0z/krtRHwLe7Ba
         HVLQ==
X-Gm-Message-State: AOAM533fvfbHPkeJYIYBwOnw8cEU1Naca8cebN5HqXP6TUX/4DJ0ZJPt
        i8cVL9nFBhk8mWHv/1eUjl0=
X-Google-Smtp-Source: ABdhPJz7Krzo43nUWz65huZsVn+vMGKHi7sjCAWlKzyr0U9IQFnLHLxKGvCbTrAaYbbVoC/8Kl8WmQ==
X-Received: by 2002:a17:902:e289:b029:e3:6915:d51b with SMTP id o9-20020a170902e289b02900e36915d51bmr1294989plc.4.1614225114106;
        Wed, 24 Feb 2021 19:51:54 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id u22sm4357734pgh.20.2021.02.24.19.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 19:51:53 -0800 (PST)
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
Subject: [PATCH v2 1/2] libperf: Add perf_evlist__reset_id_hash()
Date:   Thu, 25 Feb 2021 12:51:47 +0900
Message-Id: <20210225035148.778569-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the perf_evlist__reset_id_hash() function as an internal function
so that it can be called by perf to reset the hash table.  This is
necessary for perf stat to run the workload multiple times.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evlist.c                  | 13 +++++++++----
 tools/lib/perf/include/internal/evlist.h |  2 ++
 2 files changed, 11 insertions(+), 4 deletions(-)

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
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 2d0fa02b036f..212c29063ad4 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -124,4 +124,6 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
 			   struct perf_evsel *evsel,
 			   int cpu, int thread, int fd);
 
+void perf_evlist__reset_id_hash(struct perf_evlist *evlist);
+
 #endif /* __LIBPERF_INTERNAL_EVLIST_H */
-- 
2.30.0.617.g56c4b15f3c-goog


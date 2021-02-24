Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA6323867
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhBXIOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhBXIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:11:59 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C83C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:11:13 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c19so805374pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPbcM8LuM4cAtB4yWT+TjbbkEWdgV1w7GrdCgRKxBz0=;
        b=BVjcwBFdshpQs4J529YD87o4tFpuQZErxF1pHPsxtMI88QqDiuaQOwzmA2EW3s28HH
         cXXnb4zRbMyPtKLTtE5dhtwsbgVmfwq1bdMGAXzzkfYBaXylA74OX7dH3KoIPzoKBF3R
         Yfzn73TWxfVNV6p9C+wwF3miANebwre1TI+82WqPQU0jix6hwn51TLTQaZMb7R1Du4pW
         CFOO0dhlr+dk7rPBglCWyDpyvJPhlpUNmN+cpS5WD/k0/aP6Ce+3/x4WvhldyjybQoiV
         ZHHgbxu2M8GHL8MlHIpPRtAngQC3yAT2B/+H/SxdhjcDSHHdddayAOe3GPXDXrVGgz8r
         GsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qPbcM8LuM4cAtB4yWT+TjbbkEWdgV1w7GrdCgRKxBz0=;
        b=fBZj8M7NQV8JJJua9rKFmplxTY3K+xxh8j3EC98yoPcW0l4f22A1Khl6TlhLVlhXsZ
         Mmiat5UrQd6H/J5ovCjHAWpfGaJMtLZZth5wAEaQu1UpG4fv3jvJSqZQP4d9S1lIfJhj
         /Cs+XWnxTeiY0+9a3/xzVb69pGNOLpB3Bmu+XsWoSPT/vBR8mpodL9RV4mu6rYBPlxNs
         h2JM8hETY6zToHBW/4OzuqtRYkRsCno4++TAP/YACX28ld2axJeSx2O7sEXj4Keh2EuU
         KWrIju/NLAwMAiXascOL2i436+5/u/BTCyYZiq0EvrLAPMunRCZnUEmMhEKaS00cv0J/
         4FLw==
X-Gm-Message-State: AOAM530+88MyJdNQusrYH//civlnfM/fE2+NuH2ZJqZwZle0IBdoWB+t
        BST2IPsVMIvzW/cMiuN0cHY=
X-Google-Smtp-Source: ABdhPJyAz1O2EugtrVYklAjc3Q4OcEPfyILaFObHdbr0U1WP5IggcWPLAgB+CIYOx3WGdlcwZgvFpg==
X-Received: by 2002:a17:90a:cf82:: with SMTP id i2mr3200671pju.209.1614154272481;
        Wed, 24 Feb 2021 00:11:12 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id y68sm1607780pgy.5.2021.02.24.00.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:11:12 -0800 (PST)
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
Subject: [PATCH 2/2] perf stat: Fix segfault when -r option is used
Date:   Wed, 24 Feb 2021 17:11:03 +0900
Message-Id: <20210224081103.715233-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210224081103.715233-1-namhyung@kernel.org>
References: <20210224081103.715233-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a segfault when using -r option with event groups.  The option
makes it run the workload multiple times and it will reuse the evlist
and evsel for each run.

While most of resources are allocated and freed properly, the id hash
in the evlist was not and it resulted in a crash.  You can see it with
the address sanitizer like below:

  $ perf stat -r 100 -e '{cycles,instructions}' true
  =================================================================
  ==693052==ERROR: AddressSanitizer: heap-use-after-free on
      address 0x6080000003d0 at pc 0x558c57732835 bp 0x7fff1526adb0 sp 0x7fff1526ada8
  WRITE of size 8 at 0x6080000003d0 thread T0
    #0 0x558c57732834 in hlist_add_head /home/namhyung/project/linux/tools/include/linux/list.h:644
    #1 0x558c57732834 in perf_evlist__id_hash /home/namhyung/project/linux/tools/lib/perf/evlist.c:237
    #2 0x558c57732834 in perf_evlist__id_add /home/namhyung/project/linux/tools/lib/perf/evlist.c:244
    #3 0x558c57732834 in perf_evlist__id_add_fd /home/namhyung/project/linux/tools/lib/perf/evlist.c:285
    #4 0x558c5747733e in store_evsel_ids util/evsel.c:2765
    #5 0x558c5747733e in evsel__store_ids util/evsel.c:2782
    #6 0x558c5730b717 in __run_perf_stat /home/namhyung/project/linux/tools/perf/builtin-stat.c:895
    #7 0x558c5730b717 in run_perf_stat /home/namhyung/project/linux/tools/perf/builtin-stat.c:1014
    #8 0x558c5730b717 in cmd_stat /home/namhyung/project/linux/tools/perf/builtin-stat.c:2446
    #9 0x558c57427c24 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #10 0x558c572b1a48 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #11 0x558c572b1a48 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #12 0x558c572b1a48 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #13 0x7fcadb9f7d09 in __libc_start_main ../csu/libc-start.c:308
    #14 0x558c572b60f9 in _start (/home/namhyung/project/linux/tools/perf/perf+0x45d0f9)

Actually the nodes in the hash table are struct perf_stream_id and
they were freed in the previous run.  Fix it by resetting the hash.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5121b4db66fe..882cd1f721d9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1306,6 +1306,7 @@ void evlist__close(struct evlist *evlist)
 		perf_evsel__free_fd(&evsel->core);
 		perf_evsel__free_id(&evsel->core);
 	}
+	perf_evlist__reset_id_hash(&evlist->core);
 }
 
 static int evlist__create_syswide_maps(struct evlist *evlist)
-- 
2.30.0.617.g56c4b15f3c-goog


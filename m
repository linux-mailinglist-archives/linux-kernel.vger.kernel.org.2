Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427B532499A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhBYDww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbhBYDwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:52:38 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEC2C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:51:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h4so2884417pgf.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEuUr9VNbOHpA/0hjczpQ7Dj4IS4s74Bjtg1fR/tu8c=;
        b=Do/d4fbTOdEIKtXhhgkYxc8cfwm8TPSQKXkafQ9sxiHUHnW5ND+Q1JECHVP2b8sQK8
         0N9HSL9j3aKpce3vULyosIebwGxdCrhzvqIGOiVSDZbpYnnnqGARYDeKj9URQxeabSvS
         QD9INYdlz6yg5xcLLekuEUgacsLyMOkH1KCYGftH9XgKwTFx0vPDx5jJ0Tpb6SQeP5/g
         ltBznXnLHgM4Kc21j5O6e4Zv9/HBb9wnbBcg1ccvJw0bslzs8mF3pR10uNZsrvwAdhBY
         my2J/Vi3xMtWMMm8NfcHSXJ1OdECYzMsxbatljXIKXWC1/H3bp7HuHzg+WMaXSBXJq46
         mqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TEuUr9VNbOHpA/0hjczpQ7Dj4IS4s74Bjtg1fR/tu8c=;
        b=CrAyBuTowWqlDBIUvMCmtIz08jsYg0w871ZWUpcMPrOT73NbGajzpPuEl7+YFgGeiA
         fKHGXtyujp1iT79o6HbwF0n2IUteYe62GTKNJeZRg6s7a2ehN9nOCP2qz6dqeR0QRVx2
         /we1sKVjEQ68O3lc4nPmVo7X1HLJmAwCdcbfuHO6vMSlQPTM9YKm63Ujkrl5hxf6YClf
         tErN2QChLlN9Dkh7zmUesofDhIPclKsL4+TNCrKvbfV0XueB80yOKv8k3T2U5SZvmBi6
         o7lOBbNV1Rh8GMNHkf/7B0kq54KZ8kzvDmDMvOqMYw4WwcC6HK2L7sEITk38OuKSM3TX
         twgA==
X-Gm-Message-State: AOAM533zRhEzxUrB3kvfPsVNwTQHLYGMJ7D8svF3/kA8A5I2UrLetDSI
        bVIJdTXgEhhb/t85C/zMIQc=
X-Google-Smtp-Source: ABdhPJx3fIXqQEpguV9Wqcvlu5nT4FFchZWPYgFyyGI47Sw7+wu3wAd/yoAvsxy7i9qJ9y7hcQQznw==
X-Received: by 2002:a63:194c:: with SMTP id 12mr1177041pgz.198.1614225117359;
        Wed, 24 Feb 2021 19:51:57 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id u22sm4357734pgh.20.2021.02.24.19.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 19:51:56 -0800 (PST)
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
Subject: [PATCH v2 2/2] perf stat: Fix use-after-free when -r option is used
Date:   Thu, 25 Feb 2021 12:51:48 +0900
Message-Id: <20210225035148.778569-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
In-Reply-To: <20210225035148.778569-1-namhyung@kernel.org>
References: <20210225035148.778569-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a segfault when using -r option with event groups.  The option
makes it run the workload multiple times and it will reuse the evlist
and evsel for each run.

While most of resources are allocated and freed properly, the id hash
in the evlist was not and it resulted in the bug.  You can see it with
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


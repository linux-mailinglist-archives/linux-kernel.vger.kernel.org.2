Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B836BCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhD0BiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhD0BiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:38:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA229C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v20so3718086qkv.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FJWJCHhnqSjdmTRAsm6adaBw4EEr/lvQQJJiey1u4/U=;
        b=d6HQzQUTpAetxSdGmQHEjd+KRyVq2LDyZVdO3wU2V9zmKXozbdaFzQXvOmoN6TyVh2
         La4fgit0IgVTUHEKt8WDEG8XtWTLqJ7GU/przYelBeoor9/pICMraSRZE2VBrhGK48jZ
         yffEf56I5tlTo2//f+luuzUoBOtcWMiRMnRFl17z4xgMvbFdI1rQ7MyqkhGjLR/i/Coz
         RP5MQcO64avBZK0LWuTwulTXmI1c0ykxXRxpevjsSLKkm9Fm8fvZ64BapcwCAHPh3G2r
         hqYqvDv5UIUuAc9P5t6h2cRc0FHOZRiKjgfR/PA/5ZEslUxLvEcqBz2zFlIt5SXMvVVx
         9tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FJWJCHhnqSjdmTRAsm6adaBw4EEr/lvQQJJiey1u4/U=;
        b=Tuov1pOw+tlqmJeSubdvx+4PxbdPYH2PkTZqU9K8flFFTgbiYr8loXp0oH0dDwWeCA
         /tnzhc5LIjOWR9v18U5gh29smnHMQbICzxRhyRSyM3cML/OeHMVTgfcOQJuVubE7SMZF
         RGLabouFxoRx/eO7XEzAf4F3ObBJq2rG4WqLF9pE2HEKK52QffQrXqaO/6VnDlBOccut
         VugsIAKIXDC3sVmK9QWTuIm8z7B9dxGATIpdod2NcZxiWcDD9E7ItEqSVadUPVZWeLWN
         DdqJ+fMlHo339iO557yubzHum1ZP1xueX5SZ3S8//6U9pfGtmFsm3JekO6fJH2+tv7Ft
         UwBw==
X-Gm-Message-State: AOAM532puh/ARqR68CAc4Cuwo+o0h1Gn/TCK/AHngprOz+HTCNbkP9fM
        DSkFv3DoxyVB5DlC6IbxADo=
X-Google-Smtp-Source: ABdhPJxbiGmytNY7EERI+24RsuqkHMYe3a3G/X/UatHSu/dFJ3ICg7By6dXUshcS703Tqd9yOuhsrg==
X-Received: by 2002:ae9:e8c6:: with SMTP id a189mr20868360qkg.463.1619487441099;
        Mon, 26 Apr 2021 18:37:21 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id q67sm1858622qkb.89.2021.04.26.18.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:37:20 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET v2 0/6] perf report: Make --stat output more compact
Date:   Mon, 26 Apr 2021 18:37:11 -0700
Message-Id: <20210427013717.1651674-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset changes the output of perf report --stat.

Changes from v1)
 * fix build error in TUI  (Jiri)
 * print percentage of each event  (Andi)


The perf report --stat shows event statistics like below:

  $ perf report --stat

  Aggregated stats:
             TOTAL events:      20064
              MMAP events:        239
              LOST events:          0
              COMM events:       1518
              EXIT events:          1
          THROTTLE events:          0
        UNTHROTTLE events:          0
              FORK events:       1517
              READ events:          0
            SAMPLE events:       4015
             MMAP2 events:      12769
               AUX events:          0
      ITRACE_START events:          0
      LOST_SAMPLES events:          0
            SWITCH events:          0
   SWITCH_CPU_WIDE events:          0
        NAMESPACES events:          0
           KSYMBOL events:          0
         BPF_EVENT events:          0
            CGROUP events:          0
         TEXT_POKE events:          0
              ATTR events:          0
        EVENT_TYPE events:          0
      TRACING_DATA events:          0
          BUILD_ID events:          0
    FINISHED_ROUND events:          2
          ID_INDEX events:          0
     AUXTRACE_INFO events:          0
          AUXTRACE events:          0
    AUXTRACE_ERROR events:          0
        THREAD_MAP events:          1
           CPU_MAP events:          1
       STAT_CONFIG events:          0
              STAT events:          0
        STAT_ROUND events:          0
      EVENT_UPDATE events:          0
         TIME_CONV events:          1
           FEATURE events:          0
        COMPRESSED events:          0

But it's too long and mostly 0 so we can make it more compact.  Also
perf report -D has similar output at the end with each event's sample
count.  It'd be better if we can have the same output in both case.

So I added --skip-empty (and --no-skip-empty automatically) to suppres
the 0 output and add the event stats like below.

  $ perf report --stat --skip-empty
  
  Aggregated stats:
             TOTAL events:      20064
              MMAP events:        239  ( 1.2%)
              COMM events:       1518  ( 7.6%)
              EXIT events:          1  ( 0.0%)
              FORK events:       1517  ( 7.6%)
            SAMPLE events:       4015  (20.0%)
             MMAP2 events:      12769  (63.6%)
    FINISHED_ROUND events:          2  ( 0.0%)
        THREAD_MAP events:          1  ( 0.0%)
           CPU_MAP events:          1  ( 0.0%)
         TIME_CONV events:          1  ( 0.0%)
  cycles stats:
            SAMPLE events:       2475
  instructions stats:
            SAMPLE events:       1540


And I make it enabled by default with a new config option
report.skip-empty to change the behavior if needed.

Thanks,
Namhyung


Namhyung Kim (6):
  perf top: Use evlist->events_stat to count events
  perf hists: Split hists_stats from events_stats
  perf report: Show event sample counts in --stat output
  perf report: Add --skip-empty option to suppress 0 event stat
  perf report: Make --skip-empty as default
  perf report: Print percentage of each event statistics

 tools/perf/Documentation/perf-config.txt |  5 ++++
 tools/perf/Documentation/perf-report.txt |  3 ++
 tools/perf/builtin-annotate.c            |  6 ++--
 tools/perf/builtin-report.c              | 38 ++++++++++++++++++++----
 tools/perf/builtin-top.c                 | 20 +++++--------
 tools/perf/tests/hists_filter.c          | 14 ++++-----
 tools/perf/ui/browsers/hists.c           | 17 ++++++-----
 tools/perf/ui/stdio/hist.c               | 15 ++++++++--
 tools/perf/util/events_stats.h           | 13 +++++---
 tools/perf/util/hist.c                   | 26 +++++++++++-----
 tools/perf/util/hist.h                   |  7 +++--
 tools/perf/util/session.c                |  5 ++--
 tools/perf/util/session.h                |  3 +-
 13 files changed, 118 insertions(+), 54 deletions(-)

base-commit: 4c391ea001cb2e7bd9a691a886c0dcb030c1791c
-- 
2.31.1.527.g47e6f16901-goog


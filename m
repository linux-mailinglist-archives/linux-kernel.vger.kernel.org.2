Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F0369994
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbhDWS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhDWS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:28:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:16 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 66so10975063qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3zIZ1hM+Jn1OYfgCtlQ/Q6D+VxX7Q4phXejQ1sUS90=;
        b=NEl67M8j7CHkeOjHd+JtlOCDLWN3e6XP4W3Sts+yjTgcAFeSK+6Oda9VcdJn1L0KOT
         cw8yIRnowDxXFrtFlc5ygCMyKRnhRWoGNNNVjnoJVWCu/4758TAo3v58xxphu6OamFvY
         CT2f38R8FBq4g1kCwgvdmF9owlERdtQSy8hgIk98eK+PsdGkF94dmWg7vfGWwPxHDwem
         MP4xQaqu/V+9wsKtoGtxoTM2SGu6bDRnFYOJAew8d9IIDiwTMjKUTMD/WXT09S5uwm/a
         jERss2Lu2BI9c2Cv7nMWTrKIxU9dpGa8koV//TshWQAL8xfw+Kq8isfkkK9o7a+oH/1z
         nGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Y3zIZ1hM+Jn1OYfgCtlQ/Q6D+VxX7Q4phXejQ1sUS90=;
        b=DV9o7i6V2Fs8Hg12OSebasrjuxrTmpJ7pv7/5WVgpzY0YTHZ02qhcge6Vkc799AwoY
         4dqbCXiDNZUP43MgkC2XQkbEUamkfUgUT1q/IKQZsJhW4uInFH7xqr69uwQEVFySksnl
         GbatWKmh959y13Is6U+Plx44k/S4vPWKflk41boyh9r3ndb9BCnKxOuPBe2G7B3jo0MM
         d4s1VUOveKlcwduZT+oCc3IyOsSt6y7teC6dbUtA06ZoN2rWJunnaAazBc2XUywzjEPV
         RlSwlY0QMLToZM571MYc4el6vmUtfT4q8peg2czoC1DHv1SI4GrnJWaeB1P3WDLiyHru
         X4Mw==
X-Gm-Message-State: AOAM530BirkAAYk6ivQuApmqpuJRiytCkxtooZH5En17qBEGeMLBY1/L
        MWA4oPmpZNR47E5b7RLofk8=
X-Google-Smtp-Source: ABdhPJycaJdTBomMxoTSRXR9j6K4WaelzhC6o58iaiQN1V0fppGDdCC4PfmaJpufT9/E8SYT1OuLnA==
X-Received: by 2002:a05:620a:210c:: with SMTP id l12mr5428498qkl.421.1619202495988;
        Fri, 23 Apr 2021 11:28:15 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id c5sm4783863qkl.7.2021.04.23.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:28:15 -0700 (PDT)
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
Subject: [PATCHSET 0/5] perf report: Make --stat output more compact
Date:   Fri, 23 Apr 2021 11:28:08 -0700
Message-Id: <20210423182813.1472902-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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
              MMAP events:        239
              COMM events:       1518
              EXIT events:          1
              FORK events:       1517
            SAMPLE events:       4015
             MMAP2 events:      12769
    FINISHED_ROUND events:          2
        THREAD_MAP events:          1
           CPU_MAP events:          1
         TIME_CONV events:          1
  cycles stats:
            SAMPLE events:       2475
  instructions stats:
            SAMPLE events:       1540


And I make it enabled by default with a new config option
report.skip-empty to change the behavior if needed.

Thanks,
Namhyung


Namhyung Kim (5):
  perf top: Use evlist->events_stat to count events
  perf hists: Split hists_stats from events_stats
  perf report: Show event sample counts in --stat output
  perf report: Add --skip-empty option to suppress 0 event stat
  perf report: Make --skip-empty as default

 tools/perf/Documentation/perf-config.txt |  5 ++++
 tools/perf/Documentation/perf-report.txt |  3 ++
 tools/perf/builtin-annotate.c            |  6 ++--
 tools/perf/builtin-report.c              | 38 ++++++++++++++++++++----
 tools/perf/builtin-top.c                 | 20 +++++--------
 tools/perf/tests/hists_filter.c          | 14 ++++-----
 tools/perf/ui/stdio/hist.c               |  5 +++-
 tools/perf/util/events_stats.h           | 13 +++++---
 tools/perf/util/hist.c                   | 26 +++++++++++-----
 tools/perf/util/hist.h                   |  7 +++--
 tools/perf/util/session.c                |  5 ++--
 tools/perf/util/session.h                |  3 +-
 12 files changed, 100 insertions(+), 45 deletions(-)


base-commit: 4c391ea001cb2e7bd9a691a886c0dcb030c1791c
-- 
2.31.1.498.g6c1eba8ee3d-goog


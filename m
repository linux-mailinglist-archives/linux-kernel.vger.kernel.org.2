Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04493D9D99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhG2GZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbhG2GZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:25:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB914C061765
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:24:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q3-20020a25bfc30000b02905592911c932so5073005ybm.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ig9yW7AlFooz6SNIp+N282gcWud42g+mhGkhzdDB7tI=;
        b=lrIJ/pv4DloBVMTY1khfGSy/+pq02J6sjkcOee8earL4Fik5brTIEk2vKuoaWhoIqm
         shXrxpP0h/A+s/3pyhyp91mOhsM5OWizb4oTAA+4tBlMyVafLaHHRQ+WtPBd0+8fZfqs
         mBixU04IXw36jyLCcJKwRu9eMoGl5FOQEahwLfwOKfP1j8L+PbGG6BT4htpfL7q8CRV9
         uEzUIB1sliUANlzleZdqOOB4TAKmbKUGsCv9qmE/b61aQbuito49UYIqkWplS+AAcRgL
         pi64F+2F+LB5l8VmEF5IKh8VYXxfqLO/1EYch/WKJ2YqAc/lhwpH6BDko+bTAiIj8gTL
         AyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ig9yW7AlFooz6SNIp+N282gcWud42g+mhGkhzdDB7tI=;
        b=FMGK/tO3Exbx2xDYnRDpEPQ3Q1OYzx09m+epKkyjnJcEpN/shvUsigz879yZ/PUlOj
         K42IvEctyeoDuyLYMUWG0hf94mj4ycwlnS1dTkiHBI5/GI6JWffMrBoxvKk8t38bzQSU
         wPvM1VaYcHujPeceCR6Y+WxK3JD0c2XW2F/gL8e5Errp/Bg8ljVSVb8r+tOsP41G8/3c
         hMeX5AojcHiufCsWDZ8iKDvDYItoV2a1WyTVcGWIfIcxG9vPxMVaYPgjtZdFoTimDy+D
         gxV1M7XSOCe+ApfnW2a/bS0sdR9lGobBdBYgiktLGUrxzyJD2XT2WKIEsZtyCMMBxOyP
         Rckw==
X-Gm-Message-State: AOAM532KgwOMJhTiOZDX2S+0IqhWfUngkDVF5UASgQzLjiVAkHsAhNH7
        R73UpbR4byRh+TKEn3fi+v9JpUTwFPlM
X-Google-Smtp-Source: ABdhPJz9DrxxrrXYPmbwWmgcXIRMX6CXL6KQNcCisIOTudiMM4HcG37hQKNEYs8qCG/Gf15tSh5yf/PNVNNo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8f98:bc28:73a6:e8c9])
 (user=irogers job=sendgmr) by 2002:a25:b810:: with SMTP id
 v16mr4917039ybj.357.1627539897036; Wed, 28 Jul 2021 23:24:57 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:24:48 -0700
Message-Id: <20210729062451.1349566-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 0/3] Some exit code tidying
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm interested in varying error codes for things like parse event
failures. This is some cleanup to use more intention revealing names
in the existing exit/test cases.

Ian Rogers (3):
  libperf: Prefer exit(EXIT_SUCCESS) over exit(0)
  tools perf: Prefer exit(EXIT_*) over exit(0|1)
  perf test: Be more consistent in use of TEST_*

 tools/lib/perf/tests/test-evlist.c          |   2 +-
 tools/perf/arch/x86/tests/bp-modify.c       |   4 +-
 tools/perf/arch/x86/tests/rdpmc.c           |   8 +-
 tools/perf/bench/inject-buildid.c           |   8 +-
 tools/perf/bench/numa.c                     |   2 +-
 tools/perf/bench/sched-messaging.c          |   6 +-
 tools/perf/bench/sched-pipe.c               |   4 +-
 tools/perf/bench/syscall.c                  |   2 +-
 tools/perf/builtin-c2c.c                    |   2 +-
 tools/perf/builtin-ftrace.c                 |   2 +-
 tools/perf/builtin-mem.c                    |   2 +-
 tools/perf/builtin-script.c                 |   4 +-
 tools/perf/perf.c                           |   8 +-
 tools/perf/tests/attr.c                     |   2 +-
 tools/perf/tests/bitmap.c                   |   2 +-
 tools/perf/tests/bp_account.c               |   4 +-
 tools/perf/tests/bp_signal.c                |  51 +++++++--
 tools/perf/tests/code-reading.c             |  12 +-
 tools/perf/tests/cpumap.c                   |  10 +-
 tools/perf/tests/dso-data.c                 |   8 +-
 tools/perf/tests/dwarf-unwind.c             |  14 ++-
 tools/perf/tests/event-times.c              |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c     |  14 +--
 tools/perf/tests/evsel-tp-sched.c           |  28 ++---
 tools/perf/tests/expr.c                     |   4 +-
 tools/perf/tests/fdarray.c                  |   4 +-
 tools/perf/tests/genelf.c                   |   2 +-
 tools/perf/tests/hists_cumulate.c           |   2 +-
 tools/perf/tests/hists_filter.c             |  12 +-
 tools/perf/tests/hists_link.c               |  33 +++---
 tools/perf/tests/keep-tracking.c            |   4 +-
 tools/perf/tests/kmod-path.c                |   6 +-
 tools/perf/tests/mem.c                      |   4 +-
 tools/perf/tests/mem2node.c                 |   2 +-
 tools/perf/tests/mmap-basic.c               |  10 +-
 tools/perf/tests/mmap-thread-lookup.c       |   2 +-
 tools/perf/tests/openat-syscall-all-cpus.c  |   4 +-
 tools/perf/tests/openat-syscall-tp-fields.c |   4 +-
 tools/perf/tests/openat-syscall.c           |   6 +-
 tools/perf/tests/parse-events.c             | 118 ++++++++++----------
 tools/perf/tests/parse-metric.c             |  16 +--
 tools/perf/tests/parse-no-sample-id-all.c   |   4 +-
 tools/perf/tests/perf-hooks.c               |   2 +-
 tools/perf/tests/perf-record.c              |   2 +-
 tools/perf/tests/perf-time-to-tsc.c         |   4 +-
 tools/perf/tests/pfm.c                      |   4 +-
 tools/perf/tests/pmu-events.c               |  36 +++---
 tools/perf/tests/pmu.c                      |  16 +--
 tools/perf/tests/python-use.c               |   2 +-
 tools/perf/tests/sample-parsing.c           |  10 +-
 tools/perf/tests/stat.c                     |  12 +-
 tools/perf/tests/sw-clock.c                 |   8 +-
 tools/perf/tests/switch-tracking.c          |   9 +-
 tools/perf/tests/task-exit.c                |  12 +-
 tools/perf/tests/tests.h                    |   4 +-
 tools/perf/tests/thread-map.c               |   8 +-
 tools/perf/tests/thread-maps-share.c        |   2 +-
 tools/perf/tests/time-utils-test.c          |   2 +-
 tools/perf/tests/topology.c                 |   2 +-
 tools/perf/tests/vmlinux-kallsyms.c         |   6 +-
 tools/perf/tests/wp.c                       |  10 +-
 tools/perf/ui/tui/setup.c                   |   4 +-
 tools/perf/util/dlfilter.c                  |   2 +-
 tools/perf/util/help-unknown-cmd.c          |   2 +-
 64 files changed, 319 insertions(+), 278 deletions(-)

-- 
2.32.0.432.gabb21c7263-goog


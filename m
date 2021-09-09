Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64A940469D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhIIH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhIIH7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:59:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE5C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 63-20020a250d42000000b0059dc43162c9so1344250ybn.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AtUZacpy/bU92O3RymiZtFNlft9/Vg66zo3tmV1EZjA=;
        b=GQhVraW7EfDOpbuYOojbF+/kVtp+fRcvQ5eejljiRfqOqqhNT7DhTmHBuBwSC/KlXr
         9+3MEa2OUQfz8fBBbotzRJl/5F9l4g884vNWI5+zAR6NuEq8JCY99ZRYX3aNdf7KkxZ8
         2THk72Kmjni8zlj6bAsKGauyy6UmNYEnBsgnivH9nFvZ2FuX1q9rhaHRx6O+dn12WM2W
         cD3FluuFkY0kbqkCVp+Q59ll7qKb2wUvw9ulou6yHmaEF4Pgdgf7VkfPJJZbeiTvsIa2
         PLEY05R2/lN8RBIbR/ocQJuiYjeRUgC1LHpbzsgxTW8TaRZ0JIpQv0wjMfgz2v4RMZkf
         956A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AtUZacpy/bU92O3RymiZtFNlft9/Vg66zo3tmV1EZjA=;
        b=MciIBAMxMJZ0aHaYMrdhvMzN6Af5/fN12uWzwfFbJkDkan5Bl811h5ifLgu324SWQ+
         An35bNUN+ohLAyWzu+bjQVtKoaka5e2/LrDfKs9FUgManDW9dHVDZ7ylhC14ftrfDpHZ
         hLANk/KRiKzB0DDLLBN4070LFvC6xKsYBPzfub4kJBXe5iBpwFr7uvQSvlunbg/2Qhir
         ptrvQqJptwlTS+PZMKmwi+r93kDzrV/mkuLFm9acZHbv+pQlZgG3W2KZX0PHD/uUV7bV
         OSTuUnFn9f9iItXyT3aEU9HxLGxBLKRCOUGdeLEKQvyZXMeHJNWG7SQpaAMe/BjZS27r
         GTRg==
X-Gm-Message-State: AOAM530JIvuV3LwRNy0E40P8LQuaxNaK/8e3thXa/6HDP8YKvNsX74Fm
        dONPF7jJgB+qi2hSrvj1mtF8Rsc6kYm62M4d38BgaDGsLVLFv56Qt5HM9o1E1fFoRD5zwCvBNDa
        DnzyMVRQdY3Ro6myYExgkvd+00kjT0VG6H25STW4gtP7voDsDpEuN0XPQzibeuoZ4pTU/9Tyw
X-Google-Smtp-Source: ABdhPJzuiehIbBgOqQ9dygHrEbE7zIPZTpvmTJKzOHhWIguGcVP4X3ynLuHC9wU3LF/aAYCcol7mSP/YrGCo
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:be44:: with SMTP id
 d4mr2160983ybm.461.1631174317870; Thu, 09 Sep 2021 00:58:37 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:47 -0700
Message-Id: <20210909075700.4025355-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the AMD Fam19h 16-deep branch sampling
feature as described in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13.
This is a model specific extension. It is not an architected AMD feature.

The Branch Sampling Feature (BRS) provides the statistical taken branch information necessary
to enable autoFDO-style optimization by compilers, i.e., basic block execution counts.

BRS operates with a 16-deep saturating buffer in MSR registers. There is no
hardware branch type filtering. All control flow changes are captured. BRS
relies on specific programming of the core PMU of Fam19h.  In particular,
the following requirements must be met:
 - the sampling period be greater than 16 (BRS depth)
 - the sampling period must use fixed and not frequency mode

BRS interacts with the NMI interrupt as well. Because enabling BRS is expensive,
it is only activated after P event occurrences, where P is the desired sampling period.
At P occurrences of the event, the counter overflows, the CPU catches the NMI interrupt,
activates BRS for 16 branches until it saturates, and then delivers the NMI to the kernel.
Between the overflow and the time BRS activates more branches may be executed skewing the period.
All along, the sampling event keeps counting. The skid may be attenuated by reducing the sampling
period by 16.

BRS is integrated into perf_events seamlessly via the same PERF_RECORD_BRANCH_STACK sample
format. BRS generates branch perf_branch_entry records in the sampling buffer. There is
no prediction or latency information supported. The branches are stored in reverse order of
execution.  The most recent branch is the first entry in each record.

Because BRS must be stopped when a CPU goes into low power mode, the series includes patches
to add callbacks on low power entry and exit (mwait and halt).

Given that there is no privilege filterting with BRS, the kernel implements filtering on
privlege level.

This version adds a few simple modifications to perf record and report.
1. add the branch-brs event as a builtin such as it can used directly: perf record -e branch-brs ...
2. improve error handling for AMD IBS and is contributed by Kim Phillips.
3. use the better error handling to improve error handling for branch sampling
4. add two new sort dimensions to help display the branch sampling information. Because there is no
   latency information associated with the branch sampling feature perf report would collapse all
   samples within a function into a single histogram entry. This is expected because the default
   sort mode for PERF_SAMPLE_BRANCH_STACK is symbol_from/symbol_to. This propagates to the annotation.

For more detailed view of the branch samples, the new sort dimensions addr_from,addr_to can be used
instead as follows:

$ perf report --sort=overhead,comm,dso,addr_from,addr_to 
# Overhead  Command          Shared Object     Source Address  Target Address
# ........  ...............  ................  ..............  ..............
#
     4.21%  test_prg        test_prg         [.] test_threa+0x3c  [.] test_threa+0x4
     4.14%  test_prg        test_prg         [.] test_threa+0x3e  [.] test_threa+0x2
     4.10%  test_prg        test_prg         [.] test_threa+0x4  [.] test_threa+0x3a
     4.07%  test_prg        test_prg         [.] test_threa+0x2  [.] test_threa+0x3c

Versus the default output:

$ perf report 
# Overhead  Command          Source Shared Object  Source Symbol                        Target Symbol                        Basic Block Cycles
# ........  ...............  ....................  ...................................  ...................................  ..................
#
    99.52%  test_prg        test_prg             [.] test_thread                      [.] test_thread                      -                 

BRS can be used with any sampling event. However, it is recommended to use the RETIRED_BRANCH
event because it matches what the BRS captures. For convenience, a pseudo event matching the
branches captured by BRS is exported by the kernel (branch-brs):

$ perf record -b -e cpu/branch-brs/ -c 1000037 test

$ perf report -D
56531696056126 0x193c000 [0x1a8]: PERF_RECORD_SAMPLE(IP, 0x2): 18122/18230: 0x401d24 period: 1000037 addr: 0
... branch stack: nr:16
.....  0: 0000000000401d24 -> 0000000000401d5a 0 cycles      0
.....  1: 0000000000401d5c -> 0000000000401d24 0 cycles      0
.....  2: 0000000000401d22 -> 0000000000401d5c 0 cycles      0
.....  3: 0000000000401d5e -> 0000000000401d22 0 cycles      0
.....  4: 0000000000401d20 -> 0000000000401d5e 0 cycles      0
.....  5: 0000000000401d3e -> 0000000000401d20 0 cycles      0
.....  6: 0000000000401d42 -> 0000000000401d3e 0 cycles      0
.....  7: 0000000000401d3c -> 0000000000401d42 0 cycles      0
.....  8: 0000000000401d44 -> 0000000000401d3c 0 cycles      0
.....  9: 0000000000401d3a -> 0000000000401d44 0 cycles      0
..... 10: 0000000000401d46 -> 0000000000401d3a 0 cycles      0
..... 11: 0000000000401d38 -> 0000000000401d46 0 cycles      0
..... 12: 0000000000401d48 -> 0000000000401d38 0 cycles      0
..... 13: 0000000000401d36 -> 0000000000401d48 0 cycles      0
..... 14: 0000000000401d4a -> 0000000000401d36 0 cycles      0
..... 15: 0000000000401d34 -> 0000000000401d4a 0 cycles      0
 ... thread: test:18230
 ...... dso: test

Special thanks to Kim Phillips @ AMD for the testing, reviews and contributions.

Kim Phillips (1):
  perf tools: improve IBS error handling

Stephane Eranian (12):
  perf/core: add union to struct perf_branch_entry
  x86/cpufeatures: add AMD Fam19h Branch Sampling feature
  perf/x86/amd: add AMD Fam19h Branch Sampling support
  perf/x86/amd: add branch-brs helper event for Fam19h BRS
  perf/x86/amd: enable branch sampling priv level filtering
  perf/x86/amd: add AMD branch sampling period adjustment
  perf/core: add idle hooks
  perf/x86/core: add idle hooks
  perf/x86/amd: add idle hooks for branch sampling
  perf tools: add branch-brs as a new event
  perf tools: improve error handling of AMD Branch Sampling
  perf report: add addr_from/addr_to sort dimensions

 arch/x86/events/amd/Makefile       |   2 +-
 arch/x86/events/amd/brs.c          | 342 +++++++++++++++++++++++++++++
 arch/x86/events/amd/core.c         | 222 ++++++++++++++++++-
 arch/x86/events/core.c             |  22 +-
 arch/x86/events/intel/lbr.c        |  13 +-
 arch/x86/events/perf_event.h       | 106 +++++++--
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/msr-index.h   |   4 +
 arch/x86/include/asm/mwait.h       |   6 +-
 include/linux/perf_event.h         |   8 +
 include/uapi/linux/perf_event.h    |  19 +-
 kernel/events/core.c               |  58 +++++
 kernel/sched/idle.c                |  19 +-
 tools/perf/util/evsel.c            |  50 +++++
 tools/perf/util/hist.c             |   2 +
 tools/perf/util/hist.h             |   2 +
 tools/perf/util/parse-events.l     |   1 +
 tools/perf/util/sort.c             | 128 +++++++++++
 tools/perf/util/sort.h             |   2 +
 19 files changed, 964 insertions(+), 43 deletions(-)
 create mode 100644 arch/x86/events/amd/brs.c

-- 
2.33.0.153.gba50c8fa24-goog


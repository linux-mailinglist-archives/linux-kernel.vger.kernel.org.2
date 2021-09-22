Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8960E414396
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhIVIVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhIVIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:21:34 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15F9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:20:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id m26-20020ac87b5a000000b002a6b3744ae6so1306969qtu.22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KhEOVDh5xBwdR6E0McNSkMxXx4DtQkSqGqlUPDV4Oz8=;
        b=ajtll/hE+SdlHmRQaIxAQ28nCxwVV1hOI1A/1IKZcGgcfUPcWAh7hoMvnaOf0hrGjF
         HJ2k9lbug/vVAKK5fIT/tDI0PJ0M5Z7kWIU9Lv6R0RH42PuzLWGhCPOEFuG+3dy+p0JE
         bV+BsNWoWcLqJLdzN5ObO1C0YbKZfKXugG37yUOrkzjW2ueOKGSzQjOnZAgw9kMg+IKk
         Fq83SlybD4SaoCI0mRZ3tx8qALO9rgc/O37jRnbHVPLnv0ecI3sZ2GVvimgrCOnZLh28
         4SyN/lfsjXbr2rRrKYtY3wjEQ8aJ8CTqB6NP7u87s94MKSyeArjPyK6H8mygfMLIJNLq
         KwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KhEOVDh5xBwdR6E0McNSkMxXx4DtQkSqGqlUPDV4Oz8=;
        b=r4E9Mioa0iPLtGyRZkYyhEkmSyJggHPlRVpisrm9tCm8YMXG5blP9EAdDqin/3cnDY
         urDrNJy60NEYgYW0aUgqSyaBh3QuNF6T5WdrYkN0g0PZB1xzQv9CS7vxjZjgu+T1gCy2
         gXQQURN97lH9VFvfXaCNIkvhRdyzD012teem5ppphXhFPr7/7iSbt1EbawjzpxAvPCOm
         92hJ8RpW2qZ0TJ2Cae2St+4Nb9mb8T5wpFeMe6upOakbjgr+i+pSQkz0j3kcWwW7KNPW
         WfTcZ5Fba0KHYeWzwZqEKqp6lBtujtcRLsz5UZsry4ljuRmJYZhvkhkPMG0NJjNFi7Fm
         SxPg==
X-Gm-Message-State: AOAM531NxN+1t5LKsormeqB6P6e2/SSnxcZa9OQStARu2Vq1aCCCuI+X
        QTTjjigJuq7NcufZUc1a4redZqCPAnn4
X-Google-Smtp-Source: ABdhPJwcd8CQaMde92mXnkx5x7+KSleayRkdFp32li3a/2Sm9cufhNS2kFs5KbkxeE0ojA8hDnduboWfr9Ju
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a25:7652:: with SMTP id
 r79mr45385167ybc.96.1632298803763; Wed, 22 Sep 2021 01:20:03 -0700 (PDT)
Date:   Wed, 22 Sep 2021 01:19:53 -0700
Message-Id: <20210922081959.390059-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [RFC PATCH 0/5] Start aligning perf test with kunit style
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf test uses its own structs and code layout that differs from kunit
that was more recently introduced to the kernel. Besides consistency,
it is hoped that moving in the direction of kunit style will enable
reuse of infrastructure like test output formatting for continuous
testing systems. For example:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/

The motivation for this restructuring comes from wanting to be able to
tag tests with a size:
https://lore.kernel.org/linux-perf-users/CAP-5=fWmGyuqFKc-EMP3rbmTkjZ3MS+YSajGZfeRMc38HS82gw@mail.gmail.com/
To have more exhaustive and slower running tests.  This isn't
something kunit currently supports, nor is the execution of python and
shell tests, but it seems sensible to work on an approach with kunit
rather to invent a new wheel inside of perf.

These initial patches are just refactoring the main test suite
definitions to be in a more kunit style. Kunit isn't depended upon, it
is hoped that this can be done in later patches for the sake of
consistency.

v1. Built/tested on x86.

Ian Rogers (5):
  perf test: Use macro for "suite" declarations
  perf test: Use macro for "suite" definitions
  perf test: Make each test/suite its own struct.
  perf test: Move each test suite struct to its test
  perf test: Rename struct test to test_suite

 tools/perf/arch/arm/include/arch-tests.h      |   2 +-
 tools/perf/arch/arm/tests/arch-tests.c        |  21 +-
 tools/perf/arch/arm/tests/vectors-page.c      |   2 +-
 tools/perf/arch/arm64/include/arch-tests.h    |   2 +-
 tools/perf/arch/arm64/tests/arch-tests.c      |  15 +-
 tools/perf/arch/powerpc/include/arch-tests.h  |   2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c    |  15 +-
 tools/perf/arch/x86/include/arch-tests.h      |  14 +-
 tools/perf/arch/x86/tests/arch-tests.c        |  47 +-
 tools/perf/arch/x86/tests/bp-modify.c         |   2 +-
 tools/perf/arch/x86/tests/insn-x86.c          |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c         |   2 +-
 .../x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
 tools/perf/arch/x86/tests/rdpmc.c             |   2 +-
 tools/perf/arch/x86/tests/sample-parsing.c    |   2 +-
 tools/perf/tests/api-io.c                     |   6 +-
 tools/perf/tests/attr.c                       |   4 +-
 tools/perf/tests/backward-ring-buffer.c       |   4 +-
 tools/perf/tests/bitmap.c                     |   4 +-
 tools/perf/tests/bp_account.c                 |  10 +-
 tools/perf/tests/bp_signal.c                  |   8 +-
 tools/perf/tests/bp_signal_overflow.c         |   8 +-
 tools/perf/tests/bpf.c                        |  22 +-
 tools/perf/tests/builtin-test.c               | 441 ++++--------------
 tools/perf/tests/clang.c                      |  18 +-
 tools/perf/tests/code-reading.c               |   4 +-
 tools/perf/tests/cpumap.c                     |  10 +-
 tools/perf/tests/demangle-java-test.c         |   4 +-
 tools/perf/tests/demangle-ocaml-test.c        |   4 +-
 tools/perf/tests/dlfilter-test.c              |   4 +-
 tools/perf/tests/dso-data.c                   |  10 +-
 tools/perf/tests/dwarf-unwind.c               |   2 +-
 tools/perf/tests/event-times.c                |   4 +-
 tools/perf/tests/event_update.c               |   4 +-
 tools/perf/tests/evsel-roundtrip-name.c       |   4 +-
 tools/perf/tests/evsel-tp-sched.c             |   4 +-
 tools/perf/tests/expand-cgroup.c              |   6 +-
 tools/perf/tests/expr.c                       |   4 +-
 tools/perf/tests/fdarray.c                    |   7 +-
 tools/perf/tests/genelf.c                     |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_filter.c               |   4 +-
 tools/perf/tests/hists_link.c                 |   4 +-
 tools/perf/tests/hists_output.c               |   4 +-
 tools/perf/tests/is_printable_array.c         |   4 +-
 tools/perf/tests/keep-tracking.c              |   4 +-
 tools/perf/tests/kmod-path.c                  |   4 +-
 tools/perf/tests/llvm.c                       |  22 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/mem.c                        |   4 +-
 tools/perf/tests/mem2node.c                   |   4 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/mmap-thread-lookup.c         |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |   5 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
 tools/perf/tests/openat-syscall.c             |   5 +-
 tools/perf/tests/parse-events.c               |   4 +-
 tools/perf/tests/parse-metric.c               |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c     |   4 +-
 tools/perf/tests/pe-file-parsing.c            |   6 +-
 tools/perf/tests/perf-hooks.c                 |   4 +-
 tools/perf/tests/perf-record.c                |   4 +-
 tools/perf/tests/perf-time-to-tsc.c           |  10 +-
 tools/perf/tests/pfm.c                        |  16 +-
 tools/perf/tests/pmu-events.c                 |  19 +-
 tools/perf/tests/pmu.c                        |   4 +-
 tools/perf/tests/python-use.c                 |   4 +-
 tools/perf/tests/sample-parsing.c             |   4 +-
 tools/perf/tests/sdt.c                        |   6 +-
 tools/perf/tests/stat.c                       |  10 +-
 tools/perf/tests/sw-clock.c                   |   4 +-
 tools/perf/tests/switch-tracking.c            |   4 +-
 tools/perf/tests/task-exit.c                  |   4 +-
 tools/perf/tests/tests.h                      | 179 ++++---
 tools/perf/tests/thread-map.c                 |  10 +-
 tools/perf/tests/thread-maps-share.c          |   4 +-
 tools/perf/tests/time-utils-test.c            |   4 +-
 tools/perf/tests/topology.c                   |   4 +-
 tools/perf/tests/unit_number__scnprintf.c     |   4 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   5 +-
 tools/perf/tests/wp.c                         |  22 +-
 81 files changed, 543 insertions(+), 618 deletions(-)

-- 
2.33.0.464.g1972c5931b-goog


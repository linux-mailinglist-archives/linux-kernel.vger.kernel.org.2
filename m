Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D33CF0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 02:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377885AbhGSXgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 19:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348430AbhGSWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 18:07:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F35C08EADF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i14so5923130pfd.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OKFGPZSjOp/qW6q1mXcXpbNAjO5OGS/hWfxwbZXcdo0=;
        b=sVsOJPzGT8JNFtN6AfSOY7YVPfvQgkW/r1U3nX7YGP7whHu8yZoQlQfK9PAG9OzLW9
         bgdSKKzQBPRDs2nMVykJcgIkpFXD7j0QINfW0wnI34dFWCzC8N0GSYBxT4hrnYNwXL8x
         OQPHk+7qcuPEOb2RQfwUJQqILUmbw4sdtH1U3Dgdx1/0xLgLOOAPkhlLqzIGoFsTaRW1
         E0+QD3BzwSVD56rfHQgSK4al/PJGLagv5Fl9vuDSL1RZf8ISR1KU7Jv7NEwje2jFd6EX
         nl7aqpTmaP7POhpLaVQxllpKaG5SyHA0cLaNv9vzjWordgv7kOeO2vG5GFpriX8MhZIF
         FSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OKFGPZSjOp/qW6q1mXcXpbNAjO5OGS/hWfxwbZXcdo0=;
        b=Qgbr1z8CnJ3T2liPuSnmMLbpLEZoWR7x0FHw0jP8GzhormLHs10LXGWzms7c6NZKou
         6wMSct0w3rOwBIEPt2Jqq4xg3+jgk+ou/g6QOYMP5WDWBFrdgxWnP/ErmaPeJT2oAMf2
         AoufMHFnCJlTd9IOBcQAMpMIhVuCKasKNCr5UdlLAD0W4huKhHp8eoSwszaJRsNeQtLp
         6iY55HsNkLybICIvKztFx8M1snfvPNSN6ABGc1P4+AXpxoWHWsytomFUfHQSVSZhz52Q
         tSdkobesyZUQ+seDMNCuRdHf8NoKZyyo6pYEJVeZ0zCDnxTYYbuhglqxHHegQ1Px8hYJ
         hbrw==
X-Gm-Message-State: AOAM5323uFQemshnxE4oTXycFbeqLKhVCiUf3tQDXgVO7vmx6mor5i00
        3vdzoZof/h5zFZ4ynQNer2w=
X-Google-Smtp-Source: ABdhPJy+Qb+ZQKJVjsL0Sghky9jH8mUA6EF3wfabBUXtjASGQwkEupEdDYulMTAEPo0reLEzpTnsYg==
X-Received: by 2002:a63:3704:: with SMTP id e4mr27427154pga.310.1626733920980;
        Mon, 19 Jul 2021 15:32:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:ff4e:db29:48ff:3778])
        by smtp.gmail.com with ESMTPSA id q19sm6921569pgj.17.2021.07.19.15.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 15:32:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCHSET v3 0/5] perf inject: Fix broken data with mixed input/output
Date:   Mon, 19 Jul 2021 15:31:48 -0700
Message-Id: <20210719223153.1618812-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The perf inject processes the input data and produces an output with
injected data according to the given options.  During the work, it
assumes the input and output files have the same format - either a
regular file or a pipe.  This works for the obvious cases, but
sometimes makes a trouble when input and output have different
formats (like for debugging).

 * changes in v3
  - use task-clock:u in the pipe-test.sh

 * changes in v2
  - factor out perf_event__synthesize_for_pipe
  - add a shell test for pipe operations


For example, this patchset fixed the following cases

 1. input: pipe, output: file

  # perf record -a -o - sleep 1 | perf inject -b -o perf-pipe.data
  # perf report -i perf-pipe.data

 2. input: file, output: pipe

  # perf record -a -B sleep 1
  # perf inject -b -i perf.data | perf report -i -


Thanks,
Namhyung


Namhyung Kim (5):
  perf tools: Remove repipe argument from perf_session__new()
  perf tools: Pass a fd to perf_file_header__read_pipe()
  perf inject: Fix output from a pipe to a file
  perf inject: Fix output from a file to a pipe
  perf tools: Add pipe_test.sh to verify pipe operations

 tools/perf/bench/synthesize.c       |  4 +-
 tools/perf/builtin-annotate.c       |  2 +-
 tools/perf/builtin-buildid-cache.c  |  2 +-
 tools/perf/builtin-buildid-list.c   |  2 +-
 tools/perf/builtin-c2c.c            |  2 +-
 tools/perf/builtin-diff.c           |  4 +-
 tools/perf/builtin-evlist.c         |  2 +-
 tools/perf/builtin-inject.c         | 38 ++++++++++++++--
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/builtin-kvm.c            |  4 +-
 tools/perf/builtin-lock.c           |  2 +-
 tools/perf/builtin-mem.c            |  3 +-
 tools/perf/builtin-record.c         | 40 +++--------------
 tools/perf/builtin-report.c         |  2 +-
 tools/perf/builtin-sched.c          |  4 +-
 tools/perf/builtin-script.c         |  4 +-
 tools/perf/builtin-stat.c           |  4 +-
 tools/perf/builtin-timechart.c      |  3 +-
 tools/perf/builtin-top.c            |  2 +-
 tools/perf/builtin-trace.c          |  2 +-
 tools/perf/tests/shell/pipe_test.sh | 69 +++++++++++++++++++++++++++++
 tools/perf/tests/topology.c         |  4 +-
 tools/perf/util/data-convert-bt.c   |  2 +-
 tools/perf/util/data-convert-json.c |  2 +-
 tools/perf/util/header.c            | 12 ++---
 tools/perf/util/header.h            |  2 +-
 tools/perf/util/session.c           | 11 ++---
 tools/perf/util/session.h           | 12 ++++-
 tools/perf/util/synthetic-events.c  | 53 +++++++++++++++++++++-
 tools/perf/util/synthetic-events.h  |  6 +++
 30 files changed, 217 insertions(+), 84 deletions(-)
 create mode 100755 tools/perf/tests/shell/pipe_test.sh

-- 
2.32.0.402.g57bb445576-goog


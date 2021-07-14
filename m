Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C009A3C7A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhGNAhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 20:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbhGNAhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 20:37:36 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E18C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso343606pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 17:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2m/ly+adLKyXaiQPaIoc6PRoT9315UuebWM/KZWIP8=;
        b=doiW3uds7bnPtIKW0IxCLa1VB4cXfREKE6MmxSqXbCagZwIYhLzqJrM4N48xrhhYT9
         EB+fr9T7jtoaegR4uKeJCFPATv+LG1YHHi0lhWPTx8Cb8xTH5MDKsnNV2U2D8RvfLWQl
         /bmisbLYblEJreDsJIFkYyr6W6mQ9QbDivZX2uHByS9NMk1D4Xee4Z2PhDaRruxhcBSx
         XqiLu/OF5FtDYMis82PolwroiKXy929NXFs6e/kLpvKUk+isBsW+SgUwUFyAPjjTgbZP
         rI1bLFN4Tv6stRjl9i4XFN50Caw2dmKuHoH7dWpt+SR3fXSpcEP07U/Pf/ep0ZurmrJu
         p4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=O2m/ly+adLKyXaiQPaIoc6PRoT9315UuebWM/KZWIP8=;
        b=spGemyQpkVy9eZaVW86xqKWI2tSKqW+S6xZNXrpu5+FL//vSppCruJRdup2vZPmksT
         zVMpTLyWWTLfia2MQveVHFBmXgxv0sCAACREJLV0FkK7LZFcIuYopMPRtcpuAytorOLd
         ra8PtKekgrWVuTsgYWFPJQBVaecH7c7tiv0V25nh28GR2v8zx4JlVaYCFfHeWBlKxnPj
         bSqwzaCXYztHXnyW6ABDiPbYw608xIYe7dbFo8sQ8L+23eqvOG7pSgMVECophA0oeg3V
         M0d59ey2D/Q1Bkh+yt1503cUXyO3C9Sl3z498OBI1DL381LRGfFCe02mzkd/qebKwxAK
         3lCg==
X-Gm-Message-State: AOAM530CqMNUwj+dDwmnfIYLefkzUYi3X2rAm32AKQ1XLS9FicVJEfFB
        rfagzsUSm+/fQEiTE7DZtGg=
X-Google-Smtp-Source: ABdhPJwsCg5tdM57E6qpWeLcBwEvz5cQ7w4cY3Hp/PP7J95xkuxEdRAwSkltIMxcgKZIf+dN/lNLyw==
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr905437pjy.225.1626222884580;
        Tue, 13 Jul 2021 17:34:44 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:9b12:1fd4:6232:5315])
        by smtp.gmail.com with ESMTPSA id x6sm285896pgq.67.2021.07.13.17.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:34:43 -0700 (PDT)
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
Subject: [PATCHSET v2 0/5] perf inject: Fix broken data with mixed input/output
Date:   Tue, 13 Jul 2021 17:34:37 -0700
Message-Id: <20210714003442.1111502-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
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
2.32.0.93.g670b81a890-goog


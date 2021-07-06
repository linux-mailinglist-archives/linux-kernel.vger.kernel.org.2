Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A703BD9EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhGFPTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232124AbhGFPTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625584632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kcnccMysOp1L+/3Bdn/WYRvS1AGXRx1BBrpcB7l7eXU=;
        b=PN9+kev+aU0SiwQKMoGeRatxVcCzRy2ofSEndswqxywg9cBxQMRSbNM+zgskhjLWlCXr5I
        aw6E2rMlvK0r1ZVtnSauK7o/Q+qVS+fUQhjdNnYVAlnNtkp02sg1wPzqEusANMHzwIAtHw
        lb8EiQdPE8VPXRajVcdWmTEgK0e+Txw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-kPPbErHROcaBz9Oqylk2IA-1; Tue, 06 Jul 2021 11:17:08 -0400
X-MC-Unique: kPPbErHROcaBz9Oqylk2IA-1
Received: by mail-wr1-f69.google.com with SMTP id k3-20020a5d52430000b0290138092aea94so495363wrc.20
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kcnccMysOp1L+/3Bdn/WYRvS1AGXRx1BBrpcB7l7eXU=;
        b=n8ahk2LVPU0xMMT7tziYxPq/M1jkmdX+FQlT6LWjdSCaalKbxbfpf+WMljpTzCLanA
         an4oO0Wwx1qUFAAtCi6F2zrl5e03xBroF97dGVLnLxRXXtiKjwidBFNb+dgGwNV/Go7c
         1DlGz/MqzFQoR2FY1Hz18/AjaJ/YZF4XWNmElUdkTD3bvK65BoWZna5rucXHgnAj4vjN
         UN9OL0TtwMBo7ZQwSPwN+DFWhw9FafkPZP7bu3+koNU1OinMrri8bug2isJVvF5QSvJd
         +La7qDcIEOWDEkl/5qNRN6pkyLwWhZ1EQeus9kxDy+jRNq8f+Yd28x8ci24M0Gj9zs48
         qT2Q==
X-Gm-Message-State: AOAM533zwtDgLCysTXlA4r1HUkNpuxUzWM+rIgj/iaWBpyiamYQb9ZQy
        nqEpyoAz3pEhNkaVtvGl/6F8b7AHQl+8gO+YyzdXrSEPW9Fut9HCDI0+WSXo8Z7Pek34OanEBhG
        xNUIHWToOYtrh68WY3AMt0QAj
X-Received: by 2002:a5d:4812:: with SMTP id l18mr4641114wrq.68.1625584627317;
        Tue, 06 Jul 2021 08:17:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcrdaKcb6CHyKadW9nQ873wqxA27FWocGpKVUVstjhygzwG5+/BVlyQ2TNVSS7KzcvGTMS+A==
X-Received: by 2002:a5d:4812:: with SMTP id l18mr4641093wrq.68.1625584627184;
        Tue, 06 Jul 2021 08:17:07 -0700 (PDT)
Received: from krava.redhat.com ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id i11sm3548118wmg.18.2021.07.06.08.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 08:17:06 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: [RFCv2 0/7] libperf: Add leader/group info to perf_evsel
Date:   Tue,  6 Jul 2021 17:16:57 +0200
Message-Id: <20210706151704.73662-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
moving leader/group info to libperf's perf_evsel.

This was asked for by Shunsuke [1] and is on my list
as a prereq for event parsing move to libperf.

I still need to do more tests, but I'd like to check
with you guys if there's any feedback on this first.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  libperf/groups

v2 change:
  - repost due to smtp failures, no changes

thanks,
jirka


[1] https://lore.kernel.org/linux-perf-users/OSBPR01MB46005B38568E90509946ECA9F7319@OSBPR01MB4600.jpnprd01.prod.outlook.com/


---
Jiri Olsa (7):
      libperf: Change tests to single static and shared binaries
      libperf: Move idx to perf_evsel::idx
      libperf: Move leader to perf_evsel::leader
      libperf: Move nr_groups to evlist::nr_groups
      libperf: Add perf_evlist__set_leader function
      libperF: Add group support to perf_evsel__open
      libperf: Add tests for perf_evlist__set_leader function

 tools/lib/perf/Build                     |  2 ++
 tools/lib/perf/Makefile                  | 30 +++++++++++++++++++++++++-----
 tools/lib/perf/evlist.c                  | 22 ++++++++++++++++++++++
 tools/lib/perf/evsel.c                   | 33 +++++++++++++++++++++++++++++----
 tools/lib/perf/include/internal/evlist.h |  2 ++
 tools/lib/perf/include/internal/evsel.h  |  5 ++++-
 tools/lib/perf/include/internal/tests.h  |  4 ++--
 tools/lib/perf/include/perf/evlist.h     |  1 +
 tools/lib/perf/libperf.map               |  1 +
 tools/lib/perf/tests/Build               |  5 +++++
 tools/lib/perf/tests/Makefile            | 40 ----------------------------------------
 tools/lib/perf/tests/main.c              | 15 +++++++++++++++
 tools/lib/perf/tests/test-cpumap.c       |  3 ++-
 tools/lib/perf/tests/test-evlist.c       | 30 +++++++++++++++++++++++-------
 tools/lib/perf/tests/test-evsel.c        |  3 ++-
 tools/lib/perf/tests/test-threadmap.c    |  3 ++-
 tools/lib/perf/tests/tests.h             | 10 ++++++++++
 tools/perf/arch/x86/util/iostat.c        |  4 ++--
 tools/perf/builtin-diff.c                |  4 ++--
 tools/perf/builtin-record.c              |  4 ++--
 tools/perf/builtin-report.c              |  8 ++++----
 tools/perf/builtin-script.c              |  9 +++++----
 tools/perf/builtin-stat.c                | 12 ++++++------
 tools/perf/builtin-top.c                 | 10 +++++-----
 tools/perf/tests/bpf.c                   |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c  |  6 +++---
 tools/perf/tests/mmap-basic.c            |  8 ++++----
 tools/perf/tests/parse-events.c          | 74 +++++++++++++++++++++++++++++++++++++-------------------------------------
 tools/perf/tests/pfm.c                   |  4 ++--
 tools/perf/ui/browsers/annotate.c        |  2 +-
 tools/perf/util/annotate.c               |  8 ++++----
 tools/perf/util/auxtrace.c               | 12 ++++++------
 tools/perf/util/cgroup.c                 |  2 +-
 tools/perf/util/evlist.c                 | 44 +++++++++++++-------------------------------
 tools/perf/util/evlist.h                 |  2 --
 tools/perf/util/evsel.c                  | 32 +++++++++++++++++++++++++-------
 tools/perf/util/evsel.h                  | 14 ++++++++------
 tools/perf/util/header.c                 | 18 +++++++++---------
 tools/perf/util/metricgroup.c            | 22 +++++++++++-----------
 tools/perf/util/parse-events.c           |  8 ++++----
 tools/perf/util/pfm.c                    |  2 +-
 tools/perf/util/python.c                 |  2 +-
 tools/perf/util/record.c                 |  6 +++---
 tools/perf/util/stat-shadow.c            |  2 +-
 tools/perf/util/stat.c                   |  2 +-
 tools/perf/util/stream.c                 |  2 +-
 46 files changed, 310 insertions(+), 224 deletions(-)
 create mode 100644 tools/lib/perf/tests/Build
 delete mode 100644 tools/lib/perf/tests/Makefile
 create mode 100644 tools/lib/perf/tests/main.c
 create mode 100644 tools/lib/perf/tests/tests.h


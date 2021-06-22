Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385913B0945
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhFVPlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231680AbhFVPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NZHzXZMKP7nHpXK5mWsMLai/c3tl5cz2YTIhi9A9pMM=;
        b=EXNa/JvSBugM4L3k1Z48oKLNN5/BgJrJp9RvVA/X5jbkTWrdyudekZXKdcjn7GosYpshSb
        GOhehwVxcQ/ZWByxjc1LDXjTgMbtUYOIx5DaE/Ul9RrmwqHqm9hRh3s9akEEdWN8op5P3i
        kJIu8Y0T8KCkgmE7YKi1hpavFvlB6nk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-T7Iu-kCuMo6Z6oI8_n1Z2Q-1; Tue, 22 Jun 2021 11:39:24 -0400
X-MC-Unique: T7Iu-kCuMo6Z6oI8_n1Z2Q-1
Received: by mail-wr1-f72.google.com with SMTP id f9-20020a5d64c90000b029011a3c2a0337so9922635wri.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NZHzXZMKP7nHpXK5mWsMLai/c3tl5cz2YTIhi9A9pMM=;
        b=ShRMWp7IH/VrGqrlVYDKMc7yyLwG7T6RILkiPjOVpoSrbaXe3TftIayYr0COebRtyn
         t34Cw7b6A8Z+KRVHlSmAs4Cz/rbq/4UfJ+I9P8V0HTMfA2Ho+2+LDLSKPcKcT62CesKK
         l3YRC6xAsmCwd79ovSdIBXVpUOFhdDbIAV7dyjmngs0QkwTs2cmypHTwo+3ZC0zqtJDP
         HunI+INS1/zzQ42sPkrLu72U/yef2CEBHzjlPs7/7eRQC2teSsXRzixiWhHTn2wwGgsS
         VmGyi0km8IePhIrUhQl+nmsMh9/DCQSPQwAmCb56zq0EePKlBIlAPGnAkZm72Xlr1Vf7
         XdNQ==
X-Gm-Message-State: AOAM533Boqd02Pvky15vpNSuiFntnq5FYwJ0MKXaCpfbrfrfLchZossj
        KUUipXnDEtHXA7HNTl7yBABR8TEzE4BXFNNUqwAmzJW2lk2w6FTvDnee83r1eEKfQzoytg9oKqL
        56JD+we9ps9ApQafhGwsmd/UE
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr5049525wml.170.1624376362637;
        Tue, 22 Jun 2021 08:39:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE/pmn4kiWfXOuQKTCDrf/yUwuJQBIgPOWE/dVdGSMV4cjZ80c9YINuvkjER9s9BLe3jwA5Q==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr5049500wml.170.1624376362401;
        Tue, 22 Jun 2021 08:39:22 -0700 (PDT)
Received: from krava.redhat.com ([5.171.243.0])
        by smtp.gmail.com with ESMTPSA id e3sm11647962wro.26.2021.06.22.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:39:22 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>
Subject: [RFC 00/10] perf: Add build id parsing fault detection/fix
Date:   Tue, 22 Jun 2021 17:39:08 +0200
Message-Id: <20210622153918.688500-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this *RFC* patchset adds support to detect faults during
mmap2's build id parsing and a way to fix such maps in
generated perf.data.

It adds support to record build id faults count for session
and store it in perf.data and perf inject support to find
these maps and reads build ids for them in user space.

It's probably best explained by the workflow:

  Record data with --buildid-mmap option:

    # perf record --buildid-mmap ...
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Failed to parse 4 build ids]
    [ perf record: Captured and wrote 0.008 MB perf.data ]

  Check if there's any build id fault reported:

    # perf report --header-only
    ...
    # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED

  There is, check the stats:

    # perf report --stat

    Aggregated stats:
             TOTAL events:        104
                      ....
           BUILD_ID fails:          4  (14.3%)

  Yep, let's fix it:

    # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data

  And verify:

    # perf report -i perf-fixed.data --stats

    Aggregated stats:
               TOTAL events:        104
                        ....

  Good, let's see how many we fixed:

    # perf report --header-only -i perf-fixed.data
    ...
    # build id mmap stats: FAULTS 4, LOST 0, FIXED(4)


I don't have a good way to test it, just by artificially
adding the faults in kernel code, but Ian and Namhyung
might have setup that could generate that.. would be great
to have a perf test for this.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/buildid_stats

thoughts?

thanks,
jirka


---
Jiri Olsa (10):
      perf: Track build id faults for mmap2 event
      perf: Move build_id_parse to check only regular files
      perf: Add new read_format bit to read build id faults
      perf: Add new read_format bit to read lost events
      tools: Sync perf_event.h uapi
      libperf: Do not allow PERF_FORMAT_GROUP in perf_evsel__read
      perf record: Add support to read build id fails
      perf record: Add new HEADER_BUILD_ID_MMAP feature
      perf report: Display build id fails stats
      perf inject: Add --buildid-mmap2 option to fix failed build ids

 include/linux/perf_event.h                         |  2 ++
 include/uapi/linux/perf_event.h                    | 20 +++++++++++++-------
 kernel/events/core.c                               | 49 +++++++++++++++++++++++++++++++++++++++++++------
 kernel/events/ring_buffer.c                        |  3 +++
 tools/include/uapi/linux/perf_event.h              | 20 +++++++++++++-------
 tools/lib/perf/evsel.c                             | 10 ++++++++++
 tools/lib/perf/include/perf/evsel.h                | 11 ++++++++++-
 tools/perf/Documentation/perf-inject.txt           |  3 +++
 tools/perf/Documentation/perf.data-file-format.txt | 19 +++++++++++++++++++
 tools/perf/builtin-inject.c                        | 45 +++++++++++++++++++++++++++++++++++++++++++--
 tools/perf/builtin-record.c                        | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-report.c                        | 35 +++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h                              |  6 ++++++
 tools/perf/util/evsel.c                            | 12 ++++++++++++
 tools/perf/util/header.c                           | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h                           |  1 +
 tools/perf/util/map.h                              | 15 +++++++++++++++
 tools/perf/util/perf_event_attr_fprintf.c          |  3 ++-
 18 files changed, 407 insertions(+), 24 deletions(-)


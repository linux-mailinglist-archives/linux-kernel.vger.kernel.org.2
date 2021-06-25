Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A23B3D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFYHUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhFYHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:20:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71AFC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e22so6839780pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1vhe7aEQSO3yhW1l7ilkHZitN/BaER38WMPQaG3c9Bk=;
        b=UxpPqW/+UrMXuYmvtXN78elJCyu4ZsL4n7DO9AqgPbN/zGGGSNiP0dkQg3+s8a+lQV
         RFXow3jw6MbsNVb+9OmxJ3DNqHcePUiL8FMytpHt8Xb/By/9VIalqqCY+IRToEipB3G8
         Fm9mhJUQZukLWojbo2Paa+5yy+UToKuJ/mS9yOgVcYUn6hll3ZkEBcLL0XxDE7TtJ+jq
         Hc9Bsyve27ky8/6/CQlfnpnR00COgP0X2cXV31AbGmBo7vvQLUWdraGimsi7u0vL8CR2
         zsGEBNgF8zg5K6TtFigbd9XeDGrlkdNocS9KRwNzImJgnYZkvCkiZLaZ2aE0nT7N9pyJ
         4O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1vhe7aEQSO3yhW1l7ilkHZitN/BaER38WMPQaG3c9Bk=;
        b=QWNmjemn4SkXEq1clUcMgjBbgkLOBERmjiTVQDMXG+XbrzGxtan6C9DOWLmbgGmM0T
         4cPDvdRx5FE3OPd2uMgFLBXRwH8vVcyemRZ01+tvUQDfiz/t4iI8xX1kwmIza3ql9NRc
         qGxSOjYqzpz0R1o4khpues/5e1TvEJ3fnkCj0uw0YvaQ5Xmd4AGlqX1dhWeJimGeETTY
         2H4vo+NQuE0BL/xBGeiQsOgZEXxjDcbOZoSMPQv/A5ziZwFrbWDpNxb/EBtMUdFWA2/O
         VeZagBuWx4XUzBr8v8458uPN3TiS1ZXg+p9bxmwxz+JwH989r6VB/L+jDTK+M59vIeyV
         EDlQ==
X-Gm-Message-State: AOAM532A/U9tjdBQLD4Dp1VhOVRr6iNaphv67Jn7iXfYXPTqWgx40t3u
        T4EUZwMu/FDBuNPqjO2TQFk=
X-Google-Smtp-Source: ABdhPJxkp6s3/3z1nALNakT+5mQAY+VKRY/bWmGhSOtNMfbHsUxiv4Yv5lMsx3GhEDKY/rKZNKjNRg==
X-Received: by 2002:aa7:9118:0:b029:2eb:2ef3:f197 with SMTP id 24-20020aa791180000b02902eb2ef3f197mr8895985pfh.27.1624605508427;
        Fri, 25 Jun 2021 00:18:28 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:1b9c:b593:f9be:6b24])
        by smtp.gmail.com with ESMTPSA id c68sm4759176pfc.75.2021.06.25.00.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:18:27 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCHSET v4 0/4] perf stat: Enable BPF counters with --for-each-cgroup
Date:   Fri, 25 Jun 2021 00:18:22 -0700
Message-Id: <20210625071826.608504-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is to add BPF support for --for-each-cgroup to handle many cgroup
events on big machines.  You can use the --bpf-counters to enable the
new behavior.

 * changes in v4
  - convert cgrp_readings to a per-cpu array map
  - remove now-unused cpu_idx map
  - move common functions to a header file
  - reuse bpftool bootstrap binary
  - fix build error in the cgroup code
  
 * changes in v3
  - support cgroup hierarchy with ancestor ids
  - add and trigger raw_tp BPF program
  - add a build rule for vmlinux.h

 * changes in v2
  - remove incorrect use of BPF_F_PRESERVE_ELEMS
  - add missing map elements after lookup
  - handle cgroup v1

Basic idea is to use a single set of per-cpu events to count
interested events and aggregate them to each cgroup.  I used bperf
mechanism to use a BPF program for cgroup-switches and save the
results in a matching map element for given cgroups.

Without this, we need to have separate events for cgroups, and it
creates unnecessary multiplexing overhead (and PMU programming) when
tasks in different cgroups are switched.  I saw this makes a big
difference on 256 cpu machines with hundreds of cgroups.

Actually this is what I wanted to do it in the kernel [1], but we can
do the job using BPF!


Thanks,
Namhyung


[1] https://lore.kernel.org/lkml/20210413155337.644993-1-namhyung@kernel.org/


Namhyung Kim (4):
  perf tools: Add read_cgroup_id() function
  perf tools: Add cgroup_is_v2() helper
  perf tools: Move common bpf functions to bpf_counter.h
  perf stat: Enable BPF counter with --for-each-cgroup

 tools/perf/Makefile.perf                    |  17 +-
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |  57 +---
 tools/perf/util/bpf_counter.h               |  52 ++++
 tools/perf/util/bpf_counter_cgroup.c        | 299 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 191 +++++++++++++
 tools/perf/util/cgroup.c                    |  46 +++
 tools/perf/util/cgroup.h                    |  12 +
 8 files changed, 622 insertions(+), 53 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

-- 
2.32.0.93.g670b81a890-goog


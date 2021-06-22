Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7F3AFDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFVHOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFVHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:14:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 69so9968683plc.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8CHnIOoOchHKbn6wHelTyIsKK9z9NRZQu44egYJzsoQ=;
        b=dGmTBKEG0a3s6/p1EvvF6wu85kPREP+5Mn0yWIrHJ2qJ5yXIYd6Y3LSyJT3Iv5WKaV
         ufE4+qTyZI7nGPJcmz/D9zoWcdbqAiV5ZKpyNzNzHcTzVd0NK/mLmWKTfXWqRhmROJvp
         TVMsRGziv+pZ/HD/un1+uhXE1hug/zD/m6VrKXUwC3ntq0SNvjW796hTczbVPq33bd42
         WNHgJWciuGuPUKIys/ZYWZMciO7+7yBwRx0hNEX9IQJaNhAqoA2pPhGc2b7HP3eD0xbo
         OUWtQunXDkrQWtzHZEMZjiIfjwPmWZ2Fp88LC4oYujl3J3qh/UNhcy5fA3G9ORP+RKj+
         Qgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8CHnIOoOchHKbn6wHelTyIsKK9z9NRZQu44egYJzsoQ=;
        b=bKTf8jOvFkwtaAGH6KLL3NDMnMEDwCB3pMKvfCYD8CLtArmgwoiYZS4wbZ2skqOXBU
         dLkFwElhSbeO90Aktjy5A0oKbpxXOwV80GMCNGi6Jnu9CoNzajASTRewTGj9plXqkwQM
         dcCGfoSSzRI6310zUkNL/tXbS2zkN7+e8gJlqOEAqinpaByU3s6DbTiZ1mgKAx7lB2od
         mPvzAKwswFRX0gcfDA5WvnGo4xNPiRrYMuLIHVEmoBWX2T9Y9UGApKFkPhGxFLPOJo/A
         P0P53vNZnNiRW4oq4jPQgRsHgnj8p8hXzh383x0RtNufA8Qq1eSes4id+gXd57ocRUKv
         7qCA==
X-Gm-Message-State: AOAM532uTUNE7x/L7+oupHJdf6QP3L5xi6DPCpxwGBfXfCkhHSD+Z0BR
        mDPyn0Rbh8WiDAHnl+cJmE8=
X-Google-Smtp-Source: ABdhPJwi5pvFoeD5Q2ZmQsyxY4cKqkbEhaDrYO8TfbpPgIq1WMhor7cJ9/WBlXH7Rfoy2nXR3mnGgQ==
X-Received: by 2002:a17:902:e00e:b029:ef:5f1c:18a8 with SMTP id o14-20020a170902e00eb02900ef5f1c18a8mr21637625plo.38.1624345944574;
        Tue, 22 Jun 2021 00:12:24 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:62e3:ad14:6151:62fa])
        by smtp.gmail.com with ESMTPSA id j4sm16449129pfj.111.2021.06.22.00.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:12:23 -0700 (PDT)
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
Subject: [PATCHSET v3 0/3] perf stat: Enable BPF counters with --for-each-cgroup
Date:   Tue, 22 Jun 2021 00:12:18 -0700
Message-Id: <20210622071221.128271-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is to add BPF support for --for-each-cgroup to handle many cgroup
events on big machines.  You can use the --bpf-counters to enable the
new behavior.

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


Namhyung Kim (3):
  perf tools: Add read_cgroup_id() function
  perf tools: Add cgroup_is_v2() helper
  perf stat: Enable BPF counter with --for-each-cgroup

 tools/perf/Makefile.perf                    |   7 +-
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 337 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 207 ++++++++++++
 tools/perf/util/cgroup.c                    |  46 +++
 tools/perf/util/cgroup.h                    |  12 +
 7 files changed, 614 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

-- 
2.32.0.288.g62a8d224e6-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835753A747C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFOC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFOC6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:58:52 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3867C061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:56:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id h9so16590332oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKxfoJFYYNRx0lTeI3yckxbLmISlhapUX0qjWIkkKnM=;
        b=WghiQESH5PR3CBGWMfseOMaewPWzM9GM9rFnVkIvrcnAkUaUXg9MkB7GIQqH+BHbR4
         0xXKX7JVe5CcZU2SM03t70wPLvvAZA9I5/3uR73Se4GsnSiJy1/yERY/4k5VDhILtX1n
         kP4cryxSmsCAjxPTM2K28N930ls7xQjXc0uXEdIGkEPPc+vSt4uwYs+mq+vEIx7zDFnR
         p2Vh8RKWMY4Q9IeJ0bQ83hBTRKYR6zunO/483PBqLkF7BDyIfLr2xBEX9XXtJw1zLAev
         G5+FOZJlQBzsTA3Etim7nh20SkM1z1t4Q96FgMJ5l7UN0rQSvJLsm2PnwRU9GULJ1gXs
         inBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wKxfoJFYYNRx0lTeI3yckxbLmISlhapUX0qjWIkkKnM=;
        b=nEBnhwDyE3tSEE98IzGv1ODMzSpnGK7ic7K2brXPXBSNsm60nWtVyVYPy70suU30Nm
         AKtAx9wbwhdhyqga9X/ZooF9DAwmGZHxhoKl9fXLm42mjfjwpo+LW3+aCr+Aj5K+9Whm
         PEbTnA6LLIiBSFaefSNG+xACBCU/p/cVEliJuq16aTH4R4R8QoKBd/9yRJ2t4bTF55zl
         IcqTx1Bq4aBHfwe+28imeViHC/kiv7rzcbi5UCLVRKLOSXh9xI7hYWRRA1KJGq1ht/oP
         Oa5js+64aIt9pPI37COnU8CNIe3HV135MMebZ61jy7S81ckI5zUYzF7x7jj1IMpG8lfo
         VtxQ==
X-Gm-Message-State: AOAM532X1mHUI7SjHd17JvHXDiC6/7C5pcOgdqdkbvfvES3GVZvuWiun
        7AIt03OGhKYa5VJrJF2VcsN5mlTsOjvSuA==
X-Google-Smtp-Source: ABdhPJzkJBBoVJKdi/mLDinPSgCu5ztt4xRUYFwPOhTTAvAAEpB5ZAMaedarpo+nWFOD4ocKz6hYhg==
X-Received: by 2002:a17:90a:b94c:: with SMTP id f12mr22554048pjw.32.1623719846755;
        Mon, 14 Jun 2021 18:17:26 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:5db9:f2a7:a913:e1ba])
        by smtp.gmail.com with ESMTPSA id z15sm14881758pgu.71.2021.06.14.18.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 18:17:26 -0700 (PDT)
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
Subject: [PATCHSET v2 0/3] perf stat: Enable BPF counters with --for-each-cgroup
Date:   Mon, 14 Jun 2021 18:17:21 -0700
Message-Id: <20210615011724.672612-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is to add BPF support for --for-each-cgroup to handle many cgroup
events on big machines.  You can use the --bpf-counters to enable the
new behavior.

 * changes v2
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

Actually this is what I wanted to do it in the kernel [1], but IIUC
with some limitations we can do the job using BPF.

Current limitations are:
 * it doesn't support cgroup hierarchy
 * there's no reliable way to trigger running the BPF program


Thanks,
Namhyung


[1] https://lore.kernel.org/lkml/20210413155337.644993-1-namhyung@kernel.org/


Namhyung Kim (3):
  perf tools: Add read_cgroup_id() function
  perf tools: Add cgroup_is_v2() helper
  perf stat: Enable BPF counter with --for-each-cgroup

 tools/perf/Makefile.perf                    |   1 +
 tools/perf/util/Build                       |   1 +
 tools/perf/util/bpf_counter.c               |   5 +
 tools/perf/util/bpf_counter_cgroup.c        | 319 ++++++++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 146 +++++++++
 tools/perf/util/cgroup.c                    |  46 +++
 tools/perf/util/cgroup.h                    |  12 +
 7 files changed, 530 insertions(+)
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

-- 
2.32.0.272.g935e593368-goog


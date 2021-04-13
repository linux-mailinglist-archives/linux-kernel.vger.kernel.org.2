Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633635E33A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhDMPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbhDMPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:54:03 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:53:42 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id h7so13082504qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JX8WTHJKGz8o2m3gFANfVehh88pQR2wB5Ctp1EEgDY0=;
        b=rrGrnOVZlmr3MbCuth2lbl6TaRJE+5hZK5ZxLvj3fRUqu9mnN+6Sj3Wol44+kRUyBa
         r8Q+BHliZ5JE7R8y04TQRAgApPpUNDPV6vDL4Mnr2edl8cuZXTHNyZXw2Jz4BslJl1Qk
         TBeX9EWwjFI6MOhx+teJBIH4uD7OUZU/aoaKUazf3qF7sBysbE6XMJrUp+qL85C9utNY
         lx1dzdqYnAlqZ7puEzHzjmr8tjGSEr/uwnlS662bZMhxe/RJTtM/w1WZxiwasUyx/J+f
         UWk2uVy07uRfspqFypwtjrGDRiclkC+jhDQ9VUWzrVmeLhpmn5hz5kQYedp1h5QVtHYY
         nfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JX8WTHJKGz8o2m3gFANfVehh88pQR2wB5Ctp1EEgDY0=;
        b=dQCpvt5ST9nzH90Azjt8BfV38EcM4co1ni+67hUYxm710S6cZZV6o1p40q6qeKlWTd
         WzLN0twAIYS4eOF2xifI6shgqoGNNsMOJ4Ru27iCxT4BllBNEyXmTeevCAerRnUXmPYG
         yh73mjGsTz+5jSlFLzaPmoPDNtdNL5QnGPVXqEnU9ocI1qfx8cP37H6Bm/DonuCh0ZNW
         QmV0P7klBx5GFfiSqo9hf2mFbgXCOdfJWBECS/cyby3sIZaxTF1mJFlbGBDGbbFE7Lv4
         JA6kIvo4Y+vSG/UlwFgAmgagCY8bS3WvavRqtklf2omjEN5cZ7mBtu4RA4CNGF+HibeL
         vpfA==
X-Gm-Message-State: AOAM532gXXmco6Pm74M87TDvkGeJ0XbxOEdTeNdmc/oSiTgLJ6UXyPG2
        ZRzq5VkOwFBYr8eecuW/600=
X-Google-Smtp-Source: ABdhPJz3Of+2OUha3vUdItiQZB+fa0udCneje0wXtFusNkG/5+01BdWdneFWZHvoTamcqtPTWv/H6Q==
X-Received: by 2002:ac8:5847:: with SMTP id h7mr31443990qth.108.1618329220600;
        Tue, 13 Apr 2021 08:53:40 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id f202sm262298qke.9.2021.04.13.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:53:39 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v3 0/2] perf core: Sharing events with multiple cgroups
Date:   Tue, 13 Apr 2021 08:53:35 -0700
Message-Id: <20210413155337.644993-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This work is to make perf stat more scalable with a lot of cgroups.

Changes in V3)
 * fix build error when !CONFIG_CGROUP_PERF

Changes in v2)
 * use ____cacheline_aligned macro instead of the padding
 * enclose the cgroup node list initialization
 * add more comments
 * add Acked-by from Song Liu


Currently we need to open a separate perf_event to count an event in a
cgroup.  For a big machine, this requires lots of events like

  256 cpu x 8 events x 200 cgroups = 409600 events

This is very wasteful and not scalable.  In this case, the perf stat
actually counts exactly same events for each cgroup.  I think we can
just use a single event to measure all cgroups running on that cpu.

So I added new ioctl commands to add per-cgroup counters to an
existing perf_event and to read the per-cgroup counters from the
event.  The per-cgroup counters are updated during the context switch
if tasks' cgroups are different (and no need to change the HW PMU).
It keeps the counters in a hash table with cgroup id as a key.

With this change, average processing time of my internal test workload
which runs tasks in a different cgroup and communicates by pipes
dropped from 11.3 usec to 5.8 usec.

Thanks,
Namhyung


Namhyung Kim (2):
  perf/core: Share an event with multiple cgroups
  perf/core: Support reading group events with shared cgroups

 include/linux/perf_event.h      |  22 ++
 include/uapi/linux/perf_event.h |   2 +
 kernel/events/core.c            | 591 ++++++++++++++++++++++++++++++--
 3 files changed, 588 insertions(+), 27 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog


*** BLURB HERE ***

Namhyung Kim (2):
  perf/core: Share an event with multiple cgroups
  perf/core: Support reading group events with shared cgroups

 include/linux/perf_event.h      |  22 ++
 include/uapi/linux/perf_event.h |   2 +
 kernel/events/core.c            | 594 ++++++++++++++++++++++++++++++--
 3 files changed, 591 insertions(+), 27 deletions(-)


base-commit: cface0326a6c2ae5c8f47bd466f07624b3e348a7
-- 
2.31.1.295.g9ea45b61b8-goog


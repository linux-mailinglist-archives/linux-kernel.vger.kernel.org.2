Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4597F35D68E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 06:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhDMEl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 00:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhDMEl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 00:41:57 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB84C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 21:41:37 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id c123so11858767qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 21:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O0ejZS0czo8wk6stsh/PiKOys/WnlktEib5VStV3I6o=;
        b=IhbgIsuVkmfF/XTny4V3zKFVp0PpQ5RA1bIkmLEggz1yYNKFqQHGoAfToSdmI43omA
         9oDhhOneiPyOikJrk3+3Btawcw7r0pSc5tlErVIBFL6lc6LPBZyawy1dhDhbW4T1Vh1L
         TwPAEotlVlMgD9CGpzKT0CtYoFOHImvcdAEPcNdLFbfAEV5HIki9y1Or+l6QIzxvL7NI
         8SKz5eCMIiPfw3KFNaP/IOQaSSDY7EOABun6+j0UKHcY40VT+nj32EobOhvy289EvN9G
         kMYlgwLvqxFTBeEwUN2ytG29QZrZfW+oPWmKx5BkkQeVf2uHqBRNwMW7eXF0H+i+8f0G
         hM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=O0ejZS0czo8wk6stsh/PiKOys/WnlktEib5VStV3I6o=;
        b=J2JOegu8mdaUjy0IkylUnShQ6LT9RxZzZdDuNKURhS5Z1l8irrQ2Hjp67qXA1qvtd1
         1bQYYvkwbW2zsh9Eacq1kFAjM36FxoJpSUYE6xlxvEDvRQ3hRpUCM7oGI01DKrwESeCC
         AHVhoQzIPurPAFSQ9ZemsB3vrqxLXUSxfvqIRI267TD0YDGr9dxNV/k+D6lvjn6LhrWQ
         u9dYR1uZYjhknYsPS34P+bLXF/EmG5Ywo2ZMWO4ObrSUllKV1bPkenZTe/4t4zgUX9oh
         g7cCy2jqSY51Oc8h73ZKeKRj2C2Rp3jD3pWtJu3G0x2Z4fH0lk32F6kYOt1Mpg2UDbgU
         Tq1Q==
X-Gm-Message-State: AOAM5309xR1kTDZu/cunaxNpAw+GPQm27lzl9hvHYwRrkxFNUHEaMxwV
        JA6+dK8GNqKwMua6pi5pMDY7+McUMh3Jbw==
X-Google-Smtp-Source: ABdhPJyBr4wEhLlq9+/juIt4HCP+ivAYiGaLVa1q6laKvExqNM76GjIun/ZSCbdDHit777Wy4odVjQ==
X-Received: by 2002:ae9:eb84:: with SMTP id b126mr3593019qkg.135.1618288896299;
        Mon, 12 Apr 2021 21:41:36 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id j6sm9543991qkl.84.2021.04.12.21.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 21:41:35 -0700 (PDT)
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
Subject: [PATCH v2 0/2] perf core: Sharing events with multiple cgroups
Date:   Mon, 12 Apr 2021 21:41:31 -0700
Message-Id: <20210413044133.617921-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This work is to make perf stat more scalable with a lot of cgroups.

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


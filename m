Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879B742869C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhJKGIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhJKGH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:07:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E38C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:06:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so12697869pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 23:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lW+Ct8pp1U25isGJ3zESNWUY7CfzwYFs3/lozVSwjsc=;
        b=KXe7IadhFNd9RX8m6/dJQ84e4nHw2ATBKfnoBvetIYYeSshX0DQVLtAFkiaRDvWb0s
         gPM2lND9HsMonDEu3cXnftNJs7O6cGDPK3jv/PsQOxIR50tFE0VElPIpiALVgic3btoC
         ITdR0FyvXHQTiI2huTPC0vg/TOcrNNfFlQ/r1Ko194slrh9ElopygwBVhKqhQPeJU1qk
         /Z7/QVK4lpr557NR8A9Ua4ev/SqXoLxVP7unQQfR193WM13qIPZKKW6t5GnSwycSedm7
         KxfP+OOUHNVlGuepmKUf83wZ3fiMxglW7RDR68bBpAT6FwEqeYNDDJdpcSVoP0aLjS/D
         X2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lW+Ct8pp1U25isGJ3zESNWUY7CfzwYFs3/lozVSwjsc=;
        b=XewjzJpSpzwRQeKdmAzlaDjEAjpxVW+t9jjAhYutCJ0ts6QU2OYpKH3hQOxlIp16oa
         uSsPQRJfYnYb/3VCkYq0u6TYum2B+QLd0I05T1NXxy+sUfpQTBLXNrlX/bFTimusi3kb
         WkLHxrZ2ZloWnDX4uQbZEoCEK4zjJUwTyO+DaDdgddsKi+yiDa0pGlbFg1CtiRjPOmor
         19dFAPT5hhp1a4u5KO8a4BSDD3Ib3ZcSHXOPI6Gi9K4MksaK4vhXzPsjp7uckh8Lroog
         lpfmin6dK0ivHk0REbUwwHr/OE4rja/V0f23IKbjDmL+SHlmb/zSNmqjK5lh/1v0Hzrf
         K4QQ==
X-Gm-Message-State: AOAM532SdUkKa0tGhuSYKnjOqJETm+hUuLr7u0D1Xq6Ilp1O0AhIMKQZ
        SSfDUTDirCxD0siu9KNOBJhC7w9a/pg=
X-Google-Smtp-Source: ABdhPJwb8iBIf801C9C30Ow0A6bRlhGVTMnEhbEU070iZWBlA+/Jj91+HyM+tiSxHW2exegDl0NLyw==
X-Received: by 2002:a17:902:bb94:b0:13c:9113:5652 with SMTP id m20-20020a170902bb9400b0013c91135652mr23178056pls.70.1633932359462;
        Sun, 10 Oct 2021 23:05:59 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:20c6:f9f2:3f22:9bc])
        by smtp.gmail.com with ESMTPSA id d9sm6519818pgn.64.2021.10.10.23.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 23:05:58 -0700 (PDT)
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
Subject: [RFC] perf/core: Set event shadow time for inactive events too
Date:   Sun, 10 Oct 2021 23:05:56 -0700
Message-Id: <20211011060556.1190936-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally the shadow time is set in event_sched_in() and used to
calculate up-to-date enabled and running times without accessing
ctx->time in a NMI context.  It's fine for active events.

However, we can access inactive events as well in some cases (like
in BPF) and it caused errors due to the missing shadow time.  If
the event is not yet scheduled in for the first time, the shadow
time would be zero.  Then the time calculation in the
perf_event_read_local() can go wrong like below:

  perf_event_read_local(event, ...)
    now = event->shadow_ctx_time + perf_clock();
    __perf_update_times(event, now, ...)
      delta = now - event->tstamp;
      if (state >= INACTIVE)
        enabled += delta;
      if (state >= ACTIVE)
        running += delta;

In my understanding, the 'now' and event->tstamp are in ctx->time
which keeps actual time the given context is used.  While perf_clock()
returns a timestamp using a local clock, and event->shadow_ctx_time
should kinda convert it into ctx->time unit.

But since the shadow ctx time is not set, the delta calculation is
using two different units.  And it's added to enabled time only as
it's in an inactive state.  It'd be much bigger than ctx->time, so
it'd return much bigger enabled time.

The recent bperf infra can trigger this issue easily.  As this is
about a small window with multiplexing, we need a large number of
events and short duration like below:

  # perf stat -a -v --bpf-counters -e instructions,branches,branch-misses \
    -e cache-references,cache-misses,bus-cycles,ref-cycles,cycles sleep 0.1

  Control descriptor is not initialized
  instructions: 19616489 431324015 360374366
  branches: 3685346 417640114 344175443
  branch-misses: 75714 404089360 336145421
  cache-references: 438667 390474289 327444074
  cache-misses: 49279 349333164 272835067
  bus-cycles: 631887 283423953 165164214
  ref-cycles: 2578771111104847872 18446744069443110306 182116355
  cycles: 1785221016051271680 18446744071682768912 115821694

   Performance counter stats for 'system wide':

          19,616,489      instructions              #    0.00  insn per cycle           (83.55%)
           3,685,346      branches                                                      (82.41%)
              75,714      branch-misses             #    2.05% of all branches          (83.19%)
             438,667      cache-references                                              (83.86%)
              49,279      cache-misses              #   11.234 % of all cache refs      (78.10%)
             631,887      bus-cycles                                                    (58.27%)
  2,578,771,111,104,847,872      ref-cycles                                                    (0.00%)
  1,785,221,016,051,271,680      cycles                                                        (0.00%)

       0.010824702 seconds time elapsed

As you can see, it shows invalid values for the last two events.
The -v option shows that the enabled time is way bigger than the
running time.  So it scaled the counter values using the ratio
between the two and resulted in that.  This problem can get worse
if users want no-aggregation or cgroup aggregation with a small
interval.

Actually 18446744069443110306 is 0xffffffff01b345a2 so it seems to
have a negative enabled time.  In fact, bperf keeps values returned by
bpf_perf_event_read_value() which calls perf_event_read_local(), and
accumulates delta between two calls.  When event->shadow_ctx_time is
not set, it'd return invalid enabled time which is bigger than normal.
Later, the shadow time is set and the function starts to return a
valid time.  At the moment, the recent value is smaller than before so
the delta in the bperf can be negative.

I think we need to set the shadow time even the events are inactive so
that BPF programs (or other potential users) can see valid time values
anytime.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1cb1f9b8392e..e28d410c67e3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3730,6 +3730,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
 		}
 
+		perf_set_shadow_time(event, ctx);
+
 		*can_add_hw = 0;
 		ctx->rotate_necessary = 1;
 		perf_mux_hrtimer_restart(cpuctx);
-- 
2.33.0.882.g93a45727a2-goog


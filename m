Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B65328035
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhCAOE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhCAOE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:04:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554DC061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l18so11902528pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P/Nf1q5D0YujGLjN1MRGdIf4MhxJULK8UYfA8vu0iPM=;
        b=VCy/F92DJYg5jk/oimkaXzt69iVmfvjkPy3Y619FL44hlOfbqduXuOaXu/Mtuu1JoX
         9JuNZWLtPTvyKIOhJckl66v5WIHr71hc+/pJvTS24+9SaXMK7TvA5nbi8TJqs2pQ03If
         iPPaogZbIN5/zXZXE1DZF2C4Y4JHuRnxpQJmMsclVyHAM836u7Z/408ithJ5H8Mlt2cG
         wIM40nrBgbwao+yqilhFtKAm+KMwWhdcfstMtIDfxG+cog/NXnlt6IeCAwJZcemO02Ux
         gfjQ2GbGRuzgAZc+16nOIB2Vk4xo2FpNu6pmDWJmKsZDKvcuQz4em9Ew1vCcAG7/pP1r
         t8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=P/Nf1q5D0YujGLjN1MRGdIf4MhxJULK8UYfA8vu0iPM=;
        b=cMXx0SbbPhna9cMLb7VlUflP2p2uAb1QZgXNuc6FfFUFKoNmGyzOUZMGuh6M1pQhQp
         8Reot5VMljCnGLuRToHecJgj/hHMH2yZfUYTRxihsvQMsiemyxfMknLjYvOIN3FVD8f7
         WGMjPSjWTFJrfzprbQn6Kptuc0Qk3/9fyDsOnwr0vIi6Fzaoe5o09QR1VxKMlv/25tIU
         t/ZHs09hL0oxdo5q4GiDH1OJskmLkO5UeIw63ZVSLc8ZwHgCfyAeRybx7yvgCk9snU9b
         GQxaLP2pEN0A7bYRMxcVmWvCSobY4Izh/L1EdTd1rDfK9rHcqqhOGDFJO63BMIFQPR5Z
         GAGA==
X-Gm-Message-State: AOAM5329ABgNShKGGRZfzhTN5kl2oZLkLLIW6eWVULzow92gFDxi7KTU
        gJGtVGHwImnOBTdZ/NTdiUI=
X-Google-Smtp-Source: ABdhPJzuJeIHIoMoopdiOWbcCLpkYzKZqciHuqB3W789RXRUKXqWmwjGtHpv09mTccM0lx2XADiJ3Q==
X-Received: by 2002:a17:90a:ab8b:: with SMTP id n11mr17233867pjq.109.1614607455140;
        Mon, 01 Mar 2021 06:04:15 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:14 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCHSET 00/11] perf test: Fix cpu/thread map leaks
Date:   Mon,  1 Mar 2021 23:03:58 +0900
Message-Id: <20210301140409.184570-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset fixes memory leaks in the perf test code.  In my company
setup, it runs daily with various sanitizers on, so I want to reduce
the failures due to the leaks not the logic.

This time I've focused on the cpu and thread maps as they are obvious
and easy to fix.  I'll take a look at the rest failures.

I didn't add the Fixes: tags since most changes seem to predate the
libperf change.  I'm not sure if I could just add the original commit
hash as this fix is meaningful only if Asan is enabled..  I'm afraid
the stable tree maintainers will see patches not applied cleanly.  But
I can add them if you want, so please let me know.

It's also available at perf/asan-fix-v1 branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (11):
  perf test: Fix cpu and thread map leaks in basic mmap test
  perf test: Fix a memory leak in attr test
  perf test: Fix cpu and thread map leaks in task_exit test
  perf test: Fix cpu and thread map leaks in sw_clock_freq test
  perf test: Fix cpu and thread map leaks in code_reading test
  perf test: Fix cpu and thread map leaks in keep_tracking test
  perf test: Fix cpu and thread map leaks in switch_tracking test
  perf test: Fix a thread map leak in thread_map_synthesize test
  perf test: Fix a memory leak in thread_map_remove test
  perf test: Fix cpu map leaks in cpu_map_print test
  perf test: Fix cpu and thread map leaks in perf_time_to_tsc test

 tools/perf/tests/attr.c             |  8 +++++++-
 tools/perf/tests/code-reading.c     | 10 +++-------
 tools/perf/tests/cpumap.c           |  2 ++
 tools/perf/tests/keep-tracking.c    |  5 ++---
 tools/perf/tests/mmap-basic.c       |  2 --
 tools/perf/tests/perf-time-to-tsc.c |  2 ++
 tools/perf/tests/sw-clock.c         | 12 ++++--------
 tools/perf/tests/switch-tracking.c  |  5 ++---
 tools/perf/tests/task-exit.c        | 10 +++-------
 tools/perf/tests/thread-map.c       |  8 +++-----
 10 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.30.1.766.gb4fecdf3b7-goog


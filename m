Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52F830BA82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhBBJCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhBBJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:02:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE4C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:01:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so1956228pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOo9RBcYZJl5bCt+dCh4EPsWtE/5iMv+m7SXtUsiZOA=;
        b=s9Jkh56FJWrMfuSCi2G7edXi8/eNVo5DXWWfjVlFHTCbP3f7MSfTjdHT3G3DuTrOWa
         k7kBce+EJwsiJJYXBR+xErHg+9DRZsYqDgy0HX93VLBK30xx9cnUIoDFkdN8tPenYpZk
         gZ4BX1h3MgMBRmM43qPL6rQDoBt21Ah30f5c5T0Hu6BOq2JGVC5XudRrn20ekO0KTzKK
         ThCbkaGRtTNhyMMHIDQdo1ApbYO1vzFfdhjpj8cethHzKzLg5BVEnOp/9oBxvmjYzLYj
         J+5EQaXY8NRQwjpXbkYLmNJAWEHiLvkVB1bsDQpks3xa2OHOcTFgvD2TDvaf6qQy729q
         mmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=DOo9RBcYZJl5bCt+dCh4EPsWtE/5iMv+m7SXtUsiZOA=;
        b=n9JLk9UbjuGVhFd/YIrwaBBnbOqZXhLOCZrnUE9x6kFKh3hQOptqSsoqX0q0BJCR2C
         pQ+7VFXUG35fxlE+bMucwRcRq1aDbZbOosSNZslzcOqxWxfnlEgQIyjeegAy4gItyvbW
         9nvm+jcNKJ8Gaze4aNPo/20unOtHeiNfW7CzgO3spNFz7Z/3q843EnkyA8fBoBrmyb13
         io4T/Fy+LLRZ2mZsPiiQnCtWguZ5HEcFvX9CqwEvQ9mG99eesi39NYj8fHAf7eL8hHlV
         t88LrmnsO638ZHqKKbpsObCLoq53wiEIJNWZCuixC7rDuZjhgPJHOUx86rmQGNaTGzi1
         HhjQ==
X-Gm-Message-State: AOAM533UXPQ4atDRbKMcgT/lyVtReNuZqcfbLw4iPrlENEcZY7HUaPy6
        EeL+fqnl0RBtP5sxx2wTq60=
X-Google-Smtp-Source: ABdhPJwQjxARgVajRtLehB6Isyr3/gngxn+o4I9TjhL7qF1g+7khxclAYWrgO4+c73FXC8Cma3nSFQ==
X-Received: by 2002:a17:90a:b28a:: with SMTP id c10mr2369726pjr.39.1612256485703;
        Tue, 02 Feb 2021 01:01:25 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id t6sm21246909pfe.177.2021.02.02.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:01:24 -0800 (PST)
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
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET v3 0/3] perf tools: Minor improvements in event synthesis
Date:   Tue,  2 Feb 2021 18:01:15 +0900
Message-Id: <20210202090118.2008551-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is to optimize the event synthesis during perf record.

Changes in v3:
 * remove unnecessary pid check
 * update change log in patch #2

The first patch is to reduce memory usage when many threads are used.
The second is to avoid unncessary syscalls for kernel threads.  And
the last one is to reduce the number of threads to iterate when new
threads are being created at the same time.

Unfortunately there's no dramatic improvement here but I can see ~5%
gain in the 'perf bench internals synthesize' on a big machine.
(The numbers are not stable though)


Before:
  # perf bench internals synthesize --mt -M1 -I 100
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 68831.480 usec (+- 101.450 usec)
      Average num. events: 9982.000 (+- 0.000)
      Average time per event 6.896 usec


After:
  # perf bench internals synthesize --mt -M1 -I 100
  # Running 'internals/synthesize' benchmark:
  Computing performance of multi threaded perf event synthesis by
  synthesizing events on CPU 0:
    Number of synthesis threads: 1
      Average synthesis took: 65036.370 usec (+- 158.121 usec)
      Average num. events: 9982.000 (+- 0.000)
      Average time per event 6.515 usec


Thanks,
Namhyung


Namhyung Kim (3):
  perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
  perf tools: Skip MMAP record synthesis for kernel threads
  perf tools: Use scandir() to iterate threads

 tools/perf/util/synthetic-events.c | 83 +++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 30 deletions(-)

-- 
2.30.0.365.g02bc693789-goog


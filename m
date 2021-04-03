Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128413532F1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhDCHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhDCHX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:23:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF32C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:23:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so3490605pjg.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bvw4GzQn65DZ4pqQ+AEs3gw49XLdASJ2qk5ucIwMhWc=;
        b=vfxmwLq1Wa5/v6Q8MWuThJ/u1mb6ks/kJNkdjYnd1bL/Q1b82OuQ2m9AleIPnLJ+4W
         w0X55rkfipyIZaoJhMUzRyf5U5j2IeKR1nqywSH2m0BKU5FGQV+PSTR4RO+7n6i2T0yL
         Hl7FWaWMv24yGF6puX1wS4om6e3OO2Bz/HX5bV211Lu5Jh384LpaIDXuvi2VYh7dtEG+
         YOjEqHdav6fJf+oNvB6ZzIaZepnFEofj3A82TWZK1UN6xfIWMCo5Tu+DNq7a14cLpqVZ
         jWjQhTNJoWiRz8mRHRb5xP2zJ+WDQ+uM77vjCMlq0uAWM+8D8UhtUmPJHe0aHHm0DsH8
         hYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bvw4GzQn65DZ4pqQ+AEs3gw49XLdASJ2qk5ucIwMhWc=;
        b=Q7SDY9tlpQkfPbnbFwNwnQ6usGCxB8pM45Dvq0xYt718vQhxyXWSstuoICbKyEcLhR
         10Fs+o1Rm2TFtFBhAY1R3lgQvrsTQ9giRjodDOPEwIIYmq8NP0aBRBbKU/+oiIxmi07w
         eUsYYX3BXEqEWfrvVlJXOw9sygUYkT1R+PFo7KzOBwr0tauMmPsA6v7lJmNtWHtN60Qk
         nWApqqQ4C/R6kOyjo0VCjbCE+2KbhpdWB+GLmGVcfAbtl897VCuF/fbt2u84C+7bnZsn
         plXWVBRlwCXQFpbSomvutBgIA5IXSxKAR8kce6Qi0LoUODueMO3FnQWSxXKwA8Xn4IGa
         ndtg==
X-Gm-Message-State: AOAM533ySLTJBYGFFu+uY7NTxg4pqyu3Oa++VABPkfZWEj6XVLfuB7aq
        2DcIBBCo39BzgwqmCSOCzKSjJhc0pAtiVRM+Gwk=
X-Google-Smtp-Source: ABdhPJzo0Z+ZiHQT4uddJs2d9jflhbxk1HHdYlKqMxcnXX45d4aM+OCFQj89QTB23YiQrq6Vj85fuA==
X-Received: by 2002:a17:90b:e87:: with SMTP id fv7mr17331255pjb.27.1617434634053;
        Sat, 03 Apr 2021 00:23:54 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id y4sm9691865pfn.67.2021.04.03.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:23:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/7] perf arm-spe: Enable timestamp
Date:   Sat,  3 Apr 2021 15:23:39 +0800
Message-Id: <20210403072346.30430-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we know, the timestamp is important for AUX trace; it's mainly used
to correlate between perf events and AUX trace, allows to generate
events with time ordered manner.  There have several good examples of
enabling timestamp for AUX trace (like Intel-pt, Intel-bts, etc).

Since the conversion between TSC and kernel timestamp has been supported
on Arm64, TSC is a naming convention from x86, but perf now has reused
it to support Arm arch timer counter.

This patch set is to enable timestamp for Arm SPE trace.  It reads out
TSC parameters from mmap page and stores into auxtrace info structure;
the TSC parameters are used for conversion between timer counter and
kernel time and which is applied for Arm SPE samples.

This patch set can be clearly applied on perf/core branch with:

  commit 6859bc0e78c6 ("perf stat: Improve readability of shadow stats")

Ths patch series has been tested on Hisilicon D06 platform.

After:

  # perf script -F comm,time,cpu,pid,dso,ip,sym

              perf  2408 [032]   168.680297:  ffffbd1253690a3c perf_event_exec ([kernel.kallsyms])
              perf  2408 [032]   168.680297:  ffffbd1253690a3c perf_event_exec ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680317:  ffffbd1253683f50 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680317:  ffffbd1253683f50 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680319:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680319:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680367:  ffffbd12539b03ec __arch_clear_user ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680375:  ffffbd1253721440 kmem_cache_alloc ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])
   false_sharing.e  2408 [032]   168.680376:  ffffbd1253683f70 perf_iterate_ctx.constprop.0 ([kernel.kallsyms])

Changes from v1:
* Rebased patch series on the latest perf/core branch;
* Fixed the patch for dumping TSC parameters to support both the
  older and new auxtrace info format.


Leo Yan (7):
  perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
  perf arm-spe: Store TSC parameters in auxtrace info
  perf arm-spe: Dump TSC parameters
  perf arm-spe: Convert event kernel time to counter value
  perf arm-spe: Assign kernel time to synthesized event
  perf arm-spe: Bail out if the trace is later than perf event
  perf arm-spe: Don't wait for PERF_RECORD_EXIT event

 tools/perf/arch/arm64/util/arm-spe.c | 23 +++++++
 tools/perf/util/arm-spe.c            | 89 +++++++++++++++++++++++-----
 tools/perf/util/arm-spe.h            |  7 ++-
 3 files changed, 103 insertions(+), 16 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5C3BABBE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGDHTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDHTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686FC061764
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso9403587pjp.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRbg9p2vbCl+er+gUJXwktP/Keb1bUuPjxMHf1K9hqI=;
        b=zHbowTD9YUbL0suwxG3+QDGgODWVtKvECn0sVqD0RcwXz23Ge5tFD0JQIPWQD9eEM5
         s241NCR6rR9UB3/lYt5LzyczGFyATjzBPT+YtnC/PIq6jNuDw0XqQuUXKFlRFoIn/Do5
         +7jWo6cYV1p88e9bu+BEz4JjA2Lv6JpPsA1LUz+ptS4qUSTIq3ap1PAonsPdJr9yrMfo
         JYNmMTU/1wEMhq2xtx+krJrFj9R5BM14vsUHaHHUglyOIQPquRn2E7hMd1sXqK3asIcO
         AesLdY4kbq5zW7j+vsSU2oC2sfAUIq6DHZiv6fRqKLHt4I/T/knutLaBaBszbnedUN/7
         nzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRbg9p2vbCl+er+gUJXwktP/Keb1bUuPjxMHf1K9hqI=;
        b=gG9kz0ID5xmKls4oPtWtNK6luFS0DMsA3+oc+ArbRyHmoPEvNQN8xaHO3A3yR/e8es
         c7jrlRdqQYmGuzOymMz09pjIRjXrP8RlVKo9FMd+sPifOMEhdpwibk4J4Kh7kNMvZUkq
         GekvI9KoH+dDtZFb0qqPCMX6Z9//y2Kvh4mGX4zdeTWplPyi6eXRipdHcmQvva+9mVCP
         tXm3F8W1WgvZhKLkBwghS4/vJlFD18BkoDdhHQdzqRlaCI5ocm+3d8mTWP+rhGkoRPNG
         gRKlk5hwg88hfAvDzHi9MiXN8DWKVE26ng51O17MYa2NU/Sku53eJBLPlC/e7zGQ3V27
         u+uA==
X-Gm-Message-State: AOAM532pQ/k6hK5n6ku7TB5duY/4LmIKoLQVQsbwJcLLAU3/oG621LCQ
        xVzY6O5PaXQFcBjlsSECcaqrsw==
X-Google-Smtp-Source: ABdhPJzcaOKYIxTWXBxt0w5aoD7ycQZHn1CfQDS3U8eB4obSA+HUhexWu9WHUnbSdTYYVa4prYOQbQ==
X-Received: by 2002:a17:902:6e02:b029:128:977c:217d with SMTP id u2-20020a1709026e02b0290128977c217dmr7187748plk.44.1625383026382;
        Sun, 04 Jul 2021 00:17:06 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id w14sm7217964pjb.3.2021.07.04.00.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 00/10] perf: Refine barriers for AUX ring buffer
Date:   Sun,  4 Jul 2021 15:16:34 +0800
Message-Id: <20210704071644.107397-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to refine the memory barriers for AUX ring buffer.

Patches 01 ~ 04 to address the barriers usage in the kernel.  The first
patch is to make clear comment for how to use the barriers between the
data store and aux_head store, this asks the driver to make sure the
data is visible.  Patches 02 ~ 04 is to refine the drivers for barriers
after the data store.

Patches 05 ~ 07 is to drop the legacy __sync functions, and polish for
duplicate code and cleanup the build after SYNC_COMPARE_AND_SWAP is not
used.

Patch 08 is to use WRITE_ONCE() for updating aux_tail.

Since the 64-bit value's atomicity is not promised on 32-bit perf, the
last two patches tries to fixup for perf tool when it runs in compat
mode.  Patch 09 introduces a new global variable to indicate the kernel
runs in 64-bit mode which can be used to confirm if in compat mode;
patch 10 introduces variant functions for accessing AUX head/tail, it
can resolve the aotmicity issue for reading head pointer, and for the
tail write overflow issue it returns error to notify the tool to exit.

Have testes the patches on Arm64 Juno platform.

Changes from v2:
- Removed auxtrace_mmap__read_snapshot_head(), which has the duplicated
  code with auxtrace_mmap__read_head();
- Cleanuped the build for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT (Adrian);
- Added global variable "kernel_is_64_bit" (Adrian);
- Added compat variants compat_auxtrace_mmap__{read_head|write_tail}
  (Adrian).


Leo Yan (10):
  perf/ring_buffer: Add comment for barriers on AUX ring buffer
  coresight: tmc-etr: Add barrier after updating AUX ring buffer
  coresight: tmc-etf: Add comment for store ordering
  perf/x86: Add barrier after updating bts
  perf auxtrace: Drop legacy __sync functions
  perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
  perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
  perf auxtrace: Use WRITE_ONCE() for updating aux_tail
  perf env: Set kernel bit mode
  perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}

 arch/x86/events/intel/bts.c                   |   3 +
 .../hwtracing/coresight/coresight-tmc-etf.c   |   6 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |   8 ++
 kernel/events/ring_buffer.c                   |   9 ++
 tools/perf/Makefile.config                    |   4 -
 tools/perf/util/auxtrace.c                    |  19 ++-
 tools/perf/util/auxtrace.h                    | 109 ++++++++++++++----
 tools/perf/util/env.c                         |  17 ++-
 tools/perf/util/env.h                         |   1 +
 9 files changed, 136 insertions(+), 40 deletions(-)

-- 
2.25.1


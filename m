Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A4A3E44D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhHIL15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbhHIL14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:27:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352A5C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:27:36 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t3so15985167plg.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/+aHLq7iQTHQvse8lBK4UCS63ZAxvJXMyNkAqg6dBM=;
        b=XeC9RsTGxZMmNPGSMZ36jBKda4lwYJNW4jQonBDaQ4ieollr30yeXDOvukJd49x3cO
         zCPnZ5Ojpik0a8R4XWMDzO+jLoDa5nGB2clJbv3THaJo5MtfNkviaSRsBZZPEoLjbgdA
         FCWhrRH8ibsKKPY1x6lX1EuiR2HfcR1dSfanqtVPN8+y/LwCiYOgfImciPez7JlOdX9j
         3dZxVWlf7wBQNW5yVudwjKE+hj2Z5uPJVvO9obZSsPDjCOAMlfYYeKAD/uNrDBiS8Hy2
         oE3lMEf4+VSNPoZW27rUqoJxG4lsGW+iMfloFyGbztXqcMV8doPy10FMJpX8jJpJzVsR
         kVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/+aHLq7iQTHQvse8lBK4UCS63ZAxvJXMyNkAqg6dBM=;
        b=Lp6GEA+/+n7THFIAyvdzoO3qKQmZTq5u5OtU2QmWB/UW1NuWXF2H9d5KcU2d9DlSxl
         oC/hY7u4/JoNlLOwrkPn4QDIFbWN9eJjVF7UkHKfRQqDI95Q+8MMdyTskqw1FXcsN/xN
         IQZ6dV2mN4TLrZPRab958l1GcEeBUGkf10lu2iFdLD+TicKE1z4MmeyF4V+5xqRkgXc0
         28g3EmLqBjiomP9YRsfOO/BjJNXZ8GRJ/QfZ9TrGepR26zdPZiaE818O7A6oM/MpLEoK
         kZqyLByEKgjMwxmF5E9L73XflA6iRl/1c+ZTh77FYlcK5zc/2x0yKabzNabwe6tcmcqc
         kDkA==
X-Gm-Message-State: AOAM533LyC4vJzHGLTWdnGDr7TDFelSMX7UMFaDIPRvUETQ/dxgfsySb
        KHScEJgxowMImVUHc2LSnjNicA==
X-Google-Smtp-Source: ABdhPJzpEvnVFdglrKETSDfohtwNkBqgAITuAfv3vI+IuzpICq6uCOz0156egLMB2k4EGAZggu+6Ag==
X-Received: by 2002:a17:902:a40c:b029:12c:17cf:ab6f with SMTP id p12-20020a170902a40cb029012c17cfab6fmr609701plq.71.1628508455681;
        Mon, 09 Aug 2021 04:27:35 -0700 (PDT)
Received: from localhost ([210.0.159.74])
        by smtp.gmail.com with ESMTPSA id r18sm25123055pgk.54.2021.08.09.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 04:27:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] perf: Support compat mode for AUX ring buffer
Date:   Mon,  9 Aug 2021 19:27:24 +0800
Message-Id: <20210809112727.596876-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better organising and easier review, this patch series is extracted
from the patch set "perf: Refine barriers for AUX ring buffer" .  When
applying this patch series, it needs to be applied on the top of the
patch series [1].

To support the compat mode in perf tool, the patch 01 adds an new item
in "perf_env" to track if kernel is running in 64-bit mode.  This patch
is a preparation for later changes.

Patch 02 introduces compat variant functions for accessing AUX trace's
head and tail, these two functions are defined with weak attribute, so
they can be called when any architectures cannot provide 64-bit value
atomic accessing when perf is in compat mode.

Patch 03 supports compat_auxtrace_mmap__{read_head|write_tail} on Arm
platform.  For Arm platform with compat mode, the kernel runs in 64-bit
kernel mode and user space tool runs in 32-bit mode, it uses the
instructions "ldrd" and "strd" for 64-bit value atomicity.

This patch set have been tested on Arm64 Juno platform for the perf tool
is built with compiler arm-linux-gnueabihf-gcc.

[1] https://lore.kernel.org/patchwork/cover/1473916/


Leo Yan (3):
  perf env: Track kernel 64-bit mode in environment
  perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}
  perf auxtrace arm: Support
    compat_auxtrace_mmap__{read_head|write_tail}

 tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++
 tools/perf/util/auxtrace.c          | 88 +++++++++++++++++++++++++++--
 tools/perf/util/auxtrace.h          | 22 +++++++-
 tools/perf/util/env.c               | 24 +++++++-
 tools/perf/util/env.h               |  3 +
 5 files changed, 161 insertions(+), 8 deletions(-)

-- 
2.25.1


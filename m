Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C2398684
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhFBKcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhFBKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5C2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q16so877313pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orFPAiLjT/TAscUeulOFNpz0N4+/FzjmvGEiheJyemc=;
        b=CfSl7oh/E89fzWzOWN6rxS7VywjKuPgxegQFL/6aij7rHSk3GnslJv9+GgMZdvNiVO
         J8+S5CwfdSox/zeoLFWzo75pgfWY0Sfl9/OIMxMInHnf8laWqv+X3mGWQIgQPE8TMpMW
         CIGU2Vmh57hR0/NlbOG0P+rmvWZ1YrEaJK8nAlX5T35lgzvnkhcKnp4VPVciWTRLMxD3
         H2hgzLpUBj0wooLg0aPzr1wlSO6R1Mx3MubPJlA2SNLbqDc9b6jTpwEF1aHZA67LME6p
         xOcgbAC9feDCfj1NdaDao4k5y9o35PEJtqqyk+OPcEpBRaQTHVDa2dAx3w7WXsw0DEGD
         lNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orFPAiLjT/TAscUeulOFNpz0N4+/FzjmvGEiheJyemc=;
        b=N6/rrt4xuE4Urr3GYk+UNmGKDLf9EGcfkauzOmGvKw/cIi93nRH1GGJytS03qY4MRR
         vdBKHYAlGKHHvvynCf5LgQjIyrNb8veitowscE9cEBd7+8oyyxiHdbyfJYRyn4msCuEV
         3orjgCwMR8iT3ehwaWUDh3MRfRg3MWg4XAXrzOReUaI8k85RLoClyjnAX7q88SHhoWPa
         hvXNgCuMiy/lyUQ4yNDsXDHwGNBGzMh4PJkOOI0b2dS6KdDnbK2kconf/LDBAJwS0pve
         2nAp8CI2TAg+nI1rqaDAlsFS6RIiy8JV+4nVUQ4EaNzwJ2lWVD6YZMry4mtGR3WhW2/p
         vaZA==
X-Gm-Message-State: AOAM531hhnWgartRlzxDijyV8YTdg/mj8KpcnYSvrj0B6uZuCoM49G9r
        GuM7rT9A+4r9GR9AXc2E8w0c/g==
X-Google-Smtp-Source: ABdhPJz+UfKUHNBsKrx5b1awAHIiQVkHkRyYDEPH3BFTFogJWWjo/G6fYkl4CNcHTzlQU2fiU7lkhg==
X-Received: by 2002:a17:902:b10a:b029:f9:a0d:14a5 with SMTP id q10-20020a170902b10ab02900f90a0d14a5mr30455865plr.44.1622629815343;
        Wed, 02 Jun 2021 03:30:15 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id gg22sm4521060pjb.17.2021.06.02.03.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:14 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/8] perf: Refine barriers for AUX ring buffer
Date:   Wed,  2 Jun 2021 18:29:59 +0800
Message-Id: <20210602103007.184993-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the discussion [1], this patch series is to refine the memory
barriers for AUX ring buffer.

Patches 01 ~ 04 to address the barriers usage in the kernel.  The first
patch is to make clear comment for how to use the barriers between the
data store and aux_head store, this asks the driver to make sure the
data is visible.  Patches 02 ~ 04 is to refine the drivers for barriers
after the data store.

Patches 05 ~ 07 is to fix and clean up the memory barries in perf tool
for AUX ring buffer.

Since the 64-bit value's atomicity is not promised on 32-bit perf, the
last patch is to report error and let perf to directly exit for this
case.

Have testes the patches on Arm64 Juno platform.

[1] https://lore.kernel.org/patchwork/patch/1431867/


Leo Yan (8):
  perf/ring_buffer: Add comment for barriers on AUX ring buffer
  coresight: tmc-etr: Add barrier after updating AUX ring buffer
  coresight: tmc-etf: Add comment for store ordering
  perf/x86: Add barrier after updating bts
  perf auxtrace: Change to use SMP memory barriers
  perf auxtrace: Drop legacy __sync functions
  perf auxtrace: Use WRITE_ONCE() for updating aux_tail
  perf record: Directly bail out for compat case

 arch/x86/events/intel/bts.c                   |  3 +++
 .../hwtracing/coresight/coresight-tmc-etf.c   |  6 +++++
 .../hwtracing/coresight/coresight-tmc-etr.c   |  8 ++++++
 kernel/events/ring_buffer.c                   |  9 +++++++
 tools/perf/builtin-record.c                   | 17 ++++++++++++
 tools/perf/util/auxtrace.h                    | 27 +++----------------
 6 files changed, 47 insertions(+), 23 deletions(-)

-- 
2.25.1


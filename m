Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D4F36D6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhD1L67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD1L65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:58:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079FC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j7so35127641pgi.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkMbPMNc8FrnP1KGwkLDeuVNNhulyW7sGFTZ5AZrIsI=;
        b=ZLckhhCpN9pyq4UEm0Ez/r/KXh8xRLpXup/VBIVgEsRqD98hdgMxzWzr7olhSXOp2E
         po1SKCue0Fd2QRSyGk1k7r1aA1C7kVwAHPRvQL+H909rxysQmmbzGlHh3RpN9D3cGURT
         HfROCIylDpoxmuDlQYO7MSfWYW6jDJ0UomFFEYhubHFMcqmzo5/4xx9MJPjmvWdG07zw
         lb2ohJugNDyEZ7fBrjWTylpHkT4QtdTlctkqp1dUYM8cfjxykog0kNLQ6CQgpzlsBi4F
         TLtauOtH2Nc2gjyn522V5o6uQH95rToghX421exiZJ8vdKggAxp7ZJnNm4owgUQMeoYe
         kvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkMbPMNc8FrnP1KGwkLDeuVNNhulyW7sGFTZ5AZrIsI=;
        b=ip4IqxuxOjPwsxWyPP0EmMsUkoU0B7vtAIs90WrNPx4mt6uevqC9TxoAs6FhpVDsac
         1w5QdH6NR6or25gRIqBpR12sMpfc1KBHU92FfnyO50Jl0+Cfbrsu1kJzghGKc3KuygtP
         qYdeElk8gBk43iiMPlRMh1QeAM0rtz0vp/yzkWg97+Q9SmMVwgNVOuTDXj3SQxIppRHi
         tOhcsn9VEco1RexieCYEZEiZZhMfUYzUy+8DEnBl3zL5LOvBvmxxD51q/kHUjgfpA3OT
         IcPMaZAe4eAi/wTy4fYbs9rR4p3MPc6NWNY0fCgP41A0sc6xcQYz8QEBaKLgZK70aFhw
         RU7g==
X-Gm-Message-State: AOAM531KoxZRCaBi56Fgr0PBg0+cEgj9O8ATVplfXELCvUoOtKC0oIRD
        eXGi70X8EoG7V5/RbSs5tCqfsQ==
X-Google-Smtp-Source: ABdhPJzjKP3SaW1skFaXQk2w6oVlp46c3Ap84jbXg1gAv9zIf11TRLHkDu14Qi6IKiq+sVnBPAIPqw==
X-Received: by 2002:a05:6a00:2283:b029:261:abae:917e with SMTP id f3-20020a056a002283b0290261abae917emr27308366pfe.78.1619611092089;
        Wed, 28 Apr 2021 04:58:12 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id pc17sm5010138pjb.19.2021.04.28.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] perf: Allow TIME_CONV to be backwards-compatible and dump it
Date:   Wed, 28 Apr 2021 19:57:45 +0800
Message-Id: <20210428115749.5229-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event PERF_RECORD_TIME_CONV was extended for clock parameters, but
the tool fails to be backwards-compatible for the old event format.

Based on checking the event size, this patch series can decide if the
extended clock parameters are contained in the perf event or not.  This
allows the event PERF_RECORD_TIME_CONV to be backwards-compatible.

The last patch also is introduced for dumping the event, for both the
old and latest event formats.

The patch set has been rebased on perf/core branch with:

  commit 4c391ea001cb ("perf beauty: Fix fsconfig generator")

And the patches have been tested on Arm64 HiSilicon D06 platform.

Changes from v1:
* Changed from bool to __u8 for perf_record_time_conv (Adrain);
* Added helper event_contains() and used it (Adrian).


Leo Yan (4):
  perf tool: Change fields type in cap_user_time_short
  perf jit: Let convert_timestamp() to be backwards-compatible
  perf session: Add swap operation for event TIME_CONV
  perf session: Dump PERF_RECORD_TIME_CONV event

 tools/lib/perf/include/perf/event.h |  7 +++++--
 tools/perf/util/jitdump.c           | 30 +++++++++++++++++++----------
 tools/perf/util/session.c           | 28 +++++++++++++++++++++++++--
 tools/perf/util/tsc.c               | 30 +++++++++++++++++++++++++++++
 tools/perf/util/tsc.h               |  4 ++++
 5 files changed, 85 insertions(+), 14 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854F3945B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhE1QRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhE1QRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 12:17:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF75C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:16:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v13so1842739ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmzoCJf4YAFPMLbMFaDyVjzU4iVcJhDZdLSLwXHbWZk=;
        b=oM9RJaxUoVmpzobf0ygLoYq4B+VP2wfYxqPxmE55Pjb9KwHdxe1RUTmM2wygin375H
         DuRL2ALbaqWfPBAH78BOZRkrfUi0KxrgD3OeqNbT1MgRUbO4yoXUe17krf2lEeHMIwyQ
         wM6M7Pa1D/mU60F22Qnd3fJsw4gg6PA/T3CoJi4rNasRo466GQgjeq2z/xqnJpGJ0jld
         4lbGFpJTS+FGcfBvRqWaSnCRXrjshfeBvKlc+Ub9na8kOT3gSzYpuynj1E9DtnAy1dJl
         kZzn/zJh1MYeNNXv+yZ3vm6tGjRSXGXH2nE0tDQzC3bex8V9jgveEwbaEn83pAUA+x2s
         rmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LmzoCJf4YAFPMLbMFaDyVjzU4iVcJhDZdLSLwXHbWZk=;
        b=OT18PQTIQVQ38XBPkUaYSkdp+toESjyaU4xeOiPx4IRamrsGNVSJbBJX56zDYmiKqR
         ETa69/cJO+xYAcaup3bJQRG1n+bXT/GpviBhOBX8grd4qS8/pAozA2oa1J2+OuGzuR85
         m16LbhFjZNhq+yJdcvWvAGQaoFb5zgT7MREfEw4vXR0wrHRMoTdFf3IVi8GDLKnitMUD
         1/91JeeYQ0/l90hU2iZZDolnQGFLhhAa+QBY4JeA1uMOtGhI45FeF2jUqTQccXM9wjtT
         hLSAcBIkb4jG2D9xYQdEXKoZEA4xJHbuKexebNAyLsRYh7ti/7DBnsy9Mc2qEtpvMN9E
         Ba4g==
X-Gm-Message-State: AOAM530NRjxgHqLIwZ3yCvQHt8RRdUL0N4D8pBHhZ/v79q7l6kGJkGrG
        5VqBY7FDcG0tOB5+JZcEeuNciA==
X-Google-Smtp-Source: ABdhPJxLpioen06LQ4X2LW+DpaHIPaW74TwQtyghkALt9YuqOH0l67rzIcFiS9+prlQr3OhHDe2UCQ==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id a4-20020a1709029004b02900f0b40d038dmr8786668plp.85.1622218561662;
        Fri, 28 May 2021 09:16:01 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id o10sm4667028pfh.67.2021.05.28.09.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:16:01 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] coresight: Fix for snapshot mode
Date:   Sat, 29 May 2021 00:15:49 +0800
Message-Id: <20210528161552.654907-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to correct the pointer usages for the snapshot
mode.

Patch 01 allows the AUX trace in the free run mode and only syncs the
AUX ring buffer when taking snapshot.

Patch 02 is to polish code, it removes the redundant header maintained
in tmc-etr driver and directly uses pointer perf_output_handle::head.

Patch 03 removes the callback cs_etm_find_snapshot() which wrongly
calculates the buffer headers; we can simply use the perf's common
function __auxtrace_mmap__read() for headers calculation.

This patch can be cleanly applied on the mainline kernel with:

  commit 97e5bf604b7a ("Merge branch 'for-5.13-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu")

And it has been tested on Arm64 Juno board.


Leo Yan (3):
  coresight: etm-perf: Correct buffer syncing for snapshot
  coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer
  perf cs-etm: Remove callback cs_etm_find_snapshot()

 .../hwtracing/coresight/coresight-etm-perf.c  |  30 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |   2 +
 .../hwtracing/coresight/coresight-tmc-etr.c   |  10 +-
 tools/perf/arch/arm/util/cs-etm.c             | 133 ------------------
 4 files changed, 32 insertions(+), 143 deletions(-)

-- 
2.25.1


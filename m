Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A735C254
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbhDLJnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbhDLJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:54 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA059C06138E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f29so8882785pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QeA4bIK5GaZsi48yUhmbO7fOznvzIDvWJ10aqKKUg0=;
        b=vt2TktJL6sP6xFjdFxGR7uglI/UC0Owncgl8oyIgcTZouxROhQ4JVSQBQ4nDOL/4Qj
         I8slMZbYCulDkKW2d+RvBuWslqB0rQ9oQ0Q3uOyhPTlaw6kaNamGmyqxKFmp79aZJtWH
         0HwAxCww3+LRgwE4Y3/RdPoNUHfydxxQzUxPlMF8C0C1l5OArPdsi5zWFbgUv+SZbPMV
         GhBS2qouSqcjPaz3ed9eeIROs6d/FECR31NybBYArkfO9Ffr9OkTD/bUE6rGGvQbhToH
         WKmoOYCrtdKmQgpkacR5WWXXkZrdi5v5uS4w3fk3XaUvAa1gqSy6ExTgfugTODb7dxbH
         xJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QeA4bIK5GaZsi48yUhmbO7fOznvzIDvWJ10aqKKUg0=;
        b=kAbdmUE1L0PMOTxlDznjx06Ce5XGmLNXz2GYqtBI1dVWNH3fAluZ1ubxT1pvCPg1+V
         jGhNHXrJGBny5A63tB3A5msWaWVmQf7gCTRG7vOGYXsYmo7jevCqL17sgk9WGluSNsf6
         dR80O34J73Y/XDRb30flBTEzOu4ltmyiqo95omfCOCl7EAfF7ec32CzP3RJ93zh4ppCe
         AsfZpaZI1Es0/NVgj2fAIE/oh6ogAW24dRpZhbgrlWwnQXGEd3j23IkIrLB1VXZM+dKv
         gAWW5mnbVhaFjAoqhTVw2aDT+6PDMT2KAQCDiASxlpwqmCshy0hKgERKsdxlkJqE5xyM
         vZvg==
X-Gm-Message-State: AOAM531v/0J9en9HcdHujRfjgRuWaJOZWtiI5f0ZLW2LbVod5m0V3Lny
        p2zfq83DLwf1RnFhjjOtHs/mUw==
X-Google-Smtp-Source: ABdhPJx0D8tER8JD0nOmci8alet46I5dGHvx0NScfJNBsS9ElKisGVU5VVvwo9X10yefzRdfZOZiaA==
X-Received: by 2002:a63:77cf:: with SMTP id s198mr25996394pgc.252.1618218621208;
        Mon, 12 Apr 2021 02:10:21 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id l10sm9231324pfc.125.2021.04.12.02.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:20 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <James.Clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 0/6] perf arm-spe: Enable timestamp
Date:   Mon, 12 Apr 2021 17:10:00 +0800
Message-Id: <20210412091006.468557-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable timestamp for Arm SPE trace.  It reads out
TSC parameters from the TIME_CONV event, the parameters are used for
conversion between timer counter and kernel time and which is applied
for Arm SPE samples.

This version dropped the change for adding hardware clock parameters
into auxtrace info, alternatively, it utilizes the TIME_CONV event to
extract the clock parameters which is used for timestamp calculation.

This patch set can be clearly applied on perf/core branch with:

  commit 2c0cb9f56020 ("perf test: Add a shell test for 'perf stat --bpf-counters' new option")

Ths patch series has been tested on Hisilicon D06 platform.

Changes from v3:
* Let to be backwards-compatible for TIME_CONV event (Adrian).

Changes from v2:
* Changed to use TIME_CONV event for extracting clock parameters (Al).

Changes from v1:
* Rebased patch series on the latest perf/core branch;
* Fixed the patch for dumping TSC parameters to support both the
  older and new auxtrace info format.


Leo Yan (6):
  perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
  perf arm-spe: Save clock parameters from TIME_CONV event
  perf arm-spe: Convert event kernel time to counter value
  perf arm-spe: Assign kernel time to synthesized event
  perf arm-spe: Bail out if the trace is later than perf event
  perf arm-spe: Don't wait for PERF_RECORD_EXIT event

 tools/perf/util/arm-spe.c | 74 +++++++++++++++++++++++++++++++++------
 tools/perf/util/arm-spe.h |  1 -
 2 files changed, 64 insertions(+), 11 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860135AAF4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhDJFCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhDJFCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C692C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:01:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id i4so3894269pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TgiRaJFqBmvsmznOoufuYH6M5dZcKrePan+fSzUiFs=;
        b=ebj7bkVJFJ4IFpNeeD/7M7t/giKuU5uQR/BXMU32Z5OyAzjhz7XH+RMm8z9MUAd6pc
         EiDmkLEd9nZqc21LELvAe6J9jBYTGHz1FFpKj4boV7AUsKL1QKerzwRMBh6ccIHXm9Qi
         3RBX6FJduzYDRqMj6N8xUU4NM8Ph0w4HTsbp7JtNN8/s2d2nsMfnXL0CUHz+qFmZ0a6B
         uaEsUDSY4TsBBC4iqbaoesv8snnoMPsiO613pJ/krU9SCv2XvOZLUAD9fPKh9Rua7OzI
         jDW6yTKaEbE6pOqXwuXKfyyvcv5q4L5Il+f22OBqq5oO4TadNKZFzYTKC3wFtwoeBpLS
         S2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TgiRaJFqBmvsmznOoufuYH6M5dZcKrePan+fSzUiFs=;
        b=T9NjO2Pows7W7raBT8ERkwdV9Fxz0pxUSTEwSdh15qycvqiGonylw+OMm5OHVGFM+4
         6TMplLSbn0Uzl8n6vCLoRVBezzSMxX6wVueHGI82yMUd+vDi2Pz+g9h6MyVL8xWrXh4E
         fTKxTQCgx1wtaL4cz4Yg71G7q2HpX+XArBmh2Vi2ATKHBLxWS4ySuZPDpyuLJVfb2I+b
         7cF4MGPM9lDc3gq+gCSdmY/1WQ0G/+YS0xa38HslRpj8s33P+amWDrNzYpMyJrkegFGB
         tjzJOwxwC5M7qjAmm6pBckoZlZU508clvNbuH2R17LQ1VZPmEFAJt1HF6IFmoBcdEBoO
         jYew==
X-Gm-Message-State: AOAM5312s8Oa+110sSIIX6HAmfj4WkrWByPWWKJdyVHZkV8DHqp9LpWr
        m//3X7/k5SNpevMhc+ny5SvBlw==
X-Google-Smtp-Source: ABdhPJxad8N511r6NwGuCGqoh3SQ/vLLAzrsnDdpTAiJ2IRwJ+9ETaG3qZvwNMfKuh5tfd+QIZRvqA==
X-Received: by 2002:a17:902:ed84:b029:e7:1f2b:1eb4 with SMTP id e4-20020a170902ed84b02900e71f2b1eb4mr16430980plj.74.1618030914537;
        Fri, 09 Apr 2021 22:01:54 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id 7sm3866279pfv.97.2021.04.09.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:01:54 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/6] perf arm-spe: Enable timestamp
Date:   Sat, 10 Apr 2021 13:00:40 +0800
Message-Id: <20210410050046.5394-1-leo.yan@linaro.org>
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

Changes from v2:
* Changed to use TIME_CONV event for extracing clock parameters (Al).

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

 tools/perf/util/arm-spe.c | 66 +++++++++++++++++++++++++++++++++------
 tools/perf/util/arm-spe.h |  1 -
 2 files changed, 56 insertions(+), 11 deletions(-)

-- 
2.25.1


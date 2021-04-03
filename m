Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC23532F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhDCHYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhDCHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25250C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:23:58 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g35so104832pgg.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk/+cUxEFhkA5Sr23xDJi6lyVwLgABo9cNglBLLd61g=;
        b=YHk7w3DA4tFw0Df6MJMD/RQEw2NgoFnFcWf04Fm+olh8SInRUt0n7EzYdgu4b4L48j
         i4UsXK2FRjoXZkClvTRgZsHbjhv0dCh92mWtjcNVgv+bHns9H7L9A1spcrRDt5ty7hcS
         fZjVNmy7YXGWR5w+T1BF+RYn7RZXZNt+Tlsw9bGiMKIWZJdUcYYVihdeR76C1MhERJnN
         sjzqrV9bAeJlIE5/2yN3KdRCibRIfx/raDGtZQodiyU2FPWKarwwPPA8iNNDmLnvHLUV
         nhToB9WSO9HTgTJmPIvtI3twZzy2HKhhPfQ4C6crn0BZA6RS3EGvKAEQuCTAbYYuCFoS
         BAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk/+cUxEFhkA5Sr23xDJi6lyVwLgABo9cNglBLLd61g=;
        b=WQ9EmIjbVPcOvVQ9Mm9dYLRYHJoHREq96jxBzBSfrHUzXcmcRWkB/oC/kkvCrbFEp7
         AKAQD+ztaP5CiGe5q6DA3QP6s9J3+s6KOomzLyco6z/emeeLIRf5VsvXamhEqMkdRgdD
         2lQcblelHB2b7+3rbRrO/Fxe1VfiKfwq3rYJsgmnweGHK5aJDyo+6PuTFaVYX5vJG12t
         8RPnN61yvgV/HGdRgZq94UgaHNnb5sGi0x4tibMePBy/lgcjVQS4AY5Q/95JBNBdy6/b
         sSDgKVdENqhu0qi2yiH6rJN9/W5ij/kTD72UsSMcs0zcrHHY90IBx+APVdiFThwq9x3b
         F5TA==
X-Gm-Message-State: AOAM5328G4VJh83RR1+R/Vov903INiuyC/F7dZENh1Kvdhm63DOP7Z8t
        hxTFlEoNRhEEhVqfwJrvANujSQ==
X-Google-Smtp-Source: ABdhPJzaJeaBoWymfycnZv1heWFn9DpTBwHayvT+zcKPp9k9fw12A7Xh2d8YISZoc7s9p4rXRoo3vw==
X-Received: by 2002:aa7:8a56:0:b029:1f3:9c35:3cbb with SMTP id n22-20020aa78a560000b02901f39c353cbbmr14809922pfa.24.1617434637670;
        Sat, 03 Apr 2021 00:23:57 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id v2sm9584691pjg.34.2021.04.03.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:23:57 -0700 (PDT)
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
Subject: [PATCH v2 1/7] perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
Date:   Sat,  3 Apr 2021 15:23:40 +0800
Message-Id: <20210403072346.30430-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..105ce0ea0a01 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -11,7 +11,6 @@
 
 enum {
 	ARM_SPE_PMU_TYPE,
-	ARM_SPE_PER_CPU_MMAPS,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC5635AAF8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhDJFCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhDJFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA099C061763
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:02:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so5959252pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldonlZ9vwUBTltfCI1GiIsYf2KMOuo8USr97TAcSYMM=;
        b=bjtDPNSTZO0aYZ6szvGPFul2u9l0UGtVTr0fsrIW0qLHl+vyvUt5AdgJ28cKf18QJD
         EZZGou8FY0gOzpgucSM2oSKCujcH8syC6a5HJqpQqIuVG1iCO8iK0ljVohnrxNpOajP3
         +PYOpKVAegAAXLDyC/HENvHS55X1rzDRjMfZ2U2f0bPCXHD/ndNskdjaz4piHxFkfo8u
         J32FYP2PmyW/k3Szsi+puuRDB15/e+qXZle8J3yNXW068FcdBC+U3mYzLGqO8Uxi22ks
         nu4Qkf/NQGupFwDfpgFN0ILKL6nVHF0bo2+ufLPA8WOgZmS41YlESNmuNANYIcUkuJbl
         Y+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldonlZ9vwUBTltfCI1GiIsYf2KMOuo8USr97TAcSYMM=;
        b=M1GgNJSFHumiNjEbYJ+gnAH/WVHZ47+B4I942V5/y+/ZAeFFadwOzPuIS0u56iYoOA
         lTl4Rr/2kgfUp01cYCVjGa4Iba3O5pRaKnO4OAhvoF7Jb0BnXsRAP+eoAAliikai9bHV
         mfizhkH+J2EoIgMi2wQ/U7P9Q9QMd3VTHmTA/2pC/9el/3xjlmhQKRSU0RsTXVbsXyyD
         JR8SsrvD9Ej/uBlIqK06daeGRYfDhdDwPi/OBThJihra2REo6Oy/t27Hua2q3iRkqFBK
         ynkf/OPtXfTHEj3oHbcoAWfOlCYL+9CB+rnfJjVd1/ZVSSvWz1OL/Lcfd50/AFLyxM+n
         Vc3A==
X-Gm-Message-State: AOAM531vgX2gjpEUD5TKL26115LG33yctQqywJtovmOlRCTdszzkMunv
        QwQA6wJKIewuQOg4knztnE6cYg==
X-Google-Smtp-Source: ABdhPJyyi5ok+gdSArX8iIPD5OsC8Noiegn+PZFOSCbd3tpHsLX04I5N3GHQ3deKmp6BSCQ7+hKL0w==
X-Received: by 2002:a17:902:7594:b029:e8:c21b:76aa with SMTP id j20-20020a1709027594b02900e8c21b76aamr16120415pll.37.1618030927227;
        Fri, 09 Apr 2021 22:02:07 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id c15sm3608092pfi.207.2021.04.09.22.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:02:06 -0700 (PDT)
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
Subject: [PATCH v3 4/6] perf arm-spe: Assign kernel time to synthesized event
Date:   Sat, 10 Apr 2021 13:00:44 +0800
Message-Id: <20210410050046.5394-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410050046.5394-1-leo.yan@linaro.org>
References: <20210410050046.5394-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, it assigns the arch timer counter to the synthesized
samples Arm SPE trace, thus the samples don't contain the kernel time
but only contain the raw counter value.

To fix the issue, this patch converts the timer counter to kernel time
and assigns it to sample timestamp.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index f66e10c62473..ec7df83b50fd 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -234,7 +234,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	struct arm_spe_record *record = &speq->decoder->record;
 
 	if (!spe->timeless_decoding)
-		sample->time = speq->timestamp;
+		sample->time = tsc_to_perf_time(record->timestamp, &spe->tc);
 
 	sample->ip = record->from_ip;
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
-- 
2.25.1


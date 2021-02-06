Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA7311E48
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBFPKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBFPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:10:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419FC06178B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:08:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g3so5095101plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KYgcuzRcK64FqZdfoaXMBAUKCaxi3vx19tf6c3rQi0=;
        b=mmXuJN/1tg0qNcFwFL8K90YVumJto5vA4Aiwf7H4x+s1UCkEoAip9nU0eISzHtWZ47
         moHRovyLLaZ5OAhm0qpe9dMPB0Ut9XFIR0iF4cr5rd7PZLkbdOeV+sCq3kKHCIZXlJbZ
         Ys8ziPbWrnSpPD7L9NjXdfdaj4GNFodCy4Xdav6ILq6aNi1TDpuFfV/cGgnSPUAGG2T9
         Mz3/WxY2R0FiwzjDbcNjLCmWdeA2uCTWeHhyAHlxNpPg8yXym/4z4F/yMMU/544mqqtZ
         MYqFk/JjryOaU1e0EH7e1g81buAUurR7D08f67iZVYut5JcLsiVYAK1gC1MnV/QBSVFe
         eJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KYgcuzRcK64FqZdfoaXMBAUKCaxi3vx19tf6c3rQi0=;
        b=O8oNTttrFbFKcq5wZ8bKCi37k/B2H2H2dnXmT6z55OY5ZgSLNxNrC8Pe6Y13bDOJ5q
         k+6bSzJNsJfM2x3PsosTDxfdDLQgoeUdHxEFJLt8DcoEEEIX9qyba/DJIAOkVe0Jh2fa
         +qM5GKPFa1FgkNv/op1ytex1bBh9j/13f4qkiGHS48H+iVEE7cs6Wny6S+Zj5S7L3abB
         1Qs1aOAzzURlQBl5a0FuA05YJEW2v3k7HSiC7sTn3cezwKcDCd+w6wGFhc1BhRk/dYwa
         J+fFiUSnxZfdS/lj5u4ZyKOYVnSd1SaX2LATWHKK/xvuN+ucrUT/G7JTSHhk/a97IJdj
         C1og==
X-Gm-Message-State: AOAM5305b3j4+t5gcxLuQWSMgybbVX0Kvkc+8WUeYb/60/MkO2qXMqCc
        HGKx1uXPrRGn/LAT/sNnObjcyQ==
X-Google-Smtp-Source: ABdhPJz+CVo/Ac3YMbjwwryPb+EY4OI5OLY0lEqJGPde2t+7ReFRP54LBWUUBaL1JZXJIdlJtFtmTg==
X-Received: by 2002:a17:90b:1081:: with SMTP id gj1mr9294709pjb.231.1612624126320;
        Sat, 06 Feb 2021 07:08:46 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id y3sm8723612pfr.125.2021.02.06.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:08:45 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/8] tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
Date:   Sat,  6 Feb 2021 23:08:27 +0800
Message-Id: <20210206150833.42120-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206150833.42120-1-leo.yan@linaro.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in the commit:

  "coresight: etm-perf: Clarify comment on perf options".

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/include/linux/coresight-pmu.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index b0e35eec6499..5dc47cfdcf07 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -10,11 +10,18 @@
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
 #define CORESIGHT_ETM_PMU_SEED  0x10
 
-/* ETMv3.5/PTM's ETMCR config bit */
-#define ETM_OPT_CYCACC  12
-#define ETM_OPT_CTXTID	14
-#define ETM_OPT_TS      28
-#define ETM_OPT_RETSTK	29
+/*
+ * Below are the definition of bit offsets for perf option, and works as
+ * arbitrary values for all ETM versions.
+ *
+ * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
+ * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
+ * directly use below macros as config bits.
+ */
+#define ETM_OPT_CYCACC		12
+#define ETM_OPT_CTXTID		14
+#define ETM_OPT_TS		28
+#define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
 #define ETM4_CFG_BIT_CYCACC	4
-- 
2.25.1


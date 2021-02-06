Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F66311E46
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhBFPJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBFPJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:09:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E30C061786
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:08:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s24so5200022pjp.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7aI48q96Xs+NZkDeMm3ES5508s06Msw96vC+w3XIvVM=;
        b=JeOxMYY9Npo2EMtuL6jNxEU/nk663O8IoSiZ2rRghyQbqaxrWJEifhMRl3Y2W4zPdr
         rQwEw3wCQqwdqrLyHKgmVG7B1m+eonQkt6GdEsQanVOZcIozSllxTezo1G6QX4NNEtbt
         vn3mdlN+c+BTG6ydoTeZVTxCi+V0bWc4BqYJxz15Ua2MFPH1vhpI5IbJ5JFs52R7/yxn
         3nOpIsw0TxNDMck81ZI5GtY6j1j7ySsPbbeOsnKTM3g25Z2sisR8pkG+t7XPvaiU1JJ2
         42ybEK2XNcTpDJSa1jR3JD9J7YXOrNUtGgLhOzXnnVkkFwpaq1oVKvhO995IsKniggUV
         YmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7aI48q96Xs+NZkDeMm3ES5508s06Msw96vC+w3XIvVM=;
        b=eqxbp8T7MchonySEXh8O2HArzwb6xvq2xGajLSKxKp8v5Np0N1iF9mn1p3THw95IEq
         MkFj6nYHuZRBFa8WBIWch9VH/ja+cK//wpSQFgUykExacQH/bBjJGcIdC8mwDcIG0WwC
         aF0jvzvz0VU2WlfPuwwd3RZlQGcDu0MMUjAmWhIUGCgumRK20dqCNFe9kvYJhJeaL89d
         nZ/QgZuO38/J7N72Q63L/dsrOaa+3hHb8omMHMbr2mhJpnD4/TbExWYlmmM0aX8v9Spl
         5/TIsX/tgDEb2tYr0yOZDlMFXXxnpu0KnUlgxHRMxu2drhDnsUqrqwPG02C9Wrp2COXR
         87yg==
X-Gm-Message-State: AOAM531BZ05HpoIF/xS3a9oSTuP+GV7SgUEEWdePgdguKyRAZqe6+m1D
        5Bd3exck+GG++FkDtxn9gUcnmA==
X-Google-Smtp-Source: ABdhPJyWjUcHphAyyrMEWbYktSwhx7LUJoOKbbIhQ07SdpXChCVJ44g+aBomPt+WTC29zkMv8gyqQg==
X-Received: by 2002:a17:90a:cb15:: with SMTP id z21mr8762633pjt.164.1612624122931;
        Sat, 06 Feb 2021 07:08:42 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id k24sm2808134pfg.40.2021.02.06.07.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:08:42 -0800 (PST)
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
Subject: [PATCH v3 1/8] coresight: etm-perf: Clarify comment on perf options
Date:   Sat,  6 Feb 2021 23:08:26 +0800
Message-Id: <20210206150833.42120-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206150833.42120-1-leo.yan@linaro.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In theory, the options should be arbitrary values and are neutral for
any ETM version; so far perf tool uses ETMv3.5/PTM ETMCR config bits
except for register's bit definitions, also uses as options.

This can introduce confusion, especially if we want to add a new option
but the new option is not supported by ETMv3.5/PTM ETMCR.  But on the
other hand, we cannot change options since these options are generic
CoreSight PMU ABI.

For easier maintenance and avoid confusion, this patch refines the
comment to clarify perf options, and gives out the background info for
these bits are coming from ETMv3.5/PTM.  Afterwards, we should take
these options as general knobs, and if there have any confliction with
ETMv3.5/PTM, should consider to define saperate macros for ETMv3.5/PTM
ETMCR config bits.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../hwtracing/coresight/coresight-etm-perf.c    |  5 ++++-
 include/linux/coresight-pmu.h                   | 17 ++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdc34ca449f7..465ef1aa8c82 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -27,7 +27,10 @@ static bool etm_perf_up;
 static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
 
-/* ETMv3.5/PTM's ETMCR is 'config' */
+/*
+ * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
+ * now take them as general formats and apply on all ETMs.
+ */
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
 PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index b0e35eec6499..5dc47cfdcf07 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
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


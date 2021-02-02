Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0720130C635
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhBBQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhBBQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:39:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20DC06178A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:39:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so15228631pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tq0kn8wQ4cNSCpcYdEBjYPAftV0+h3/NpmhAUshCF0U=;
        b=yTndU65Sl8Ob0YAvVXTHGAV5Nczr4dBuH7X94sJqQXi8KHJE0lShyEaqXy97KTpFgD
         k0jNJzTiHCJybiPEPc+ODJUR4vkxUVrRcIU9CH6k4fniC+smLrA9uToVdOTtsP+X/FqS
         p3sK18lIGGqUbDOHlcdyRLdNGV9HYRVNFgIYV7uIOw+G3FKKZSKeQx6VaUXCex1JjH5t
         oXVgcKHXg/kDGC6SuQeZlUCsQnicneKM0PiXCATjYirhZZU7/EZenYuwkATHt3T0NII6
         27XzYItoSOWWd1ySQJ2KUAlYhR4105L0sSPpN6HqPJjbQ3vg0RZ1OmhN9uVYxGw3uhNQ
         2Igw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tq0kn8wQ4cNSCpcYdEBjYPAftV0+h3/NpmhAUshCF0U=;
        b=uSSIk0Gyp41kI8sUTDkxeztqTl8m5J9V2lET9wkXMAEbCrzVpofQsGZlgZqy9OJ3lP
         UoWLB9pPnGjoSCBCnx1F0K6hLm7ItHUpPdTq0qmlKyasndzWrKApBzu5bC1AKOetcunr
         nThDVXw+qVOhFmTSZ95LuIpKRnDHscVd/Cvz2z0u9TOfkrp+VsIagy3mSYHh7pHKi2bP
         r+4g/yQvknWPuC0q77/3IZjCDcdmWp2xDMKUha9+IwrEJ8aNehkYNwQPY9iKOo+hfMSC
         soLYbf73djbAmtuwlfqL1mgjfAltftWouA9U1o9tem8jrIovjuWW+HEJr9/NgVvqvj71
         X6Wg==
X-Gm-Message-State: AOAM530mNh3G66/1qi+9MMqTRtwBHGX4O9euOUbOhYQgqFSxIxwdEFZj
        ykUG7TATVTJqBr9B+LcvgFJl+g==
X-Google-Smtp-Source: ABdhPJzeOqe2CAs1UnE+QgY8zmh1RJyEOKxmiq5FSu+O0azBurjZtdxZdFhRIuDNxrqMHgCZ3Tk4Ow==
X-Received: by 2002:a63:f905:: with SMTP id h5mr16311501pgi.301.1612283950192;
        Tue, 02 Feb 2021 08:39:10 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id g5sm22521513pfm.115.2021.02.02.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 08:39:09 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/7] coresight: etm-perf: Clarify comment on perf options
Date:   Wed,  3 Feb 2021 00:38:36 +0800
Message-Id: <20210202163842.134734-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202163842.134734-1-leo.yan@linaro.org>
References: <20210202163842.134734-1-leo.yan@linaro.org>
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
---
 .../hwtracing/coresight/coresight-etm-perf.c    |  5 ++++-
 include/linux/coresight-pmu.h                   | 17 ++++++++++++-----
 tools/include/linux/coresight-pmu.h             | 17 ++++++++++++-----
 3 files changed, 28 insertions(+), 11 deletions(-)

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


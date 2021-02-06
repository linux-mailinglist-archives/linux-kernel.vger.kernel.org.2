Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F1311E4D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 16:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBFPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 10:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhBFPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 10:10:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF1C061797
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 07:08:53 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k22so708216pll.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 07:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYsvbHKaWJFqmZk3Q9+ksW0atKxTMG3xftJaoncz8gs=;
        b=dNGP/2hlQACIFVgVqAZpcOMCki2v+66EQ8TBrZ0HkGU1vdF4megfua9P0HKGvpNazw
         GTb08ugdsqG+adcVgSFXLmRI4zB275pVV9Fe4RTFrxuqmVs/kptl/g+ugvPMrj03PEoY
         Zr2mA69d6sQIZHak0J1XmTDzsUGGstX31y37iYBvxpDOl7EvUd/+o0oA31eRPlHTB0Mq
         y8lzyTW+b18AIspZlpPPbixXmhjY6PhEN+Hrgi6RluDpznis0mF95vjrRvB0IdVz3WPn
         WYOWlwsw+Zf488V4rIABms4TCm80huXZD3GaVla75qIRHfTkppCzAmy1KNa7TLKftTfx
         eNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYsvbHKaWJFqmZk3Q9+ksW0atKxTMG3xftJaoncz8gs=;
        b=clqHrZSVMUC20Dkffnn5sYjxdETiaoIyAQPmtu77OxpwONUI7DeWp9Vbs4jDXF/1nw
         wy+sfzYnwN8lbqrASxQgFYXOtl0uAlkfSLSi3e2hwThwu7tHRmCquzrqHGbEoKKqfE46
         EFfgFjirIq8thl46O6bfkvn1QxL7PH3khthvazpsp/PGwJC0HWTL0qI5UgH/pwhWqOD0
         KM6omdlMrPjEhslpZWgIYwujnhQis1E9Pu2+i1QXYp0mERUW5hV9Ce4cXB8j2+dXruhd
         yD9Ahc+Vm0TUSDRTJlIO99SmegnJ/QmSHGN/o6bZZh7gyEcEpBdkZxFP28rWqhr5gosB
         XxXw==
X-Gm-Message-State: AOAM533GE9eNusAxuXaZX1ZaqXMiVV0qOZXfV3k8AhfSmFqyKMie9q7W
        rAJdBdHfyii6WRZi7XphHtgx6A==
X-Google-Smtp-Source: ABdhPJy5Kt2RYWfoS5BP+one494ix3rqIBAWlKT0wTwuY4x0rPYFzi1BDUE/E0AOrgyBFjSsr2UDjA==
X-Received: by 2002:a17:90a:f0c7:: with SMTP id fa7mr8463150pjb.201.1612624133053;
        Sat, 06 Feb 2021 07:08:53 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id x17sm13394623pff.180.2021.02.06.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 07:08:52 -0800 (PST)
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
Subject: [PATCH v3 4/8] perf cs-etm: Fix bitmap for option
Date:   Sat,  6 Feb 2021 23:08:29 +0800
Message-Id: <20210206150833.42120-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206150833.42120-1-leo.yan@linaro.org>
References: <20210206150833.42120-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When set option with macros ETM_OPT_CTXTID and ETM_OPT_TS, it wrongly
takes these two values (14 and 28 prespectively) as bit masks, but
actually both are the offset for bits.  But this doesn't lead to
further failure due to the AND logic operation will be always true for
ETM_OPT_CTXTID / ETM_OPT_TS.

This patch defines new independent macros (rather than using the
"config" bits) for requesting the "contextid" and "timestamp" for
cs_etm_set_option().

[leoy: Extract the change as a separate patch for easier review]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index bd446aba64f7..c25c878fd06c 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -156,6 +156,10 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
 	return err;
 }
 
+#define ETM_SET_OPT_CTXTID	(1 << 0)
+#define ETM_SET_OPT_TS		(1 << 1)
+#define ETM_SET_OPT_MASK	(ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS)
+
 static int cs_etm_set_option(struct auxtrace_record *itr,
 			     struct evsel *evsel, u32 option)
 {
@@ -169,17 +173,17 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !cpu_map__has(online_cpus, i))
 			continue;
 
-		if (option & ETM_OPT_CTXTID) {
+		if (option & ETM_SET_OPT_CTXTID) {
 			err = cs_etm_set_context_id(itr, evsel, i);
 			if (err)
 				goto out;
 		}
-		if (option & ETM_OPT_TS) {
+		if (option & ETM_SET_OPT_TS) {
 			err = cs_etm_set_timestamp(itr, evsel, i);
 			if (err)
 				goto out;
 		}
-		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
+		if (option & ~(ETM_SET_OPT_MASK))
 			/* Nothing else is currently supported */
 			goto out;
 	}
@@ -406,7 +410,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		evsel__set_sample_bit(cs_etm_evsel, CPU);
 
 		err = cs_etm_set_option(itr, cs_etm_evsel,
-					ETM_OPT_CTXTID | ETM_OPT_TS);
+					ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS);
 		if (err)
 			goto out;
 	}
-- 
2.25.1


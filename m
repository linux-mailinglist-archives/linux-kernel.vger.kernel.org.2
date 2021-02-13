Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78D331AB0F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 12:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBMLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 06:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBMLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 06:33:22 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADADBC0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so1120139pjj.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lf5+wHFh/Uek5hfHg7++IxniwiE0WRCCl0ivatRXUfQ=;
        b=lUtUrdV8F5yVgAvbTvW16yTgqa31k6nD3PABB/VX6Ie5khOCXRKBppUv2Eh7zoKY40
         PCNC5YXN0Enb/LRKTLPnTQcPkEDLHIX98rurIsPZFLK36JbPj8I/9OJ8VKqLmGKZ6oaZ
         RV0LfgPu2wy/n6Ftcze5XJREfSfz2k2rPOsaYDv5rgNw5KDd5+87VGCL6WhveJeQFcDY
         R90CpjYBQdVHmyeLk+nt/SKckLl0CpE8eKED+ZE+t5QDu6SgbYiR+/5cnARsUPxoQGDW
         0WtX8fDpervJet2IhXJE3EVr5IPnR7EmriG1RT1SpdRbi/afHUUnUmXpcIiTCihI1BQ8
         3+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lf5+wHFh/Uek5hfHg7++IxniwiE0WRCCl0ivatRXUfQ=;
        b=B6sk12EYsL/XCtyo2FZlDvhpJ5RkTaRrFh1iiqJaUQWrObZn2ocKfvep5kKx8LOCFM
         guS7JjRcFVp28dDB96demMv8HapDz9zuVOr5UOy7cj8ETUj5PVzCrqkuV8JvyT4HHR14
         TxSm4vi2KUj2t6oL9P8/inrb9zcT0YAZkgVQuS13Ozr7neyNgXqXduaOhNy4oJ5pyvu5
         5M9tkmRYmWKZaFIYgsqlH4FnTbOZPwiTqzNzYPSSk8aWPm4Z9C8PlBV/Ab6dXttOInUO
         qZhpJwLtrZM6ijRLrhcvHikoR7WemA6SZHyHKTukti980poD3fliTN3olyQBmaOokwTb
         nB+w==
X-Gm-Message-State: AOAM532l9GuVrHg5YY40wfPQvLOTYIlf4U9hfB6HUlhsfEhiBzHGampr
        2ZzOqGGdwhL4U4zOBaHm5bYTPQ==
X-Google-Smtp-Source: ABdhPJxT28EgGbln89SxHYgR1TIwNUs6SMv9hpBmGRLMkrHW9XauOOndQ/Qoc2uCFGD5cxNRM88avQ==
X-Received: by 2002:a17:902:e74b:b029:df:e5d6:c35f with SMTP id p11-20020a170902e74bb02900dfe5d6c35fmr6473691plf.57.1613215956235;
        Sat, 13 Feb 2021 03:32:36 -0800 (PST)
Received: from localhost ([45.137.216.202])
        by smtp.gmail.com with ESMTPSA id z125sm13997662pgz.45.2021.02.13.03.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 03:32:35 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/5] perf cs-etm: Fix bitmap for option
Date:   Sat, 13 Feb 2021 19:32:17 +0800
Message-Id: <20210213113220.292229-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210213113220.292229-1-leo.yan@linaro.org>
References: <20210213113220.292229-1-leo.yan@linaro.org>
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

This patch uses the BIT() macro for option bits, thus it can request the
correct bitmaps for "contextid" and "timestamp" when calling
cs_etm_set_option().

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[Extract the change as a separate patch for easier review]
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index bd446aba64f7..ad8421e8b651 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -169,17 +169,17 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !cpu_map__has(online_cpus, i))
 			continue;
 
-		if (option & ETM_OPT_CTXTID) {
+		if (option & BIT(ETM_OPT_CTXTID)) {
 			err = cs_etm_set_context_id(itr, evsel, i);
 			if (err)
 				goto out;
 		}
-		if (option & ETM_OPT_TS) {
+		if (option & BIT(ETM_OPT_TS)) {
 			err = cs_etm_set_timestamp(itr, evsel, i);
 			if (err)
 				goto out;
 		}
-		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
+		if (option & ~(BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS)))
 			/* Nothing else is currently supported */
 			goto out;
 	}
@@ -406,7 +406,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		evsel__set_sample_bit(cs_etm_evsel, CPU);
 
 		err = cs_etm_set_option(itr, cs_etm_evsel,
-					ETM_OPT_CTXTID | ETM_OPT_TS);
+					BIT(ETM_OPT_CTXTID) | BIT(ETM_OPT_TS));
 		if (err)
 			goto out;
 	}
-- 
2.25.1


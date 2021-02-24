Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9132428D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbhBXQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhBXQt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:49:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88AC0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:40 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id u26so1689303pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN1xkXCNY+ia4CNPv3REFEERkQ1m3v/JN5PUoVOZIRg=;
        b=TE+uJjfwm+TleSgP/eDzSU8hQx7IIEHB11Q7+BecW5r8/yEtYu2KUrEpcgIgsvndb1
         kEDopWONv1+A/j1Y3Gj0ajE7PUTRfmRhhV/TocLRlIEusnCUVk7C5YExFsWFWy944ruc
         HodZ9bMMGImC3MAfY/me/LS7mHEkym/daKFMZsBDVGEPSiXCkDIsaj17214MRWm1lply
         aQh87SAOwMY8aEXZOknVclXFxYgKEzMqkoI9mx9lLVwHncovlOQ8hreabOh0i064kPtn
         +2zgOF0hHW3J69baKZY+RhjdZ5kKn9mN6ZS8HPOkQaPdzG5duPsHaqgmXQtQSbwkb2RT
         RMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN1xkXCNY+ia4CNPv3REFEERkQ1m3v/JN5PUoVOZIRg=;
        b=UbLcc/3p1uh+BsnDt9YhV2x/lEMownzA/DUY1DbqSLO3SAgpp9SOLyrJarGpW3jrIB
         NsdwilUKdWrCvJ2RDQEc3u2TD1Mh+ewG4a9MjIyl36lOiJTAHSOmM01yw07Th8ww4+TS
         j+DDJHopaAXL8GqK6st2S6RWaJUWXT8R530cWgrf9wKOd0uo2irGTxXbPH7dC6yDpBtG
         bAAwO54vGnvlsryEt24c+fvsajZSeDpnieFhS/off0/7kChErEhP+M6X0QQZec9CEWvV
         xygWEFaye+R87d4iE6Ms8/8CgIY/052I8FSyUOKK46kAk3KXlEY7c0RJgZLBYsRz+rgR
         qICA==
X-Gm-Message-State: AOAM531FkecGn/IE5rx1XlEqt/yoL+Zpa0vu8Ehb75a+4KJbwC0CF210
        ZuUsrl0Tz5aetwagP1SpmG3/NA==
X-Google-Smtp-Source: ABdhPJyRAW/QrRdlQD6eOJMNoQe0a9ijiZme6ta+QFrYj5LDzHW3jSuWtdaiROZL84jSbjVFYoEDIw==
X-Received: by 2002:a63:4654:: with SMTP id v20mr29245081pgk.129.1614185319933;
        Wed, 24 Feb 2021 08:48:39 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m6sm3284793pfc.56.2021.02.24.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:48:39 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] perf cs-etm: Fix bitmap for option
Date:   Wed, 24 Feb 2021 09:48:32 -0700
Message-Id: <20210224164835.3497311-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
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
Link: https://lore.kernel.org/r/20210213113220.292229-3-leo.yan@linaro.org
---
 tools/perf/arch/arm/util/cs-etm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b0470f2a955a..5b2bb7fc5ee1 100644
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


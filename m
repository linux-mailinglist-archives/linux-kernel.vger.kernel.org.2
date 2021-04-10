Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E4D35AAF7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhDJFCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhDJFCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F3C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:02:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y32so5366444pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2eMAvnU/VPv1tOaH24j1fTs/20qgersR7UfBpgGUfc=;
        b=GeWCfq8v7BKxOeZLMYA4WMw4ttCARZDuEUue4sfCkBPbzNy/Y0VbbK58tw20qjz4ol
         YA0CgSmlDd/lLZLavVzWqr9upF621I0KZXY6aZuw1u/LwmULAoLlWpFEGm53M129TOIG
         99ce6ZNEUC2SZw4QB6YP3qqBTvQzUrPnKjnoZl4VnhseUos8vIe1xswrMBPvSuc1FFUs
         xjySAnINzI02vCM5rJ0q+7myQi9k+4MnL+61/AAhlyehFCEJ16ji5dWOEQ5En8e+ilb3
         pSnfLTQAXXxqyo8qqquv4OpGTKPmchAvQzNTo7H67emxXtzI/l8MAW282BbcOTpEEhRk
         pKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2eMAvnU/VPv1tOaH24j1fTs/20qgersR7UfBpgGUfc=;
        b=Bq6DCeNvEF0P00LHFVHTWaaa9l+7NgQ2AhX285QjuxaBDmyb9Ck0iD2ajS4cTaYNJ3
         9PUj3LttJAFrJibND8irRyNvSjG/6rUm9Xlxw8YqNcncrwZDdNB39Aiy1nsznzSzuorZ
         ZiIeX6VyUlhS/qCNvNRQNWZfLbFL6G4pRVbZBDT8noHXKOF8a1iDMHJdOtu/HZecL5G+
         zR/hR26cNROJdneySkn8bv/Qcq2tIyMAvfqXK3tvCah/pXygI5/nktE9wSXyNAFnTLsR
         5MhgjyRlzK05ST67dl4FfA5CAFL68rhMN/LK6THw4WFKK0ENS7+h01p43BZkegwooKgp
         o7OQ==
X-Gm-Message-State: AOAM530HmIEZ37y/+ST5V8zuWCndTt6aARP0cjP7J2z1e26b3qbhiem6
        dGhMrSuuDp8tTvLx3al8Ld1Log==
X-Google-Smtp-Source: ABdhPJzS+S0dzrXM99O8/UPWV3kxKBMLsMGFfEVyW9mZ6F+83Vt8JVXNF3v1JCkFDeEm4SwiHBCVTQ==
X-Received: by 2002:a62:db43:0:b029:244:3c4c:6b90 with SMTP id f64-20020a62db430000b02902443c4c6b90mr11294634pfg.59.1618030924319;
        Fri, 09 Apr 2021 22:02:04 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id w1sm4232233pgh.26.2021.04.09.22.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:02:03 -0700 (PDT)
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
Subject: [PATCH v3 3/6] perf arm-spe: Convert event kernel time to counter value
Date:   Sat, 10 Apr 2021 13:00:43 +0800
Message-Id: <20210410050046.5394-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410050046.5394-1-leo.yan@linaro.org>
References: <20210410050046.5394-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle a perf event, Arm SPE decoder needs to decide if this perf
event is earlier or later than the samples from Arm SPE trace data; to
do comparision, it needs to use the same unit for the time.

This patch converts the event kernel time to arch timer's counter value,
thus it can be used to compare with counter value contained in Arm SPE
Timestamp packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index b48816d5c0b4..f66e10c62473 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -669,7 +669,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_tsc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630FE35C256
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbhDLJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbhDLJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C96C061344
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s14so1466809pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zseEPnoUr9ivu9L6FxmsLFtiTUN3E67cPG71UQDkec0=;
        b=kZfP6rjyHgMWhhRNazBI/9RKNQZdRwp8nK8lC95bIf4FpXRQfoQSyXGUIl0Sd8rB3t
         Ipd0ytq59oqBvZ4XxXjLlD9LKcTJ/aU5AQUdaenYpVmiufcEaA/IUZcijD+dPB6TFdNe
         cNbh5xXPUxBSaTxlGTqFVMMzOo1oEHOQu3D0XvxbnhpjirTFQRt5aI8KLmf4bjlYyz8E
         7GG4zghzwU3vcaFkNtIz9/EEirAkblRh9y72ZfmthwjJgoW0S2+x6+NI2vtUgEhlxiAA
         ib6izNmX0aNJxiN3b3v98Nu49iVftG5uRij2DHDcqsIjNV3KkPoJo9b3FhlCA7otzZSJ
         Hirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zseEPnoUr9ivu9L6FxmsLFtiTUN3E67cPG71UQDkec0=;
        b=Nq4RRl3v/85Ogq3uuT8JrnuI27SUECCcRyedCPwzbX6E7Q4A9xwjCGCPtlB+pmnLIT
         /EiyG9ru+mZLcaXuEtWBgeLTeR4ADMyca1DiusyhCg98ydhjdjQtStfHxNDP0RIJMKbx
         B8FyPSEYVFqeoZ8ZJkii25oASoYTNmXAG28L4PwQbFwrUpndobUAXqPDApUSwtU16wR8
         J0ENlEpKeVfVGv3ZsKzcqfZgp2B6YeNFkFTi5vcMbA1mO/ifBWP9QdMQv0vd2ASG1Rh2
         ckns8SiYBUrFQi/fa5z3+JJcLSt4/J+P1EGC4babpaa1DrG+AhCeWj7gt6XIEaeZBd3Y
         gQQQ==
X-Gm-Message-State: AOAM5303f88T1LfpaP2cTpalHQEOj9nKbqUgK0uZOlTekbeOj45OVEEY
        0iBBCzfP7q3BZYyCAjNd5rSXxg==
X-Google-Smtp-Source: ABdhPJzZWnu4/cFrP8wRNIZ4ptmoUt5/TxqUA/lg4X5nmYbGhoMmSBkscDQ2fPhKcQaMM5DwOGZjNg==
X-Received: by 2002:a17:902:6946:b029:e9:4dcc:9966 with SMTP id k6-20020a1709026946b02900e94dcc9966mr25591582plt.6.1618218633589;
        Mon, 12 Apr 2021 02:10:33 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id n16sm9211548pff.119.2021.04.12.02.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:32 -0700 (PDT)
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
        James Clark <James.Clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 4/6] perf arm-spe: Assign kernel time to synthesized event
Date:   Mon, 12 Apr 2021 17:10:04 +0800
Message-Id: <20210412091006.468557-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
References: <20210412091006.468557-1-leo.yan@linaro.org>
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
index 23714cf0380e..c13a89f06ab8 100644
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


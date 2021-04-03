Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE14E3532F6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhDCHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhDCHYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:24:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B2C061788
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 00:24:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so3513596pjv.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvWLuPq6mG+ewzJDl0OTtXQFVQc7oQ72INsuecPbdF4=;
        b=tX7xn5/oAVWZT8agnPIKhUsVwa+y5tH32C6rhMrC3xd5XV4Q+qt9S/LeU83NswWFnF
         BO17gDAwrOPBKEUweyzdJ/Kmx6wsuSIDwHNFkERh51AUuhm6cBLGxlIAlOFyHxN3RozS
         VqU6BSgchRjVwawbu2mq65GSXYHHb3neOiALkBx/rm5LCJsOeA4lgYleY+Co3J9GrKrf
         4KY6rXVmBpNbigxZzGbMrKB8O7VhcPpwGMAaHv9Smw3sfDDQmTeqUyv/ZPWM+F4QGEqm
         /ObZH18FoGM7RkwXLVI6abs8JQxQC1Ioi5NqNgJVHGVIl98opZ/ZcXuxWM6tHFo+Tz1/
         Iz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvWLuPq6mG+ewzJDl0OTtXQFVQc7oQ72INsuecPbdF4=;
        b=PpBzOKxP1g8+VMFI5nz6tpbvz0rojBJ2+dLj5M69SpyNRdaHODJUqdGV3toOZiPJSx
         F2bPV/osQU5reIruqnWvUlTAGi30mkBlP2UmhZ+iAPF3i/HKjQAPBL88F+LvyfRp+beX
         4o3adtNqI5WVuP/VliSFs3fypYsb9NKYqsPN1j15ShrezbC+Bng+2s0hKiBWbo46ArEN
         iKKmiqQ0U9S3ibIPkG/bkbuw55Vp9DYGv+gm3sUK1cf2uMabRik6JpD+o5A5URLQDbaO
         nuJxx76efEBOJX3OHddZsKDQc2OAg9TuSrzSIoqlrfNxQ/gHsllUPWWVhb/lKh2jkpyD
         /6MA==
X-Gm-Message-State: AOAM531rF77NzMfG1v6h0Zw5N6rQtjOFnoUa5BbRkKX1uo8n1Yz2yY5W
        MTSUn5XrULtQMUXeHwNb4X/iCA==
X-Google-Smtp-Source: ABdhPJxanVXpAQFgwaMGIhmdXHhEZKjGzhZ8f75RkjD1K6x2+w7vrg3X6o8b/y7VVUEy484jWX/IaA==
X-Received: by 2002:a17:903:31ca:b029:e6:65f:ca87 with SMTP id v10-20020a17090331cab02900e6065fca87mr15860056ple.85.1617434650389;
        Sat, 03 Apr 2021 00:24:10 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id g12sm9964387pjd.57.2021.04.03.00.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 00:24:09 -0700 (PDT)
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
Subject: [PATCH v2 5/7] perf arm-spe: Assign kernel time to synthesized event
Date:   Sat,  3 Apr 2021 15:23:44 +0800
Message-Id: <20210403072346.30430-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210403072346.30430-1-leo.yan@linaro.org>
References: <20210403072346.30430-1-leo.yan@linaro.org>
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
index 4cf558b0218a..80f5659e7f7e 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD038880B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239784AbhESHVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbhESHVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:21:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FFC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:19:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id m124so8793738pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xZ1JYU86x9GDV6Fl4hcG6dEfcPMAOex7K5iW9hqWQM=;
        b=U6+8lJ4Pk8JtHFn8B024BbgRWRFCyCrkDS0Bgs8PLztCnYHkfhatiRfpMWjiupEcbw
         VWSNho5nhCcuqMwrsP3+97N0oCgO55Nmt9yrooRm4khn+AUa3GHRIjgyiBb2HydObi5r
         XIHkFtW9YXZ5hnqV2qWhjy4xCiLqtuApq30qrKI/iTn3QKnFythlXlyLKSxmp1bDGo7T
         WtNKIDrIo8g07o2/M9A+4syHOxP1NtVEXlxz6HhKP5UsXaeIfLmFTQhqZsMzypzsNwiu
         P7nXmkz2Be/mo70TN1OXu6sk4r2j0maJDqHoNViETayhTVyJSMF/QEOc2GaK+ufAGk+L
         6NeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xZ1JYU86x9GDV6Fl4hcG6dEfcPMAOex7K5iW9hqWQM=;
        b=oiH8ybiNxbpoGHUl+Zxn6xOPE591T4y6ViX8HBq2auu31uhc2t7MCW/XASoR48eJpf
         44kSu6pdnOnbv8rXrpcOvlShhJgoma3vzUDEsmUuTzvBdJCVgdkqPxS1TctjHJj3BUC0
         P6zROUvlrEhUxJI2xCM5rntiQ9hbdMtuYMky9Q7bWQDW8Nc40EqcW/SN4mSFNRMDlkhf
         v07VsKBGjQE2/M1wyhNxMMOQ8IeVV7/IAnPWeqUxR4E7DemAfNR5JXcecEijsRB2Pa65
         U14cGLR/lE6c+U1tif32qxoDVFRHTJNgiDqUiVYRzfYu/75EEDH+Us5hkiT+Pc0PX38i
         D/zw==
X-Gm-Message-State: AOAM530XR2mPEB+wBm7ye2hWmJNBAdXvUd4vG8dUul2H2MZ4bsiuvRNF
        MxyjzHun97yefjZug5uHj4Fq4w==
X-Google-Smtp-Source: ABdhPJxXKjh4+Y0yqeqxJSJMdI5LxN2W4oL2rsmllBC4cnpR8GGbCdPaAXDKugAwhd//EA1cw4x5eA==
X-Received: by 2002:a62:3101:0:b029:2de:4f8d:2ca0 with SMTP id x1-20020a6231010000b02902de4f8d2ca0mr7454623pfx.65.1621408797702;
        Wed, 19 May 2021 00:19:57 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id r22sm14267134pgr.1.2021.05.19.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 3/5] perf arm-spe: Assign kernel time to synthesized event
Date:   Wed, 19 May 2021 15:19:37 +0800
Message-Id: <20210519071939.1598923-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
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
index ff8b52e6d475..da379328442c 100644
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


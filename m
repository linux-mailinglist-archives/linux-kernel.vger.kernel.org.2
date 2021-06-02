Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B318C398687
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhFBKcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhFBKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:09 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA50C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 29so1845324pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=jHRKX5cUkNuQqA6FcVDelOyL6rHw3QdZHN9QJqi0thrX/s2qZM6IGuYS7Rky09KG9R
         VysMh5AauTe0QUSWhu57mujRxBqQhFwPOPxuOGNTRUHYw+tM923NayUvs0WwJCYHAmeE
         33CPzv15Gz9UninMPEYLTgUnVU5aU2ovg6d1qH8teYiA9Byx8VZ5VuF1k4BaTHj9dnON
         JaFgb6ugdkBDuOmK1GCKfnElu1QeFzgJuaV/WHZpfuWD9i6Jh6QMuSDmyMW2glUF9KuH
         HKuOeo6t7CO1A5YwvZeYygPIec0p6GWo105Oq5oi27FJK8FZRWDNZYBkoz+BJtrr5dGm
         +dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxgwZHP/NxGkiYvHiVeQZZDAd7piMTreovHUTu3tJE4=;
        b=j68xspYe9YF1XgNP5hxcgZGJZUl9+R6+S0c9+RO0cZqN6HfylYgxSLVYl/ny7LsriA
         6Z+OYYYlw7arhvHcWTK+Nl2+ZOH2sLMlbrQd1Ur7cV5O3eSoPYo2pVt+lSQkpwnielL7
         2tKH4wbUWcuCJQP7NPU/7j5co2SN/w+sM497+A5YYPkhtQv5Vo5AUWITM8LqoOGdyFGo
         7FbRFK2uIOix5WH+elv9r5tODwJdJPribAU8XFsBTI0TW2UeiD0rIF7ymHnkpueM7z7P
         vUalnivLPOMbCLZof9qczj6ECxEFfaS65GsvnZfC9RO7z45N0/7IYBRgW9MwCa6EymWj
         6f9g==
X-Gm-Message-State: AOAM533mvJxxH1sQKbJNIVk/o2nySIwmJQ/xvyV1LggaOa7fva4wX78k
        jWLpEX6XO1kRQ1VzgfkrbbQ+rQ==
X-Google-Smtp-Source: ABdhPJzyW6EPkT5gkkT06ZlfTQHfLmc+dwW6YIn3U8DB25Ciy7gNcrlSKpY5YK/BNT72rLsFD/In1Q==
X-Received: by 2002:a62:ea03:0:b029:2e7:8445:243c with SMTP id t3-20020a62ea030000b02902e78445243cmr26382005pfh.54.1622629825762;
        Wed, 02 Jun 2021 03:30:25 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id t13sm8756126pfh.97.2021.06.02.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/8] coresight: tmc-etf: Add comment for store ordering
Date:   Wed,  2 Jun 2021 18:30:02 +0800
Message-Id: <20210602103007.184993-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AUX ring buffer is required to separate the data store and aux_head
store, since the function CS_LOCK() has contained memory barrier mb(),
mb() is a more conservative barrier than smp_wmb() on Arm32/Arm64, thus
it's needless to add any explicit barrier anymore.

Add comment to make clear for the barrier usage for ETF.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 45b85edfc690..9a42ee689921 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -553,6 +553,12 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (buf->snapshot)
 		handle->head += to_read;
 
+	/*
+	 * AUX ring buffer requires to use memory barrier to separate the trace
+	 * data store and aux_head store, because CS_LOCK() contains mb() which
+	 * gives more heavy barrier than smp_wmb(), it's not necessary to
+	 * explicitly invoke any barrier.
+	 */
 	CS_LOCK(drvdata->base);
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.25.1


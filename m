Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F95398686
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbhFBKcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhFBKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4252DC06138A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y15so1830699pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=POWzSZ5TRT+9dr74+V15dGxhepckGw99Xtw70LETQ2z3VMGYTXTOwtdm6cl33wbAff
         LEsF+BxxrTAxWeVcYdCHSgWl+4xjHatzqqb84TDjSjM4cps1Xi43q0gRKuKehIGj6QQJ
         SMVld7CJ3kXmvcclqESa7CHe5OF5x/O7GIgLU8gTKMtOQmTEf73RqTyPY91NLA5ARmu5
         SF9IjG4Qhswx34IcxQZO+wWSocV3XUptIOGGHQl2UZyQvH901whvw+yf+Aawpxuak0+n
         UN8gron1YQzhcgYefKP7eI2zgGQoqzJCrDn84BJ71sbk1565GIGlKdAfNJOku6vlyGgQ
         7bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvAJvuDnRJDe9YMY5R2L+q2C0nSKQeIr4jFz4M7hp0E=;
        b=ctX46pZEFEdUNgQ/zkfqyFTHr2CuVRsVEkdaZ00qgdmE/qrYweAYdBde0cUNCfq3TC
         6K7v5SHK1KxPrBbA5PWQx259IzyZ+XHfd93hACLg71/rJNhBoC0tieGbckvwM1tuLivp
         VOppsqyHrP0jyx0p8BXy/5mPCmqb/H18v8+XDvxIwZZwMVc6Lhw1a1wNCWoMr9DB+rk4
         rBCZf1iRVd/fma9ErRfw37NF41GHp2I63KbVf4BH8M5H3ad/HCgBw5tTub43kDxnt3J/
         4sA0hvgIV/lYI3wMb+w9v99lxRTrLjvT+/RNragWilT6QBllYRD/JUJ+QKttKnPFd+9y
         iBoQ==
X-Gm-Message-State: AOAM531S6Bw7n5ccwpOkuqTIydwOUHTEDVUwDqe1y1WjTmfyGFU2q2Mg
        MNnzvQJsSzOI7eyg3IKC6RwUgw==
X-Google-Smtp-Source: ABdhPJy5pG1LjUfP91QAtl2t0ow2iEBMIl7BJdK1RWAS4sEnHwBJ5KdESYaC3yr/wQPQz544PM/Bvg==
X-Received: by 2002:a63:5a19:: with SMTP id o25mr32747476pgb.122.1622629822770;
        Wed, 02 Jun 2021 03:30:22 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id g141sm15568758pfb.210.2021.06.02.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:22 -0700 (PDT)
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
Subject: [PATCH v2 2/8] coresight: tmc-etr: Add barrier after updating AUX ring buffer
Date:   Wed,  2 Jun 2021 18:30:01 +0800
Message-Id: <20210602103007.184993-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a memory barrier is required between AUX trace data store and
aux_head store, and the AUX trace data is filled with memcpy(), it's
sufficient to use smp_wmb() so can ensure the trace data is visible
prior to updating aux_head.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index acdb59e0e661..713205db15a1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	 */
 	if (etr_perf->snapshot)
 		handle->head += size;
+
+	/*
+	 * It requires the ordering between the AUX trace data and aux_head
+	 * store, below smp_wmb() ensures the AUX trace data is visible prior
+	 * to updating aux_head.
+	 */
+	smp_wmb();
+
 out:
 	/*
 	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
-- 
2.25.1


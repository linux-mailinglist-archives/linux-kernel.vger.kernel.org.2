Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE30E38880D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhESHVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhESHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:21:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31312C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:20:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k19so9277557pfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Chi1IofC1LVT5Y+rvN1rFC7UBLdb7aCrIZYrC4aASeE=;
        b=yddoojxF7uDWUZxGOObcD+IlaNc0Vem+McpvUNJ2n8STiIA4foAtRSyH8S9KUwPZoL
         1gUIlCXqAMOix/+Y7tC0ugzNucy0olkHIEBWFGXlw+Gl5Q7NiR4BuEmpjJYXixc6BjWX
         5EhXx6M4e+0i16NhYRfgN1IxfjFwZL9KZyUpVqE9/Zk4btLAPhZ7/C/87x3MwhznE4jX
         +1uZgRKHYei6bbA+TZZs5FQJ7fguXPlmy5XeiDhy6BLEXMcG3/Z5EAshSElmYfDpFqed
         mXj5BwK86pxLbJGCUcvexKME+VMwvAuoCtrA7uiYy2a6xCs5s3Hxzm0701ZniCICa7BF
         /qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Chi1IofC1LVT5Y+rvN1rFC7UBLdb7aCrIZYrC4aASeE=;
        b=CDqZxMgl7+CoxcsX5B59ir2bw5bVs5y+6ibFvvvgIFoAFcJ8YBUxnFo4Z35WmNuMRb
         aPqinlSDOehfntwC+re8XPh4klQRnLWr/57vOHNG1t3daTfFItdF05UtyghpmRGX5EnQ
         ySyf3LyLADbDBM5v37C4+qOsGILtHgslVCR3MOIrQuSoJMz4ZBGO1xTZKmppcNd/Mp1i
         lC7GfkVhJRLa8hoGztDxQ6EEehpJeHX0D+lFaIB2vO3O2dYtEV0tQIIur6Q6ht1qUa1u
         WLq6r/Vp8sH3EQSbcBzvGLXNy4TtB6CBvBzdHlcbbESqpXRghRq+LWdfFc1F72hXmbDQ
         szMw==
X-Gm-Message-State: AOAM530lN8JXcibYPCkMZjIfbn1cElknV7d08gLfY5DpnnY5+D+1SSBa
        nBdlZetIBebqi62JugfvorYleg==
X-Google-Smtp-Source: ABdhPJyTH2gc1bFlj5R2BhX7fJGAX8sT+U1KvjUgM9c8MPmMkLckOB8aCI0UxWShd2iT49crzw0oyA==
X-Received: by 2002:a63:4648:: with SMTP id v8mr9458082pgk.34.1621408804623;
        Wed, 19 May 2021 00:20:04 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id y14sm12448747pgl.21.2021.05.19.00.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:20:04 -0700 (PDT)
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
Subject: [PATCH v5 5/5] perf arm-spe: Don't wait for PERF_RECORD_EXIT event
Date:   Wed, 19 May 2021 15:19:39 +0800
Message-Id: <20210519071939.1598923-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When decode Arm SPE trace, it waits for PERF_RECORD_EXIT event (the last
perf event) for processing trace data, which is needless and even might
cause logic error, e.g. it might fail to correlate perf events with Arm
SPE events correctly.

So this patch removes the condition checking for PERF_RECORD_EXIT event.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 5c5b438584c4..58b7069c5a5f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -717,11 +717,7 @@ static int arm_spe_process_event(struct perf_session *session,
 					sample->time);
 		}
 	} else if (timestamp) {
-		if (event->header.type == PERF_RECORD_EXIT) {
-			err = arm_spe_process_queues(spe, timestamp);
-			if (err)
-				return err;
-		}
+		err = arm_spe_process_queues(spe, timestamp);
 	}
 
 	return err;
-- 
2.25.1


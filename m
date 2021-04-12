Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6196535C21A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhDLJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240785AbhDLJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:10:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D671C061346
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso6758824pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ty81BCsORd5s69G8d1mkYSj1zTzYA49IgpkqvkyuSg4=;
        b=AZHsMaeVOD7i+v/+4w1QrZkA+VxUz6jlOVGh/Jw3x67jejKOLWR4q7SMS6Ixuhs2UN
         Nnusdxgr4O8YgD2zBcWniqVcOrBQpsSeX5VbI17JSfLbvnifaMIrezKEo3giwvDh4Tyh
         vxgpP+EVMK16R4xvXEq9ym5xWVnQEtPEkvu1mqsoZlI637DiGK12qUKWixLnyE6NeaC5
         NTKB74ekszMvFS8QUQMgatvjZriDyKTHUuTKTE4Zkvb4B1pimUMz2uvFX+28ogbR93tC
         gRyt+UrcqHiAtBjvZfhyTful9fnUbNMI04mtJgQgMy7Q3xV/Y9nddZKMP19hfD6SoXcF
         Op8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ty81BCsORd5s69G8d1mkYSj1zTzYA49IgpkqvkyuSg4=;
        b=f0ZEDelovGZf79aOHQjv3mtFKcfiXpOlev+hu5k9mD9UtzfFbnv8dgvwQRT9R8auKj
         DZVUeTGUHlxRnxAIYal8txw0AOeLfipv7XJafW3UxIZS67EU+oxOUGq76VmuwRr/l3nd
         3bvMj7wMb75KGzGmwBsOOS9LrvofwccvL28gFSkacieMyrXYYDHVKXqDbRKF5LbCNfXF
         Kgus4Kl7OxWnjdCdIlkC+KIhOcEMkE9dAU6jood8HJ2pqiO//1z0S8zNZKOW38RzXWlX
         eIcACu5fFk3BhjC+7pigxSXs8zHCMyTuPi/7o81IXbB1/hrEbKsVROERc3HNgIkbcIQe
         4s1A==
X-Gm-Message-State: AOAM5315KaFBXIYUz6PklzUAtd4lW6lTpGkVpbFvf6xqk3Y60y4IEtGE
        sFMtWZQfJdHwf8ODACJtFM0jNQ==
X-Google-Smtp-Source: ABdhPJxY2wgiIB14DfuZG8F3mw/lrO4DRyLbSKZutgW8n5t2B5xm0/Br+J2SkABOTRPWpa/L6u4iNg==
X-Received: by 2002:a17:90b:2291:: with SMTP id kx17mr1077967pjb.79.1618218639739;
        Mon, 12 Apr 2021 02:10:39 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id w23sm11187337pgi.63.2021.04.12.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 02:10:39 -0700 (PDT)
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
Subject: [PATCH v4 6/6] perf arm-spe: Don't wait for PERF_RECORD_EXIT event
Date:   Mon, 12 Apr 2021 17:10:06 +0800
Message-Id: <20210412091006.468557-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412091006.468557-1-leo.yan@linaro.org>
References: <20210412091006.468557-1-leo.yan@linaro.org>
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
index b37d1cacebe9..654fa2413823 100644
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


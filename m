Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6F38F5DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhEXWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:52:22 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161ECC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:50:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 6so21180575pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CqpbmqXb4GYpmDkkqnjns1MTswBqOhXJh0DKj+/hJFs=;
        b=GdXQhx5iiDE42kvv+GAdszPs11tFkirL14gypGO/es249nQdbOZipJ79x0pg/51Rtn
         Sy+CMlYegvTXmylFpuELU33XUAATLaWhgTkIFHPL3mnwyesHjFTUuUv7SmsKJRh6qPoH
         HC0ErbcoMZ6WbJsIEfXyWgzBKRRgOtk9f1+PVFFCoB9gZ2tFkz6JvK8qzuQSvAPp12dt
         Zx7derxAOWorMSqVYPhY2HqCnWdsWDMXSe2ovZEOI1u7vW3xaTE8TeD5YgpDhLaz+1Fm
         h/lI8yKNpCDBswtcc5CyULOENdnrBK5VSCu8DIPYG7VmENGW5UHoMqwrXVAb2RrVUwR5
         ffQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CqpbmqXb4GYpmDkkqnjns1MTswBqOhXJh0DKj+/hJFs=;
        b=DQnybx2DHyXEhabgviISa+FsYPxfuGtEAKOXfvQFGPGIU1jwIvsuuJfzmzkR3LCzuN
         etFmBaQHOT/0ylOrvMQsg6dVmatMZwSc7JhsYKek102IIPDRjD+m4Z8sCcR9T+TFOj9S
         MEuNBRWUMc1WFKBWIfiLencg65Ufx3kxaby75oV6VP75WlXlImxKsS5CL59KAMpaatBI
         44Qe9gGQAyqE2r1pVqhmyvyBL6AZncJg3TE7DC9FYlwsWPhygd/7tLCVfL/EMT9CdJV3
         NH07nWCHtk+oXGkrkrdQz2PoRuHc/T++N4cpg4y5H6PsxZ5R5moWZHDQt1cRKQGThH1Z
         B9Fg==
X-Gm-Message-State: AOAM533WOTQ5wcv5oQiggw8AliyODFtoFgmWAP+YUTyO2pSmqBV6Lp2B
        0F3aWQPkAHH1R4sYixs2Id6zmQcpqqc=
X-Google-Smtp-Source: ABdhPJw1Ww1emX8KS2Me0a4xoUMHc+QTM1+O9RNLDaUEtOgrBlmrwcycoP5zOoEksViWxvKRs+FUtw==
X-Received: by 2002:a05:6a00:216a:b029:2df:3461:4ac3 with SMTP id r10-20020a056a00216ab02902df34614ac3mr26479214pff.80.1621896653590;
        Mon, 24 May 2021 15:50:53 -0700 (PDT)
Received: from balhae.roam.corp.google.com (173-13-151-221-sfba.hfc.comcastbusiness.net. [173.13.151.221])
        by smtp.gmail.com with ESMTPSA id t14sm1959459pgk.21.2021.05.24.15.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:50:52 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf inject: Call dso__put() even if dso->hit is set
Date:   Mon, 24 May 2021 15:50:50 -0700
Message-Id: <20210524225051.1190486-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it'll leak the refcount for the DSO.  As dso__put() can
handle a NULL dso pointer, we can just call it unconditionally.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 102cafb0c0b3..8bbaa46eb7e6 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -383,8 +383,8 @@ static int perf_event__repipe_buildid_mmap(struct perf_tool *tool,
 	if (dso && !dso->hit) {
 		dso->hit = 1;
 		dso__inject_build_id(dso, tool, machine, sample->cpumode, 0);
-		dso__put(dso);
 	}
+	dso__put(dso);
 
 	return perf_event__repipe(tool, event, sample, machine);
 }
@@ -447,8 +447,8 @@ static int perf_event__repipe_buildid_mmap2(struct perf_tool *tool,
 		dso->hit = 1;
 		dso__inject_build_id(dso, tool, machine, sample->cpumode,
 				     event->mmap2.flags);
-		dso__put(dso);
 	}
+	dso__put(dso);
 
 	perf_event__repipe(tool, event, sample, machine);
 
-- 
2.31.1.818.g46aad6cb9e-goog


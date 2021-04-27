Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923236BCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhD0BiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbhD0BiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:38:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:32 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dm16so3441248qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QB800rHYAeL0/mLOu6ht7g88VM3imoEr4I1ah0eoM3w=;
        b=AFV0EFC3lMxMy0npzHQLmeKh5sg6p+6xOSY8r4n3vU8cZC31dVsePzNarYd6U7HPT2
         USDYVyiZd/gJozmfuh/vSkkGrpGX682BWq/T3JdRyADaA4hqDFEsTMDOODZ+mkUty+0m
         gEPS7FaKDDAjKIt6F+chaB4bqAf+Y8GGFK6W0gui/qH7BT9BVmtGP8AZM9jHWsU4wT1D
         yKLblJ8dC8ZoiJDfaNA99FILJZjiKGMot4cSJ0/hZBN8/IH11PHJaioiWezM5Dy9JO+/
         hwTUnz8RIsx1pOvPi5mt2MRp5egXj+SktN9kzCRzamUwQ/WO+fBkjqAzCXGXBGEqWmgG
         Npgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QB800rHYAeL0/mLOu6ht7g88VM3imoEr4I1ah0eoM3w=;
        b=b6e32ej3ljX/v+WcxjuR9lGphxZKt18H0MGLUG5E6veSBzMQGcZcng/GfRnFBYmoGh
         CljjTHsaoKYYJxgwzboL61Ni3NMqAraVnryCaEcctFwdYg/XLhkhhALf8SEnSmT/3nwg
         EcIcrvo4C/tr8kXR32qsaGHdshkwyvG2ADOgODBVyLscfJpPQPMvbxg+rt54nemlCmNh
         u2fGOjlTUhZ7mikihwNsgyfbCyNWk3vdox0jXber6jJD5aJPa7RXapXhz6sEK4yTz1FX
         w8pTSTk+j4PBpuqirshRyn7oNN4P+MjzEVqO+yaHD132yuCybPTX0huQNdP38Zltr+E7
         M/lg==
X-Gm-Message-State: AOAM533ObSkHL8qcPCVymEV+S/5HyvmHXGVZROOpNU9uMKnbdNPk/MXq
        EcFH+DpxrHSBkGFFsn6I3Nk=
X-Google-Smtp-Source: ABdhPJx4RjAb6cTop0FPSjfmGyF2sN3M38cxEUBNSgoFfHyH8YMl+FzLxtzj0F3B/bQ+2npNfV0v5w==
X-Received: by 2002:a0c:d786:: with SMTP id z6mr21041012qvi.18.1619487451043;
        Mon, 26 Apr 2021 18:37:31 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id q67sm1858622qkb.89.2021.04.26.18.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:37:30 -0700 (PDT)
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
Subject: [PATCH v2 6/6] perf report: Print percentage of each event statistics
Date:   Mon, 26 Apr 2021 18:37:17 -0700
Message-Id: <20210427013717.1651674-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
References: <20210427013717.1651674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's sometimes useful to see how many samples vs other events in the
data file with percent values.

  $ perf report --stat

  Aggregated stats:
             TOTAL events:      20064
              MMAP events:        239  ( 1.2%)
              COMM events:       1518  ( 7.6%)
              EXIT events:          1  ( 0.0%)
              FORK events:       1517  ( 7.6%)
            SAMPLE events:       4015  (20.0%)
             MMAP2 events:      12769  (63.6%)
    FINISHED_ROUND events:          2  ( 0.0%)
        THREAD_MAP events:          1  ( 0.0%)
           CPU_MAP events:          1  ( 0.0%)
         TIME_CONV events:          1  ( 0.0%)
  cycles stats:
            SAMPLE events:       2475
  instructions stats:
            SAMPLE events:       1540

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/stdio/hist.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index d9e634406175..f36270485168 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -902,6 +902,7 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
 {
 	int i;
 	size_t ret = 0;
+	u32 total = stats->nr_events[0];
 
 	for (i = 0; i < PERF_RECORD_HEADER_MAX; ++i) {
 		const char *name;
@@ -912,7 +913,14 @@ size_t events_stats__fprintf(struct events_stats *stats, FILE *fp,
 		if (skip_empty && !stats->nr_events[i])
 			continue;
 
-		ret += fprintf(fp, "%16s events: %10d\n", name, stats->nr_events[i]);
+		if (i && total) {
+			ret += fprintf(fp, "%16s events: %10d  (%4.1f%%)\n",
+				       name, stats->nr_events[i],
+				       100.0 * stats->nr_events[i] / total);
+		} else {
+			ret += fprintf(fp, "%16s events: %10d\n",
+				       name, stats->nr_events[i]);
+		}
 	}
 
 	return ret;
-- 
2.31.1.527.g47e6f16901-goog


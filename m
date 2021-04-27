Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2194D36BCF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhD0BiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbhD0BiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:38:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15588C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:27 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a18so19377605qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9nJHhGV5CGMj0faurm9korFNjKpb/N5RJQCDRwRwqA=;
        b=QuQcnxTJyraZA5sF34VdwhXiaAhUR6czilSGFa7ETs0aqrGJ65/w+dXutvyk129sFH
         XOtRBLu78UbpOwp1gO6bBv24eay8RnlbMP0g4Waeyr32LDdv83QzKT5qWTFV0/IQ1wgd
         1aejXBPMTqygFLAzzAUYhCCKhCLS4qYbRMs57w8qEXZHH92uKJl8ViOCoYFFeXV1t7Rl
         Oa7jGAry2b26C53mktzloOrFPPc9qbJLO4sa7eAJBlnZMFpCdul5JY/Ct9vMUBj5LKOS
         wsKP4oBebkQCWFewPYUh2BrEtEMLcK2QcA+/8sZxU6c54x86viwLbxhHR17BV+xhgbGd
         CxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/9nJHhGV5CGMj0faurm9korFNjKpb/N5RJQCDRwRwqA=;
        b=SzxSZV0pYByfvzlgRQj+5z8c11TEmBFh3DiR27aSF7E1hPOgjH4cBOIPL3uzafeLcy
         IJ4QVcRz+gdnvXrI0P5Qi2vbG6fHfmdBWuJVYrugpUWKF0eNutY0T/XV5twMFDHbON11
         Xr8Wm75Y9G7y1vVpov2e0n4er0KyENPMU5NIhb9NgKVcqJzl/6o2A4Wq3v65Wk6EUzbN
         CvSi8gP7oGynuz0ZFHbJ0Rqgw2LZ69fxHQ4VwqgCnO/S/5u5PTR+wyf1em9G62S0G1PT
         0ZnGp6E1HDFv/ac59nUlnZI61Uil5AC/kl0dE0M79kCxEQVT+zUSYCith5/Wh6M3qDj3
         Lj/Q==
X-Gm-Message-State: AOAM533N+1hQJjB+u9WNOGJW2x33/ncUGSHyshyIA3iCIXZRm2Do40Qr
        ECdn1NOugB7Yu8bFOUSrwbg=
X-Google-Smtp-Source: ABdhPJzlx0qECB99nQl4e2FambuFNqZlrwJluHjvequXoXXWO84Ey137V7+kPYS4alufqC4Y/nSm/A==
X-Received: by 2002:ac8:4a10:: with SMTP id x16mr8365018qtq.283.1619487446373;
        Mon, 26 Apr 2021 18:37:26 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id q67sm1858622qkb.89.2021.04.26.18.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:37:25 -0700 (PDT)
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
Subject: [PATCH v2 3/6] perf report: Show event sample counts in --stat output
Date:   Mon, 26 Apr 2021 18:37:14 -0700
Message-Id: <20210427013717.1651674-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
References: <20210427013717.1651674-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the output identical with perf report -D, it needs to show
per-event sample counts along with the aggregated stat  at the end.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b0b9b60f74e5..be56f3efa413 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -708,9 +708,22 @@ static void report__output_resort(struct report *rep)
 	ui_progress__finish();
 }
 
+static int count_sample_event(struct perf_tool *tool __maybe_unused,
+			      union perf_event *event __maybe_unused,
+			      struct perf_sample *sample __maybe_unused,
+			      struct evsel *evsel,
+			      struct machine *machine __maybe_unused)
+{
+	struct hists *hists = evsel__hists(evsel);
+
+	hists__inc_nr_events(hists);
+	return 0;
+}
+
 static void stats_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.sample = count_sample_event;
 	rep->tool.no_warn = true;
 }
 
@@ -719,6 +732,7 @@ static int stats_print(struct report *rep)
 	struct perf_session *session = rep->session;
 
 	perf_session__fprintf_nr_events(session, stdout);
+	perf_evlist__fprintf_nr_events(session->evlist, stdout);
 	return 0;
 }
 
-- 
2.31.1.527.g47e6f16901-goog


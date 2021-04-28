Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516FF36D6E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhD1MAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhD1L7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:59:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BCC06138A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q10so44532749pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tV+hssRk6K2Vi07LzMhy306zXuuNxECYbp48A5vv8Q4=;
        b=KvQV2TybtqadF3BrweZUETziOYuNYKSF1kLQESklARvqEStnKpIQpZq3mpZamszbL5
         D1/Oz1TVivLZ6sgJQqJoNzJEivM1yhpACU5DFhu+XPMTl8GQZJhVmrHVAqZwa7YfqJ0J
         QMIuv36qYaFqTJ3xRDjHA7OYRtA48Itwnu4GSRhYNnFEvyFHnmPzRWrlG+Y5JDEeG0pf
         1lIn9GbLG+ZItG7i+Q66oxusxDv42ksVua2dWun0GsUfzzHzJE3MvnN2C/jsNWeUMtPE
         EMXTh/5F6LGG4kMgeW1etLWb37GjbCG0ncMyh+RjSN14d8GtQ89z9olbTVyvll+RkXau
         u/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tV+hssRk6K2Vi07LzMhy306zXuuNxECYbp48A5vv8Q4=;
        b=M1KzgCEiQfEwSLROq69SbhfWdTeMamBeq9Lp4ZjFlczya27j7CZiiCDCB2gEXFvpmk
         3guLSVmhcE4elPvL5s25mvez//dWeTfaMGNWNo6NXDo54kq3Au9ogvuHhTk5nyL4W6x0
         JhK+4nqyShfL01CmL3pk2/H51aH2g5LzKJkvUWrbODRKPDUZXNbLLbLiGtq1Np8zWVFg
         1X74Y+TRFZjoJJnL3ftD/0rcAVidJEFmsE1mdXtUb6Q/Pn3C+AfrkDG4xUVm/55q7/91
         0C/rFM3Oom1Qh7k99BGkWQw/2ZQWqbcNiorrZ8Bq4utd1iJSwkihAgYAG+1IycY/FQLE
         ABsg==
X-Gm-Message-State: AOAM5311hwZjD1/M2Z6gRspNB7inJk/YwvYV+nnhfaETOj8e4MTbvBp8
        gdoEwQRe5KBzkQbb/g4YfFuMZw==
X-Google-Smtp-Source: ABdhPJxa8aiTAiIMKd8jPTiOyrVT68WgI3gxKv9lWUG+XdaXqtAP3tWuLsn+uz0fIOZeByOnTCb6FA==
X-Received: by 2002:a63:788f:: with SMTP id t137mr26779336pgc.323.1619611101972;
        Wed, 28 Apr 2021 04:58:21 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id z17sm4862255pfe.181.2021.04.28.04.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/4] perf session: Add swap operation for event TIME_CONV
Date:   Wed, 28 Apr 2021 19:57:48 +0800
Message-Id: <20210428115749.5229-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428115749.5229-1-leo.yan@linaro.org>
References: <20210428115749.5229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d110162cafc8 ("perf tsc: Support cap_user_time_short for
event TIME_CONV"), the event PERF_RECORD_TIME_CONV has extended the data
structure for clock parameters.

To be backwards-compatible, this patch adds a dedicated swap operation
for the event PERF_RECORD_TIME_CONV, based on checking if the event
contains field "time_cycles", it can support both for the old and new
event formats.

Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/session.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index eba3769be3f1..1e3cab92042d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -949,6 +949,19 @@ static void perf_event__stat_round_swap(union perf_event *event,
 	event->stat_round.time = bswap_64(event->stat_round.time);
 }
 
+static void perf_event__time_conv_swap(union perf_event *event,
+				       bool sample_id_all __maybe_unused)
+{
+	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
+	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
+	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
+
+	if (event_contains(event->time_conv, time_cycles)) {
+		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
+		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
+	}
+}
+
 typedef void (*perf_event__swap_op)(union perf_event *event,
 				    bool sample_id_all);
 
@@ -985,7 +998,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT]		  = perf_event__stat_swap,
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
-	[PERF_RECORD_TIME_CONV]		  = perf_event__all64_swap,
+	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
-- 
2.25.1


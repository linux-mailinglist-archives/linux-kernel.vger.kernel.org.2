Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B8A36D707
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhD1MKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhD1MKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:10:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t13so6625599pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 05:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tV+hssRk6K2Vi07LzMhy306zXuuNxECYbp48A5vv8Q4=;
        b=TFlXU76bmyuofrDAMoUP0Y/tgnouV6hc9rFmd8bhLPY8kCp2gCFylMpSgDCB0KOdnB
         luPqesURLSMdmEhCA083i75slBVv9mL9Rep45hzoghKS2jTumxO56VFOiKeX1cL4mKXw
         nnu+eLudapZewuQCZSutsNP0+OEW8Ev+2FMEXY2eEHWDz439KjR32W/RbCmGGMn78Y1i
         mgRUMfE1ZTbW0uuV1GTgjyfuFGbVEeXkUwhoLZZDyUg9sMlXed83VyKyU1C+r7fuF3OG
         6vWW1Xk2LzMfFzavuxIc1vr0Z1Ql5u5DrZlDw3pVSKlNrAXrCdClhmmH28q93BKBPJOe
         hanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tV+hssRk6K2Vi07LzMhy306zXuuNxECYbp48A5vv8Q4=;
        b=rJQxaNMPFygpMKCsiOprac9ZpaugHMbUT3PQUBrEsNw2gHm5H3JGXndQo+iYC18SHZ
         FjXOKACcb5smvXBk3uqq66EeRTJJeICLgIlDcV++mflKvwO9sa9Xpm1lrhUbCTzRwJXl
         9u6qstkED8fDew607821JuvzAvP4FBo2sCRtmNa9+YligZqZ6TQq94XhurXL3vQa4lS6
         cPXGLLRcjLHUlmO0mAIZzhK7zYOKEE73suc1Ho1JhMNaco3yThFLWUSR9MCXf9UvWqBd
         wP0SPaIUOY91yosSCoqDdIhzMD3AhtkDiuvZO3JK5rkWPCTCBFRuko9q3yvF/5j0Ll1q
         zDyw==
X-Gm-Message-State: AOAM532TnX0ONBGy6QEkCXbgy6bw8dfGfSmLTa8gnnrVvDS/2k1ArKdl
        R2ocwMNcbl2wOCzggKvqQjzBug==
X-Google-Smtp-Source: ABdhPJwsq4jnyylQ3zxx5e5fSSZltGenWRIg/5aHmuSgkxNK2PrmNOdgnoGOSHPJV7ZIN0yDo5HiEw==
X-Received: by 2002:a17:90a:c404:: with SMTP id i4mr3752315pjt.10.1619611775314;
        Wed, 28 Apr 2021 05:09:35 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id r32sm2500326pgm.49.2021.04.28.05.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:09:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 3/4] perf session: Add swap operation for event TIME_CONV
Date:   Wed, 28 Apr 2021 20:09:14 +0800
Message-Id: <20210428120915.7123-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428120915.7123-1-leo.yan@linaro.org>
References: <20210428120915.7123-1-leo.yan@linaro.org>
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


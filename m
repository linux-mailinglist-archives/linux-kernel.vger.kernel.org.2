Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0258135BC44
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhDLIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbhDLIfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:35:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75871C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:35:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so8422270pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oe78LY13UXLbresQeQWZ+TCznjPcUJtXGcm2GQoJe4g=;
        b=Tlyw8b14+sOBQ2+uYrxtidhhq/75Kt/OG7hfBzFE4+rQnJrE881NFXH8XuQy4+vQFH
         bMMMjl0clCz/zQdLa3xOGDusY+Qg6cNGuePhBMKME6DmcoxUOxVQu8oVhVT/bq7Mc9Li
         9sOmgKEerUoXryzQC7NCM3R3/NFu4Mr7sJ99ldt610qwagzI9CsCUnKIKM82NahCwZye
         f06PAfbmT+ES2nOs6FHC0vaUS26VZ6gjmdUrGNNLFlcAU5LjEVb502z7LLwck9IB/XAu
         wyRh10kHvADD8u3IYGRoQrEO9WM7QqaDnBvB8w5J3kU4a7a7xphTQX3SrtguGFel5/S1
         qXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oe78LY13UXLbresQeQWZ+TCznjPcUJtXGcm2GQoJe4g=;
        b=MBgXwDraEmS1L1zGUzbcuAlxqpOM8M1R58JknLhTff0X6rdW19/yLYWd3QyDxCFprP
         VLo2yCrWN94HTn3lYo1XmVPq7n+6QRe1ez5jNCYwbd5esJGpTLG5628nZGUrjjAtnrF2
         ShOd5wHrhzZR/I9CMNxe9F9VkdZwtI7IMpZZwS6Nf3SEeY26AbfpfoU+IrB/lmnQLp3O
         3sjkBxa8sGc9GNHjIFvSINq5ZbNl4dKhb6swO58SolnZu8vaz+IkKKZ6w1OuQoA2xZUm
         qUcU4Z1a6Ky9vDzQnyV/Pc2vH69el7SqyZtbQJSc/nWLlhCKokhS90djjZk/Y5Im3hhe
         Ot6Q==
X-Gm-Message-State: AOAM533iozNhNdRWxCUp2oiMFeFqtpx/ZKMVGpAymzW6NBtRV2TFW+BO
        WLG2Hlmwb80FfWDZbkN/AU9ZIQ==
X-Google-Smtp-Source: ABdhPJzhdM8glFAC5n/7TzI1W2ASz8WQTkFqxJSqPHTWUcM9Gw0lsz1CkKefjsrsWEm/4D+ZHxlwRw==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr28038380pjb.127.1618216516009;
        Mon, 12 Apr 2021 01:35:16 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id m14sm11497540pgb.0.2021.04.12.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 01:35:15 -0700 (PDT)
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
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] perf session: Add swap operation for event TIME_CONV
Date:   Mon, 12 Apr 2021 16:34:58 +0800
Message-Id: <20210412083459.462817-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412083459.462817-1-leo.yan@linaro.org>
References: <20210412083459.462817-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d110162cafc8 ("perf tsc: Support cap_user_time_short for
event TIME_CONV"), the event PERF_RECORD_TIME_CONV has extended the data
structure for clock parameters.

To be backwards-compatible, this patch adds a dedicated swap operation
for the event PERF_RECORD_TIME_CONV, based on checking the event size,
it can support both for the old and new event formats.

Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/session.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9a8808507bd9..afca3d5fc851 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -949,6 +949,26 @@ static void perf_event__stat_round_swap(union perf_event *event,
 	event->stat_round.time = bswap_64(event->stat_round.time);
 }
 
+static void perf_event__time_conv_swap(union perf_event *event,
+				       bool sample_id_all __maybe_unused)
+{
+	size_t time_zero_size;
+
+	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
+	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
+	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
+
+	time_zero_size = (void *)&event->time_conv.time_cycles - (void *)event;
+	if (event->header.size > time_zero_size) {
+		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
+		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
+		event->time_conv.cap_user_time_zero =
+			bswap_32(event->time_conv.cap_user_time_zero);
+		event->time_conv.cap_user_time_short =
+			bswap_32(event->time_conv.cap_user_time_short);
+	}
+}
+
 typedef void (*perf_event__swap_op)(union perf_event *event,
 				    bool sample_id_all);
 
@@ -985,7 +1005,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT]		  = perf_event__stat_swap,
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
-	[PERF_RECORD_TIME_CONV]		  = perf_event__all64_swap,
+	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
-- 
2.25.1


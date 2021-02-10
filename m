Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10612316133
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhBJIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhBJIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:34:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0CDC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:33:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cl8so718066pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Urw0MttkoHyWjlVxc2MZMMTWoUuAnMBT3SEeTrL/iCQ=;
        b=Ft0bhtbE7bZF82zLZPY06/R9Lon1k4Lulg6Rux8ptHPRICVthYNFOA9xY2vDCibg8g
         lwlL3PZPBuWIJ8w0e+LOg9E1yixwvr9RpQw8u5VPYxwiv089JtP10c+Rbt6dzx8WpDrf
         ilQrOSZTAmiaDjsOIIFHyjK7GPylwtF42unU2YjovnEkhpMSRu41oR641AdgIWlr8Meo
         llB5qx4UtOs6O9++Ms5JMSGpe+R13oW6j6nC5upDu5WmkPGBdbiQgI8pQ1416IGIFkAF
         P62QpS/P0XpEIOfzD+rh0EOCraMadpTCz1Z1SSQrAv87IwDWsf4BNJYtiepQLnHnVVbe
         3GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Urw0MttkoHyWjlVxc2MZMMTWoUuAnMBT3SEeTrL/iCQ=;
        b=svEGwgTmx1gDGn8k2b0KvZWgJoO1svqwIn6k5MLbOzgiHEqORVEr8hCa3VocM6ida8
         Mn3AekC4wxzokoSgytnMgdkCdCpPqH1Lqq7a8ybHgew14gaYI2AmOPXMZIdhECHFO2Ub
         WWvn24gtZB02SoMzml1k5Dp8j4kzd+XPzMpcV1o0xOn3wbOBmQ4DANu7yFBlE54m194D
         4l9lg9Y5MbAgezZ0dWkuIV2M8A8Y8RNOuj0E1ISR5qeREskXpTF6KUruUSpKyHpxJn2z
         kFVp8JVAlSvx2RPhtcM3OBebjQ1X8lONDRgDOoaA8LQm9cidST5niOJ2DSHXPOP68oIv
         eybA==
X-Gm-Message-State: AOAM531dR6kpQ1g0NJHzrairpGdTFpKIk7RKhnicjjVTkgTiaqjzRTNb
        VaJeqwWJn9KKquLES5SeQDo=
X-Google-Smtp-Source: ABdhPJz+YQckOjR5a+f+QtSmpGA7doo37wW5U8QlIj9ghxdY4V/53hOse49msbZ1jInDiA3pyoY7Og==
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr2060813pjv.173.1612946024822;
        Wed, 10 Feb 2021 00:33:44 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id l21sm1401341pjy.31.2021.02.10.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:33:44 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 3/3] perf tools: Add 'cgroup-switches' software event
Date:   Wed, 10 Feb 2021 17:33:27 +0900
Message-Id: <20210210083327.22726-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210083327.22726-1-namhyung@kernel.org>
References: <20210210083327.22726-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It counts how often cgroups are changed actually during the context
switches.

  # perf stat -a -e context-switches,cgroup-switches -a sleep 1

   Performance counter stats for 'system wide':

              11,267      context-switches
              10,950      cgroup-switches

         1.015634369 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 1 +
 tools/perf/util/parse-events.c        | 4 ++++
 tools/perf/util/parse-events.l        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b15e3447cd9f..16b9538ad89b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -112,6 +112,7 @@ enum perf_sw_ids {
 	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
 	PERF_COUNT_SW_DUMMY			= 9,
 	PERF_COUNT_SW_BPF_OUTPUT		= 10,
+	PERF_COUNT_SW_CGROUP_SWITCHES		= 11,
 
 	PERF_COUNT_SW_MAX,			/* non-ABI */
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 42c84adeb2fb..09ff678519f3 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -145,6 +145,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 		.symbol = "bpf-output",
 		.alias  = "",
 	},
+	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
+		.symbol = "cgroup-switches",
+		.alias  = "",
+	},
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097317f4..88f203bb6fab 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -347,6 +347,7 @@ emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EM
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
 duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 	/*
 	 * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
-- 
2.30.0.478.g8a0d178c01-goog


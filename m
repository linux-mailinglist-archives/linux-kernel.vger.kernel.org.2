Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABB9369999
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhDWS3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbhDWS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:29:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86856C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f12so37092787qtf.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vycntx5n21EJGlkqYyFsYgfJRdY1+8RQcTCR7EOXMlU=;
        b=WCd0Ld3Z2sOj9CWsQvWQU9oMol3bfMZCBIdAEK+NKXFD/vo0GVA+kIUAX6n46aMeTu
         zmZq0pt+ZHFsBoqDja+M3L1SerDNm/yDtBzP8m8emeaR24+cW2hGYZpdXGsDtrvpUUeS
         cBRmgn3fvvDQsTGQjiWy0/VXESGuYvqi1FpXYc0TD4yflSAJuStTnAaFonv0aFDFHd/s
         9aXskbXaUtKrztHPdo5ImyNiYAGLs3NfBCLqp/XpXhc6OCr7it8WdqOJk++MmVmxPfdj
         ZU3pN1jb5pgYJVsyvKJYMC7ZoA8vLKB8MwSf87wuEsG1QQL+Ilo3137nZ97s8SWst3N4
         /gFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vycntx5n21EJGlkqYyFsYgfJRdY1+8RQcTCR7EOXMlU=;
        b=Ye+Isf2PGbgMYLYpJfoadASaLkyh2YJqFZJzr47ImoFrb+zbgeRuxT2yOv+bihQMeO
         3AfyAgv5QdQatWERyqMBUHRx6zqJ4W1s9O5KyK9ODsQ1nZbG887r93hrPLP4luAyvZLQ
         2+/EOEiRqODLMFBkppBrom/HGNWgleBb55lzG7jO1kmmMAGgfWmgZTtwjF2kxEIXU+BO
         Llv6j4jAhiGpxbyFVYjUyja7Ur8KMgw5SRKHKvOXQMHFFPXayy+fKlIWh/rq6tKykrks
         FSfKm96zR/GZfAgeMh6YbfFB+KfKQnC+ZyNpDjD6RKTfWShg5055DMn2jEVHS5gcucKp
         gxCw==
X-Gm-Message-State: AOAM533tWVz/1QHWIU46NFOsIwtWAo0xrAuRB7hZnmxWaQBQAdEHOLnk
        d6i+OOja91jTque5QOUDymCNTJcV9/LvfA==
X-Google-Smtp-Source: ABdhPJyKcrnFpoyBApXQ3l5b8gB0wCU8jTcktBeQAzxxs4NgQET93Dz/7/9ORH2q9ouf+SyzLChb/A==
X-Received: by 2002:ac8:580a:: with SMTP id g10mr5241545qtg.93.1619202503820;
        Fri, 23 Apr 2021 11:28:23 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id c5sm4783863qkl.7.2021.04.23.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:28:23 -0700 (PDT)
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
Subject: [PATCH 5/5] perf report: Make --skip-empty as default
Date:   Fri, 23 Apr 2021 11:28:13 -0700
Message-Id: <20210423182813.1472902-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
In-Reply-To: <20210423182813.1472902-1-namhyung@kernel.org>
References: <20210423182813.1472902-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

so that the compact output is shown by default.  Also add
'report.skip-empty' config option to override the default.
Users can also use --no-skip-empty command line option to
change the behavior anytime.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-config.txt | 5 +++++
 tools/perf/builtin-report.c              | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 154a1ced72b2..b0872c801866 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -123,6 +123,7 @@ Example
 		queue-size = 0
 		children = true
 		group = true
+		skip-empty = true
 
 	[llvm]
 		dump-obj = true
@@ -531,6 +532,10 @@ Variables
 		     0.07%   0.00%  noploop  ld-2.15.so         [.] strcmp
 		     0.03%   0.00%  noploop  [kernel.kallsyms]  [k] timerqueue_del
 
+	report.skip-empty::
+		This option can change default stat behavior with empty results.
+		If it's set true, 'perf report --stat' will not show 0 stats.
+
 top.*::
 	top.children::
 		Same as 'report.children'. So if it is enabled, the output of 'top'
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4910194acaa6..36f9ccfeb38a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -136,6 +136,11 @@ static int report__config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "report.skip-empty")) {
+		rep->skip_empty = perf_config_bool(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -1160,6 +1165,7 @@ int cmd_report(int argc, const char **argv)
 		.pretty_printing_style	 = "normal",
 		.socket_filter		 = -1,
 		.annotation_opts	 = annotation__default_options,
+		.skip_empty		 = true,
 	};
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
-- 
2.31.1.498.g6c1eba8ee3d-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369BF36BCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 03:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhD0BiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236339AbhD0BiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 21:38:14 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F093C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id y136so26486566qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nds5UsnFfWyLneoZ29mCNCHjuwAf8rMG4lYQhbzz8Fg=;
        b=M4UG5LY+9RAykfAcBIS8bjYPsVRRnjmN7g7q5VJam0ecKOykjkic/MGXTb74/fTPzU
         Te2b6e/Uu6N3fFrQE/Ki2IbuBu9tnRpA9iST/2aC5jUaot9h0yTuAGecDExIoi5MJIMu
         8IB1j21skSRSCScc9VrKWUKnvYXdlaxp+gfn7M4bJqJDrjWridCvN48/+ciiyZMtV5Mq
         g2c6ujrgBB5yjfGpv4xCJZ3F0haVbx56MAJdjaRqf4oVnydExCi/mTpXfvSS7KPdNg3q
         Ew0nWepAI5uSE7EdzKjuYCJoC1ZAdeKOY1Hy9U3AwEWzRdxnoEj4912bd0mX0pj9rW31
         sBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nds5UsnFfWyLneoZ29mCNCHjuwAf8rMG4lYQhbzz8Fg=;
        b=DjhQO79rPjmO5FSlodQuWfXSD52BOkLYDjMVFafP4u20Rfv5y5dUPRC30C+YQsVUjf
         iOzrTtSJ0WDAWPY/ysyl3zT0miYTVvZ23W54ysYfUas1mZ8Jmzd4KajDgF9whFyP2GQH
         969c4VeyQkKIN5DjE7IAR7yYZeqQ/CLbsAjeLqLwzmPCD8dEFIoT9dO3sduBN/N3LbaW
         CS2Fwwqx4dOZzhJaYxUXYy07UDkM8EHQL2YPB1qMkAPfemUPO5Xq354sYpUKFBUhLZET
         mpQbMlQSqO1XOza66iUkMIo6Hg1lNVi3A1ZObf4CQHJl6UCYQMKV0W7FH+UMZAd6Bd2J
         jIWg==
X-Gm-Message-State: AOAM530HEmd4aN8UhHZjZnrTkEcLbyEcfQL0Uqlp07ARIOVQX5y+rN4u
        sCpkTFu4czFxo1l4HjlV2tA=
X-Google-Smtp-Source: ABdhPJwGJMIkZecIcTgnIUuEMaZSbr7xb9FcBj+INUlRYXyuk9fN/ehg7L0mDXpKH/s4JLmagS8tUw==
X-Received: by 2002:a37:8a01:: with SMTP id m1mr20849260qkd.85.1619487449477;
        Mon, 26 Apr 2021 18:37:29 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([50.238.223.130])
        by smtp.gmail.com with ESMTPSA id q67sm1858622qkb.89.2021.04.26.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 18:37:29 -0700 (PDT)
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
Subject: [PATCH v2 5/6] perf report: Make --skip-empty as default
Date:   Mon, 26 Apr 2021 18:37:16 -0700
Message-Id: <20210427013717.1651674-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210427013717.1651674-1-namhyung@kernel.org>
References: <20210427013717.1651674-1-namhyung@kernel.org>
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
2.31.1.527.g47e6f16901-goog


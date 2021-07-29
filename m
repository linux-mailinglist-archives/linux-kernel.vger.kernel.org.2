Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D683DA828
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhG2QAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:00:21 -0400
Received: from foss.arm.com ([217.140.110.172]:51328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238271AbhG2P6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:58:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B305CD6E;
        Thu, 29 Jul 2021 08:58:47 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11F6D3F73D;
        Thu, 29 Jul 2021 08:58:44 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Cc:     leo.yan@linaro.org, suzuki.poulose@arm.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/6] perf tools: Add WARN_ONCE equivalent for UI warnings
Date:   Thu, 29 Jul 2021 16:58:00 +0100
Message-Id: <20210729155805.2830-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210729155805.2830-1-james.clark@arm.com>
References: <20210729155805.2830-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently WARN_ONCE prints to stderr and corrupts the TUI. Add
equivalent methods for UI warnings.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/debug.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 48f631966067..f99468a7f681 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -22,6 +22,13 @@ extern int debug_data_convert;
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warning(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warning_once(fmt, ...) ({		\
+	static int __warned;			\
+	if (unlikely(!__warned)) {		\
+		pr_warning(fmt, ##__VA_ARGS__); \
+		__warned = 1;			\
+	}					\
+})
 #define pr_info(fmt, ...) \
 	eprintf(0, verbose, pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_debug(fmt, ...) \
@@ -55,6 +62,13 @@ void trace_event(union perf_event *event);
 
 int ui__error(const char *format, ...) __printf(1, 2);
 int ui__warning(const char *format, ...) __printf(1, 2);
+#define ui__warning_once(format, ...) ({		\
+	static int __warned;				\
+	if (unlikely(!__warned)) {			\
+		ui__warning(format, ##__VA_ARGS__);	\
+		__warned = 1;				\
+	}						\
+})
 
 void pr_stat(const char *fmt, ...);
 
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48CC3DA82B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhG2QAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:00:47 -0400
Received: from foss.arm.com ([217.140.110.172]:51390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238168AbhG2P7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:59:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8BA106F;
        Thu, 29 Jul 2021 08:58:57 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FA1F3F73D;
        Thu, 29 Jul 2021 08:58:55 -0700 (PDT)
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
Subject: [RFC PATCH 4/6] perf tools: Add flag for tracking warnings of missing DSOs
Date:   Thu, 29 Jul 2021 16:58:03 +0100
Message-Id: <20210729155805.2830-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210729155805.2830-1-james.clark@arm.com>
References: <20210729155805.2830-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Auxtrace support may need DSOs for decoding (for example Arm
Coresight). If one of these is missing it would make sense to
warn once for each one that's missing, but not flood the output
with every address as there could be thousands of lookups.

This flag will allow tracking whether a warning was shown for
each DSO.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/dso.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 52e7101c5609..83723ba11dc8 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -170,6 +170,7 @@ struct dso {
 	u8		 has_srcline:1;
 	u8		 hit:1;
 	u8		 annotate_warned:1;
+	u8		 auxtrace_warned:1;
 	u8		 short_name_allocated:1;
 	u8		 long_name_allocated:1;
 	u8		 is_64_bit:1;
-- 
2.28.0


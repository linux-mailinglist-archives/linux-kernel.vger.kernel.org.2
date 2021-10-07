Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1368E4251B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 13:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbhJGLIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 07:08:16 -0400
Received: from foss.arm.com ([217.140.110.172]:45896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241038AbhJGLIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 07:08:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2D1A6D;
        Thu,  7 Oct 2021 04:06:16 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E2AA3F70D;
        Thu,  7 Oct 2021 04:06:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org
Cc:     Nick.Forrington@arm.com, Andrew.Kilroy@arm.com,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf tools: Enable strict JSON parsing
Date:   Thu,  7 Oct 2021 12:05:42 +0100
Message-Id: <20211007110543.564963-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211007110543.564963-1-james.clark@arm.com>
References: <20211007110543.564963-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to ensure that the PMU event files can always be parsed by
other tools.

Testing
=======

 * There are no errors when parsing files for all architectures:
     # pmu-events/jevents nds32 pmu-events/arch/ test
     # pmu-events/jevents s390 pmu-events/arch/ test
     # pmu-events/jevents powerpc pmu-events/arch/ test
     # pmu-events/jevents arm64 pmu-events/arch/ test
     # pmu-events/jevents test pmu-events/arch/ test
     # pmu-events/jevents x86 pmu-events/arch/ test

 * Trailing and leading commas now cause a parse error

 * Double commas now cause a parse error

 * Compilation and parsing works with strict mode disabled and enabled

 * A diff of the output files shows no changes

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/pmu-events/jsmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jsmn.c b/tools/perf/pmu-events/jsmn.c
index 8124d2d3ff0c..831dc44c4558 100644
--- a/tools/perf/pmu-events/jsmn.c
+++ b/tools/perf/pmu-events/jsmn.c
@@ -24,6 +24,7 @@
 
 #include <stdlib.h>
 #include "jsmn.h"
+#define JSMN_STRICT
 
 /*
  * Allocates a fresh unused token from the token pool.
-- 
2.28.0


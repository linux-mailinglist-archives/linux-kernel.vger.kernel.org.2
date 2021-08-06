Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7887C3E2BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbhHFNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:41:44 -0400
Received: from foss.arm.com ([217.140.110.172]:32996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244498AbhHFNll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:41:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F40C12FC;
        Fri,  6 Aug 2021 06:41:25 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 67E193F40C;
        Fri,  6 Aug 2021 06:41:22 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        mike.leach@linaro.org
Cc:     acme@kernel.org, suzuki.poulose@arm.com,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] perf cs-etm: Initialise architecture based on TRCIDR1
Date:   Fri,  6 Aug 2021 14:41:02 +0100
Message-Id: <20210806134109.1182235-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the architecture is hard coded as ARCH_V8, but from ETMv4.4
onwards this should be ARCH_AA64.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 187c038caa19..787b19642e78 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -126,6 +126,20 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
 	return 0;
 }
 
+#define TRCIDR1_TRCARCHMIN_SHIFT 4
+#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
+#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
+static enum _ocsd_arch_version cs_etm_decoder__get_etmv4_arch_ver(u32 reg_idr1)
+{
+	/*
+	 * For ETMv4 if the trace minor version is 4 or more then we can assume
+	 * the architecture is ARCH_AA64 rather than just V8.
+	 * ARCH_V8 = V8 architecture
+	 * ARCH_AA64 = Min v8r3 plus additional AA64 PE features
+	 */
+	return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
+}
+
 static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 					     ocsd_etmv4_cfg *config)
 {
@@ -140,7 +154,7 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
 	config->reg_idr11 = 0;
 	config->reg_idr12 = 0;
 	config->reg_idr13 = 0;
-	config->arch_ver = ARCH_V8;
+	config->arch_ver = cs_etm_decoder__get_etmv4_arch_ver(params->etmv4.reg_idr1);
 	config->core_prof = profile_CortexA;
 }
 
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06A43E2BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbhHFNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:41:57 -0400
Received: from foss.arm.com ([217.140.110.172]:33090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344277AbhHFNl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:41:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9995811FB;
        Fri,  6 Aug 2021 06:41:40 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.40.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 068483F40C;
        Fri,  6 Aug 2021 06:41:37 -0700 (PDT)
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
Subject: [PATCH v2 6/9] perf cs-etm: Update OpenCSD decoder for ETE
Date:   Fri,  6 Aug 2021 14:41:06 +0100
Message-Id: <20210806134109.1182235-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210806134109.1182235-1-james.clark@arm.com>
References: <20210806134109.1182235-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OpenCSD v1.1.1 has a bug fix for the installation of the ETE decoder
headers. This also means that including headers separately for each
decoder is unnecessary so remove these.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/build/feature/test-libopencsd.c           | 4 ++--
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index 52c790b0317b..eb6303ff446e 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
+#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 1.0.0 is required"
+#error "OpenCSD >= 1.1.1 is required"
 #endif
 
 int main(void)
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 787b19642e78..12cee321fbf2 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -13,8 +13,6 @@
 #include <linux/zalloc.h>
 #include <stdlib.h>
 #include <opencsd/c_api/opencsd_c_api.h>
-#include <opencsd/etmv4/trc_pkt_types_etmv4.h>
-#include <opencsd/ocsd_if_types.h>
 
 #include "cs-etm.h"
 #include "cs-etm-decoder.h"
-- 
2.28.0


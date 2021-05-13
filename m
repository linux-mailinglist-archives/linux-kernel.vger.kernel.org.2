Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711C137F9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhEMOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:37:13 -0400
Received: from foss.arm.com ([217.140.110.172]:36734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234494AbhEMOgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:36:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E491B175D;
        Thu, 13 May 2021 07:35:38 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 162F53F73B;
        Thu, 13 May 2021 07:35:35 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, leo.yan@linaro.org
Cc:     al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] perf cs-etm: Start reading 'Z' --itrace option
Date:   Thu, 13 May 2021 17:35:19 +0300
Message-Id: <20210513143520.22694-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513143520.22694-1-james.clark@arm.com>
References: <20210513143520.22694-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the 'Z' --itrace option was added to override detection
of timeless decoding. This is also useful in Coresight to work around
issues with invalid timestamps on some hardware.

When the 'Z' option is provided, the existing timeless decoding mode
will be used, even if timestamps were recorded.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a752fe06f170..64536a6ed10a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2473,6 +2473,10 @@ static bool cs_etm__is_timeless_decoding(struct cs_etm_auxtrace *etm)
 	struct evlist *evlist = etm->session->evlist;
 	bool timeless_decoding = true;
 
+	/* Override timeless mode with user input from --itrace=Z */
+	if (etm->synth_opts.timeless_decoding)
+		return true;
+
 	/*
 	 * Circle through the list of event and complain if we find one
 	 * with the time bit set.
-- 
2.28.0


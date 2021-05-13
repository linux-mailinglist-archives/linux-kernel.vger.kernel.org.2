Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E868F37F9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhEMOhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:37:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234551AbhEMOgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:36:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AF1C1713;
        Thu, 13 May 2021 07:35:35 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B27713F73B;
        Thu, 13 May 2021 07:35:32 -0700 (PDT)
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
Subject: [PATCH v2 1/3] perf cs-etm: Move synth_opts initialisation
Date:   Thu, 13 May 2021 17:35:18 +0300
Message-Id: <20210513143520.22694-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513143520.22694-1-james.clark@arm.com>
References: <20210513143520.22694-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move initialisation of synth_opts earlier in the function
so that synth_opts can be used at an earlier stage in a
later commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 153fb8393e6e..a752fe06f170 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2819,6 +2819,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	if (err)
 		goto err_free_etm;
 
+	if (session->itrace_synth_opts->set) {
+		etm->synth_opts = *session->itrace_synth_opts;
+	} else {
+		itrace_synth_opts__set_default(&etm->synth_opts,
+				session->itrace_synth_opts->default_no_sample);
+		etm->synth_opts.callchain = false;
+	}
+
 	etm->session = session;
 	etm->machine = &session->machines.host;
 
@@ -2863,14 +2871,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		return 0;
 	}
 
-	if (session->itrace_synth_opts->set) {
-		etm->synth_opts = *session->itrace_synth_opts;
-	} else {
-		itrace_synth_opts__set_default(&etm->synth_opts,
-				session->itrace_synth_opts->default_no_sample);
-		etm->synth_opts.callchain = false;
-	}
-
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.28.0


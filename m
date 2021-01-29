Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB3308D12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhA2THM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:07:12 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:33754 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232960AbhA2TGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:06:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611947172; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=DkbiVl/O6sWRYU/Czn4LMHnOGXcjQCXsJqpICQQxSFY=; b=m+E/n6ajilbQoMq/mWlBY8/Oa7NzW3vJha5eOYdPYtybIeXPYrq5rxB+7v75CEH+XGD5bgjh
 9aIRGvwUl8VgiyIWIo7QxkHi6twojEvxMEPKlfhP3FGyrMRzXYrJRc10bj4EP0wSWdyPq1re
 XmHdclpL6lEu7SJZ21loGah/qp4=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60145c8a058a69a06d19556a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Jan 2021 19:05:46
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BBB19C4346B; Fri, 29 Jan 2021 19:05:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2472C433CA;
        Fri, 29 Jan 2021 19:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F2472C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Al Grant <al.grant@arm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 2/4] perf evsel: Print warning for excluding kernel mode instruction tracing
Date:   Sat, 30 Jan 2021 00:35:11 +0530
Message-Id: <014e0ded8cb17cbf8cbdf35275bd6fb9cacdfffb.1611909025.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <cover.1611909025.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1611909025.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a warning message to check CONFIG_EXCLUDE_KERNEL_HW_ITRACE kernel
config which excludes kernel mode instruction tracing to help perf tool
users identify the perf event open failure when they attempt kernel mode
tracing with this config enabled.

Tested-by: Denis Nikitin <denik@chromium.org>
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c26ea82220bd..09cc0349f883 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2630,7 +2630,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 		 ">= 1: Disallow CPU event access\n"
 		 ">= 2: Disallow kernel profiling\n"
 		 "To make the adjusted perf_event_paranoid setting permanent preserve it\n"
-		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)",
+		 "in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)\n\n"
+		 "Also check CONFIG_EXCLUDE_KERNEL_HW_ITRACE if kernel mode tracing is allowed.",
 		 perf_event_paranoid());
 	case ENOENT:
 		return scnprintf(msg, size, "The %s event is not supported.", evsel__name(evsel));
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


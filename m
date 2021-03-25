Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85A348800
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCYEkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:40:23 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:44366 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCYEkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:40:09 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id C756A980243;
        Thu, 25 Mar 2021 12:40:05 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] tools: perf: util: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 12:39:34 +0800
Message-Id: <20210325043947.846093-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHh9DH01DHRpOSx1PVkpNSk1NT0xJS01KSEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MC46OAw*Fz8UND5OPzJROE8u
        HyswFBpVSlVKTUpNTU9MSUtNTktIVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJT0lINwY+
X-HM-Tid: 0a7867aeb4b9d992kuwsc756a980243
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct evlist has been declared at 10th line.
struct comm has been declared at 15th line.
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 tools/perf/util/metricgroup.h  | 1 -
 tools/perf/util/thread-stack.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index ed1b9392e624..026bbf416c48 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -9,7 +9,6 @@
 
 struct evlist;
 struct evsel;
-struct evlist;
 struct option;
 struct rblist;
 struct pmu_events_map;
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index 3bc47a42af8e..b3cd09beb62f 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -16,7 +16,6 @@ struct comm;
 struct ip_callchain;
 struct symbol;
 struct dso;
-struct comm;
 struct perf_sample;
 struct addr_location;
 struct call_path;
-- 
2.25.1


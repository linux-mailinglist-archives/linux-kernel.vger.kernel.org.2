Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F631E8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhBRLGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:06:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:58030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhBRKBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:01:49 -0500
IronPort-SDR: m8w8hz8UbAwbq6tzbRacarjj4tD4jSp/zPvTms9MbMBk99C/33668jbMO0e46CE2IFbGVbSclD
 Pff7Vy0JB0xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171127929"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="171127929"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 01:58:15 -0800
IronPort-SDR: i44T9nzWTECfCJqRpwU30FleM6sw2fAW3B3ywm4KBJPK3YowQngj7tOcpu/BSTC153k0Y5eTYN
 hqZO1CtICEmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400427638"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 01:58:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] perf machine: Factor out machines__find_guest()
Date:   Thu, 18 Feb 2021 11:57:55 +0200
Message-Id: <20210218095801.19576-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218095801.19576-1-adrian.hunter@intel.com>
References: <20210218095801.19576-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out machines__find_guest() so it can be re-used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/machine.c | 9 +++++++++
 tools/perf/util/machine.h | 1 +
 tools/perf/util/session.c | 7 +------
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ab8a6b3e801d..90703b7ca6de 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -369,6 +369,15 @@ struct machine *machines__findnew(struct machines *machines, pid_t pid)
 	return machine;
 }
 
+struct machine *machines__find_guest(struct machines *machines, pid_t pid)
+{
+	struct machine *machine = machines__find(machines, pid);
+
+	if (!machine)
+		machine = machines__findnew(machines, DEFAULT_GUEST_KERNEL_ID);
+	return machine;
+}
+
 void machines__process_guests(struct machines *machines,
 			      machine__process_t process, void *data)
 {
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 26368d3c1754..022c19ecd287 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -162,6 +162,7 @@ struct machine *machines__add(struct machines *machines, pid_t pid,
 struct machine *machines__find_host(struct machines *machines);
 struct machine *machines__find(struct machines *machines, pid_t pid);
 struct machine *machines__findnew(struct machines *machines, pid_t pid);
+struct machine *machines__find_guest(struct machines *machines, pid_t pid);
 
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size);
 void machines__set_comm_exec(struct machines *machines, bool comm_exec);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f4aeb1af05d8..7b0d0c9e3dd1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1356,8 +1356,6 @@ static struct machine *machines__find_for_cpumode(struct machines *machines,
 					       union perf_event *event,
 					       struct perf_sample *sample)
 {
-	struct machine *machine;
-
 	if (perf_guest &&
 	    ((sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL) ||
 	     (sample->cpumode == PERF_RECORD_MISC_GUEST_USER))) {
@@ -1369,10 +1367,7 @@ static struct machine *machines__find_for_cpumode(struct machines *machines,
 		else
 			pid = sample->pid;
 
-		machine = machines__find(machines, pid);
-		if (!machine)
-			machine = machines__findnew(machines, DEFAULT_GUEST_KERNEL_ID);
-		return machine;
+		return machines__find_guest(machines, pid);
 	}
 
 	return &machines->host;
-- 
2.17.1


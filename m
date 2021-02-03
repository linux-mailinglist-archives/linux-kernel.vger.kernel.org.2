Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39B430D17D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhBCC0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:26:09 -0500
Received: from foss.arm.com ([217.140.110.172]:33098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhBCC0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:26:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5ECFED1;
        Tue,  2 Feb 2021 18:25:18 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F36FB3F73B;
        Tue,  2 Feb 2021 18:25:14 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mhiramat@kernel.org,
        srikar@linux.vnet.ibm.com, adrian.hunter@intel.com
Cc:     Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] perf probe: Added protection to avoid endless loop
Date:   Wed,  3 Feb 2021 10:25:07 +0800
Message-Id: <20210203022507.677283-1-Jianlin.Lv@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if dwarf_offdie() return NULL, the continue statement forces the next
iteration of the loop without update variable off. It will cause an
endless loop in the process of traversing the compilation unit.
So added exception protection for loop CUs.

Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
---
 tools/perf/util/probe-finder.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 76dd349aa48d..887bffb1cc58 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1156,7 +1156,7 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 	Dwarf_Die *diep;
 	int ret = 0;
 
-	off = 0;
+	noff = 0;
 	pf->lcache = intlist__new(NULL);
 	if (!pf->lcache)
 		return -ENOMEM;
@@ -1184,7 +1184,7 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 	}
 
 	/* Loop on CUs (Compilation Unit) */
-	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
+	while (!dwarf_nextcu(dbg->dbg, off = noff, &noff, &cuhl, NULL, NULL, NULL)) {
 		/* Get the DIE(Debugging Information Entry) of this CU */
 		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
 		if (!diep)
@@ -1208,7 +1208,6 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 			if (ret < 0)
 				break;
 		}
-		off = noff;
 	}
 
 found:
@@ -1919,7 +1918,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 {
 	struct line_finder lf = {.lr = lr, .found = 0};
 	int ret = 0;
-	Dwarf_Off off = 0, noff;
+	Dwarf_Off off = 0, noff = 0;
 	size_t cuhl;
 	Dwarf_Die *diep;
 	const char *comp_dir;
@@ -1943,6 +1942,7 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 
 	/* Loop on CUs (Compilation Unit) */
 	while (!lf.found && ret >= 0) {
+		off = noff;
 		if (dwarf_nextcu(dbg->dbg, off, &noff, &cuhl,
 				 NULL, NULL, NULL) != 0)
 			break;
@@ -1967,7 +1967,6 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 				ret = find_line_range_by_line(NULL, &lf);
 			}
 		}
-		off = noff;
 	}
 
 found:
-- 
2.25.1


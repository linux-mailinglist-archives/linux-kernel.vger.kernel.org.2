Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561CF30DD62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhBCO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:58:12 -0500
Received: from foss.arm.com ([217.140.110.172]:41578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233234AbhBCO57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:57:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 815B111FB;
        Wed,  3 Feb 2021 06:57:13 -0800 (PST)
Received: from net-arm-thunderx2-02.shanghai.arm.com (net-arm-thunderx2-02.shanghai.arm.com [10.169.208.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEB293F73B;
        Wed,  3 Feb 2021 06:57:09 -0800 (PST)
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mhiramat@kernel.org,
        srikar@linux.vnet.ibm.com, adrian.hunter@intel.com
Cc:     Jianlin.Lv@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf probe: Added protection to avoid endless loop
Date:   Wed,  3 Feb 2021 22:57:02 +0800
Message-Id: <20210203145702.1219509-1-Jianlin.Lv@arm.com>
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
v2: removed the statement that updates variable in the function argument.
---
 tools/perf/util/probe-finder.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 76dd349aa48d..1b118c9c86a6 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1187,8 +1187,10 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 	while (!dwarf_nextcu(dbg->dbg, off, &noff, &cuhl, NULL, NULL, NULL)) {
 		/* Get the DIE(Debugging Information Entry) of this CU */
 		diep = dwarf_offdie(dbg->dbg, off + cuhl, &pf->cu_die);
-		if (!diep)
+		if (!diep) {
+			off = noff;
 			continue;
+		}
 
 		/* Check if target file is included. */
 		if (pp->file)
@@ -1949,8 +1951,10 @@ int debuginfo__find_line_range(struct debuginfo *dbg, struct line_range *lr)
 
 		/* Get the DIE(Debugging Information Entry) of this CU */
 		diep = dwarf_offdie(dbg->dbg, off + cuhl, &lf.cu_die);
-		if (!diep)
+		if (!diep) {
+			off = noff;
 			continue;
+		}
 
 		/* Check if target file is included. */
 		if (lr->file)
-- 
2.25.1


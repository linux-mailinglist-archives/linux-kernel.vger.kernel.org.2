Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18BD31A33F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhBLRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:05:34 -0500
Received: from foss.arm.com ([217.140.110.172]:39928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhBLREy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:04:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE5411B3;
        Fri, 12 Feb 2021 09:04:05 -0800 (PST)
Received: from e125528.arm.com (unknown [10.57.5.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECE873F73B;
        Fri, 12 Feb 2021 09:04:03 -0800 (PST)
From:   Alexandre Truong <alexandre.truong@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>
Subject: [PATCH v2 2/4] perf tools: add a mechanism to inject stack frames
Date:   Fri, 12 Feb 2021 17:03:41 +0000
Message-Id: <20210212170343.7729-2-alexandre.truong@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210212170343.7729-1-alexandre.truong@arm.com>
References: <20210212170343.7729-1-alexandre.truong@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mechanism for platforms to inject stack frames for the leaf
frame caller if there is enough information to determine a frame
is missing from dwarf or other post processing mechanisms.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
---
 tools/perf/util/machine.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ab8a6b3e801d..7f03ffa016b0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2671,6 +2671,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 	return err;
 }
 
+static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
+		struct thread *thread __maybe_unused)
+{
+	return 0;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct evsel *evsel,
@@ -2687,6 +2693,8 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int i, j, err, nr_entries;
 	int skip_idx = -1;
 	int first_call = 0;
+	u64 leaf_frame_caller;
+	int pos;
 
 	if (chain)
 		chain_nr = chain->nr;
@@ -2811,6 +2819,21 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 		}
 
+		pos = callchain_param.order == ORDER_CALLEE ? 2 : chain_nr - 2;
+
+		if (i == pos) {
+			leaf_frame_caller = get_leaf_frame_caller(sample, thread);
+
+			if (leaf_frame_caller && leaf_frame_caller != ip) {
+
+				err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, leaf_frame_caller,
+					       false, NULL, NULL, 0);
+				if (err)
+					return (err < 0) ? err : 0;
+			}
+		}
+
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       false, NULL, NULL, 0);
-- 
2.23.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A313939BD16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFDQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDQaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:30:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBC29613FF;
        Fri,  4 Jun 2021 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622824108;
        bh=5w7g/bUb7eOwdfJb6PV3UCSCV/RrnNbcODEpMBBPUfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhfLcJW0o7ww5kGyM6ZKT2zv3KRcNYUQvCSY5cRqCVen2Dz/gSVZ3bnFanW4nvL89
         83HeoCS77dJgLagdY1xbvEqUOlOeUiP9YXQKd1Y8GefLwG6s1zDu0zwgVMnj0u7OiJ
         1nXoo5nZsQDcONg6jAddsnl8cBPDJBOwolTUipeENFIyH+sPvDM7hpCRqBFiOhBY0a
         6LGgoTMusJYQKFIvcDyzv+yQzuEpcrKhchK7GYQl3jfPofP38m5/AyTTQS4j64IyE9
         xO6h2Wko8qWjn5c1pX+Uh45MFhSU8NdeBfJGTRf0hUfGfMnUBPPEDEnHy5ejxYIYEr
         ec/YO9bs3rxow==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf/probe: Support probes on init functions for offline kernel
Date:   Sat,  5 Jun 2021 01:28:23 +0900
Message-Id: <162282410293.452340.13347006295826431632.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162282409255.452340.4645118932261585719.stgit@devnote2>
References: <162282409255.452340.4645118932261585719.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf probe internally checks the probe target is in the text area
in post-process (after analyzing debuginfo). But it fails if the
probe target is in the "inittext".
This is a good limitation for the online kernel because such
functions have gone after booting. However, for using it for
boot-time tracing, user may want to put a probe on init functions.

This skips the post checking process if the target is offline kenrel
so that user can get the probe definition on the init functions.

Without this patch:
  $ perf probe -k ./build-x86_64/vmlinux -D do_mount_root:10
  Probe point 'do_mount_root:10' not found.
    Error: Failed to add events.

With this patch:
  $ perf probe -k ./build-x86_64/vmlinux -D do_mount_root:10
  p:probe/do_mount_root_L10 mount_block_root+300


Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 8fe179d671c3..a6e121afb651 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -682,8 +682,13 @@ static int post_process_probe_trace_point(struct probe_trace_point *tp,
 	u64 addr = tp->address - offs;
 
 	sym = map__find_symbol(map, addr);
-	if (!sym)
-		return -ENOENT;
+	if (!sym) {
+		/*
+		 * If the address is in the inittext section, map can not
+		 * find it. Ignore it if we are probing offline kernel.
+		 */
+		return (symbol_conf.ignore_vmlinux_buildid) ? 0 : -ENOENT;
+	}
 
 	if (strcmp(sym->name, tp->symbol)) {
 		/* If we have no realname, use symbol for it */


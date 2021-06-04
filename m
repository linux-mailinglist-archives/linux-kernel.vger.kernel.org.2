Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5D39BBE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFDPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFDPct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:32:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0647461400;
        Fri,  4 Jun 2021 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622820662;
        bh=HhPIBjF2l9fUquzpGnwEb4o7+Wjeo4+G9l0gwPGt450=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzChDeTHYhHBippoSMnibwESdwGZ6VNecYwVRWiHoLIpeomXGo3TnFSFLc+vIKlyn
         qGfdsLIdktpB8B7xcWrBLxUHXJakn1PpYQfQjKf7oOoBzKWnWrRGyfiUV/HJXricpZ
         g9pLRZeKsksQzlzOuBiZko3cAD6cH7eI1fGXmlSriFC0IO51Tdz7THwcob+bGhS+KR
         m3OFMBiSo2QuG6JwUhBlWtSwS86MYU4HlJahH/mVEZLtXs714mpZu9ZdzH/1+vyL4R
         4nAexDHC5FxJ7Zm93tdozyziF88ljZ8AyQVTc7biZv6Fvf1IT6GlmJpQI23GKyyEVe
         RzI7TbivUle4g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/2] perf/probe: Report possible permission error for map__load failure
Date:   Sat,  5 Jun 2021 00:30:58 +0900
Message-Id: <162282065877.448336.10047912688119745151.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162282064848.448336.15589262399731095367.stgit@devnote2>
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report possible permission error including kptr_restrict setting
for map__load() failure. This can happen when non-superuser runs
perf probe.

With this patch, perf probe shows the following message.

 $ perf probe vfs_read
 Failed to load symbols from /proc/kallsyms
 Please ensure you can read the /proc/kallsyms symbol addresses.
 If the /proc/sys/kernel/kptr_restrict is '2', you can not read
 kernel symbol address even if you are a superuser. Please change
 it to '1'. If kptr_restrict is '1', the superuser can read the
 symbol addresses.
 In that case, please run this command again with sudo.
   Error: Failed to add events.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 3a7649835ec9..8fe179d671c3 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2936,7 +2936,7 @@ static int find_probe_functions(struct map *map, char *name,
 	bool cut_version = true;
 
 	if (map__load(map) < 0)
-		return 0;
+		return -EACCES;	/* Possible permission error to load symbols */
 
 	/* If user gives a version, don't cut off the version from symbols */
 	if (strchr(name, '@'))
@@ -2975,6 +2975,17 @@ void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
 				struct map *map __maybe_unused,
 				struct symbol *sym __maybe_unused) { }
 
+
+static void pr_kallsyms_access_error(void)
+{
+	pr_err("Please ensure you can read the /proc/kallsyms symbol addresses.\n"
+	       "If the /proc/sys/kernel/kptr_restrict is '2', you can not read\n"
+	       "kernel symbol address even if you are a superuser. Please change\n"
+	       "it to '1'. If kptr_restrict is '1', the superuser can read the\n"
+	       "symbol addresses.\n"
+	       "In that case, please run this command again with sudo.\n");
+}
+
 /*
  * Find probe function addresses from map.
  * Return an error or the number of found probe_trace_event
@@ -3011,8 +3022,16 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 	 */
 	num_matched_functions = find_probe_functions(map, pp->function, syms);
 	if (num_matched_functions <= 0) {
-		pr_err("Failed to find symbol %s in %s\n", pp->function,
-			pev->target ? : "kernel");
+		if (num_matched_functions == -EACCES) {
+			pr_err("Failed to load symbols from %s\n",
+			       pev->target ?: "/proc/kallsyms");
+			if (pev->target)
+				pr_err("Please ensure the file is not stripped.\n");
+			else
+				pr_kallsyms_access_error();
+		} else
+			pr_err("Failed to find symbol %s in %s\n", pp->function,
+				pev->target ? : "kernel");
 		ret = -ENOENT;
 		goto out;
 	} else if (num_matched_functions > probe_conf.max_probes) {


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768CF39BBEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFDPdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231172AbhFDPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:32:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4D9F61402;
        Fri,  4 Jun 2021 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622820673;
        bh=tGBLXDuAuIKJSPpoa4UYobRcjJZf0tk1Rc1UX7cyfQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUFwg4bDVGM758V234vXpMbuYRiFp7Ag4YMuKjDPXrM57sVsReu9Fuzg1xYN3x+np
         e4jBA9HbDvGjMZQJ/9mTkIkNCESh0BcBJzcKcqMZ6SXYDJ82TGBC6AFAxH1hiGOzQf
         97Zh83ga+BPE+0M17eZOOhHBTkyXoTUU9cwvbHfsW6Wk3b6nR3WiMOMjdhaFEBhmD5
         lpoNCGTh5Aj9zoQ4nlwDDzfl1FsdhTQU5JIOQ84UjZNnH491NS7NJXLq6OFXwd3FUm
         x+Rsi4fxNi/AHNS06dkoUYbrHYpuqNGA1M4+OkLLyLZUs9h5jsTerwEWhZ4MRE55KY
         3YRF3ylRub5Sg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/2] perf/probe: Report permission error for tracefs error
Date:   Sat,  5 Jun 2021 00:31:08 +0900
Message-Id: <162282066829.448336.16156999655071988915.stgit@devnote2>
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

Report permission error for the tracefs access error.
This can happen when non-superuser runs perf probe.
With this patch, perf probe shows the following message.

  $ perf probe -l
  No permission to access tracefs. Please run this command again with sudo.
    Error: Failed to show event list.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/perf/util/probe-file.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 52273542e6ef..52d878f5a44d 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -48,6 +48,8 @@ static void print_open_warning(int err, bool uprobe)
 			   uprobe ? 'u' : 'k', config);
 	} else if (err == -ENOTSUP)
 		pr_warning("Tracefs or debugfs is not mounted.\n");
+	else if (err == -EACCES)
+		pr_warning("No permission to access tracefs. Please run this command again with sudo.\n");
 	else
 		pr_warning("Failed to open %cprobe_events: %s\n",
 			   uprobe ? 'u' : 'k',
@@ -62,6 +64,8 @@ static void print_both_open_warning(int kerr, int uerr)
 	else if (kerr == -ENOENT && uerr == -ENOENT)
 		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
 			   "or/and CONFIG_UPROBE_EVENTS.\n");
+	else if (kerr == -EACCES && uerr == -EACCES)
+		pr_warning("No permission to access tracefs. Please run this command again with sudo.\n");
 	else {
 		char sbuf[STRERR_BUFSIZE];
 		pr_warning("Failed to open kprobe events: %s.\n",


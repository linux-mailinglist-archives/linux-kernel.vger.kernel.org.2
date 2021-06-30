Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2883B7CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 06:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhF3Edb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 00:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhF3Eda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:33:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720ECC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:31:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3107135pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 21:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n88t6MZE03YYaeLW7VzVlj9SnIItufaJO+bdeY0ffCo=;
        b=qaucdpQ7twaFppXUjAeZWgfzpT6YKxHl2zrvRCBz1wD96P4ZXf4oiMi6d5523/sDBx
         jCmsFyXa/aD3eicIUqR+1LeYyf0VmcZdHYD1ztAHUESpZcBOiCEpO5wRAj130wZfMTNw
         7okQLJzc+/KZptbWQjnc6q8UNXTgfKXN+P2ce5DZ0zLu9KEQvxtrbIjLIosyz2LXMlnZ
         GWMXR1QDDQH9DM5g5yR4O5hjlnuLkWj7FCCfSRa/YKCmj5+480nNIk5vJOvrA4CQrQGD
         n1Bk8/z+TXdt/0MqeyqIaMmhSMAMQuRE/0F3VMd4NTbDpxPWrLR+xVrpMBz7i50jCwZO
         kH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=n88t6MZE03YYaeLW7VzVlj9SnIItufaJO+bdeY0ffCo=;
        b=Dq0MrCI3Q4tnAxESPM3xmFmNnhs2VsJxwsOq+Vf7jtd6UQLLOU06jMgNi7b9eBrK0Y
         Wiegom34aLQhBNP0WMEHnqvf1UBCczF2yluPytGoX5oXQ+SYRC7/ZWLapYwjbLmAiqOl
         IP7IV4lbQxFiwa+f1srtFvj+Tqj1KDcO3oVWOgk27b2osZyeC3ZbGg6ZfVovbaAgNT6t
         XcktrIL3Gl/bnvmm0Hg0zbGgzDd8nJjINJj/tNBFP0fQ/I/FNUpsR8P6GXbjSlBqh9Df
         FjfGPHwV/R+cy1UAPZxZ74oNeIA1me1Ky5PGxqlWZXrEMP7Cy4ljbWLWVy7kmLilyhM8
         +T0g==
X-Gm-Message-State: AOAM532CLGTzn00/5grbAR4/AIFIIG945H/vYINW6RfmVLnw5QAYeWBe
        f2bQdPUR24UCKTdfFWcF5adNIEMgWC+gtA==
X-Google-Smtp-Source: ABdhPJz9soFSu2ejOjRX0h6g780qlZMTg4uFznrLn496b18LCqimjV2H9vCJloSL/tpTgx6ltddwSQ==
X-Received: by 2002:a17:902:d90b:b029:11b:f58c:f3d6 with SMTP id c11-20020a170902d90bb029011bf58cf3d6mr30834433plz.42.1625027460870;
        Tue, 29 Jun 2021 21:31:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:c8a:b7f3:dc3f:27ce])
        by smtp.gmail.com with ESMTPSA id w8sm21708634pgf.81.2021.06.29.21.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 21:31:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf report: Fix --task and --stat with pipe input
Date:   Tue, 29 Jun 2021 21:30:58 -0700
Message-Id: <20210630043058.1131295-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current perf report fails to process a pipe input when --task
or --stat option is used.  This is because they reset all the
tool callbacks and failed to find a matching event for a sample.

When pipe input is used, the event info is passed via ATTR records
so it needs to handle that operation.  Otherwise the following error
occurred.  Note, -14 (= -EFAULT) comes from evlist__parse_sample():

  # perf record -a -o- sleep 1 | perf report -i- --stat
  Can't parse sample, err = -14
  0x271044 [0x38]: failed to process type: 9
  Error:
  failed to process sample

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index bc5c393021dc..8639bbe0969d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -729,9 +729,14 @@ static int count_sample_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static int process_attr(struct perf_tool *tool __maybe_unused,
+			union perf_event *event,
+			struct evlist **pevlist);
+
 static void stats_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.attr = process_attr;
 	rep->tool.sample = count_sample_event;
 	rep->tool.no_warn = true;
 }
@@ -753,6 +758,7 @@ static void tasks_setup(struct report *rep)
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
 	}
+	rep->tool.attr = process_attr;
 	rep->tool.comm = perf_event__process_comm;
 	rep->tool.exit = perf_event__process_exit;
 	rep->tool.fork = perf_event__process_fork;
-- 
2.32.0.93.g670b81a890-goog


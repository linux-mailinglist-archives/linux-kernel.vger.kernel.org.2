Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233284152AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238159AbhIVVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbhIVVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:22:17 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF93C06179A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:20:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z8-20020a056214040800b00380dea65c01so14964787qvx.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DdQUoFRq3sEN1JUX2L/SFL8llDgMarKIfKvV6PGdcNM=;
        b=O4Jy/Ogp/dp680P+CqoX4JCGL8Rm0rGOz/twbZ/PLzUe02DaJhI6ICFOXvxErzAlCR
         R/6GWvxQWHUp4U82Sbykjn+7zGYogeWjiJH57Tz5GYyhl4BaU3gnE0KX4RZ1ByJ27yqg
         KTK0XWu52VN94NN7WJMD4a8uLuEHckFb+t7BiGo8d059NOrbw5rRI5YKbg6UpJuWAX0f
         KyDfEv0HbMTkpH+v0W7BkmEXnM+sHr00HrsEXiG+T1dkghKtmEUIHgclR7QTZECK9RYv
         KDfvaFRH9VIp7PuY6/qEtmyBI8lw0oBxSEVcK020VEV0hlzUWIDty29cqkknxinkLOjm
         m+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DdQUoFRq3sEN1JUX2L/SFL8llDgMarKIfKvV6PGdcNM=;
        b=Nrh8gjcx5F/0qXtTmBA+53s7w8z9OnG/WJr7oJxjbnzTizVqRGdninsMWFq+9LR6yw
         A6fAdmrFbWZ4go/p6S5swXrRAcVBd7W54Nxs1KTLUS7e/K0TcG/N5mbnwdvJVPBA0su/
         PT9L9wVhixFeBVB19fjezv9E5WRfCamv9dB/KAK1hClOt7fHVWlEnu+3/wSdRYnQz3dA
         BNeQK7Dez4qWL53ztpAWtz0NMAh+QmDEOzDVtBgAAniE1NZ2BFVoIZx/fUik7+cQq9vJ
         o76JHjVR+XsOYFYW/1NfB/m3BwerIu6H8X1fQ3RSxSt4IxSul0MvHjGjM0uEAzOxKilo
         fBmA==
X-Gm-Message-State: AOAM5321Wj9V+Nn1CELwlWA7TiFqjs6NSJJYAtxGXdYUZ2XhBetErdrh
        RJ5dIX/LUr4FkQayG3nPUydMyoXd1d7u
X-Google-Smtp-Source: ABdhPJwvhV9ZFc+lkU9LSeXeQy7XtePcMyA7QjfbSu604kbhOmlA4DCMROswouYhlH/9UtbhAyY8Pz95qvWc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a25:c183:: with SMTP id
 r125mr1134144ybf.37.1632345634702; Wed, 22 Sep 2021 14:20:34 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:20:31 -0700
Message-Id: <20210922212031.485950-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] perf kmem: Improve man page for record options
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since:
https://lore.kernel.org/lkml/20200708183919.4141023-1-irogers@google.com/
The output option works for 'perf kmem', however, it must appear after
'record'. This is different to 'stat' where '-i' for the input must
appear before. Try to capture this complication in the man page.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-kmem.txt | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-kmem.txt b/tools/perf/Documentation/perf-kmem.txt
index 85b8ac695c87..f378ac59353d 100644
--- a/tools/perf/Documentation/perf-kmem.txt
+++ b/tools/perf/Documentation/perf-kmem.txt
@@ -8,22 +8,25 @@ perf-kmem - Tool to trace/measure kernel memory properties
 SYNOPSIS
 --------
 [verse]
-'perf kmem' {record|stat} [<options>]
+'perf kmem' [<options>] {record|stat}
 
 DESCRIPTION
 -----------
 There are two variants of perf kmem:
 
-  'perf kmem record <command>' to record the kmem events
-  of an arbitrary workload.
+  'perf kmem [<options>] record [<perf-record-options>] <command>' to
+  record the kmem events of an arbitrary workload. Additional 'perf
+  record' options may be specified after record, such as '-o' to
+  change the output file name.
 
-  'perf kmem stat' to report kernel memory statistics.
+  'perf kmem [<options>] stat' to report kernel memory statistics.
 
 OPTIONS
 -------
 -i <file>::
 --input=<file>::
-	Select the input file (default: perf.data unless stdin is a fifo)
+	For stat, select the input file (default: perf.data unless stdin is a
+	fifo)
 
 -f::
 --force::
-- 
2.33.0.464.g1972c5931b-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D4F3266EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBZScd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZScb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:32:31 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC244C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:31:50 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id r1so7161435qtu.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ldoe3HG1IhqPijNEiOOjsR9XR/MKPo6yA6Bs6hLdTfE=;
        b=izi/aNmMV11+Aw0c1lKFqduye9EDBAAnOnyVrhoguSORaruhIBv50fehFA0BWGQoAB
         aav8cSJJ1GwxjhpeFJKtuxIy+TzB1JFfhw38fcFq86x9yDqIB4xLYlqGktYN5x7xDkmr
         1bbW1YulWAMJtIr3+41ZRVTWgiQY8cxoUUAXqCYWM12Siz9OF2Vd4X/tL81wAxM7ywdu
         yy1HSJf2gylK5hfq5GJEj8CRDIj6HU2V82dhb7KfqnHbfulnJ+RdGIjMMDkTGZMN+fc6
         G/nA/gt3xRcf0YNSanNeU5xkq4/pnKcVfLToll10EK6ai9t88yHUmBcdb7YFZA8aYH/Y
         4p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ldoe3HG1IhqPijNEiOOjsR9XR/MKPo6yA6Bs6hLdTfE=;
        b=LVXGB0C99OOcP0ka0cugsCz+Ne3+j1RkIc6rhfEL3BcGLPMoD1DkW45I8b9Ihustgq
         KYIoabUnZibve0kOdWnjGqg3AUW847gLip/tSZNj1VkbR9afHN+Z/nznmcEBVITJPD9g
         9mbw5JriITWbaiJi6ar0fSvq5KchRXGkWJqGI1NIoTJk/XftY0aPP9CBFhiHvRxZZjU2
         /eJmlNeOxk5ewBXEp5S9WkQrxZaV1guz2h23O9PtYNNlXMPIbtYtwthKEMvXP4vHKFT7
         +pzrD788fJdO60Xsosaat+FQQYnVVWWXI/z7E1ikkmtKKgvQuvilQc53wmviMXlmkne5
         4e0g==
X-Gm-Message-State: AOAM532s56p56UwOGsI/Opya14+CP2/dE4sXSuJvXpuINeeDzB5xmMo1
        9Rzn5iyU7CId2MNnPPjTO/CDOg5YFtJr
X-Google-Smtp-Source: ABdhPJwr3mg2Fdi/LOec4fsBbR0aTujTMxBzlCM0sWpe+r79UqzpBcdmZoaMcllCpIw8SkVxN9o7Sn087Tru
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:199:60bf:2d7e:5bf])
 (user=irogers job=sendgmr) by 2002:a0c:b912:: with SMTP id
 u18mr4118382qvf.2.1614364309739; Fri, 26 Feb 2021 10:31:49 -0800 (PST)
Date:   Fri, 26 Feb 2021 10:31:44 -0800
Message-Id: <20210226183145.1878782-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] perf tools: Fix documentation of verbose options
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Option doesn't take a value, make sure the man pages agree. For example:

$ perf evlist --verbose=1
 Error: option `verbose' takes no value

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-evlist.txt   | 2 +-
 tools/perf/Documentation/perf-ftrace.txt   | 4 ++--
 tools/perf/Documentation/perf-kallsyms.txt | 2 +-
 tools/perf/Documentation/perf-trace.txt    | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-evlist.txt b/tools/perf/Documentation/perf-evlist.txt
index c0a66400a960..9af8b8dfb7b6 100644
--- a/tools/perf/Documentation/perf-evlist.txt
+++ b/tools/perf/Documentation/perf-evlist.txt
@@ -29,7 +29,7 @@ OPTIONS
 	Show just the sample frequency used for each event.
 
 -v::
---verbose=::
+--verbose::
 	Show all fields.
 
 -g::
diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 1e91121bac0f..6e82b7cc0bf0 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -28,8 +28,8 @@ OPTIONS
 	specified: function_graph or function.
 
 -v::
---verbose=::
-        Verbosity level.
+--verbose::
+        Increase the verbosity level.
 
 -F::
 --funcs::
diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
index f3c620951f6e..c97527df8ecd 100644
--- a/tools/perf/Documentation/perf-kallsyms.txt
+++ b/tools/perf/Documentation/perf-kallsyms.txt
@@ -20,5 +20,5 @@ modules).
 OPTIONS
 -------
 -v::
---verbose=::
+--verbose::
 	Increase verbosity level, showing details about symbol table loading, etc.
diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index abc9b5d83312..f0da8cf63e9a 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -97,8 +97,8 @@ filter out the startup phase of the program, which is often very different.
 	Filter out events for these pids and for 'trace' itself (comma separated list).
 
 -v::
---verbose=::
-        Verbosity level.
+--verbose::
+        Increase the verbosity level.
 
 --no-inherit::
 	Child tasks do not inherit counters.
-- 
2.30.1.766.gb4fecdf3b7-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5A3AA759
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 01:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhFPXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhFPXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 19:21:11 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:19:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r17-20020ac842510000b02902456ec03025so2684460qtm.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KL9pKlY+SIJOEMhWl6PcXG3HYKZEILy2NYmCGtJLkuQ=;
        b=qKc9QFFkHvy6IcEHA67n4jMWEs9Xq4Vjuhou1aNH78223eIR1uLUtjOm1Z50c30PxA
         JgVZ76QZEhuhUmW9zqpcyFcwDiUpmpS40B3Bva8bTYDjoaBDQtFIvqhV55hzvay3l+iW
         F0SfqsFb0ZQ2LuiwYiw08DzdQxrssiC4YjU+I5sOmSbJ1HIebplADFL+W+saHGlA2m3C
         ZAK80XSk0bLZIprUFgVNTBlfImOAaHa1Fm/D5cPZ7s+OIdSFCsenNfG+DlouYqu5Ppa8
         479NQ8AkKYcNwH4Mre0ykFgVxURNyXxaerVaLDtXZNWLNWAoWuAyWdoQZuHiBqeTAwUh
         2XfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KL9pKlY+SIJOEMhWl6PcXG3HYKZEILy2NYmCGtJLkuQ=;
        b=Qf6kGglVSquMSVxWDmzXxKoc1DbB3p8Tx7VVDIT56pY3K9qasWtfpBVbbTeSfP7dqz
         FiGISzWoFIjq+3c95h2T1MgIxWMKs3veGD5oxTuf8DUxeXeRpDDg91CwSSjaWJ2mh3Ur
         p0b8B97gcVVQGkPEONX4HkM4NfyZxJWgQyhEMvZmVgVCBC1bYaru5Eg6O7DSr08rN++m
         5kUnoH6vzPhgVuN5gOAUhJZIXTEWgM4+Fve4ACC5K5JDZeOxT3MNHPmih/RtemMIHo6W
         zUISrT1zTFiQ2q82eKiMYhgO6JofbtlXLkyFmummL+dv/274C36LLEaPst5m6jJc+dGA
         2S7g==
X-Gm-Message-State: AOAM5330mXTYfG2STaFB47ZR7fM6pmsYSRdZQnI4/461w9yoVk5XJ7Cj
        cRYwU6axUa9PJK3Gxm8nUVUDOdtWXCdyqnCd
X-Google-Smtp-Source: ABdhPJw1YYp+pbF4FBjYjbuLLGcv6TfeDyZPs9rghE2USRFVYc0FBxMMfNPY0pFL6VvgEy44c969zPqKp9KO254c
X-Received: from joshuamart.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:22e9])
 (user=joshuamart job=sendgmr) by 2002:ad4:576e:: with SMTP id
 r14mr2645445qvx.61.1623885538333; Wed, 16 Jun 2021 16:18:58 -0700 (PDT)
Date:   Wed, 16 Jun 2021 23:18:29 +0000
Message-Id: <20210616231829.3735671-1-joshuamart@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] perf top: Add cgroup support for perf top (-G)
From:   Joshua Martinez <joshuamart@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        irogers@google.com
Cc:     Joshua Martinez <joshuamart@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added callback option (-G) to support cgroups for perf top.
Added condition to make sure -cgroup and --all-cgroups aren't both enabled.

Example:
$perf top -e cycles -G system.slice/docker-6b95a5eb649c0d671eba3835f0d93973d05a088f3ae8602246bde37affb1ba3e.scope -a --stdio

   PerfTop:    3330 irqs/sec  kernel:68.2%  exact:  0.0% lost: 0/0 drop: 0/11075 [4000Hz cpu-clock],  (all, 4 CPUs)
----------------------------------------------------------------------------------------------------------------------------------------------------------

    27.32%  [unknown]         [.] 0x00007f8ab7b69352
    11.44%  [kernel]          [k] 0xffffffff968cd657
     3.12%  [kernel]          [k] 0xffffffff96160e96
     2.63%  [kernel]          [k] 0xffffffff96160eb0
     1.96%  [kernel]          [k] 0xffffffff9615fcf6
     1.42%  [kernel]          [k] 0xffffffff964ddfc7
     1.09%  [kernel]          [k] 0xffffffff96160e90
     0.81%  [kernel]          [k] 0xffffffff96160eb3
     0.67%  [kernel]          [k] 0xffffffff9615fec1
     0.57%  [kernel]          [k] 0xffffffff961ee1d0
     0.53%  [unknown]         [.] 0x00007f8ab7b6666c
     0.53%  [kernel]          [k] 0xffffffff96160e64
     0.52%  [kernel]          [k] 0xffffffff9616c303
     0.51%  [kernel]          [k] 0xffffffffc08e7d50
     ...

Signed-off-by: Joshua Martinez <joshuamart@google.com>
---
 tools/perf/Documentation/perf-top.txt | 12 ++++++++++++
 tools/perf/builtin-top.c              |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index bba5ffb05463..9898a32b8d9c 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -277,6 +277,18 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+-G name::
+--cgroup name::
+monitor only in the container (cgroup) called "name". This option is available only
+in per-cpu mode. The cgroup filesystem must be mounted. All threads belonging to
+container "name" are monitored when they run on the monitored CPUs. Multiple cgroups
+can be provided. Each cgroup is applied to the corresponding event, i.e., first cgroup
+to first event, second cgroup to second event and so on. It is possible to provide
+an empty cgroup (monitor all the time) using, e.g., -G foo,,bar. Cgroups must have
+corresponding events, i.e., they always refer to events defined earlier on the command
+line. If the user wants to track multiple events for a specific cgroup, the user can
+use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
+
 --all-cgroups::
 	Record events of type PERF_RECORD_CGROUP and display it with the
 	'cgroup' sort key.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 69cb3635f5ef..2d570bfe7a56 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -22,6 +22,7 @@
 
 #include "util/annotate.h"
 #include "util/bpf-event.h"
+#include "util/cgroup.h"
 #include "util/config.h"
 #include "util/color.h"
 #include "util/dso.h"
@@ -1558,6 +1559,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
+	OPT_CALLBACK('G', "cgroup", &top.evlist, "name",
+		     "monitor event in cgroup name only", parse_cgroups),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
 	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
@@ -1646,6 +1649,11 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (nr_cgroups > 0 && opts->record_cgroup) {
+		pr_err("--cgroup and --all-cgroups cannot be used together\n");
+		goto out_delete_evlist;
+	}
+
 	if (opts->branch_stack && callchain_param.enabled)
 		symbol_conf.show_branchflag_count = true;
 
-- 
2.32.0.272.g935e593368-goog


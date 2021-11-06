Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6085044700D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 20:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhKFTWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 15:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhKFTWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 15:22:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 490D4610E9;
        Sat,  6 Nov 2021 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636226369;
        bh=1IbxCHwEU9IOFKyrsw6XV4EKp1VlAt7xuPlI6rfA3h0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RmDWcUkMt/X+eKb8oRfwhj4Xcion+8T5rMGgdFUxAQA2yzgjO+KVgW+bGEOqVddn/
         uPmgrVxTBGw4kQwZDk9yb/u3dESrpdCN2lEJlKryO0ZPwBcEJlUtXQLlNFan8VEH3C
         xateqGyayp9hxp47IkVa9FIgzjDlh9q8Sx+vtnb98x5vq8VLFeebBvSQ7ROnuv7pvF
         E83a1VCTNbc3Fu6UlMAiNv/2jbkqEyCwAepsA+U8S+brkSbQsmuFp9JC48NQwFdETU
         s5MLxYYZreydHq/J/OB4psF/35muavdxsnmTpQJ8+pbPJFh+p5Q2Gc+l40RdjS1byr
         xDkv8CJknsr9g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68494410A1; Sat,  6 Nov 2021 16:19:26 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:19:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v4] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYbVPmrF0CD6KFLk@kernel.org>
References: <20211105205847.120950-1-namhyung@kernel.org>
 <YYbS/UoQ9wHAc44j@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYbS/UoQ9wHAc44j@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 06, 2021 at 04:09:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 05, 2021 at 01:58:47PM -0700, Namhyung Kim escreveu:
> > The current logic for the perf missing feature has a bug that it can
> > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > support any filtering or exclusion while others do.  But we check it
> > as a global feature.
> > 
> > For example, the cycles event can have 'G' modifier to enable it only
> > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> > 
> >   # perf stat -a -e cycles:G sleep 1
> > 
> >     Performance counter stats for 'system wide':
> > 
> >                     0      cycles:G
> > 
> >           1.000721670 seconds time elapsed
> > 
> > But when it's used with other pmu events that don't support G modifier,
> > it'll be reset and return non-zero values.
> > 
> >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> > 
> >     Performance counter stats for 'system wide':
> > 
> >           538,029,960      cycles:G
> >        16,924,010,738      msr/tsc/
> > 
> >           1.001815327 seconds time elapsed
> > 
> > This is because of the missing feature detection logic being global.
> > Add a hashmap to set pmu-specific exclude_host/guest features.
> 
> ⬢[acme@toolbox perf]$ perf test python
> 19: 'import perf' in python                                         : FAILED!
> ⬢[acme@toolbox perf]$ perf test -v python
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
> 19: 'import perf' in python                                         :
> --- start ---
> test child forked, pid 11602
> python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: evsel__find_pmu
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> ⬢[acme@toolbox perf]$
> 
> Trying to fix this now. please do a 'perf test' before submitting
> patches.

Added this bandaid, should be good for the time being.

- Arnaldo

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8feef3a05af7b31d..563a9ba8954f31b3 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -69,6 +69,18 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 {
 }

+/*
+ * This one is needed not to drag the PMU bandwagon, jevents generated
+ * pmu_sys_event_tables, etc and evsel__find_pmu() is used so far just for
+ * doing per PMU perf_event_attr.exclude_guest handling, not really needed, so
+ * far, for the perf python binding known usecases, revisit if this become
+ * necessary.
+ */
+struct perf_pmu *evsel__find_pmu(struct evsel *evsel __maybe_unused)
+{
+       return NULL;
+}
+


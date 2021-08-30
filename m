Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534B23FBCAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 20:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhH3Suv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 14:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhH3Suq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:50:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F205760F3A;
        Mon, 30 Aug 2021 18:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630349392;
        bh=udvv/0pGkfqii7OTrZR4/YqSuw6NnWA1FbONY3Ma2RI=;
        h=Date:From:To:Cc:Subject:From;
        b=JShH6IctYifgXZdQLqRZMwrkPUhNDumRtIzptT5byt+f98JJCeyMtTyiQ4AjWOX/p
         HPSwEwdSR47axTeejJ6o9R7yxPm9EH4hZlsqq66Rue26s+YF4TTxzUVkkmOVnDo5S+
         fki3LkUbWLs4mV+1SanWZ5g03o1uVNBRQZxfwMdheBtfS0J05atJJ/LU/cmvPJXQ7B
         Sg2Oizd47fuTMy8a9hVxZx7NurJIOGxkHam9InXiYycUoTpXAZPIFG+rkqfdU43UrB
         bJ/ILGquiWW7p7o51nsIva/7J7Ckh8hoxksp2j1hbqr5eT2YHozSBNedAvboXVdcoh
         yB2PwozjSqaaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82B134007E; Mon, 30 Aug 2021 15:49:49 -0300 (-03)
Date:   Mon, 30 Aug 2021 15:49:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf bench evlist-open-close: Use PRIu64 with u64 to fix
 build on 32-bit architectures
Message-ID: <YS0oTcA9Zuy8Wjm9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riccardo,

	I'm applying this one here, please take this into account in the
future when using u64 in printf-like routines.

- Arnaldo

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  73     9.00 ubuntu:18.04-x-powerpc        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
    bench/evlist-open-close.c: In function 'bench_evlist_open_close__run':
    bench/evlist-open-close.c:173:12: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
       pr_debug("Iteration %d took:\t%ldus\n", i, runtime_us);
                ^
    bench/../util/debug.h:18:21: note: in definition of macro 'pr_fmt'
     #define pr_fmt(fmt) fmt
                         ^~~
    bench/evlist-open-close.c:173:3: note: in expansion of macro 'pr_debug'
       pr_debug("Iteration %d took:\t%ldus\n", i, runtime_us);
       ^~~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-5.14.0/tools/build/Makefile.build:139: recipe for target 'bench' failed

Cc: Riccardo Mancini <rickyman7@gmail.com>
Fixes: 4241eabf59d5b7e9 ("perf bench: Add benchmark for evlist open/close operations")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/evlist-open-close.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 674cb14cbaa9ef2c..83e9897c64a13179 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <limits.h>
@@ -170,7 +171,7 @@ static int bench_evlist_open_close__run(char *evstr)
 		update_stats(&time_stats, runtime_us);
 
 		evlist__delete(evlist);
-		pr_debug("Iteration %d took:\t%ldus\n", i, runtime_us);
+		pr_debug("Iteration %d took:\t%" PRIu64 "us\n", i, runtime_us);
 	}
 
 	time_average = avg_stats(&time_stats);
-- 
2.31.1


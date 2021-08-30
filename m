Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7423FBA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhH3RC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbhH3RC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:02:58 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E42C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:02:04 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e7so14056210pgk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9a8VH6jp4ZknHI98I833vKnDvC+Wtkab9LNCdiWsz5E=;
        b=E5qr0ZaUOSElHeMSrmsIGM16uVao33/vp3U7VN8BFhp9ZkFj7VsdV/i0CsNrFoZ9vc
         w3l8TiRbPQFopcBT+gdyuNfD/EGZE3UH2ZhjWd5Jyavr30+6ToqG4QWWkOBli/aQwQ3J
         /Z5qsuDWUYLpKQ99nHn9BfpB3TP8Qg10C84ORmeThCRzG/N9KBGYCPAJWB1Lf7QeOxez
         0aFBXLFWQ0HOPseZs4qas/ups/nEk+bBxMOC2r760vxvtcVE77SUrspzDdwf4shZmK5Y
         Dnr7lIra4beNqLebSe7xu5WH/tOOFgGtxqUq2VEHvBfOo61A2kbxY8pmNYEBwaEn3eCp
         b53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9a8VH6jp4ZknHI98I833vKnDvC+Wtkab9LNCdiWsz5E=;
        b=TechTuLcdwItPyIbRd1YhtdxUAfDhGuSswzYdIz9ZMMwjj3NKUdcVQ9p04KKWEzu4z
         wcqViKqvMpnDIQ2nQ4vSF79JER5cXWAngZBULZ+0+bdoIeC+aeTxIfFOUQ+xVfQTuzcz
         gI0rjQUkxmnMoIhjkmKD2152Eva+XC3IxCePdxXI63evpOgJwNamOk0DR6013YHSu7mf
         XTlsA2BdZC3XpKqW87qeFIR8/B9tdhjkUsdTDGUOXsFCzWeZHoCAZ54mYD7fHOp+mefq
         L+n16U6QGVtHB/SWygompAB1NhnoIoLbZQM/uIyUR+VvnelsWZc0ch7fzcFTltljXTlV
         9d3w==
X-Gm-Message-State: AOAM532RC1hK6XX7KLAiBdUGA4LIoEK5/eEFOMi3+K+DpawbF6lgslwU
        LoSjQHyarI1dego42px5QX0=
X-Google-Smtp-Source: ABdhPJwPUwptw+jdSXMEGWAG66fKLOkY2/KSJfTt4MGoYiJyACqPkLSUU4HMvEHmTn+5rO0t0F8rEA==
X-Received: by 2002:a63:4b4c:: with SMTP id k12mr14508321pgl.172.1630342923757;
        Mon, 30 Aug 2021 10:02:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:c7e0:15d:ee02:2186])
        by smtp.gmail.com with ESMTPSA id l19sm60299pjq.10.2021.08.30.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:02:03 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH] perf stat: Do not allow --for-each-cgroup without cpu
Date:   Mon, 30 Aug 2021 10:02:00 -0700
Message-Id: <20210830170200.55652-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup mode should work with cpu events.  Warn if --for-each-cgroup
option is used with a task target like existing -G option.

  # perf stat --for-each-cgroup . sleep 1
  both cgroup and no-aggregation modes only available in system-wide mode

   Usage: perf stat [<options>] [<command>]

      -G, --cgroup <name>   monitor event in cgroup name only
      -A, --no-aggr         disable CPU count aggregation
      -a, --all-cpus        system-wide collection from all CPUs
          --for-each-cgroup <name>
                            expand events for each cgroup

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 84de61795e67..1a64aebc0d2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2386,7 +2386,8 @@ int cmd_stat(int argc, const char **argv)
 	 * --per-thread is aggregated per thread, we dont mix it with cpu mode
 	 */
 	if (((stat_config.aggr_mode != AGGR_GLOBAL &&
-	      stat_config.aggr_mode != AGGR_THREAD) || nr_cgroups) &&
+	      stat_config.aggr_mode != AGGR_THREAD) ||
+	     (nr_cgroups || stat_config.cgroup_list)) &&
 	    !target__has_cpu(&target)) {
 		fprintf(stderr, "both cgroup and no-aggregation "
 			"modes only available in system-wide mode\n");
@@ -2394,6 +2395,7 @@ int cmd_stat(int argc, const char **argv)
 		parse_options_usage(stat_usage, stat_options, "G", 1);
 		parse_options_usage(NULL, stat_options, "A", 1);
 		parse_options_usage(NULL, stat_options, "a", 1);
+		parse_options_usage(NULL, stat_options, "for-each-cgroup", 0);
 		goto out;
 	}
 
-- 
2.33.0.259.gc128427fd7-goog


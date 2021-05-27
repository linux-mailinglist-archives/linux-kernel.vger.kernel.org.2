Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECDC392909
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 09:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhE0H5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 03:57:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:39429 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235048AbhE0H5G (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 03:57:06 -0400
IronPort-SDR: 19trqLhoCS0l50WtNl/3fyT+icwj06phP2iaZvtf1Xvn/z7TebpgmTxcOI8mSgzpoHPCXCksvY
 uE97bSe+YfSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288262849"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="288262849"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 00:54:47 -0700
IronPort-SDR: g7w4AO6Jkvvymo0Dr9UZwThJKu2qFF9+q3uXYZqm3kV9dyJJSCUpPKTcgbVaGIj7AGa7n0Xqbo
 KsYeLVROwh8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547586590"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 00:54:45 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 6/8] perf mem: Fix wrong verbose output for recording events
Date:   Thu, 27 May 2021 08:16:08 +0800
Message-Id: <20210527001610.10553-7-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527001610.10553-1-yao.jin@linux.intel.com>
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code:

for (j = 0; j < argc; j++, i++)
        rec_argv[i] = argv[j];

if (verbose > 0) {
        pr_debug("calling: record ");

        while (rec_argv[j]) {
                pr_debug("%s ", rec_argv[j]);
                j++;
        }
        pr_debug("\n");
}

The entries of argv[] are copied to the end of rec_argv[], not
copied to the beginning of rec_argv[]. So the index j at
rec_argv[] doesn't point to the first event.

Now we record the start index and end index for events in rec_argv[],
and print them if verbose is enabled.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - New in v2.

 tools/perf/builtin-mem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 6b633df458c2..0fd2a74dbaca 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -65,6 +65,7 @@ static const char * const *record_mem_usage = __usage;
 static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 {
 	int rec_argc, i = 0, j, tmp_nr = 0;
+	int start, end;
 	const char **rec_argv;
 	char **rec_tmp;
 	int ret;
@@ -144,9 +145,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (mem->data_page_size)
 		rec_argv[i++] = "--data-page-size";
 
+	start = i;
 	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
 	if (ret)
 		goto out;
+	end = i;
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
@@ -160,10 +163,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	if (verbose > 0) {
 		pr_debug("calling: record ");
 
-		while (rec_argv[j]) {
+		for (j = start; j < end; j++)
 			pr_debug("%s ", rec_argv[j]);
-			j++;
-		}
+
 		pr_debug("\n");
 	}
 
-- 
2.17.1


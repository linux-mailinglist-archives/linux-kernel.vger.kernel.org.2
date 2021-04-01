Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB13513B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhDAKgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:36:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:24643 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233760AbhDAKf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:35:57 -0400
IronPort-SDR: EvEfbOm7JEGGuoE9DeCv+DJSQI0BOCglE6jazw2sKXqeEnxI7XGfmtri7Pe5C3/HoDGbn4QriW
 ch8ZHslfwwAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192241135"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192241135"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 03:35:56 -0700
IronPort-SDR: uLtn0qHe95Rdu3q4NBD3H5nsB30oX7pP1IxMOAdlwagyMGZtCWvOtLrYuHBKVeq2hGSNKk9fzF
 1u2YtDjd37Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="610873649"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 01 Apr 2021 03:35:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject: Fix repipe usage
Date:   Thu,  1 Apr 2021 13:36:05 +0300
Message-Id: <20210401103605.9000-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 14d3d5405253 ("perf session: Try to read pipe data from file")
perf inject has started printing "PERFILE2h" when not processing pipes.

The commit exposed perf to the possiblity that the input is not a pipe but
the 'repipe' parameter gets used. That causes the printing because perf
inject sets 'repipe' to true always.

The 'repipe' parameter of perf_session__new() is used by 2 functions:
	- perf_file_header__read_pipe()
	- trace_report()
In both cases, the functions copy data to STDOUT_FILENO when 'repipe' is
true.

Fix by setting 'repipe' to true only if the output is a pipe.

Fixes: e558a5bd8b74 ("perf inject: Work with files")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6fe44d97fde5..ddccc0eb7390 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -906,7 +906,7 @@ int cmd_inject(int argc, const char **argv)
 	}
 
 	data.path = inject.input_name;
-	inject.session = perf_session__new(&data, true, &inject.tool);
+	inject.session = perf_session__new(&data, inject.output.is_pipe, &inject.tool);
 	if (IS_ERR(inject.session))
 		return PTR_ERR(inject.session);
 
-- 
2.17.1


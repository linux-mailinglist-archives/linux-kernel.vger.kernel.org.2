Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE33E8E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhHKKLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:11:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:17186 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237034AbhHKKLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:11:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="195363667"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="195363667"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 03:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506890985"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 03:10:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/6] perf tools: Amend dlfilter documentation wrt library dependencies
Date:   Wed, 11 Aug 2021 13:10:34 +0300
Message-Id: <20210811101036.17986-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811101036.17986-1-adrian.hunter@intel.com>
References: <20210811101036.17986-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like all locally-built programs, dlfilters may need to be re-built if
shared libraries they use change. Also there may be unexpected results
if the dfilter uses different versions of the shared libraries that perf
uses.

Note those things in the documentation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index ece07509d1f7..594f5a5a0c9e 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -246,6 +246,14 @@ To use the filter with perf script:
 
 	perf script --dlfilter dlfilter-example.so
 
+NOTES
+-----
+
+The dlfilter .so file will be dependent on shared libraries. If those change,
+it may be necessary to rebuild the .so. Also there may be unexpected results
+if the .so uses different versions of the shared libraries that perf uses.
+Versions can be checked using the ldd command.
+
 SEE ALSO
 --------
 linkperf:perf-script[1]
-- 
2.17.1


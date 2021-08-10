Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8403E596A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240268AbhHJLsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:48:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:64075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240314AbhHJLs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="236894491"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="236894491"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 04:47:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="589277363"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2021 04:47:47 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf tools: Amend dlfilter documentation wrt library dependencies
Date:   Tue, 10 Aug 2021 14:48:11 +0300
Message-Id: <20210810114813.12951-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810114813.12951-1-adrian.hunter@intel.com>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
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
index 02842cb4cf90..322510d3ec0c 100644
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


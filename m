Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CBD38C2F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhEUJXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:23:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:43358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235995AbhEUJWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:22:48 -0400
IronPort-SDR: qAb6iUWV3bqYQItwNZsIuHID9ZGklG32q4ZxvmxwNr2Xd7kqrRJEeHyLDgPJQ8tl4Y3l0kDzfc
 j0JuaLaIpKaA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181056451"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181056451"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 02:20:34 -0700
IronPort-SDR: 3QfjvEbHTEFAAdULrq3OrXIOh+gTD8BZr+STl+coXSGlv9Gnwbq/yuVbU5bTqvjJWxb0ElNODB
 nwrFv+IfprfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631750086"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2021 02:20:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf scripts python: exported-sql-viewer.py: Fix warning display
Date:   Fri, 21 May 2021 12:20:53 +0300
Message-Id: <20210521092053.25683-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521092053.25683-1-adrian.hunter@intel.com>
References: <20210521092053.25683-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecation warnings are useful only for the developer, not an end user.
Display warnings only when requested using the python -W option. This
stops the display of warnings like:

 tools/perf/scripts/python/exported-sql-viewer.py:5102: DeprecationWarning:
         an integer is required (got type PySide2.QtCore.Qt.AlignmentFlag).
         Implicit conversion to integers using __int__ is deprecated, and
         may be removed in a future version of Python.
    err = app.exec_()

Since the warning can be fixed only in PySide2, we must wait for it to
be finally fixed there.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org      # v5.3+
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 4a63843f623c..711d4f9f5645 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -91,6 +91,11 @@
 from __future__ import print_function
 
 import sys
+# Only change warnings if the python -W option was not used
+if not sys.warnoptions:
+	import warnings
+	# PySide2 causes deprecation warnings, ignore them.
+	warnings.filterwarnings("ignore", category=DeprecationWarning)
 import argparse
 import weakref
 import threading
-- 
2.17.1


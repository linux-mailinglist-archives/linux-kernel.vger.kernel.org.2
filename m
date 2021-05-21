Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC69838C2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEUJXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:23:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:43361 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236055AbhEUJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:22:47 -0400
IronPort-SDR: 3RFGJqRlgXVt3LCrrG1PtF8+iec9ImqWpg/bBfwzXHI3nNVVk99F91i2ld4MgWkGS1545XJwY2
 3gu7ZULd+bKg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181056447"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181056447"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 02:20:32 -0700
IronPort-SDR: cyOYonAL+fCLFKNPEfuHbdr+y80O60kUv+rLNIrVAW9Ctk0IX6O7fKnUbcyBGmArli+lZPbT/B
 cdEDkEIwFo7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631750076"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2021 02:20:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf scripts python: exported-sql-viewer.py: Fix Array TypeError
Date:   Fri, 21 May 2021 12:20:52 +0300
Message-Id: <20210521092053.25683-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521092053.25683-1-adrian.hunter@intel.com>
References: <20210521092053.25683-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'Array' class is present in more than one python standard library.
In some versions of Python 3, the following error occurs:

Traceback (most recent call last):
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 4702, in <lambda>
    reports_menu.addAction(CreateAction(label, "Create a new window displaying branch events", lambda a=None,x=dbid: self.NewBranchView(x), self))
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 4727, in NewBranchView
    BranchWindow(self.glb, event_id, ReportVars(), self)
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 3208, in __init__
    self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, report_vars.where_clause))
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 343, in LookupCreateModel
    model = create_fn()
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 3208, in <lambda>
    self.model = LookupCreateModel(model_name, lambda: BranchModel(glb, event_id, report_vars.where_clause))
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 3124, in __init__
    self.fetcher = SQLFetcher(glb, sql, prep, self.AddSample)
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 2658, in __init__
    self.buffer = Array(c_char, self.buffer_size, lock=False)
TypeError: abstract class

This apparently happens because Python can be inconsistent about which
class of the name 'Array' gets imported. Fix by importing explicitly by
name so that only the desired 'Array' gets imported.

Fixes: 8392b74b575c3 ("perf scripts python: exported-sql-viewer.py: Add ability to display all the database tables")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/exported-sql-viewer.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index b5078d65704e..4a63843f623c 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -125,8 +125,9 @@ if pyside_version_1:
 	from PySide.QtGui import *
 	from PySide.QtSql import *
 
-from decimal import *
-from ctypes import *
+from decimal import Decimal, ROUND_HALF_UP
+from ctypes import CDLL, Structure, create_string_buffer, addressof, sizeof, \
+		   c_void_p, c_bool, c_byte, c_char, c_int, c_uint, c_longlong, c_ulonglong
 from multiprocessing import Process, Array, Value, Event
 
 # xrange is range in Python3
-- 
2.17.1


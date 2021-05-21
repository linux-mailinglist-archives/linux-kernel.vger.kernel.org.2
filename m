Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092CB38C2F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhEUJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 05:22:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:43359 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234297AbhEUJWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 05:22:47 -0400
IronPort-SDR: PzaOvqBdJ1RMVuiuFSpb5xMZlpCwiLxfvYrwyAIi8RqJdVwXZBzUx57FUyM+ACUSwT73bVzFDq
 MkDyOQOpPf8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181056446"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181056446"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 02:20:30 -0700
IronPort-SDR: BH08kDWmIB85e1jxLO1LeOA51/BLv93jTcp+kfL1WRvV+ORGP4mL4hcYC6+ds3JmXDRdMJa6sG
 KhRsqLR95EBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="631750068"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga005.fm.intel.com with ESMTP; 21 May 2021 02:20:29 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf scripts python: exported-sql-viewer.py: Fix copy to clipboard from Top Calls by elapsed Time report
Date:   Fri, 21 May 2021 12:20:51 +0300
Message-Id: <20210521092053.25683-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521092053.25683-1-adrian.hunter@intel.com>
References: <20210521092053.25683-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide missing argument to prevent following error when copying a
selection to the clipboard:

Traceback (most recent call last):
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 4041, in <lambda>
    menu.addAction(CreateAction("&Copy selection", "Copy to clipboard", lambda: CopyCellsToClipboardHdr(self.view), self.view))
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 4021, in CopyCellsToClipboardHdr
    CopyCellsToClipboard(view, False, True)
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 4018, in CopyCellsToClipboard
    view.CopyCellsToClipboard(view, as_csv, with_hdr)
  File "tools/perf/scripts/python/exported-sql-viewer.py", line 3871, in CopyTableCellsToClipboard
    val = model.headerData(col, Qt.Horizontal)
TypeError: headerData() missing 1 required positional argument: 'role'

Fixes: 96c43b9a7ab3b ("perf scripts python: exported-sql-viewer.py: Add copy to clipboard")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/scripts/python/exported-sql-viewer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 7daa8bb70a5a..b5078d65704e 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -3868,7 +3868,7 @@ def CopyTableCellsToClipboard(view, as_csv=False, with_hdr=False):
 	if with_hdr:
 		model = indexes[0].model()
 		for col in range(min_col, max_col + 1):
-			val = model.headerData(col, Qt.Horizontal)
+			val = model.headerData(col, Qt.Horizontal, Qt.DisplayRole)
 			if as_csv:
 				text += sep + ToCSValue(val)
 				sep = ","
-- 
2.17.1


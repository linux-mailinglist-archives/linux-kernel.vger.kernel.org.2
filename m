Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E63E5967
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbhHJLsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:48:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:64067 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240315AbhHJLs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="236894500"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="236894500"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 04:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="589277373"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2021 04:47:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf tools: Move perf_dlfilters.h in the source tree
Date:   Tue, 10 Aug 2021 14:48:12 +0300
Message-Id: <20210810114813.12951-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810114813.12951-1-adrian.hunter@intel.com>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_dlfilters.h in the source tree so that it will be found when
building dlfilters as part of the perf build.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.perf                          | 2 +-
 tools/perf/{util => include/perf}/perf_dlfilter.h | 0
 tools/perf/util/dlfilter.c                        | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/perf/{util => include/perf}/perf_dlfilter.h (100%)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 77e7f18c0bd0..6dafde69d5e3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -925,7 +925,7 @@ install-tools: all install-gtk
 		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
 		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
-		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
+		$(INSTALL) -m 644 include/perf/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
 ifndef NO_PERF_READ_VDSO32
 	$(call QUIET_INSTALL, perf-read-vdso32) \
 		$(INSTALL) $(OUTPUT)perf-read-vdso32 '$(DESTDIR_SQ)$(bindir_SQ)';
diff --git a/tools/perf/util/perf_dlfilter.h b/tools/perf/include/perf/perf_dlfilter.h
similarity index 100%
rename from tools/perf/util/perf_dlfilter.h
rename to tools/perf/include/perf/perf_dlfilter.h
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index ca33fbc5efde..7d11ce76157c 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -21,7 +21,7 @@
 #include "symbol.h"
 #include "srcline.h"
 #include "dlfilter.h"
-#include "perf_dlfilter.h"
+#include "../include/perf/perf_dlfilter.h"
 
 static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 {
-- 
2.17.1


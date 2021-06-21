Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9C3AEBF6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhFUPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:07:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:58545 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFUPHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:31 -0400
IronPort-SDR: HJf8CT8QenQAWVuXbeQvJ48jKLpfxtv8jLwc6Kw0x/ZUQhrD2mKv2JXE8Xc+d55QC4pwc46l+Q
 l5DVCO8q5vcA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998902"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998902"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:05:17 -0700
IronPort-SDR: lYJvoZFOJF9sR6mMgD3hSTTTuxEO8pHWIzWNBSpayv48gt6DgAKhuGRkgiKGdjArdua7geNw6f
 JLVpxIXE4r1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519546"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:05:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 06/11] perf build: Install perf_dlfilter.h
Date:   Mon, 21 Jun 2021 18:05:09 +0300
Message-Id: <20210621150514.32159-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of the --dlfilter option need to include perf_dlfilter.h
in their filters. Install it to the include path.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.config | 3 +++
 tools/perf/Makefile.perf   | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a62d09808fef..87f9a139a89c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1118,6 +1118,8 @@ prefix ?= $(HOME)
 endif
 bindir_relative = bin
 bindir = $(abspath $(prefix)/$(bindir_relative))
+includedir_relative = include
+includedir = $(abspath $(prefix)/$(includedir_relative))
 mandir = share/man
 infodir = share/info
 perfexecdir = libexec/perf-core
@@ -1150,6 +1152,7 @@ ETC_PERFCONFIG_SQ = $(subst ','\'',$(ETC_PERFCONFIG))
 STRACE_GROUPS_DIR_SQ = $(subst ','\'',$(STRACE_GROUPS_DIR))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+includedir_SQ = $(subst ','\'',$(includedir))
 mandir_SQ = $(subst ','\'',$(mandir))
 infodir_SQ = $(subst ','\'',$(infodir))
 perfexecdir_SQ = $(subst ','\'',$(perfexecdir))
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e47f04e5b51e..c9e0de5b00c1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -923,7 +923,9 @@ install-tools: all install-gtk
 	$(call QUIET_INSTALL, binaries) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'; \
 		$(INSTALL) $(OUTPUT)perf '$(DESTDIR_SQ)$(bindir_SQ)'; \
-		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(bindir_SQ)/trace'
+		$(LN) '$(DESTDIR_SQ)$(bindir_SQ)/perf' '$(DESTDIR_SQ)$(dir_SQ)/trace'; \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(includedir_SQ)/perf'; \
+		$(INSTALL) util/perf_dlfilter.h -t '$(DESTDIR_SQ)$(includedir_SQ)/perf'
 ifndef NO_PERF_READ_VDSO32
 	$(call QUIET_INSTALL, perf-read-vdso32) \
 		$(INSTALL) $(OUTPUT)perf-read-vdso32 '$(DESTDIR_SQ)$(bindir_SQ)';
-- 
2.17.1


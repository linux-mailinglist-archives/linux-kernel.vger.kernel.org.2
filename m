Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8841D347
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348317AbhI3Gat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:30:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:31838 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348307AbhI3Gar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:30:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="286132428"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="286132428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 23:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="520226146"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2021 23:29:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools: Suppress 'rm dlfilter' build message
Date:   Thu, 30 Sep 2021 09:28:49 +0300
Message-Id: <20210930062849.110416-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build message:

	rm dlfilters/dlfilter-test-api-v0.o

is unwanted.

The object fle is being treated as an intermediate file and being
automatically removed. Mark the object file as .SECONDARY to prevent
removal and hence the message.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Makefile.perf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index e04313c4d840..ab8cb17d9ec5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -787,6 +787,8 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
 	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
 	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<
 
+.SECONDARY: $(DLFILTERS:.so=.o)
+
 $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
 	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
 
-- 
2.25.1


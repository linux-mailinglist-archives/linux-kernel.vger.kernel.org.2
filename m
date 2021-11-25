Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76645D548
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353061AbhKYHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:20:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:51272 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348674AbhKYHSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:18:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="222684552"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="222684552"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 23:14:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="510184781"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by orsmga008.jf.intel.com with ESMTP; 24 Nov 2021 23:14:57 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject: Fix itrace output_data_offset
Date:   Thu, 25 Nov 2021 09:14:57 +0200
Message-Id: <20211125071457.2066863-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The space allowed for new attributes can be too small if existing header
information is large. That can happen, for example, if there are very
many CPUs, due to having an event ID per CPU per event being stored in the
header information.

Fix by adding the existing header.data_offset. Also increase the extra
space allowed to 8KiB and align to a 4KiB boundary for neatness.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index bc5259db5fd9..b9d6306cc14e 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -820,7 +820,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.ordered_events = true;
 		inject->tool.ordering_requires_timestamps = true;
 		/* Allow space in the header for new attributes */
-		output_data_offset = 4096;
+		output_data_offset = roundup(8192 + session->header.data_offset, 4096);
 		if (inject->strip)
 			strip_init(inject);
 	}
-- 
2.25.1


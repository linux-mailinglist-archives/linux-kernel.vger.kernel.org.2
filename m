Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565633E8E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbhHKKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:10:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:49822 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236906AbhHKKKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:10:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="215084184"
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="215084184"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 03:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,311,1620716400"; 
   d="scan'208";a="506890895"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2021 03:10:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/6] perf script: Fix documented const'ness of perf_dlfilter_fns
Date:   Wed, 11 Aug 2021 13:10:31 +0300
Message-Id: <20210811101036.17986-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811101036.17986-1-adrian.hunter@intel.com>
References: <20210811101036.17986-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_dlfilter_fns must not be const, because it is not. Declaring it
const can result in it being mapped read-only, causing a segfaullt when
it is written. Update documentation accordingly.

Fixes: 8defa7147d5572 ("perf script: Add API for filtering via dynamically loaded shared object")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-dlfilter.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-dlfilter.txt b/tools/perf/Documentation/perf-dlfilter.txt
index 02842cb4cf90..ece07509d1f7 100644
--- a/tools/perf/Documentation/perf-dlfilter.txt
+++ b/tools/perf/Documentation/perf-dlfilter.txt
@@ -32,7 +32,7 @@ The API for filtering consists of the following:
 ----
 #include <perf/perf_dlfilter.h>
 
-const struct perf_dlfilter_fns perf_dlfilter_fns;
+struct perf_dlfilter_fns perf_dlfilter_fns;
 
 int start(void **data, void *ctx);
 int stop(void *data, void *ctx);
@@ -214,7 +214,7 @@ Filter out everything except branches from "foo" to "bar":
 #include <perf/perf_dlfilter.h>
 #include <string.h>
 
-const struct perf_dlfilter_fns perf_dlfilter_fns;
+struct perf_dlfilter_fns perf_dlfilter_fns;
 
 int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
 {
-- 
2.17.1


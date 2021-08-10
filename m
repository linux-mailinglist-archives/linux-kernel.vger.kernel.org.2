Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1998A3E5963
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhHJLs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:48:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:64075 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236528AbhHJLsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="236894482"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="236894482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 04:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="589277345"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2021 04:47:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] perf script: Fix --list-dlfilters documentation
Date:   Tue, 10 Aug 2021 14:48:10 +0300
Message-Id: <20210810114813.12951-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810114813.12951-1-adrian.hunter@intel.com>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option --list-dlfilters does use a string value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-script.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index aa3a0b2c29a2..c80515243560 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -106,7 +106,7 @@ OPTIONS
 	Pass 'arg' as an argument to the dlfilter. --dlarg may be repeated
 	to add more arguments.
 
---list-dlfilters=::
+--list-dlfilters::
         Display a list of available dlfilters. Use with option -v (must come
         before option --list-dlfilters) to show long descriptions.
 
-- 
2.17.1


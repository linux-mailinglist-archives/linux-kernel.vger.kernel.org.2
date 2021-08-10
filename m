Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB23E5965
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbhHJLsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:48:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:64071 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240317AbhHJLsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="236894470"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="236894470"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 04:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="589277338"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga001.fm.intel.com with ESMTP; 10 Aug 2021 04:47:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf script: Fix unnecessary machine_resolve()
Date:   Tue, 10 Aug 2021 14:48:09 +0300
Message-Id: <20210810114813.12951-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810114813.12951-1-adrian.hunter@intel.com>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_resolve() may have already been called. Test for that to avoid
calling it again unnecessarily.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e2e165b53499..f469354155f1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2212,7 +2212,7 @@ static int process_sample_event(struct perf_tool *tool,
 	if (filter_cpu(sample))
 		goto out_put;
 
-	if (machine__resolve(machine, &al, sample) < 0) {
+	if (!al.thread && machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event, skipping it.\n",
 		       event->header.type);
 		ret = -1;
-- 
2.17.1


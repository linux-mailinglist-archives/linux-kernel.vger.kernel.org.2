Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03F638FE34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhEYJwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:52:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:45713 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232731AbhEYJwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:52:38 -0400
IronPort-SDR: JGGhGCmxzNCEPHFnNdsMf7YIiwLpY7hYksnjgLd05dqYr3vqvTdTH4MoB8gYnb9S3XSBoE74mq
 eVEWXl+CsoFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="266047668"
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="266047668"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 02:51:03 -0700
IronPort-SDR: 7PeSnQkY1eCLBD4OaVOc6eQ59CbzloZPStC9hzLCJGaiHOLn70gtvMBjkz8KaHjCm+/kFembu5
 7CBawvEwfZOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,328,1613462400"; 
   d="scan'208";a="479224552"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 02:51:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] perf scripting python: Add cpumode
Date:   Tue, 25 May 2021 12:51:09 +0300
Message-Id: <20210525095112.1399-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210525095112.1399-1-adrian.hunter@intel.com>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpumode to python scripting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fccd1b415ea0..cb708669e02e 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -822,6 +822,9 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	brstacksym = python_process_brstacksym(sample, al->thread);
 	pydict_set_item_string_decref(dict, "brstacksym", brstacksym);
 
+	pydict_set_item_string_decref(dict_sample, "cpumode",
+			_PyLong_FromLong((unsigned long)sample->cpumode));
+
 	if (addr_al) {
 		pydict_set_item_string_decref(dict_sample, "addr_correlates_sym",
 			PyBool_FromLong(1));
-- 
2.17.1


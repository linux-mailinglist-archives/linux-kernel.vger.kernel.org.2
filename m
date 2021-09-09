Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F37405773
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376864AbhIINfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:35:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:21871 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357247AbhIINAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:00:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="306348694"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="306348694"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 05:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="479645329"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2021 05:54:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf tools: Fix hybrid config terms list corruption
Date:   Thu,  9 Sep 2021 15:55:06 +0300
Message-Id: <20210909125508.28693-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is a fix for an issue using perf on ADL.


Adrian Hunter (2):
      perf tools: Factor out copy_config_terms() and free_config_terms()
      perf tools: Fix hybrid config terms list corruption

 tools/perf/util/evsel.c               | 20 +++++++++++++++-----
 tools/perf/util/evsel.h               |  3 +++
 tools/perf/util/parse-events-hybrid.c | 18 +++++++++++++++---
 tools/perf/util/parse-events.c        | 27 +++++++++++++--------------
 4 files changed, 46 insertions(+), 22 deletions(-)


Regards
Adrian

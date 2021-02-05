Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C6310F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhBEQPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 11:15:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:14363 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233582AbhBEQMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:12:08 -0500
IronPort-SDR: N7jfEW+dMWkT1JFcpN1tcgwmvUH4+e4eXfg3n8MEkwVgqCF0OCbDEc/jge7i8la09M8+Lag1MH
 YAlsPyPokw3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="180690057"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="180690057"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 09:53:49 -0800
IronPort-SDR: awtXQiFMksro5xt1YP1BzlFZ+/iiq3tgYTWLWosDwH9l4heEzeZFwmDt7lELFF1benIsK9k381
 ynXROxRgypZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="583856310"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga005.fm.intel.com with ESMTP; 05 Feb 2021 09:53:47 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/0] perf intel-pt: Add PSB events
Date:   Fri,  5 Feb 2021 19:53:46 +0200
Message-Id: <20210205175350.23817-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are 3 fixes and 1 minor new feature, for Intel PT.


Adrian Hunter (4):
      perf intel-pt: Fix missing CYC processing in PSB
      perf intel-pt: Fix premature IPC
      perf intel-pt: Fix IPC with CYC threshold
      perf intel-pt: Add PSB events

 tools/perf/Documentation/itrace.txt                |   2 +-
 tools/perf/Documentation/perf-intel-pt.txt         |   7 +-
 tools/perf/builtin-script.c                        |  14 ++
 tools/perf/util/event.h                            |   7 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 273 +++++++++++++++++----
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   4 +
 tools/perf/util/intel-pt.c                         |  69 +++++-
 7 files changed, 312 insertions(+), 64 deletions(-)


Regards
Adrian

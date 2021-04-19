Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2300364D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhDSVun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:50:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:61937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhDSVul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:50:41 -0400
IronPort-SDR: AX9pF4H3eBflZzXQ8ts0783o4V+ONrUT4KF+VIATYt+ku9csLrIfDC2NvKlTa0TaGb1asT9Vvu
 ljb2dX81Omgg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193279423"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="193279423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:50:10 -0700
IronPort-SDR: Zl53hd2MGnfkJUme0M+fJqV7pSihR8zXHDdCHqm14CzXQ/DlqLWgH4rxPoNuHXiaaZesvksRpA
 iO2LzpX3d+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="534277600"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2021 14:50:10 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/4] x86/bus_lock: Set rate limit for bus lock
Date:   Mon, 19 Apr 2021 21:49:54 +0000
Message-Id: <20210419214958.4035512-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bus lock warn and fatal handling is in tip. This series sets system
wide bus lock rate limit to throttle malicious code.

This series is applied on top of tip master branch.

Change Log:
-Set system wide rate limit instead of per-user rate limit (Thomas).
-Thomas suggested to split the previous bus lock into warn and fatal
patch set and this rate limit patch set:
https://lore.kernel.org/lkml/871rca6dbp.fsf@nanos.tec.linutronix.de/

Fenghua Yu (4):
  Documentation/x86: Add buslock.rst
  x86/bus_lock: Set rate limit for bus lock
  Documentation/admin-guide: Change doc for bus lock ratelimit
  Documentation/x86: Add ratelimit in buslock.rst

 .../admin-guide/kernel-parameters.txt         |   8 ++
 Documentation/x86/buslock.rst                 | 133 ++++++++++++++++++
 arch/x86/kernel/cpu/intel.c                   |  43 +++++-
 3 files changed, 182 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/x86/buslock.rst

-- 
2.31.1


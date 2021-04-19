Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA9364D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbhDSVu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:50:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:61937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232114AbhDSVum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:50:42 -0400
IronPort-SDR: vLhuW5zSehW0G+R+qX2NFLMEC9jxyb2mbS7naXyUPkbn7Edv/o8tSTjb4BVFlLEqSafbbBJDWN
 s2BO2ypx6ylg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193279427"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="193279427"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:50:11 -0700
IronPort-SDR: p1N1Eok4UyUGZ32X3h254Tzi1RlogcT6hhT3elu16h4b3z57mVzPeArEAbUmYnUHAd6aD5x///
 WbIETsfb1vPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="534277620"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga004.jf.intel.com with ESMTP; 19 Apr 2021 14:50:11 -0700
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
Subject: [PATCH 4/4] Documentation/x86: Add ratelimit in buslock.rst
Date:   Mon, 19 Apr 2021 21:49:58 +0000
Message-Id: <20210419214958.4035512-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419214958.4035512-1-fenghua.yu@intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ratelimit is a new option in bus lock handling. Need to add it in
buslock.rst.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/x86/buslock.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/x86/buslock.rst b/Documentation/x86/buslock.rst
index 4deaf8b82338..87ee5925cb5c 100644
--- a/Documentation/x86/buslock.rst
+++ b/Documentation/x86/buslock.rst
@@ -61,6 +61,11 @@ The kernel #AC and #DB handlers handle bus lock based on kernel parameter
 |		   |When both features are	|			|
 |		   |supported, fatal in #AC	|			|
 +------------------+----------------------------+-----------------------+
+|ratelimit:N	   |Do nothing			|Limit bus lock rate to	|
+|(0 < N <= 1000)   |				|N bus locks per second	|
+|		   |				|system wide and warn on|
+|		   |				|bus locks.		|
++------------------+----------------------------+-----------------------+
 
 Usages
 ======
@@ -108,3 +113,21 @@ fatal
 In this case, the bus lock is not tolerated and the process is killed.
 
 It is useful in hard real time system.
+
+ratelimit
+---------
+
+A system wide bus lock rate limit N is specified where 0 < N <= 1000.
+Less bus locks can be generated when N is smaller.
+
+This may find usage in throttling malicious processes in cloud. For
+example, a few malicious users may generate a lot of bus locks to launch
+Denial of Service (DoS) attack. By setting ratelimit, the system wide
+bus locks is rate limited by N bus locks per second and the DoS attack
+will be mitigated. The bus locks are warned so that the system
+administrator can found the malicious users and processes.
+
+Selecting a rate limit of 1000 would allow the bus to be locked for
+up to about seven million cycles each second (assuming 7000 cycles for
+each bus lock). On a 2 GHz processor that would be about 0.35% system
+impact.
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708C3364D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhDSVu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:50:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:61937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhDSVul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:50:41 -0400
IronPort-SDR: O3t0ISLvMzexHDSTisX0vAOFd8nT9iBvkw53iVivbh/ubR6PdX3xSzXZPlzK5dlEPcw6r5fX9e
 yKNGBaZOvPPw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="193279426"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="193279426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:50:11 -0700
IronPort-SDR: qQ4Ff3dbDtswGJ34r0KECI2prgBfempJBqRMw4bWpwKwdp9Xb5NVK1M6TeDB3ApdBOp9eIARY5
 PHnNsyAffLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="534277614"
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
Subject: [PATCH 3/4] Documentation/admin-guide: Change doc for bus lock ratelimit
Date:   Mon, 19 Apr 2021 21:49:57 +0000
Message-Id: <20210419214958.4035512-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419214958.4035512-1-fenghua.yu@intel.com>
References: <20210419214958.4035512-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since bus lock rate limit changes the split_lock_detect parameter,
update the documentation for the change.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5892896bedc..c13bbfd8c5aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5154,6 +5154,14 @@
 				  exception. Default behavior is by #AC if
 				  both features are enabled in hardware.
 
+			ratelimit:N -
+				  Set system wide rate limit to N bus locks
+				  per second for bus lock detection.
+				  0 < N <= 1000.
+
+				  N/A for split lock detection.
+
+
 			If an #AC exception is hit in the kernel or in
 			firmware (i.e. not while executing in user mode)
 			the kernel will oops in either "warn" or "fatal"
-- 
2.31.1


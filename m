Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2F30AFEC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhBATBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:01:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:48704 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbhBATBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:01:07 -0500
IronPort-SDR: /0VBM4DwLfCPB6gAbLxU1/w+1aAfggX7sXfgcvvTL1xbYD1cXGKQjbxy2ZUduHUpVvt3TUONee
 zh9eBd4XZn/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160502028"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="160502028"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 11:00:25 -0800
IronPort-SDR: 3t2iewEyPLBzvhYaom2xEgRe257zdR1j8NBaLn88+kz/8aOjGKxytSVkbZQP7PBlnTdP28JyON
 T0VD8aMiuOOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="412872194"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Feb 2021 11:00:25 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/split_lock: Enable the split lock feature on another Alder Lake CPU
Date:   Mon,  1 Feb 2021 19:00:07 +0000
Message-Id: <20210201190007.4031869-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alder Lake mobile processor to CPU list to enumerate and enable the
split lock feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 59a1e3ce3f14..816fdbec795a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1159,6 +1159,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
 	{}
 };
 
-- 
2.30.0


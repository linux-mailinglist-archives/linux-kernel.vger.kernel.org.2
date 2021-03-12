Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD46338EF2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 14:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhCLNhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 08:37:42 -0500
Received: from mga05.intel.com ([192.55.52.43]:26445 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhCLNhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 08:37:09 -0500
IronPort-SDR: jqgKNmJTYCCXqnWHRzMz3gE2VfmhrOcQ8me2Ac14sbGuvA3FmVPPJvSHLmRks1f5jgljw9EPn3
 Uuc+dXLwjErQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="273874660"
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="273874660"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 05:37:09 -0800
IronPort-SDR: V2atn+ntx1sM1XTuf8bpfyPFuC7//4sfqIcoIJMHrc9Xq6L6ypx2vY4+Fzu2g+23mUFPoDtCnJ
 UNzqEdZVLeDQ==
X-IronPort-AV: E=Sophos;i="5.81,243,1610438400"; 
   d="scan'208";a="411008616"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 05:37:05 -0800
Date:   Fri, 12 Mar 2021 21:41:14 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Doug Smythies <dsmythies@telus.net>, bas@basnieuwenhuizen.nl,
        Bingsong Si <owen.si@ucloud.cn>,
        youling257 <youling257@gmail.com>
Cc:     bas@basnieuwenhuizen.nl, erwanaliasr1@gmail.com, owen.si@ucloud.cn,
        youling257 <youling257@gmail.com>, lenb@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
Message-ID: <20210312134114.GA21436@chenyu-desktop>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
 <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Youling, Bas, and Bingsong,
On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
> Hi Yu,
> 
> I am just resending your e-mail, adjusting the "To:" list to
> include the 3 others that have submitted similar patches.
> 
> ... Doug
> 
Could you please help check if the following combined patch works?

Thanks,
Chenyu


From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Fri, 12 Mar 2021 21:27:40 +0800
Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs

It was reported that on Zen+ system turbostat started exiting,
which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
offset_to_idx wasn't returning a non-negative index.

This patch combined the modification from Bingsong Si and
Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
MSR_PKG_ENERGY_STATUS.

Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
Reported-by: youling257 <youling257@gmail.com>
Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index a7c4f0772e53..a7c965734fdf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -297,7 +297,10 @@ int idx_to_offset(int idx)
 
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		offset = MSR_PKG_ENERGY_STATUS;
+		if (do_rapl & RAPL_AMD_F17H)
+			offset = MSR_PKG_ENERGY_STAT;
+		else
+			offset = MSR_PKG_ENERGY_STATUS;
 		break;
 	case IDX_DRAM_ENERGY:
 		offset = MSR_DRAM_ENERGY_STATUS;
@@ -326,6 +329,7 @@ int offset_to_idx(int offset)
 
 	switch (offset) {
 	case MSR_PKG_ENERGY_STATUS:
+	case MSR_PKG_ENERGY_STAT:
 		idx = IDX_PKG_ENERGY;
 		break;
 	case MSR_DRAM_ENERGY_STATUS:
@@ -353,7 +357,7 @@ int idx_valid(int idx)
 {
 	switch (idx) {
 	case IDX_PKG_ENERGY:
-		return do_rapl & RAPL_PKG;
+		return do_rapl & (RAPL_PKG | RAPL_AMD_F17H);
 	case IDX_DRAM_ENERGY:
 		return do_rapl & RAPL_DRAM;
 	case IDX_PP0_ENERGY:
-- 
2.25.1


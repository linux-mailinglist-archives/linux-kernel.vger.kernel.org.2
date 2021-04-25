Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10736A968
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhDYVNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:13:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:43887 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhDYVNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:13:17 -0400
IronPort-SDR: ZHslSZhGNPYu64ieBCnbyHKC0haWxe7e0C73hK2UAKdWuFXIIkeSJ/Xw+Ba6oZcmrA7Ek+VMPL
 XSOHCNmWNzbg==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="257560459"
X-IronPort-AV: E=Sophos;i="5.82,250,1613462400"; 
   d="scan'208";a="257560459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:12:37 -0700
IronPort-SDR: fkz3ua720CuPcH922xWOpiVrg2n2y5hre6AFEnn+b+UPGZXRaJjQ507KCCGaL1yuNciuUA/fe/
 l8+jp9jGekug==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="429115870"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 14:12:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/resctrl: Fix init const confusion
Date:   Sun, 25 Apr 2021 14:12:29 -0700
Message-Id: <20210425211229.3157674-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <andi@firstfloor.org>

const variable must be initconst, not initdata.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Andi Kleen <andi@firstfloor.org>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7ac31210e452..4327792a22f2 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -84,7 +84,7 @@ unsigned int resctrl_cqm_threshold;
 static const struct mbm_correction_factor_table {
 	u32 rmidthreshold;
 	u64 cf;
-} mbm_cf_table[] __initdata = {
+} mbm_cf_table[] __initconst = {
 	{7,	CF(1.000000)},
 	{15,	CF(1.000000)},
 	{15,	CF(0.969650)},
-- 
2.25.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D5D3B7D45
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhF3GMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:12:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:46961 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232441AbhF3GKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:10:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195448594"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="195448594"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 23:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="455156574"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 29 Jun 2021 23:08:22 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v6 24/26] x86/insn/amx: Add TILERELEASE instruction to the opcode map
Date:   Tue, 29 Jun 2021 23:02:24 -0700
Message-Id: <20210630060226.24652-25-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210630060226.24652-1-chang.seok.bae@intel.com>
References: <20210630060226.24652-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the opcode of TILERELEASE that returns all the AMX state to
INIT-state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Added as a new patch as preparatory to use the instruction in the kernel.
---
 arch/x86/lib/x86-opcode-map.txt       | 8 +++++++-
 tools/arch/x86/lib/x86-opcode-map.txt | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..dbc5078ccafe 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -690,7 +690,9 @@ AVXcode: 2
 45: vpsrlvd/q Vx,Hx,Wx (66),(v)
 46: vpsravd Vx,Hx,Wx (66),(v) | vpsravd/q Vx,Hx,Wx (66),(evo)
 47: vpsllvd/q Vx,Hx,Wx (66),(v)
-# Skip 0x48-0x4b
+# Skip 0x48
+49: Grp22 (1A)
+# Skip 0x4a-0x4b
 4c: vrcp14ps/d Vpd,Wpd (66),(ev)
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
@@ -1082,6 +1084,10 @@ GrpTable: Grp21
 7: ENDBR64 (F3),(010),(11B) | ENDBR32 (F3),(011),(11B)
 EndTable
 
+GrpTable: Grp22
+0: TILERELEASE (!F3),(v1),(11B)
+EndTable
+
 # AMD's Prefetch Group
 GrpTable: GrpP
 0: PREFETCH
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..dbc5078ccafe 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -690,7 +690,9 @@ AVXcode: 2
 45: vpsrlvd/q Vx,Hx,Wx (66),(v)
 46: vpsravd Vx,Hx,Wx (66),(v) | vpsravd/q Vx,Hx,Wx (66),(evo)
 47: vpsllvd/q Vx,Hx,Wx (66),(v)
-# Skip 0x48-0x4b
+# Skip 0x48
+49: Grp22 (1A)
+# Skip 0x4a-0x4b
 4c: vrcp14ps/d Vpd,Wpd (66),(ev)
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
@@ -1082,6 +1084,10 @@ GrpTable: Grp21
 7: ENDBR64 (F3),(010),(11B) | ENDBR32 (F3),(011),(11B)
 EndTable
 
+GrpTable: Grp22
+0: TILERELEASE (!F3),(v1),(11B)
+EndTable
+
 # AMD's Prefetch Group
 GrpTable: GrpP
 0: PREFETCH
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA63D445C79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhKDXCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:02:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:49613 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232332AbhKDXCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:02:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="212554541"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="212554541"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 15:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="490138582"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2021 15:59:53 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, mingo@redhat.com,
        chang.seok.bae@intel.com
Subject: [PATCH 1/4] x86/insn/amx: Add TILERELEASE instruction to the opcode map
Date:   Thu,  4 Nov 2021 15:52:23 -0700
Message-Id: <20211104225226.5031-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104225226.5031-1-chang.seok.bae@intel.com>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the opcode of TILERELEASE that returns all the AMX states to
INIT-state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
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


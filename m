Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB13CF3E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhGTEnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:43:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:5620 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236349AbhGTEmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:42:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211237193"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211237193"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 22:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="496035622"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2021 22:22:54 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH V2 1/3] arm64: Add config for Thunder Bay SoC
Date:   Tue, 20 Jul 2021 10:52:47 +0530
Message-Id: <1626758569-27176-2-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
References: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>

Add ARCH_THUNDERBAY configuration option to support Intel Movidius SoC
code-named Thunder Bay

Signed-off-by: Demakkanavar, Kenchappa <kenchappa.demakkanavar@intel.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6409b47..8a043e2 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -154,6 +154,11 @@ config ARCH_KEEMBAY
 	help
 	  This enables support for Intel Movidius SoC code-named Keem Bay.
 
+config ARCH_THUNDERBAY
+	bool "Thunder Bay SoC"
+	help
+	  This enables support for Intel Movidius SoC code-named Thunder Bay.
+
 config ARCH_MEDIATEK
 	bool "MediaTek SoC Family"
 	select ARM_GIC
-- 
2.7.4


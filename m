Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5554140D2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhIPF7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:59:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:43518 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232716AbhIPF7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:59:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="209583414"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="209583414"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 22:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="471234612"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2021 22:58:23 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH v3 1/3] arm64: Add config for Thunder Bay SoC
Date:   Thu, 16 Sep 2021 11:28:16 +0530
Message-Id: <1631771898-18702-2-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com>
References: <1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>

Add ARCH_THUNDERBAY configuration option to support Intel Movidius SoC
code-named Thunder Bay

Signed-off-by: Kenchappa, Demakkanavar <kenchappa.demakkanavar@intel.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC48540D2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 07:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhIPF7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 01:59:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:43514 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhIPF7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 01:59:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="209583413"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="209583413"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 22:58:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="471234605"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2021 22:58:19 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH v3 0/3] Add initial Thunder Bay SoC / Board support
Date:   Thu, 16 Sep 2021 11:28:15 +0530
Message-Id: <1631771898-18702-1-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kenchappa, Demakkanavar" <kenchappa.demakkanavar@intel.com>

Hi,

This patch-set adds initial support for a new Intel Movidius SoC
code-named Thunder Bay. The SoC couples an ARM Cortex A53 CPU
with an Intel Movidius VPU.

This initial patch-set enables only the minimal set of components
required to make the Thunder Bay full or prime configuration boards
boot into initramfs.

Thunder Bay full configuration board has 4 clusters of 4 ARM
Cortex A53 CPUs per cluster, 4 VPU processors and
(8GB + 8GB + 4GB + 4GB) DDR memory.

Thunder Bay prime configuration board has 4 clusters of 4 ARM
Cortex A53 CPUs per cluster, 2 VPU processors and
(8GB + 4GB) DDR memory.

Changes since v2:
* Add compatibility strings for all supported boards in dt-binding yaml
* Email id format corrected. (First name, Last name)
* $nodename schema added for the root node
* Fixed 'make dtbs_check' warnings/errors
* Removed alias name for disabled serial1 node
* Corrected lowercase hex on unit-addresses

Changes since v1:
* Commit message updated for patch 3/3
* UART0 enabled by default for all Thunder Bay boards

Regards,
Kenchappa S. D.

Kenchappa, Demakkanavar (3):
  arm64: Add config for Thunder Bay SoC
  dt-bindings: arm: Add Thunder Bay bindings
  arm64: dts: add initial device tree for Thunder Bay SoC

 .../devicetree/bindings/arm/intel,thunderbay.yaml  |  27 +++
 MAINTAINERS                                        |   7 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/intel/Makefile                 |   6 +
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts    |  42 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts    |  42 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts    |  42 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts    |  42 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts       |  53 +++++
 arch/arm64/boot/dts/intel/thunderbay-soc.dtsi      | 242 +++++++++++++++++++++
 10 files changed, 508 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,thunderbay.yaml
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts
 create mode 100644 arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts
 create mode 100644 arch/arm64/boot/dts/intel/thunderbay-soc.dtsi

-- 
2.7.4


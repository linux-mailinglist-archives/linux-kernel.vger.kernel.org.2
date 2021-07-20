Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52C3CF3E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 07:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbhGTEnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:43:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:5616 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236329AbhGTEmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 00:42:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211237186"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211237186"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 22:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="496035584"
Received: from inlubt0150.iind.intel.com ([10.67.198.203])
  by orsmga001.jf.intel.com with ESMTP; 19 Jul 2021 22:22:50 -0700
From:   kenchappa.demakkanavar@intel.com
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, dinguyen@kernel.org
Cc:     furong.zhou@intel.com, kris.pan@linux.intel.com,
        kris.pan@intel.com, mgross@linux.intel.com, mark.gross@intel.com,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: [PATCH V2 0/3] Add initial Thunder Bay SoC / Board support
Date:   Tue, 20 Jul 2021 10:52:46 +0530
Message-Id: <1626758569-27176-1-git-send-email-kenchappa.demakkanavar@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>

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

Changes from v1 to v2:
* Commit message updated for patch 3/3
* UART0 enabled by default for all Thunder Bay boards

Regards,
Kenchappa S. D.

Demakkanavar, Kenchappa (2):
  arm64: Add config for Thunder Bay SoC
  arm64: dts: add initial device tree for Thunder Bay SoC

Pan, Kris (1):
  dt-bindings: arm: Add Thunder Bay bindings

 .../devicetree/bindings/arm/intel,thunderbay.yaml  |  21 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/Kconfig.platforms                       |   5 +
 arch/arm64/boot/dts/intel/Makefile                 |   6 +
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_02.dts    |  43 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_03.dts    |  43 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_12.dts    |  43 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_2s_13.dts    |  43 ++++
 arch/arm64/boot/dts/intel/hddl_hybrid_4s.dts       |  54 +++++
 arch/arm64/boot/dts/intel/thunderbay-soc.dtsi      | 243 +++++++++++++++++++++
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


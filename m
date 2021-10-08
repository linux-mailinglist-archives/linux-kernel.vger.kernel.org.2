Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C044270B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbhJHSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 14:31:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235604AbhJHSbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 14:31:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C67A1063;
        Fri,  8 Oct 2021 11:29:20 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FFFA3F766;
        Fri,  8 Oct 2021 11:29:18 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        anshuman.khandual@arm.com, coresight@lists.linaro.org,
        maz@kernel.org, james.morse@arm.com, mark.rutland@arm.com,
        lcherian@marvell.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 00/16] arm64: Self-hosted trace related errata workarounds
Date:   Fri,  8 Oct 2021 19:28:50 +0100
Message-Id: <20211008182906.1688009-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series adds CPU erratum work arounds related to the self-hosted
tracing. The list of affected errata handled in this series are :

 * TRBE may overwrite trace in FILL mode
   - Arm Neoverse-N2	#2139208
   - Cortex-A710	#211985

 * A TSB instruction may not flush the trace completely when executed
   in trace prohibited region.

   - Arm Neoverse-N2	#2067961
   - Cortex-A710	#2054223

 * TRBE may write to out-of-range address
   - Arm Neoverse-N2	#2253138
   - Cortex-A710	#2224489

The series applies on coresight/next. The series has been reordered
to make it easier to merge the patches via arm64 tree and the coresight
tree.

Patches 1-4 are could be picked up via arm64 tree. The rest can go via
the coresight tree. All Kconfig changes are at the end of the series
and could go via the coresight tree to make sure that the work arounds
are available in the final tree before they can be selected by the user.

A tree is available here :

git@git.gitlab.arm.com:linux-arm/linux-skp.git  coresight/errata/trbe-tsb-n2-a710/v3

Changes since v2:
 * https://lkml.kernel.org/r/20210921134121.2423546-1-suzuki.poulose@arm.com 
 - Dropped patch adding a helper to reach cpudata from perf handle
 - Split the TSB erratum work around patch to split the Kconfig/erratum
   list update changes(pushed to the end of the series).
 - Added wrappers to check the erratum :
    trbe_has_erratum(cpudata, TRBE_ERRATUM_<TITLE>) -> trbe_may_<title>
 - More ASCII art explanation on workaround.

Changes since v1:
 * https://lkml.kernel.org/r/20210728135217.591173-1-suzuki.poulose@arm.com
 - Added a fix to the TRBE driver handling of sink_specific data
 - Added more description and ASCII art for overwrite in FILL mode
   work around 
 - Added another TRBE erratum to the list.
  "TRBE may write to out-of-range address"
  Patches from 12-17
 - Added comment to list the expectations around TSB erratum workaround.

Suzuki K Poulose (16):

 for arm64 tree

  arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
  arm64: errata: Add detection for TRBE overwrite in FILL mode
  arm64: errata: Add workaround for TSB flush failures
  arm64: errata: Add detection for TRBE write to out-of-range

  for CoreSight tree

  coresight: trbe: Add a helper to calculate the trace generated
  coresight: trbe: Add a helper to pad a given buffer area
  coresight: trbe: Decouple buffer base from the hardware base
  coresight: trbe: Allow driver to choose a different alignment
  coresight: trbe: Add infrastructure for Errata handling
  coresight: trbe: Workaround TRBE errata overwrite in FILL mode
  coresight: trbe: Add a helper to determine the minimum buffer size
  coresight: trbe: Make sure we have enough space
  coresight: trbe: Work around write to out of range
  arm64: errata: Advertise workaround for TRBE overwrite in FILL mode
  arm64: errata: Advertise the workaround for TSB flush failures
  arm64: errata: Advertise TRBE erratum workaround for write to out-of-range address

 Documentation/arm64/silicon-errata.rst       |  12 +
 arch/arm64/Kconfig                           | 109 ++++++
 arch/arm64/include/asm/barrier.h             |  16 +-
 arch/arm64/include/asm/cputype.h             |   4 +
 arch/arm64/kernel/cpu_errata.c               |  64 ++++
 arch/arm64/tools/cpucaps                     |   3 +
 drivers/hwtracing/coresight/coresight-trbe.c | 382 +++++++++++++++++--
 7 files changed, 554 insertions(+), 36 deletions(-)

-- 
2.25.4


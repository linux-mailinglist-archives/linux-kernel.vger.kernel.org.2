Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8905E41348C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhIUNnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 09:43:02 -0400
Received: from foss.arm.com ([217.140.110.172]:33734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232953AbhIUNm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:42:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126B36D;
        Tue, 21 Sep 2021 06:41:30 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A7C53F59C;
        Tue, 21 Sep 2021 06:41:28 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, mathieu.poirier@linaro.org, will@kernel.org,
        lcherian@marvell.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 00/17] arm64: Self-hosted trace related errata workarounds
Date:   Tue, 21 Sep 2021 14:41:04 +0100
Message-Id: <20210921134121.2423546-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
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

The series applies on the self-hosted/trbe fixes posted here [0].
A tree containing both the series is available here [1]

 [0] https://lkml.kernel.org/r/20210914102641.1852544-1-suzuki.poulose@arm.com
 [1] git@git.gitlab.arm.com:linux-arm/linux-skp.git coresight/errata/trbe-tsb-n2-a710/v2

Changes since v1:
 https://lkml.kernel.org/r/20210728135217.591173-1-suzuki.poulose@arm.com
 - Added a fix to the TRBE driver handling of sink_specific data
 - Added more description and ASCII art for overwrite in FILL mode
   work around 
 - Added another TRBE erratum to the list.
  "TRBE may write to out-of-range address"
  Patches from 12-17
 - Added comment to list the expectations around TSB erratum workaround.


Suzuki K Poulose (17):
  coresight: trbe: Fix incorrect access of the sink specific data
  coresight: trbe: Add infrastructure for Errata handling
  coresight: trbe: Add a helper to calculate the trace generated
  coresight: trbe: Add a helper to pad a given buffer area
  coresight: trbe: Decouple buffer base from the hardware base
  coresight: trbe: Allow driver to choose a different alignment
  arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
  arm64: Add erratum detection for TRBE overwrite in FILL mode
  coresight: trbe: Workaround TRBE errata overwrite in FILL mode
  arm64: Enable workaround for TRBE overwrite in FILL mode
  arm64: errata: Add workaround for TSB flush failures
  coresight: trbe: Add a helper to fetch cpudata from perf handle
  coresight: trbe: Add a helper to determine the minimum buffer size
  coresight: trbe: Make sure we have enough space
  arm64: Add erratum detection for TRBE write to out-of-range
  coresight: trbe: Work around write to out of range
  arm64: Advertise TRBE erratum workaround for write to out-of-range address

 Documentation/arm64/silicon-errata.rst       |  12 +
 arch/arm64/Kconfig                           | 109 ++++++
 arch/arm64/include/asm/barrier.h             |  16 +-
 arch/arm64/include/asm/cputype.h             |   4 +
 arch/arm64/kernel/cpu_errata.c               |  64 ++++
 arch/arm64/tools/cpucaps                     |   3 +
 drivers/hwtracing/coresight/coresight-trbe.c | 339 +++++++++++++++++--
 7 files changed, 510 insertions(+), 37 deletions(-)

-- 
2.24.1


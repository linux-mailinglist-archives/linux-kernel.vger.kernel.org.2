Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA63D8FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhG1Nxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:53:47 -0400
Received: from foss.arm.com ([217.140.110.172]:56864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236973AbhG1Nwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:52:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E2E91042;
        Wed, 28 Jul 2021 06:52:46 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECE023F70D;
        Wed, 28 Jul 2021 06:52:44 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 00/10] arm64: Self-hosted trace related erratum workarouds
Date:   Wed, 28 Jul 2021 14:52:07 +0100
Message-Id: <20210728135217.591173-1-suzuki.poulose@arm.com>
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
   - Cortex-A710	#2119858

 * A TSB instruction may not flush the trace completely when executed
   in trace prohibited region.

   - Arm Neoverse-N2	#2067961
   - Cortex-A710	#2054223

The series applies on the self-hosted/trbe fixes posted here [0].
A tree containing both the series is available here [1].

 [0] https://lkml.kernel.org/r/20210723124456.3828769-1-suzuki.poulose@arm.com
 [1] git@git.gitlab.arm.com:linux-arm/linux-skp.git coresight/errata/trbe-tsb-n2-a710/v1


Suzuki K Poulose (10):
  coresight: trbe: Add infrastructure for Errata handling
  coresight: trbe: Add a helper to calculate the trace generated
  coresight: trbe: Add a helper to pad a given buffer area
  coresight: trbe: Decouple buffer base from the hardware base
  coresight: trbe: Allow driver to choose a different alignment
  arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
  arm64: Add erratum detection for TRBE overwrite in FILL mode
  coresight: trbe: Workaround TRBE errat overwrite in FILL mode
  arm64: Enable workaround for TRBE overwrite in FILL mode
  arm64: errata: Add workaround for TSB flush failures

 Documentation/arm64/silicon-errata.rst       |   8 +
 arch/arm64/Kconfig                           |  70 ++++++
 arch/arm64/include/asm/barrier.h             |  17 +-
 arch/arm64/include/asm/cputype.h             |   4 +
 arch/arm64/kernel/cpu_errata.c               |  44 ++++
 arch/arm64/tools/cpucaps                     |   2 +
 drivers/hwtracing/coresight/coresight-trbe.c | 227 ++++++++++++++++---
 7 files changed, 341 insertions(+), 31 deletions(-)

-- 
2.24.1


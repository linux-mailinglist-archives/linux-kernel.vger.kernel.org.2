Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A23354575
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhDEQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:43:34 -0400
Received: from foss.arm.com ([217.140.110.172]:55858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhDEQnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36F831B;
        Mon,  5 Apr 2021 09:43:25 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 079D93F694;
        Mon,  5 Apr 2021 09:43:23 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     maz@kernel.org, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, leo.yan@linaro.org, robh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v6 00/20] coresight: Add support for ETE and TRBE
Date:   Mon,  5 Apr 2021 17:42:47 +0100
Message-Id: <20210405164307.1720226-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables future IP trace features Embedded Trace Extension
(ETE) and Trace Buffer Extension (TRBE). This series applies on
kvmarm/fixes tree. A standalone tree is also available here [0].
The queued patches (almost there) are included in this posting for
the sake of constructing a tree from the posting.

ETE is the PE (CPU) trace unit for CPUs, implementing future
architecture extensions. ETE overlaps with the ETMv4 architecture, with
additions to support the newer architecture features and some restrictions
on the supported features w.r.t ETMv4. The ETE support is added by extending
the ETMv4 driver to recognise the ETE and handle the features as exposed by
the TRCIDRx registers. ETE only supports system instructions access from the
host CPU. The ETE could be integrated with a TRBE (see below), or with
the legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same
firmware description as the ETMs and requires a node per instance. 

Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which
is accessible via the system registers and can be combined with the ETE to
provide a 1x1 configuration of source & sink. TRBE is being represented
here as a CoreSight sink. Primary reason is that the ETE source could
work with other traditional CoreSight sink devices. As TRBE captures the
trace data which is produced by ETE, it cannot work alone.

TRBE representation here have some distinct deviations from a
traditional CoreSight sink device. Coresight path between ETE and TRBE are
not built during boot looking at respective DT or ACPI entries.

Unlike traditional sinks, TRBE can generate interrupts to signal
including many other things, buffer got filled. The interrupt is a PPI and
should be communicated from the platform. DT or ACPI entry representing TRBE
should have the PPI number for a given platform. During perf session, the
TRBE IRQ handler should capture trace for perf auxiliary buffer before restarting
it back. System registers being used here to configure ETE and TRBE could
be referred in the link below.

https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.

[0] https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/ete/v6/

Changes since v6:
 - Rebased to kvmarm/fixes tree (which has some patches queued that this
   series depends on)
 - Fixed a sparse warning in TRBE driver Reported-by: kernel test robot
   <lkp@intel.com>
 - Add explicit undef handler for TRFCR_EL1 (Marc Zyngier)
 - Check for the SPE support early, kvm_arch_vcpu_load(), instead of
   every single time in guest_enter() (Patch 06)

Changes since V4:

https://lkml.kernel.org/r/20210225193543.2920532-1-suzuki.poulose@arm.com

 - Split the documentation patches from the TRBE driver
 - Drop the patches already queued for v5.12.
 - Mark the buffer TRUNCATED in case of a WRAP event
 - Fix error code for vmap failure
 - Fix build break on arm32 for per-cpu sink patch
 - Address comments on ETE dts bindings.
 - Make ete_sysreg_read/write static (kernel test robot)
 - Merged ete sysreg definition patch with ete support, to avoid
   a "defined but unused warning" on build in part of the series.
 - Add new bindings to MAINTAINERS 
 
Changes since V3:

https://lore.kernel.org/linux-arm-kernel/1611737738-1493-1-git-send-email-anshuman.khandual@arm.com/

 - ETE and TRBE changes have been captured in the respective patches
 - Better support for nVHE
 - Re-ordered and splitted the patches to keep the changes separate
   for the generic/arm64 tree from CoreSight driver specific changes.
 - Fixes for KVM handling of Trace/SPE


Changes since V2:

https://lore.kernel.org/linux-arm-kernel/1610511498-4058-1-git-send-email-anshuman.khandual@arm.com/

- Rebased on coresight/next
- Changed DT bindings for ETE
- Included additional patches for arm64 nvhe, perf aux buffer flags etc
- TRBE changes have been captured in the respective patches

Changes since V1:

https://lore.kernel.org/linux-arm-kernel/1608717823-18387-1-git-send-email-anshuman.khandual@arm.com/

- Converted both ETE and TRBE DT bindings into Yaml
- TRBE changes have been captured in the respective patches
 
Changes since RFC:


- There are not much ETE changes from Suzuki apart from splitting of the
  ETE DTS patch
- TRBE changes have been captured in the respective patches

RFC:

https://lore.kernel.org/linux-arm-kernel/1605012309-24812-1-git-send-email-anshuman.khandual@arm.com/

Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Linu Cherian <lcherian@marvell.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org



Anshuman Khandual (5):
  arm64: Add TRBE definitions
  coresight: core: Add support for dedicated percpu sinks
  coresight: sink: Add TRBE driver
  Documentation: coresight: trbe: Sysfs ABI description
  Documentation: trace: Add documentation for TRBE

Suzuki K Poulose (15):
  perf: aux: Add flags for the buffer format
  perf: aux: Add CoreSight PMU buffer formats
  arm64: Add support for trace synchronization barrier
  kvm: arm64: Handle access to TRFCR_EL1
  kvm: arm64: Move SPE availability check to VCPU load
  arm64: kvm: Enable access to TRBE support for host
  coresight: etm4x: Move ETM to prohibited region for disable
  coresight: etm-perf: Allow an event to use different sinks
  coresight: Do not scan for graph if none is present
  coresight: etm4x: Add support for PE OS lock
  coresight: ete: Add support for ETE sysreg access
  coresight: ete: Add support for ETE tracing
  dts: bindings: Document device tree bindings for ETE
  coresight: etm-perf: Handle stale output handles
  dts: bindings: Document device tree bindings for Arm TRBE

 .../testing/sysfs-bus-coresight-devices-trbe  |   14 +
 .../devicetree/bindings/arm/ete.yaml          |   75 ++
 .../devicetree/bindings/arm/trbe.yaml         |   49 +
 .../trace/coresight/coresight-trbe.rst        |   38 +
 MAINTAINERS                                   |    2 +
 arch/arm64/include/asm/barrier.h              |    1 +
 arch/arm64/include/asm/el2_setup.h            |   13 +
 arch/arm64/include/asm/kvm_arm.h              |    2 +
 arch/arm64/include/asm/kvm_host.h             |    8 +
 arch/arm64/include/asm/sysreg.h               |   50 +
 arch/arm64/kernel/hyp-stub.S                  |    3 +-
 arch/arm64/kvm/arm.c                          |    2 +
 arch/arm64/kvm/debug.c                        |   36 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c            |   56 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |    1 +
 arch/arm64/kvm/sys_regs.c                     |    1 +
 drivers/hwtracing/coresight/Kconfig           |   24 +-
 drivers/hwtracing/coresight/Makefile          |    1 +
 drivers/hwtracing/coresight/coresight-core.c  |   29 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |  119 +-
 .../coresight/coresight-etm4x-core.c          |  161 ++-
 .../coresight/coresight-etm4x-sysfs.c         |   19 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   83 +-
 .../hwtracing/coresight/coresight-platform.c  |    6 +
 drivers/hwtracing/coresight/coresight-priv.h  |    3 +
 drivers/hwtracing/coresight/coresight-trbe.c  | 1157 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h  |  152 +++
 include/linux/coresight.h                     |   13 +
 include/uapi/linux/perf_event.h               |   13 +-
 29 files changed, 2054 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
 create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h

-- 
2.24.1


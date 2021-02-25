Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565633256D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhBYTjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:39:39 -0500
Received: from foss.arm.com ([217.140.110.172]:48146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhBYTgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:36:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A4E71063;
        Thu, 25 Feb 2021 11:35:58 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 966C53F70D;
        Thu, 25 Feb 2021 11:35:56 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Linu Cherian <lcherian@marvell.com>, coresight@lists.linaro.org
Subject: [PATCH v4 00/19] arm64: coresight: Add support for ETE and TRBE
Date:   Thu, 25 Feb 2021 19:35:24 +0000
Message-Id: <20210225193543.2920532-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series enables future IP trace features Embedded Trace Extension (ETE)
and Trace Buffer Extension (TRBE). This series applies on linux-next/master
(from tag next-20210222), and is also available here [0].

Patches 1 & 2:  UABI updates for perf AUX flag format. We reserve
a byte for advertising the format of the buffer when the PMU could
support different formats. The CoreSight PMUs could use Frame formatted
data and Raw format of the trace source.

Patches 3 - 5: Fixes for arm64 KVM hypervisor to align with the architecture.
Patches 6 - 7: Adds the arrchitecture defintions for trace and TRBE
Patch 8	     : Adds the necessary changes for enabling TRBE access to host
from the early initialisation (VHE and nVHE). Also support for nVHE hyp
to save/restore the TRBE context of the host during a trip to the guest. 

Patches 9 - 19: CoreSight driver specific changes and DT bindings for 
ETE and TRBE support


ETE is the PE (CPU) trace unit for CPUs, implementing future architecture
extensions. ETE overlaps with the ETMv4 architecture, with additions to
support the newer architecture features and some restrictions on the
supported features w.r.t ETMv4. The ETE support is added by extending the
ETMv4 driver to recognise the ETE and handle the features as exposed by the
TRCIDRx registers. ETE only supports system instructions access from the
host CPU. The ETE could be integrated with a TRBE (see below), or with the
legacy CoreSight trace bus (e.g, ETRs). Thus the ETE follows same firmware
description as the ETMs and requires a node per instance. 

Trace Buffer Extensions (TRBE) implements a per CPU trace buffer, which is
accessible via the system registers and can be combined with the ETE to
provide a 1x1 configuration of source & sink. TRBE is being represented
here as a CoreSight sink. Primary reason is that the ETE source could work
with other traditional CoreSight sink devices. As TRBE captures the trace
data which is produced by ETE, it cannot work alone.

TRBE representation here have some distinct deviations from a traditional
CoreSight sink device. Coresight path between ETE and TRBE are not built
during boot looking at respective DT or ACPI entries.

Unlike traditional sinks, TRBE can generate interrupts to signal including
many other things, buffer got filled. The interrupt is a PPI and should be
communicated from the platform. DT or ACPI entry representing TRBE should
have the PPI number for a given platform. During perf session, the TRBE IRQ
handler should capture trace for perf auxiliary buffer before restarting it
back. System registers being used here to configure ETE and TRBE could be
referred in the link below.

https://developer.arm.com/docs/ddi0601/g/aarch64-system-registers.

[0] https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/ete/v4/next

Changes in V4:

 - ETE and TRBE changes have been captured in the respective patches
 - Better support for nVHE
 - Re-ordered and splitted the patches to keep the changes separate
   for the generic/arm64 tree from CoreSight driver specific changes.
 - Fixes for KVM handling of Trace/SPE


Changes in V3:

https://lore.kernel.org/linux-arm-kernel/1611737738-1493-1-git-send-email-anshuman.khandual@arm.com/

- Rebased on coresight/next
- Changed DT bindings for ETE
- Included additional patches for arm64 nvhe, perf aux buffer flags etc
- TRBE changes have been captured in the respective patches

Changes in V2:

https://lore.kernel.org/linux-arm-kernel/1610511498-4058-1-git-send-email-anshuman.khandual@arm.com/

- Converted both ETE and TRBE DT bindings into Yaml
- TRBE changes have been captured in the respective patches
 
Changes in V1:

https://lore.kernel.org/linux-arm-kernel/1608717823-18387-1-git-send-email-anshuman.khandual@arm.com/

- There are not much ETE changes from Suzuki apart from splitting of the ETE DTS patch
- TRBE changes have been captured in the respective patches

Changes in RFC:

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


Anshuman Khandual (3):
  arm64: Add TRBE definitions
  coresight: core: Add support for dedicated percpu sinks
  coresight: sink: Add TRBE driver

Suzuki K Poulose (16):
  perf: aux: Add flags for the buffer format
  perf: aux: Add CoreSight PMU buffer formats
  kvm: arm64: Hide system instruction access to Trace registers
  kvm: arm64: nvhe: Save the SPE context early
  kvm: arm64: Disable guest access to trace filter controls
  arm64: Add support for trace synchronization barrier
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
 .../devicetree/bindings/arm/ete.yaml          |   71 +
 .../devicetree/bindings/arm/trbe.yaml         |   49 +
 .../trace/coresight/coresight-trbe.rst        |   38 +
 arch/arm64/include/asm/barrier.h              |    1 +
 arch/arm64/include/asm/el2_setup.h            |   13 +
 arch/arm64/include/asm/kvm_arm.h              |    3 +
 arch/arm64/include/asm/kvm_host.h             |    2 +
 arch/arm64/include/asm/kvm_hyp.h              |    5 +
 arch/arm64/include/asm/sysreg.h               |   50 +
 arch/arm64/kernel/cpufeature.c                |    1 -
 arch/arm64/kernel/hyp-stub.S                  |    3 +-
 arch/arm64/kvm/debug.c                        |    6 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c            |   54 +-
 arch/arm64/kvm/hyp/nvhe/switch.c              |   13 +-
 drivers/hwtracing/coresight/Kconfig           |   24 +-
 drivers/hwtracing/coresight/Makefile          |    1 +
 drivers/hwtracing/coresight/coresight-core.c  |   29 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |  119 +-
 .../coresight/coresight-etm4x-core.c          |  161 ++-
 .../coresight/coresight-etm4x-sysfs.c         |   19 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   83 +-
 .../hwtracing/coresight/coresight-platform.c  |    6 +
 drivers/hwtracing/coresight/coresight-priv.h  |    3 +
 drivers/hwtracing/coresight/coresight-trbe.c  | 1149 +++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h  |  153 +++
 include/linux/coresight.h                     |   12 +
 include/uapi/linux/perf_event.h               |   13 +-
 28 files changed, 2028 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-trbe
 create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h

-- 
2.24.1


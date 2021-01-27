Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E210C305659
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhA0JAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:00:30 -0500
Received: from foss.arm.com ([217.140.110.172]:60890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhA0I4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:56:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B9031B;
        Wed, 27 Jan 2021 00:55:23 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.91.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF4213F66B;
        Wed, 27 Jan 2021 00:55:20 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V3 00/14] arm64: coresight: Enable ETE and TRBE
Date:   Wed, 27 Jan 2021 14:25:24 +0530
Message-Id: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables future IP trace features Embedded Trace Extension (ETE)
and Trace Buffer Extension (TRBE). This series depends on the ETM system
register instruction support series [0] which is available here [1]. This
series which applies on [1] is avaialble here [2] for quick access.

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

Question:

- Should we implement sysfs based trace sessions for TRBE ?

[0] https://lore.kernel.org/linux-arm-kernel/20210110224850.1880240-1-suzuki.poulose@arm.com/
[1] https://gitlab.arm.com/linux-arm/linux-skp/-/tree/coresight/etm/sysreg-v7
[2] https://gitlab.arm.com/linux-arm/linux-anshuman/-/tree/coresight/ete_trbe_v3

Changes in V3:

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

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Linu Cherian <lcherian@marvell.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  coresight: core: Add support for dedicated percpu sinks
  arm64: Add TRBE definitions
  coresight: sink: Add TRBE driver

Suzuki K Poulose (11):
  coresight: etm-perf: Allow an event to use different sinks
  coresight: Do not scan for graph if none is present
  coresight: etm4x: Add support for PE OS lock
  coresight: ete: Add support for ETE sysreg access
  coresight: ete: Add support for ETE tracing
  dts: bindings: Document device tree bindings for ETE
  coresight: etm-perf: Handle stale output handles
  arm64: nvhe: Allow TRBE access at EL1
  dts: bindings: Document device tree bindings for Arm TRBE
  perf: aux: Add flags for the buffer format
  coresight: etm-perf: Add support for trace buffer format

 Documentation/devicetree/bindings/arm/ete.yaml     |   74 ++
 Documentation/devicetree/bindings/arm/trbe.yaml    |   49 +
 Documentation/trace/coresight/coresight-trbe.rst   |   39 +
 arch/arm64/include/asm/el2_setup.h                 |   19 +
 arch/arm64/include/asm/kvm_arm.h                   |    2 +
 arch/arm64/include/asm/sysreg.h                    |   51 +
 drivers/hwtracing/coresight/Kconfig                |   21 +-
 drivers/hwtracing/coresight/Makefile               |    1 +
 drivers/hwtracing/coresight/coresight-core.c       |   16 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |   93 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  138 ++-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   19 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   81 +-
 drivers/hwtracing/coresight/coresight-platform.c   |    6 +
 drivers/hwtracing/coresight/coresight-trbe.c       | 1025 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h       |  160 +++
 include/linux/coresight.h                          |   12 +
 include/uapi/linux/perf_event.h                    |   13 +-
 18 files changed, 1759 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h

-- 
2.7.4


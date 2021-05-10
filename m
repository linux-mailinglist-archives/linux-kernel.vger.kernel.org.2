Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294873793D1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhEJQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:32:25 -0400
Received: from foss.arm.com ([217.140.110.172]:33978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhEJQcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:32:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25F3A168F;
        Mon, 10 May 2021 09:31:15 -0700 (PDT)
Received: from e113131-lin.cambridge.arm.com (e113131-lin.cambridge.arm.com [10.1.195.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C81A13F73B;
        Mon, 10 May 2021 09:31:13 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, corbet@lwn.net, rdunlap@infradead.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 0/3] Rework CPU capacity asymmetry detection
Date:   Mon, 10 May 2021 17:30:55 +0100
Message-Id: <1620664258-11045-1-git-send-email-beata.michalska@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of now, the asym_cpu_capacity_level will try to locate the lowest
topology level where the highest available CPU capacity is being
visible to all CPUs. This works perfectly fine for most of existing
asymmetric designs out there, though for some possible and completely
valid setups, combining different cpu microarchitectures within
clusters, this might not be the best approach, resulting in pointing
at a level, at which some of the domains might not see any asymmetry
at all. This could be problematic for misfit migration and/or energy
aware placement. And as such, for affected platforms it might result
in custom changes to wake-up and CPU selection paths.

As mentioned in the previous version, based on the available sources out there,
one of the potentially affected (by original approach) platforms might be
Exynos 9820/990 with it's 'sliced' LLC(SLC) divided between the two custom (big)
cores and the remaining A75/A55 cores, which seems to be reflected in the
made available dt entries for those platforms.

The following patches rework how the asymmetric detection is being
carried out, pinning the asymmetric topology level to the lowest one,
where full range of CPU capacities is visible to all CPUs within given
sched domain. The asym_cpu_capacity_level will also keep track of those
levels where any scope of asymmetry is being observed, to denote
corresponding sched domains with the SD_ASYM_CPUCAPACITY flag
and to enable misfit migration for those.

In order to distinguish the sched domains with partial vs full range
of CPU capacity asymmetry, new sched domain flag has been introduced:
SD_ASYM_CPUCAPACITY_FULL.

The overall idea of changing the asymmetry detection has been suggested
earlier by Valentin Schneider <valentin.schneider@arm.com>

Verified on (mostly):
    - QEMU (version 4.2.1) with variants of possible asymmetric topologies
	- machine: virt
	- modifying the device-tree 'cpus' node for virt machine:

	qemu-system-aarch64 -kernel $KERNEL_IMG
	    -drive format=qcow2,file=$IMAGE
	    -append 'root=/dev/vda earlycon console=ttyAMA0 sched_debug
	     loglevel=15 kmemleak=on' -m 2G  --nographic  -cpu cortex-a57
	    -machine virt -smp cores=6 -machine dumpdtb=$CUSTOM_DTB.dtb

	$KERNEL_PATH/scripts/dtc/dtc -I dtb -O dts $CUSTOM_DTB.dts >
	$CUSTOM_DTB.dtb

	(modify the dts)

	$KERNEL_PATH/scripts/dtc/dtc -I dts -O dtb $CUSTOM_DTB.dts >
	$CUSTOM_DTB.dtb

	qemu-system-aarch64 -kernel $KERNEL_IMG
	    -drive format=qcow2,file=$IMAGE
	    -append 'root=/dev/vda earlycon console=ttyAMA0 sched_debug
	     loglevel=15 kmemleak=on' -m 2G  --nographic  -cpu cortex-a57
	    -machine virt -smp cores=6 -machine dtb=$CUSTOM_DTB.dtb


v3:
 - Additional style/doc fixes
v2:
 - Fixed style issues
 - Reworked accessing the cached topology data as suggested by Valentin

Beata Michalska (3):
  sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL sched_domain flag
  sched/topology: Rework CPU capacity asymmetry detection
  sched/doc: Update the CPU capacity asymmetry bits

 Documentation/scheduler/sched-capacity.rst |   6 +-
 Documentation/scheduler/sched-energy.rst   |   2 +-
 include/linux/sched/sd_flags.h             |  10 +
 kernel/sched/topology.c                    | 326 +++++++++++++++++++++++++----
 4 files changed, 299 insertions(+), 45 deletions(-)

-- 
2.7.4


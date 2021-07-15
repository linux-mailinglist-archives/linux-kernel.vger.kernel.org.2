Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9E33CA468
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhGORdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:33:47 -0400
Received: from foss.arm.com ([217.140.110.172]:55852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhGORdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:33:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B1A6D;
        Thu, 15 Jul 2021 10:30:53 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E25B3F7D8;
        Thu, 15 Jul 2021 10:30:51 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
Subject: [PATCH v6 00/24] x86/resctrl: Merge the CDP resources
Date:   Thu, 15 Jul 2021 17:30:19 +0000
Message-Id: <20210715173043.14222-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Changes since v5? Nothing: just picked up the tags, (rebased and retested).
---

This series re-folds the resctrl code so the CDP resources (L3CODE et al)
behaviour is all contained in the filesystem parts, with a minimum amount
of arch specific code.

Arm have some CPU support for dividing caches into portions, and
applying bandwidth limits at various points in the SoC. The collective term
for these features is MPAM: Memory Partitioning and Monitoring.

MPAM is similar enough to Intel RDT, that it should use the defacto linux
interface: resctrl. This filesystem currently lives under arch/x86, and is
tightly coupled to the architecture.
Ultimately, my plan is to split the existing resctrl code up to have an
arch<->fs abstraction, then move all the bits out to fs/resctrl. From there
MPAM can be wired up.

x86 might have two resources with cache controls, (L2 and L3) but has
extra copies for CDP: L{2,3}{CODE,DATA}, which are marked as enabled
if CDP is enabled for the corresponding cache.

MPAM has an equivalent feature to CDP, but its a property of the CPU,
not the cache. Resctrl needs to have x86's odd/even behaviour, as that
its the ABI, but this isn't how the MPAM hardware works. It is entirely
possible that an in-kernel user of MPAM would not be using CDP, whereas
resctrl is.

Pretending L3CODE and L3DATA are entirely separate resources is a neat
trick, but doing this is specific to x86.
Doing this leaves the arch code in control of various parts of the
filesystem ABI: the resources names, and the way the schemata are parsed.
Allowing this stuff to vary between architectures is bad for user space.

This series collapses the CODE/DATA resources, moving all the user-visible
resctrl ABI into what becomes the filesystem code. CDP becomes the type of
configuration being applied to a cache. This is done by adding a
struct resctrl_schema to the parts of resctrl that will move to fs. This
holds the arch-code resource that is in use for this schema, along with
other properties like the name, and whether the configuration being applied
is CODE/DATA/BOTH.

This lets us fold the extra resources out of the arch code so that they
don't need to be duplicated if the equivalent feature to CDP is missing, or
implemented in a different way.


The first two patches split the resource and domain structs to have an
arch specific 'hw' portion, and the rest that is visible to resctrl.
Future series massage the resctrl code so there are no accesses to 'hw'
structures in the parts of resctrl that will move to fs, providing helpers
where necessary.

This series adds temporary scaffolding, which it removes a few patches
later. This is to allow things like the ctrlval arrays and resources to be
merged separately, which should make is easier to bisect. These things
are marked temporary, and should all be gone by the end of the series.

This series is a little rough around the monitors, would a fake
struct resctrl_schema for the monitors simplify things, or be a source
of bugs?

A side effect of merging these resources, is their names are no longer printed
in the kernel log at boot. e.g:
| resctrl: L3 allocation detected
| resctrl: MB allocation detected
| resctrl: L3 monitoring detected
would previously have had extra entries for 'L3CODE' and 'L3DATA'.
User-space cannot rely on this to discover CDP support, as the kernel log may
be inaccessible, may have been overwritten by newer messages, and because
parsing the kernel log is a bad idea.


This series is based on v5.14-rc1, and can be retrieved from:
git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v6

v5: https://lore.kernel.org/lkml/20210617175820.24037-1-james.morse@arm.com/
v4: https://lore.kernel.org/lkml/20210614200941.12383-1-james.morse@arm.com/
v3: https://lore.kernel.org/lkml/20210519162424.27654-1-james.morse@arm.com/
v2: https://lore.kernel.org/lkml/20210312175849.8327-1-james.morse@arm.com/
v1: https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

Parts were previously posted as an RFC here:
https://lore.kernel.org/lkml/20200214182947.39194-1-james.morse@arm.com/


Thanks,

James Morse (24):
  x86/resctrl: Split struct rdt_resource
  x86/resctrl: Split struct rdt_domain
  x86/resctrl: Add a separate schema list for resctrl
  x86/resctrl: Pass the schema in info dir's private pointer
  x86/resctrl: Label the resources with their configuration type
  x86/resctrl: Walk the resctrl schema list instead of an arch list
  x86/resctrl: Store the effective num_closid in the schema
  x86/resctrl: Add resctrl_arch_get_num_closid()
  x86/resctrl: Pass the schema to resctrl filesystem functions
  x86/resctrl: Swizzle rdt_resource and resctrl_schema in
    pseudo_lock_region
  x86/resctrl: Add a helper to read/set the CDP configuration
  x86/resctrl: Move the schemata names into struct resctrl_schema
  x86/resctrl: Group staged configuration into a separate struct
  x86/resctrl: Allow different CODE/DATA configurations to be staged
  x86/resctrl: Rename update_domains() resctrl_arch_update_domains()
  x86/resctrl: Add a helper to read a closid's configuration
  x86/resctrl: Pass configuration type to resctrl_arch_get_config()
  x86/resctrl: Make ctrlval arrays the same size
  x86/resctrl: Apply offset correction when config is staged
  x86/resctrl: Calculate the index from the configuration type
  x86/resctrl: Merge the ctrl_val arrays
  x86/resctrl: Remove rdt_cdp_peer_get()
  x86/resctrl: Expand resctrl_arch_update_domains()'s msr_param range
  x86/resctrl: Merge the CDP resources

 arch/x86/kernel/cpu/resctrl/core.c        | 276 ++++++-------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 164 +++++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 232 ++++-------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  44 ++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  12 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 459 ++++++++++++----------
 include/linux/resctrl.h                   | 185 +++++++++
 7 files changed, 776 insertions(+), 596 deletions(-)

-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8541F1B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355203AbhJAQFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:05:08 -0400
Received: from foss.arm.com ([217.140.110.172]:46324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354671AbhJAQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:05:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24181101E;
        Fri,  1 Oct 2021 09:03:23 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2724C3F766;
        Fri,  1 Oct 2021 09:03:21 -0700 (PDT)
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
Subject: [PATCH v2 00/23] x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes
Date:   Fri,  1 Oct 2021 16:02:39 +0000
Message-Id: <20211001160302.31189-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Patches 1&2 have been posted independently in case they are wanted as fixes.

The major change in this version is when the mba_mbps[] array is allocated.

---
The aim of this series is to insert a split between the parts of the monitor
code that the architecture must implement, and those that are part of the
resctrl filesystem. The eventual aim is to move all filesystem parts out
to live in /fs/resctrl, so that resctrl can be wired up for MPAM.

What's MPAM? See the cover letter of a previous series. [1]

The series adds domain online/offline callbacks to allow the filesystem to
manage some of its structures itself, then moves all the 'mba_sc' behaviour
to be part of the filesystem.
This means another architecture doesn't need to provide an mbps_val array.
As its all software, the resctrl filesystem should be able to do this without
any help from the architecture code.

Finally __rmid_read() is refactored to be the API call that the architecture
provides to read a counter value. All the hardware specific overflow detection,
scaling and value correction should occur behind this helper.


This series is based on v5.15-rc3, and can be retrieved from:
git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_monitors_in_bytes/v2

[0] git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v7
[1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/

[v1] https://lore.kernel.org/lkml/20210729223610.29373-1-james.morse@arm.com/


Thanks,

James Morse (23):
  x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state()
    fails
  x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()
  x86/resctrl: Kill off alloc_enabled
  x86/resctrl: Merge mon_capable and mon_enabled
  x86/resctrl: Add domain online callback for resctrl work
  x86/resctrl: Group struct rdt_hw_domain cleanup
  x86/resctrl: Add domain offline callback for resctrl work
  x86/resctrl: Create mba_sc configuration in the rdt_domain
  x86/resctrl: Switch over to the resctrl mbps_val list
  x86/resctrl: Remove architecture copy of mbps_val
  x86/resctrl: Remove set_mba_sc()s control array re-initialisation
  x86/resctrl: Abstract and use supports_mba_mbps()
  x86/resctrl: Allow update_mba_bw() to update controls directly
  x86/resctrl: Calculate bandwidth from the previous __mon_event_count()
    chunks
  x86/recstrl: Add per-rmid arch private storage for overflow and chunks
  x86/recstrl: Allow per-rmid arch private storage to be reset
  x86/resctrl: Abstract __rmid_read()
  x86/resctrl: Pass the required parameters into
    resctrl_arch_rmid_read()
  x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()
  x86/resctrl: Move get_corrected_mbm_count() into
    resctrl_arch_rmid_read()
  x86/resctrl: Rename and change the units of resctrl_cqm_threshold
  x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's
    boot_cpu_data
  x86/resctrl: Make resctrl_arch_rmid_read() return values in bytes

 arch/x86/kernel/cpu/resctrl/core.c        | 116 ++++--------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  75 +++++---
 arch/x86/kernel/cpu/resctrl/internal.h    |  62 +++----
 arch/x86/kernel/cpu/resctrl/monitor.c     | 200 ++++++++++++--------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 217 ++++++++++++++++++----
 include/linux/resctrl.h                   |  60 +++++-
 7 files changed, 480 insertions(+), 252 deletions(-)

-- 
2.30.2


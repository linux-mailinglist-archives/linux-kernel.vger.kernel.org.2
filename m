Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307E0357B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhDHEFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHEFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:05:50 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB88AC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id f12so471923qtf.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5B73UfQ5a6IB10mvo49iMJhVZaGhyOKJLQHACOOVDdo=;
        b=Y4NutwNOcqsgquLCYPXOba/K9lFF6UObq4AdfG6HMgOQtn6f+fbCXEqu3I0h4FAy2q
         ZLrw+qxwE4ZsabFVUSSCOuAvVmtgkTpw5uLM7SuFsIXsIyGzFTNG/pOZb1yV+1iMwfFB
         DW5qf4zHUddOt7JrC9E8difegrNesYNlga3mhkOk8mWf4EZ25gUGuZH7hQG8Xeg4A+K4
         oXxqHMepgLnOAa8sF22Oxk+mvRMbuiswkRIxMecUDtlXOhPMuC0E+dPO+vd320dwK/in
         1ZOffifxMyA2I48J4xvpYHjuVj/W3mserbsmGX3qSl1y5/vem8IJKRTF3kaPvph/I/gh
         uldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5B73UfQ5a6IB10mvo49iMJhVZaGhyOKJLQHACOOVDdo=;
        b=Hrt+sGKZ83mW5KodApAgq3ZvMMVD7ZxDjbV0RHEtFy1CAhjQHr+46cT4tppHzYmRDM
         RgxfpTRsIgF57kUAgx1aIGaH9pH9QVGCTySSPFNdYrcciNZ0i53m+3RvkdFGlyFNuia1
         S5c1HVpIkhZXggP5u4FFVS0WzsgrkWfIxRnjo8zP95KQFdf64IYaGfuA1XaVHgWe66DV
         Yj/NXkANKbuaSLQRRPGG3YpYRcQRjmPeAv6wBa1Mx9iJSs4U4PjbIrhi1Cq6Xxzw7yaN
         IDyFq40a+pbW6lQeq2pMVXjdcKO2SWpB/qD1wBrzYWfkJw03jfu+Kxk6LroBUt0c9dB4
         N0bQ==
X-Gm-Message-State: AOAM5339OakX3euOs5Z6H4NIjNuPCKU8CWaoZwhLZbqCJkbMVYU/jJrk
        6DBz9v1IvJI/l8eK8+7z5RwsOQ==
X-Google-Smtp-Source: ABdhPJwvy328w/G/pcrOuyccvyR6qs/JOLYKIiiK1GEIK+Hjvu4MNTdnLSHQuQKy1zfL2U7kKIXiWg==
X-Received: by 2002:ac8:6bc5:: with SMTP id b5mr5920670qtt.90.1617854739055;
        Wed, 07 Apr 2021 21:05:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:38 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com
Subject: [PATCH v13 00/18] arm64: MMU enabled kexec relocation
Date:   Thu,  8 Apr 2021 00:05:19 -0400
Message-Id: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v13:
	- Fixed a hang on ThunderX2, thank you Pingfan Liu for reporting
	  the problem. In relocation function we need civac not ivac, we
	  need to clean data in addition to invalidating it.
	  Since I was using ThunderX2 machine I also measured the new
	  performance data on this large ARM64 server. The MMU improves
	  kexec relocation 190 times on this machine! (see below for
	  raw data). Saves 7.5s during CentOS kexec reboot.
v12:
	- A major change compared to previous version. Instead of using
	  contiguous VA range a copy of linear map is now used to perform
	  copying of segments during relocation as it was agreed in the
	  discussion of version 11 of this project.
	- In addition to using linear map, I also took several ideas from
	  James Morse to better organize the kexec relocation:
	  	1. skip relocation function entirely if that is not needed
		2. remove the PoC flushing function since it is not needed
		   anymore with MMU enabled.
v11:
	- Fixed missing KEXEC_CORE dependency for trans_pgd.c
	- Removed useless "if(rc) return rc" statement (thank you Tyler Hicks)
	- Another 12 patches were accepted into maintainer's get.
	  Re-based patches against:
	  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
	  Branch: for-next/kexec
v10:
	- Addressed a lot of comments form James Morse and from  Marc Zyngier
	- Added review-by's
	- Synchronized with mainline

v9:	- 9 patches from previous series landed in upstream, so now series
	  is smaller
	- Added two patches from James Morse to address idmap issues for machines
	  with high physical addresses.
	- Addressed comments from Selin Dag about compiling issues. He also tested
	  my series and got similar performance results: ~60 ms instead of ~580 ms
	  with an initramfs size of ~120MB.
v8:
	- Synced with mainline to keep series up-to-date
v7:
	-- Addressed comments from James Morse
	- arm64: hibernate: pass the allocated pgdp to ttbr0
	  Removed "Fixes" tag, and added Added Reviewed-by: James Morse
	- arm64: hibernate: check pgd table allocation
	  Sent out as a standalone patch so it can be sent to stable
	  Series applies on mainline + this patch
	- arm64: hibernate: add trans_pgd public functions
	  Remove second allocation of tmp_pg_dir in swsusp_arch_resume
	  Added Reviewed-by: James Morse <james.morse@arm.com>
	- arm64: kexec: move relocation function setup and clean up
	  Fixed typo in commit log
	  Changed kern_reloc to phys_addr_t types.
	  Added explanation why kern_reloc is needed.
	  Split into four patches:
	  arm64: kexec: make dtb_mem always enabled
	  arm64: kexec: remove unnecessary debug prints
	  arm64: kexec: call kexec_image_info only once
	  arm64: kexec: move relocation function setup
	- arm64: kexec: add expandable argument to relocation function
	  Changed types of new arguments from unsigned long to phys_addr_t.
	  Changed offset prefix to KEXEC_*
	  Split into four patches:
	  arm64: kexec: cpu_soft_restart change argument types
	  arm64: kexec: arm64_relocate_new_kernel clean-ups
	  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
	  arm64: kexec: add expandable argument to relocation function
	- arm64: kexec: configure trans_pgd page table for kexec
	  Added invalid entries into EL2 vector table
	  Removed KEXEC_EL2_VECTOR_TABLE_SIZE and KEXEC_EL2_VECTOR_TABLE_OFFSET
	  Copy relocation functions and table into separate pages
	  Changed types in kern_reloc_arg.
	  Split into three patches:
	  arm64: kexec: offset for relocation function
	  arm64: kexec: kexec EL2 vectors
	  arm64: kexec: configure trans_pgd page table for kexec
	- arm64: kexec: enable MMU during kexec relocation
	  Split into two patches:
	  arm64: kexec: enable MMU during kexec relocation
	  arm64: kexec: remove head from relocation argument
v6:
	- Sync with mainline tip
	- Added Acked's from Dave Young
v5:
	- Addressed comments from Matthias Brugger: added review-by's, improved
	  comments, and made cleanups to swsusp_arch_resume() in addition to
	  create_safe_exec_page().
	- Synced with mainline tip.
v4:
	- Addressed comments from James Morse.
	- Split "check pgd table allocation" into two patches, and moved to
	  the beginning of series  for simpler backport of the fixes.
	  Added "Fixes:" tags to commit logs.
	- Changed "arm64, hibernate:" to "arm64: hibernate:"
	- Added Reviewed-by's
	- Moved "add PUD_SECT_RDONLY" earlier in series to be with other
	  clean-ups
	- Added "Derived from:" to arch/arm64/mm/trans_pgd.c
	- Removed "flags" from trans_info
	- Changed .trans_alloc_page assumption to return zeroed page.
	- Simplify changes to trans_pgd_map_page(), by keeping the old
	  code.
	- Simplify changes to trans_pgd_create_copy, by keeping the old
	  code.
	- Removed: "add trans_pgd_create_empty"
	- replace init_mm with NULL, and keep using non "__" version of
	  populate functions.
v3:
	- Split changes to create_safe_exec_page() into several patches for
	  easier review as request by Mark Rutland. This is why this series
	  has 3 more patches.
	- Renamed trans_table to tans_pgd as agreed with Mark. The header
	  comment in trans_pgd.c explains that trans stands for
	  transitional page tables. Meaning they are used in transition
	  between two kernels.
v2:
	- Fixed hibernate bug reported by James Morse
	- Addressed comments from James Morse:
	  * More incremental changes to trans_table
	  * Removed TRANS_FORCEMAP
	  * Added kexec reboot data for image with 380M in size.

Enable MMU during kexec relocation in order to improve reboot performance.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs takes a significant portion
of reboot.

The reason for slow relocation is because it is done without MMU, and thus
not benefiting from D-Cache.

Performance data
----------------

Cavium ThunderX2:
Kernel Image size: 38M Iniramfs size: 46M Total relocation size: 84M
MMU-disabled:
relocation	7.489539915s
MMU-enabled:
relocation	0.03946095s

Relocation performance is improved 190 times.

Broadcom Stingray:
For this experiment, the size of kernel plus initramfs is small, only 25M.
If initramfs was larger, than the improvements would be greater, as time
spent in relocation is proportional to the size of relocation.

MMU-disabled::
kernel shutdown	0.022131328s
relocation	0.440510736s
kernel startup	0.294706768s

Relocation was taking: 58.2% of reboot time

MMU-enabled:
kernel shutdown	0.032066576s
relocation	0.022158152s
kernel startup	0.296055880s

Now: Relocation takes 6.3% of reboot time

Total reboot is x2.16 times faster.

With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
and is reduced from 3.9s down to 0.33s

Previous approaches and discussions
-----------------------------------
v12: https://lore.kernel.org/lkml/20210303002230.1083176-1-pasha.tatashin@soleen.com
v11: https://lore.kernel.org/lkml/20210127172706.617195-1-pasha.tatashin@soleen.com
v10: https://lore.kernel.org/linux-arm-kernel/20210125191923.1060122-1-pasha.tatashin@soleen.com
v9: https://lore.kernel.org/lkml/20200326032420.27220-1-pasha.tatashin@soleen.com
v8: https://lore.kernel.org/lkml/20191204155938.2279686-1-pasha.tatashin@soleen.com
v7: https://lore.kernel.org/lkml/20191016200034.1342308-1-pasha.tatashin@soleen.com
v6: https://lore.kernel.org/lkml/20191004185234.31471-1-pasha.tatashin@soleen.com
v5: https://lore.kernel.org/lkml/20190923203427.294286-1-pasha.tatashin@soleen.com
v4: https://lore.kernel.org/lkml/20190909181221.309510-1-pasha.tatashin@soleen.com
v3: https://lore.kernel.org/lkml/20190821183204.23576-1-pasha.tatashin@soleen.com
v2: https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
v1: https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com

James Morse (4):
  arm64: hyp-stub: Check the size of the HYP stub's vectors
  arm64: hyp-stub: Move invalid vector entries into the vectors
  arm64: hyp-stub: Move el1_sync into the vectors
  arm64: kexec: Use dcache ops macros instead of open-coding

Pavel Tatashin (13):
  arm64: kernel: add helper for booted at EL2 and not VHE
  arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
  arm64: hibernate: abstract ttrb0 setup function
  arm64: kexec: flush image and lists during kexec load time
  arm64: kexec: skip relocation code for inplace kexec
  arm64: kexec: pass kimage as the only argument to relocation function
  arm64: kexec: kexec may require EL2 vectors
  arm64: kexec: relocate in EL1 mode
  arm64: kexec: use ld script for relocation function
  arm64: kexec: install a copy of the linear-map
  arm64: kexec: keep MMU enabled during kexec relocation
  arm64: kexec: remove the pre-kexec PoC maintenance
  arm64: kexec: Remove cpu-reset.h

Pingfan Liu (1):
  arm64/mm: remove useless trans_pgd_map_page()

 arch/arm64/Kconfig                   |   2 +-
 arch/arm64/include/asm/assembler.h   |  31 ++++-
 arch/arm64/include/asm/kexec.h       |  12 ++
 arch/arm64/include/asm/mmu_context.h |  24 ++++
 arch/arm64/include/asm/sections.h    |   1 +
 arch/arm64/include/asm/trans_pgd.h   |   8 +-
 arch/arm64/include/asm/virt.h        |   8 ++
 arch/arm64/kernel/asm-offsets.c      |  11 ++
 arch/arm64/kernel/cpu-reset.S        |   7 +-
 arch/arm64/kernel/cpu-reset.h        |  32 -----
 arch/arm64/kernel/hibernate-asm.S    |  20 ----
 arch/arm64/kernel/hibernate.c        |  56 +++------
 arch/arm64/kernel/hyp-stub.S         |  95 +++++++--------
 arch/arm64/kernel/machine_kexec.c    | 168 +++++++++++++++------------
 arch/arm64/kernel/relocate_kernel.S  |  72 ++++++------
 arch/arm64/kernel/sdei.c             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S      |  19 +++
 arch/arm64/mm/trans_pgd.c            |  77 ++++--------
 18 files changed, 315 insertions(+), 330 deletions(-)
 delete mode 100644 arch/arm64/kernel/cpu-reset.h

-- 
2.25.1


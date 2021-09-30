Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FD341DC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349841AbhI3OdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbhI3Oc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:32:59 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758E2C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:16 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l13so5844806qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbuwxsKPYTdhf8jtJ8ZUpgnfmWMWZTkgjiohKslZ8j8=;
        b=cIUqv7nckLHWpokZNCEpj6sokKcbm/amEEbPinljY1GSvvLV7G0qwAFr2i96fNmXOY
         W83VIy7JvsqYUzIipyX7MR+HH0fRGrEzSS7omyMF/uj1981208ZFDBdI2H0bHM7QXMIj
         l0XAcTEo5xkCjrrnMl1jFl9iicVSpEL73o15FItn21dZaIRj+dwNZhaIIWyje9poa/Za
         vyJvxUte1UFmrUEd9r1fb7fkk/sJNyudqNKa4+Cwc2HMJMjZRHeSFPPW1fQh4GhqgrNm
         yxeLZZ8wYudRGx8OhS8B8fb9m9u3j+/7CVfiQ8BycEJ5HjzxkOEZ1sruvJy7yj7qfY2I
         xX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbuwxsKPYTdhf8jtJ8ZUpgnfmWMWZTkgjiohKslZ8j8=;
        b=S5wnhpp7YcVnuCTxC9kiOUfZovimKpZ/GYRbAavAYtndNz+VcFxXn1EHG+B66rQgzj
         0TFB0w0JDwdn0seSPG3t2M/545yR3k9Yfuaykf1TGDYJwyII7RlYME0d0zsXte9SEOWW
         rIyMRIr3OVNV0jPyznaUN+lmkzI5yoaRktblJqpsIop1X+ihpBS3PDPKA9dusfPIEgh7
         6ixupAlCIAWRqaH3Q4GFjAJO3k1Z+7Ttw0Y6qtlXRIoM0f0OhD8CC93hawDK0DsuHyl+
         PbrFXAd0Aus7sNb0DcZm6QeVFFUTDdroTvfd5qPKzTlyobYsBfM7kIj2lQmGgTHaPTYk
         Q4jw==
X-Gm-Message-State: AOAM533Yac7DMFtttwBo/j4gHiXb6EtSP/RyC71F1gChlW6w4IClJLpr
        4j+ZwcYS1mqL4I5zQEg1rlt2ag==
X-Google-Smtp-Source: ABdhPJzVuO1e+ABllsyU28hyU39xhqruFnQ7BdWzN0F3kwAkp+siOoDp1zDVlWouYBrpuGeVqM1lKA==
X-Received: by 2002:ac8:5e52:: with SMTP id i18mr6749061qtx.329.1633012275578;
        Thu, 30 Sep 2021 07:31:15 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:14 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org
Subject: [PATCH v18 00/15] arm64: MMU enabled kexec relocation
Date:   Thu, 30 Sep 2021 14:30:58 +0000
Message-Id: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
v18:
	- Addressed comments from Will Deacon
	- Added Acks from Catalin Marinas
v17:
	- Merged with 5.15-rc1 as requested by Catalin Marinas
	- Added Tested-by: Pingfan Liu <piliu@redhat.com>
v16:
	- Merged with 5.14-rc4
v15:
	- Changed trans_pgd_copy_el2_vectors() to use vector table that
	  only shared by kexec and hibernate. This way sync does not have
	  dangling branch that was recently introduced. (Reported by Marc
	  Zyngier)
	- Renamed is_hyp_callable() to is_hyp_nvhe() as requested by Marc
	  Zyngier
	- Clean-ups, comment fixes.
	- Sync with upstream 368094df48e680fa51cedb68537408cfa64b788e
v14:
	- Fixed a bug in "arm64: hyp-stub: Move elx_sync into the vectors"
	  that was noticed by Marc Zyngier
	- Merged with upstream
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
v17: https://lore.kernel.org/lkml/20210916231325.125533-1-pasha.tatashin@soleen.com
v16: https://lore.kernel.org/lkml/20210802215408.804942-1-pasha.tatashin@soleen.com
v15: https://lore.kernel.org/lkml/20210609004419.936873-1-pasha.tatashin@soleen.com
v14: https://lore.kernel.org/lkml/20210527150526.271941-1-pasha.tatashin@soleen.com
v13: https://lore.kernel.org/lkml/20210408040537.2703241-1-pasha.tatashin@soleen.com
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

Pasha Tatashin (15):
  arm64: kernel: add helper for booted at EL2 and not VHE
  arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
  arm64: hibernate: abstract ttrb0 setup function
  arm64: kexec: flush image and lists during kexec load time
  arm64: kexec: skip relocation code for inplace kexec
  arm64: kexec: Use dcache ops macros instead of open-coding
  arm64: kexec: pass kimage as the only argument to relocation function
  arm64: kexec: configure EL2 vectors for kexec
  arm64: kexec: relocate in EL1 mode
  arm64: kexec: use ld script for relocation function
  arm64: kexec: install a copy of the linear-map
  arm64: kexec: keep MMU enabled during kexec relocation
  arm64: kexec: remove the pre-kexec PoC maintenance
  arm64: kexec: remove cpu-reset.h
  arm64: trans_pgd: remove trans_pgd_map_page()

 arch/arm64/Kconfig                   |   2 +-
 arch/arm64/include/asm/assembler.h   |  49 ++++++--
 arch/arm64/include/asm/kexec.h       |  12 ++
 arch/arm64/include/asm/mmu_context.h |  24 ++++
 arch/arm64/include/asm/sections.h    |   1 +
 arch/arm64/include/asm/trans_pgd.h   |  14 ++-
 arch/arm64/include/asm/virt.h        |   7 ++
 arch/arm64/kernel/asm-offsets.c      |  11 ++
 arch/arm64/kernel/cpu-reset.S        |   7 +-
 arch/arm64/kernel/cpu-reset.h        |  32 -----
 arch/arm64/kernel/hibernate-asm.S    |  72 -----------
 arch/arm64/kernel/hibernate.c        |  49 ++------
 arch/arm64/kernel/machine_kexec.c    | 177 ++++++++++++++-------------
 arch/arm64/kernel/relocate_kernel.S  |  69 +++++------
 arch/arm64/kernel/sdei.c             |   2 +-
 arch/arm64/kernel/vmlinux.lds.S      |  19 +++
 arch/arm64/mm/Makefile               |   1 +
 arch/arm64/mm/trans_pgd-asm.S        |  65 ++++++++++
 arch/arm64/mm/trans_pgd.c            |  84 ++++---------
 19 files changed, 357 insertions(+), 340 deletions(-)
 delete mode 100644 arch/arm64/kernel/cpu-reset.h
 create mode 100644 arch/arm64/mm/trans_pgd-asm.S

-- 
2.33.0.800.g4c38ced690-goog


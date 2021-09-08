Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A93403682
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbhIHJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348242AbhIHJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631091590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i1z+hNoodfakHY/saIp3ZYZ7f5RY2OcgP3cCihuEZyw=;
        b=Q8E3kM4TZjLrPSg+vQKg+2ZAW6BJDd7W2UsWZTyFSsgr08nt558vcz4PQluaOq8yKT+gNE
        sw2sJNSo7XzcqsgZ7xYqJA34UObD0rLI4C/jxyHe2xaiBkhoDzkgJEUaO3LS57flmJeGdm
        WSO+WM7zIp95NkXDpyGZxgJ4Fxbv3zI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-uUzGojSdNKSXRtsRFTUufQ-1; Wed, 08 Sep 2021 04:59:47 -0400
X-MC-Unique: uUzGojSdNKSXRtsRFTUufQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0666C100C660;
        Wed,  8 Sep 2021 08:59:44 +0000 (UTC)
Received: from piliu.users.ipa.redhat.com (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70CFE6E0B0;
        Wed,  8 Sep 2021 08:59:31 +0000 (UTC)
Date:   Wed, 8 Sep 2021 16:59:28 +0800
From:   Pingfan Liu <piliu@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v16 00/15] arm64: MMU enabled kexec relocation
Message-ID: <YTh7cFoduzQwRwxk@piliu.users.ipa.redhat.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 05:53:53PM -0400, Pavel Tatashin wrote:
> Changelog:
> v16:
> 	- Merged with 5.14-rc4
> v15:
> 	- Changed trans_pgd_copy_el2_vectors() to use vector table that
> 	  only shared by kexec and hibernate. This way sync does not have
> 	  dangling branch that was recently introduced. (Reported by Marc
> 	  Zyngier)
> 	- Renamed is_hyp_callable() to is_hyp_nvhe() as requested by Marc
> 	  Zyngier
> 	- Clean-ups, comment fixes.
> 	- Sync with upstream 368094df48e680fa51cedb68537408cfa64b788e
> v14:
> 	- Fixed a bug in "arm64: hyp-stub: Move elx_sync into the vectors"
> 	  that was noticed by Marc Zyngier
> 	- Merged with upstream
> v13:
> 	- Fixed a hang on ThunderX2, thank you Pingfan Liu for reporting
> 	  the problem. In relocation function we need civac not ivac, we
> 	  need to clean data in addition to invalidating it.
> 	  Since I was using ThunderX2 machine I also measured the new
> 	  performance data on this large ARM64 server. The MMU improves
> 	  kexec relocation 190 times on this machine! (see below for
> 	  raw data). Saves 7.5s during CentOS kexec reboot.
> v12:
> 	- A major change compared to previous version. Instead of using
> 	  contiguous VA range a copy of linear map is now used to perform
> 	  copying of segments during relocation as it was agreed in the
> 	  discussion of version 11 of this project.
> 	- In addition to using linear map, I also took several ideas from
> 	  James Morse to better organize the kexec relocation:
> 	  	1. skip relocation function entirely if that is not needed
> 		2. remove the PoC flushing function since it is not needed
> 		   anymore with MMU enabled.
> v11:
> 	- Fixed missing KEXEC_CORE dependency for trans_pgd.c
> 	- Removed useless "if(rc) return rc" statement (thank you Tyler Hicks)
> 	- Another 12 patches were accepted into maintainer's get.
> 	  Re-based patches against:
> 	  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> 	  Branch: for-next/kexec
> v10:
> 	- Addressed a lot of comments form James Morse and from  Marc Zyngier
> 	- Added review-by's
> 	- Synchronized with mainline
> 
> v9:	- 9 patches from previous series landed in upstream, so now series
> 	  is smaller
> 	- Added two patches from James Morse to address idmap issues for machines
> 	  with high physical addresses.
> 	- Addressed comments from Selin Dag about compiling issues. He also tested
> 	  my series and got similar performance results: ~60 ms instead of ~580 ms
> 	  with an initramfs size of ~120MB.
> v8:
> 	- Synced with mainline to keep series up-to-date
> v7:
> 	-- Addressed comments from James Morse
> 	- arm64: hibernate: pass the allocated pgdp to ttbr0
> 	  Removed "Fixes" tag, and added Added Reviewed-by: James Morse
> 	- arm64: hibernate: check pgd table allocation
> 	  Sent out as a standalone patch so it can be sent to stable
> 	  Series applies on mainline + this patch
> 	- arm64: hibernate: add trans_pgd public functions
> 	  Remove second allocation of tmp_pg_dir in swsusp_arch_resume
> 	  Added Reviewed-by: James Morse <james.morse@arm.com>
> 	- arm64: kexec: move relocation function setup and clean up
> 	  Fixed typo in commit log
> 	  Changed kern_reloc to phys_addr_t types.
> 	  Added explanation why kern_reloc is needed.
> 	  Split into four patches:
> 	  arm64: kexec: make dtb_mem always enabled
> 	  arm64: kexec: remove unnecessary debug prints
> 	  arm64: kexec: call kexec_image_info only once
> 	  arm64: kexec: move relocation function setup
> 	- arm64: kexec: add expandable argument to relocation function
> 	  Changed types of new arguments from unsigned long to phys_addr_t.
> 	  Changed offset prefix to KEXEC_*
> 	  Split into four patches:
> 	  arm64: kexec: cpu_soft_restart change argument types
> 	  arm64: kexec: arm64_relocate_new_kernel clean-ups
> 	  arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
> 	  arm64: kexec: add expandable argument to relocation function
> 	- arm64: kexec: configure trans_pgd page table for kexec
> 	  Added invalid entries into EL2 vector table
> 	  Removed KEXEC_EL2_VECTOR_TABLE_SIZE and KEXEC_EL2_VECTOR_TABLE_OFFSET
> 	  Copy relocation functions and table into separate pages
> 	  Changed types in kern_reloc_arg.
> 	  Split into three patches:
> 	  arm64: kexec: offset for relocation function
> 	  arm64: kexec: kexec EL2 vectors
> 	  arm64: kexec: configure trans_pgd page table for kexec
> 	- arm64: kexec: enable MMU during kexec relocation
> 	  Split into two patches:
> 	  arm64: kexec: enable MMU during kexec relocation
> 	  arm64: kexec: remove head from relocation argument
> v6:
> 	- Sync with mainline tip
> 	- Added Acked's from Dave Young
> v5:
> 	- Addressed comments from Matthias Brugger: added review-by's, improved
> 	  comments, and made cleanups to swsusp_arch_resume() in addition to
> 	  create_safe_exec_page().
> 	- Synced with mainline tip.
> v4:
> 	- Addressed comments from James Morse.
> 	- Split "check pgd table allocation" into two patches, and moved to
> 	  the beginning of series  for simpler backport of the fixes.
> 	  Added "Fixes:" tags to commit logs.
> 	- Changed "arm64, hibernate:" to "arm64: hibernate:"
> 	- Added Reviewed-by's
> 	- Moved "add PUD_SECT_RDONLY" earlier in series to be with other
> 	  clean-ups
> 	- Added "Derived from:" to arch/arm64/mm/trans_pgd.c
> 	- Removed "flags" from trans_info
> 	- Changed .trans_alloc_page assumption to return zeroed page.
> 	- Simplify changes to trans_pgd_map_page(), by keeping the old
> 	  code.
> 	- Simplify changes to trans_pgd_create_copy, by keeping the old
> 	  code.
> 	- Removed: "add trans_pgd_create_empty"
> 	- replace init_mm with NULL, and keep using non "__" version of
> 	  populate functions.
> v3:
> 	- Split changes to create_safe_exec_page() into several patches for
> 	  easier review as request by Mark Rutland. This is why this series
> 	  has 3 more patches.
> 	- Renamed trans_table to tans_pgd as agreed with Mark. The header
> 	  comment in trans_pgd.c explains that trans stands for
> 	  transitional page tables. Meaning they are used in transition
> 	  between two kernels.
> v2:
> 	- Fixed hibernate bug reported by James Morse
> 	- Addressed comments from James Morse:
> 	  * More incremental changes to trans_table
> 	  * Removed TRANS_FORCEMAP
> 	  * Added kexec reboot data for image with 380M in size.
> 
> Enable MMU during kexec relocation in order to improve reboot performance.
> 
> If kexec functionality is used for a fast system update, with a minimal
> downtime, the relocation of kernel + initramfs takes a significant portion
> of reboot.
> 
> The reason for slow relocation is because it is done without MMU, and thus
> not benefiting from D-Cache.
> 
> Performance data
> ----------------
> 
> Cavium ThunderX2:
> Kernel Image size: 38M Iniramfs size: 46M Total relocation size: 84M
> MMU-disabled:
> relocation	7.489539915s
> MMU-enabled:
> relocation	0.03946095s
> 
> Relocation performance is improved 190 times.
> 
> Broadcom Stingray:
> For this experiment, the size of kernel plus initramfs is small, only 25M.
> If initramfs was larger, than the improvements would be greater, as time
> spent in relocation is proportional to the size of relocation.
> 
> MMU-disabled::
> kernel shutdown	0.022131328s
> relocation	0.440510736s
> kernel startup	0.294706768s
> 
> Relocation was taking: 58.2% of reboot time
> 
> MMU-enabled:
> kernel shutdown	0.032066576s
> relocation	0.022158152s
> kernel startup	0.296055880s
> 
> Now: Relocation takes 6.3% of reboot time
> 
> Total reboot is x2.16 times faster.
> 
> With bigger userland (fitImage 380M), the reboot time is improved by 3.57s,
> and is reduced from 3.9s down to 0.33s
> 
> Previous approaches and discussions
> -----------------------------------
> v15: https://lore.kernel.org/lkml/20210609004419.936873-1-pasha.tatashin@soleen.com
> v14: https://lore.kernel.org/lkml/20210527150526.271941-1-pasha.tatashin@soleen.com
> v13: https://lore.kernel.org/lkml/20210408040537.2703241-1-pasha.tatashin@soleen.com
> v12: https://lore.kernel.org/lkml/20210303002230.1083176-1-pasha.tatashin@soleen.com
> v11: https://lore.kernel.org/lkml/20210127172706.617195-1-pasha.tatashin@soleen.com
> v10: https://lore.kernel.org/linux-arm-kernel/20210125191923.1060122-1-pasha.tatashin@soleen.com
> v9: https://lore.kernel.org/lkml/20200326032420.27220-1-pasha.tatashin@soleen.com
> v8: https://lore.kernel.org/lkml/20191204155938.2279686-1-pasha.tatashin@soleen.com
> v7: https://lore.kernel.org/lkml/20191016200034.1342308-1-pasha.tatashin@soleen.com
> v6: https://lore.kernel.org/lkml/20191004185234.31471-1-pasha.tatashin@soleen.com
> v5: https://lore.kernel.org/lkml/20190923203427.294286-1-pasha.tatashin@soleen.com
> v4: https://lore.kernel.org/lkml/20190909181221.309510-1-pasha.tatashin@soleen.com
> v3: https://lore.kernel.org/lkml/20190821183204.23576-1-pasha.tatashin@soleen.com
> v2: https://lore.kernel.org/lkml/20190817024629.26611-1-pasha.tatashin@soleen.com
> v1: https://lore.kernel.org/lkml/20190801152439.11363-1-pasha.tatashin@soleen.com
> 
> Pavel Tatashin (15):
>   arm64: kernel: add helper for booted at EL2 and not VHE
>   arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
>   arm64: hibernate: abstract ttrb0 setup function
>   arm64: kexec: flush image and lists during kexec load time
>   arm64: kexec: skip relocation code for inplace kexec
>   arm64: kexec: Use dcache ops macros instead of open-coding
>   arm64: kexec: pass kimage as the only argument to relocation function
>   arm64: kexec: configure EL2 vectors for kexec
>   arm64: kexec: relocate in EL1 mode
>   arm64: kexec: use ld script for relocation function
>   arm64: kexec: install a copy of the linear-map
>   arm64: kexec: keep MMU enabled during kexec relocation
>   arm64: kexec: remove the pre-kexec PoC maintenance
>   arm64: kexec: remove cpu-reset.h
>   arm64: trans_pgd: remove trans_pgd_map_page()
> 
>  arch/arm64/Kconfig                   |   2 +-
>  arch/arm64/include/asm/assembler.h   |  49 ++++++--
>  arch/arm64/include/asm/kexec.h       |  12 ++
>  arch/arm64/include/asm/mmu_context.h |  24 ++++
>  arch/arm64/include/asm/sections.h    |   1 +
>  arch/arm64/include/asm/trans_pgd.h   |  12 +-
>  arch/arm64/include/asm/virt.h        |   7 ++
>  arch/arm64/kernel/asm-offsets.c      |  11 ++
>  arch/arm64/kernel/cpu-reset.S        |   7 +-
>  arch/arm64/kernel/cpu-reset.h        |  32 -----
>  arch/arm64/kernel/hibernate-asm.S    |  72 -----------
>  arch/arm64/kernel/hibernate.c        |  49 ++------
>  arch/arm64/kernel/machine_kexec.c    | 177 ++++++++++++++-------------
>  arch/arm64/kernel/relocate_kernel.S  |  70 +++++------
>  arch/arm64/kernel/sdei.c             |   2 +-
>  arch/arm64/kernel/vmlinux.lds.S      |  19 +++
>  arch/arm64/mm/Makefile               |   1 +
>  arch/arm64/mm/trans_pgd-asm.S        |  65 ++++++++++
>  arch/arm64/mm/trans_pgd.c            |  82 ++++---------
>  19 files changed, 356 insertions(+), 338 deletions(-)
>  delete mode 100644 arch/arm64/kernel/cpu-reset.h
>  create mode 100644 arch/arm64/mm/trans_pgd-asm.S
> 
> 
> base-commit: c500bee1c5b2f1d59b1081ac879d73268ab0ff17
> -- 

Tested-by: Pingfan Liu <piliu@redhat.com>


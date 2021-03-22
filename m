Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3F343652
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 02:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCVBgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhCVBgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:36:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7AFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:36:19 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id d2so13380164ilm.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 18:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5P3FnGvvFEq3w5k+fDoeNErW7w8oAG1qbo2SONBJzWo=;
        b=HIyjGI/d4S7sb4SiCR3WWj0k+BR6EODOreHMXL+lWaWbNRQTKZak6/m/CbocpjXoWK
         GheNCrBDLHjz5ZoxWBBNWJQKn1rzX0+OVrczFe2R4zseLHF6dfZ47m9db66ULf3HLjyX
         gWU6aOC4aZ6oqAEXD5L1hwvGmgxykFdmNYU2JngBt8sj7d0qEvUABvmIlVcQypYQNuCx
         m0JDJJB7w30FnAIHmwXy7MVnuunL49rP6XaKzupZMryx0YRxj/XehE4DzEaZiemo+U2i
         rKk7ks1tNqHVy3IrS+6hAMJK6VPAB/wvMbcUB3RW0znTOh5llqFv0TtD0kl0pDA2UvhQ
         MxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5P3FnGvvFEq3w5k+fDoeNErW7w8oAG1qbo2SONBJzWo=;
        b=oc6TFCdvHHs7/KkYHe2PqX2B19dABqVFzBsi/dSwCCq8NqmXnLuxMARJF5uiZOuLoj
         bWfoECcwoMmx2vyPb/Pos3bAv2rSfnqwg9YW1BAYBZYycUJFLAFk5umq0i8vpsqVtR+B
         MhFW1+enSJzTIZQLz+s7YbG3tD75/due+HNdks62QHe0De22L2qhdJSwWbtduJhbW73F
         ogN392ta2puel5ClMVm+rg8RCcbpCvfSfkyw7nZ55aV603ptIF8gbHr2i/2lVa+w3NjA
         qz+NVOCU+rY1CReqYecxMxRofV3315QC+Fkp8mJ+oiTSJZcFo6PaDvd72SoNlFJqPIAl
         FzNA==
X-Gm-Message-State: AOAM531q7neFev6G7BdUQNUM6melFdcChbtQtp/QiWwE32Jn3VMbzuTs
        NppSDnXYxwTwNvR19gpHlYkkHawUSXA6NfesYg==
X-Google-Smtp-Source: ABdhPJxW9Bh+pO3vwANocNTDMFgSqsRyB88k7iZw8tY8IldUCWXD3w9aMO1BBUAmOXKw18Fc0K2cx5DL8B3wjtRjQNI=
X-Received: by 2002:a05:6e02:eaf:: with SMTP id u15mr9258087ilj.45.1616376978691;
 Sun, 21 Mar 2021 18:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 22 Mar 2021 09:36:07 +0800
Message-ID: <CAFgQCTtthPoxMyNX=epHHNqG8O1ZykQaLtCCObnHSUP5hS9+Ag@mail.gmail.com>
Subject: Re: [PATCH v12 00/17] arm64: MMU enabled kexec relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        matthias.bgg@gmail.com, Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>, rfontana@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, selindag@gmail.com,
        tyhicks@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

After going through this series, I think if this can be done by using
identity map through ttbr0.

Then the processes may be neat (I hope so):
-1. set up identity map in machine_kexec_post_load(), instead of
copying linear map.
-2. Also past this temporary identity map to arm64_relocate_new_kernel()
-3. in arm64_relocate_new_kernel(), just load identity map and
re-enable MMU. After copying, just turn off MMU.

Thanks,
Pingfan

On Thu, Mar 4, 2021 at 3:47 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Changelog:
> v12:
>         - A major change compared to previous version. Instead of using
>           contiguous VA range a copy of linear map is now used to perform
>           copying of segments during relocation as it was agreed in the
>           discussion of version 11 of this project.
>         - In addition to using linear map, I also took several ideas from
>           James Morse to better organize the kexec relocation:
>                 1. skip relocation function entirely if that is not needed
>                 2. remove the PoC flushing function since it is not needed
>                    anymore with MMU enabled.
> v11:
>         - Fixed missing KEXEC_CORE dependency for trans_pgd.c
>         - Removed useless "if(rc) return rc" statement (thank you Tyler Hicks)
>         - Another 12 patches were accepted into maintainer's get.
>           Re-based patches against:
>           https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
>           Branch: for-next/kexec
> v10:
>         - Addressed a lot of comments form James Morse and from  Marc Zyngier
>         - Added review-by's
>         - Synchronized with mainline
>
> v9:     - 9 patches from previous series landed in upstream, so now series
>           is smaller
>         - Added two patches from James Morse to address idmap issues for machines
>           with high physical addresses.
>         - Addressed comments from Selin Dag about compiling issues. He also tested
>           my series and got similar performance results: ~60 ms instead of ~580 ms
>           with an initramfs size of ~120MB.
> v8:
>         - Synced with mainline to keep series up-to-date
> v7:
>         -- Addressed comments from James Morse
>         - arm64: hibernate: pass the allocated pgdp to ttbr0
>           Removed "Fixes" tag, and added Added Reviewed-by: James Morse
>         - arm64: hibernate: check pgd table allocation
>           Sent out as a standalone patch so it can be sent to stable
>           Series applies on mainline + this patch
>         - arm64: hibernate: add trans_pgd public functions
>           Remove second allocation of tmp_pg_dir in swsusp_arch_resume
>           Added Reviewed-by: James Morse <james.morse@arm.com>
>         - arm64: kexec: move relocation function setup and clean up
>           Fixed typo in commit log
>           Changed kern_reloc to phys_addr_t types.
>           Added explanation why kern_reloc is needed.
>           Split into four patches:
>           arm64: kexec: make dtb_mem always enabled
>           arm64: kexec: remove unnecessary debug prints
>           arm64: kexec: call kexec_image_info only once
>           arm64: kexec: move relocation function setup
>         - arm64: kexec: add expandable argument to relocation function
>           Changed types of new arguments from unsigned long to phys_addr_t.
>           Changed offset prefix to KEXEC_*
>           Split into four patches:
>           arm64: kexec: cpu_soft_restart change argument types
>           arm64: kexec: arm64_relocate_new_kernel clean-ups
>           arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
>           arm64: kexec: add expandable argument to relocation function
>         - arm64: kexec: configure trans_pgd page table for kexec
>           Added invalid entries into EL2 vector table
>           Removed KEXEC_EL2_VECTOR_TABLE_SIZE and KEXEC_EL2_VECTOR_TABLE_OFFSET
>           Copy relocation functions and table into separate pages
>           Changed types in kern_reloc_arg.
>           Split into three patches:
>           arm64: kexec: offset for relocation function
>           arm64: kexec: kexec EL2 vectors
>           arm64: kexec: configure trans_pgd page table for kexec
>         - arm64: kexec: enable MMU during kexec relocation
>           Split into two patches:
>           arm64: kexec: enable MMU during kexec relocation
>           arm64: kexec: remove head from relocation argument
> v6:
>         - Sync with mainline tip
>         - Added Acked's from Dave Young
> v5:
>         - Addressed comments from Matthias Brugger: added review-by's, improved
>           comments, and made cleanups to swsusp_arch_resume() in addition to
>           create_safe_exec_page().
>         - Synced with mainline tip.
> v4:
>         - Addressed comments from James Morse.
>         - Split "check pgd table allocation" into two patches, and moved to
>           the beginning of series  for simpler backport of the fixes.
>           Added "Fixes:" tags to commit logs.
>         - Changed "arm64, hibernate:" to "arm64: hibernate:"
>         - Added Reviewed-by's
>         - Moved "add PUD_SECT_RDONLY" earlier in series to be with other
>           clean-ups
>         - Added "Derived from:" to arch/arm64/mm/trans_pgd.c
>         - Removed "flags" from trans_info
>         - Changed .trans_alloc_page assumption to return zeroed page.
>         - Simplify changes to trans_pgd_map_page(), by keeping the old
>           code.
>         - Simplify changes to trans_pgd_create_copy, by keeping the old
>           code.
>         - Removed: "add trans_pgd_create_empty"
>         - replace init_mm with NULL, and keep using non "__" version of
>           populate functions.
> v3:
>         - Split changes to create_safe_exec_page() into several patches for
>           easier review as request by Mark Rutland. This is why this series
>           has 3 more patches.
>         - Renamed trans_table to tans_pgd as agreed with Mark. The header
>           comment in trans_pgd.c explains that trans stands for
>           transitional page tables. Meaning they are used in transition
>           between two kernels.
> v2:
>         - Fixed hibernate bug reported by James Morse
>         - Addressed comments from James Morse:
>           * More incremental changes to trans_table
>           * Removed TRANS_FORCEMAP
>           * Added kexec reboot data for image with 380M in size.
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
> For this experiment, the size of kernel plus initramfs is small, only 25M.
> If initramfs was larger, than the improvements would be greater, as time
> spent in relocation is proportional to the size of relocation.
>
> Previously:
> kernel shutdown 0.022131328s
> relocation      0.440510736s
> kernel startup  0.294706768s
>
> Relocation was taking: 58.2% of reboot time
>
> Now:
> kernel shutdown 0.032066576s
> relocation      0.022158152s
> kernel startup  0.296055880s
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
> James Morse (4):
>   arm64: hyp-stub: Check the size of the HYP stub's vectors
>   arm64: hyp-stub: Move invalid vector entries into the vectors
>   arm64: hyp-stub: Move el1_sync into the vectors
>   arm64: kexec: Use dcache ops macros instead of open-coding
>
> Pavel Tatashin (13):
>   arm64: kernel: add helper for booted at EL2 and not VHE
>   arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
>   arm64: hibernate: abstract ttrb0 setup function
>   arm64: kexec: flush image and lists during kexec load time
>   arm64: kexec: skip relocation code for inplace kexec
>   arm64: kexec: pass kimage as the only argument to relocation function
>   arm64: kexec: kexec may require EL2 vectors
>   arm64: kexec: relocate in EL1 mode
>   arm64: kexec: use ld script for relocation function
>   arm64: kexec: install a copy of the linear-map
>   arm64: kexec: keep MMU enabled during kexec relocation
>   arm64: kexec: remove the pre-kexec PoC maintenance
>   arm64: kexec: Remove cpu-reset.h
>
>  arch/arm64/Kconfig                   |   2 +-
>  arch/arm64/include/asm/assembler.h   |  31 ++++-
>  arch/arm64/include/asm/kexec.h       |  12 ++
>  arch/arm64/include/asm/mmu_context.h |  24 ++++
>  arch/arm64/include/asm/sections.h    |   1 +
>  arch/arm64/include/asm/trans_pgd.h   |   3 +
>  arch/arm64/include/asm/virt.h        |   8 ++
>  arch/arm64/kernel/asm-offsets.c      |  11 ++
>  arch/arm64/kernel/cpu-reset.S        |   7 +-
>  arch/arm64/kernel/cpu-reset.h        |  32 -----
>  arch/arm64/kernel/hibernate-asm.S    |  20 ----
>  arch/arm64/kernel/hibernate.c        |  56 +++------
>  arch/arm64/kernel/hyp-stub.S         |  95 +++++++--------
>  arch/arm64/kernel/machine_kexec.c    | 168 +++++++++++++++------------
>  arch/arm64/kernel/relocate_kernel.S  |  72 ++++++------
>  arch/arm64/kernel/sdei.c             |   2 +-
>  arch/arm64/kernel/vmlinux.lds.S      |  19 +++
>  arch/arm64/mm/trans_pgd.c            |  20 ++++
>  18 files changed, 314 insertions(+), 269 deletions(-)
>  delete mode 100644 arch/arm64/kernel/cpu-reset.h
>
> --
> 2.25.1
>

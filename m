Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA403A9A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhFPMUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbhFPMUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:20:44 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C955C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:18:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u24so2371484edy.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aMG1rgHzbx8tLqPnrgoAITLeb8LBkwiIu8MXSTmmdi8=;
        b=gywdPYuOWOldT99oiDHK1rlEcDqsuTiftiokrAXsvCZyoMut3o7LF57C4sgZZQhMOt
         NG6SCX5Rn6VCfsR2C0odeeyOoSIyWkOMCcdZAhLewcjPUagzFhD3y8QZ576wBIdMChXn
         I+dywp3WmsNeT2CbQCELUGRm1gqjxiITDVBc3WgigQ0FK6JspYIq3STWRV5AVb7qZv7P
         uVYwgaz5ugkw11EXpEhptaYHmHllcmnbPkRHM5XVmMFx46hHFb/ELwJZafwDLSTdgHHG
         kYL8A0WlgPOIsf3udgNnqKFglo06b1/b7YjuzEKWoBFx6bFWDsCp5IbaHZp6S3oVKkZG
         5w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aMG1rgHzbx8tLqPnrgoAITLeb8LBkwiIu8MXSTmmdi8=;
        b=aDfYDxKHKZxDPq3udA+smbL1MwEKHZPsa9Ld4Ju17Es7xOJl2XutcVOvzJARlUFA9I
         PE8X4oO3zbAzNOte4V1rI0crOnuyJIYmK/X5+HT7Sk7Eah2pwQkE4UPZV0+6rXCTf5sC
         bcvy3ToV+p92zVhXYstVSxv9B96NSbd9HDBrVfVU8T7xlFGTiDygqmfuNqRkU0ljtF8e
         yUYG5s4Y5oJyIzVjlYCnAhFx9vKxNag8B5QA3VH5KP1iMegt6+maDKyzt5ZOozOMMajm
         8gvxpe1hjUx+ScBGdjsV2d6sl+j+IF2Mb1EUUYqchUjsP/aK6QoS9CuNOGn0R0Z3EhZ+
         DhHw==
X-Gm-Message-State: AOAM530PUwNcz8TPumqADJAlgajn88QCrzb4UJz4MnEkZIgER5oZx4Xi
        d1ICv34p7L5/djf3IDYeqyhrxJN+GW38A2Dx+PnM+Q==
X-Google-Smtp-Source: ABdhPJzsXaCcua6A7GuvSzgPHcg+u6YgWNQ2O+bihVVm4nL1cDDpwYMpwbXyx9vm2fvgeFsUBiXOqfcG2RVRcVtqMqw=
X-Received: by 2002:aa7:ce96:: with SMTP id y22mr3942811edv.210.1623845915724;
 Wed, 16 Jun 2021 05:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 16 Jun 2021 08:17:59 -0400
Message-ID: <CA+CK2bA4e7mn+anvgw51HTXbw=-6e0emsupnhTuTrHgQzT9QJA@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] arm64: MMU enabled kexec relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        madvenka@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 8:44 PM Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> Changelog:
> v15:
>         - Changed trans_pgd_copy_el2_vectors() to use vector table that
>           only shared by kexec and hibernate. This way sync does not have
>           dangling branch that was recently introduced. (Reported by Marc
>           Zyngier)
>         - Renamed is_hyp_callable() to is_hyp_nvhe() as requested by Marc
>           Zyngier
>         - Clean-ups, comment fixes.
>         - Sync with upstream 368094df48e680fa51cedb68537408cfa64b788e
> v14:
>         - Fixed a bug in "arm64: hyp-stub: Move elx_sync into the vectors"
>           that was noticed by Marc Zyngier
>         - Merged with upstream
> v13:
>         - Fixed a hang on ThunderX2, thank you Pingfan Liu for reporting
>           the problem. In relocation function we need civac not ivac, we
>           need to clean data in addition to invalidating it.
>           Since I was using ThunderX2 machine I also measured the new
>           performance data on this large ARM64 server. The MMU improves
>           kexec relocation 190 times on this machine! (see below for
>           raw data). Saves 7.5s during CentOS kexec reboot.
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
>
> Cavium ThunderX2:
> Kernel Image size: 38M Iniramfs size: 46M Total relocation size: 84M
> MMU-disabled:
> relocation      7.489539915s
> MMU-enabled:
> relocation      0.03946095s
>
> Relocation performance is improved 190 times.
>
> Broadcom Stingray:
> For this experiment, the size of kernel plus initramfs is small, only 25M.
> If initramfs was larger, than the improvements would be greater, as time
> spent in relocation is proportional to the size of relocation.
>
> MMU-disabled::
> kernel shutdown 0.022131328s
> relocation      0.440510736s
> kernel startup  0.294706768s
>
> Relocation was taking: 58.2% of reboot time
>
> MMU-enabled:
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

HI All,

I am looking for reviewers. It provides a great performance boost, but
lacks reviewers for the last iterations of the series.

Than you,
Pasha

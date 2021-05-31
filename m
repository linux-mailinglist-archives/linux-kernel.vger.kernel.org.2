Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C6A396863
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhEaTi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 15:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231144AbhEaTiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 15:38:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BA546128A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622489805;
        bh=CLLhfPrGUsh9JYNXiGJiXeJ+RJ6r+AscuPI1NBWlG5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c2Dqg7GWLB84YPc3RL/DZS2dSv7b9DnrLUt+9fQ39YNaqog0T1BRyqHF0g99W/kG4
         kVZ2XwUlRKsEIdx3mu2+3VBOJV8ERpcYo0mrC94IQiLva95SgBBp9B84zfRJj27GRv
         ojWggEuAFssJPXf7SX/WGfLbqLvN+5taWwME07vHN8rPO8Cs3vmIkLsgtQB4uSv2K4
         x+kuBVsQKYxzTRqw/QD3+CLa6W8Hl6YbVPU+Q9yQ2t1t0zYWvA70gFdNyUICubMVIe
         WNt2Z5qkqMTkFH7sgRjoLPbnxgJntQjII1S+M7qpFXc36/23B8X7VdTqJPBE96ezo4
         MHbcM+yzWdVSw==
Received: by mail-ot1-f43.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso12026681ote.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 12:36:45 -0700 (PDT)
X-Gm-Message-State: AOAM53032Lja9GrU7l7c2U2BMndMgtZATh9qba8EfsWYWSC5nlxMHFf9
        agLyspU9hGrKi2OOTALkadbNaJiEaPHwKChUwtg=
X-Google-Smtp-Source: ABdhPJzKQ18se19IrtZo2HMHS0JyPFh2MzBsqtIx1KLprlO2Vao7wxsnqsNC4IogO3uIkDgHCuM8VB9hhwigwiULMks=
X-Received: by 2002:a9d:7cd8:: with SMTP id r24mr18604847otn.90.1622489804839;
 Mon, 31 May 2021 12:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210531095720.77469-1-maz@kernel.org>
In-Reply-To: <20210531095720.77469-1-maz@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 May 2021 21:36:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjsdnNy=7yMwCQsAyKrratU0_9eemviHug6VeGbSEmOg@mail.gmail.com>
Message-ID: <CAMj1kXFjsdnNy=7yMwCQsAyKrratU0_9eemviHug6VeGbSEmOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] arm64: Make kexec_file_load honor iomem reservations
To:     Marc Zyngier <maz@kernel.org>
Cc:     kexec@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Bhupesh SHARMA <bhupesh.sharma@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Moritz Fischer <mdf@kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2021 at 11:57, Marc Zyngier <maz@kernel.org> wrote:
>
> This series is a complete departure from the approach I initially sent
> almost a month ago[0]. Instead of trying to teach EFI, ACPI and other
> subsystem to use memblock, I've decided to stick with the iomem
> resource tree and use that exclusively for arm64.
>
> This means that my current approach is (despite what I initially
> replied to both Dave and Catalin) to provide an arm64-specific
> implementation of arch_kexec_locate_mem_hole() which walks the
> resource tree and excludes ranges of RAM that have been registered for
> any odd purpose. This is exactly what the userspace implementation
> does, and I don't really see a good reason to diverge from it.
>
> Again, this allows my Synquacer board to reliably use kexec_file_load
> with as little as 256M, something that would always fail before as it
> would overwrite most of the reserved tables.
>
> Although this series still targets 5.14, the initial patch is a
> -stable candidate, and disables non-kdump uses of kexec_file_load. I
> have limited it to 5.10, as earlier kernels will require a different,
> probably more invasive approach.
>
> Catalin, Ard: although this series has changed a bit compared to v1,
> I've kept your AB/RB tags. Should anything seem odd, please let me
> know and I'll drop them.
>

Fine with me.

> Thanks,
>
>         M.
>
> * From v1 [1]:
>   - Move the overlap exclusion into find_next_iomem_res()
>   - Handle child resource not overlapping with parent
>   - Provide walk_system_ram_excluding_child_res() as a top level
>     walker
>   - Simplify arch-specific code
>   - Add initial patch disabling non-crash kernels
>
> [0] https://lore.kernel.org/r/20210429133533.1750721-1-maz@kernel.org
> [1] https://lore.kernel.org/r/20210526190531.62751-1-maz@kernel.org
>
> Marc Zyngier (5):
>   arm64: kexec_file: Forbid non-crash kernels
>   kexec_file: Make locate_mem_hole_callback global
>   kernel/resource: Allow find_next_iomem_res() to exclude overlapping
>     child resources
>   kernel/resource: Introduce walk_system_ram_excluding_child_res()
>   arm64: kexec_image: Restore full kexec functionnality
>
>  arch/arm64/kernel/kexec_image.c | 39 ++++++++++++++++
>  include/linux/ioport.h          |  3 ++
>  include/linux/kexec.h           |  1 +
>  kernel/kexec_file.c             |  6 +--
>  kernel/resource.c               | 82 +++++++++++++++++++++++++++++----
>  5 files changed, 119 insertions(+), 12 deletions(-)
>
> --
> 2.30.2
>

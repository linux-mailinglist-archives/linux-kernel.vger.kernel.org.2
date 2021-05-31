Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D045395536
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 08:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhEaGE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 02:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhEaGET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 02:04:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 015B86023E
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 06:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622440960;
        bh=+5ov8UUntqW9gCmRshS2gEuALsinTqlQoIyDSLkMHLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dkMt42Zsli2RFAB7P//uWpCuOMQQldTvXWBSnI7bd1WVfDurwkE6X0xLXPcfSNT9D
         zCSsCCMmptmKglgXIcXDMp0lrs4jZF5YQPIE7klxws4s7lJOBlwpHHoWhnNyHrykEc
         w6Bs8g6sWeWSVCfQNBkZ6Z944AHuE8PxmTI3zSYuIsMsnur/nV0ifYNiihWaYbdVpy
         Jb69l7kfAvSqgbISrgUBOBLCM/nCTLetDWn8NdDsTEahPAY+1NxsLztU2QFc+RlQvY
         DUfdG4mBh7JizraGFIXf47OQnAyfjNnrA0b10dihug/NQhj2NgYhwfj7dOVXW+vmFK
         kIvaOoNxkfTBA==
Received: by mail-oi1-f178.google.com with SMTP id u11so11303194oiv.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 23:02:39 -0700 (PDT)
X-Gm-Message-State: AOAM530Xf7jHZTzUr6Ff+Gx0zTzaTRi510B+3H0IG4Vt1eQVc1OnPt5F
        7FVdugcGDWeco/qzS6Gl3s1m2lUaZN+G7A962Uk=
X-Google-Smtp-Source: ABdhPJxpsgJjfZbYUkFGUua5GCtrw+Y5M3W3A5zPJoM/HKRwYUIwL1KYxU7I/5umn1sOxgOf6gUDbUZZT2aa9w0RGx4=
X-Received: by 2002:aca:4343:: with SMTP id q64mr13196858oia.33.1622440959409;
 Sun, 30 May 2021 23:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210526190531.62751-1-maz@kernel.org> <20210527173915.GH8661@arm.com>
In-Reply-To: <20210527173915.GH8661@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 May 2021 08:02:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEMfDd=OVoZQ9C2hiJg7QbD8LvTjXRyrHDPvhOQYn=5cA@mail.gmail.com>
Message-ID: <CAMj1kXEMfDd=OVoZQ9C2hiJg7QbD8LvTjXRyrHDPvhOQYn=5cA@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Make kexec_file_load honor iomem reservations
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, kexec@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Moritz Fischer <mdf@kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 19:39, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, May 26, 2021 at 08:05:27PM +0100, Marc Zyngier wrote:
> > This series is a complete departure from the approach I initially sent
> > almost a month ago[1]. Instead of trying to teach EFI, ACPI and other
> > subsystem to use memblock, I've decided to stick with the iomem
> > resource tree and use that exclusively for arm64.
> >
> > This means that my current approach is (despite what I initially
> > replied to both Dave and Catalin) to provide an arm64-specific
> > implementation of arch_kexec_locate_mem_hole() which walks the
> > resource tree and excludes ranges of RAM that have been registered for
> > any odd purpose. This is exactly what the userspace implementation
> > does, and I don't really see a good reason to diverge from it.
> >
> > Again, this allows my Synquacer board to reliably use kexec_file_load
> > with as little as 256M, something that would always fail before as it
> > would overwrite most of the reserved tables.
> >
> > Obviously, this is now at least 5.14 material. Given how broken
> > kexec_file_load is for non-crash kernels on arm64 at the moment,
> > should we at least disable it in 5.13 and all previous stable kernels?
>
> I think it makes sense to disable it in the current and earlier kernels.
>

Ack to that

> For this series:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

and likewise for the series

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

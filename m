Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A431C6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBPHh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229713AbhBPHhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:37:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3975264DC3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 07:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613461001;
        bh=HcYqW8/qRuo3kSh4HBmRqKKVZrvA9wI0nKwnFND/7Es=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eb7eAeA3BV05Wb/Z+2UfjpMtlj/qV/Ly3mxPD/v9iQrr+56N6vWTTK+Mv6FrtKpOJ
         eBPTb/sZbX9XXpGCRPn87lcpoYJdtQtcHRrEl05HEnOGRI99VAt8JvjISlDOdJ/gVO
         Kau7+gfGtwjnsLbZTadj+vkTTM47dKANWYZqqqyV4xKItQEnJnieTkpRYLeUuh+dcY
         qW7Xj0vY7Rw/8wV6nN6G+QSEDCg9aDz6Re2Cnse/EJUzhvVKLKU5H5g5wipWcqXD6M
         JYFN9N/PklVelRL4mwNI5XJC7gmMe5sVgbFhirR0zDw2p7Wd1CKTxvXd/xgsP+1qiH
         cI4qUKs00V7zA==
Received: by mail-oi1-f177.google.com with SMTP id h17so6417065oih.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 23:36:41 -0800 (PST)
X-Gm-Message-State: AOAM532DZR0zMn9Gb2mLVgq8hUUDkywPW8Xtx+ajDhFe3DUhK67rAlD8
        71brLNVVfnV47+i7NXpIc450TsNhgYD+LvJKZr4=
X-Google-Smtp-Source: ABdhPJxGsfTmY4tueuaxx9cadKNbKIICvQuus4c+2Y+WGUaRCs7tMad57+GGr17En0d7WAgajt08A5qc1qvv4euvVKs=
X-Received: by 2002:aca:307:: with SMTP id 7mr1730193oid.174.1613461000391;
 Mon, 15 Feb 2021 23:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
 <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
 <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com> <1790afff-eebd-1eda-a1b4-0062908f1f32@arm.com>
In-Reply-To: <1790afff-eebd-1eda-a1b4-0062908f1f32@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 16 Feb 2021 08:36:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAF-xhrB=L2UHHqOs6CidcYFbbBud89HiYAzcBminTpA@mail.gmail.com>
Message-ID: <CAMj1kXEAF-xhrB=L2UHHqOs6CidcYFbbBud89HiYAzcBminTpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 at 04:12, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 2/16/21 1:21 AM, Pavel Tatashin wrote:
> > On Mon, Feb 15, 2021 at 2:34 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> On Mon, 15 Feb 2021 at 20:30, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >>>
> >>>> Can't we simply use signed arithmetic here? This expression works fine
> >>>> if the quantities are all interpreted as s64 instead of u64
> >>>
> >>> I was thinking about that, but I do not like the idea of using sign
> >>> arithmetics for physical addresses. Also, I am worried that someone in
> >>> the future will unknowingly change it to unsigns or to phys_addr_t. It
> >>> is safer to have start explicitly set to 0 in case of wrap.
> >>
> >> memstart_addr is already a s64 for this exact reason.
> >
> > memstart_addr is basically an offset and it must be negative. For
> > example, this would not work if it was not signed:
> > #define vmemmap ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
> >
> > However, on powerpc it is phys_addr_t type.
> >
> >>
> >> Btw, the KASLR check is incorrect: memstart_addr could also be
> >> negative when running the 52-bit VA kernel on hardware that is only
> >> 48-bit VA capable.
> >
> > Good point!
> >
> > if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
> >     memstart_addr -= _PAGE_OFFSET(48) - _PAGE_OFFSET(52);
> >
> > So, I will remove IS_ENABLED(CONFIG_RANDOMIZE_BASE) again.
> >
> > I am OK to change start_linear_pa, end_linear_pa to signed, but IMO
> > what I have now is actually safer to make sure that does not break
> > again in the future.
> An explicit check for the flip over and providing two different start
> addresses points would be required in order to use the new framework.

I don't think so. We no longer randomize over the same range, but take
the support PA range into account. (97d6786e0669d)

This should ensure that __pa(_PAGE_OFFSET(vabits_actual)) never
assumes a negative value. And to Pavel's point re 48/52 bit VAs: the
fact that vabits_actual appears in this expression means that it
already takes this into account, so you are correct that we don't have
to care about that here.

So even if memstart_addr could be negative, this expression should
never produce a negative value. And with the patch above applied, it
should never do so when running under KASLR either.

So question to Pavel and Tyler: could you please check whether you
have that patch, and whether it fixes the issue? It was introduced in
v5.11, and hasn't been backported yet (it wasn't marked for -stable)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F13731CC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBPOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhBPOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:35:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:34:42 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id d8so3400061ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 06:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXRiNtgUJwndRsbowN5g0iH/tQxeuxW4thto5ZiApR0=;
        b=I6FNoD27ClHApeRICS8igOg6GXBDMvQQOUo0JtWmU9cfbZ1VwK9cjTUWbH/UitP80T
         3r9frClCF7vjAQVCLpPZNR4AMKEGkdUpLp0AVn0uc5KHkZ4pWqmSvvCyS6dYSTTeOyuH
         3tNgwCN+E7GLYB9nsr2N9JgMXJL9ArV6z9WlBLe/f0w+1MLFzSHGvQf9dVB2fQ2gLIko
         4jSlIKCKh5npaKdy0yqMahIzfe/cE7E92xBe9h6poDXyBgilOPfNAy/Du9WUCHy9CdKN
         Hm1gKYzTwB/Ur0SZltsm2oMh5nJKkBzua4h98S/UHeW/5tk9lyVy5nrzjASJtHKDCwpz
         YRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXRiNtgUJwndRsbowN5g0iH/tQxeuxW4thto5ZiApR0=;
        b=Jgg+shAdPjJyE9Ieo6zAzMVl4n8y93o+t2EEoKl8ocRBCtYWW7kAv4c+hf8ExLdQmP
         FA9/2CAv7TWcCHh5r0QRObeiXN13TFdBtw0D2n1OW460x5nRJUpGgjI4by53I3oqIXC9
         cxayBFqL9B7LTLdvR7NhXkz/NlPluQ3XVuWlryAp2CDTzD3gnpntd/CGheiDG8V+B0i/
         77ZGxhCkAdKNKM7ke6PPUcRjzk5B/eR+roTH6xnOqe6kf6AimkZ+s7QcHglI5dTgK0BL
         2hF1NEGmDxYH485yTvDpNkaCdqm1HInYtl7rOgMvhuFs+7lwJda16b4lASlmC6pz1h31
         D22Q==
X-Gm-Message-State: AOAM532gbRvL+s/vUyj3A+Hy2y21mAsWCcJ2NKnDla9AqWILtbhPwWBJ
        ugk9cpGCAmWVpyXEv+SqZ8+puiI0htQnwh2i+j91ncThN4H57oLE
X-Google-Smtp-Source: ABdhPJxe3JZquTx8iHbeMFUWrLTUhi6f8WF2y20pflxVUJtnIevMkkDU3HlZTBVF9ifTC1Q1+s3IRsO+xfX1eg1R3hY=
X-Received: by 2002:a17:906:28cc:: with SMTP id p12mr437289ejd.426.1613486080796;
 Tue, 16 Feb 2021 06:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
 <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
 <CA+CK2bDJ7Y2-vEpZrZ0fzigAfDgcJOmjhmin_GjTqioYXAYB3Q@mail.gmail.com>
 <1790afff-eebd-1eda-a1b4-0062908f1f32@arm.com> <CAMj1kXEAF-xhrB=L2UHHqOs6CidcYFbbBud89HiYAzcBminTpA@mail.gmail.com>
In-Reply-To: <CAMj1kXEAF-xhrB=L2UHHqOs6CidcYFbbBud89HiYAzcBminTpA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 16 Feb 2021 09:34:04 -0500
Message-ID: <CA+CK2bBMoAQy=AB7N7G5AzWR5kpUXRGBwTowrJkB-4CmD1qQyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
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

On Tue, Feb 16, 2021 at 2:36 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 16 Feb 2021 at 04:12, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> >
> >
> > On 2/16/21 1:21 AM, Pavel Tatashin wrote:
> > > On Mon, Feb 15, 2021 at 2:34 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >>
> > >> On Mon, 15 Feb 2021 at 20:30, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> > >>>
> > >>>> Can't we simply use signed arithmetic here? This expression works fine
> > >>>> if the quantities are all interpreted as s64 instead of u64
> > >>>
> > >>> I was thinking about that, but I do not like the idea of using sign
> > >>> arithmetics for physical addresses. Also, I am worried that someone in
> > >>> the future will unknowingly change it to unsigns or to phys_addr_t. It
> > >>> is safer to have start explicitly set to 0 in case of wrap.
> > >>
> > >> memstart_addr is already a s64 for this exact reason.
> > >
> > > memstart_addr is basically an offset and it must be negative. For
> > > example, this would not work if it was not signed:
> > > #define vmemmap ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
> > >
> > > However, on powerpc it is phys_addr_t type.
> > >
> > >>
> > >> Btw, the KASLR check is incorrect: memstart_addr could also be
> > >> negative when running the 52-bit VA kernel on hardware that is only
> > >> 48-bit VA capable.
> > >
> > > Good point!
> > >
> > > if (IS_ENABLED(CONFIG_ARM64_VA_BITS_52) && (vabits_actual != 52))
> > >     memstart_addr -= _PAGE_OFFSET(48) - _PAGE_OFFSET(52);
> > >
> > > So, I will remove IS_ENABLED(CONFIG_RANDOMIZE_BASE) again.
> > >
> > > I am OK to change start_linear_pa, end_linear_pa to signed, but IMO
> > > what I have now is actually safer to make sure that does not break
> > > again in the future.
> > An explicit check for the flip over and providing two different start
> > addresses points would be required in order to use the new framework.
>
> I don't think so. We no longer randomize over the same range, but take
> the support PA range into account. (97d6786e0669d)
>
> This should ensure that __pa(_PAGE_OFFSET(vabits_actual)) never
> assumes a negative value. And to Pavel's point re 48/52 bit VAs: the
> fact that vabits_actual appears in this expression means that it
> already takes this into account, so you are correct that we don't have
> to care about that here.
>
> So even if memstart_addr could be negative, this expression should
> never produce a negative value. And with the patch above applied, it
> should never do so when running under KASLR either.
>
> So question to Pavel and Tyler: could you please check whether you
> have that patch, and whether it fixes the issue? It was introduced in
> v5.11, and hasn't been backported yet (it wasn't marked for -stable)

97d6786e0669d
arm64: mm: account for hotplug memory when randomizing the linear region

Does not address the problem that is described in this bug. It only
addresses the problem of adding extra PA space to the linear map which
is indeed needed (btw is it possible that hot plug is going to add
below memblock_start_of_DRAM(), because that is not currently
accounted) , but not the fact that a linear map can start from high
addresses because of randomization. I have verified that in QEMU, and
Tyler verified it on real hardware backporting it to 5.10, the problem
that this patch fixes is still there.

Pasha

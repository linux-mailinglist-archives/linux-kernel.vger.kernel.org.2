Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0E441D72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhKAPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhKAPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:35:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3456C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:32:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so65998673edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CN8rQ1tRxeXIpx3jQunjqqrNjS826z1bdP3f36w4Lmc=;
        b=E3z1G6+rXmLBTcUCEqna/tuPLpo7fQbax/jJAq51voPIued0ebctyXesnEDJyedqe0
         B3vApk1aqq1mW3FMTHaXpNrpeX63SmVWjLnv/ghtdm46WN0W0Fz/VVeVFtB6+N/WCIJ0
         VMWpTqU10VHUp0Dtzgh/QRKVZzNJ6FrdKViIZe75HFsTGTo8dRvxkuLKaoVBJGFtttId
         IcFSbAWXtptga7Gia+JapGySXbmulnW1xxh0uzgpkwCTSdyB/Gb7vMkfdeJ4dKsQKR62
         F6tXJs06vlMlvRqdnkvJtkLJwq8OqzEjSCwSeLJGD5xIaCIZMTAr9dGZL6ASKUivzo2z
         Zqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CN8rQ1tRxeXIpx3jQunjqqrNjS826z1bdP3f36w4Lmc=;
        b=23aEafPUTagif4QdI6fGtR8wgCo5mBlOPwU3a1XsBHgfTv/4PoCW/tJuZFEBNx90ep
         Lk7mUj+cNsPpZ+VW0fd5kyYuuwsW7DrV543UzuXuOUf9y9KYgwmrMxUy4gtu11jsP+Zn
         c3cWbUJVoXzTMCDrqA84A4987FSKd5aQ1FESNME2lE/HmBN+B/belbxMNYAn8aT5rS6L
         X/6I/ca5uyWvSCRlin5bDE1CpYkq9oW4aNBxAYUCwX5RMC5KOvouFvnPivNABUGR9V6/
         5q7GRnix9DXVJ1dE4dIVVPT+NW4DooWdXsXlQDjbqrnD5FuYuT8U5sjifjLCaksWPqcz
         GBOg==
X-Gm-Message-State: AOAM531U1rQV+d5tk8/8D1CMKxa4dWP556vkjXb1QvQl54MlBT76XXU/
        6BsfNO+rQ5iJzp8aKFa30pMdofOmzwBfPTRVL3TI0w==
X-Google-Smtp-Source: ABdhPJxlap7LRxTrSRvjY8lTA/SiUFKR9WcJC/LnAtRi/RCXGvMgRMJKHeuKplgfc3q8qm6aH0J1juUwGiL/w/nuq6o=
X-Received: by 2002:a17:906:9601:: with SMTP id s1mr38619975ejx.68.1635780762250;
 Mon, 01 Nov 2021 08:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211029113023.760421-1-arnd@kernel.org> <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
 <YXw4H2BNx85KnLDh@arm.com> <20211101090143.GA27181@willie-the-truck>
 <db9bb430-4502-0c46-d8d7-ddb236750499@arm.com> <20211101094045.GB27400@willie-the-truck>
 <55cc7816-cc7a-3161-71cc-0c969ec131a2@arm.com> <YX/LymZ5ZwNbtjUp@kroah.com>
In-Reply-To: <YX/LymZ5ZwNbtjUp@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 1 Nov 2021 09:32:29 -0600
Message-ID: <CANLsYkyQssRivPCPJQf11UeUwp089byhpB1MvoGy50r3Yz+ULQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: export this_cpu_has_cap
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2021 at 05:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 01, 2021 at 09:52:22AM +0000, Suzuki K Poulose wrote:
> > On 01/11/2021 09:40, Will Deacon wrote:
> > > On Mon, Nov 01, 2021 at 09:34:08AM +0000, Suzuki K Poulose wrote:
> > > > On 01/11/2021 09:01, Will Deacon wrote:
> > > > > On Fri, Oct 29, 2021 at 07:06:23PM +0100, Catalin Marinas wrote:
> > > > > > On Fri, Oct 29, 2021 at 02:31:23PM +0100, Suzuki K Poulose wrote:
> > > > > > > On 29/10/2021 12:30, Arnd Bergmann wrote:
> > > > > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > > > > >
> > > > > > > > It's now used in a coresight driver that can be a loadable module:
> > > > > > > >
> > > > > > > > ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> > > > > > > >
> > > > > > > > Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
> > > > > > >
> > > > > > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > > > > Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > > > >
> > > > > > > Will, Catalin, Mathieu,
> > > > > > >
> > > > > > > Do you have a preference on how this fix can be pulled in ? This may
> > > > > > > be safe to go via coresight tree if it is not too late. Otherwise,
> > > > > > > it could go via the arm64 tree.
> > > > > >
> > > > > > I think Will already closed/tagged the arm64 tree for the upcoming
> > > > > > merging window, though he could take it as a fix afterwards.
> > > > > >
> > > > > > If it doesn't conflict with the arm64 for-next/core, it's fine by me to
> > > > > > go through the coresight tree.
> > > > > >
> > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > > ---
> > > > > > > > Not sure if we actually want this to be exported, this is my local
> > > > > > > > workaround for the randconfig build bot.
> > > > > > > > ---
> > > > > > > >     arch/arm64/kernel/cpufeature.c | 1 +
> > > > > > > >     1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > > > > > > index ecbdff795f5e..beccbcfa7391 100644
> > > > > > > > --- a/arch/arm64/kernel/cpufeature.c
> > > > > > > > +++ b/arch/arm64/kernel/cpufeature.c
> > > > > > > > @@ -2864,6 +2864,7 @@ bool this_cpu_has_cap(unsigned int n)
> > > > > > > >           return false;
> > > > > > > >     }
> > > > > > > > +EXPORT_SYMBOL(this_cpu_has_cap);
> > > > > >
> > > > > > EXPORT_SYMBOL_GPL? I think this_cpu_has_cap() is a bit more more
> > > > > > specialised than cpus_have_const_cap().
> > > > > >
> > > > > > With that:
> > > > > >
> > > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > >
> > > > > Yes, at this stage I think it's best for this to go via the Coresight tree.
> > > > > So with the _GPL export:
> > > > >
> > > > > Acked-by: Will Deacon <will@kernel.org>
> > > > >
> > > > > If that doesn't work for some reason, I can take it next week after the
> > > > > initial arm64 queue has been merged. Please just let me know.
> > > >
> > > > As I understand correctly, this will now need to go via arm64 tree. The
> > > > CoreSight tree changes are pulled into Greg's tree and the next it will
> > > > happen is for the next release. Usually the fixes don't end up there
> > > > during the -rc cycles. So, I believe it is better if this goes via
> > > > arm64.
> > >
> > > Hmm, are you saying that Coresight drivers don't receive fixes outside of
> > > the merge window? That sounds sub-optimal...
> >
> > Unfortunately thats how it works today. We should fix this.
> >
> > Mathieu, Greg,
> >
> > Do you have any thoughts on how to address this ?
>
> What?  That's crazy, if there are bugfixes needed of course I would take
> them during the -rc cycle, that is explicitly what it is there for!

I have sent patches to the char-misc tree several times during -rc
cycles.  As Greg points out, proceeding otherwise would not make
sense.

>
> It's up to the maintainer of the subsystem to send me the fixes to get
> into the -final kernel release, I don't pick them up on my own unless
> asked to by them.
>

I will send a pull request for this when I receive another patch with
Catalin's annotation and collected RB tags.

> thanks,
>
> greg k-h

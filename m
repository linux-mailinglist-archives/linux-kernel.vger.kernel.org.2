Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64973ADAEE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhFSQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 12:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234001AbhFSQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 12:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624120736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbiqFTgyr2qVT+KslDN1kNwhH+ycxPPZqgEd38hPDCM=;
        b=A8A4E+b+TRWZtF0YOCmpsdalgUoCU1XEG1zkyPVEjX0ZfFKPvVOx5esZlXdnqzB1HYvugr
        Gyd1gZhjm1++XGknuit61N/CEfHfjieoSsRsotYEbMm3gT/Ln+5YRwB9JSklA/0i+kAUeg
        06Z6noADfWCSKnUfUcm/yN2vKpv1FcU=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-DCFJKPTtMhuc6RogAkxsfA-1; Sat, 19 Jun 2021 12:38:55 -0400
X-MC-Unique: DCFJKPTtMhuc6RogAkxsfA-1
Received: by mail-vs1-f70.google.com with SMTP id e25-20020a67e1990000b0290272d600a2fbso380585vsl.21
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 09:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbiqFTgyr2qVT+KslDN1kNwhH+ycxPPZqgEd38hPDCM=;
        b=h/Nf3ZByaagJv5GbGE090gAKdVH1agEjgfDG8wn2nBDkDIvrnBaSaeS833lsDdEESp
         rAxnFJlSoOgfjGILgpfT9a5lLGASXDxSto665rNsObtD1VGRJyyROn19VRK1E2Iv0mC5
         FP1ZKqrVnpbr5Wcr968jbjEZuPySukQ9SFFovjfGPu1Zxx5qBC7gdNREnW/nvIYWHN7L
         9J9EMAbHMXUAQKT42GTUq/cs9VNVKsp3//gFpvunvfA4v33EU7njVguKSth9wosVJUBB
         FGfKDHun5e3yIrwwOLHcvilFmUpCVVOPXKv3d0krpJQjeiSIt+iLhmP7M2PMB+bapcTZ
         ISdg==
X-Gm-Message-State: AOAM532ugcMFVnOFSQ7alZCEVAsxcO9rxSGGRrMRiKqisEks2d+/b1cE
        FhjVK9PsyIbk/n2US4++txKR3s66TQZGN8rtEdzq/J4Ud8wB+26NEEKCNl18feNGi0HYq7Ecw9+
        nJLqbOYyqZ+2HZTFWh17Z5Zh/Ra3BdneRqEjelAqT
X-Received: by 2002:a9f:3743:: with SMTP id a3mr17091672uae.92.1624120734998;
        Sat, 19 Jun 2021 09:38:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzehFfaaWYP9AWbBh706kWIK3vDxHR8P63KwuLiGoF8f6zf2ocIjKEwad+AacB+2euZypvQBA1RlQJ2pGyN8iA=
X-Received: by 2002:a9f:3743:: with SMTP id a3mr17091644uae.92.1624120734773;
 Sat, 19 Jun 2021 09:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com> <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com> <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com> <20210616173646.GA1840163@nvidia.com>
 <CA+kK7ZijdNERQSauEvAffR7JLbfZ512na2-9cJrU0vFbNnDGwQ@mail.gmail.com>
 <20210618140554.GD1002214@nvidia.com> <CA+kK7ZhJ8+BhLZeZ5XtL2M_qDpOo823taFbM45DTV=H6L1EvhQ@mail.gmail.com>
In-Reply-To: <CA+kK7ZhJ8+BhLZeZ5XtL2M_qDpOo823taFbM45DTV=H6L1EvhQ@mail.gmail.com>
From:   Jon Masters <jcm@redhat.com>
Date:   Sat, 19 Jun 2021 12:38:44 -0400
Message-ID: <CA+kK7ZhaqWrEkRzGrOtLwbs1fiyXAeztKy9P6-LgJx_GAWevtw@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Eric Brower <ebrower@nvidia.com>, Grant.Likely@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P.S. Note that you shouldn't have to do any of the below because this
is exactly what someone should be sitting on Cadence and Synopsys for
until they do it correctly in licenseable IP that just does the right
thing. A real RC as a unit. No more root ports and vendors having to
hack it together. If we want to solve the actual problem, then that is
the actual problem.

Ok, off my hobby horse ;)

On Sat, Jun 19, 2021 at 12:34 PM Jon Masters <jcm@redhat.com> wrote:
>
> Hi Jason,
>
> On Fri, Jun 18, 2021 at 10:06 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Jun 18, 2021 at 09:21:54AM -0400, Jon Masters wrote:
> > >    Hi Jason,
> > >    On Wed, Jun 16, 2021 at 1:38 PM Jason Gunthorpe <[1]jgg@nvidia.com>
> > >    wrote:
> > >
> > >      On Thu, Mar 25, 2021 at 01:12:31PM +0000, Lorenzo Pieralisi wrote:
> > >      However, in modern server type systems the PCI config space is often
> > >      a
> > >      software fiction being created by firmware throughout the PCI
> > >      space. This has become necessary as the config space has exploded in
> > >      size and complexity and PCI devices themselves have become very,
> > >      very
> > >      complicated. Not just the config space of single devices, but even
> > >      bridges and topology are SW created in some cases.
> > >      HW that is doing this is already trapping the config cycles somehow,
> > >      presumably with some very ugly way like x86's SMM. Allowing a
> > >      designed
> > >      in way to inject software into the config space cycles does sound a
> > >      lot cleaner and better to me.
> > >
> > >    This is not required. SMM is terrible, indeed. But we don't have to
> > >    relive it in Arm just because that's [EL3] the easy place to shove
> > >    things :)
> >
> > "This is not required"? What does that mean?
>
> It's not required to implement platform hacks in SMM-like EL3. The
> correct place to do this kind of thing is behind the scenes in a
> platform microcontroller (note that I do not necessarily mean Arm's
> SCP approach, you can do much better than that).
>
> > >      For instance it may solve other pain points if ARM systems had a
> > >      cheap
> > >      way to emulate up a "PCI device" to wrapper around some IP blob on
> > >      chip. The x86 world has really driven this approach where everything
> > >      on SOC is PCI discoverable, and it does seem to work well.
> > >      IMHO SW emulation of config space is an important ingredient to do
> > >      this.
> > >
> > >    There are certainly ways to build PCI configuration space in a
> > >    programmable way that does not require software trapping into
> > >    MM.
> >
> > Can you elaborate on what you'd like to see here? Where do you want to
> > put the software then?
>
> There are places other than EL3 where this should live. It should not
> involve the AP at all in a correct configuration. It should (only)
> appear to be done in hardware, but where you do it is up to an
> implementation. Doing it correctly also accounts for others accessing
> configuration space simultaneously. You don't want to have to stop the
> world, or break PCI ordering semantics on access. There is a right way
> (hardware) to do this, and a wrong way (EL3 hacks). But I'll leave
> folks to figure out how to implement it. There are several possible
> approaches to do this.
>
> > >    I strongly agree with the value of an industry standard approach
> > >    to this in hardware, particularly if the PCIe vendors would offer
> > >    this as IP.  In a perfect world, ECAM would simply be an
> > >    abstraction and never directly map to fixed hardware, thus one
> > >    could correct defects in behavior in the field. I believe on the
> > >    x86 side of the house, there is some interesting trapping support
> > >    in the LPC/IOH already and this is absolutely what Arm should be
> > >    doing.
> >
> > AFAIK x86 has HW that traps the read/writes to the ECAM and can
> > trigger a FW flow to emulate them, maybe in SMM, I don't know the
> > details. It ceratinly used to be like this when SMM could trap the
> > config space io read/write registers.
>
> They trap to something that isn't in SMM, but it is in firmware. That
> is the correct (in my opinion) approach to this. It's one time where
> I'm going to say that all the Arm vendors should be doing what Intel
> is doing in their implementation today.
>
> > Is that what you want to see for ARM? Is that better than a SMC?
>
> Yes, because you preserve perfect ECAM semantics and correct it behind
> the scenes. That's what people should be building.
>
> > That is alot of special magic hardware to avoid a SMC call...
>
> And it's the correct way to do it. Either that, or get ECAM perfect up
> front and do pre-si testing under emulation to confirm.
>
> </opinion>
>
> Jon.


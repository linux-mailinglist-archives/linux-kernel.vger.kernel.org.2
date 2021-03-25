Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E062349B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCYVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230467AbhCYVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616706773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GWG62i2UZUo8ua5XusiVhjktb0103ycitfGwTI3taRk=;
        b=BbFVMeEBB1U1FyVFDGR3NB+FRLwvj3PXd7JjkagCyD8VHJfwCmC3h8lOiocRm+Ye0ttWLu
        YdB2rbf3WT4wII9MOccnnyYtcArJ6+2dwLwLkgywRER0ayoio3rvitq0zGbUki1ulHvaEz
        jEdx+K0uNKn9mJBKVcM5AA2d9Kmml9E=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-lva6-wLCNa2RmHsduXZcKg-1; Thu, 25 Mar 2021 17:12:48 -0400
X-MC-Unique: lva6-wLCNa2RmHsduXZcKg-1
Received: by mail-ua1-f70.google.com with SMTP id i90so1992999uad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GWG62i2UZUo8ua5XusiVhjktb0103ycitfGwTI3taRk=;
        b=UkOZMFwYm9DYFaAScAoTBG7S14Vq94BnnfxXNOziz7jOHLU0DIO/fko2l/K2ZjJyFg
         ywXMpPM9ClVIHiP1LoIWUplIFgBqgwwLMNfcEiYA1adSxqrTgFCMLGP3a6N/G1AMswQK
         Al8qtxJ6wT1Jl6J9G+E7LHWqfUmfESgdhQBSsc1q+rEEngVrmFic7ty06Wg1i1McE7QF
         Xr0eZVwnxvdREBRDZNz+x/b6MRyo2UnDOBia2DuFijMLZd/iMqqR5u54D1E244boABbx
         s0stqALDxg8/V0XsL7BGgIkAli8sI4bRFF12p0PcDf9nuQbBu0luONie1O5OYmYUlv9V
         OhOA==
X-Gm-Message-State: AOAM530hoXNvjdcujKBDdIxJYJk7MrLi+Tj/k9c4k+f2ExR6KSvSJ+l8
        7EO0wHxmadwr99k03vq82oPKcfcN1mm5o6NoQvBGUU5TBlhfzjQgfu9bA6PyQq+zSWs25i5ighj
        dEgw0Q6vPujkRUprdE1cdKD6WZYSkdsSS+Eg3kBUx
X-Received: by 2002:ab0:608e:: with SMTP id i14mr6348288ual.92.1616706767532;
        Thu, 25 Mar 2021 14:12:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXoT6sMJKhKxYG0uLG8tKxKgRpQ7swSQHje5erIKKsFPTkJAOwmC6qs9temFDCaKGJDlppAY5zSQRdXdZzN/c=
X-Received: by 2002:ab0:608e:: with SMTP id i14mr6348271ual.92.1616706767335;
 Thu, 25 Mar 2021 14:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck> <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com> <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com> <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com> <CAPv3WKcgZ9aEx7s6keWMssGefYH=rtdxSp5eiBVibtjY=sctpg@mail.gmail.com>
In-Reply-To: <CAPv3WKcgZ9aEx7s6keWMssGefYH=rtdxSp5eiBVibtjY=sctpg@mail.gmail.com>
From:   Jon Masters <jcm@redhat.com>
Date:   Thu, 25 Mar 2021 17:12:36 -0400
Message-ID: <CA+kK7Ziz+k5iJjBT8BuUDCCfCB5eat+SUYXNV+fH3UN2DLRRXA@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>, vidyas@nvidia.com,
        Thierry Reding <treding@nvidia.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Eric Brower <ebrower@nvidia.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcin,

Many thanks for your thoughtful, heartfelt response, and I don't
disagree with your sentiments.

The truth is that we have a messy situation. As a collective community
of people who are passionate about the success of Arm in general
purpose systems, I know many who would share my personal feeling that
this is all beyond very unfortunate. That other architecture has
working, robust, PCI IP that adheres to standards (more or less)
correctly. There is no reason we can't either. But it takes a
collective industry wide effort, alongside leadership from Arm (and
others) to push things forward. I'm very impressed with where
SystemReady is headed and there are great people behind making that
happen. So I have faith that things will improve. Now is a good time
to unite as an industry behind improving both the status quo (quirks)
and future IP so that it is properly compliant. My opinion is that now
is not a good moment to rework entirely how we do PCI enumeration to
use an alternative scheme.

Please see the below for more.

On Thu, Mar 25, 2021 at 4:45 PM Marcin Wojtas <mw@semihalf.com> wrote:

> So what we have after 4 years:
> * Direct convincing of IP vendors still being a plan.

Things need to improve here. I've *expressed* as much to certain folks
around the industry. I'm not afraid to get more vocal. There is too
much IP out there even now that is doing inexcusably non-compliant
things. When I would talk to these vendors they didn't seem to take
standards compliance seriously (to any standard) because they're used
to making some BSP for some platform and nobody has stood thoroughly
over them to the point of extreme discomfort so that they change their
approach. It is now past time that we stand over these folks and get
them to change. I am not afraid to get much more intense here in my
approach and I would hope that others who feel similarly about
standardization would also choose to engage with extreme vigor.
Extreme vigor. It must become an extreme embarrassment for any of them
to continue to have any IP that claims to be "PCI" which is....not
PCI.

> * Reverting the original approach towards MCFG quirks.
> * Double-standards in action as displayed by 2 cases above.

The truth is we've had an inconsistent approach. But an understandable
one. It's painful to take quirks. I am grateful that the maintainers
are willing to consider this approach now in order to get to where we
want to be, but I completely understand the hesitance in the past.
Along with the above, we all need to do all we can to ensure that
quirks are an absolute last resort. It's one thing to have a corner
case issue that couldn't be tested pre-silicon, but there is *no
excuse* in 2021 to ever tape out another chip that hasn't had at least
a basic level of ECAM testing (and obviously it should be much more).
Emulation time should catch the vast majority of bugs as real PCIe
devices are used against a design using speed bridges and the like.
There's no excuse not to test. And frankly it boggles my mind that
anyone would think that was a prudent way to do business. You can have
every distro "just work" by doing it right, or you can have years of
pain by doing it wrong. And too many still think the BSP hack it up
model is the way to go. We ought to be dealing predominantly with the
long tail of stuff that is using obviously busted IP that was already
baked. We can use quirks for that. But then they need to go away and
be replaced with real ECAM that works on future platforms.

> I'm sorry for my bitter tone, but I think this time could and should
> have been spent better - I doubt it managed to push us in any
> significant way towards wide fully-standard compliant PCIE IP
> adoption.

Truthfully there will be some parts of the Arm story that will be
unpleasant footnotes in the historical telling. How we haven't moved
the third party IP vendors faster is a significant one. I think we
have a chance to finally change that now that Arm is gaining traction.
I am very sad that some of the early comers who tried to do the right
thing had to deal with the state of third party IP at the time.

Jon.


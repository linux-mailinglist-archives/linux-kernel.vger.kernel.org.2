Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E999B3F5952
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhHXHqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:46:34 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33116
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234618AbhHXHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:46:32 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 03:46:32 EDT
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7527D4075F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629790789;
        bh=Zuyxk19zELEDrtZ5P5c0Ms+6wi23L0zn72ao5lHm2JE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=s2RuUrw1t8LKgkxv/v054KXpyTrapFip5hH8Qx0E9Ir8xtqhCkOwsXIBGpKyMU2iE
         Frk52A6tCkjqRK96OAgEYGlmcs5FwNqUu1Iv806vFnoMCO03rdvE5ljz6x8EApDaWb
         NMi/gL9W5ZSd4nXO2KL68+Ih40TbLJbb0Pw8W62gq3b+3T5LqGunFSe0tq3evvu4Jx
         j68ehQant5gzP0VHdvE2PTyY//pwbmdcdjcgmi0YtJI6d0fPgc0zyJ0kmAzmss3j1N
         yCL+BXpkWFQvx1bEu6Ejssk4/QagO1wKjRu4wC93Qcl0O/jJU38R5NvXNssvc5Fhjr
         uwyBWz2t1eaPg==
Received: by mail-ed1-f72.google.com with SMTP id s25-20020a50d499000000b003c1a8573042so4389737edi.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zuyxk19zELEDrtZ5P5c0Ms+6wi23L0zn72ao5lHm2JE=;
        b=I2ChSl8CSdOqnj2icg7sYP5wzR4C9aI9vhRfx5BpOldSzKfYUlfX2CQhh7ZYfXBwKn
         uYBJdH1jLyJ1lo/nTprn9Fc255snL3mCGK7RPOSpCWk6f2IQiLARwU+EprxjvInh5G9h
         kd9p6uoRWodxy8JRzybKdnJYAlpydPlRZ5iFLEPh6kL+GfSxPBdCn92Bha2iXJp0ukDH
         YCzSfxBr01ZiWZWSzmkab/K2ou2wHiVeFl+zJtobftvoo54zG5i9v/VS+x4HkPnNjXNv
         +riLS0ZI8PDKB1MObF4Zbnr2430Pmk55rVZ1b0rdrypE1hDRChTSeN9Xq8a27brAH4wf
         rMOQ==
X-Gm-Message-State: AOAM531Q4lnC+HA4NqrTJ45/8FR7AacBm2x3v/iSpGPnl4qr72Bd+Cjj
        +cCpqV2CthE3SBeFkawjA5AwNkHT0KwaP7C/HU6My61EU+ykOg2VitmCMYekT58rzS1P8YfVZuc
        209w8nt1sq77+rjgftDql8ywvj3yqB/R9lSgBRZvyeCjSsxxHBXyHrn+Npw==
X-Received: by 2002:a17:906:6d9:: with SMTP id v25mr40563799ejb.192.1629790787675;
        Tue, 24 Aug 2021 00:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfAMy5028gDLZFF3NX7qVJxB/Bfu0IQnN2gB92EDHCsxshcZq4TLviWQfhAzi0O6ddx0dG4313iHbhciyccj8=
X-Received: by 2002:a17:906:6d9:: with SMTP id v25mr40563778ejb.192.1629790787402;
 Tue, 24 Aug 2021 00:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <9ebf8fa1-cbd4-75d6-1099-1a45ca8b8bb0@gmail.com> <20210820210309.GA3357515@bjorn-Precision-5520>
In-Reply-To: <20210820210309.GA3357515@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 24 Aug 2021 15:39:35 +0800
Message-ID: <CAAd53p5KH69NPMejM93STx3J+0WNBuXzaheWJJoURM39=DLvxg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] r8169: Implement dynamic ASPM mechanism
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 5:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Aug 19, 2021 at 05:45:22PM +0200, Heiner Kallweit wrote:
> > On 19.08.2021 13:42, Bjorn Helgaas wrote:
> > > On Thu, Aug 19, 2021 at 01:45:40PM +0800, Kai-Heng Feng wrote:
> > >> r8169 NICs on some platforms have abysmal speed when ASPM is enabled.
> > >> Same issue can be observed with older vendor drivers.
> > >
> > > On some platforms but not on others?  Maybe the PCIe topology is a
> > > factor?  Do you have bug reports with data, e.g., "lspci -vv" output?
> > >
> > >> The issue is however solved by the latest vendor driver. There's a new
> > >> mechanism, which disables r8169's internal ASPM when the NIC traffic has
> > >> more than 10 packets, and vice versa.
> > >
> > > Presumably there's a time interval related to the 10 packets?  For
> > > example, do you want to disable ASPM if 10 packets are received (or
> > > sent?) in a certain amount of time?
> > >
> > >> The possible reason for this is
> > >> likely because the buffer on the chip is too small for its ASPM exit
> > >> latency.
> > >
> > > Maybe this means the chip advertises incorrect exit latencies?  If so,
> > > maybe a quirk could override that?
> > >
> > >> Realtek confirmed that all their PCIe LAN NICs, r8106, r8168 and r8125
> > >> use dynamic ASPM under Windows. So implement the same mechanism here to
> > >> resolve the issue.
> > >
> > > What exactly is "dynamic ASPM"?
> > >
> > > I see Heiner's comment about this being intended only for a downstream
> > > kernel.  But why?
> > >
> > We've seen various more or less obvious symptoms caused by the broken
> > ASPM support on Realtek network chips. Unfortunately Realtek releases
> > neither datasheets nor errata information.
> > Last time we attempted to re-enable ASPM numerous problem reports came
> > in. These Realtek chips are used on basically every consumer mainboard.
> > The proposed workaround has potential side effects: In case of a
> > congestion in the chip it may take up to a second until ASPM gets
> > disabled, what may affect performance, especially in case of alternating
> > traffic patterns. Also we can't expect support from Realtek.
> > Having said that my decision was that it's too risky to re-enable ASPM
> > in mainline even with this workaround in place. Kai-Heng weights the
> > power saving higher and wants to take the risk in his downstream kernel.
> > If there are no problems downstream after few months, then this
> > workaround may make it to mainline.
>
> Since ASPM apparently works well on some platforms but not others, I'd
> suspect some incorrect exit latencies.

Can be, but if their dynamic ASPM mechanism can workaround the issue,
maybe their hardware is just designed that way?

>
> Ideally we'd have some launchpad/bugzilla links, and a better
> understanding of the problem, and maybe a quirk that makes this work
> on all platforms without mucking up the driver with ASPM tweaks.

The tweaks is OS-agnostic and is also implemented in Windows.

>
> But I'm a little out of turn here because the only direct impact to
> the PCI core is the pcie_aspm_supported() interface.  It *looks* like
> these patches don't actually touch the PCIe architected ASPM controls
> in Link Control; all I see is mucking with Realtek-specific registers.

AFAICT, Realtek ethernet NIC and wireless NIC both have two layers of
ASPM, one is the regular PCIe ASPM, and a Realtek specific internal
ASPM.
Both have to be enabled to really make ASPM work for them.

Kai-Heng

>
> I think this is more work than it should be and likely to be not as
> reliable as it should be.  But I guess that's up to you guys.
>
> Bjorn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7537A705
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhEKMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:48:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhEKMsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:48:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 278BF61921;
        Tue, 11 May 2021 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620737221;
        bh=2dH1hIl6jMgbKTHKZnDTKRaPqpS64U0At1Tgchy3nhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3MquA1+V2V6DvmcLtComF1IGrNKJIODby1wB1LFRMa2Wg4vBDqSwsZFsGa1Wr5A+
         feVnJYaph+ZSXCYgd0FR0Ec9yDjjJVJj3euSzOuEyhoMmNNsZj51Z/RZt8OTyPpufj
         n+qiwg4e75pSaKgNGscm0G9oiaA2AMZrhjnQjx2ATByZu5qsEKDNWOFNmEtk8Td6lR
         lcUCiXDpuBRLbYZjsgzVkd50Aq8bxtHqbFy74zfCzuYbTH9lEO+8dY/ooQ31hqI539
         z6MVMfscdh0BbMWwuK6pW9d+GDqhimjdfjfRqy5Yu5XuRoaVo9xqjbxzvZAx3Lkdfl
         Z7utSY9ycTHpQ==
Received: by mail-ot1-f41.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so17336978otf.12;
        Tue, 11 May 2021 05:47:01 -0700 (PDT)
X-Gm-Message-State: AOAM532EmuQjK0jPxYsgIdpdmue8HkIIMJTVPE+8K1k4BWKN1hNXuidz
        46rBCd2vnPbVDK0GbyzVFmrWLNDuVRR0Zs9Pmtc=
X-Google-Smtp-Source: ABdhPJz/xTvZ8CTrGXJPpA9elI1bWyfMlv3pMALsNA2kK+26+wfIsbZwJvDcqeTE0b7k5gvBfgJL/TZ6GwadeyF2GVY=
X-Received: by 2002:a05:6830:4da:: with SMTP id s26mr25743193otd.77.1620737220278;
 Tue, 11 May 2021 05:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210511021656.17719-1-ansuelsmth@gmail.com> <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
 <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain> <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
 <YJp1WYTXHsSAA0ES@Ansuel-xps.localdomain> <CAMj1kXHoc283aHT2EjxyRe8_cTWn_SUGoVLNKJ+40ia8Fppynw@mail.gmail.com>
 <YJp6mbJRMlN5yFC7@Ansuel-xps.localdomain>
In-Reply-To: <YJp6mbJRMlN5yFC7@Ansuel-xps.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 May 2021 14:46:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFDY0Go9yDXAfAiN8pm-q0qGSYaWNw0LVw044ErZ0zKvQ@mail.gmail.com>
Message-ID: <CAMj1kXFDY0Go9yDXAfAiN8pm-q0qGSYaWNw0LVw044ErZ0zKvQ@mail.gmail.com>
Subject: Re: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 14:37, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 02:30:36PM +0200, Ard Biesheuvel wrote:
> > On Tue, 11 May 2021 at 14:15, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > >
> > > On Tue, May 11, 2021 at 06:26:28AM +0200, Ard Biesheuvel wrote:
> > > > On Tue, 11 May 2021 at 04:32, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > On Tue, May 11, 2021 at 03:24:29AM +0100, Matthew Wilcox wrote:
> > > > > > On Tue, May 11, 2021 at 04:16:54AM +0200, Ansuel Smith wrote:
> > > > > > > Ipq8064 SoC requires larger IO_SPACE_LIMIT on second and third pci port.
> > > > > >
> > > > > > Do you really?  I mean, yes, theoretically, I understand it, the
> > > > > > hardware supports 64kB of I/O port space per root port.  But I/O
> > > > > > port space is rather deprecated these days.  My laptop has precisely
> > > > > > two devices with I/O ports, one with 64 bytes and the other with 32
> > > > > > bytes.  Would you really suffer by allocating 16kB of I/O port
> > > > > > space to each root port?
> > > > >
> > > > > We were talking about this in the other wrong patch. I also think this
> > > > > much space looks wrong. The current ipq806x dts have this space so it's
> > > > > actually broken from a long time. The only reason pci worked before was
> > > > > because the pci driver didn't actually check if the settings were right.
> > > > > New kernel introduced more checks and this problem showed up. (to be
> > > > > more precise, the pci port are commonly used by the ath10k wifi and the
> > > > > second ath10k wifi fails to init because of this problem)
> > > > > If you can give me any hint on how to check if the space can be reduced
> > > > > I would be very happy to investigate it.
> > > > > In the driver I notice that the max buffer is set to 2k, could be this a
> > > > > hint?
> > > > >
> > > >
> > > > Could you share the output of lspci -vv from such a system?
> > > >
> > > > I agree with Matthew that fiddling with the size of the I/O space
> > > > range probably papers over another problem, and with the odd
> > > > exception, no PCIe card used on ARM systems actually uses their I/O
> > > > BARs, even when they have them. (I used to carry a PCIe serial port
> > > > card to UEFI plugfests because that was the only thing that would stop
> > > > working if a system configured its I/O resource window incorrectly)
> > >
> > > Here is the output of lspci -vv
> > >
> > > 0000:00:00.0 PCI bridge: Qualcomm Device 0101 (prog-if 00 [Normal decode])
> > >         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > >         I/O behind bridge: [disabled]
> > >         Memory behind bridge: 08000000-081fffff [size=2M]
> > >         Prefetchable memory behind bridge: [disabled]
> >
> > So this a MMIO window to the endpoint
> >
> > ...
> >
> > >
> > > 0000:01:00.0 Network controller: Qualcomm Atheros QCA9984 802.11ac Wave 2 Wireless Network Adapter
> > >         Region 0: Memory at 08000000 (64-bit, non-prefetchable) [size=2M]
> >
> > ... and the endpoint has a single *MMIO* BAR of size 2 MiB.
> >
> > This has *nothing* to do with port I/O, which is what you are
> > modifying with your patch.
> >
> > Did you check that the problem exists without the patch, and that the
> > patch makes it go away?
> >
> >
>
> Yes without the change to IO_SPACE_LIMIT, the ath10k driver fails to
> init as it can't access the reg. Only the first pci wifi works but the
> second one fails to init. By increasing the limit all comes back to
> normal. What I really can't understand is if the big IO space set in the
> ipq8064 dtsi was wrong from the start and the ath10k fails to init just
> because is missconfigured. Any idea how to find the appropriate max IO space
> for the pci?
>

OK, so the entire second host bridge fails to probe, because there is
no virtual address space left for the I/O window.

Just change the 'downstream I/O' window size in the DT to 64k
(0x10000) - I assume the current size (0x100000) is a typo anyway.

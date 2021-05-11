Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BF0379E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhEKE1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhEKE1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:27:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49F7B61924;
        Tue, 11 May 2021 04:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620707200;
        bh=wRXSAlpFD5A3K59gxjiDb9yv86dHCRapJK897k/KZVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l14XsSKl9CxxOWYR42hUKlBFXXCqRsNU0iQ4lXBq84RT8rQETaimZfDzd2C1O3cJ8
         ygzYxkJuXRaxvAlaso+ih1MmvzmUQGvQdB/p5jgvZE4b3agkOHQbIIg/+6PvbfAD9B
         aK+EBGI6IftrjECs634bxCoLoY8Q2ZFKFH5YN1xXgO+yrZIo+MsvOaeF4Y96Rzd4/9
         /YakEPdViMqYioKWHCcUCPmXwEfFna+c9tHKT7HMCEr1FGdJgUqOKUcaKRD3hOe1Ss
         Ir3in3DzvZsc60STYQByK6eRJGTYKK6UHT9gRCeGoNrIsnYrOm+4B+9WRJ7uMinmKw
         XdR5n98ZXteUA==
Received: by mail-ot1-f54.google.com with SMTP id t4-20020a05683014c4b02902ed26dd7a60so6309424otq.7;
        Mon, 10 May 2021 21:26:40 -0700 (PDT)
X-Gm-Message-State: AOAM533QfxNr6mtt6RnQOf7S82HlyVDUZfzouF8plRJz3e3ssQRj+y0q
        8rTbLN7QGHU04tDWqL6zvJMN3ynUp+rgOwbC7VA=
X-Google-Smtp-Source: ABdhPJxIuXe2hgWJqDZi6HFqhc1wS2t8jnlgjjTQXKEZ+ZD0Ui2Gc8hVEmFRQk0JpLMfEp9szwbdJXyk0wvSepFglJw=
X-Received: by 2002:a9d:69c5:: with SMTP id v5mr23927948oto.108.1620707199581;
 Mon, 10 May 2021 21:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210511021656.17719-1-ansuelsmth@gmail.com> <YJnq3Y3/I1kdV1Ov@casper.infradead.org>
 <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain>
In-Reply-To: <YJnswvYFUjlNS7Fa@Ansuel-xps.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 May 2021 06:26:28 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
Message-ID: <CAMj1kXGLihr4gq3iwHy6mLKG4UHWnh5XAgxZDZmnmNPErfJ-bg@mail.gmail.com>
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

On Tue, 11 May 2021 at 04:32, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 03:24:29AM +0100, Matthew Wilcox wrote:
> > On Tue, May 11, 2021 at 04:16:54AM +0200, Ansuel Smith wrote:
> > > Ipq8064 SoC requires larger IO_SPACE_LIMIT on second and third pci port.
> >
> > Do you really?  I mean, yes, theoretically, I understand it, the
> > hardware supports 64kB of I/O port space per root port.  But I/O
> > port space is rather deprecated these days.  My laptop has precisely
> > two devices with I/O ports, one with 64 bytes and the other with 32
> > bytes.  Would you really suffer by allocating 16kB of I/O port
> > space to each root port?
>
> We were talking about this in the other wrong patch. I also think this
> much space looks wrong. The current ipq806x dts have this space so it's
> actually broken from a long time. The only reason pci worked before was
> because the pci driver didn't actually check if the settings were right.
> New kernel introduced more checks and this problem showed up. (to be
> more precise, the pci port are commonly used by the ath10k wifi and the
> second ath10k wifi fails to init because of this problem)
> If you can give me any hint on how to check if the space can be reduced
> I would be very happy to investigate it.
> In the driver I notice that the max buffer is set to 2k, could be this a
> hint?
>

Could you share the output of lspci -vv from such a system?

I agree with Matthew that fiddling with the size of the I/O space
range probably papers over another problem, and with the odd
exception, no PCIe card used on ARM systems actually uses their I/O
BARs, even when they have them. (I used to carry a PCIe serial port
card to UEFI plugfests because that was the only thing that would stop
working if a system configured its I/O resource window incorrectly)

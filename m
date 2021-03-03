Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80132BE35
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385320AbhCCRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:09:50 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:38951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbhCCM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:57:22 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MScHp-1lNs1p3eaf-00SySq; Wed, 03 Mar 2021 13:54:33 +0100
Received: by mail-oo1-f42.google.com with SMTP id n19so5629513ooj.11;
        Wed, 03 Mar 2021 04:54:32 -0800 (PST)
X-Gm-Message-State: AOAM531NGPkJYWb1ZEFu6XbsC7YVWOmvzrRqhXBN6CfZkYA6PIa3yx1G
        EScro9i4TbX7aw+6NikJzdSa+eL2n42XAXAJiM4=
X-Google-Smtp-Source: ABdhPJwXgFWFO3RYa/2UyhwtfbPkpNjFdncGZfT0/SZ2aliOLqtfzNqIP0coHL8oImAR6W0F/2R4YD7CufcYWXAMvuE=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr21215393ooz.26.1614776071464;
 Wed, 03 Mar 2021 04:54:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com> <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap>
In-Reply-To: <20210303103839.it7grj3vtrdmngbd@kozik-lap>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 13:54:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Hyc9yCvi=htGdpHbYy-XWxPXOyEQSYxFXtLTpqYsD_A@mail.gmail.com>
Message-ID: <CAK8P3a3Hyc9yCvi=htGdpHbYy-XWxPXOyEQSYxFXtLTpqYsD_A@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/fY+IC7sdXVEt5DfeSZdLHFlKw5bjgFa/KafvJ86l5IJUoHp3ZD
 Bu/WIRlIqig8NWh/Pcrp1AOHsrPePzPe0O0Vmwd0PhqYhQVnUfV2S4WAN6Ls0rT5NQqassk
 B5MUqkJUjesuWPdRNeDqjnioP8FxUw7X0J34tvZvS5pCMuj8E+Vh0vonGdYW2ZG6qkIva5z
 kUheakM7t0ZskNq/v/H9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mHeJUIhFkBQ=:7NK8Cc66O4L35N29NC8jfp
 JplUWfG4ssECEkk6BhTiA9aJW3/0UQXO2eE64N+OuuKLZhLEQm5KfqXNJhsBcxSvDP9VGxKAb
 2bVdXlTeZIFee18bVjpcVXQAChGB2EaIamooFelFLf/RFxSUllOxf5DhCuInwu2P5NTOQIT+I
 Y1/+MGg4ScFr8OoJ8stLXvG0ihXj+XeTy70vVxygPIYCebhN1J8JigJCzeRrKMlqFI+StowB9
 h573BE54OtZJa8MfF1saf1fGnuD2fPbgdO4/VqFSNC30GdNWBuyJSsKeDhY5+/oR75HEsTnQF
 gSiP6niITpG894AoZx0GvQTO0ru2tMkeFg1UPopSzLrEsEUclQTBVCEbDITfVIwPWhSJG16Ei
 2mkMOx7VWXCfe5WWpDOeDL/8iiptVyGaIBRhOWPjVNSxu3nK4u9bkllCWyDQG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 11:38 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Mar 03, 2021 at 11:30:38AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Mar 03, 2021 at 11:24:01AM +0100, Krzysztof Kozlowski wrote:
> > > On 03/03/2021 03:26, taehyun cho wrote:
> > > > 'ARCH_EXYNOS' is not suitable for DWC3_EXYNOS config.
> > > > 'USB_DWC3_EXYNOS' is glue layer which can be used with
> > > > Synopsys DWC3 controller on Exynos SoCs. USB_DWC3_EXYNOS'
> > > > can be used from Exynos5 to Exynos9.
> > > >
> > > > Signed-off-by: taehyun cho <taehyun.cho@samsung.com>
> > >
> > > NACK because you ignored comments from March. Please respond to them instead
> > > of resending the same patch.
> > >
> > > Anyway, when resending you need to version your patches and explain the
> > > differences. Please also Cc reviewers and other maintainers. I pointed out
> > > this before:
> > > scripts/get_maintainer.pl -f drivers/usb/dwc3/dwc3-exynos.c
> > >
> > > The driver - in current form - should not be available for other
> > > architectures. It would clutter other platforms and kernel config selection.
> > > If you want to change this, you need to provide rationale (usually by adding
> > > support to new non-Exynos platform).
> >
> > No, these crazy "ARCH_FOO" things need to go away.  For systems that
> > want to build "universal" kernels, why are they being forced to enable
> > "ARCH_*" just so they can pick specific drivers?  That is not done on
> > other architectures, why is ARM64 so "special" in this regard.
> >
> > How do you "know" that these cores/devices are tied to specific ARCH_
> > platforms?  We don't, so that dependency should not be there.
> >
> > Just let any arch pick any driver if it can be built, you never know
> > what it might be run on.  Removing ARCH_ dependencies in Kconfig files
> > is a good thing, please do not discourage that from happening.
>
> It's getting more generic topic, so let me Cc Arnd and Guenter (I think
> once I discussed this with Guenter around watchdog).
>
> This is so far component of a SoC, so it cannot be re-used outside of
> SoC. Unless it appears in a new SoC (just like recent re-use of Samsung
> serial driver for Apple M1). Because of the architecture, you cannot
> build universal kernel without ARCH_EXYNOS. You need it. Otherwise the
> kernel won't boot on hardware with DWC Exynos.
>
> Since DWC Exynos won't work without ARCH_EXYNOS - the user will not get
> any usable binary - I think all, or almost all, SoC specific drivers are
> limited per ARCH. This limits the amount of choices for distro people
> and other kernel configuring folks, so they won't have to consider
> useless options.
>
> Anyway, that's the convention or consensus so far for entire SoC. If we
> want to change it - sure, but let's make it for everyone, not for just
> this one USB driver.

I think we should keep it like this, and have most platform specific
drivers be guarded in Kconfig like this. There are two main advantages
for this:

- Linus has mentioned several times that he does not want to
  be asked about new drivers that cannot run on x86 when doing
  'make oldconfig', and I'm fairly sure this applies to other users
  as well. Life is too short to know 19000 Kconfig symbols and
  whether you should enable them or not.
  Drivers tend to not be tied to an instruction set, so if a driver
  is used on mips32, arm32 and arm64, but is tied to a particular
  SoC manufacturer, it should only need to depend on that platform
  (|| COMPILE_TEST).

- A default config enables tons of device drivers, most of which
  are only ever used on a small number of SoCs. I like the convenience
  of being able to turn a generic config into one for my particular SoC
  by turning off all other platforms, and letting the platform specific
  drivers disappear because of the dependency.

There are two related points:

- For the specific question of drivers like DWC3_EXYNOS, I
  would indeed like to see fewer questions asked, and more
  of the customization done in a generic driver. The same is
  true for a lot of designware drivers (ethernet, pci, mmc, ...)
  and similar IP blocks from other vendors. We know these are
  all the same hardware design, just wired up in slightly different
  ways, but without help from the hardware designers we have
  no good way to come up with a generic driver that understands
  all the possible ways it can be wired up.

- I don't like the way we deal with a lot of platform specific irqchip
  and clocksource drivers. Unlike most other subsystems, these
  drivers just get selected implicitly from a platform specific
  Kconfig symbol. The main disadvantage is that this is inconsistent
  with the rest of the kernel, but there is also a more general
  problem with the use of 'select' that causes a couple of issues
  when used too much.

       Arnd

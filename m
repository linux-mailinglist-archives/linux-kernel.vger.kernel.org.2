Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2055F32C0F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837248AbhCCSsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:51 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:41745 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbhCCSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:08:13 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MWhxY-1lJgSG3ouu-00X4M5; Wed, 03 Mar 2021 18:52:01 +0100
Received: by mail-ot1-f52.google.com with SMTP id e45so24373157ote.9;
        Wed, 03 Mar 2021 09:52:00 -0800 (PST)
X-Gm-Message-State: AOAM532iIqwn/5Jd4IbaN/F8hhMqgD2ZsOGmGVFLdX7Oyn11ptroFLBE
        nti+jyAH987ZUo+osdYFI6iudyxMAtLP4kGZ9JU=
X-Google-Smtp-Source: ABdhPJyZgFHUFofWUTXeg3MMV6dTME4mgPmK7Qu2uOA2JDhmP2sb3P0PM0oD4uxx9M963W2C6eq2lvdKqMI/0mYWmok=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr152425otq.251.1614793919578;
 Wed, 03 Mar 2021 09:51:59 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210303022537epcas2p1b85ab825ceca3a411a177cc1af8a2c7b@epcas2p1.samsung.com>
 <20210303022628.6540-1-taehyun.cho@samsung.com> <c9ac155c-56c2-4025-d1ae-d0c6c95533b8@kernel.org>
 <YD9lTjWc25Nn7jAR@kroah.com> <20210303103839.it7grj3vtrdmngbd@kozik-lap> <YD+XkFAfoKpSsea3@kroah.com>
In-Reply-To: <YD+XkFAfoKpSsea3@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 18:51:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1GN-g07hi8xCQ8AcTk1Cioj=ro6oqQFa844OnmFQ0MEQ@mail.gmail.com>
Message-ID: <CAK8P3a1GN-g07hi8xCQ8AcTk1Cioj=ro6oqQFa844OnmFQ0MEQ@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: make USB_DWC3_EXYNOS independent
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        taehyun cho <taehyun.cho@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+betIC5tW5QZLNZtTZm60dhIJMGOOeTkC0zt6RZZcK0WFzr7/2C
 avnORCt4Lbf4XFYJGGUTsHDDjnNObX9IkThsIg4/bl0B6TLbbKvMvSKZlfAPW2UpIpb9Xxz
 D9HfeA7ItE5F6pUErxeJWOK5P1IaAfw+jr8P4N6GJyL5tQD9DQa1CmHGziF/JglVpoY6we/
 EC9xNgKuSx5GhC0CJAr0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hRqmoWF4L1k=:etCBzdVpxQgfNxO+Nm1+iR
 kRiBbw4HXXJBHk8j9WNtQzlnUHiZc2qVpVb9/55bbz5C0GcejILlPJTY4ulNOruQ0lT+NUrqn
 0yKMYgrjGpq1q9rgDjI6yejL0ny/7GKKAErgCBD2yg7gU5KYQE75SPxUHUkhxc8vqBAAd0Xl+
 8Z9/80C95o0nfyvaN1VF2vIWtUpuZuUOdHeFzBeQGujyo1o6Hj3PaN/v13Xb7iBtEEtBe6Mwr
 cznr567eoVjxi08+owimMG4TxuWOy+r+BFxqY2xUdOV4rB8xg+/iNxFbi9s9N+OtYl3US7beR
 3MnTtAcZyGh8Bd7/VRsF66vkv3B6WtAo2pvFSkxOS/4PDs7popy6SagUJl924RRII/ab9ob6v
 Bk8Wn55HyX1nCwj2Na0iolWvCQ8NuIe6fgJ0a1/jTXXTXHTDPWptPC6HmS4bp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 3:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Mar 03, 2021 at 11:38:39AM +0100, Krzysztof Kozlowski wrote:
> > On Wed, Mar 03, 2021 at 11:30:38AM +0100, Greg Kroah-Hartman wrote: >
> > It's getting more generic topic, so let me Cc Arnd and Guenter (I think
> > once I discussed this with Guenter around watchdog).
> >
> > This is so far component of a SoC, so it cannot be re-used outside of
> > SoC. Unless it appears in a new SoC (just like recent re-use of Samsung
> > serial driver for Apple M1). Because of the architecture, you cannot
> > build universal kernel without ARCH_EXYNOS. You need it. Otherwise the
> > kernel won't boot on hardware with DWC Exynos.
>
> So, to create a "generic" arm64 kernel, I need to go enable all of the
> ARCH_* variants as well?  I thought we were trying to NOT do the same
> mess that arm32 had for this type of thing.

Yes, same as on any other architecture that supports more than one
platform at a time.

> > Since DWC Exynos won't work without ARCH_EXYNOS - the user will not get
> > any usable binary - I think all, or almost all, SoC specific drivers are
> > limited per ARCH. This limits the amount of choices for distro people
> > and other kernel configuring folks, so they won't have to consider
> > useless options.
>
> Why do we have ARCH_EXYNOS at all?  x86-64 doesn't have this, why is
> arm64 somehow special here?

There are only about five chip vendors for x86-64, and they largely
just use the same drivers. You still have platform support that you need to
enable to run on all machines, see:

CONFIG_X86_NUMACHIP
CONFIG_X86_VSMP
CONFIG_X86_UV
CONFIG_X86_GOLDFISH
CONFIG_X86_INTEL_CE
CONFIG_X86_INTEL_MID
CONFIG_X86_AMD_PLATFORM_DEVICE
CONFIG_KVM_GUEST
CONFIG_JAILHOUSE_GUEST
CONFIG_ACRN_GUEST
CONFIG_CHROME_PLATFORMS
CONFIG_MELLANOX_PLATFORM
CONFIG_SURFACE_PLATFORMS
laptop vendors in drivers/platform/x86/Kconfig

Most of these have only a few drivers, while none of the interesting
x86 platforms that modified from ARM or MIPS SoCs
(Allwinner/Rockchip Sofia, Unisoc SC9861G-IA, Maxlinear
XWAY, MobilEye EyeQ6) made it upstream so far, and probably
never will.

> That's my complaint, it feels wrong that I have to go and enable all
> different ARCH_ symbols just to build these drivers.  If people want
> 'default' configurations, then provide an exynos default config file,
> right?

It is very intentional that there is only one defconfig, this helps ensure
that none of the platform specific drivers conflicts with other platforms.

> I've complained about this before, from a driver subsystem maintainer
> point of view, this is crazy, drivers should be building and working on
> everything.  Worst case, it's a cpu-type issue, to build or not build a
> driver (i.e. s390, i386), best case it's a feature-type issue to depend
> on (i.e. USB, TTY, etc.).  But never a "this one sub-architecture of
> this one cpu"-type issue.  That feels crazy to me...

Basing on the CPU type seems way crazier to me, these have
almost nothing to do with what kind of drivers one gets to use.

SoC designers rarely care much about the CPU core they put
in a SoC, they just license a part fits their needs.
At the moment everyone is using ARM, but before that they had
the same platforms on powerpc, mips, sh, or their own custom
architecture. Some get acquired by Intel and start using x86
cores, and some others move to RISC-V.

       Arnd

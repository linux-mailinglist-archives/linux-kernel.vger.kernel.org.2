Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572933B0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCOLM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:12:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhCOLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:11:56 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2VCb-1li9Qr0MZT-013rlP for <linux-kernel@vger.kernel.org>; Mon, 15 Mar
 2021 12:11:54 +0100
Received: by mail-ot1-f42.google.com with SMTP id r24so6791974otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:11:53 -0700 (PDT)
X-Gm-Message-State: AOAM533QdiU81p2rdngUAxTObTkgreCsf5joY04QRFj3Pyt6g6MDHI5A
        kRQeuU8RFpUxWdTPDX2ETwtEpIqcjV+OKm9+75Y=
X-Google-Smtp-Source: ABdhPJwgFNAyEVxZiEuwwAFSd1LDIRQSQ4zi7ZvOwBbILrKBjO6+lOmx4xH7rEw7RUsB/mp58wpwWDncRUhPJRN7aEM=
X-Received: by 2002:a9d:6341:: with SMTP id y1mr13488018otk.210.1615806712855;
 Mon, 15 Mar 2021 04:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
 <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
 <CACT4Y+aTbdE1CeUOgCKLJ3XpjazN5=yTmToXN_03M9EQ_hhayg@mail.gmail.com>
 <CAK8P3a221xG9dM1UZXNGhjkVyxn6sjscSYdsFwWO6CVB_HQhXw@mail.gmail.com>
 <48347b4d-9194-16f2-95a0-c3eb55ca9a80@huawei.com> <CACT4Y+a58QHkas=5t51Aou9GDHDtjyiGwtruUZgbe-iVmTp0Mw@mail.gmail.com>
 <56d33822-e577-c8a8-673b-675d6920c379@huawei.com>
In-Reply-To: <56d33822-e577-c8a8-673b-675d6920c379@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Mar 2021 12:11:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2BQQOZS0wbFVWm6HjmZZMKLGn6EruhDuFJi6kvv8UwWA@mail.gmail.com>
Message-ID: <CAK8P3a2BQQOZS0wbFVWm6HjmZZMKLGn6EruhDuFJi6kvv8UwWA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     John Garry <john.garry@huawei.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Jiahui Cen <cenjiahui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AC9s1pMLnz+KjapEsXpdrrW9SL623+mzhVCbm8uWUosXXAFUr9r
 3yVwZQBGpP/lZ2MkyYfL8736Lqm1YL7udzTSG01Zl0m64AQga4+W3G0LAkLJAhN4caqzbLM
 avw6NK9SBY1+Af/kyVD7DgO0qwKsbAB/C08FfrfCKFHw48hLFrQf7AZW/x3VQ1bv6zcA/O7
 /rFdwkOrWRhGXCtV61krg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+U9cBDxu96o=:Ptl8ARVSmuhkVzhbYGY4h1
 fIhJUmDHt4Udonp4omtNkzfulRzOsrkrUYnTo72d5jynND+2nXqyTkrxTAKoz5A0nooaFI9gj
 ErFqPOiggNMMzb/oJx8gofTOpR3oPrk9y5UcjrzEjF2hrjaWHTlNLKpBKoL/8AyrJV9RzJpMa
 Hrm67TSL9Y0onKw+5PJj9XHkQJWpadrRdyeMeN4JHaTs/jeDOmT96TTWkaWMdOnCI8dOXQHQz
 jivEhpFOxMtSHukh7L4VAQ1tKzL3CXj8CVHNpZ8ag2UbIIWnDi0xqkEldH3X54k3tsJTykQ2K
 Tys9Ir6sc2jSo3cyK+JwG5Q1r/6rpFkW2h3e2RsMoOVIaV4xVjfJi+MdYoirmiI4/teby6SBn
 CE/CJYzwVpNd60wgomVHfmIXkzArEKZEK3UfvAIUHRYmR0bIvoM6/hkJSCK6v
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:29 AM John Garry <john.garry@huawei.com> wrote:
> On 15/03/2021 10:01, Dmitry Vyukov wrote:
> > On Mon, Mar 15, 2021 at 10:45 AM John Garry<john.garry@huawei.com>  wrote:
> >>>> It does not happen too often on syzbot so far, so let's try to do the
> >>>> right thing first.
> >>>> I've filed:https://bugs.launchpad.net/qemu/+bug/1918917
> >>>> with a link to this thread. To be fair, I don't fully understand what
> >>>> I am talking about, I hope I proxied your description properly.
> >>> Thanks, looks good. I provided a little more detail in a comment there.
> >>>
> >>>           Arnd
> >>> .
> >>>
> >>   From looking at the bug report, my impression is that this is a qemu
> >> issue, as the logical IO space is mapped to the PCI host bridge IO
> >> space, and qemu does not handle accesses to that CPU addressable region
> >> at all. As Arnd said.
> >>
> >> However, we really should not be accessing logical IO ports 0 or 0x2f8
> >> at all via ttyS3 if not enumerated from PCI device at that logical IO
> >> port. That is what I think anyway, as who knows what device - if any -
> >> really exists at that location. That is why I had this patch to just
> >> stop accesses to legacy IO port regions on arm64:
> >>
> >> https://lore.kernel.org/lkml/1610729929-188490-2-git-send-email-john.garry@huawei.com/
> > Hi John,
> >
> > Thanks for the info.
> >
> > The patch is from January, but it's not merged yet, right?
> > It will fix the crash we see, right?
>
> It's not merged, and it probably would solve this issue. But following
> discussion with Arnd when it was originally posted, I still need to do
> some analysis whether it is the proper thing to do.

Right, it might be something we decide to do in order to intentionally
break legacy ISA devices, but I don't think that patch should be necessary
as a bugfix, given that the same devices on x86 just work.

I think Huawei and some others have a BMC on either a PCI port or
an LPC bridge, with PC style device emulation for things that might
include VGA, serial, keyboard/mouse, RTC, IPMI, or ATAPI CDROM.

In a properly designed system, these should all be described by the
firmware if present, but today they should still work even if the firmware
does not describe them (provided the driver looks at the correct address,
which the 8250 driver did not).

         Arnd

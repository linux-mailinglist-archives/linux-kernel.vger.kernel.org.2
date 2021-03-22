Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0E344986
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhCVPnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:43:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhCVPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:43:14 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6lxY-1lJOMY3ila-008Kw4 for <linux-kernel@vger.kernel.org>; Mon, 22 Mar
 2021 16:43:13 +0100
Received: by mail-ot1-f44.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so16348695ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:43:12 -0700 (PDT)
X-Gm-Message-State: AOAM530y2QApd+oo1tBMD8b3GoyXgFpY6bjnA7QThEVIKpdxiHjGLnUG
        wpFDy5xOgrDyWStVyiWSpaqYvFfksKpqUm2YhJw=
X-Google-Smtp-Source: ABdhPJwWNPEJuaMEZd8pIQV9l7n7UkrBbBEBeXH7l5ey8sIMjBmiFNOwitwEz/Yn8XRlHflfgzUwdqIgvpVDd75yQvY=
X-Received: by 2002:a9d:316:: with SMTP id 22mr470096otv.210.1616427791533;
 Mon, 22 Mar 2021 08:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
 <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com> <CAFEAcA-oH=9RLdzhsLcSTxNLBLcyEcJtO4L5EqRSiGWHdApgqA@mail.gmail.com>
In-Reply-To: <CAFEAcA-oH=9RLdzhsLcSTxNLBLcyEcJtO4L5EqRSiGWHdApgqA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 22 Mar 2021 16:42:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2aQ0C7M2p3DBwjvK5mGyg2_8PQK2=FnkPFp3bVmt_xMw@mail.gmail.com>
Message-ID: <CAK8P3a2aQ0C7M2p3DBwjvK5mGyg2_8PQK2=FnkPFp3bVmt_xMw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:LT7wnUnrQ0twKagV6NI+TbEYlbAXBcULaEpkOLb8rRzTH3knYBl
 uAlOwrHmsYDqKLh0TSCXdwp0OYxPOyNRCARcSERHmWR89SC6PwEALtX9EllRfBTOlPjbzwu
 QpVssjZMCS3vCkyMAHhbWW0GtEGqR/aRNgkqiMX+cDne69cFNttqsJPcWHEe98n2ABx4aoZ
 oC/w7hpB+wkd+hhi3oA4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:i3WaBeHP4nc=:GGy+t7lW0MZXBdtjbYgoLt
 X/s2PRZqTfpca4z73MwKMd5w0Kw0seU/cDoLg0kpYvQJncL2utyTRU22ySvlRkMIHcW/v7hEL
 spytwFtTpyqUnd7mMy9mXnD8r/DsHN/YlybObNnONnrlP3kLYV3S4HXKOFOrMYD3kuuu9jojV
 FGndS2mA0IEKGK1s3vAsG1dO9JUA8uKTlWbqqHPRShcGTHi6EmZcyUgIRPU0HHs8GbWG7Q31v
 5DYkNj1PGQEUwh/uJ8C7KlJBQAW8++8Xkcyr2nRaQG1GbqXyLBys8KWStb8eEP9PpOMnsKG21
 9oOrlgMa1R7pDXF6YC5Vp6aQ4TkF4KCUTm18ge8kia5yFKAFwaNWfhTXYUBikG9AeVfPgv605
 0+4vTeAYuZy7ql+v7rZ+D8ig7bx/1JxMCa3qXT6dAwb0nBRRcMWcceVIwQlEkGey7gyMiNWiW
 N42MxwP+XUzh9HcatT8fZ/BZhVGAMn34x+S5lQsAbb3KFdyPOLhCPNzI5Aozt5d5s5/LFtZt4
 PFr5wNSXK1ovMNIX+VsMlJ9GNcss9n7coN6pYS0FlZFuVlAQCwhwofaH0GJ5Ti3QA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 2:53 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Sun, 21 Mar 2021 at 19:00, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Mar 20, 2021 at 9:43 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > On Fri, 12 Mar 2021 at 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > So it's probably qemu that triggers the 'synchronous external
> > > > abort' when accessing the PCI I/O space, which in turn hints
> > > > towards a bug in qemu. Presumably it only returns data from
> > > > I/O ports that are actually mapped to a device when real hardware
> > > > is supposed to return 0xffffffff when reading from unused I/O ports.
> > >
> > > Do you have a reference to the bit of the PCI spec that mandates
> > > this -1/discard behaviour for attempted access to places where
> > > there isn't actually a PCI device mapped ? The spec is pretty
> > > long and hard to read...
> > >
> > > (Knowing to what extent this behaviour is mandatory for all
> > > PCI systems/host controllers vs just "it would be nice if the
> > > gpex host controller worked this way" would help in figuring
> > > out where in QEMU to change.)
> >
> > I spent some more time looking at both really old PCI specifications,
> > and new ones.
> > The old PCI specs seem to just leave this bit as out of scope because
> > it does not concern transactions on the bus. The PCI host controller
> > can either report a 'master abort' to the CPU, or ignore it, and each
> > bridge can decide to turn master aborts on reads into all 1s.
> > We do have support some SoCs in Linux that trigger a CPU exception,
> > but we tend to deal with those with an ugly hack that just ignores
> > all exceptions from the CPU. Most host bridges fortunately behave
> > like an x86 PC though, and do not trigger an exception here.
>
> There's apparently a bit in the PCI spec that reads:
>         The host bus bridge, in PC compatible systems, must return all
>         1's on a read transaction and discard data on a write transaction
>         when terminated with Master-Abort.
>
> which obviously applies only to "PC compatible systems".

Right. As far as I can tell, all ARMv8 and most ARMv7 based SoCs
do this to be more compatible with PC style operating systems like
Linux, but you are right that the specification here does not
mandate that, and the older ARMv5 SoCs seem to be compliant
as well based on this.

> > Linux has a driver for DPC, which apparently configures it to
> > cause an interrupt to log the event, but it does not hook up the
> > CPU exception handler to this. I don't see an implementation of DPC
> > in qemu, which I take as an indication that it should use the
> > default behavior and cause neither an interrupt nor a CPU exception.
>
> Hmm, maybe. We should probably also implement -1/discard just because
> we're not intending to have 'surprising' behaviour.
>
> TBH I'm having difficulty seeing why the kernel should be doing
> this at all, though. The device tree tells you you have a PCI
> controller; PCI supports enumeration of devices; you know exactly
> where everything is mapped because the BARs tell you that.
> I don't see anything that justifies the kernel in randomly
> dereferencing areas of the IO or memory windows where it hasn't
> mapped anything. You shouldn't be probing for legacy ISA-port
> devices unless you're on a system which might actually have them
> (eg an x86 PC).

It only happened in this case because there is also a bug in
the 8250 serial port driver that is configured to assume four ports
exist at port zero. On real arm64 hardware, this is apparently
harmless because the driver has coped with this for 30 years ;-)

There are a few other drivers that assume hardware is accessible
at the legacy addresses, and applications can also still open /dev/ioport
(if that is enabled at compile time) for the same purpose. Examples
could be PC-style mouse/keyboard (emulated by a server BMC),
PATA/SATA controllers in pre-AHCI mode, VGA console, and a
couple of industrial I/O drivers that have ISA devices behind a
PCI bridge.

Most other actual ISA add-on card drivers can only be enabled
on kernels that support machines with real slots, so you could
get them on an i386 kernel running a virtualized x86_64 machine,
but not on ARMv6 or later kernels, and you can't run pre-ARMv7
kernels on ARMv8 hardware.

        Arnd

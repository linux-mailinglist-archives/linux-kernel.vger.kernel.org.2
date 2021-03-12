Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB13389BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhCLKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:11:23 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:48973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhCLKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:11:17 -0500
Received: from mail-oo1-f49.google.com ([209.85.161.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxE5Y-1ledUi157Q-00xZUl for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021
 11:11:16 +0100
Received: by mail-oo1-f49.google.com with SMTP id r17-20020a4acb110000b02901b657f28cdcso1399812ooq.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:11:16 -0800 (PST)
X-Gm-Message-State: AOAM533hxlpktTjiznqkFhb9inLKh9XnzIvAK1k4whdbThMZ2p85rb40
        VJ8CDwqdYyNmYAaw4D8geKpJAuLQsdIgl568Q5c=
X-Google-Smtp-Source: ABdhPJz8/CIhaCMY3e4m42A2g6CP7hIU2c8qbOPobmaOxdjD9Q+mXuESPm7Xpc/XF0fDCeoBYEstu48X+caG94ZUCaI=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr2771319ooz.26.1615543874960;
 Fri, 12 Mar 2021 02:11:14 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com> <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
In-Reply-To: <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Mar 2021 11:10:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
Message-ID: <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FGhDDW6dfB4k+qSladY8t6mv2smKWyjZkjH/dfNqO6zRT2SRzyG
 cqrEu5uXNaE7f/9A2kVdyBpJqtauqrP2pzpIln/PG31/Pk8LktQLU/bYUjIJ8dpwWOALROT
 nELd+BIQNhHtQMPBsA/imsKLB7/eoenOaMoxAO6FgIzpfKxnvK+tCuSFp2mFyTK10Gge13U
 3Gb026ngfTU/1frZMfUdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HhbIGF1s3pU=:tFY0x5F2La/sELLuOvNvQG
 XXb4FYpHpKcKUKIBVOpb1pajZOpLdsteql1MwUc0efxooQsDUD/O6oL52bXnhXedPHcFJnBMN
 RWaINIwdjZCSgVV537pDMrJ7l7/mBA5BQsIH45NtiBtZYwwmMsU3qLu6+MyOL9JxLyny9vsIK
 5aYImv2olJDwFoC1GF63pUQVgxZ1o4l/UyOMRR4KL1YhPLEyqUjDspwtj/ZBBsK9rpre+Yz0f
 aLfjynBu97DEULXzc1hKhiI9I0lTQOhJEMTEntLOhRpPoONCXTzea5OyGuEcr9huXnVQELGZA
 89qrtYE7ieHzajBloslsKyF381ZKfxlUW5y1BF34uB4ymwc/C4BsEUR+SDC0PNXfeGic9mxW0
 oW1jL0yrGO38o9BsLBZde4FGkGfZDMxysnDBTtDQuOhBMdHek181J7DGaawtq+6TwKvmjJKei
 ZKaPfVuN5x1hkCrCCppIr4neWzf8bSpuYC0Fw6Rn1n2V/mwuTsdTOsc7YYg4fccXpX9TGnmtz
 zzYuUyOButr0JXqf44fEev9KDycHQbRoJs5LggLfN2BGD2xj+t9pBnc+mLoqAqVUw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 10:21 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Mar 12, 2021 at 10:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Mar 12, 2021 at 9:46 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > On Fri, Mar 12, 2021 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Thu, Mar 11, 2021 at 6:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > a) accessing a legacy ISA/LPC port should not result in an oops,
> > > >     but should instead return values with all bits set. There could
> > > >     be a ratelimited console warning about broken drivers, but we
> > > >     can't assume that all drivers work correctly, as some ancient
> > > >     PC style drivers still rely on this.
> > > >     John Garry has recently worked on a related bugfix, so maybe
> > > >     either this is the same bug he encountered (and hasn't merged
> > > >     yet), or if his fix got merged there is still a remaining problem.
> >
> > > > b) It should not be possible to open /dev/ttyS3 if the device is
> > > >     not initialized. What is the output of 'cat /proc/tty/driver/serial'
> > > >     on this machine? Do you see any messages from the serial
> > > >     driver in the boot log?
> > > >     Unfortunately there are so many different ways to probe devices
> > > >     in the 8250 driver that I don't know where this comes from.
> > > >     Your config file has
> > > >    CONFIG_SERIAL_8250_PNP=y
> > > >    CONFIG_SERIAL_8250_NR_UARTS=32
> > > >    CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > > >    CONFIG_SERIAL_8250_EXTENDED=y
> > > >    I guess it's probably the preconfigured uarts that somehow
> > > >    become probed without initialization, but it could also be
> > > >    an explicit device incorrectly described by qemu.
> > >
> > >
> > > Here is fool boot log, /proc/tty/driver/serial and the crash:
> > > https://gist.githubusercontent.com/dvyukov/084890d9b4aa7cd54f468e652a9b5881/raw/54c12248ff6a4885ba6c530d56b3adad59bc6187/gistfile1.txt
> >
> > Ok, so there are four 8250 ports, and none of them are initialized,
> > while the console is on /dev/ttyAMA0 using a different driver.
> >
> > I'm fairly sure this is a bug in the kernel then, not in qemu.
> >
> >
> > I also see that the PCI I/O space gets mapped to a physical address:
> > [    3.974309][    T1] pci-host-generic 4010000000.pcie:       IO
> > 0x003eff0000..0x003effffff -> 0x0000000000
> >
> > So it's probably qemu that triggers the 'synchronous external
> > abort' when accessing the PCI I/O space, which in turn hints
> > towards a bug in qemu. Presumably it only returns data from
> > I/O ports that are actually mapped to a device when real hardware
> > is supposed to return 0xffffffff when reading from unused I/O ports.
> > This would be separate from the work that John did, which only
> > fixed the kernel for accessing I/O port ranges that do not have
> > a corresponding MMU mapping to hardware ports.
>
> Will John's patch fix this crash w/o any changes in qemu? That would
> be good enough for syzbot. Otherwise we need to report the issue to
> qemu.

No, this was a third issue. As far as I remember, this would result in
a similar problem in the case where there is no PCI bus at all, or
where no PCI host has an I/O port range, so the inb() from the serial
driver would cause a page fault. The problem you ran into happens
in qemu when the PCI I/O ports are mapped to hardware registers
that cause an exception when accessed.

If you just want to work around the problem for now, it should
go away if you set CONFIG_SERIAL_8250_RUNTIME_UARTS
to zero.

       Arnd

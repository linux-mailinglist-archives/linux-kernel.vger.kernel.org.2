Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E33A3387CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhCLIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:40:45 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:51739 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbhCLIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:40:12 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwPjf-1ldGgh2rX3-00sOlV for <linux-kernel@vger.kernel.org>; Fri, 12 Mar
 2021 09:40:10 +0100
Received: by mail-ot1-f44.google.com with SMTP id 75so3173785otn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:40:10 -0800 (PST)
X-Gm-Message-State: AOAM530E3VB9COxHq/Y7DLHPdH7BABVVabeeJgOZIbotLnuMqsEbspTi
        vGZIulMLJjpIoLOgCMkwUA/U796wjVGImw7r0o0=
X-Google-Smtp-Source: ABdhPJwmWRknWAXyknHhULYipa3e0PU0+89BL/xcwaOgnIpdo8m0SjaiJsDY1UKOPAvk3wFmMHUSdMGjuLDgjnVO3vI=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr2610357otq.251.1615538409449;
 Fri, 12 Mar 2021 00:40:09 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com> <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
In-Reply-To: <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Mar 2021 09:39:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
Message-ID: <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Tn11+rvtKFDHYSXiVdqAx653MxaLsl0ytUE+bkf1etAr6LIcl0i
 RQIotLZ5uPZv5D6kra5YFOdywsExh+/6bip6AGY9VqGtRWuho7oLQPadLjqRUgXTuPPAjCg
 RmkjdxhrRayJXdBbaKIEahm091RltC9Whw4NiVHZJY3h/SJ24HStUm7AE5MlPYcJxMMWwDE
 X7YIS8A3t9hSt4WNEgS9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yjduab4BG0c=:ltHuOjfMlPt7Qn7sGWEA7E
 FwK1WDo23Mkge2LmGSmIvsjXRJdbdp3ZFYZIFavs4R1tHNKjGEpfBZNmm5odwwsXl3rTnnulg
 BdI7iXjqagGBXMIBfieBR3J8zbzgPLxfBW+e9zesZtPmBrBAXY4uoEwVO3rnmlWSodaU8AqnA
 awYNSA1BGU8mQeW1+VcwXHxcyXauP6syuNTteGw9inIsdGYiGrg71HJKCMFVGqmyWxGYhpz9C
 8vh/0Tf9fSqrQKUzzYugVp2ywUxWKACfkmFtDlDc2RHVobcHOWpxyEeqVtmZs4+GRLo4J5gqU
 BXfhej4E/TVl9wg7sriiQpio9tD91yO41n3eY/hqxKBFWp0Pp/arVPVAnzjMTIy5YEC18E8cj
 MWA+y1XcVt15JAm8R/lqNqGvYM/8Jns1F+AWwXAPa5V3+yWc5WG62+2UpkLZR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 6:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Mar 11, 2021 at 2:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > The instances found few arm64-specific issues that we have not
> > > observed on other instances:
> >
> > I've had a brief look at these:
> >
> > > https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
> >
> > This one  doesn't seem arm64 specific at all. While the KASAN report has shown
> > up on arm64, the link to
> > https://syzkaller.appspot.com/bug?id=aa8808729c0a3540e6a29f0d45394665caf79dca
> > seems to be for x86 machines running into the same problem.
> >
> > Looking deeper into the log, I see that fw_load_sysfs_fallback() finds
> > an existing
> > list entry on the global "pending_fw_head" list, which seems to have been freed
> > earlier (the allocation listed here is not for a firmware load, so presumably it
> > was recycled in the meantime). The log shows that this is the second time that
> > loading the regulatory database failed in that run, so my guess is that it was
> > the first failed load that left the freed firmware private data on the
> > list, but I
> > don't see how that happened.
> >
> > > https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea
> >
> > This one rings a bell: opening a 8250 uart on a well-known port must fail
> > when no I/O ports are registered in the system, or when the PCI I/O ports
> > are mapped to an invalid area.
> >
> > It seems to be attempting a register access at I/O port '1' (virtual
> > address 0xfffffbfffe800001 is one byte into the well-known PCI_IOBASE),
> > which is an unusual place for a UART, traditional PCs had it at 0x3F8.
> >
> > This could be either a result of qemu claiming to support a PIO based UART
> > at the first available address, or the table of UARTS being uninitialized
> > .bss memory.
> >
> > Definitely an arm64 specific bug.
>
> I can reproduce this with just:
>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> int main(void)
> {
>   int fd = syscall(__NR_openat, 0xffffffffffffff9cul, "/dev/ttyS3", 0ul, 0ul);
>   char ch = 0;
>   syscall(__NR_ioctl, fd, 0x5412, &ch); // TIOCSTI
>   return 0;
> }
>
>
> It does not even do any tty setup... does it point to a qemu bug?

There are at least two bugs here, but both could be either in the
kernel or in qemu:

a) accessing a legacy ISA/LPC port should not result in an oops,
    but should instead return values with all bits set. There could
    be a ratelimited console warning about broken drivers, but we
    can't assume that all drivers work correctly, as some ancient
    PC style drivers still rely on this.
    John Garry has recently worked on a related bugfix, so maybe
    either this is the same bug he encountered (and hasn't merged
    yet), or if his fix got merged there is still a remaining problem.

b) It should not be possible to open /dev/ttyS3 if the device is
    not initialized. What is the output of 'cat /proc/tty/driver/serial'
    on this machine? Do you see any messages from the serial
    driver in the boot log?
    Unfortunately there are so many different ways to probe devices
    in the 8250 driver that I don't know where this comes from.
    Your config file has
   CONFIG_SERIAL_8250_PNP=y
   CONFIG_SERIAL_8250_NR_UARTS=32
   CONFIG_SERIAL_8250_RUNTIME_UARTS=4
   CONFIG_SERIAL_8250_EXTENDED=y
   I guess it's probably the preconfigured uarts that somehow
   become probed without initialization, but it could also be
   an explicit device incorrectly described by qemu.

        Arnd

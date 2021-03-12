Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D240E3387D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhCLIqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbhCLIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:46:16 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41725C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:46:16 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t4so23559958qkp.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3kPlMQWZvsqGOcv/+/rDO73rv7m2YnQ8zEd6x5HGmc=;
        b=DBSUH6oIGC51NGxAqgFg79OENqewq2idqpVpo1XCR+p2tArAmctpwxtBzpSnLuPF4v
         biqKnBRgWNjjyrgoBVt+x9TBP9aBHhuHJo1olNwGPxwPpYG147uyMLdGYk4ZIygMmh8g
         IjEErcf6HfxiQmgltA+YWqsX1bXQNIVJ5M6p6sIIfJowYMU70bOTLnB7b0g0BW/cGmEl
         mseYoGKPLv3q7W/2woO+t8hbmigb/NBOhkHcpwYcAmqAQOoqgucxFogFcP5X8yviC9Xl
         DX7DujKfdHhcfvp9g/WtmIVFKQ4INH7suGqQrej4IcnLDSA2N25nzePPzCmpXjdTSr7p
         60xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3kPlMQWZvsqGOcv/+/rDO73rv7m2YnQ8zEd6x5HGmc=;
        b=O8Fl4iYWgIJhAl1+wJSQNhVW8VPrNR24hKBv0WmfUA4VOvsjixLEw4thvYtgkBWx6U
         mo5VgxSaHKxRdC0S7Gcis1rud1HdFVbu6ooSjzM/AvaO35NeRAT8EG32oDPMR1MthYvf
         TyF/Nm84aVEvGpU7Y43VrFamVpwlZz1IO5rpm6wp9j3dd9MKnlWmj8t0HIhUfsgKfOhK
         jQdbxGsMKI6g24HPeXvtilPbhhy93O0MJ62X30dnohzv6bnNGxmbgWGDOEm2ix8vJFLb
         19OWkUldQyQEead1pkEq+SnfM4Gs+pXwvTxJI4jzUCdyGBtkGiptuJnV4St1Di3lWzlW
         cJWw==
X-Gm-Message-State: AOAM530qVF+g0bm/ARHS5DOEgLySSlz6DGQYgavWjmjp15QmQWW4w1km
        1wPavpkJvfTQ14j73aE2vUsWr7Vo85ksatmBNAbMtw==
X-Google-Smtp-Source: ABdhPJzLUpZiUzj3Z5y8Lv+uiy5ESLWivOvS/pAxmKrtJHK/FNyc611i72WnrKyuqpIni+kjpc88mxlco6YaTwsC2Ik=
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr11711869qko.424.1615538775155;
 Fri, 12 Mar 2021 00:46:15 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com> <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
In-Reply-To: <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 09:46:03 +0100
Message-ID: <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Mar 11, 2021 at 6:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Thu, Mar 11, 2021 at 2:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > The instances found few arm64-specific issues that we have not
> > > > observed on other instances:
> > >
> > > I've had a brief look at these:
> > >
> > > > https://syzkaller.appspot.com/bug?id=1d22a2cc3521d5cf6b41bd6b825793c2015f861f
> > >
> > > This one  doesn't seem arm64 specific at all. While the KASAN report has shown
> > > up on arm64, the link to
> > > https://syzkaller.appspot.com/bug?id=aa8808729c0a3540e6a29f0d45394665caf79dca
> > > seems to be for x86 machines running into the same problem.
> > >
> > > Looking deeper into the log, I see that fw_load_sysfs_fallback() finds
> > > an existing
> > > list entry on the global "pending_fw_head" list, which seems to have been freed
> > > earlier (the allocation listed here is not for a firmware load, so presumably it
> > > was recycled in the meantime). The log shows that this is the second time that
> > > loading the regulatory database failed in that run, so my guess is that it was
> > > the first failed load that left the freed firmware private data on the
> > > list, but I
> > > don't see how that happened.
> > >
> > > > https://syzkaller.appspot.com/bug?id=bb2c16b0e13b4de4bbf22cf6a4b9b16fb0c20eea
> > >
> > > This one rings a bell: opening a 8250 uart on a well-known port must fail
> > > when no I/O ports are registered in the system, or when the PCI I/O ports
> > > are mapped to an invalid area.
> > >
> > > It seems to be attempting a register access at I/O port '1' (virtual
> > > address 0xfffffbfffe800001 is one byte into the well-known PCI_IOBASE),
> > > which is an unusual place for a UART, traditional PCs had it at 0x3F8.
> > >
> > > This could be either a result of qemu claiming to support a PIO based UART
> > > at the first available address, or the table of UARTS being uninitialized
> > > .bss memory.
> > >
> > > Definitely an arm64 specific bug.
> >
> > I can reproduce this with just:
> >
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/syscall.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> >
> > int main(void)
> > {
> >   int fd = syscall(__NR_openat, 0xffffffffffffff9cul, "/dev/ttyS3", 0ul, 0ul);
> >   char ch = 0;
> >   syscall(__NR_ioctl, fd, 0x5412, &ch); // TIOCSTI
> >   return 0;
> > }
> >
> >
> > It does not even do any tty setup... does it point to a qemu bug?
>
> There are at least two bugs here, but both could be either in the
> kernel or in qemu:
>
> a) accessing a legacy ISA/LPC port should not result in an oops,
>     but should instead return values with all bits set. There could
>     be a ratelimited console warning about broken drivers, but we
>     can't assume that all drivers work correctly, as some ancient
>     PC style drivers still rely on this.
>     John Garry has recently worked on a related bugfix, so maybe
>     either this is the same bug he encountered (and hasn't merged
>     yet), or if his fix got merged there is still a remaining problem.
>
> b) It should not be possible to open /dev/ttyS3 if the device is
>     not initialized. What is the output of 'cat /proc/tty/driver/serial'
>     on this machine? Do you see any messages from the serial
>     driver in the boot log?
>     Unfortunately there are so many different ways to probe devices
>     in the 8250 driver that I don't know where this comes from.
>     Your config file has
>    CONFIG_SERIAL_8250_PNP=y
>    CONFIG_SERIAL_8250_NR_UARTS=32
>    CONFIG_SERIAL_8250_RUNTIME_UARTS=4
>    CONFIG_SERIAL_8250_EXTENDED=y
>    I guess it's probably the preconfigured uarts that somehow
>    become probed without initialization, but it could also be
>    an explicit device incorrectly described by qemu.


Here is fool boot log, /proc/tty/driver/serial and the crash:
https://gist.githubusercontent.com/dvyukov/084890d9b4aa7cd54f468e652a9b5881/raw/54c12248ff6a4885ba6c530d56b3adad59bc6187/gistfile1.txt

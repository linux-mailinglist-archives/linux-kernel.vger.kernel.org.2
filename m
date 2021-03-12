Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB8A338A61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhCLKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhCLKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:39:11 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:39:11 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a11so3362260qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8hB+rU3U8i3a16FibhnL4+fR0BO+F4l1PF+kFVx2sg=;
        b=DWeWxPIXzjP6CE0lwr4Jtgy8L2p+EEJyAXBsnXEa7GHvepuYx3IzLeOE4DCWhBkDM7
         GKbw5TcWhidwA1bPMcTP79NU0FEXwHshoXvbDLrOUAp/arl4Jc/gIwOCCPqCLMgsYScv
         fmLHUjQUtXBTWaXenmmJtcjj6twaN/cljwm0DA+8/NoiBmLGcAHatMwzDVPjHCyaioP3
         hBATSJ7ley0yaTBKfjCh1xoz1aCgNOd00KNGMKpUig85YgtgCkb56PEWq6OCT62H7wWq
         9tS6R0m8EOF8sykXJ6DnT0u8+wT5pHHocgCvwVmUtQHPZMNTe5jFoOqk+X2HxF1tBAmM
         C6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8hB+rU3U8i3a16FibhnL4+fR0BO+F4l1PF+kFVx2sg=;
        b=lL+ykYoFB77lU4lF6xrAo8+PEXi7vKDP4duDPmZ1Dho3Z0JrwBYeyXOQSN0wpfkSAb
         ms9upj4LEeN+DMnVWkby4a+gTvYa01jGEaYTIknAzziRGU3FrgNxzuQBFi95XOSbjVBZ
         ZqN/kYDZVtYwbHxadBseLjEHiVEvI9zawxMNnzLurHJPgtf3/rHmkQRAzkfje5eftBta
         lSbt/KGouWoBCJiZ3Pl3CGT+v1gCsWrYwc6Ss8s8b+O8fHKVAvXzxayVyrMCIg2xpqV0
         LfxR++bbJC+aZexlxnRZ45ECAC5H0IrYSacxF7U63JpfG4lUzoootjG1TDiV4WjcOHdl
         lznw==
X-Gm-Message-State: AOAM531g1CMQCel/6Qc8tZhFe9M26yMtnUb3nYtDSAySEIXSoNLS3I/p
        wbzU4s4Y3JLyLKqX9SJzxqIGxnUdJJTCZsXCvSpZWA==
X-Google-Smtp-Source: ABdhPJwZjBClxBJU+RakNGZo7qkMpjC4fo1MzVAeR4ORlDp0sn8kkkqf28qbNAaYUoXAvoAkEDZ/HRtASeaBCyoiIgY=
X-Received: by 2002:ac8:7318:: with SMTP id x24mr11123115qto.67.1615545549950;
 Fri, 12 Mar 2021 02:39:09 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com> <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
In-Reply-To: <CAK8P3a0yxbeY0z=6EQhvBN8NWF++1Cww4tRaSwrUQFt3A-BMaw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 11:38:58 +0100
Message-ID: <CACT4Y+aTbdE1CeUOgCKLJ3XpjazN5=yTmToXN_03M9EQ_hhayg@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 11:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Mar 12, 2021 at 9:46 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > On Fri, Mar 12, 2021 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Thu, Mar 11, 2021 at 6:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > a) accessing a legacy ISA/LPC port should not result in an oops,
> > > > >     but should instead return values with all bits set. There could
> > > > >     be a ratelimited console warning about broken drivers, but we
> > > > >     can't assume that all drivers work correctly, as some ancient
> > > > >     PC style drivers still rely on this.
> > > > >     John Garry has recently worked on a related bugfix, so maybe
> > > > >     either this is the same bug he encountered (and hasn't merged
> > > > >     yet), or if his fix got merged there is still a remaining problem.
> > >
> > > > > b) It should not be possible to open /dev/ttyS3 if the device is
> > > > >     not initialized. What is the output of 'cat /proc/tty/driver/serial'
> > > > >     on this machine? Do you see any messages from the serial
> > > > >     driver in the boot log?
> > > > >     Unfortunately there are so many different ways to probe devices
> > > > >     in the 8250 driver that I don't know where this comes from.
> > > > >     Your config file has
> > > > >    CONFIG_SERIAL_8250_PNP=y
> > > > >    CONFIG_SERIAL_8250_NR_UARTS=32
> > > > >    CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > > > >    CONFIG_SERIAL_8250_EXTENDED=y
> > > > >    I guess it's probably the preconfigured uarts that somehow
> > > > >    become probed without initialization, but it could also be
> > > > >    an explicit device incorrectly described by qemu.
> > > >
> > > >
> > > > Here is fool boot log, /proc/tty/driver/serial and the crash:
> > > > https://gist.githubusercontent.com/dvyukov/084890d9b4aa7cd54f468e652a9b5881/raw/54c12248ff6a4885ba6c530d56b3adad59bc6187/gistfile1.txt
> > >
> > > Ok, so there are four 8250 ports, and none of them are initialized,
> > > while the console is on /dev/ttyAMA0 using a different driver.
> > >
> > > I'm fairly sure this is a bug in the kernel then, not in qemu.
> > >
> > >
> > > I also see that the PCI I/O space gets mapped to a physical address:
> > > [    3.974309][    T1] pci-host-generic 4010000000.pcie:       IO
> > > 0x003eff0000..0x003effffff -> 0x0000000000
> > >
> > > So it's probably qemu that triggers the 'synchronous external
> > > abort' when accessing the PCI I/O space, which in turn hints
> > > towards a bug in qemu. Presumably it only returns data from
> > > I/O ports that are actually mapped to a device when real hardware
> > > is supposed to return 0xffffffff when reading from unused I/O ports.
> > > This would be separate from the work that John did, which only
> > > fixed the kernel for accessing I/O port ranges that do not have
> > > a corresponding MMU mapping to hardware ports.
> >
> > Will John's patch fix this crash w/o any changes in qemu? That would
> > be good enough for syzbot. Otherwise we need to report the issue to
> > qemu.
>
> No, this was a third issue. As far as I remember, this would result in
> a similar problem in the case where there is no PCI bus at all, or
> where no PCI host has an I/O port range, so the inb() from the serial
> driver would cause a page fault. The problem you ran into happens
> in qemu when the PCI I/O ports are mapped to hardware registers
> that cause an exception when accessed.
>
> If you just want to work around the problem for now, it should
> go away if you set CONFIG_SERIAL_8250_RUNTIME_UARTS
> to zero.

It does not happen too often on syzbot so far, so let's try to do the
right thing first.
I've filed: https://bugs.launchpad.net/qemu/+bug/1918917
with a link to this thread. To be fair, I don't fully understand what
I am talking about, I hope I proxied your description properly.

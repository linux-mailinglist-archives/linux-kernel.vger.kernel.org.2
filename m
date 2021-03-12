Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3A133887C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhCLJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbhCLJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:21:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81285C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:21:53 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l15so3932490qvl.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWKvAGiRnhLquHQ+RPB+OyLtA9yjx7WsA3FQ83tQqko=;
        b=i9hsJeYi3+tzFRPk4krMWWUhY1HpCXJ0D/YqqWplkPZ2mshdNt/WIXmi+BMURFm1ek
         92NGQ+s4yWP7DFNJuyl+jZigA/1AeNotVlYOoDPTR+9LnmYcb4Wfdb3R1Dv4qmtOn6l6
         rsMUj6tLWLT3jlu0Bbry0rsNqjVBfsfOeMnlFzqNfPykfZLdducmdgds4R4FIOHxFNIp
         0USmI4pKBnBB48q7R3HDmZ1fH2ceUFf+HheRR6sJOAdz4i+WcDG4eqXD499MjW2HcGwE
         qVi4+JyE5GA8XY2z+4XxoPVVCxWzYP0FWzxXJspDQwQW5TjXSf8q0rPrroG/FC5lc5PM
         jtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWKvAGiRnhLquHQ+RPB+OyLtA9yjx7WsA3FQ83tQqko=;
        b=EcdV4GBUmNazwW4X9vIw9GtD0eON0useqlDIY5lK5DTuJPIsWXiyaS2INZdhb7CN9C
         ym3OffS6xGLZgheIFFSqvrbwDuczf9tPkml8mYdcUd2B4XElay5MSgE/Fqlb7ZZvpGOU
         D4/2dNsKD9YlGe+HnVWaZaHjWB5Whb1kCh5SkXgZaWExPKpNfSn0vtL/JWBlTPU4B/8p
         qRl6UgeTV2SL4SWroeTRKbMZ1RQy2t3dsSyWQ2ROomQzaf4OK3yg30ulvafaSv0LZodq
         a9wS0/UeGEgOs6ttmYxV9eec6tsOHlgj2oqi61XJ3JHnV6+yrFrWZQVNaSQmv322TrO9
         ZwKg==
X-Gm-Message-State: AOAM533szvGjYP1eKyiXo4tp7Xyqjy+eQ0lHSo9hdkqGDo+KIm2AyZP9
        hga9e1RmvhXvjFlIJ7FsjiJgjgEXyHLZ2mmIKH1/kQ==
X-Google-Smtp-Source: ABdhPJxYPfouFkVCOeRhsDnMKiSIax5m+QDb5njgcWNdWGbe/nsCXQ+TT3awq0ZqdrH2MV6P+r1/AJrBYuGu9XRuY4w=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr11587575qva.18.1615540912497;
 Fri, 12 Mar 2021 01:21:52 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com> <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
In-Reply-To: <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Mar 2021 10:21:41 +0100
Message-ID: <CACT4Y+bLdCw+nWndwnv6W9=0EhNNxi=n5Zp032hZE1j0QBMkaA@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 10:16 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 12, 2021 at 9:46 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Fri, Mar 12, 2021 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Mar 11, 2021 at 6:57 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > a) accessing a legacy ISA/LPC port should not result in an oops,
> > >     but should instead return values with all bits set. There could
> > >     be a ratelimited console warning about broken drivers, but we
> > >     can't assume that all drivers work correctly, as some ancient
> > >     PC style drivers still rely on this.
> > >     John Garry has recently worked on a related bugfix, so maybe
> > >     either this is the same bug he encountered (and hasn't merged
> > >     yet), or if his fix got merged there is still a remaining problem.
>
> > > b) It should not be possible to open /dev/ttyS3 if the device is
> > >     not initialized. What is the output of 'cat /proc/tty/driver/serial'
> > >     on this machine? Do you see any messages from the serial
> > >     driver in the boot log?
> > >     Unfortunately there are so many different ways to probe devices
> > >     in the 8250 driver that I don't know where this comes from.
> > >     Your config file has
> > >    CONFIG_SERIAL_8250_PNP=y
> > >    CONFIG_SERIAL_8250_NR_UARTS=32
> > >    CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> > >    CONFIG_SERIAL_8250_EXTENDED=y
> > >    I guess it's probably the preconfigured uarts that somehow
> > >    become probed without initialization, but it could also be
> > >    an explicit device incorrectly described by qemu.
> >
> >
> > Here is fool boot log, /proc/tty/driver/serial and the crash:
> > https://gist.githubusercontent.com/dvyukov/084890d9b4aa7cd54f468e652a9b5881/raw/54c12248ff6a4885ba6c530d56b3adad59bc6187/gistfile1.txt
>
> Ok, so there are four 8250 ports, and none of them are initialized,
> while the console is on /dev/ttyAMA0 using a different driver.
>
> I'm fairly sure this is a bug in the kernel then, not in qemu.
>
>
> I also see that the PCI I/O space gets mapped to a physical address:
> [    3.974309][    T1] pci-host-generic 4010000000.pcie:       IO
> 0x003eff0000..0x003effffff -> 0x0000000000
>
> So it's probably qemu that triggers the 'synchronous external
> abort' when accessing the PCI I/O space, which in turn hints
> towards a bug in qemu. Presumably it only returns data from
> I/O ports that are actually mapped to a device when real hardware
> is supposed to return 0xffffffff when reading from unused I/O ports.
> This would be separate from the work that John did, which only
> fixed the kernel for accessing I/O port ranges that do not have
> a corresponding MMU mapping to hardware ports.

Will John's patch fix this crash w/o any changes in qemu? That would
be good enough for syzbot. Otherwise we need to report the issue to
qemu.

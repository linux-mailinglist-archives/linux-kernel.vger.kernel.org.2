Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14A534463A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhCVNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:52:22 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37222C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:52:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so21379429ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7ClNO/+gp8fBJb8xLreTzvK/s1Bn78lVmoVSnGgBDw=;
        b=QUQeXUlUC6L4PtBJkR0BcrtU9V7Aj7cqaODt01xBZ2gtGeRqq+ENm4tDjFPqQQIYxE
         229KbbJjNIAgvdWE9tDD4PFj9iAfZ3M9y/IvmiSy5bevmo/CO7hMwruE8KAF93Ea3Fgu
         i3HT++98PnjJ0sCKy8wuoNsocknMyFknJ7VYcvzY+FcB56ClRee3qnCcpx/o9A47xfiv
         eU1MgPYx44iJM9QYMYO9pAMqfDhMKb33oWQMrjOQT6o1GGdpuauyWkTYzhsanairmPuv
         GPKZP7pwCPCpOHnRm9l5H6cFWOnthTTQg6CLw8jqbRuYKL1nmvOqbEkX40b4hDP2b0Xi
         ypnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7ClNO/+gp8fBJb8xLreTzvK/s1Bn78lVmoVSnGgBDw=;
        b=F6GeuNZaju7oTrVWyhk0pLOJlo6OmpNqdESxo7Ok3H+r+UPrQEKq+tVGxaDar05UhD
         kHUI2ZiJBcoFWAxWuYYaGuqwe//lyGQieMMGrjbojDvfSgTNsK4b9RqRmTvd/XqMhJVw
         U9lYXONpZQSUKOJ1HTtssSlEw33VYMS4PdhvZC90+iS6QvIoDNWsosMF/esktgUgMbPK
         txRTeklG0wJdnjANP+vX86rpYiHoPJKW6De34xX7e4jRi5t7tPrUgU1CUI16sUMuaFbt
         iqeXuvjUcODZEvMBMwvZ29q5QmrszCPDaybZNYBQ0KtopdLnbQvS+uVIe4jYyCNvsos3
         LQfw==
X-Gm-Message-State: AOAM533vUQlvgItxbEBWlpqPvEvFTHwcZKKQW9sd1XW9kML9J5ukUmlr
        g/EYGQexbWpLZ30qKsuMqq07RtjTg/+ZIZUWQEFReA==
X-Google-Smtp-Source: ABdhPJxIkvEStRl4Aps4NTecQkEIhxM65h8ku7s6zQwhOyD5ohptY6o2W89QrBB9BGzO0IngwOG40gu2SN6Vl2LfXmI=
X-Received: by 2002:a17:906:8a65:: with SMTP id hy5mr19838553ejc.250.1616421140964;
 Mon, 22 Mar 2021 06:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com> <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com>
In-Reply-To: <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 22 Mar 2021 13:51:52 +0000
Message-ID: <CAFEAcA-oH=9RLdzhsLcSTxNLBLcyEcJtO4L5EqRSiGWHdApgqA@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     Arnd Bergmann <arnd@arndb.de>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 at 19:00, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 20, 2021 at 9:43 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 12 Mar 2021 at 09:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > > So it's probably qemu that triggers the 'synchronous external
> > > abort' when accessing the PCI I/O space, which in turn hints
> > > towards a bug in qemu. Presumably it only returns data from
> > > I/O ports that are actually mapped to a device when real hardware
> > > is supposed to return 0xffffffff when reading from unused I/O ports.
> >
> > Do you have a reference to the bit of the PCI spec that mandates
> > this -1/discard behaviour for attempted access to places where
> > there isn't actually a PCI device mapped ? The spec is pretty
> > long and hard to read...
> >
> > (Knowing to what extent this behaviour is mandatory for all
> > PCI systems/host controllers vs just "it would be nice if the
> > gpex host controller worked this way" would help in figuring
> > out where in QEMU to change.)
>
> I spent some more time looking at both really old PCI specifications,
> and new ones.
> The old PCI specs seem to just leave this bit as out of scope because
> it does not concern transactions on the bus. The PCI host controller
> can either report a 'master abort' to the CPU, or ignore it, and each
> bridge can decide to turn master aborts on reads into all 1s.
> We do have support some SoCs in Linux that trigger a CPU exception,
> but we tend to deal with those with an ugly hack that just ignores
> all exceptions from the CPU. Most host bridges fortunately behave
> like an x86 PC though, and do not trigger an exception here.

There's apparently a bit in the PCI spec that reads:
        The host bus bridge, in PC compatible systems, must return all
1's on a read transaction and
        discard data on a write transaction when terminated with Master-Abort.

which obviously applies only to "PC compatible systems".

> In the PCIe 4.0 specification, I found that the behavior is configurable
> at the root port, using the 'RP PIO Exception Register' at offset 0x1c
> in the DPC Extended Capability. This register defaults to '0', meaning
> that reads from an unknown port that generate a 'Unsupported Request
> Completion' get turned into all 1s. If the firmware or OS enables it,
> this can be turned into an AER log event, generate an interrupt or
> a CPU exception.
>
> Linux has a driver for DPC, which apparently configures it to
> cause an interrupt to log the event, but it does not hook up the
> CPU exception handler to this. I don't see an implementation of DPC
> in qemu, which I take as an indication that it should use the
> default behavior and cause neither an interrupt nor a CPU exception.

Hmm, maybe. We should probably also implement -1/discard just because
we're not intending to have 'surprising' behaviour.

TBH I'm having difficulty seeing why the kernel should be doing
this at all, though. The device tree tells you you have a PCI
controller; PCI supports enumeration of devices; you know exactly
where everything is mapped because the BARs tell you that.
I don't see anything that justifies the kernel in randomly
dereferencing areas of the IO or memory windows where it hasn't
mapped anything. You shouldn't be probing for legacy ISA-port
devices unless you're on a system which might actually have them
(eg an x86 PC).

thanks
-- PMM

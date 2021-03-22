Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C49344C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCVQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCVQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:49:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A702C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:49:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r12so22422935ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXJ5Sar/Ifz6JJAimj38gRVDAr3OzSV/gaJ8wXJmb9M=;
        b=LW9du4C9WPfXG+G3KZi3P6ozsF9gt4VrbAR4Z62UoD7bHlHwHdeQB3vQ53Ci/uZrnM
         MCj6yCTpxhDpbCzv7Huqey/XxpEVNrkqnz+LIJg8hRLGIeATT4Jyu5l3a98TeAgR0aOk
         Eqx37cgwY3RQze7KoCi4XrLF3XH19tHN5MKZVnCnB9OD/Nd/fkkpUT54zJ0KEONLiCNy
         ubuzzVqkcvIrVQgwmRwnPKLJzTtyUzZL5Kmvm57shs3hdriNL/IV6SXe49tenbBIZB6+
         kfe2MdDtVqw245DnHwSXblRbUr9RjfFer7rM588aqSzblIgHPG0vU12qMtyRTWM/TiJL
         JDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXJ5Sar/Ifz6JJAimj38gRVDAr3OzSV/gaJ8wXJmb9M=;
        b=KsuOKVtt/CUo0EFB4Fi3EUsMV9YZSMyVINyXjTPQy/iGvOoT0SeZIkSvW7HYG6dBNr
         yRohR/Un73AweZXfZauR0qZELg9vV6nxxkCrPbo9M1QNmM8WDsrahzWtVXaPVXf/1Oed
         V6ivf501OgkY5uWNYS3arAQN8TwNMw2YRzbuavI7+AccgAZPKb/+cEYfZ8PnINls5PbQ
         ZB0G1F0uT+xTGqxanNni5LvrBcfxxDNVwCqMLqbGqT6f7HXnVMDVW6Z0stEN3BKIjcgy
         0ii/rztYVaRgbhFLBRLKM94+PyFIdL8p/jrGjoaS5dtdnLxQylW620g2kZgFCCpL8hs0
         ZWtA==
X-Gm-Message-State: AOAM533Yh4gc6oQ2Jk/FB3L7ZHt60NknWI+1v/gLLUQ8kwXHxocP1asC
        iGHJ5JVxgEyJ1395WrRJwNbGdktfxDvwVCPZ2Lwoig==
X-Google-Smtp-Source: ABdhPJwMTly+dnvGOZCcyUiuvTg4XNpbJvl0rmYqw0PzBbiRyF066Lh4cY57dwH0UfNGxEzShtwgHYkpi8rizqlJ3j4=
X-Received: by 2002:a17:906:8a65:: with SMTP id hy5mr753913ejc.250.1616431792272;
 Mon, 22 Mar 2021 09:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+beyZ7rjmy7im0KdSU-Pcqd4Rud3xsxonBbYVk0wU-B9g@mail.gmail.com>
 <CAK8P3a1xBt6ucpVMhQrw4fGiLDZaJZ4_kn+qy9xAuykRRih6FA@mail.gmail.com>
 <CACT4Y+YeeEkF65O40DMLB=cggiowZUxXDs++BNTrDMO94j=NvA@mail.gmail.com>
 <CAK8P3a0HVu+x0T6+K3d0v1bvU-Pes0F0CSjqm5x=bxFgv5Y3mA@mail.gmail.com>
 <CACT4Y+aWMD283vYMfoGM1fir_fPF7MPqe+vLjaoQD2iZUV4c-A@mail.gmail.com>
 <CAK8P3a2NEcHG+nOUCc6-DPeFKkc-GF-LEOkynhNdgxiXBHdQaw@mail.gmail.com>
 <CAFEAcA-s79=4VDSA3TO8tpLUMwJE=HcFT4eZO8L8CCkAAfj8PA@mail.gmail.com>
 <CAK8P3a26dWjbS8CjGwc7S5S0M4SonWh4afqdxpoa8Q9vQhC0TA@mail.gmail.com>
 <CAFEAcA-oH=9RLdzhsLcSTxNLBLcyEcJtO4L5EqRSiGWHdApgqA@mail.gmail.com>
 <CAK8P3a2aQ0C7M2p3DBwjvK5mGyg2_8PQK2=FnkPFp3bVmt_xMw@mail.gmail.com> <771d89a8-b7e0-6095-b101-e7ae91bcdc85@huawei.com>
In-Reply-To: <771d89a8-b7e0-6095-b101-e7ae91bcdc85@huawei.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 22 Mar 2021 16:49:24 +0000
Message-ID: <CAFEAcA9d5NLUcn_wdj=pUWEW9arRcZnOwUuqtoSep=FSjpB_Tw@mail.gmail.com>
Subject: Re: arm64 syzbot instances
To:     John Garry <john.garry@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 at 16:36, John Garry <john.garry@huawei.com> wrote:
>
> >>
> >> There's apparently a bit in the PCI spec that reads:
> >>          The host bus bridge, in PC compatible systems, must return all
> >>          1's on a read transaction and discard data on a write transaction
> >>          when terminated with Master-Abort.
> >>
> >> which obviously applies only to "PC compatible systems".
> >
> > Right. As far as I can tell, all ARMv8 and most ARMv7 based SoCs
> > do this to be more compatible with PC style operating systems like
> > Linux, but you are right that the specification here does not
> > mandate that, and the older ARMv5 SoCs seem to be compliant
> > as well based on this.

> >> TBH I'm having difficulty seeing why the kernel should be doing
> >> this at all, though. The device tree tells you you have a PCI
> >> controller; PCI supports enumeration of devices; you know exactly
> >> where everything is mapped because the BARs tell you that.
> >> I don't see anything that justifies the kernel in randomly
> >> dereferencing areas of the IO or memory windows where it hasn't
> >> mapped anything.
>
> BIOS has described a CPU-addressable PIO region in the PCI hostbridge,
> and the kernel has mapped it:
>
> [    3.974309][    T1] pci-host-generic 4010000000.pcie:       IO
> 0x003eff0000..0x003effffff -> 0x0000000000
>
> So I don't see why any accesses there should fault.

As requested above, do you have the PCI spec reference for
why the PIO region is supposed to do -1/discard for parts of
the PIO region where the kernel hasn't mapped any devices ?
For classic PCI, at least, the spec does not seem to mandate it.

thanks
-- PMM

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8849730ECCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 07:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhBDG5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 01:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhBDG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:57:06 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1588C0613D6;
        Wed,  3 Feb 2021 22:56:25 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id p15so1623585ilq.8;
        Wed, 03 Feb 2021 22:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7RG/t0VIp1YIh84HtpnpszNv3Gn4YzPZngUDm90mxto=;
        b=M8FFirN5QdkpH7EsV4KpqXBO8of1/P+RSj5BsBbXtDN/uwyv+vvCt7dLmNzJTJ7R8k
         E+BiNUGRUoDtxf+1IslNuGUgjdL4MYaj0sfhc6UWtZK9kke48oZ44JpjHyr5qa8zk+WE
         l3Fr3zVvEg6Qae5S3IY5qTtDrjDsaP6rKA0yNZOaED1Lx2pFHfQZC0lzZQmgFaUNwyip
         21bBEI6RgQclXbZIxKGzPnYNC3ZXK9wowmoeVyypI7FGoCzkQp5Ja8CebnT0NzKsKfQD
         vOaBrILmb9dDylcqzsNfGxCUT4U5Q1NsQmB6CyySEhHS5Fm+nGQTxh2NbLlBcO+gOCGh
         5EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7RG/t0VIp1YIh84HtpnpszNv3Gn4YzPZngUDm90mxto=;
        b=GZVCwMNWEGCq3rCChx9mGUOBYyFr4dNIN8tRwtWSipGj5kV2mQ6NzW3Pfx8XmtTVL2
         +dGCzot+fS7ci48cdkfNgq2vw5WPEQMqLAVhOw9IIhZVFkC2XqkiXDpMeZx5fOmbhH++
         su7Myq5tJ0QBoV/NLPEdKIOv+fQ9V/rg2TQIbtpAN1HOMMdF2JgceSPPSwwjZ+vSzCIU
         bJjByZ09IKQVC/3lh88qkFIJsoQwfTPFeYBqs8vOZkUdhdISC9XyaqjZS7CRbvIOnVAw
         f7Raf3bjNz9ACyU3ocuOcu49fHJ22xsSIFjktR9FeK6Uu0TLGaKxWp6hMWZ0iwsZ5NPV
         FElw==
X-Gm-Message-State: AOAM530s0j85NhN7fHECk/0axcn4CWEbMRs/dBEC4c+9/YSEgzZ/aOsR
        X9ekP0nW2RzXTgb17ob2deIGtlkyzOT6iHN4Ngo=
X-Google-Smtp-Source: ABdhPJzjMjHgBVpgg/0wfoFoO6F7n7PlmdrvzqcGqbUl812vPWli4bl8uZqkgy02WdYLkmkstRmBUdJO3l9YGaUnQUE=
X-Received: by 2002:a92:4b06:: with SMTP id m6mr5903984ilg.177.1612421785418;
 Wed, 03 Feb 2021 22:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20210117180301.1956-1-alistair@alistair23.me> <20210117180301.1956-3-alistair@alistair23.me>
 <20210129071341.GH4356@dragon> <CAKmqyKOoTG+BGhRFtppQxnaV61GFxXXhmZJcxqGQVbnuV1PfqA@mail.gmail.com>
 <CAK8P3a1ZLuDTKY6YbPrcM338K4vmAgESeBiNwWN7VaWj2PtKFg@mail.gmail.com>
In-Reply-To: <CAK8P3a1ZLuDTKY6YbPrcM338K4vmAgESeBiNwWN7VaWj2PtKFg@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 3 Feb 2021 22:55:58 -0800
Message-ID: <CAKmqyKPukAOA5rw2c6cjGKmoTo5HFudtwS4_6P7DGCiGGHGbgA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/arm/configs: Enable VMSPLIT_2G in imx_v6_v7_defconfig
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 11:50 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Feb 3, 2021 at 3:37 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 11:13 PM Shawn Guo <shawnguo@kernel.org> wrote:
> > >
> > > On Sun, Jan 17, 2021 at 10:03:01AM -0800, Alistair Francis wrote:
> > > > The reMarkable2 requires VMSPLIT_2G, so lets set this in the
> > > > imx_v6_v7_defconfig.
> > >
> > > Hmm, why is VMSPLIT_2G required by reMarkable2?
> >
> > I'm not too sure. It's difficult to debug problems as I only have a
> > UART but without this I don't see any kernel prints so it seems like
> > the kernel doesn't get very far. I haven't had any luck with earlycon
> > on the device so I don't know how I can get more information.
>
> In the dts file, I can see that the machine has 1GB of RAM at
> contiguous addresses. My first guess would be a problem with
> highmem, as this configuration means that with VMSPLIT_3G
> there are 768MB of lowmem and 256MB of highmem.
>
> Can you try these two things to narrow the problem down
> further?
>
> a) disable CONFIG_HIGHMEM when using VMSPLIT_3G
> b) use VMSPLIT_3G_OPT

Thanks Arnd,

I was working on testing the config changes you mentioned, but it
seems like all of them work now.

VMSPLIT_2G: Boots to userspace

VMSPLIT_3G && HIGHMEM: Boots to userspace

VMSPLIT_3G && !HIGHMEM: Boots to userspace

VMSPLIT_3G_OPT && HIGHMEM:Boots to userspace

>
> If both of them solve the problem, then highmem is likely
> the root cause. One possible issue might be that the boot
> loader loads the initramfs or the dtb into a location outside
> of the first 768 MB of lowmem where it is unreachable
> in the VMSPLIT_3G configuration.

It boots with u-boot, which I am building so I can change these addresses.

I'm guessing that I have changed the addresses at some point and now
it works. I'm going to drop this patch.

Alistair

>
>         Arnd

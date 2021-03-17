Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55B433F0B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 13:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCQMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 08:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhCQMyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 08:54:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D29764F18;
        Wed, 17 Mar 2021 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615985636;
        bh=CVep1gbTRjB+20m1ldxk7nAxwnahqYPj6MrXsgFKflU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c+Ia7ho3BJjFBeMI2Egh7Zx9fvN/L8WcXrUhW9ph740iN/61320WJXT/EFP7xg6Ng
         j7QOl03dNCiTNjbmjzB3vmb8jrrNF4j4saNJkAsNz1i4r5GSZvBp78L4kNzDqudBdL
         py49RkV9imRMSnaQtABut0pOlV2T60UlOf7BLyb4=
Date:   Wed, 17 Mar 2021 13:53:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, lkft-triage@lists.linaro.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Yan <yanaijie@huawei.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Oliver Neukum <oneukum@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: BUG: KFENCE: memory corruption in usb_get_device_descriptor
Message-ID: <YFH74Y6QfofcMOkv@kroah.com>
References: <CA+G9fYsKBLOvvxOfB6AAzjarsABQiEUhGd4JB3FDq3q1OrFmOw@mail.gmail.com>
 <YFHUGG6AWGt/C8C+@kroah.com>
 <CA+G9fYv9kwQDYzzA1e=c8kg1wWQ1MwKtintBvyqMiKG5S+ggqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYv9kwQDYzzA1e=c8kg1wWQ1MwKtintBvyqMiKG5S+ggqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 04:56:15PM +0530, Naresh Kamboju wrote:
> On Wed, 17 Mar 2021 at 15:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Mar 17, 2021 at 02:28:40PM +0530, Naresh Kamboju wrote:
> > > While booting Linux mainline master 5.12.0-rc2 and 5.12.0-rc3 on arm64
> > > Hikey device the following KFENCE bug was found.
> > >
> > > Recently, we have enabled CONFIG_KFENCE=y and started seeing this crash.
> > > kernel BUG log:
> >
> > What USB traffic are you having here?
> 
> This is  getting triggered while booting the device.
> We are not running any traffic.

Ah, so this is device probe time.

> > And has this ever not triggered?
> 
> No.
> It was not triggered before.
> Since CONFIG_KFENCE=y is added to our builds recently we are able to
> reproduce always on recent builds.
> 
> Steps to reproduce:
> 1) Build arm64 kernel Image with this given config.
>       - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-9
> --kconfig defconfig --kconfig-add
> https://builds.tuxbuild.com/1pfztfszUNcDwOAyMrw2wPMKNfc/config
> 2) Boot arm64 hikey hi6220 device
> 3) While booting the device you will get to see this kernel BUG:
> 
> [   18.243075] BUG: KFENCE: memory corruption in
> usb_get_device_descriptor+0x80/0xb0
> [   18.813861] BUG: KFENCE: memory corruption in
> __usbnet_read_cmd.isra.0+0xd0/0x1a0

There was a warning before this, from the hub code, when reading from
this device as well.  Perhaps this is just a side affect of the real
memory corruption issue somewhere else?

Bisection would be nice, but I'm placing odds on this always being an
issue here in this driver code...

thanks for the report.

greg k-h

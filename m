Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4C135A24A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDIPu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhDIPu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72AD761042;
        Fri,  9 Apr 2021 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617983413;
        bh=F6dOTV7avDP3ofhEidxw/zMb+uU/iXMccst0qahQ63I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Woj62dkcUIP3wY+pIKcBe1uBGMLn0sIwgolXQGxIUbaGctU2xtQ5PwZTIlJb/BhxZ
         Xx/z5cVb8CMDt4E4PZNBKeGefVfpB4VETWkD9aAq6JBlS26ZIwYYjWvcajHNgIFuf7
         y7owg/9f+Pr2ee/Wigw//NRldqPwu7OdVZg/YgZcuW350p7iAtzYbEL2SDLscNuOzm
         JKgUBjG3dCSVA+8PkDhGkyaBHak8dgEX2hlu9dhjhxro6Y0j/sT/PXav/MXRtVPQ1W
         TAg4n/cPUu5K/MNjznFD+2RbS6r1LJ+JR7rFZ4rEzZObYZR39f3V1koABucCz6v/2I
         0AwX6kZzD2t0A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lUtOc-0008Gq-3j; Fri, 09 Apr 2021 17:50:10 +0200
Date:   Fri, 9 Apr 2021 17:50:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pho Tran <photranvan0712@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hung.Nguyen@silabs.com" <Hung.Nguyen@silabs.com>,
        "Tung.Pham@silabs.com" <Tung.Pham@silabs.com>,
        Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v8] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YHB3sma1onbZboGv@hovoldconsulting.com>
References: <20210406101850.3111-1-photranvan0712@gmail.com>
 <CAHp75Vf8jwhLkaHL2D6FvRJpmbBqpTzePpNqVAFVt8EhSCgxnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf8jwhLkaHL2D6FvRJpmbBqpTzePpNqVAFVt8EhSCgxnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:25:00AM +0300, Andy Shevchenko wrote:
> On Tuesday, April 6, 2021, Pho Tran <photranvan0712@gmail.com> wrote:

> > Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functions
> > will be different from other CP210x devices. So need to check part number
> > of the device to use correct data format  before sending commands to
> > devices.
> >
> > Like CP2104, CP2108 have GPIO pins with configurable options. Therefore,
> > should be mask all pins which are not in GPIO mode in cp2108_gpio_init()
> > function.

> This I didn’t get. If you are talking about usage pin as GPIO, perhaps you
> should use valid_mask in GPIO chip structure. Otherwise you probably need
> to implement a proper pinmux ops for this (and register a pin controller
> which the code below also suggests).

Neither is needed here.

Using a valid mask is a new feature and isn't a prerequisite for adding
support for the GPIOs on cp2108. I've been meaning to implement that
since we started using it for ftdi_sio, and I'll be posting that
shortly.

The cp2108 pin configuration can't be changed at runtime, but even if it
was it's not clear what the pinctrl subsystem would buy us for a
hotpluggable USB device currently (even if devicetree could be used for
static topologies).

I'll look at the rest of this thread and the latest version of this
patch next week.

Johan

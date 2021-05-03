Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF817371714
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhECOvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhECOvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:51:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97018611C9;
        Mon,  3 May 2021 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620053416;
        bh=TAAj8JUMZ5Ge/N8UGgRC7jVXZ0TWnJ829jWlzKcUXOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqH0g44uqju/ZM8wf4P4iop0EwCVDwqXsrTSumFPFgtyNG0fHbeoh3i8avYG+m+Yz
         EgCEQ+3tjm6oT+NAetDC6DW0Rfqhx629BnCX2jzlpgC4wAHk9GqNvHoZigobcEGF3b
         wsBZMHAsud0jQx9NfbE72TMwi36o7V1Kr8YcD7DA=
Date:   Mon, 3 May 2021 16:50:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <linux@roeck-us.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Small devm helper for devm implementations
Message-ID: <YJANpeOmfTpQoVM0@kroah.com>
References: <e8221bff-3e2a-7607-c5c8-abcf9cebb1b5@free.fr>
 <69f6f7fc-4fb6-248a-684a-b853ee0836bc@free.fr>
 <3fea884b-05d3-ff67-b9fe-41c9b46cf478@free.fr>
 <20200706195758.GA100842@kroah.com>
 <23a476f9-8ea3-566e-be5e-5237fb14bb91@free.fr>
 <20200723150030.GA2515799@kroah.com>
 <ddfff98f-ebd5-fa25-e4d4-6f3a7cafa132@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddfff98f-ebd5-fa25-e4d4-6f3a7cafa132@free.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 02:08:33PM +0200, Marc Gonzalez wrote:
> On 23/07/2020 17:00, Greg Kroah-Hartman wrote:
> 
> > On Tue, Jul 21, 2020 at 09:10:23AM +0200, Marc Gonzalez wrote:
> > 
> >> On 06/07/2020 21:57, Greg Kroah-Hartman wrote:
> >>
> >>> Given the lack of testing of the patch, it doesn't seem wise to add
> >>> this, right?
> >>
> >> You're probably not wrong :)
> >>
> >>> Please get some testing, and some more users, and I'll be glad to
> >>> consider it.
> >>
> >> "Users" == files modified to use the new helper?
> > 
> > Yes.
> > 
> >> How many files would you suggest? 3? 5? 10?
> > 
> > How many do you see that can use it?  I would suggest "all" :)
> 
> Hello Greg (and everyone on the CC list),
> 
> I'm getting the itch to work on this patch-set again.
> 
> To recap: I wrote a tiny devm helper.
> It's a trivial wrapper around devres_alloc() + devres_add()
> which releases the resource when devres_alloc() fails.
> That's all there is to it.
> 
> Despite its triviality, the helper allows writing simpler code
> in drivers using devm, and generates smaller object code,
> so I think it's quite useful.
> 
> 
> With all that being said, I'm a bit concerned by Greg's "all" answer.
> 
> $ git grep '= devres_alloc' | wc -l
> 173
> 
> $ git grep -c '= devres_alloc' | wc -l
> 103
> 
> There are 173 calls to devres_alloc across 103 files.
> 
> It looks (to me) too risky to change everything in a single patch-set.
> 
> Perhaps we could define a few frameworks that would get the improvement
> as a first step?
> 
> $ git grep '= devres_alloc' v5.12 | grep -o 'v5.12:[[:alnum:]]*/[[:alnum:]]*' | uniq -c
>       1 v5.12:Documentation/driver
>       3 v5.12:drivers/ata
>      11 v5.12:drivers/base
>       1 v5.12:drivers/bus
>       1 v5.12:drivers/char
>      13 v5.12:drivers/clk
>       1 v5.12:drivers/counter
>       4 v5.12:drivers/devfreq
>       2 v5.12:drivers/dma
>       4 v5.12:drivers/extcon
>       2 v5.12:drivers/firmware
>       4 v5.12:drivers/fpga
>       8 v5.12:drivers/gpio
>       1 v5.12:drivers/gpu
>       2 v5.12:drivers/hid
>       2 v5.12:drivers/hwmon
>       3 v5.12:drivers/hwspinlock
>       1 v5.12:drivers/i2c
>      12 v5.12:drivers/iio
>       2 v5.12:drivers/input
>       1 v5.12:drivers/interconnect
>       5 v5.12:drivers/leds
>       1 v5.12:drivers/macintosh
>       1 v5.12:drivers/mailbox
>       2 v5.12:drivers/media
>       2 v5.12:drivers/mfd
>       1 v5.12:drivers/mtd
>       3 v5.12:drivers/mux
>       6 v5.12:drivers/net
>       1 v5.12:drivers/ntb
>       3 v5.12:drivers/nvmem
>       1 v5.12:drivers/of
>       4 v5.12:drivers/pci
>       5 v5.12:drivers/phy
>       3 v5.12:drivers/pinctrl
>       2 v5.12:drivers/platform
>       4 v5.12:drivers/power
>       3 v5.12:drivers/pwm
>       6 v5.12:drivers/regulator
>       1 v5.12:drivers/remoteproc
>       3 v5.12:drivers/reset
>       3 v5.12:drivers/spi
>       2 v5.12:drivers/staging
>       3 v5.12:drivers/thermal
>       1 v5.12:drivers/tty
>       1 v5.12:drivers/uio
>       2 v5.12:drivers/usb
>       2 v5.12:drivers/video
>       1 v5.12:drivers/watchdog
>       1 v5.12:kernel/dma
>       1 v5.12:kernel/iomem
>       5 v5.12:kernel/irq
>       1 v5.12:kernel/reboot
>       2 v5.12:kernel/resource
>       3 v5.12:lib/devres
>       1 v5.12:lib/genalloc
>       1 v5.12:mm/dmapool
>       2 v5.12:net/devres
>       1 v5.12:sound/hda
>       6 v5.12:sound/soc
>       1 v5.12:tools/testing
> 
> 
> Perhaps I could take a look at all the subsystems/frameworks that you maintain, Greg?
> What do you think?

Just do a few, not all to start with by any means.  Just examples of how
this will be used to show if it really does make things better or not.

And sure, do USB and TTY to start with if that makes it easier.

thanks,

greg k-h

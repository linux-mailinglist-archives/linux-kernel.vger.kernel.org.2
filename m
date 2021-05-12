Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF4437B9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhELJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhELJ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:56:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90D2B613C4;
        Wed, 12 May 2021 09:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620813321;
        bh=LTvCbc3XEBABcTRaXQBhanBHLn9QZv/OYuAGN9dS2yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2JAVgG7CsbD+gCbeSchnbZtKlWzuJ9oIDY2k64eRs/evaD5d0mmzjLlmMLtB8CWT
         UGLh2+Jv99FG5h72e86dpjawpe8KxEnvdz3hdqeyAlAZJbqnZP1gHFby6fmaFT/W7i
         1dIu7OnPvaq4PcQBHi0qH96iCiKt4XdUviyK5dibBSNevYuVC4zpytBiWxNlFhK1hr
         mh9xhFAGuiv83dTxr5m0eBqX0A0krahuKwAU8A+6TgSnJbFeBAKzPT2PxO3Ef2wU8B
         TnrNY0979ZQA9MQwVg+Giyt2+RZb9+DE0GTvQRRY40KFFjPY19pUqplJyuDm//fKd2
         Nw3i8i3loqj7w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lglaO-0004HW-4X; Wed, 12 May 2021 11:55:24 +0200
Date:   Wed, 12 May 2021 11:55:24 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Frank Zago <frank@zago.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, linux-usb@vger.kernel.org,
        gunar@schorcht.net
Subject: Re: [PATCH v2 1/2] Revert "USB: serial: ch341: add new Product ID
 for CH341A"
Message-ID: <YJumDN4w4KS3Iuap@hovoldconsulting.com>
References: <20210423002852.3904-1-frank@zago.net>
 <YJjjfx49nCflzFbR@hovoldconsulting.com>
 <8b3c348f-9e05-29f9-9197-8ddf1c8a9e8b@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3c348f-9e05-29f9-9197-8ddf1c8a9e8b@zago.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 08:07:31PM -0500, Frank Zago wrote:
> Hello,
> 
> On 5/10/21 2:40 AM, Johan Hovold wrote:
> > On Thu, Apr 22, 2021 at 07:28:51PM -0500, Frank Zago wrote:
> >> From: frank zago <frank@zago.net>
> >> 
> >> The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is 
> >> still present but only the TX and RX pins are available; DTS, DTR, 
> >> ... are used for other things. Remove the PID, and let a I2C
> >> driver bind to it.
> >> 
> >> Existing CH341 boards usually have physical jumpers to switch 
> >> between the 3 modes.
> >> 
> >> This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.
> > 
> > You can't just revert something which people clearly depend on and 
> > therefore added to the kernel in the first place.
> 
> That device in UART mode was already supported by the serial driver. The 
> original submitter just had to move a jumper on his board. There was no 
> need to patch the kernel.

How do you know that the author used a dev board? And are you really
sure that there are no devices out there which always operate in this
mode?

> That product ID also supports UART but in a limited way, as only the RX and TX
> pins are available. However it is the only one that supports i2c/spi/gpio, and
> that's why I have to revert the patch. 

I understand why you did it. My point is that you cannot just claim that
PID and say that it's only to be used for I2C/SPI without even trying to
make a case for why that should be ok.

> If that's desired, the new driver could add support for that as well, but I don't
> think it's worth the effort.

We obviously don't want a second serial driver for these devices.

> > Can you reprogram the device with a newly allocated PID to be used 
> > for i2c-only instead?
> 
> It is possible if the device has an SPI flash connected to it, but none of
> the cheap boards have that.

That's unfortunate. In principle, your approach is the right one, that
is, to use a dedicated PID do determine when to configure an alternate
mode. But since we already know that some people are using the PID in
question in serial mode, it's not that clear cut.

How do you intend to switch between i2c and spi mode?

Johan

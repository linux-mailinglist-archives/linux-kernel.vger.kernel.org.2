Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE837F6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhEMLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233389AbhEMLc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:32:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61C00613F7;
        Thu, 13 May 2021 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620905479;
        bh=tSHcTdtxqpZhO0fwyWQ/F7OH1QZHG+4XchP3m2NFC38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSLqFJ+oj90m3qeW5CpRVYyVQfOE6KVffNjrtjChwH2vd7oRum0DpLpINaMt2vmWo
         H/Jg1cGfYNulbp/nIg7xrZZ99fpb4Pa6vnQmYGP+fTmr/co2tiqrGa0hNK3XmG5mbR
         I8VuTQ2e8d8uLm8SLKLw3EDMrKUYuuPAeLBU85ib2S44uvxFCZxG9YKwWZwMiDx3E0
         HtV3EKt2m3LLsnqUo0BINhClzgL6jEVWguty81WauiEIir+SfUfojybYzkTRuntyZJ
         TnTVhTkg2gBnuop+0XpaBLfQIRxlueAlCQOyoDIfeGE1j8ItmDPjPQKGHJKF29I68P
         gHT2fQ4EQ9G4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lh9Yn-0006OM-MC; Thu, 13 May 2021 13:31:21 +0200
Date:   Thu, 13 May 2021 13:31:21 +0200
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
Message-ID: <YJ0OCS/sh+1ifD/q@hovoldconsulting.com>
References: <20210423002852.3904-1-frank@zago.net>
 <YJjjfx49nCflzFbR@hovoldconsulting.com>
 <8b3c348f-9e05-29f9-9197-8ddf1c8a9e8b@zago.net>
 <YJumDN4w4KS3Iuap@hovoldconsulting.com>
 <17a4178a-48b7-284c-1c3d-85c570bccf01@zago.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17a4178a-48b7-284c-1c3d-85c570bccf01@zago.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 08:00:41PM -0500, Frank Zago wrote:
> On 5/12/21 4:55 AM, Johan Hovold wrote:
> > On Tue, May 11, 2021 at 08:07:31PM -0500, Frank Zago wrote:
> >> Hello,
> >> 
> >> On 5/10/21 2:40 AM, Johan Hovold wrote:
> >>> On Thu, Apr 22, 2021 at 07:28:51PM -0500, Frank Zago wrote:
> >>>> From: frank zago <frank@zago.net>
> >>>> 
> >>>> The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is
> >>>>  still present but only the TX and RX pins are available; DTS,
> >>>> DTR, ... are used for other things. Remove the PID, and let a
> >>>> I2C driver bind to it.
> >>>> 
> >>>> Existing CH341 boards usually have physical jumpers to switch 
> >>>> between the 3 modes.
> >>>> 
> >>>> This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.
> >>> 
> >>> You can't just revert something which people clearly depend on
> >>> and therefore added to the kernel in the first place.
> >> 
> >> That device in UART mode was already supported by the serial
> >> driver. The original submitter just had to move a jumper on his
> >> board. There was no need to patch the kernel.
> > 
> > How do you know that the author used a dev board? And are you really 
> > sure that there are no devices out there which always operate in
> > this mode?
> 
> The author of commit 46ee4abb10a07bd8 put a link to his device. I have
> the same one (or a clone) and it works fine in serial mode without the
> patch.  I have a different model that works the same way. A jumper
> selects the mode.
> 
> I can't be sure that no one has ever built a board with that chip,
> selecting the wrong mode. But the chip is about 10 years old now;
> someone would have noticed.

Since commit 46ee4abb10a0 ("USB: serial: ch341: add new Product ID for
CH341A") went in fairly recently it may still be possible to revert it,
especially if the author can speak up and explain why he added it.

If I'm reading the datasheets correctly (which I should not have to,
this should all be explained in the commit message), serial TX/RX isn't
even available in the mode we're discussing here as those pins are used
for parallel mode ERR#/PEMP:

	http://www.anok.ceti.pl/download/ch341ds1.pdf

Someone might however be using the parallel interface with the current
serial driver but that doesn't seem to be the case with the programmer
in question based on some other random site which has some schematics
(possibly a different device):

	https://www.onetransistor.eu/2017/08/ch341a-mini-programmer-schematic.html

> >> That product ID also supports UART but in a limited way, as only
> >> the RX and TX pins are available. However it is the only one that
> >> supports i2c/spi/gpio, and that's why I have to revert the patch.
> > 
> > I understand why you did it. My point is that you cannot just claim
> > that PID and say that it's only to be used for I2C/SPI without even
> > trying to make a case for why that should be ok.
> 
> That's the only PID that works for I2C/SPI/GPIO. Right now the serial
> driver is claiming it. I don't know what else to say. If I can't
> revert that patch, my driver can't be used without blacklisting the
> serial driver.

You still need to make the case for why this is OK. Explain the various
modes, how they are configured (e.g. the various bootstrap pins), and
argue why claiming this PID might be acceptable. Getting the author who
added the PID to say he's ok with reverting would also help.

Just repeating "I need this" isn't good enough.

> >>> Can you reprogram the device with a newly allocated PID to be
> >>> used for i2c-only instead?
> >> 
> >> It is possible if the device has an SPI flash connected to it, but
> >> none of the cheap boards have that.
> > 
> > That's unfortunate. In principle, your approach is the right one,
> > that is, to use a dedicated PID do determine when to configure an
> > alternate mode. But since we already know that some people are using
> > the PID in question in serial mode, it's not that clear cut.
> > 
> > How do you intend to switch between i2c and spi mode?
> 
> i2c, spi and gpio can all be used simultaneously. I have a working spi
> implementation, but I'm still testing it. Basically if a user wants
> to use spi, then 3 specific gpios will be reserved for MOSI/MISO/CLK
> (using gpiochip_request_own_desc), with possibly one or more used
> for the chip select.

Ok, thanks for clarifying. Sounds like this should be an MFD driver
then even if the SPI and GPIO blocks aren't independent.

> How a user books spi is up in the air right now. That might be done
> through a sysfs command.

Would be interesting to see a proposal since we don't currently have a
good interface for handling this kind of runtime configuration.

Johan

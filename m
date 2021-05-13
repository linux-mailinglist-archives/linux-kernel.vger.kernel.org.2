Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CA737F0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhEMBNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:13:05 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:34571 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbhEMBMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:12:30 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 9814A100963;
        Thu, 13 May 2021 01:01:08 +0000 (UTC)
X-Originating-IP: 68.203.5.165
Received: from [192.168.1.186] (cpe-68-203-5-165.austin.res.rr.com [68.203.5.165])
        (Authenticated sender: frank@zago.net)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8E8A2FF804;
        Thu, 13 May 2021 01:00:43 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] Revert "USB: serial: ch341: add new Product ID for
 CH341A"
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jan-Niklas Burfeind <kernel@aiyionpri.me>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Wolfram Sang <wsa@kernel.org>, linux-usb@vger.kernel.org,
        gunar@schorcht.net
References: <20210423002852.3904-1-frank@zago.net>
 <YJjjfx49nCflzFbR@hovoldconsulting.com>
 <8b3c348f-9e05-29f9-9197-8ddf1c8a9e8b@zago.net>
 <YJumDN4w4KS3Iuap@hovoldconsulting.com>
From:   Frank Zago <frank@zago.net>
Message-ID: <17a4178a-48b7-284c-1c3d-85c570bccf01@zago.net>
Date:   Wed, 12 May 2021 20:00:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJumDN4w4KS3Iuap@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 4:55 AM, Johan Hovold wrote:
> On Tue, May 11, 2021 at 08:07:31PM -0500, Frank Zago wrote:
>> Hello,
>> 
>> On 5/10/21 2:40 AM, Johan Hovold wrote:
>>> On Thu, Apr 22, 2021 at 07:28:51PM -0500, Frank Zago wrote:
>>>> From: frank zago <frank@zago.net>
>>>> 
>>>> The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is
>>>>  still present but only the TX and RX pins are available; DTS,
>>>> DTR, ... are used for other things. Remove the PID, and let a
>>>> I2C driver bind to it.
>>>> 
>>>> Existing CH341 boards usually have physical jumpers to switch 
>>>> between the 3 modes.
>>>> 
>>>> This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.
>>> 
>>> You can't just revert something which people clearly depend on
>>> and therefore added to the kernel in the first place.
>> 
>> That device in UART mode was already supported by the serial
>> driver. The original submitter just had to move a jumper on his
>> board. There was no need to patch the kernel.
> 
> How do you know that the author used a dev board? And are you really 
> sure that there are no devices out there which always operate in
> this mode?

The author of commit 46ee4abb10a07bd8 put a link to his device. I have 
the same one (or a clone) and it works fine in serial mode without the patch.
I have a different model that works the same way. A jumper selects the mode.

I can't be sure that no one has ever built a board with that chip, selecting
the wrong mode. But the chip is about 10 years old now; someone would have noticed.

> 
>> That product ID also supports UART but in a limited way, as only
>> the RX and TX pins are available. However it is the only one that
>> supports i2c/spi/gpio, and that's why I have to revert the patch.
> 
> I understand why you did it. My point is that you cannot just claim
> that PID and say that it's only to be used for I2C/SPI without even
> trying to make a case for why that should be ok.

That's the only PID that works for I2C/SPI/GPIO. Right now the serial driver is 
claiming it. I don't know what else to say. If I can't revert that patch, my driver
can't be used without blacklisting the serial driver.

> 
>> If that's desired, the new driver could add support for that as
>> well, but I don't think it's worth the effort.
> 
> We obviously don't want a second serial driver for these devices.
> 
>>> Can you reprogram the device with a newly allocated PID to be
>>> used for i2c-only instead?
>> 
>> It is possible if the device has an SPI flash connected to it, but
>> none of the cheap boards have that.
> 
> That's unfortunate. In principle, your approach is the right one,
> that is, to use a dedicated PID do determine when to configure an
> alternate mode. But since we already know that some people are using
> the PID in question in serial mode, it's not that clear cut.
> 
> How do you intend to switch between i2c and spi mode?

i2c, spi and gpio can all be used simultaneously. I have a working spi implementation,
but I'm still testing it. Basically if a user wants to use spi, then 3 specific gpios
will be reserved for MOSI/MISO/CLK (using gpiochip_request_own_desc), with possibly 
one or more used for the chip select. 
How a user books spi is up in the air right now. That might be done through a sysfs command.

Frank.


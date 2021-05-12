Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55D37B344
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 03:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhELBIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 21:08:47 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51733 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELBIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 21:08:45 -0400
X-Originating-IP: 68.203.5.165
Received: from [192.168.1.186] (cpe-68-203-5-165.austin.res.rr.com [68.203.5.165])
        (Authenticated sender: frank@zago.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id AD7A260003;
        Wed, 12 May 2021 01:07:33 +0000 (UTC)
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
From:   Frank Zago <frank@zago.net>
Message-ID: <8b3c348f-9e05-29f9-9197-8ddf1c8a9e8b@zago.net>
Date:   Tue, 11 May 2021 20:07:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJjjfx49nCflzFbR@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 5/10/21 2:40 AM, Johan Hovold wrote:
> On Thu, Apr 22, 2021 at 07:28:51PM -0500, Frank Zago wrote:
>> From: frank zago <frank@zago.net>
>> 
>> The 0x5512 USB PID is for the I2C/GPIO/SPI interfaces. UART is 
>> still present but only the TX and RX pins are available; DTS, DTR, 
>> ... are used for other things. Remove the PID, and let a I2C
>> driver bind to it.
>> 
>> Existing CH341 boards usually have physical jumpers to switch 
>> between the 3 modes.
>> 
>> This reverts commit 46ee4abb10a07bd8f8ce910ee6b4ae6a947d7f63.
> 
> You can't just revert something which people clearly depend on and 
> therefore added to the kernel in the first place.

That device in UART mode was already supported by the serial driver. The 
original submitter just had to move a jumper on his board. There was no 
need to patch the kernel.

That product ID also supports UART but in a limited way, as only the RX and TX
pins are available. However it is the only one that supports i2c/spi/gpio, and
that's why I have to revert the patch. 

If that's desired, the new driver could add support for that as well, but I don't
think it's worth the effort.

> 
> Can you reprogram the device with a newly allocated PID to be used 
> for i2c-only instead?

It is possible if the device has an SPI flash connected to it, but none of
the cheap boards have that.

Frank.

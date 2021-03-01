Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E9F327A54
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhCAJDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233709AbhCAI4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:56:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE27A6148E;
        Mon,  1 Mar 2021 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614588932;
        bh=1Lj3nNR9NY5QBEvwcUxtfqmYoLwL0qm3v3ID+sTuq6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJYAIlkCN4p0WxB/8R8oNXUUCM9KOLmVOPkojRWgZSjI6M8vPZWRfSYFN4zH64I7n
         Ln1mUvO/5ETHCibW1oI8zbKrQhFMft9W8ZANJBLYhrexeH0r41u26Xk+Rbx7pdiWgM
         /otkm6vIPfb7bpnZVlzVJR5CoK2K17RjUVUncAt2BiNwSzfMfT10330QaE+YCsAFa2
         2vVtbI02rBqTSFJPmsKpO4IL1v0kXAZap0Xyx7XR1XzRVvECsT9VoZdnhwTUck8200
         OgNVvySX+zRrLIQ+detvuyfYWcAsxlPmWh57tGI5XIVaXpwZco6jeq6hYLKnC3/IEe
         K1O/GoXbssvgw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lGeLG-0003sV-8A; Mon, 01 Mar 2021 09:55:50 +0100
Date:   Mon, 1 Mar 2021 09:55:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs of CP2108
Message-ID: <YDysFn8RgBKV7iCV@hovoldconsulting.com>
References: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 08:13:46AM +0000, Pho Tran wrote:
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be supported for CP2108.
> 
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared to all of those interfaces.
> So, just need to initialize GPIOs of CP2108 with only one interface (I use interface 0).
> It means just only 1 gpiochip device file will be created for CP2108.
> 
> CP2108 has 16 GPIOs, So data types of several variables need to be is u16
> instead of u8(in struct cp210x_serial_private). This doesn't affect other CP210x devices.
> 
> Because CP2108 has 16 GPIO pins, the parameter which is passed by cp210x functions
> will be different from other CP210x devices. So need to check part number of the device to use correct data format  before sending commands to devices.
> 
> Like CP2104, CP2108 have GPIO pins with configurable options. Therefore, in cp2108_gpio_init() function,
> Should be mask all pins which are not in GPIO mode.

Please break commit message lines at 72 cols or so (and try to keep code
< 80 cols).

There are still a few checkpatch.pl warnings on this one that look
legitimate, please fix those up (e.g. spaces at start of lines).

Also use the kernel u8 and u16 types instead of the c99 ones.

Johan

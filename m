Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6934D3228B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhBWKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 05:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232216AbhBWKOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 05:14:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17A5964E31;
        Tue, 23 Feb 2021 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614075253;
        bh=sRi3w/UtXjArAxUjSdt9d+vBEIHdStIGDyWR0ZupaC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvCVkPbWnO4jQoEIX7CNsPejjEzpRWK1zKCL2csD8QDmL3u0SAZI4wY6IpYI/MCS+
         34w+judW2RWBTWE+a3YBGMrfcmZqUTmAMUYGt5btVLWeIbBXNnwmJQ38PYcQ2gZrqZ
         W4LYJl4PQ/ZsgoXHgU5c/sgyzOpohm2Yl3TK+GbMCFhcffr3WNGaQJYzbQ/cLEy0m5
         FsfC9yrSInX3G2fx8ePJsIM8iz89if5JPuh8do5gsIlbWozQ35UjGoOWwlN4Tpkkpx
         CtGtHhix2BBdvcbYl83Q/TFYP/3DDg8F2A794Ym2/7B82E9/+YXBwxJCwVoslV/eTP
         FYwWZ8+i23XBQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lEUi4-0005m4-Sz; Tue, 23 Feb 2021 11:14:28 +0100
Date:   Tue, 23 Feb 2021 11:14:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-usb@vger.kernel.org'" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs
Message-ID: <YDTVhIrMrFtbcJy9@hovoldconsulting.com>
References: <MWHPR1101MB20783123E0E9AD359DD48186E3809@MWHPR1101MB2078.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1101MB20783123E0E9AD359DD48186E3809@MWHPR1101MB2078.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 10:02:08AM +0000, Pho Tran wrote:
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be supported for CP2108.
> 
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared to all of those interfaces.
> So, just need to initialize GPIOs of CP2108 with only one interface (I use interface 0).
> It means just only 1 gpiochip device file will be created for CP2108.
> 
> CP2108 has 16 GPIOs, So data types of several variables need to be is u16
> instead of u8(in struct cp210x_serial_private). This doesn't affect other CP210x devices.
> 
> Because CP2108 has 16 GPIO pins, the parameter which is passed by CP210x functions
> will be different from other CP210x devices. So need to check part number of the device
> to use correct data format  before sending commands to devices.
> 
> Like CP2104, CP2108 have GPIO pins with configurable options. Therefore, in cp2108_gpio_init() function,
> Should be mask all pins which are not in GPIO mode.
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com<mailto:pho.tran@silabs.com>>
> ---
> drivers/usb/serial/cp210x.c | 199 +++++++++++++++++++++++++++++++-----
> 1 file changed, 172 insertions(+), 27 deletions(-)

You sent this patch twice, and I'm afraid both have been white-space
corrupted (e.g. by your mailer).

Try sending the patch to yourself first and make sure you can apply it
using git-am (and run checkpatch.pl on it without any obvious errors).

Johan

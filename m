Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760C932E57E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCEJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:59:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhCEJ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:59:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93E6964F56;
        Fri,  5 Mar 2021 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614938361;
        bh=Zt6dMvyvgSf4f+esbQrzrLLMGSxV46ucIebHZrV1O/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kf6mIcTQXaujH2SvguwzE468w4nFueQLraCGkWZBW7LTKd+HeNBDJW7SeUGdsJRcL
         wcYbUvQXHQi89qsLghYv3wyp5fof4Rm9P3EgjKNhfieR16o/k67q2LNMoHDi3jtVF1
         v2ovrb4YrYbwVPT/QO5rP7cO5WX0cSvTkcTe6c96tmixCQP85uQ6qFXgnnPBbvcebg
         +lLdBsMegHZLqHh0tVW5dlm7EqyhrTYhrF4cAhqpWq9v8joH0Dd2i3hLT/EKvFhjzh
         uOeuG5ZZ7NvgeqScVzwMgTtemtmY1TXNZVli7CeWfaiMIV08Gf1hvYd5mYSnvVsv/+
         jaa/TihX/ae1g==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lI7F9-0001G0-K6; Fri, 05 Mar 2021 10:59:36 +0100
Date:   Fri, 5 Mar 2021 10:59:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs of CP2108
Message-ID: <YEIBB+Se1zdUpctn@hovoldconsulting.com>
References: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
 <3734B8C1-9AFA-494E-9C5B-433219D1F55A@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3734B8C1-9AFA-494E-9C5B-433219D1F55A@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 09:50:47AM +0000, Pho Tran wrote:
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be
> supported for CP2108.
> 
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared
> to all of those interfaces. So, just need to initialize GPIOs of CP2108
> with only one interface (I use interface 0). It means just only 1 gpiochip
> device file will be created for CP2108.
> 
> CP2108 has 16 GPIOs, So data types of several variables need to be is u16
> instead of u8(in struct cp210x_serial_private). This doesn't affect other
> CP210x devices.
> 
> Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functions
> will be different from other CP210x devices. So need to check part number
> of the device to use correct data format  before sending commands to
> devices.
> 
> Like CP2104, CP2108 have GPIO pins with configurable options. Therefore,
> should be mask all pins which are not in GPIO mode in cp2108_gpio_init()
> function.
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> ---

Which version is this and what changed since the previous one? Always
include a patch revision in the Subject when resending (e.g. 
"[PATCH v3]: USB: ...") and add a short changelog here.

I tried not to look at the code but I still see some overly long lines
(e.g. comments beyond 80 cols).

Johan

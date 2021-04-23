Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7460536920F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242452AbhDWM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:26:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242382AbhDWM0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:26:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6972161459;
        Fri, 23 Apr 2021 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619180746;
        bh=aM+Sojr2k7UDRMAnNY+H+VELI6N8SH3ptsc1gWn2L6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/mn5gkz+niJiikHOTeliDrRa5c217CJaBrMkhu+8eGuDiSMgSZIube0S1US3TZtm
         Kjgcjlbk1k27z15Px4ZgFvBZTbJENgUidlUEKT5fY25h8txfA1+tLY0w6rRlXwzvnm
         VFQ6DjSQ+FSxq9mxY8ORzCkUlr8ymsjzJAy6cunTm2/6e3tPzS1mkt9Qv9Ia+MA5NI
         cXY7Yb56ssJ7znWSro3cvS3gh1JzFAzigj31YY/P6X4uNE94vBTjZzkOLVoqBVx6kr
         aY7424CocbN/tROFuSz+xmguJEzE8rQg0+D1SrbgjKF+CiJqudJ+DgFSP7KZfEHUPo
         T+IYaEhVmHnDg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lZusb-0002me-Vn; Fri, 23 Apr 2021 14:25:54 +0200
Date:   Fri, 23 Apr 2021 14:25:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     tu pham <thanhtung1909@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v10] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YIK80foYxTKpGsNc@hovoldconsulting.com>
References: <20210423121645.16790-1-tupham@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423121645.16790-1-tupham@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 07:16:45PM +0700, tu pham wrote:
> From: Pho Tran <pho.tran@silabs.com>
> 
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

When you forward a patch from someone else you need to sign-off on it as
well. If you also worked on the patch you can use the Co-Developed-by
tag as well. More info here:

	Documentation/process/submitting-patches.rst

Johan

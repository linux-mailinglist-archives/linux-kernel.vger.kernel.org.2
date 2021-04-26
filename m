Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30E36AFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhDZIuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhDZIuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:50:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 068D061151;
        Mon, 26 Apr 2021 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619426962;
        bh=c385gX+rJYzUpr+F1uP3NMEB3F9npFzu6PF75Za/gEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oqr8d2iSkLOb3qHLWc5pq2I7hHmVqEviSYlX3BVQG7cEFvkdT0Rc0Mvc+w/0aIVKj
         jo2s+GTtltcxmc1gxFuqmr2ncbABn5RxCFPvP0WaYNjBEZNRCkEq0zEo3TRGtPg4l3
         ELtA0BuvTaCjYZLi3Ubi1jm5rQwMVhXiovz2MqLdRr1l2cIrqvTIyXeWozWo+Ah4lo
         I4WPWCArT1byai6zIBcyXSGeqpcwEzjMRMs3RsV1+U1Wno6zwOnvOaijhbpqX21Dik
         sExmlKi5B63eiakOG1wSQrAvnCS6NyauVlFBInqfrtIrOUlqc4vwS4E8WgNyHWpfP8
         quix0zwMx+enA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lawvs-0000Cu-Eh; Mon, 26 Apr 2021 10:49:32 +0200
Date:   Mon, 26 Apr 2021 10:49:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     tu pham <thanhtung1909@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, Pho Tran <pho.tran@silabs.com>
Subject: Re: [PATCH v11] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YIZ+nKw6iNcQP26E@hovoldconsulting.com>
References: <20210426084213.9823-1-tupham@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426084213.9823-1-tupham@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 03:42:13PM +0700, tu pham wrote:
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
> Co-developed-by: Tung Pham <tung.pham@silabs.com>

You still need to sign-off as mentioned in the document I referred to.

Johan

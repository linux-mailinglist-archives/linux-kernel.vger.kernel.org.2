Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049B232E6BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhCEKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhCEKvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:51:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8AB764F69;
        Fri,  5 Mar 2021 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614941459;
        bh=Ae5vOsGvJPMG1k1VK0GXA5F3+ig3MBmLu+NTQt/lJQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2l5AF5itVzeiKVooVGgXSxLJ8fFAGZISH3YAadrWVigS47+QR5vFd1wcFf68Grp6
         Zr9bzC+oOjZYRRbfLz3/HN23aMKZ6bbHXKEU1r7Ry/uZIGa8gyb2Lw2p2Qf7+QFhJd
         1Nr84JhmH79dssrR2Wc/5rfmF1iqZpPpK144mawn6+TqblCTFlkMRm7X2MJ+hYwFch
         K37y3gfrcSZlji94OHI4XcfJkwqJeUp3j/yT4cmUTuvXv08nmD5riQ5ypfHOvfJ+sy
         kFJAvsXCn5ie83CNFH9cw1EWP/zQ00A+8vZkr/u/8cFYzUpgxA6ENXwkMUBtCYCOR9
         racOS98SxFR+g==
Received: from johan by xi with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lI838-0001YK-7s; Fri, 05 Mar 2021 11:51:14 +0100
Date:   Fri, 5 Mar 2021 11:51:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>
Subject: Re: [PATCH v2] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs  of CP2108
Message-ID: <YEINIu+kFsNCHP7J@hovoldconsulting.com>
References: <5F0FCC57-86C5-4FF2-AE75-C2DDC748901A@silabs.com>
 <3734B8C1-9AFA-494E-9C5B-433219D1F55A@silabs.com>
 <71DBC945-FBA0-4FDF-8167-95697A5AFF44@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71DBC945-FBA0-4FDF-8167-95697A5AFF44@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 10:44:07AM +0000, Pho Tran wrote:
> Similar to other CP210x devices, GPIO interfaces (gpiochip) should be supported for CP2108.
> 
> CP2108 has 4 serial interfaces but only 1 set of GPIO pins are shared to all of those interfaces. So, just need to initialize GPIOs of CP2108 with only one interface (I use interface 0). It means just only 1 gpiochip device file will be created for CP2108.
> 
> CP2108 has 16 GPIOs, So data types of several variables need to be is u16 instead of u8(in struct cp210x_serial_private). This doesn't affect other CP210x devices.
> 
> Because CP2108 has 16 GPIO pins, the parameter passed by cp210x functions will be different from other CP210x devices. So need to check part number of the device to use correct data format  before sending commands to devices.
> 
> Like CP2104, CP2108 have GPIO pins with configurable options. Therefore, should be mask all pins which are not in GPIO mode in cp2108_gpio_init() function.
> 
> Signed-off-by: Pho Tran <pho.tran@silabs.com<mailto:pho.tran@silabs.com>>
> ---

This patch is whitespace corrupt.

And the changelog should go here (after the '---', not after the diff).

> 3/4/2021: Patch v2 Modify format patch as comment form Johan Hovold
> <johan@kernel.org<mailto:johan@kernel.org>>

As I told when you submitted a previous patch; you need to be more
specific in your changelog. This doesn't say *what* has changed.

> 3/1/2021: Initial submission of patch " Make the CP210x driver work
> with GPIOs  of CP2108 "

Johan

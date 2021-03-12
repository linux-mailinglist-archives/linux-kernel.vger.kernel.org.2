Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE833878B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhCLIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232387AbhCLIgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:36:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4950F64FC1;
        Fri, 12 Mar 2021 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615538184;
        bh=L2hJBCU/7D+nSFex12m9kzLvCdK5v/H9qPPq41cS+5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxfvDSM2vJI3Xgwj37HBBm8JJTjfCleuXssxVa5iEMOnpLHp1eghXbp9l0ozmWsG+
         wtdRpsLayuKvqIn3L64qQfmcnfYLVrOwWfskVfHtRfQbYXrKzc9ugOqCTLSvGdQDSN
         VPQfOINk6X4P5d/52aZ4ACJrNIan9xaEAQCDzNqzXNdyawaEEGsiHZVn1distYhQfA
         29AGLXQh5JCjwcyrSlOL9ZHGUNcKfLkCoaraFegNa/ON3VcMyNEveXDmvfC5xSMEao
         jkwYSJao9K0kqC+61sAJlA0fsPHvIiPCIuAzooasJiuD+GGYr3NcPlq5psfAiq41Zs
         8qwQ1Zm0SCk8A==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lKdHf-00027L-Su; Fri, 12 Mar 2021 09:36:36 +0100
Date:   Fri, 12 Mar 2021 09:36:35 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v4] USB: serial: cp210x: Make the CP210x driver work with
 GPIOs  of CP2108
Message-ID: <YEsoE+QXSq8LagWG@hovoldconsulting.com>
References: <8B41D8A4-2CE0-4EA9-87A9-28A62905F9B1@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8B41D8A4-2CE0-4EA9-87A9-28A62905F9B1@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 04:27:57AM +0000, Pho Tran wrote:
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
> Signed-off-by: Pho Tran <pho.tran@silabs.com<mailto:pho.tran@silabs.com>>
> —
> 03/05/2021: Patch v3 modified format and contents of changelog follow feedback
> from Jonhan Hovold <johan@kernel.org<mailto:johan@kernel.org>>.
> 03/04/2021: Patch v2 modified format patch as comment from
> Johan Hovold <johan@kernel.org<mailto:johan@kernel.org>>:
> 1. Break commit message lines at 80 cols
> 2. Use kernel u8 and u16 types instead of the c99 ones.
> 03/01/2021: Initialed submission of patch “Make the CP210x driver work with
> GPIOs of CP2108.”.

Why are you resending the v4 that you submitted only four days ago? 

Note that this version is again white space corrupted, and something
happened to you SOB tag above.

Johan

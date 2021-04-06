Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07C8354C30
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbhDFFO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 01:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242730AbhDFFOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 01:14:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD627613A3;
        Tue,  6 Apr 2021 05:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617686085;
        bh=YiBIuM95M7RmdUhLr0ehVXM8FXpHF3Eq18NMpMHqigQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17ib04zPsoSFp4+/AqYcJBfuAZ5vSp/bYnQdPVSV+v+dxZ87p2V3FQA99160FZgG8
         /HxUDMDmc0+Vbwj9azSInhL5uxH9MnNAfieA0EWaPBxxsc66f2xd9+TDRotK/pMSKE
         g2LTvT3R9180uEB9Ho6OcjKphhvPuL0KIopB3iy8=
Date:   Tue, 6 Apr 2021 07:14:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pho Tran <photranvan0712@gmail.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hung.Nguyen@silabs.com,
        Tung.Pham@silabs.com, Pho Tran <pho.tran@silabs.com>,
        Kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7] USB: serial: cp210x: Add support for GPIOs on CP2108
Message-ID: <YGvuQlxyorJt+ErG@kroah.com>
References: <20210406040238.1850-1-photranvan0712@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406040238.1850-1-photranvan0712@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:02:38AM +0700, Pho Tran wrote:
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
> Fix build test WARNING reported by kernel test robot.
> 
> Reported-by: Kernel test robot <lkp@intel.com>

The kernel test robot did not report this needed support :(


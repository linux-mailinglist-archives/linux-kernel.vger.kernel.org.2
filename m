Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E5357C83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhDHGXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhDHGXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:23:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25D5A610E6;
        Thu,  8 Apr 2021 06:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617862972;
        bh=s5DxdPa0qBalZxAPxqbzIOTmBMgmX1U5/r1n4i6Ua5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcjME3upWbPai6OutoM0QAemT1KHipC3zuOYRTKFj60DnSLFyCMSunJpNDnZG+njE
         sbCaJB0PBZas/w/Z8xs/mK8utjGnMjdwkH664R/hXYevdG0wosxcoWQuL4K/wpBB3k
         8rIyyjnPWQKUGPVna/IeSaSre5TOt58TXP0odvEU=
Date:   Thu, 8 Apr 2021 08:22:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG6hOuOO5EL9xTwH@kroah.com>
References: <1617846650-10058-1-git-send-email-min.li.xe@renesas.com>
 <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617846650-10058-2-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:50:50PM -0400, min.li.xe@renesas.com wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This driver is developed for the IDT ClockMatrix(TM) and 82P33xxx families
> of timing and synchronization devices.It will be used by Renesas PTP Clock
> Manager for Linux (pcm4l) software to provide support to GNSS assisted
> partial timing support (APTS) and other networking timing functions.
> 
> Current version provides kernel API's to support the following functions
> -set combomode to enable SYNCE clock support
> -read dpll's state to determine if the dpll is locked to the GNSS channel
> -read dpll's ffo (fractional frequency offset) in ppqt
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> Change log
> -rebase change to linux-next tree
> -remove uncessary condition checks suggested by Greg
> -fix compile error for x86_64
> -register device through misc_register suggested by Greg
> -change to use module_platform_device to register driver
> -remove empty open and release functions
> -more informational comment for struct rsmu_cdev
> 
>  drivers/misc/Kconfig      |   9 ++
>  drivers/misc/Makefile     |   2 +
>  drivers/misc/rsmu_cdev.c  | 231 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_cdev.h  |  74 +++++++++++++++
>  drivers/misc/rsmu_cm.c    | 166 +++++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_sabre.c | 133 ++++++++++++++++++++++++++

Again, please make this only one file.

thanks,

greg k-h

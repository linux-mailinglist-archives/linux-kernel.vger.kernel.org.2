Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F742357369
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348228AbhDGRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348171AbhDGRpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:45:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 000E86105A;
        Wed,  7 Apr 2021 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617817533;
        bh=qklOIn3ovCrR6e2dnWjgPfxUzfa/JvarRuKRkrprMac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKwTPKGd5n2AAm77BhrHQLwErSuny0ZuFsyKDfZzPHjmxyG9I42CEYS2RXN+f/5A0
         29a3gfRI/AoEUlW0uYk16Wk4cseETVV1cfnuJ4pLqEQOViRezkTUiL1Eq+SHEF98dX
         cGEx7DoOGoN+P9xIrja+YiauGfSIOzuKCLgs7YBA=
Date:   Wed, 7 Apr 2021 19:45:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG3vu9XQ94w5dlbp@kroah.com>
References: <1617816815-3785-1-git-send-email-min.li.xe@renesas.com>
 <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617816815-3785-2-git-send-email-min.li.xe@renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:33:35PM -0400, min.li.xe@renesas.com wrote:
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
> 
>  drivers/misc/Kconfig      |   9 ++
>  drivers/misc/Makefile     |   2 +
>  drivers/misc/rsmu_cdev.c  | 266 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/rsmu_cdev.h  |  74 +++++++++++++
>  drivers/misc/rsmu_cm.c    | 166 +++++++++++++++++++++++++++++
>  drivers/misc/rsmu_sabre.c | 133 +++++++++++++++++++++++

Why do you need 4 files here?  Can't you do this all in one?  There's no
need for such a small driver to be split up, that just causes added
complexity and makes things harder to review and understand.

>  include/uapi/linux/rsmu.h |  64 +++++++++++

Where are you documenting these new custom ioctls?  And why do you even
need them?

thanks,

greg k-h

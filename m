Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F635738F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDGRvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhDGRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:51:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3C8561284;
        Wed,  7 Apr 2021 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617817900;
        bh=nTp/WvTjnSAnS4EME/mBxL+kfQ/uoYRLlrN/5NR97xU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omajU5piXAUTclvgcNDnRJQzQDMDqpLqjznpZkQwXlJL1h2h/U7lfuJgbbdVSeTtf
         FfHr7mkdQiKx8exUyHsXxfojHllhpe/cHgowljZOUHnzI8ZUVkIkTO7P9xuV0ZWXC2
         1qlAjU8uFFNwjrWk4z00apdfpX8ei2eZWlI1hR/o=
Date:   Wed, 7 Apr 2021 19:51:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     min.li.xe@renesas.com
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] misc: Add Renesas Synchronization
 Management Unit (SMU) support
Message-ID: <YG3xKlSrOZvrIr3z@kroah.com>
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
> +/**
> + * struct rsmu_cdev - Driver data for RSMU character device
> + * @name: rsmu device name

Why not use the miscdev name field?

> + * @dev: pointer to platform device

So it's a parent?  Why not make this a real platform_device pointer and
not a device pointer?

> + * @mfd: pointer to MFD device

You are properly handling the reference count of this and the platform
device pointer when you save it off, right?  Please check.

> + * @miscdev: character device handle
> + * @lock: mutex to protect operations from being interrupted

What operations?

> + * @type: rsmu device type
> + * @ops: rsmu device methods
> + * @index: rsmu device index

Index into what?

> --- /dev/null
> +++ b/drivers/misc/rsmu_cm.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * This driver is developed for the IDT ClockMatrix(TM) of
> + * timing and synchronization devices.
> + *
> + * Copyright (C) 2019 Integrated Device Technology, Inc., a Renesas Company.

Note, it's 2021 :)

thanks,

greg k-h

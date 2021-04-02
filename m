Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB4352AF6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhDBNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:16:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBNQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0285610F7;
        Fri,  2 Apr 2021 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617369413;
        bh=/BQ5h0ZVqbqSFxqV9m02WcLc6Z8/u/Dvvd8g8cm6jrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZ1HioHCyhOvKy6l8tgnDAaxxkekkKPJ2t4X9sKEgqFiVyqGfLgx2YTHHFg1Ljg1r
         UQtlNoH0hVgOd53joPR1v12rGxKuMjW2bzyU+ibaA1toVJUF+BlzT73Fmq4z4nJgUy
         +n6jDk4kP/xECaDRf5rcxJYgSjkgC50QwxdhRJXs=
Date:   Fri, 2 Apr 2021 15:16:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kong.kongxinwei@hisilicon.com, yisen.zhuang@huawei.com
Subject: Re: [PATCH] USB:ohci:fix ohci interruption problem
Message-ID: <YGcZQiBx3mCzqkPd@kroah.com>
References: <1617355679-9417-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617355679-9417-1-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 05:27:59PM +0800, Longfang Liu wrote:
> The operating method of the system entering S4 sleep mode:
> echo disk > /sys/power/state
> 
> When OHCI enters the S4 sleep state, the USB sleep process will call
> check_root_hub_suspend() and ohci_bus_suspend() instead of
> ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
> to not be closed.
> 
> At this time, if just one device interrupt is reported. Since rh_state
> has been changed to OHCI_RH_SUSPENDED after ohci_bus_suspend(), the
> driver will not process and close this device interrupt. It will cause
> the entire system to be stuck during sleep, causing the device to
> fail to respond.
> 
> When the abnormal interruption reaches 100,000 times, the system will
> forcibly close the interruption and make the device unusable.
> 
> Because the root cause of the problem is that ohci_suspend is not
> called to perform normal interrupt shutdown operations when the system
> enters S4 sleep mode.
> 
> Therefore, our solution is to specify freeze interface in this mode to
> perform normal suspend_common() operations, and call ohci_suspend()
> after check_root_hub_suspend() is executed through the suspend_common()
> operation.
> After using this solution, it is verified by the stress test of sleep
> wake up in S4 mode for a long time that this problem no longer occurs.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/core/hcd-pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What changed from the previous version sent for this patch?  Always
properly describe the changes below the --- line, and also version your
subject line as documented.

Please fix up and resend.

thanks,

greg k-h

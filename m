Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FD03595BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhDIGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhDIGrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:47:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8549E600D1;
        Fri,  9 Apr 2021 06:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617950812;
        bh=naU9mp3i+9IGisOL6fpcFcdLBoNBAuhbDBaHXCZY61U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywrI9IX4qp2Vhl0Rd3JDNhhXbvOuEjmfjpFkXcy0IKHAvknrxVu9mOrwv4+LB06q/
         Ubhs8ViRUiktU69WQFCYqx8SK+m5Plng+nP8Xg08wWIWTQEBq3RWvU4d/Th+Tu5Wad
         uTa7so64ar3TfQMWshWIvARyj1/Mc+Jl8uActPRA=
Date:   Fri, 9 Apr 2021 08:46:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        liudongdong3@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kong.kongxinwei@hisilicon.com,
        yisen.zhuang@huawei.com
Subject: Re: [PATCH v3 1/2] USB:ehci:Add a whitelist for EHCI controllers
Message-ID: <YG/4WTTAg2cjjRDi@kroah.com>
References: <1617937215-39035-1-git-send-email-liulongfang@huawei.com>
 <1617937215-39035-2-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617937215-39035-2-git-send-email-liulongfang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 11:00:14AM +0800, Longfang Liu wrote:
> Some types of EHCI controllers do not have SBRN registers.
> By comparing the white list, the operation of reading the SBRN
> registers is skipped.
> 
> Subsequent EHCI controller types without SBRN registers can be
> directly added to the white list.

Your subject line still contains "whitelist" when the code does not.
Please fix it up to reflect your recent changes.

> 
> The current patch does not affect the drive function.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/usb/host/ehci-pci.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
> index 3c3820a..f7f3156 100644
> --- a/drivers/usb/host/ehci-pci.c
> +++ b/drivers/usb/host/ehci-pci.c
> @@ -47,6 +47,28 @@ static inline bool is_bypassed_id(struct pci_dev *pdev)
>  	return !!pci_match_id(bypass_pci_id_table, pdev);
>  }
>  
> +static const struct ehci_nosbrn {
> +	u16 vendor;
> +	u16 device;
> +} ehci_nosbrn_table[] = {
> +	/* STMICRO ConneXT has no sbrn register */
> +	{PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_USB_HOST},
> +	{},
> +};
> +
> +static bool usb_forbid_sbrn_read(struct pci_dev *pdev)
> +{
> +	const struct ehci_nosbrn *entry;
> +
> +	for (entry = ehci_nosbrn_table; entry->vendor; entry++) {
> +		if (pdev->vendor == entry->vendor &&
> +		    pdev->device == entry->device)
> +			return true;

There is a PCI-match-device function somewhere, right?

But as Alan said, why is all of this needed?  You only have 2 devices
you are testing for, we have if statements that are MUCH bigger than
that for simple things like this.

And the odds that a new device will be added to this list in the future
is _VERY_ low given that I would think that no one is making new EHCI
controllers anymore.

So just make this one patch, and add your device id to that, like you
did in the first set of patches.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1011D35C70D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbhDLNJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241719AbhDLNJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7487610CA;
        Mon, 12 Apr 2021 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618232970;
        bh=L3N68V2eqg7gh+TZ25IVywa5xY3+wRDh60JE2ZwBUkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fN7ebk2LpV6guxWoT8wq2ePE/7dh5iBu3WzFAu+Jz657ynNGQ/+erfvkiSBESEnoA
         znvdasyQ2qGqacznxHrU0arlN0r1SjVY8AuI/T3roEtLlNnPDJMiz4r9xSBXJBjjLq
         jAdOACXzBdR9GMMoHFKE+eZQ31wsVoVE+IuD8kZj4j7gK7C3sHNb9b1DWg1dEKd6kz
         pMQnTND2cJ5xWBoIQBCkZ4CN9bSHwEbGAZgiTjXlS762Cmu5P7jF2+LNsITzach6hV
         TRN33GJKtMYtb6b6cvo0IR4Coy6KJTb4TVDib1vvv3zNJ5SQ5OpDilc8N6I2HoXQbU
         pv6a72BwltilQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVwJh-00028s-17; Mon, 12 Apr 2021 15:09:25 +0200
Date:   Mon, 12 Apr 2021 15:09:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, Alan Stern <stern@rowland.harvard.edu>,
        penghao <penghao@uniontech.com>,
        Oliver Neukum <oneukum@suse.com>,
        Jonathan Cox <jonathan@jdcox.net>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Tomasz =?utf-8?Q?Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock
 Gen2 Ethernet
Message-ID: <YHRGhQ51LeouoWEv@hovoldconsulting.com>
References: <20210412130521.782373-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412130521.782373-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 09:05:20PM +0800, Kai-Heng Feng wrote:
> This is another branded 8153 device that doesn't work well with LPM
> enabled:
> [ 400.597506] r8152 5-1.1:1.0 enx482ae3a2a6f0: Tx status -71
> 
> So disable LPM to resolve the issue.
> 
> BugLink: https://bugs.launchpad.net/bugs/1922651
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Put the quirk in the right order.

Seriously... You sent the exact same patch again. Still not ordered.

> 
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 76ac5d6555ae..dfedb51cf832 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -434,6 +434,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	{ USB_DEVICE(0x1532, 0x0116), .driver_info =
>  			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
>  
> +	/* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
> +	{ USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
> +
>  	/* Lenovo ThinkCenter A630Z TI024Gen3 usb-audio */
>  	{ USB_DEVICE(0x17ef, 0xa012), .driver_info =
>  			USB_QUIRK_DISCONNECT_SUSPEND },

Johan

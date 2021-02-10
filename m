Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7442C31649D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBJLGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhBJLEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:04:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99A7F64E2F;
        Wed, 10 Feb 2021 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612955030;
        bh=mUhu9PKRysORVYVGtZgYfDLrCRCblnoUgWoaKX9kNds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQ4X8oyzURKgX2ffLpHenlZEaJ9M6N0rBUdq6qayIc6ynQtuGMe1ES9g2KyFrEApV
         fBi/rtSqNetldEMB469rN6C6MQxfVPD4BL7bOdhjmMweerXRbmjFOE+6azTS6dtJvv
         yxa1Gdru02+PKjUqhN4tjem6tY0Wj/M5aSnYi3acZ6j+uEkO6z/ZuAumQnMS3tszB5
         9FDNIjheneiIUrZUG3Mikev0ndejbQ8jVolsaCUcYrT8K4FSUot0akfnWNReySxktp
         oaPEMlpWCeBoLUYvRmWE+ThAmFlP+ZhC22PGAx85C3w+0tQCyAgaSzYiN7kyfvqvzZ
         A0C1kflMqOqCQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l9nHw-0002SM-L7; Wed, 10 Feb 2021 12:04:04 +0100
Date:   Wed, 10 Feb 2021 12:04:04 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Stefan Ursella <stefan.ursella@wolfvision.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Jonathan Cox <jonathan@jdcox.net>,
        Tomasz =?utf-8?Q?Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: quirks: add quirk to start video capture on ELMO
 L-12F document camera reliable
Message-ID: <YCO9pNI1hZhJ+Z9y@hovoldconsulting.com>
References: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210102821.31779-1-stefan.ursella@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 11:28:20AM +0100, Stefan Ursella wrote:
> Without this quirk starting a video capture from the device often fails with
> 
> kernel: uvcvideo: Failed to set UVC probe control : -110 (exp. 34).
> Signed-off-by: Stefan Ursella <stefan.ursella@wolfvision.net>
> ---
>  drivers/usb/core/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index f232914de5fd..f888deaf7bab 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -480,6 +480,9 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* novation SoundControl XL */
>  	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
>  
> +	/* ELMO L-12F document camera */
> +	{ USB_DEVICE(0x09a1, 0x0028), .driver_info = USB_QUIRK_DELAY_CTRL_MSG },
> +

Please keep the entries sorted by VID/PID (all but the recently added
last one are).

>  	{ }  /* terminating entry must be last */
>  };

Johan

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB235C6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhDLMsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241264AbhDLMsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:48:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95D1261287;
        Mon, 12 Apr 2021 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618231671;
        bh=7ffJOh7fZyJDcpKY7y4QF2GC9OUlZzK6/eFDMH4zVpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ky2chopvPWn4Zl+Sk7prcCuU5j+8oeENGvuwJuqKFaoZPkfdTVgOA9UtZ3ogQTCCc
         61Q96Gxm8JWp+Rx5fjvvfAZ5S8Q5+eJT7nXnVDrSqxPyP23fcIlHN+QHzyN3aBX/71
         ugMQ9083Ffve0vHT4bWw1b2lWuKNnQomkAxCyuzwlBQQysTqV1BnX4ws+loJ2B7ylo
         VeaLG1MAr7PQUGIo3qDpxO0B0gVzuIbGeKaRfCKcU0q0nx6N158STNjiuYliqcQWGa
         2oX+pDB8ltUMKuYXPpqGNtSyLtwvPCSrBgvTKuylnr0mW5DXX7G2zmZeGV1RIqR6fB
         AnHxSeirHtVrA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lVvyj-00025f-9M; Mon, 12 Apr 2021 14:47:46 +0200
Date:   Mon, 12 Apr 2021 14:47:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     gregkh@linuxfoundation.org, Alan Stern <stern@rowland.harvard.edu>,
        penghao <penghao@uniontech.com>,
        Stefan Ursella <stefan.ursella@wolfvision.net>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Oliver Neukum <oneukum@suse.com>,
        Tomasz =?utf-8?Q?Meresi=C5=84ski?= <tomasz@meresinski.eu>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Add LPM quirk for Lenovo ThinkPad USB-C Dock Gen2
 Ethernet
Message-ID: <YHRBcYM/mbtIQdpN@hovoldconsulting.com>
References: <20210412123754.779304-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412123754.779304-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 08:37:52PM +0800, Kai-Heng Feng wrote:
> This is another branded 8153 device that doesn't work well with LPM
> enabled:
> [ 400.597506] r8152 5-1.1:1.0 enx482ae3a2a6f0: Tx status -71
> 
> So disable LPM to resolve the issue.
> BugLink: https://bugs.launchpad.net/bugs/1922651
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
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

Please keep the entries sorted by VID/PID.

Johan

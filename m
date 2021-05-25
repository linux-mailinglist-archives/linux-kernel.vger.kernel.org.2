Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0394938FB58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhEYHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231319AbhEYHDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30F4F61019;
        Tue, 25 May 2021 07:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621926108;
        bh=PO1ijCuYZAqxglfvUIFTRxhCFsTAS+p/J6Dr85+93w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c7WU6/WCt3TVby20Rg6iYIjPTHySOfVwdRWAJEv4ktDz20QzMsQrCJl3ThzpOYyLo
         F8pBVyZLRLKAH7NoD6zjSxA3Pmu1532fSTqOx1HKJVeb8bpUhXi8rPpVbGKZTbxYCt
         T9ifFJ81Vz9HDaKeovy7IFhAAZzrt7GZ/s5wWgAvciL3tp29YdmIzUxiVZubgPkyUT
         6+ZWx5WkxlQGPMK01m6IXeMBYEkMI+iVrfmUXdNBb9KzxAoTcbO30irjOM+AdN8o1L
         VgCf9I92zgBmf4S/90xpawDS9XCfLj4gDtUEOhHqhu9gDaFa0jdLsGzKEm+CJiNAre
         kH01QAgSFveuA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1llR4S-0004Ca-6o; Tue, 25 May 2021 09:01:44 +0200
Date:   Tue, 25 May 2021 09:01:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] USB: serial: omninet: Adding Zyxel Omni 56K
 Plus
Message-ID: <YKyg2EYDn2BEnvYU@hovoldconsulting.com>
References: <20210523163522.1690-1-agriveaux@deutnet.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523163522.1690-1-agriveaux@deutnet.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 06:35:21PM +0200, Alexandre GRIVEAUX wrote:
> Adding Zyxel Omni 56K Plus modem, this modem include:

Nit: In the future, try to use imperative mood in your commit messages
(i.e. use "add" rather than "adding").

Also, why is there a RESEND prefix in the subject? This is the first
time I see this patch.

> USB chip:
> NetChip
> NET2888
> 
> Main chip:
> 901041A
> F721501APGF
> 
> Another modem using the same chips is the Zyxel Omni 56K DUO/NEO,
> could be added with the right USB ID.
> 
> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> ---
>  drivers/usb/serial/omninet.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
> index 83c62f920c50..8be91f5a4dd7 100644
> --- a/drivers/usb/serial/omninet.c
> +++ b/drivers/usb/serial/omninet.c
> @@ -26,6 +26,7 @@
>  
>  #define ZYXEL_VENDOR_ID		0x0586
>  #define ZYXEL_OMNINET_ID	0x1000
> +#define ZYXEL_OMNI_56K_PLUS_ID	0x1500
>  /* This one seems to be a re-branded ZyXEL device */
>  #define BT_IGNITIONPRO_ID	0x2000
>  
> @@ -41,6 +42,7 @@ static void omninet_port_remove(struct usb_serial_port *port);
>  static const struct usb_device_id id_table[] = {
>  	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNINET_ID) },
>  	{ USB_DEVICE(ZYXEL_VENDOR_ID, BT_IGNITIONPRO_ID) },
> +	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNI_56K_PLUS_ID) },
>  	{ }						/* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, id_table);

Now applied with a slightly modified commit message. Thanks.

Johan

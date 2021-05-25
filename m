Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F083238FDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhEYJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhEYJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:27:07 -0400
Received: from srv1.deutnet.info (srv1.deutnet.info [IPv6:2a01:4f8:c2c:6846::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92B1C061574;
        Tue, 25 May 2021 02:25:37 -0700 (PDT)
Received: from [2a01:e0a:186:d21:be5f:f4ff:fe8b:2fc1] (helo=sonata)
        by srv1.deutnet.info with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1llTJf-0002ZT-2j; Tue, 25 May 2021 11:25:35 +0200
Received: from agriveaux by sonata with local (Exim 4.92)
        (envelope-from <agriveaux@deutnet.info>)
        id 1llTJe-0002Dx-I7; Tue, 25 May 2021 11:25:34 +0200
Date:   Tue, 25 May 2021 11:25:34 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, agriveaux@deutnet.info
Subject: Re: [PATCH RESEND 1/2] USB: serial: omninet: Adding Zyxel Omni 56K
 Plus
Message-ID: <20210525092534.GA7238@localhost.localdomain>
References: <20210523163522.1690-1-agriveaux@deutnet.info>
 <YKyg2EYDn2BEnvYU@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKyg2EYDn2BEnvYU@hovoldconsulting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:01:44AM +0200, Johan Hovold wrote:
> On Sun, May 23, 2021 at 06:35:21PM +0200, Alexandre GRIVEAUX wrote:
> > Adding Zyxel Omni 56K Plus modem, this modem include:
> 
> Nit: In the future, try to use imperative mood in your commit messages
> (i.e. use "add" rather than "adding").
> 
Hello,

Ok.

> Also, why is there a RESEND prefix in the subject? This is the first
> time I see this patch.

For the RESEND, I have a residual mailname file with
"localhost.localdomain" inside, i've checked log, some address received
messages, so i've changed the subject prefix to "resend". sorry for
that.

Thanks.

> 
> > USB chip:
> > NetChip
> > NET2888
> > 
> > Main chip:
> > 901041A
> > F721501APGF
> > 
> > Another modem using the same chips is the Zyxel Omni 56K DUO/NEO,
> > could be added with the right USB ID.
> > 
> > Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> > ---
> >  drivers/usb/serial/omninet.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
> > index 83c62f920c50..8be91f5a4dd7 100644
> > --- a/drivers/usb/serial/omninet.c
> > +++ b/drivers/usb/serial/omninet.c
> > @@ -26,6 +26,7 @@
> >  
> >  #define ZYXEL_VENDOR_ID		0x0586
> >  #define ZYXEL_OMNINET_ID	0x1000
> > +#define ZYXEL_OMNI_56K_PLUS_ID	0x1500
> >  /* This one seems to be a re-branded ZyXEL device */
> >  #define BT_IGNITIONPRO_ID	0x2000
> >  
> > @@ -41,6 +42,7 @@ static void omninet_port_remove(struct usb_serial_port *port);
> >  static const struct usb_device_id id_table[] = {
> >  	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNINET_ID) },
> >  	{ USB_DEVICE(ZYXEL_VENDOR_ID, BT_IGNITIONPRO_ID) },
> > +	{ USB_DEVICE(ZYXEL_VENDOR_ID, ZYXEL_OMNI_56K_PLUS_ID) },
> >  	{ }						/* Terminating entry */
> >  };
> >  MODULE_DEVICE_TABLE(usb, id_table);
> 
> Now applied with a slightly modified commit message. Thanks.
> 
> Johan

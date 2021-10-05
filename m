Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE2422141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhJEIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhJEIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:52:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF69C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 01:51:06 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1mXgA8-0006xB-Ek; Tue, 05 Oct 2021 10:51:00 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1mXgA8-0008Vr-3B; Tue, 05 Oct 2021 10:51:00 +0200
Date:   Tue, 5 Oct 2021 10:51:00 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Ferry Toth <fntoth@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v1 1/1] usb: dwc3: gadget: Revert "set gadgets parent to
 the right controller"
Message-ID: <20211005085100.GB17524@pengutronix.de>
References: <20211004141839.49079-1-andriy.shevchenko@linux.intel.com>
 <7019ca3e-f076-e65b-f207-c23a379ade29@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <7019ca3e-f076-e65b-f207-c23a379ade29@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:47:09 up 229 days, 12:11, 143 users,  load average: 0.19, 0.14,
 0.17
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2021 at 10:35:57PM +0200, Ferry Toth wrote:
>Hi,
>
>Op 04-10-2021 om 16:18 schreef Andy Shevchenko:
>>The commit c6e23b89a95d ("usb: dwc3: gadget: set gadgets parent to the ri=
ght
>>controller") changed the device for the UDC and broke the user space scri=
pts
>>that instantiate the USB gadget(s) via ConfigFS.
>
>I confirm this regression on Intel Edison since at least 5.15-rc2=20
>while in 5.14.0 it was working fine.
>
>This patch resolves the issue as tested on 5.15-rc4.
>
>Tested-by: Ferry Toth<fntoth@gmail.com>

NACK! Why should we resolv an issue by reverting it to solve not working
userspace. We already have this patch as a solution for solving a deeper
Problem, regarding the allocator addressing the right device.

>>Revert it for now until the better solution will be proposed.

So, I think fixing the userspace would be the right fix, not changing
the kernel. Otherwise we should find a proper solution.

>>
>>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>---
>>  drivers/usb/dwc3/gadget.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>index 8e66a70adae6..13664609ed3c 100644
>>--- a/drivers/usb/dwc3/gadget.c
>>+++ b/drivers/usb/dwc3/gadget.c
>>@@ -4253,7 +4253,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>  	}
>>-	usb_initialize_gadget(dwc->sysdev, dwc->gadget, dwc_gadget_release);
>>+	usb_initialize_gadget(dwc->dev, dwc->gadget, dwc_gadget_release);
>>  	dev				=3D &dwc->gadget->dev;
>>  	dev->platform_data		=3D dwc;
>>  	dwc->gadget->ops		=3D &dwc3_gadget_ops;
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmFcEfEACgkQC+njFXoe
LGSwEA//cvhxo3xRtqGqVnYMa0JT5KcGdAfR4/RQ5wwqvjbUSjylr4waULrVZNnQ
5SgPZN7l34c3I9B9QW7a9Yg+2iFlTiSqb2VRby0G16R4kIoxZqheIEsfIfOwJsY9
AcJf7BftF6Ubd0LjSL0l7mLH8ADV8tztgbE4WbpWB5yiEHzmY5I/Uqxteme4ZEtt
UzjV+bw/IqytMu5vzq18/9EPaZc21Z0obt4Gd3ElGXV8ryjsJ2qs9x0MxokJXLgZ
cOaCaeuIMgrhuiS9f8lWibNki8GY/v2jBfzBwnv0qa68vgobl8PDIsz2twWuZmnL
Xm8qwiQoRYCfZoMzKk3GzZRu4FHb0CFh1URvO4oQvgPH0pKQiBR4JwRf/LSSYMqO
zXvNSOrYi6feJQjFgT3Wfju7tkYbcxLhOewpqnSpKCnlGnAmX5DIsjHtGUxkAEYA
G6VOGrYcermQM0RBntnsA4YJmCpxV4HA5Sm8jU7v+GgS5hsVlfuMt1WOSfrovNcK
/3mHvhYOmJIPimWpr5tmUouznhVf6sVvbTJpPm7aMMMtksX0+4dgsH1Ac8L+Yzgh
5xk7AyFJb7dE7dRJX2trP6pKjmmjzfOfjehYszU+PR9CttQG8ddZgX6KtrorjE7d
x6tufHTlk36ZfE70ADN98Sa3gUgC7ra+J44hOde0kXjd6w4IvfE=
=nZkL
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF0316A58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhBJPh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhBJPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:37:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F38C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:36:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d13so1415698plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AExeMbU6/3BxOHLnhv3fYTbsrsNViVB+RCtpeImP3T8=;
        b=b3Ae+56yg1cB1V8FTSmCrOT0NAYqlRdeUMT2k/4uSx5NA5k10+m8hcnijT2xXmt9QH
         h9O15ZWnBdAf/0UBAhiQRKMmV4ZMpBiLv4i1uXHJ6X8ew9qUQecxzNDMCJ1Ie8absEa2
         BurQ2T+PVNOwhQZrApTAZF8jtbZvqvFGKclqEBjR6JIxSLOSsCsGNhk5pMq41xQVv6gi
         Jsx8vhiJGkSKGQuqEwSN8mQnt+zCsGWJeegTi69txmqy94HKS5vaCD2GrIMDdY6Ddu6C
         1nHXcjjtMhHjRV+cyv5SxHN645T5UmvjxGHseSIcUKDpeY0kWxIRJjD7ouM15B+ZilUI
         /SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AExeMbU6/3BxOHLnhv3fYTbsrsNViVB+RCtpeImP3T8=;
        b=NnBdkEA5WJ0u47G4xOLtY+4thneELvI/yQ4UFtPhEhdtkkVYkt+pHWeASp1duRQLL6
         mpQUkJ9IdDctNf/LTjvyq6KmlFOvBH/X4DDbixyJDgZb/TmiMlvTeYsAtU2QlKj3p5F3
         G/kfOQaeA1e5/g5kn2aTWLEJRag49HRmMrl22aMcBpLyaEgYoPA0tW1tkO34/Teabe8Q
         snBOHAZcWm7XF0+BiTeey+X9TtVEL2wxoJyx4phw3H7PpANps5LKthRdMIUVvar7MMGp
         WD1Spju0E2oKRe2n33viHnHOzXAtdkMWI4ztO8ltr9QMkejASPLR6woIkQYIE36bePre
         n7Jg==
X-Gm-Message-State: AOAM5318JU4SjHgScvodo/nyqpNaf6LuwIfnxp3l+MXshTaxHsw9XFeG
        9qOt/f8+olTPYzxuB9nnd+9x2UW6cWA=
X-Google-Smtp-Source: ABdhPJwyfWnpxMVVCqKFPkQcSKqZvbs0LaPo4DQFOW+BgK9wBo3szV3izhRJt4FsVlgJ6AXy6glWZw==
X-Received: by 2002:a17:90a:4598:: with SMTP id v24mr3520249pjg.135.1612971396414;
        Wed, 10 Feb 2021 07:36:36 -0800 (PST)
Received: from localhost ([103.200.106.135])
        by smtp.gmail.com with ESMTPSA id k69sm2841896pfd.4.2021.02.10.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 07:36:35 -0800 (PST)
Date:   Wed, 10 Feb 2021 21:06:21 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: gdm724x: Fix DMA from stack
Message-ID: <20210210153621.3nmwsegn5a7mb5v5@archlinux>
References: <20210210142512.23152-1-ameynarkhede03@gmail.com>
 <YCPz7jy6BLRzmvU3@kroah.com>
 <20210210150133.chf4gwefgcvaewnd@archlinux>
 <20210210151924.GA20820@kadam>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jyslrfw62hrxq7ip"
Content-Disposition: inline
In-Reply-To: <20210210151924.GA20820@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyslrfw62hrxq7ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/02/10 06:19PM, Dan Carpenter wrote:
> On Wed, Feb 10, 2021 at 08:31:33PM +0530, Amey Narkhede wrote:
> > On 21/02/10 03:55PM, Greg KH wrote:
> > > On Wed, Feb 10, 2021 at 07:55:12PM +0530, Amey Narkhede wrote:
> > > > Stack allocated buffers cannot be used for DMA
> > > > on all architectures so allocate hci_packet buffer
> > > > using kmalloc.
> > > >
> > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > ---
> > > > Changes in v3:
> > > > 	- Remove superfluous buf pointer
> > > > 	- Reduce size of allocation of hci_packet to match number of
> > > > 	bytes used for DMA
> > > >
> > > >  drivers/staging/gdm724x/gdm_usb.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> > > > index dc4da66c3..80c58a3ef 100644
> > > > --- a/drivers/staging/gdm724x/gdm_usb.c
> > > > +++ b/drivers/staging/gdm724x/gdm_usb.c
> > > > @@ -56,20 +56,24 @@ static int gdm_usb_recv(void *priv_dev,
> > > >
> > > >  static int request_mac_address(struct lte_udev *udev)
> > > >  {
> > > > -	u8 buf[16] = {0,};
> > > > -	struct hci_packet *hci = (struct hci_packet *)buf;
> > > > +	struct hci_packet *hci;
> > > >  	struct usb_device *usbdev = udev->usbdev;
> > > >  	int actual;
> > > >  	int ret = -1;
> > > >
> > > > +	hci = kmalloc(5, GFP_KERNEL);
> > >
> > > Why "5" and not:
> > > 	hci = kmalloc(sizeof(*hci), GFP_KERNEL);
>
> 5 is correct and sizeof(*hci) is 4.  The hci struct ends in a zero
> element array.  You could do:
>
> 	hci = kmalloc(struct_size(hci, data, 1), GFP_KERNEL);
>
> I'm not sure it's more readable.  But you still will have to resend
> because the patch passes "&hci" to usb_bulk_msg() instead of "hci" so it
> will corrupt memory.
>
> I always encourage people to write the patch and then sit on it over
> night and send it the next day.
>
> regards,
> dan carpenter
>
Yes I was about to send patch with kmalloc(sizeof(*hci) + sizeof(u8)).
Now I'll take your advice and send the patch tomorrow.

Thanks,
Amey

--jyslrfw62hrxq7ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAmAj/XQACgkQBBTsy/Z3
yzbaowgAmz+E/S2FJPQNOQbR3rn7hOqy0HcAUM5WNjZ8Q4Qnd5+K28z5mr1M47or
VFNNjtfq1pr46zPGUUm3sIsd+nfYkun5Ya+KlV6nbsw5uUqnUKQktietlN25k7No
MkEEze4w8FLZ55tgW0SuHPR+iAR++1FZuMDgDmJhlWJYN/oiHBqgq6TsRsRi3sT0
pev8ihSRzZRERb+msPAX8URUT+6qC+r7iHNMFfU9k9SpUBf1KRtzmab4F6+nZwRp
WUEeALP6HrKiMfWs6+74Hyp+MCyhHTOQ+BgUs5O51DKXT07NGf4BdfdAW+UwO1Ws
3grFxtVbeqWgnDKlWPCgOX0CEeuiGA==
=6vKP
-----END PGP SIGNATURE-----

--jyslrfw62hrxq7ip--

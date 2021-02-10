Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A83161CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhBJJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhBJI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:59:08 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:58:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x9so841422plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L0/WCK79u4jPyX14Fa6fB/Tf2pwYkuo5vf8cwq7WihA=;
        b=VvoSMbIBtE6TwgFr+sI9fVN0TDY69YNtnXI0+mFoPmPmSbcW0Dy6UQqwWyl8/3CVZb
         v/om2TUK0Rk+/ZF36X+uZHXx2IYC2445yUtMqZFTaor92hX/MrSvIZEhKypAr4iWoXjQ
         Go/fqKnqSxSDP7hHCNBJTUfgrdEIfe4ssbqlE4VsDAAwDp0mHnUNHG6B+vB0S581FxNt
         wmKHN5oHz1A7rqySv3B4Df8QdZhXHGMJZ6Tj7jx9DgNQUFy4tf39eSN8MF2sj+9LEen8
         Xu4rNqWSnWhtkeaKfhnOsZsyrPXgcTqfCmEJVcFP7AOv+lcjVQv2tPK1EkZ0X9jzNP4C
         ccGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0/WCK79u4jPyX14Fa6fB/Tf2pwYkuo5vf8cwq7WihA=;
        b=jy5+9A+YnOrzr+aOGCsqrpyNhSDZbJNW71FiPXZlUHDkybWwjnjszGY4ZnLce1bw8z
         LOvFQoQmCUu566FO0MRGIyJY7VHQMOFjvlnnTkjNCB8CQ0iDlfDCTwuItmMcXoazmYB0
         SYYke4l6JqbK70RhzMqfesN+Gso7gW6MUu1j1dCwcbVEify9IQ8Z+aOIQNZ2dZKmAxzg
         bv/7n+Mroun0rypCbWBrr+Z2o/WyUHrbTF87N0z0MSMTqIWz0wq/RNnqnG2HvfCe32FD
         AVkNcAAKOG5UaMwS28vU9HGnRiC/jllNqDeFLwl879sliIO4hOdTgGUsvTZsDtB8b7IR
         2j8Q==
X-Gm-Message-State: AOAM533H5H0Q3UglHLGo0JsULapGamfdOfmXv792s2BZz6HgOD4DIiFo
        31Jw/MPZfxyEYOgpufLr77c=
X-Google-Smtp-Source: ABdhPJyn66NKIEHIu0/ohiieMG0WLN8hvyCkuHxiliUEDHK1mjF/X2r04ZICF2ODInM8tHKAlOH9aw==
X-Received: by 2002:a17:90b:4a03:: with SMTP id kk3mr2120826pjb.206.1612947507189;
        Wed, 10 Feb 2021 00:58:27 -0800 (PST)
Received: from localhost ([103.200.106.135])
        by smtp.gmail.com with ESMTPSA id y2sm1450272pfe.118.2021.02.10.00.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:58:26 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:28:11 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gdm724x: Fix DMA from stack
Message-ID: <20210210085811.7dunnfly6cqw67m3@archlinux>
References: <20210210080134.1978-1-ameynarkhede03@gmail.com>
 <YCOUIFVuvJuPP3lX@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imubcj7qugnas5hs"
Content-Disposition: inline
In-Reply-To: <YCOUIFVuvJuPP3lX@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imubcj7qugnas5hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 21/02/10 09:06AM, Greg KH wrote:
> On Wed, Feb 10, 2021 at 01:31:34PM +0530, Amey Narkhede wrote:
> > Stack allocated buffers cannot be used for DMA
> > on all architectures so allocate hci_packet buffer
> > using kzalloc().
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> > Changes in v2:
> > 	- Fixed build warning
> > 	- Fixed memory leak using kfree
> >
> >  drivers/staging/gdm724x/gdm_usb.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
> > index dc4da66c3..c4a9b90c5 100644
> > --- a/drivers/staging/gdm724x/gdm_usb.c
> > +++ b/drivers/staging/gdm724x/gdm_usb.c
> > @@ -56,11 +56,15 @@ static int gdm_usb_recv(void *priv_dev,
> >
> >  static int request_mac_address(struct lte_udev *udev)
> >  {
> > -	u8 buf[16] = {0,};
> > -	struct hci_packet *hci = (struct hci_packet *)buf;
> > +	u8 *buf;
> > +	struct hci_packet *hci;
> >  	struct usb_device *usbdev = udev->usbdev;
> >  	int actual;
> >  	int ret = -1;
> > +	buf = kzalloc(16, GFP_KERNEL);
>
> checkpatch did not complain about this?
No. checkpatch shows no errors and warnings.
>
> And why do you need 'buf' anymore now?  Why not just allocate hci and
> pass that to the request instead?  Saves you an extra cast and an extra
> pointer.
>
> thanks,
>
> greg k-h
Thanks. I'll send v3. I assume now we don't need kzalloc anymore as we initialize
the hci_packet so kmalloc(sizeof(struct hci_packet),..) will do.

Amey

--imubcj7qugnas5hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEb5tNK+B4oWmn+0Z9BBTsy/Z3yzYFAmAjoCMACgkQBBTsy/Z3
yzbVKAf+Iph1lZz0+d3r8rBFI2plXv7eFKjbXmVguuPe3pI8qKhgxAmDq0KMTOai
qMtCIV4Iy08Y5UAZ5uXvswK6SULC9QJZ5M+e3U21lZmr3W1Ift6RUZKuxtOYrqwa
HSaKMXnuSxP5wF1KqGnCf+cdiNsWel26p4qgODylPn5Gfv2kpRiLIBvzRgSV7EaI
80Am5yQY2u5Jz+WsNK/uxq7Fj60yMlyFHlgRwiHwgguboLSGAhShcaDcY+/LaE/3
oyCrdQIQ/OYbb54zVpH+X/6coDZpm60ltmEqFscuGqtypSDom5eZalUsMggTlkl9
dbAsVy9gvdm4R7BE+/xoJY0L4Us3NA==
=FHTN
-----END PGP SIGNATURE-----

--imubcj7qugnas5hs--

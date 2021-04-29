Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE97C36F0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhD2UPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:15:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52752 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhD2UPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:15:02 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0F42A1C0B9F; Thu, 29 Apr 2021 22:14:15 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:14:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 056/190] Revert "media: davinci/vpfe_capture.c: Avoid
 BUG_ON for register failure"
Message-ID: <20210429201414.GF31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-57-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-57-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is no big deal either way, and I doubt it is malicious. It will
only hit during development. Returning error is more in line with
linux style.

I'd suggest keeping it.

Best regards,
								Pavel

ci/vpfe_capture.c
> index f9f7dd17c57c..bcedaf4523e0 100644
> --- a/drivers/media/platform/davinci/vpfe_capture.c
> +++ b/drivers/media/platform/davinci/vpfe_capture.c
> @@ -168,22 +168,21 @@ int vpfe_register_ccdc_device(const struct ccdc_hw_=
device *dev)
>  	int ret =3D 0;
>  	printk(KERN_NOTICE "vpfe_register_ccdc_device: %s\n", dev->name);
> =20
> -	if (!dev->hw_ops.open ||
> -	    !dev->hw_ops.enable ||
> -	    !dev->hw_ops.set_hw_if_params ||
> -	    !dev->hw_ops.configure ||
> -	    !dev->hw_ops.set_buftype ||
> -	    !dev->hw_ops.get_buftype ||
> -	    !dev->hw_ops.enum_pix ||
> -	    !dev->hw_ops.set_frame_format ||
> -	    !dev->hw_ops.get_frame_format ||
> -	    !dev->hw_ops.get_pixel_format ||
> -	    !dev->hw_ops.set_pixel_format ||
> -	    !dev->hw_ops.set_image_window ||
> -	    !dev->hw_ops.get_image_window ||
> -	    !dev->hw_ops.get_line_length ||
> -	    !dev->hw_ops.getfid)
> -		return -EINVAL;
> +	BUG_ON(!dev->hw_ops.open);
> +	BUG_ON(!dev->hw_ops.enable);
> +	BUG_ON(!dev->hw_ops.set_hw_if_params);
> +	BUG_ON(!dev->hw_ops.configure);
> +	BUG_ON(!dev->hw_ops.set_buftype);
> +	BUG_ON(!dev->hw_ops.get_buftype);
> +	BUG_ON(!dev->hw_ops.enum_pix);
> +	BUG_ON(!dev->hw_ops.set_frame_format);
> +	BUG_ON(!dev->hw_ops.get_frame_format);
> +	BUG_ON(!dev->hw_ops.get_pixel_format);
> +	BUG_ON(!dev->hw_ops.set_pixel_format);
> +	BUG_ON(!dev->hw_ops.set_image_window);
> +	BUG_ON(!dev->hw_ops.get_image_window);
> +	BUG_ON(!dev->hw_ops.get_line_length);
> +	BUG_ON(!dev->hw_ops.getfid);
> =20
>  	mutex_lock(&ccdc_lock);
>  	if (!ccdc_cfg) {

--=20
http://www.livejournal.com/~pavelmachek

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLE5YACgkQMOfwapXb+vK09gCgwLgfxuQdLSOaLuAryHEGjRKd
XbgAoI0Umku13n4WbQwhlJN09qyflshv
=4wPh
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--

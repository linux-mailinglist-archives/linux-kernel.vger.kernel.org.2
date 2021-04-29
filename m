Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1782D36F0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbhD2US1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:18:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52954 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbhD2US1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:18:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 516C01C0B9F; Thu, 29 Apr 2021 22:17:39 +0200 (CEST)
Date:   Thu, 29 Apr 2021 22:17:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 057/190] Revert "media: saa7146: Avoid using BUG_ON as an
 assertion"
Message-ID: <20210429201738.GG31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-58-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-58-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I doubt this is malicious, and BUG()s are ugly. I'd suggest keeping
this.

Best regards,
								Pavel


> diff --git a/drivers/media/common/saa7146/saa7146_video.c b/drivers/media=
/common/saa7146/saa7146_video.c
> index 7b8795eca589..d9d7d82ca451 100644
> --- a/drivers/media/common/saa7146/saa7146_video.c
> +++ b/drivers/media/common/saa7146/saa7146_video.c
> @@ -345,8 +345,7 @@ static int video_begin(struct saa7146_fh *fh)
> =20
>  	fmt =3D saa7146_format_by_fourcc(dev, vv->video_fmt.pixelformat);
>  	/* we need to have a valid format set here */
> -	if (!fmt)
> -		return -EINVAL;
> +	BUG_ON(NULL =3D=3D fmt);
> =20
>  	if (0 !=3D (fmt->flags & FORMAT_IS_PLANAR)) {
>  		resource =3D RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;
> @@ -399,8 +398,7 @@ static int video_end(struct saa7146_fh *fh, struct fi=
le *file)
> =20
>  	fmt =3D saa7146_format_by_fourcc(dev, vv->video_fmt.pixelformat);
>  	/* we need to have a valid format set here */
> -	if (!fmt)
> -		return -EINVAL;
> +	BUG_ON(NULL =3D=3D fmt);
> =20
>  	if (0 !=3D (fmt->flags & FORMAT_IS_PLANAR)) {
>  		resource =3D RESOURCE_DMA1_HPS|RESOURCE_DMA2_CLP|RESOURCE_DMA3_BRS;

--=20
http://www.livejournal.com/~pavelmachek

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLFGIACgkQMOfwapXb+vJ5uACeOEbsMVKYsFGZKpafQHboGB7I
kwAAn2QmGy6ehVV22bIkXDyY3r4IId4k
=m03W
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--

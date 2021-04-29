Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250236F0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhD2T6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 15:58:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51576 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbhD2T6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:58:13 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 01F841C0B9F; Thu, 29 Apr 2021 21:57:25 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:57:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 011/190] Revert "media: platform: fcp: Fix a reference
 count leak."
Message-ID: <20210429195725.GD31692@amd>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-12-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-12-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> --- a/drivers/media/platform/rcar-fcp.c
> +++ b/drivers/media/platform/rcar-fcp.c
> @@ -102,10 +102,8 @@ int rcar_fcp_enable(struct rcar_fcp_device *fcp)
>  		return 0;
> =20
>  	ret =3D pm_runtime_get_sync(fcp->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(fcp->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	return 0;
>  }

This one, 12/, 13/ 14/ of the series look correct to me, and should NOT be
reverted.

Additinaly 19/, 21/, 27/, 30/, 32/, 33/ and 62/ looked correct to me,
but you already decided they should be kept, so no action needs to be
done there.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCLD6UACgkQMOfwapXb+vI30ACdFquhSZ1/zo7Rf0UpXi5/9SwC
gPwAnAhnLISFQpsjqKXur2TrTumit3WT
=nSqq
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--

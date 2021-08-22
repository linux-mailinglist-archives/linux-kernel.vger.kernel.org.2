Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225263F40A8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhHVRT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 13:19:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58786 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHVRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 13:19:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 826131C0B76; Sun, 22 Aug 2021 19:18:43 +0200 (CEST)
Date:   Sun, 22 Aug 2021 19:18:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Kai Vehmanen <kai.vehmanen@nokia.com>
Subject: Re: [PATCH] HSI: cmt_speech: unmark comments as kernel-doc
Message-ID: <20210822171841.GA22647@duo.ucw.cz>
References: <20210822163838.15964-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20210822163838.15964-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2021-08-22 09:38:38, Randy Dunlap wrote:
> Fix build warnings from the kernel test robot:
>=20
> drivers/hsi/clients/cmt_speech.c:831: warning: This comment starts with '=
/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-=
doc.rst
>     * Block until pending data transfers have completed.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Aditya Srivastava <yashsri421@gmail.com>
> Cc: Kai Vehmanen <kai.vehmanen@nokia.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

Best regards,
								Pavel

> @@ -827,7 +827,7 @@ static int check_buf_params(struct cs_hs
>  	return r;
>  }
> =20
> -/**
> +/*
>   * Block until pending data transfers have completed.
>   */
>  static int cs_hsi_data_sync(struct cs_hsi_iface *hi)
> @@ -850,7 +850,7 @@ static int cs_hsi_data_sync(struct cs_hs
>  			r =3D -ERESTARTSYS;
>  			goto out;
>  		}
> -		/**
> +		/*
>  		 * prepare_to_wait must be called with hi->lock held
>  		 * so that callbacks can check for waitqueue_active()
>  		 */

--=20
http://www.livejournal.com/~pavelmachek

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYSKG8wAKCRAw5/Bqldv6
8iBTAJ9CNZlvHw5rKLBwWGhGOVXMxguhKACaAhoAMGBAqCnGCWcGxVTERHLbXDw=
=3fAf
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

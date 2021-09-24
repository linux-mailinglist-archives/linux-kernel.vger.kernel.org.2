Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1871416F85
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245400AbhIXJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:52:20 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60624 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbhIXJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:51:58 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1A2481C0BA3; Fri, 24 Sep 2021 11:50:22 +0200 (CEST)
Date:   Fri, 24 Sep 2021 11:50:21 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] f2fs: fix incorrect return value in
 f2fs_sanity_check_ckpt()
Message-ID: <20210924095021.GA16651@duo.ucw.cz>
References: <20210922152705.720071-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20210922152705.720071-1-chao@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This code looks quite confused: part of function returns 1 on
> corruption, part returns -errno. The problem is not stable-specific.
>=20
> [1] https://lkml.org/lkml/2021/9/19/207
>=20
> Let's fix to make 'insane cp_payload case' to return 1 rater than
> EFSCORRUPTED, so that return value can be kept consistent for all
> error cases, it can avoid confusion of code logic.
>=20
> Fixes: 65ddf6564843 ("f2fs: fix to do sanity check for sb/cp fields corre=
ctly")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Pavel Machek <pavel@denx.de>

(This is good minimal fix, but eventually I believe the function
should switch to 0/-errno... for consistency with rest of kernel).

Thank you,
								Pavel
							=09
> +++ b/fs/f2fs/super.c
> @@ -3487,7 +3487,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  		NR_CURSEG_PERSIST_TYPE + nat_bits_blocks >=3D blocks_per_seg)) {
>  		f2fs_warn(sbi, "Insane cp_payload: %u, nat_bits_blocks: %u)",
>  			  cp_payload, nat_bits_blocks);
> -		return -EFSCORRUPTED;
> +		return 1;
>  	}
> =20
>  	if (unlikely(f2fs_cp_error(sbi))) {

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYU2fXQAKCRAw5/Bqldv6
8pXIAJ4nca/YOddxdbLx3i18slR3oC/ClQCeJWytQZvNXNh3szUC6zUX3YfJexw=
=nsrq
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

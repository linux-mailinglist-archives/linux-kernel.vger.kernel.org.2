Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34420367FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhDVLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236159AbhDVLn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:43:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FD3C6145B;
        Thu, 22 Apr 2021 11:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619091801;
        bh=hnsxBEVDgL73sOas/tCkZVWYSPbRCbBc9Cr4bnAgVhw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O3W8rGtH4iLlcIoJEpgRKDIE7E+Dch27Lp0k2K34Vo1MBfjMvm2VL1V6Ad1EIDex3
         OoWKNUMOdEigN3I3kFDP5PNgVGgk9dmTTtbR3QCo0Jtg0p9THS9WoVXg4TLrAeNB5q
         uFN28iw01tzQcafrTHrSOB2Pm7dgN7pVb6M5meGOvuJhFE/DioK7gAMyFWfvC9ZKfy
         gf/o2EsOD5VT7QmcHZH06ukuL4ip10ndQudviIvxP4m0QP+OAw2tMGsJ+c2TUqFFGw
         FH+YgINpM5E4V7YLH3/HHWkj4Y2No64lgjyEKnp7v9fiBwkjvRDCpeTukL0FZM7NKK
         9+ZFlbN9tHHkQ==
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 045/190] Revert "usb: gadget: fix potential double-free
 in m66592_probe."
In-Reply-To: <20210421130105.1226686-46-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-46-gregkh@linuxfoundation.org>
Date:   Thu, 22 Apr 2021 14:43:15 +0300
Message-ID: <87czummtnw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> This reverts commit 44734a594196bf1d474212f38fe3a0d37a73278b.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/gadget/udc/m66592-udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc=
/m66592-udc.c
> index 931e6362a13d..75d16a8902e6 100644
> --- a/drivers/usb/gadget/udc/m66592-udc.c
> +++ b/drivers/usb/gadget/udc/m66592-udc.c
> @@ -1667,7 +1667,7 @@ static int m66592_probe(struct platform_device *pde=
v)
>=20=20
>  err_add_udc:
>  	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
> -	m66592->ep0_req =3D NULL;

harmless, can be reverted and left reverted, I guess.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAmCBYVMRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbpvg//feehQGU67eeH7IANxfSC6IpbnwO7a/TA
6fVEoXBoXE9hJnb36f9A5riXhyhT7Hzlu1+iJpa2y+l/ZJzlFAa8uZ7aIEkP86yL
MdeoqvlFgkimKYZZXNq38n/nipMlwBNYDRZcrhOj9UHGY5op2G5OSqoPEKc2vKp1
g2xWBRaAXdUn+JvbDUdUlAmYShHZ4nRKSwxi45qcFuFMx5CgKAlXNvoBCQKs4J2v
l52COX4gHNN2cxU9JtH6odblLYcLqmKM0AX+Jyhz+EZOSrwM2K3HpBkyzjHW36gV
dM687kZJe2wzeoV0ZWu+J7kifka6m2RtocnC+Fa6f04cHGcq1NFAVllA90OEoHDB
h9dTIANGGUDSpHzl+U2AgGyN5JTjWYTs/9EyqudqCcj7W8AFCQ/ZUny0eASyAnVL
RDBlmniO9PLWK4JUole7Vuk5PfiE++KzKt90hxM5QxiNdhIxbVkV4+OWSBH6458o
8er/NjZct8K+Tk9L0gQcBlTH58vk8vpeynluV0vRa59Pb2zJTiUwr7azHwYVTXIz
t9LdRKcyvJ4PdJXKQZHVIAlH19dLDpYlM7FFpPbEXKE8Wfa60598Rtp93w9n6rbg
MX+rg+zQNDDf+TjG88hbfOcFRWG8c/tBK6sykE1efwjJPGa2vBr0hI2akwbcrlr7
XHWhE+VWo7I=
=0hqT
-----END PGP SIGNATURE-----
--=-=-=--

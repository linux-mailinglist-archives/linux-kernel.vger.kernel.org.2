Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D445E8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348056AbhKZHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:53:28 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:59545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbhKZHv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:51:27 -0500
Received: from leknes.fjasle.eu ([92.116.70.26]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MmDZI-1m8Plh47uK-00iFvg; Fri, 26 Nov 2021 08:48:02 +0100
Received: from lillesand.fjasle.eu (unknown [IPv6:fd00::eadf:70ff:fe12:9041])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "lillesand.fjasle.eu", Issuer "Fake LE Intermediate X1" (not verified))
        by leknes.fjasle.eu (Postfix) with ESMTPS id A8FC13C57D;
        Fri, 26 Nov 2021 08:48:00 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by lillesand.fjasle.eu (Postfix, from userid 1000)
        id D142A106F1B; Fri, 26 Nov 2021 08:47:59 +0100 (CET)
Date:   Fri, 26 Nov 2021 08:47:59 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] fscache: re-match MODULE_PARM_DESC() calls to
 module parameters
Message-ID: <YaCRLx0/CvrxqlZM@lillesand.fjasle.eu>
References: <YTX02eiVawkpTquX@fjasle.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tephn8Z5lGDb1jFQ"
Content-Disposition: inline
In-Reply-To: <YTX02eiVawkpTquX@fjasle.eu>
X-Operating-System: Debian GNU/Linux bookworm/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:ZtYkmr9w5hy014mLoecCecpDJ1YoEVbGE/AMW5XS4wxcswZPp1l
 YEvzU84XphZgM4rbLtzWqJ1dt91uWo8jFrvH5PhPcWhsFXs0xv96LeEvbtg9WFl/KMPzHwk
 04vE0t5oa2n5BH2YgFjFlr+pl6SCN3isbiB4vtqs5UMTkEQUr6JtjWNxlewVQlJ0q4zEn/A
 AdCNXZafMAG8xord9rj1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Vow/qss8kI=:DXiSvVpVtVtNM6SzsHWts4
 utRTFNp3tnJJzwHnlveIYeMhen/M3lS7stRO3AcTZFHTiwYYyRhC3TGCQypj4cyIwx2dXtS9Z
 46+q1y0Ls4+VxWULV2wmjFs69zQ/VzCwiTrxsO/V9CQ5XsUd5xeVPQf/Z1GTNvDvOpaRHj+G0
 nZzJIzdYm9oOK7mgLNHsKBex7hkYBY2zFzghMJuhX+CwZoCKprjHXduGjaQDAEkgZs24kli7e
 hVPAH4IHbGOcueQ8tFFZEmU3jnXXpm8nit1CTnmmKA35f5eJxgWhCoqPekXivsgtXlWSJn4VO
 BRAkwNYqHkiTbrSptqJvPN4ZU2qEhOrECLFpfTF4TCdyGSViW+ro7EtNPXPaDisDI31qD6945
 k4zAUVbDQt6nHYPn4pHC4I7kVmBMdhwk9ixfiS6SnKlXb1s1ILYxhBBggJt0aXawpcz93SE8n
 1kV5Dt7hV4RG9U6ciZJ2Iv/lESEuafedS24YTZS+ta97wfwt8FtNVugbbu6B82WcrHBYFY7ma
 UG6jSp7hHfJxboN7k966q680sRIisoGYzyQtlKlWm1zl0GEI7u+R2yVzvsI9KBMgMsFdiZm0D
 wupsceejsaRW1UWm9evSeao9t3qID7Xeg5xrzlt5vZFeMjwZfwbdLaC4ByxzjLaBtE21mR9Fa
 8fAurYepK2xOgBsmas4LMpNnr95XiRmOwPw0W4+5fOEK0JJh7ldWWl2fR5KBwPEN4oPU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tephn8Z5lGDb1jFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon Sep  6 13:00:41 2021 Nicolas Schier wrote:
> Fix calls of MODULE_PARM_DESC() such that the first argument matches=20
> the
> actual module parameter name.  This changes the 'parm' section in the
> output of `modinfo fscache` from:
>=20
>     parm: defer_lookup:uint
>     parm: fscache_defer_lookup:Defer cookie lookup to background thread
>     parm: defer_create:uint
>     parm: fscache_defer_create:Defer cookie creation to background thread
>     parm: debug:uint
>     parm: fscache_debug:FS-Cache debugging mask
>=20
> into:
>=20
>     parm: defer_lookup:Defer cookie lookup to background thread (uint)
>     parm: defer_create:Defer cookie creation to background thread (uint)
>     parm: debug:FS-Cache debugging mask (uint)
> .
>=20
> Signed-off-by: Nicolas Schier <nicolas@fjasle.eu>
> ---
>  fs/fscache/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> --
> Resend unmodified as list approval for linux-cachefs@r.c timed out.
>=20
> diff --git a/fs/fscache/main.c b/fs/fscache/main.c
> index c1e6cc9091aa..ccb06dc0a6e9 100644
> --- a/fs/fscache/main.c
> +++ b/fs/fscache/main.c
> @@ -22,19 +22,19 @@ MODULE_LICENSE("GPL");
>  unsigned fscache_defer_lookup =3D 1;
>  module_param_named(defer_lookup, fscache_defer_lookup, uint,
>  		   S_IWUSR | S_IRUGO);
> -MODULE_PARM_DESC(fscache_defer_lookup,
> +MODULE_PARM_DESC(defer_lookup,
>  		 "Defer cookie lookup to background thread");
> =20
>  unsigned fscache_defer_create =3D 1;
>  module_param_named(defer_create, fscache_defer_create, uint,
>  		   S_IWUSR | S_IRUGO);
> -MODULE_PARM_DESC(fscache_defer_create,
> +MODULE_PARM_DESC(defer_create,
>  		 "Defer cookie creation to background thread");
> =20
>  unsigned fscache_debug;
>  module_param_named(debug, fscache_debug, uint,
>  		   S_IWUSR | S_IRUGO);
> -MODULE_PARM_DESC(fscache_debug,
> +MODULE_PARM_DESC(debug,
>  		 "FS-Cache debugging mask");
> =20
>  struct kobject *fscache_root;
> --=20
> 2.30.1

David,  I got no feedback on this here, yet.  Shall I fix something or=20
is there anything wrong with the patch? =20

Kind regards,
Nicolas

--tephn8Z5lGDb1jFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmGgkS8ACgkQB1IKcBYm
EmkV4hAAgsK+KGS+gHIn+QYzN4RY4hNVUo2dIX6990kgZQhiuJr0Ut7WbOUwOEw3
JeazkIu2S77G3G6kE2weUfeFft3dS+C6BqYI9GbmRWCTfPeUlg1PUq4/WIIfIC5V
Anln4x1Jzyx4ZLMPAevtHkIUvmN+57joAcksdX4GWblcvLUjELD9zccoY67oLcyG
oPX3jtUK8/eUTcltWo+lcWFPaMv/7Aa9pN3CNtZacseVUnlYuQ53QYz7ZK6PqcZe
NYRCCFZZvxAGf8AfGaieH/T/e2CU/FLuD3D3LFAj6uYfC1sQQO0ErQMLr1sJlu2H
i+Bjw6NDtS9WLFOrI0w+MZwa6fT3SRPq7MLOVlC7q9jFjVOR/tBZcpxoZLYH9gdV
ApZlSXBghkZqkRaOX2GzdfruS2ZpJusL2dSyoL9JiawdxbUi91VPL5J+TtovBetx
NZfVnLw2brdhQYj8TbEyJI1j8YB9wyVz+L1IxpeJH0e2bpB0EnPS9zBzVquCN2UV
KEcijQK31vUJyRCC31YZRh1tC2dVLUs8UKxLMAvaepZI/WY0wbS/YYMoh1pHFQ1t
1ZjzxDHg3ua1ck9t51nt2nyBxOBWFZdlEXjJdM5dhySaEutWsvW2Yn21IRJe5Sns
NRvzm+iQ2mGambLVkvKMeOI+HnkoJIxNWxCN2IXCbQI1kZC34r4=
=u7j8
-----END PGP SIGNATURE-----

--tephn8Z5lGDb1jFQ--

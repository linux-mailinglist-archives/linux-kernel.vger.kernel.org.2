Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6144DAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 18:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhKKRNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 12:13:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47214 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 12:13:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ritesh)
        with ESMTPSA id A98661F45F82
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636650610; bh=gzPwpXJRMu8yzxK71eUeHysRVbadXnuxET79GLTdXvs=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=Y+st0clLbWs4fJEgkPCjylHIHvLiZ+9PqzG5cVNhwuC5Mx2yVQrn2gmHkwbfSzbYb
         HFq769dnw6DibwKqHvLkhyz33TtPfhAiFqkucw/lkAHlvpEad4QiVMDO2c2tzvt4De
         UpY8dvVlJ/htSTJPB7i1ZkOHicRNhzSl5lODogfx+JjRHbD3aA6qVJAMee9nbmoxdD
         9DxNG6yDg6BRtHxBEEkNjgE4sQAmeizqWX7vyuolTNFik9X6VPHCNH1Q06n9TOyQVU
         GsQRd3vby6zjqdLq0yTHtqGAHKU4G5L63xT7I8MYwmnWZGckSo9P5iflkqzKJzryZt
         W1E2WbuD3wzaA==
Message-ID: <ba9a4b5405774f157df790c57d658b9f37e1ae61.camel@collabora.com>
Subject: Re: [PATCH] hostfs: Fix writeback of dirty pages
From:   Ritesh Raj Sarraf <ritesh.sarraf@collabora.com>
Reply-To: ritesh.sarraf@collabora.com
To:     Sjoerd Simons <sjoerd@collabora.com>, linux-um@lists.infradead.org
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Nov 2021 22:40:02 +0530
In-Reply-To: <20211105081052.2353801-1-sjoerd@collabora.com>
References: <20211105081052.2353801-1-sjoerd@collabora.com>
Organization: Collabora
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-mPx2yEaImVsfjNu+RXgK"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mPx2yEaImVsfjNu+RXgK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-11-05 at 09:10 +0100, Sjoerd Simons wrote:
> Hostfs was not setting up the backing device information, which means
> it
> uses the noop bdi. The noop bdi does not have the writeback
> capability
> enabled, which in turns means=C2=A0 dirty pages never got written back to
> storage.
>=20
> In other words programs using mmap to write to files on=C2=A0 hostfs neve=
r
> actually got their data written out...
>=20
> Fix this by simply setting up the bdi with default settings as all
> the
> required code for writeback is already in place.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>=20

Tested-by: Ritesh Raj Sarraf <ritesh@collabora.com>

> ---
>=20
> =C2=A0fs/hostfs/hostfs_kern.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index d5c9d886cd9f..ef481c3d9019 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -924,6 +924,9 @@ static int hostfs_fill_sb_common(struct
> super_block *sb, void *d, int silent)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sb->s_op =3D &hostfs_sbop=
s;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sb->s_d_op =3D &simple_de=
ntry_operations;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sb->s_maxbytes =3D MAX_LF=
S_FILESIZE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D super_setup_bdi(sb);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto out;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* NULL is printed as '(n=
ull)' by printf(): avoid that. */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (req_root =3D=3D NULL)

--=20
Ritesh Raj Sarraf
Collabora

--=-mPx2yEaImVsfjNu+RXgK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmGNTmoACgkQpjpYo/Lh
dWnuIw/9Hs9NnkW5ktqmp8OL7AQFsgz/XAWlA45RW/5X8qPmRDDVm5PuvDeLdqbn
luiP6lwGDL4kDu6FXVR2CAEFiNeRTD8eIuLUsK8o6M0ceINdRXbbmRxA7o2zsQgP
GPTyUM7RdlEQco9BebY7Jz8EfKpaIPEMDN4Xt4oqqGLEULiq65qFahLBBq9sELvM
TPPMvTHCcdQ73ZA9UIbBg/raeyAHZFRc25yVw9escbZhISIwAJ14ZO0VhOuufPHj
pS2ZuYS0zCfx5Y6tJoFt0nhCWG+9U4OG1f4CEQhxRk9wyvb1IWbhL3n5rpkK/guD
hH0G9KAMzRSxs7BCInibIeKolFzSk+T3JjZW9Wr7PPB3bbLp4WVmdmb2R2A2cYh/
InzxwJ01iwtu1HXvp5TXpIWJ2ascPYML2SJnPJiFnc81K1e2w2VuoNv2nRTt1xOh
/4t+PYzOB7jzqqzVCoqxXJs02+vASVaXI7WzZIDLnT7CRMyGRLZ+S+6pJ9aVysMN
p4d5hneM2h4F0fvWq4kkKApwB01jBoOEcvJuZiOaz5iGPiUIO2CU32z5pU/TSztE
uNhn7ksm2JnGX1qoESiYCI2G80rN1tNElAFcLUt5+wLJeZAt41tA6SG0jeG3zUL6
pcEBytWB2NCox8LZM6lLEW3X1mhmx3GD/SfNuxjCKQoeCtrMY90=
=wNMv
-----END PGP SIGNATURE-----

--=-mPx2yEaImVsfjNu+RXgK--

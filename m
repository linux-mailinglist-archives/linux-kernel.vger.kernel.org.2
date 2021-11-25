Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3C45E318
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 23:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbhKYWrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 17:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhKYWpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:45:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E609C0613D7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 14:41:37 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J0Xt626fmz4xdT;
        Fri, 26 Nov 2021 09:41:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1637880095;
        bh=nlaUd9W0tHCOhsyv8/Mj4y6isLo9UUrKlGwjXMPqxhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hs1ZVK5+xUJJHcbPE8yKP38GbX3mJ7gGHh61yR/7uOtsK7X5YQbUPruGKyV0E+Cg9
         gIOWGQYo5RdkEsUe2MclH3kN5kwnmrTj3rTq/bn5PXzsEku4IhKCTu1ac1Gmx1At+x
         oGP70uitSSmOpzeAaaoF3b7Mrb8WklVzw08jRejN6kx6Vy5soAFbeDHZVjAny1meL1
         iXV4gEHcrt6ypzZR6OQp6XDnTqcKfQq8nbNYyhkq2IBVup8jDjIL7SYNVpqREqREI5
         V++s6a7LLn9HDxJp6J4yCchCap+UImmvN8AgTqr9GMrUe0pcRbhossQLVFCq+3oOWG
         YUJe183SwdSLQ==
Date:   Fri, 26 Nov 2021 09:41:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nubus: Rename pde_data var to fix conflict with
 external function
Message-ID: <20211126094133.6eae75fd@canb.auug.org.au>
In-Reply-To: <20211125083808.82560-1-geert@linux-m68k.org>
References: <20211125083808.82560-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kxt5KF1MAk6lTn0K+HoKuzs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kxt5KF1MAk6lTn0K+HoKuzs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 25 Nov 2021 09:38:08 +0100 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> In file included from drivers/nubus/proc.c:24:
> drivers/nubus/proc.c: In function =E2=80=98nubus_proc_rsrc_show=E2=80=99:
> ./include/linux/proc_fs.h:123:21: error: called object =E2=80=98pde_data=
=E2=80=99 is not a function or function pointer
>   123 | #define PDE_DATA(i) pde_data(i)
>       |                     ^~~~~~~~
> drivers/nubus/proc.c:112:13: note: in expansion of macro =E2=80=98PDE_DAT=
A=E2=80=99
>   112 |  pde_data =3D PDE_DATA(inode);
>       |             ^~~~~~~~
> drivers/nubus/proc.c:110:30: note: declared here
>   110 |  struct nubus_proc_pde_data *pde_data;
>       |                              ^~~~~~~~
>=20
> Fix this by renaming the local variable to "pde".  Do this everywhere
> for consistency.
>=20
> Reported-by: noreply@ellerman.id.au
> Fixes: e7e935db128e724f ("fs: proc: store PDE()->data into inode->i_priva=
te")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Not fixed by commit 5de6353a96bec91d ("proc: remove PDE_DATA()
> completely"), which just removes the macro indirection.
> ---
>  drivers/nubus/proc.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/nubus/proc.c b/drivers/nubus/proc.c
> index 22fb11da519bfc43..aff1c5d257cd8183 100644
> --- a/drivers/nubus/proc.c
> +++ b/drivers/nubus/proc.c
> @@ -93,30 +93,30 @@ struct nubus_proc_pde_data {
>  static struct nubus_proc_pde_data *
>  nubus_proc_alloc_pde_data(unsigned char *ptr, unsigned int size)
>  {
> -	struct nubus_proc_pde_data *pde_data;
> +	struct nubus_proc_pde_data *pde;
> =20
> -	pde_data =3D kmalloc(sizeof(*pde_data), GFP_KERNEL);
> -	if (!pde_data)
> +	pde =3D kmalloc(sizeof(*pde), GFP_KERNEL);
> +	if (!pde)
>  		return NULL;
> =20
> -	pde_data->res_ptr =3D ptr;
> -	pde_data->res_size =3D size;
> -	return pde_data;
> +	pde->res_ptr =3D ptr;
> +	pde->res_size =3D size;
> +	return pde;
>  }
> =20
>  static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
>  {
>  	struct inode *inode =3D m->private;
> -	struct nubus_proc_pde_data *pde_data;
> +	struct nubus_proc_pde_data *pde;
> =20
> -	pde_data =3D pde_data(inode);
> -	if (!pde_data)
> +	pde =3D pde_data(inode);
> +	if (!pde)
>  		return 0;
> =20
> -	if (pde_data->res_size > m->size)
> +	if (pde->res_size > m->size)
>  		return -EFBIG;
> =20
> -	if (pde_data->res_size) {
> +	if (pde->res_size) {
>  		int lanes =3D (int)proc_get_parent_data(inode);
>  		struct nubus_dirent ent;
> =20
> @@ -124,11 +124,11 @@ static int nubus_proc_rsrc_show(struct seq_file *m,=
 void *v)
>  			return 0;
> =20
>  		ent.mask =3D lanes;
> -		ent.base =3D pde_data->res_ptr;
> +		ent.base =3D pde->res_ptr;
>  		ent.data =3D 0;
> -		nubus_seq_write_rsrc_mem(m, &ent, pde_data->res_size);
> +		nubus_seq_write_rsrc_mem(m, &ent, pde->res_size);
>  	} else {
> -		unsigned int data =3D (unsigned int)pde_data->res_ptr;
> +		unsigned int data =3D (unsigned int)pde->res_ptr;
> =20
>  		seq_putc(m, data >> 16);
>  		seq_putc(m, data >> 8);
> @@ -142,18 +142,18 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry =
*procdir,
>  			     unsigned int size)
>  {
>  	char name[9];
> -	struct nubus_proc_pde_data *pde_data;
> +	struct nubus_proc_pde_data *pde;
> =20
>  	if (!procdir)
>  		return;
> =20
>  	snprintf(name, sizeof(name), "%x", ent->type);
>  	if (size)
> -		pde_data =3D nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
> +		pde =3D nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
>  	else
> -		pde_data =3D NULL;
> +		pde =3D NULL;
>  	proc_create_single_data(name, S_IFREG | 0444, procdir,
> -			nubus_proc_rsrc_show, pde_data);
> +			nubus_proc_rsrc_show, pde);
>  }
> =20
>  void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,

I will apply that to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/kxt5KF1MAk6lTn0K+HoKuzs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGgER0ACgkQAVBC80lX
0GxvdQf/eNvmkFiAljQDufRVjwgWomvmlol1phwO73AsKvmeFa4JzKiHKZv4D1UO
bXUZxhIvfoOdLOiTvcSrthWQNWO7P4xxWiJGpp2MDui3JJ4MGB9gf4oIzcP3aiIv
KUenPvZEu96SU29DDAzbGIMfBPVeKkA3bcnuHyKwvfYB0S1pM0iAydloFyQDNgq4
FF1jqcqwxJ7NPGHCDIl/Ylbk5Xs9oz626O3tm7Nds8Paq1ESPwnwgUrPkvT0rRRV
qHwgbDXW/i2E1C6CATrbioEop1t0Q7yKOxpyMs38Qqxw91eupsVUjiCRllQ8BNT0
z1qYpkuhcNqpgoxxL9DMRcULwfVIPQ==
=y5F9
-----END PGP SIGNATURE-----

--Sig_/kxt5KF1MAk6lTn0K+HoKuzs--

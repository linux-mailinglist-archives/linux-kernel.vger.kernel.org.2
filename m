Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2345E2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243593AbhKYVzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 16:55:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43019 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245722AbhKYVxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:53:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EB9305C0218;
        Thu, 25 Nov 2021 16:50:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 25 Nov 2021 16:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jYSlKM
        Aet0/1c+eF2iMVgokx8yoKQHQWMZx83vCGDaQ=; b=IJBmtDxk4pC6PK9d32vFZj
        FxH87VYY/WXixkegfWbRAx1gCSBsySRAMM/P12HrfIM8HKaex11TwhED/M2nHkwS
        sUYT24hV9pn6HQNvEvHWOnAUst0scXW0AbQkX7r/z7s2KFj+pD7xlOoQOxcLoDku
        +YBYq9jEivKQ/5InbQtsS9KckyQDVkuRw7lq3MC1jfGh/OxL6KULCZcCrpzRaBBi
        x2dsUYWJyZTRs53fnbGO3oIoa0IpDGTK8Ge6KisrxU+RThuP+AHhhWGG7LG4Ernn
        PYSwajbPNaXuiyupDx/hdVSmeh2eeb5lVPvlmYKAiFOkGg2ReHez2EKfISFlsYHQ
        ==
X-ME-Sender: <xms:DgWgYe-maLbDXkG6PQxosZNx82hFq2675pHn2lnhT5SVRPbuJZGcSw>
    <xme:DgWgYevp0x59Eq_t0vEjCznedrnH0hmfn53G6D-IYlLiLdb_XMsp9wUzswsH6tXLz
    y45l7MA2fr8qyr_9Ns>
X-ME-Received: <xmr:DgWgYUATaOo-USQKz2KCjo6P_v_rf4aAAvfinyNGf95CdKx6wReIuEmaEHvs6U66BRkbeIpNJ9dTzMQQke8NP-OD5LuH10OVsYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrhedtgdduhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesmhdtreertddtjeenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepfeffjeeigfehveehfeevhfetgefgieejieeviefhffffudfgfeekleffhffg
    hedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:DgWgYWcef9OnvHkdG4S1NWkI8uSly0oaSViIs8o5L0_QNoP9IdPDcQ>
    <xmx:DgWgYTNAqNcRiEF2VFgblD0NFkeiP8xSpPzmGurSyWqhAXR_gbOusg>
    <xmx:DgWgYQnEO-ayMqLmEweGR4otN-2yw3RsSNz_NebdS-fVcuOlXyMquA>
    <xmx:DgWgYYoeknvUlTTpl5hhRoBtqhwZXRITne15aWfpNphgUs00GnXuvQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Nov 2021 16:50:03 -0500 (EST)
Date:   Fri, 26 Nov 2021 08:50:00 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] nubus: Rename pde_data var to fix conflict with
 external function
In-Reply-To: <20211125083808.82560-1-geert@linux-m68k.org>
Message-ID: <9af12089-95d-dbf0-4e78-abe763ee333c@linux-m68k.org>
References: <20211125083808.82560-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-775371871-1637877000=:31307"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-775371871-1637877000=:31307
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE


On Thu, 25 Nov 2021, Geert Uytterhoeven wrote:

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

Acked-by: Finn Thain <fthain@linux-m68k.org>

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
> -=09struct nubus_proc_pde_data *pde_data;
> +=09struct nubus_proc_pde_data *pde;
> =20
> -=09pde_data =3D kmalloc(sizeof(*pde_data), GFP_KERNEL);
> -=09if (!pde_data)
> +=09pde =3D kmalloc(sizeof(*pde), GFP_KERNEL);
> +=09if (!pde)
>  =09=09return NULL;
> =20
> -=09pde_data->res_ptr =3D ptr;
> -=09pde_data->res_size =3D size;
> -=09return pde_data;
> +=09pde->res_ptr =3D ptr;
> +=09pde->res_size =3D size;
> +=09return pde;
>  }
> =20
>  static int nubus_proc_rsrc_show(struct seq_file *m, void *v)
>  {
>  =09struct inode *inode =3D m->private;
> -=09struct nubus_proc_pde_data *pde_data;
> +=09struct nubus_proc_pde_data *pde;
> =20
> -=09pde_data =3D pde_data(inode);
> -=09if (!pde_data)
> +=09pde =3D pde_data(inode);
> +=09if (!pde)
>  =09=09return 0;
> =20
> -=09if (pde_data->res_size > m->size)
> +=09if (pde->res_size > m->size)
>  =09=09return -EFBIG;
> =20
> -=09if (pde_data->res_size) {
> +=09if (pde->res_size) {
>  =09=09int lanes =3D (int)proc_get_parent_data(inode);
>  =09=09struct nubus_dirent ent;
> =20
> @@ -124,11 +124,11 @@ static int nubus_proc_rsrc_show(struct seq_file *m,=
 void *v)
>  =09=09=09return 0;
> =20
>  =09=09ent.mask =3D lanes;
> -=09=09ent.base =3D pde_data->res_ptr;
> +=09=09ent.base =3D pde->res_ptr;
>  =09=09ent.data =3D 0;
> -=09=09nubus_seq_write_rsrc_mem(m, &ent, pde_data->res_size);
> +=09=09nubus_seq_write_rsrc_mem(m, &ent, pde->res_size);
>  =09} else {
> -=09=09unsigned int data =3D (unsigned int)pde_data->res_ptr;
> +=09=09unsigned int data =3D (unsigned int)pde->res_ptr;
> =20
>  =09=09seq_putc(m, data >> 16);
>  =09=09seq_putc(m, data >> 8);
> @@ -142,18 +142,18 @@ void nubus_proc_add_rsrc_mem(struct proc_dir_entry =
*procdir,
>  =09=09=09     unsigned int size)
>  {
>  =09char name[9];
> -=09struct nubus_proc_pde_data *pde_data;
> +=09struct nubus_proc_pde_data *pde;
> =20
>  =09if (!procdir)
>  =09=09return;
> =20
>  =09snprintf(name, sizeof(name), "%x", ent->type);
>  =09if (size)
> -=09=09pde_data =3D nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
> +=09=09pde =3D nubus_proc_alloc_pde_data(nubus_dirptr(ent), size);
>  =09else
> -=09=09pde_data =3D NULL;
> +=09=09pde =3D NULL;
>  =09proc_create_single_data(name, S_IFREG | 0444, procdir,
> -=09=09=09nubus_proc_rsrc_show, pde_data);
> +=09=09=09nubus_proc_rsrc_show, pde);
>  }
> =20
>  void nubus_proc_add_rsrc(struct proc_dir_entry *procdir,
>=20
---1463811774-775371871-1637877000=:31307--

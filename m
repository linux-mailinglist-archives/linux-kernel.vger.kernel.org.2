Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B03A38E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhFKAke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhFKAkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:40:33 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B7C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:38:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G1MQZ6SJ5z9sSs;
        Fri, 11 Jun 2021 10:38:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1623371913;
        bh=TsJGwEzSgIBwr1Y7JTzFw65t4hMoxf4Ivz9P28M+VRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hlYlvA9Di5+EcDY5bmD7E3Dw+Io8G872Siu3nayEOaKrq+9SfW4dEeGUOkJhNqj9v
         3F2m0/vBuV7p94RCbNEL4Kqktv1fkAr+brND3CvATsBZhPwqr6Ged0cFK9gPJ6dmhP
         CAj+Z3aPzvG23Owb7cuY0I3kU55qjvojt5miBZYxtRIhUGvWhd/syVvBqN5YKLcfnt
         T0/AWf3xzJAYfMS3Nogxuc3iWaB5jj+SlTxNBIuWiFOVcBpLWis+2Ft9pYQiGGp5B9
         2JdlFtsztsqDCiTE9kWLd1j5iaOf5E33q4PccdjvGS/Rb5RQ/jBOpdJbS1HsHY7kwN
         Qb56XqhG7S6xg==
Date:   Fri, 11 Jun 2021 10:38:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zi Yan <ziy@nvidia.com>, Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-ID: <20210611103827.4b78b776@canb.auug.org.au>
In-Reply-To: <20210610155940.7d0e1430fd15461d9dabb2d4@linux-foundation.org>
References: <20210603142220.10851-1-mgorman@techsingularity.net>
        <20210603142220.10851-3-mgorman@techsingularity.net>
        <88FCC7AA-FAAA-4B87-B382-50BD54B2886B@nvidia.com>
        <20210610111821.GY30378@techsingularity.net>
        <3B44DF44-5669-40B6-A122-011F1A749FAA@nvidia.com>
        <20210610155940.7d0e1430fd15461d9dabb2d4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DMw09q.dbvYPDytg4u4Zhp+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DMw09q.dbvYPDytg4u4Zhp+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 10 Jun 2021 15:59:40 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Thu, 10 Jun 2021 07:40:47 -0400 Zi Yan <ziy@nvidia.com> wrote:
>=20
> > >> The attached config has THP disabled. The VM cannot boot with THP en=
abled,
> > >> either.
> > >> =20
> > >
> > > There is not a lot of information to go on here. Can you confirm that=
 a
> > > revert of that specific patch from mmotm-2021-06-07-18-33 also boots?=
 It
> > > sounds like your console log is empty, does anything useful appear if
> > > you add "earlyprintk=3Dserial,ttyS0,115200" to the kernel command lin=
e? =20
> >=20
> > Sure. I can confirm that reverting the patch makes the VM boot.
> > The important information I forgot to mention is that after I remove
> > the NUMA setting in the QEMU, the VM can boot too. =20
>=20
> Thanks, I'll drop
> mm-page_alloc-allow-high-order-pages-to-be-stored-on-the-per-cpu-lists.pa=
tch
> for now.
>=20

Dropped from linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DMw09q.dbvYPDytg4u4Zhp+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmDCsIQACgkQAVBC80lX
0Gz4bAf+NvVnu/CqtKU8EKU51vyRUznpBSyExPiaDpjzKHhp2++47yldSN/DNALg
bQnlYFT60goZsg2UxCWSVFr3H5ClnCSsyhZT7RO5TQ+WHUcdeOWizvZM2p8DrE02
obbJUK4dCQ3kx6HhahPofABS5FkWqSQWH6PWSODbRyGaeX6bdZdMm2Rzw2ECrQF3
O2Z79D5j31ADPbYTBIkck6ffX9DOd1BsWR6NFO3kIpQex2fnDNaC1iVbaZ2LShAe
DrvCLDph80soRHFFggrx+6Byw3nI6RCLoPTv9lzRYdCB0GhLdxQk2KAn+VAckeIu
I4yaKLdLf29MfYd2p4TKx6Il53c2tw==
=i4Qe
-----END PGP SIGNATURE-----

--Sig_/DMw09q.dbvYPDytg4u4Zhp+--

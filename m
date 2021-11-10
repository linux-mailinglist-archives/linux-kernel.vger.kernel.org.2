Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7268B44BDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhKJJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:19:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45565 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230484AbhKJJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:19:50 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EDCAC5C01E3;
        Wed, 10 Nov 2021 04:16:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Nov 2021 04:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sSpGxH+Rw6W+BJgQbKAT0McUO0L
        1gdUtv1WBx7RCMo8=; b=FUZ14TAIIj5Ez9sbcMXVsRltIl9HdhGbzuUgkn4wIJL
        VTKC0rHZe0hX1HIHC7bwaOlwgaGCSJ+sOddA1UL1cEJWJyOT6KGRdzwDrF0LmOT7
        X4MkCa4WPuwaPP690DJyHoJpKA4S8x9JK9ImsG9sFQ2kzAGweDmxiKQGTEfsAIZC
        EZ04QwqBK14PdriZqNccNY/bOd3EZnw9HvXIekdpQtnd5BQF7QBC6MvaY2j/g3HX
        KXuJoRa4j0dOVKvAvOJPmulWgAYc6hXro5qAfVH4DvcQtEDH5+MGH+ODhVPnx+BC
        AJsDJrBnA/7nxh65wnlQXMxE8Cu31Kj4GUpK3uoYOGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sSpGxH
        +Rw6W+BJgQbKAT0McUO0L1gdUtv1WBx7RCMo8=; b=FWehnPjLwaHvY2OtBPRfsM
        vCZHK4SNEY+/kEz49LEMvpCJa7Yz54EeeUPjVeVyA34lVRmwmqpB5rbJ0azF3Yry
        9KXxuUnui86hrG5nuw+gYP9jfT2ZVFCjXh3gkhtM6vMEcG5CgGOXrZTFrxdnnPS3
        mD97cAqwBn65K13s06dNns048Mj3u+dKzbB9KmT3VqQOHtfCEHOZ5hXZYnjHkrRj
        ae4tOSoei2lSpn3OMVPs7Csv4HeFjuuJLcSnC9fMZ1bABeDxXhFqFul912qeiIzO
        n7KcS036SvCsQw2zyXDJEU1k5dR9qdsmcMbFoQEInv5pYrcOmh9X/cqLxAbNfpZg
        ==
X-ME-Sender: <xms:C46LYdq0tuPd5_k5eAjzNqG6R_s8NpsKVDZF2jG4Uv8YmRB_3uvwaw>
    <xme:C46LYfr4NCiL74_S7nv7orZckfE1E33KuxVs105bZzEIgLZH6Afu-p_6-hRtld6hb
    MBNFlIQbuwWiOIlT6E>
X-ME-Received: <xmr:C46LYaP2FgCdAHx1WspHmbroNJmtNtgEXQYN4Pnixl7hZUxcPAg0A0f_V6qMlcK5OFP90ol6UVcQztYLCsgOcdxqJaKZ9sHPZkQ2k0GpCpceIBwG3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
    lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
    hrnhepjeegudffueeiteekieelkedvueelteevjeduieeludfffeejgeffhfduvdduffek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
    esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:C46LYY7hhKidb5Y-HahI3EZc6oJp4SpWYaRxQ98oSvSxmlU_nxBYhQ>
    <xmx:C46LYc5hZXKd_zYtAF0u1qJxpwtzvOVx018PtYnR7cW_c_qis-FbQQ>
    <xmx:C46LYQhV2BkjiYOVlT2kPlHMLbWs33sjitGVHVwdtrwki6Ng8ByTmA>
    <xmx:C46LYba1FiMrBng0Ndyy0NsWgw5UY1Z6puXAUTipTyoEsggumjqbMQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 04:16:57 -0500 (EST)
Date:   Wed, 10 Nov 2021 10:16:55 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH] nvme: fix write zeroes pi
Message-ID: <YYuOB9VytsFiDox2@apples.localdomain>
References: <20211104181618.864157-1-its@irrelevant.dk>
 <db739cda-2dd7-015a-5ad9-d2d6e44131c6@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ye8ibXikhyU4UpIe"
Content-Disposition: inline
In-Reply-To: <db739cda-2dd7-015a-5ad9-d2d6e44131c6@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ye8ibXikhyU4UpIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 10 06:10, Chaitanya Kulkarni wrote:
> Klaus,
>=20
> On 11/4/2021 11:16 AM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Write Zeroes sets PRACT when block integrity is enabled (as it should),
> > but neglects to also set the reftag which is expected by reads. This
> > causes protection errors on reads.
> >=20
> > Fix this by setting the reftag for type 1 and 2 (for type 3, reads will
> > not check the reftag).
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Patch looks good to me but did you get a chance to test on
> multiple non-QEMU controllers ?
>=20

Hi Chaitanya,

No, I should of course have mentioned that, my apologies. I hit this on
QEMU, so just tested it with that. I didn't have a pi-capable device on
hand.

Feel free to leave this hanging until it can be tested with real
hardware, I think I can dig something up :) However, the spec is pretty
clear that the reftag must be set when using PRACT. It is, however,
kinda strange that the spec also says that PRCHK must be cleared to
zeroes - in my opinion, the device should check the reftag in type 1 and
2 if requested to do so.

A reason this doesnt bug out on real hardware is probably that the
blocks end up deallocated, which bypasses the pi check. However,
currently, in QEMU, if PRACT is set, QEMU will not deallocate the block
in write zeroes. Honestly, I'm not sure why it doesnt. I dont see any
reason for it to not request the QEMU block layer to deallocate... Yours
truly is the idiot that wrote it so I'll consider fixing that :)

The commit that introduced PRACT for write zeroes (commit aaeb7bb061be5
"nvme: set the PRACT bit when using Write Zeroes with T10 PI") also
mentions that without PRACT reads may have validation errors if the
write zeroes didnt deallocate, and QEMU is one of those devices.

--Ye8ibXikhyU4UpIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmGLjgYACgkQTeGvMW1P
DemRCAgAhY6rLFxCImjQJF4u0l7EQP2gO0+MNOkHKPjljy54QzBOMaOEErk9ycdp
Bx/km3rIt9hMY7AlrdcTAkO6EivAjdke0muHlDqovvxKTEs3Fp7GGPzvGcaL+n/O
H/fEtjYXv2I0VhhR29bi8h9hQFsU4QFCpvof2lT1Tftym3Xix4NPPOS5bO+JhWJb
2DBoW/0L2Nougm2QKaGhAhmHeGHJGAL486P1Bv9m/XmsVmuV/jcoAQd613+yK/NC
2/PgFXqTeWFDwpR1o8yd9Gq768cW76jz4ptgl4NCc3tvfzlKpHMH00frmSBZef/p
Om0gu1ilaHyAaNj4UwhR9qbQI1Q01A==
=EaqI
-----END PGP SIGNATURE-----

--Ye8ibXikhyU4UpIe--

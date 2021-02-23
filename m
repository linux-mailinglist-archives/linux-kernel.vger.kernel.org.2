Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24DC322CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhBWO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:56:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:33382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhBWO4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:56:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F6D1AFCE;
        Tue, 23 Feb 2021 14:55:30 +0000 (UTC)
Message-ID: <2fff7c82d983baccb91c4a1c0891a9b6cdc50dd6.camel@suse.de>
Subject: Re: [PATCH -next] nvmem: Fix return value check in rmem_read()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 23 Feb 2021 15:55:29 +0100
In-Reply-To: <20210223142214.3405217-1-weiyongjun1@huawei.com>
References: <20210223142214.3405217-1-weiyongjun1@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+ZOTHRWo0mdmPr2PAEim"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+ZOTHRWo0mdmPr2PAEim
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-02-23 at 14:22 +0000, Wei Yongjun wrote:
> In case of error, the function memremap() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
>=20
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvme=
m")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!



--=-+ZOTHRWo0mdmPr2PAEim
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA1F2EACgkQlfZmHno8
x/5q2QgAntr7DrAtYlhZ2GumimEwN+L4edjp9P+ocKfuMbUP+RhvDb/ha1RpI6JB
IvbVD/GkhL7KmyQ8MWBk7tQ1uTSgl7VggqGcXQvkmKVHW2OEwa+NpGNAQDxJUajw
YAG99GooA3aQxSY3FN9vvbb0xiFNZyufgIORGj7VovkrQSP49EQlgfxs5paU/leA
YieP200H0k//7o/9Twl+x3BWNeurfxKyDGLuMzsHPXPxKYVdTxgCKaC/Z8FknwwY
HFYy2Bmm4VAVXY2zcPXB5cSYdjU/rFWChXBhV9X4h2Y51o70paB5kx3Djv+KoJeF
97fxxJO19HGmLpT9UgqMR5vFYMEFnA==
=RjAZ
-----END PGP SIGNATURE-----

--=-+ZOTHRWo0mdmPr2PAEim--


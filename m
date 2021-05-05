Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C0374998
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhEEUqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:46:22 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55402 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhEEUqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:46:21 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0E9A41C0B87; Wed,  5 May 2021 22:45:23 +0200 (CEST)
Date:   Wed, 5 May 2021 22:45:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jianxiong Gao <jxgao@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Yet another way to mark upstream commits was Re: [PATCH 5.10 13/29]
 swiotlb: add a IO_TLB_SIZE define
Message-ID: <20210505204522.GA3061@amd>
References: <20210505112326.195493232@linuxfoundation.org>
 <20210505112326.635285720@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20210505112326.635285720@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jianxiong Gao <jxgao@google.com>
>=20
> commit: b5d7ccb7aac3895c2138fe0980a109116ce15eff

This is 5th variant of marking upstream commits, and I need to update
my scripts again.

Could we please put this into Signed-off area, where it belongs, so it
is easy to see who touched the patch for mainline, and stop this
creativity?

> Add a new IO_TLB_SIZE define instead open coding it using
> IO_TLB_SHIFT all over.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jianxiong Gao <jxgao@google.com>
> Tested-by: Jianxiong Gao <jxgao@google.com>
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

I'd like to see

Upstream: b5d7ccb7aac3895c2138fe0980a109116ce15eff

here. Probably. Note that it has additional advantage that you can
easily marked who Acked/Tested the patch for mainline, and who tested
it in the stable context.

> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCTA+IACgkQMOfwapXb+vIyegCaAyDNebEFnDhFRikmTxeuWxIL
tuUAoMBzNUEIigELl1VV1YrogOBZ395t
=QNb3
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

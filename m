Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC41834E97A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhC3Nno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:43:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34380 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhC3Nn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:43:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 64A351C0B7F; Tue, 30 Mar 2021 15:43:23 +0200 (CEST)
Date:   Tue, 30 Mar 2021 15:43:23 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hao Fang <fanghao11@huawei.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
Message-ID: <20210330134323.GA3700@duo.ucw.cz>
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
 <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
> >
> > s/Hisilicon/HiSilicon/g.
> > It should use capital S, according to
> > https://www.hisilicon.com/en/terms-of-use.
> >
> > Signed-off-by: Hao Fang <fanghao11@huawei.com>

> >  /*
> >   * Copyright (c) 2013 Linaro Ltd.
> > - * Copyright (c) 2013 Hisilicon Limited.
> > + * Copyright (c) 2013 HiSilicon Limited.
>=20
> This change looks really silly to me, but I am not a lawyer - so I
> can't tell if this makes sense or not.
>=20
> In any case, "Hisilicon" is being used all over the kernel - do you
> intend to patch all places with similar changes like this one? Perhaps
> just send a big tree-wide-patch instead and see what people think?

Plus, I'd expect authors to submit changes to copyright notices.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYGMq+wAKCRAw5/Bqldv6
8rYZAKCFJ2HU/daNZlq3Bw53OOssGEwL1wCgwJwZnDGPVaWOKTz5RDZsBYc7tdc=
=4T3Q
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

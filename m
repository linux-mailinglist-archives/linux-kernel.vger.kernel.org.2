Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C535240D8E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbhIPLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237325AbhIPLgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:36:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BD4461248;
        Thu, 16 Sep 2021 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631792127;
        bh=MFMiWiLbSsHBNdgxwGgQNq9D4t09z7wHqQ4/u55g5x4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EH90IBenRfIn5PoWk2oUHjN7lRmSzeCv7bQw1cSOMwPJ7U8EBfkrQwmpOXxBISEBu
         YphqgzSitGGeWEleX0obAKjnRQ5zS0yhrMsCsimCXJi2cV7B79Sfmuy6TP/mTVSszz
         N+8QWuppsbyWGYIM/OGB4c23oUoO4g5Z+JQzO7TdBTRy1PFDKuyqS7/g7P+VecMVAs
         34S6bIrW82gO4zfGG1x33bvhOrjxafr4zryTYOVVo2xLpNaQGDSMjRDjfDjFPb/mSZ
         +7f5npNdtBDHmoPNDkjthgQuu+cVdklRznp3smgceffhusgAnvo+m9pdK9t2fAfjEn
         Pt7ft/PtjQZuQ==
Date:   Thu, 16 Sep 2021 12:34:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/23] MAINTAINERS: update silergy,sy8106a.yaml
 reference
Message-ID: <20210916113445.GD5048@sirena.org.uk>
References: <cover.1631785820.git.mchehab+huawei@kernel.org>
 <d8a40e9523405be1c05d265589270e298ff42ae4.1631785820.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <d8a40e9523405be1c05d265589270e298ff42ae4.1631785820.git.mchehab+huawei@kernel.org>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021 at 11:55:20AM +0200, Mauro Carvalho Chehab wrote:
> Changeset b1c36aae51c9 ("regulator: Convert SY8106A binding to a schema")
> renamed: Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
> to: Documentation/devicetree/bindings/regulator/silergy,sy8106a.yaml.
>=20
> Update its cross-reference accordingly.

Again, what's the story with the rest of the series?

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFDK9UACgkQJNaLcl1U
h9BRtgf7BvY3SrdVlj/I58cdUy9qAC62yF2wMuSoG7QuA1L/uJniIGAZLMLEJhwq
SM9ydKDH1YLLJXh1NgQzYoy1rdaD/77+Sazv/oLUW39y7AAQNtUsF2HpoN8F9v0X
7UUsXAbrJL2MZScuufti9WGpsdtFIAydFgPp4b2gbn8qZk0T00DAOWmUIgK65b2Y
KKYbzIF6P8zFJfDjP4dCn0tXYnKrwRCbKixOLmH0UMvb4d2NsZwK8ySJZBQ8f/0b
3r21hdcB1F1sS6sK3TvAMuRgo4JX4SFxVZGKUtKf8Ko87n3REP83PmlokuwnA+sW
4T0DnbJVk03S54p4DUJNIY4j7Yc0uw==
=uFvn
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--

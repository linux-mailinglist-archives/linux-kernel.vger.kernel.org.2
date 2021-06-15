Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D6F3A8613
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFOQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOQKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:10:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2B3A61476;
        Tue, 15 Jun 2021 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623773292;
        bh=nrtDm/ulOUX2K+o4UwIqzPS8pTMb/7uPqGmY0tBnOQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S39MP5e1NbTTIabrgyXArZlHHcKSjAVR+B+pwDWX118HBOjexdXeRJJkVptNAZ8UY
         k/CPivHJLuasJw9j4DDFuezpDKJ+LN22QQgHQVn7ISsxJIOjkoyfPSMC1hfTENjmd2
         CfEG5A+ZSFeo3WRG2Tf+FRGidI33hfSy5ytvoCnsx//ysMFKeYJFSOaSUbdKLiSfmF
         TreyqSr8QWgQndG0sPtu0vSzCfNWNs0la/wlAfqDMY0J96Or4qFfWdMVVASeAOk83I
         q45kI4dl7LNC7LIItu3f8lMPrQMoJvAjxVqjRxzSDuDHgSoVTNQhO3pJizIhE2POpF
         az3ccT7O774FA==
Date:   Tue, 15 Jun 2021 17:07:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: rt6160: Remove vsel_active_low from struct
 rt6160_priv
Message-ID: <20210615160753.GO5149@sirena.org.uk>
References: <20210615103947.3387994-1-axel.lin@ingics.com>
 <162376572819.36399.17993990572863185568.b4-ty@kernel.org>
 <1623770667.4571.4.camel@richtek.com>
 <20210615153424.GJ5149@sirena.org.uk>
 <1623773096.4571.13.camel@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline
In-Reply-To: <1623773096.4571.13.camel@richtek.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2021 at 04:04:57PM +0000, cy_huang(=E9=BB=83=E5=95=9F=E5=8E=
=9F) wrote:
> Hi, Mark:
>=20
> OK. Later I'll send one to fix it.
> But based on regulator-next branch?

Yes, please.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDI0FgACgkQJNaLcl1U
h9D4bwf/QTo4DVkD/u9xGsaYMFsxb3ocAR8ti4+maJ1vhi/zqGDn+hB5We8prmDc
DKJzBh3JnJs5cewhIyHIpuXskSBlVdaMI9TOtODVe8FqtyALoTvWC33hZerGCU1K
BbylYODLtu8f2udcZ1ghpeV/hDpZ5aqUI4RL5Uq2VsHe9F5w0g2lJDpVLU42cbs3
M/blsTC1fGdI35DhzCb2ivTe9JuNHsMXx25XRqPraVi9m7wbDq9gxkTMPxGkVr4V
0K+/ONBIt9kqpIrHK9Ga4YWIvKRHPeXBioUPts+UQ/oT4WYTNIxpKVQs2bEVffb0
+k3QPyFQmT9N2if+io87PJLqDQ0+Gg==
=gXVd
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--

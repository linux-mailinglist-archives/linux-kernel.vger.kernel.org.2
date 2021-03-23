Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6C346689
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCWRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhCWRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D029F600EF;
        Tue, 23 Mar 2021 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616521082;
        bh=F8W4NhZSrISx6ND4EZ52T2q3feCQu7g+dSt4VWdnFkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/MhSNCq6nEFI3xMlKc6ZhM5SMX3gycIH9MsrTdNYKOZaMsOqzMGTJtWHDd4NaqRm
         sJeq8HkIinumdgBwWi+U4ku3DJAuJi/IHMWieUYW7Yb7FUsJ9FRgNx5Xjlp2Rj1cJv
         SCWJDKPBjRWCWpsKLzp+QX7mLZjPatrRqI4FJhmMBS+65iJ+35805rfiHsfmdEwJMc
         EY33fvIAa6yQfD11WXIwkzbnX15/9X/sahR+f6ig78AR8f7XO2GWrh7J52LVDiDPgF
         ePQ9bvkJx5Kwkuv277lKSw0OBtbybM2VQ8bxTqPTPYPRPXhpXCdp9fZX+pl01vbYTG
         6/QMW10xrfQPw==
Date:   Tue, 23 Mar 2021 17:37:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] regulator: qcom_spmi-regulator: Clean-up by using
 managed work init
Message-ID: <20210323173755.GC5490@sirena.org.uk>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <3bd35bb43257f4bf5b99f75d207ed5e1e08d1d38.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <3bd35bb43257f4bf5b99f75d207ed5e1e08d1d38.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: Formatted to fit your screen.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 23, 2021 at 03:58:11PM +0200, Matti Vaittinen wrote:
> Few drivers implement remove call-back only for ensuring a delayed
> work gets cancelled prior driver removal. Clean-up these by switching
> to use devm_delayed_work_autocancel() instead.

Acked-by: Mark Brown <broonie@kernel.org>

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBaJ3IACgkQJNaLcl1U
h9AsRQf+MwBWHCDMYU8mOBhM4L4uPfYY11l3mKT/pDWxZRI6lbivQivpbwflLTPr
oj/gA4mh5shj9T5M+fIx6dj3EvTG55a+KMEFXzkLnF0FIu1uLxDeTbICztP3CSLy
SJ72Ho2MjUBS9c2lHllkMrXqpciu7ORQ7g/rAdCC34yLOy+zXx6kEtd3OM/B6DeV
TvJhTRmvoeq9KvGS99dMMwsiDp5WO6OA+n6NGfHthiP9D186MJxrXC04VAEZEdJ0
4Lqgsjtx6frKSo/ZmQydf/Is5L0LjxZ/IjdZBQ1pVKsuGkBX6k+w6rxUuEGuXeWJ
rFz90+X6SEH7Nz6X/cwPjvqPcpj1yA==
=0pAj
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--

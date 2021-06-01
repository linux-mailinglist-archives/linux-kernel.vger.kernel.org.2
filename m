Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F208439773B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhFAPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:54:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234495AbhFAPyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:54:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BE3861396;
        Tue,  1 Jun 2021 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622562769;
        bh=aGdPf/JG2Ma5dBKju6woR09ogotgTp0UyCyCSzPN8E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vFmm4EuDgRez/N9yYR8a2d8GUezxEqiMSMBcLzq6HqBUE9zJLj6qL2dkHJZDPH8op
         iX1CqyIZdIMGpNoMJTIQcrkoOPYDGcPRizuPOtMu++Mpn3MXa7CrkR+xTl0SizVkxU
         vcY6KQYQK60IB4VYju/UO9J5u2YSUpE5eGtiUe/2X99jCl7DPrE7zmeZwH7xYGB08Y
         ATdnAOyRj0KSZSx3/W8vzdstQHOvZ/6t2RrP+qoC6yeHZl1IWU6uCqi65sHaC+ae/d
         ePaRWGOdqnfOrax69HoqQoU0WFH6K/UvnadhleC25UuxBaWYwIZ//PDxH7sk13RtRc
         u7POCe7b6WHgw==
Date:   Tue, 1 Jun 2021 16:52:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] regulator: rt6160: Add support for Richtek RT6160
Message-ID: <20210601155239.GD4089@sirena.org.uk>
References: <1622008068-13474-1-git-send-email-u0084500@gmail.com>
 <1622008068-13474-2-git-send-email-u0084500@gmail.com>
 <YK4oGB5cZ/DhG5vm@sirena.org.uk>
 <CADiBU393NchfrTmgPApNRqSVrTBGT+bs+H+m2UF_H3tSGLyFVQ@mail.gmail.com>
 <CADiBU3-LjetAkzks4MZKiK=KXK5ziFhF9D13cAjJ4W5gytw74A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <CADiBU3-LjetAkzks4MZKiK=KXK5ziFhF9D13cAjJ4W5gytw74A@mail.gmail.com>
X-Cookie: Sic Transit Gloria Thursdi.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 27, 2021 at 11:14:17AM +0800, ChiYuan Huang wrote:

> I review the regulator_set_ramp_delay_regmap API.
> If seems I need to fill in the ramp_delay_table by the descend order.
> But this chip ramp delay table is designed the ascending value reg bit
> field [0 1 2 3] by
> the ascending order [1000 2500 5000 10000] uV/uS
> Even if I tried to filler in descending order, I also need a inverted operation.

I see... that really should be supportable, and I'd have expected
find_closest_bigger() to DTRT here, it's not obvious it's expecting
ordering.

> And I found the regulator_set_ramp_delay_regmap API has some logic error.
> From the include/linux/regulator/driver.h, the set_ramp_delay function says to
> set the less or equal one ramp delay value.
> But your logic will get the larger or equal one from the descending
> ramp delay table.

The code is correct here, the documentation should be fixed - with a
delay like this we should be erring on the side of delaying too long to
be safe.

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC2V8YACgkQJNaLcl1U
h9CTrgf6ArqSe4D42r70JaahR7KYaMW6G6x9fIdM279DEUiisu2lF4pby14hFG9v
xze19BNI8C7w7ziMCd3Q4gOF2h8jLljHv8tubSalY3W89MCX6AhfBfKzoc7aSWat
lxjjLfCMWV6u5CJhPvSS8L2XMawDG6WkA98Kuvde52YGTxRnieHeJbLaHdIs3fr9
c2uHJRSRFvEkVhkhikwi4OhtFHoRjZVRlnTn03n1gqSc9d9gfZSOATutUZxQnvoe
6eneLvfQJwpX1UjhvJ1JPox28cXqzPwWgxKfBBoAd3hRSRwZSNMhwto9VsJ7TrRZ
9r1fBvnARN+gMU2hPNeHwQT6zO5p7A==
=1NtJ
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--

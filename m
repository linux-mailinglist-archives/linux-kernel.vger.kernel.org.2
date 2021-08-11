Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC3B3E8FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhHKL5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236607AbhHKL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF27D60E93;
        Wed, 11 Aug 2021 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628683016;
        bh=x6GpUTuyq1LGQnUrhcBnUA32Z1gHDW6QU3OP9zxLmrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbsZr2aHkFyDggkWVCAxMFQoJ0H/YdqGxFz8hLuNqG40BmJ8ePLhoy05XuYRnQlsW
         m15bbt3BzujEC4tXt6uWPf5ru66opPYSt9UA39ss95l80enILnnNQ66GU5n9e18svh
         71b29xnyS38hQJFW/l6bAY2Qbir7gIXT/w7oD0Z2JA7d7fK3v9MPWGaqjR3omW9W7f
         OOEvAmNrNX4uGNjPu94TZnhrCqjnXjirBop+XVUNH6YkDQMaYxzK2VK75DxoLAvCgB
         qJnVmPpiCOr1oBxvqDDOX5VBoy4H23fNzB/wOLjUWDi6uksjD4arvQ3sjV1dECWfbW
         a4gQ9O0LsTT8g==
Date:   Wed, 11 Aug 2021 12:56:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] ASoC: cs42l42: Don't reconfigure the PLL while it
 is running
Message-ID: <20210811115637.GA4167@sirena.org.uk>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
 <20210810153759.24333-5-rf@opensource.cirrus.com>
 <20210810154959.GD4704@sirena.org.uk>
 <c194004a-2a22-5354-9042-3ce811236319@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <c194004a-2a22-5354-9042-3ce811236319@opensource.cirrus.com>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 10, 2021 at 05:27:45PM +0100, Richard Fitzgerald wrote:
> On 10/08/2021 16:49, Mark Brown wrote:

> > Shouldn't the PLL code be noticing problematic attempts to reconfigure
> > the PLL while it's active rather than the individual callers?

> It's wrong for a hw_params() for one stream to try to configure the PLL
> when the other stream has already called hw_params(), configured the PLL
> and started it. E.g. if you started a PLAYBACK, configured and
> started everything, then got another hw_params() for the CAPTURE.

> cs42l42_pll_config() could check whether it is already running and skip
> configuration in that case, but that seems to me a rather opaque
> implementation. In my opinion this doesn't really fall into the case of
> ignoring-bad-stuff-to-be-helpful (like free() accepting a NULL).

This doesn't treat the situation as an error though, it just ignores it,
and there's nothing to stop _pll_config() generating a warning if that
makes sense.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmETuvQACgkQJNaLcl1U
h9C7vwf/bk/AHt269vqKFlZ433279l7SHMz5PTCd2YccnwCotrFWmbrqCERd7d8t
lCOOnpLPu1iUoQbEj5ES+tPD28v+oHrTnGDapFXnHqKpNRURwubqH3KcI09eTVNp
+hAEVYE0EXS3Q8yYIZVDIGrWX8hcAAHNeANj+mpCcZayyKRcYEGWQIFBJ96q3L5/
5XOvRetZGTePrMOlUYH162rUJZddP0ODxg2wMKLL+XxJwaG/7fxMqfJXKlwcqaYQ
8seroVXuCzOv4HlTJTlU45/dLc6McEmMWxKqnw86Hb6AUSIgQEJMlHywyFcTlyCx
q1P85hj5vCjKMqnTlcEXxO7/kDFRow==
=PgIx
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

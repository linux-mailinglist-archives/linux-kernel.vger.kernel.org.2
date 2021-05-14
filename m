Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA00B380D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhENPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhENPhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:37:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E485613B5;
        Fri, 14 May 2021 15:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621006550;
        bh=7hJnLrXNCqOXZB+3JhB19cjM5AdIfIeZHV8EI43YPI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcbiwc2J9SQNxA0TGHaJebyhzp3bnJe5dlgfqPH5PhyRY99qdxQIRt9NKBpqvluhF
         Uy0vjxHLmaztUPiqClIC8DphyWpXZy50BmNs39gGVJBDqMuR/iWcO5Tbf3nc7zgQvB
         2HC2G9loF/5tkXB3SqWicrNH+JoDL8jklPcZlpQkQ+KeEeSfGQeWSZSixDOLVCJoVp
         Nua4Oj9sdFXU3lNVCHAAHkXl+x5JG+AYA3pWLtyl2TszpUvEviLFiVZEX1prLjSNBt
         rIuNTq/mtv9k+xYENGXf3FeEbmKJfoVM16SGFCkDh6VMgoS3XZ6j933Va7TMRvBT6Q
         uJDCJb5FMgGeg==
Date:   Fri, 14 May 2021 16:35:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] regulator: fan53555: Fix off-by-one for
 TCS4525_NVOLTAGES
Message-ID: <20210514153509.GA51845@sirena.org.uk>
References: <20210427134529.818784-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20210427134529.818784-1-axel.lin@ingics.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 27, 2021 at 09:45:29PM +0800, Axel Lin wrote:
> While at it, also remove unused TCS_VSEL_NSEL_MASK.

This needs rebasing against current code, I'm not sure if the issue
still applies though.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCemK0ACgkQJNaLcl1U
h9ArQgf+Lax62YwnTsKmX6DTZ7+eD4PO85EengUhUAkl2W208HOwBZJZv1OtqQ9x
rpRyQILkqdUZsbCsenVJP8ItNkKloy+yoaCVMv2gKYPB8Dr57Ziitglf6iUFWJzu
W2t7lnDAd1DS0ZoHQ/zAYjStR19YZHNE3o7XnyXH0ud4wDmdpBSbJoDDvIHqazuf
pCrvXZG78WaOGX9gQ5wIE3MCItZ7LW5z01T8gpYCvTyugvLIrGaV0O7ZUr9RhUyH
1JmPk6i7Ymd1c6+a5p0PNzqXDOZwhnbVaFkbIc755+wn68XJt5rpkijRZPeoNIT4
W0nI42BNHwaPeFYTAgVJ2LBcE/HJyQ==
=L6Ex
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

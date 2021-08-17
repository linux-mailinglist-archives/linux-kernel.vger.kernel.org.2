Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD93EEEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbhHQOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237768AbhHQOhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:37:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB1F960EFE;
        Tue, 17 Aug 2021 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629210995;
        bh=mPCzu0e9q4q9qvg75V/xfVFPNu0IiOfphiyVwG9+mHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbO+KE7v6Hhr1hO0l2XB1e5iGxLOkk2/xGarlZl+PlVsP9232QlYAYjp/Vl2zjzM/
         ABMv55Ry6Hi0+oGKb/v0uXyhyN8/S/lzvQV5AdNzstoIxoDPCMNWy9rXq/LyAuhFhR
         H2A6NfJc8aRLgDwMZ0QcNLmNFN1UGR27nXC/LOoaKssdyv0ksZ2+1eEUJloB6jw9ZM
         wqF1RQvPdbaMZfjV7AFk+r8gRaYBgmp1nW9qPPzN7jPDIUhDX/3HviK7j27Z5iXvOF
         36iVGvITbz2QOmaw57Sa1t9cDKrUBzS5Bb61xX/AAVfcZTSArPkORdPq9A2lqvPjxG
         4RCORITGsM+ag==
Date:   Tue, 17 Aug 2021 15:36:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     lgirdwood@gmail.com, ulf.hansson@linaro.org, lee.jones@linaro.org,
        zhangchangzhong@huawei.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] soc: rockchip: io-domain: do more thing about
 regulator notify
Message-ID: <20210817143612.GB4290@sirena.org.uk>
References: <20210817033848.1396749-1-jay.xu@rock-chips.com>
 <20210817033848.1396749-4-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20210817033848.1396749-4-jay.xu@rock-chips.com>
X-Cookie: Custer committed Siouxicide.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 17, 2021 at 11:38:48AM +0800, Jianqun Xu wrote:

> +	} else if (event & REGULATOR_EVENT_ENABLE) {
> +		uV = regulator_get_voltage(supply->reg);
>  	} else {

I am very surprised this doesn't cause locking issues given that we
might call notifiers with the regulator API's locks held.  Have you
tested this with lockdep on?

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEbyVsACgkQJNaLcl1U
h9C7kQf/WvUxRsG7vyHPDAemRhQZrWNrsF6EfO3vzSfm14zPt8akTymLyEqjX0V2
qFvaGqTQRB9yM4M2akgoYNipieBTfBlqYaDsvFupJ5XmQ61T733R+LI34DytIsp1
RKkT6ZDZNG8FZkgbMZGhWUwFhjnVrvjAt7Q5eUkj9/BtoQLek4w7CUVOc03dFCmf
qUzxxrFz0OZGOweq5KjkCNBuQMcSXMAHKQGK3BKTzHv8KCNFFXO4dssFUM0CEAw1
hSekoRR6HnIyP9mMAGRtu3tp7VWQng4NWjrFOUJj2fy3b733uzsdmsNiCgC1ekKB
sMTfNZFkUWCFaW4+Bh6QPZ2CFApTdA==
=PMmT
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--

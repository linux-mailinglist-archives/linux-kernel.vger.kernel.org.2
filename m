Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86E4119BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhITQZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhITQZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:25:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26F761163;
        Mon, 20 Sep 2021 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632155053;
        bh=aVOL2cZujNDAzDgTzdr4Fi1p8QS8fATKU3ExPt2/6MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7ARMoG+WRmwz8JPqbgHPm9uw/kdc41X45gHmlK+C6qOY5Mzymx/Z17vq2on4Vza8
         khfWzIWTVOLiNzNLYqEuwM5ke+/q6vT/ViOwtDSEmwguh+6NaN9xozV5Hv6awn2Di7
         9aGpUxNMtCY7982KCPm9vhzJKVBgyZYTu61fq/PldDSrcBShU7Yku5MWxGAcZ/b/vD
         Nv4hNBBUZ74FSw69slAbnc8EKxDcG9/EPUdaugewoowevgxYCirC3X+9vOQdT8iF9p
         0V473T1aKYZQfvRUWTCVaEv8AixiWMfakViXVbpUofJmZ8bQq/+iOGNX1YOfaI1VMp
         4FDRdt/WGGKDw==
Date:   Mon, 20 Sep 2021 17:23:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laura Abbott <laura@labbott.name>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Hansen <dave@sr71.net>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>, ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Tech-board-discuss] IMPORTANT: CIVS opt-in for Technical
 Advisory Board voting
Message-ID: <20210920162329.GJ4192@sirena.org.uk>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
 <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
 <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
 <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QDIl5R72YNOeCxaP"
Content-Disposition: inline
In-Reply-To: <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QDIl5R72YNOeCxaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 12:18:09PM -0400, Laura Abbott wrote:

> Yes that is correct. We attempted to consolidate e-mail addresses if you
> contribute under multiple ones. This is a pain point we will need to fix
> next year.

Will we be getting some futher mail when we should vote?  I opted in but
didn't vote at that time - I saw the vote was listed but didn't realise
that voting was open since people still seemed to be nominating.

--QDIl5R72YNOeCxaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFItYAACgkQJNaLcl1U
h9DyCAf+JtZbHZD0kdzFUE1/+HGw6nZyKYjxX6TVIbAIdWUGIM5znLb2iKnsWymK
z5JChpRKw3jS699NaAku6tLdifV2sMXfWzB8w4SmUtMBuN7OnXHfwbA8/KyNT9Qo
OkoVvVXfv4FJ5JY5n9teeoF8Bo0g0OKDmyIbTsz7EICp3+mYxIsfCS/CKgp1M+cL
GOacceSe7fWHXlPM4+3NiA92f2L3oyCOGNOXtC9V6zzUaoWJ8xR791Z3bsvaDG+y
xcy2+ioUgf4v7EPLPWUTet1zHSKqnHY9VkWKV7o6JUMDPW4bVAeS/c7inz7Zj1jY
Msoa2/ox1vU6/v2Qj6IWEaZL0kg7Vg==
=xP/I
-----END PGP SIGNATURE-----

--QDIl5R72YNOeCxaP--

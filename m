Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F08411D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbhITRPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347357AbhITRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:13:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37BDC6138E;
        Mon, 20 Sep 2021 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632157080;
        bh=hgdusSh4N2LuDAVQwJA8YQ+ZnZnLuDk5XHhcA4K15uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AcvAZ+y4rfPDf80KkUOFZ4G0AJcFjk/15I23Xx8DggFNlztZ/zpyuLlLiWh34nlCC
         DOcrV5NFPVj7eaJLyZjjIR1pWw5BuaJiXLhLLm2M1I/smr/IRUTuJxdz2DeBxCyS0E
         K7j9H5bP7mFMTPJIXC/wp3p+QdIAAJFdxmljoxhvqH6GV9hymtfhIMFCP/ozbLe0qD
         /ygysY8Zv0P5fgiA9JQM2mPAnhfxBXlYC9/xkvUFYlmNs+HDPM8J03YlcDszFgexgF
         40IyiOqgXXq6eXaKH6/pt/Bajma1/xfvp9Z8Sfwicd6oalBnkK8uxs1owJpWpQoUlT
         CnfXBtcgu9r6Q==
Date:   Mon, 20 Sep 2021 17:57:16 +0100
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
Message-ID: <20210920165716.GL4192@sirena.org.uk>
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
 <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
 <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
 <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name>
 <20210920162329.GJ4192@sirena.org.uk>
 <5c88ae67-df7b-60ab-d087-bd244753c98f@labbott.name>
 <20210920164837.GK4192@sirena.org.uk>
 <ebcaac1d-9b97-81d9-28eb-eeb51c51673f@labbott.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Content-Disposition: inline
In-Reply-To: <ebcaac1d-9b97-81d9-28eb-eeb51c51673f@labbott.name>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 12:53:48PM -0400, Laura Abbott wrote:
> On 9/20/21 12:48, Mark Brown wrote:

> > How can I do this?  As (IIRC) Geert reported if you've activated your
> > mail then attempting to activate again causes CIVS to report "This email
> > address is already activated" with no link to any existing polls.

> CIVS said it should give a list of all polls but perhaps that didn't
> happen. I'll see if I can get it to resend.

It gives a list of all polls on activation but it seems like it doesn't
get that far on reactivations, it looks like it's generating an error
refusing to activate again before it gets that far.

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIvWwACgkQJNaLcl1U
h9AToAf/bx+6RKSo3Sz88lrKcm7OzuDCd8KEIK2TbrDoaPFJ8hdMUbmswcb0Q5w0
0JElkbS2vViVNlKpUEGl4UMPbthV9zI9J1QcpFLoHt6cbQsDAGJ7IYdccq2WWqyo
sCFKmTeUbm23/lrnmijQAT6rldIH4KUKwqbsK8X8Zk4z6fanbJ/6a8ZIlXre1bk3
icUVAn2aotDxTP5JQzSpF+1n3b0T1cHsuVG86+V9Kb+B5CQjbCyXnLL0D8dqMmJU
eqd6I0najrcRq+S+SzREdD8FlbwgrpBm6IhkclIn2pOxI4oWtQYvlaWlVTUjdjHp
OHPHXHfnz41e8zc1fED6HR3e1oezRQ==
=yX0Z
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9D3FF210
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbhIBRHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346501AbhIBRHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B97C761054;
        Thu,  2 Sep 2021 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630602405;
        bh=Xbw/qWyyLJxlhUSuR+vFLrxCpyznW1udr6aBUz1rfCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eCazicTNYhpyuHF2dJDD5tvBCUlimShv7UbTGim9yQNX+gt0rtTs8iLVuPAsLe9iO
         Ih/PFau49JlXpW4mS4fPkiekPiNGaylUUUGDGARt3u8RAl3arenKWykUyfnMY91cb9
         tfwe6/POuUv3dknb1TtPeo0DX8HT5fuXXElsRiAmb11SINyMgxTFmexbXfq8IWSgK1
         hnRjqGQJEb1rhl+aSZTuPCUcY/4cGFJCKDxx9ajZwUY0MYAkc1FE+7a+bmVTs0iztB
         nDDxfeSkes1Cu3UekKvP7NBJrtf8f3XJH2kkD6F3AmzhGQs+6lCgXkJWjOzDctLG5Z
         TgrMJEwnaz8/g==
Date:   Thu, 2 Sep 2021 18:06:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
Message-ID: <20210902170613.GG11164@sirena.org.uk>
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk>
 <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
X-Cookie: Famous last words:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 01, 2021 at 01:06:28PM -0700, Brian Norris wrote:
> On Wed, Sep 1, 2021 at 8:09 AM Mark Brown <broonie@kernel.org> wrote:

> > This doesn't make sense to me.  Why are we getting as far as trying to
> > read the voltage if we've been told to defer probe?  This suggests that
> > we ought to be doing this earlier on.  I see that the logic is already
> > there to handle a deferral being generated here but it looks off.

> Take a look at the commit this "Fixes":

> 21e39809fd7c ("regulator: vctrl: Avoid lockdep warning in enable/disable ops")

That driver change is at most tangentially related to the code that's
being updated, this is a prime example of just randomly shoving Fixes
lines onto things :( .  It's perfectly fine to send patches without a
Fixes line, adding them when they're not really related at best creates
noise and at worst causes problems with backporting (especially given
the whole pulling random commits into stable thing we have these days).

> Frankly, I'm not sure if we're abusing regulator framework features
> (particularly, around use of ->supply) in commit 21e39809fd7c, or if
> this is just a lacking area in the framework. I'm interested in
> whether you have thoughts on doing this Better(TM).

That's definitely an abuse of the API, the hardware design is pretty
much a gross hack anywhere as far as I remember.  As Chen-Yu says I'd
only expect this to be possible in the case where the supply is in
bypass mode and hasn't got its own parent.  In any case I can see why
it's happening now...

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmExBIQACgkQJNaLcl1U
h9AjJwf+NMa+muPsPs5NxLPOL+tGoNKy1FHjFGLSK6n1OF9MHdlfdKOyL+F08/8u
kvLtvhBU8nR43RcP1e73FNJvJvo+neJfz3zx/xbHHIfyo6a299FYNGeoNwXrvLGF
VKKDfnpaayngu0zbi+8Hqe57hezP07KFPesKGNx/awhIVR8fJwxQMf5pAAZxvJK1
cBN1IpEvFPTDvyc+0aNtbdrOvcXE2R99/N7jBOaEn4rxwoJkwjRVZ6BDUI8+6wNn
+5vz38C6hscEEzcvVGNRGr1EMakNb7vsglhhXATttLf6Jul8o+HkWlydn9Rd0O4g
Pkfg9lGA39Qms/3JAJI5AfEwDcCIKA==
=CynK
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--

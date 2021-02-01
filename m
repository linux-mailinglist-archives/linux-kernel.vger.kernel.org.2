Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE75C30A888
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhBANUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhBANS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:18:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C2E364E7A;
        Mon,  1 Feb 2021 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612185495;
        bh=KuMpckWaYzVrE0SzbUMxrzZ7LVnPP1FSHmTioHG1Ep4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6F6c/wA09a8CnPX7FTiEZpME7C755JNVsyXozO8wQzHp2k66mZ/G21MsfWMx0a6x
         hYDGCG0JG9nkiOUf9Yr5/YOL5Q0jun2qfHeP/f41k4lvK2duKCyuo6CApHYgYq/8Jh
         7SgIgtyhOf4ELh6iZbY7Ti2xFzfFSH6mc0ME8KsfxmUGpLX6BRoj3TStnv5Sh8hr1A
         ahlyQLKz1eNEqs5tEVjdUbrqonHN5xZwlDPTDi0GD7Zc//Ezp/+VnX79GZg9sgx/6p
         fLJHxPTfmu0cZWrwEzpCt00hlWRtQ3X3LLkWy/VKSl7Hm/6YWkAWFkhVslhBgAFDmh
         woilzr+vE4P0w==
Date:   Mon, 1 Feb 2021 13:17:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     matti.vaittinen@fi.rohmeurope.com,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: short-circuit and over-current IRQs
Message-ID: <20210201131728.GA5960@sirena.org.uk>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
 <20210127122733.GC4387@sirena.org.uk>
 <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
 <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
 <20210127163218.GD4387@sirena.org.uk>
 <5bf8b75f3a2f9db5fc200a9418ece5dfa2f91ab5.camel@fi.rohmeurope.com>
 <20210128121019.GB4537@sirena.org.uk>
 <a89bf6f0e6c1e4b9afe980908b7e36b70b304a96.camel@fi.rohmeurope.com>
 <536ce0f7-b299-f39c-15e1-a7c1151d0fd8@somainline.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <536ce0f7-b299-f39c-15e1-a7c1151d0fd8@somainline.org>
X-Cookie: Place stamp here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 30, 2021 at 04:43:46PM +0100, AngeloGioacchino Del Regno wrote:
> Il 29/01/21 10:14, Matti Vaittinen ha scritto:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > > It's not that we shouldn't implement support for warnings, it's that
> > > they're not the common case for hardware and so won't line up with
> > > behaviour for other users.

> ....but anyway, I have no idea what would you do when a warning is
> triggered: make a good example, please...

> I mean, take for example the "usual display": you are delivering power
> to a DriverIC (which is most of the times undocumented), your display
> starts drawing more than expected, so... uh.. so what?
> You shut it down? You reboot the DrIC?
> I can't imagine a DrIC reboot to restore the power draw...

As I've said several times now if you're getting anywhere near the point
where individual chips are starting to generate this sort of hardwired
alarms rather than specialist hardware monitoring stuff then something
will usually be very badly wrong.  If there's an actual fault developed
then very likely there is nothing that will fix it and it's merely a
case of preventing further or escallating physical damage to the system.
If it's something like a thermal warning then possibly waiting for
things to cool down might help.  The fact that it's hard to do anything
constructive about these issues on an individual device level is why
there's not code doing so upstream, if things have got to this point
then the ship has sailed.

Typical reactions would include things like going down to the lowest
available OPP, turning off some or all functionality of the system or
just plain shutting down the entire system.  The main distinction with a
warning rather than an error is that you know the regulator is still
operating.  If the regulator has encountered an actual error then you
don't know what state the devices it is supplying will be in, this means
that for example the driver getting the notification won't be able to
assume that the device will respond to register I/O or retain any state
it may have had.

> Keep in mind, though, that at least the qcom-labibb regulator does *not*
> support what you propose: that one has auto-shutdown (OVP) enabled by
> default (and *cannot* be disabled), no auto-shutdown on OCP (and no way
> to enable it).

This is very standard, the stuff that's baked into the devices tends to
be minimally configurable.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAX/2cACgkQJNaLcl1U
h9DpBQf/dS9dh0l/PUe5+vGA+kSctRdvnKpGrlyV48FmZgndiuqXoFYU9biXoi61
LJg9J42xz8YrMNSc6tfF5LLlk4o2Q0HTWfUTZaX6GDsVBEC1xd8+vPg1zXFQYQgn
LE1SMP8ox7Du5Di0QwCutStqnufjxmHflFbOazSqIunwfXXjmvKvZf4pQ03iRUno
hnkOBtxP9e/w2xLtPD3zC474x8dPpjjGGvwiVfKZOCQrijGoX8Cyw63Kw0I8Nld0
pClrfHc+mh3S0UsNCy9fnUsHS1TqMXbMzO0LinOk1eW4oKP2w2XYs64cf9IN8dgF
5pc0RS4CWm7kxpjmg8ZR555bJmTOcA==
=ue+o
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

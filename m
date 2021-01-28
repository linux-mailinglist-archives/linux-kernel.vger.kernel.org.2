Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE3D30759D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 13:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhA1MLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 07:11:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhA1MLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:11:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 717BD64DD8;
        Thu, 28 Jan 2021 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611835864;
        bh=Du3i/MIjsEBw9r6WpsGYm+IoqI+N+Q9qrB1wqlHYf7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VELdSdodtS3aOmj1dV3scBaogmg6gV1SNf0v4JpJaRVQKTBBjRfYBLdR+uqoIEZji
         bACorVj66FWALMBG/RwqP3ZxvD3Qax9W1Qr+dwLdR+duiQdpjIxwrY2URI2eVBO63Z
         BuWA9F7h/8uscwRNmU8+7etZjQE6n2k6wjIH5mFGP0R1hmgVxHjU2xpQ/wUIrghkT2
         xoSfLXpu7JsIXdhMxi1qtinzV/SCyXmz8gLZJiTN1caQL8nBH8ZHxNHoadA65zbOIa
         jIPYNTTBJ0mkEpWiZl4VAO8oY7Yb0+hzGgR4V7OYPpNCTZY4BKR6diX3EeaghxD6yY
         vLzFXocuEJ1Ag==
Date:   Thu, 28 Jan 2021 12:10:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: short-circuit and over-current IRQs
Message-ID: <20210128121019.GB4537@sirena.org.uk>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
 <20210127122733.GC4387@sirena.org.uk>
 <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
 <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
 <20210127163218.GD4387@sirena.org.uk>
 <5bf8b75f3a2f9db5fc200a9418ece5dfa2f91ab5.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <5bf8b75f3a2f9db5fc200a9418ece5dfa2f91ab5.camel@fi.rohmeurope.com>
X-Cookie: Do not pick the flowers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 28, 2021 at 09:23:08AM +0000, Vaittinen, Matti wrote:
> On Wed, 2021-01-27 at 16:32 +0000, Mark Brown wrote:

> > Note that the events the API currently has are expected to be for the
> > actual error conditions, not for the warning ones - indicating that
> > the
> > voltage is out of regulation for example.

> I am unsure how to interpret this. What is the criteria of issue being
> an error/warning. When I was talking about warning I meant that the
> issue which is detected is unexpected and abnormal (error?) - but might
> still be recoverable (warning?). I understand the regulator framework
> must not signal same events for different purposes - but I don't really
> know what the current events are used for - I am grateful for any
> guidance!

What the majority of hardware interrupts on is situations where things
have already gone out of spec and there are actual problems with the
output - for example with current limiting there's often an actual
limiter in there so the regulator simply won't supply any more current
than is configured.  With a warning everything is still working fine but
getting close to not doing so.

> > Well, if these things are kicking in the hardware is in serious
> > trouble
> > anyway so it's unclear what the system would be likely to do in
> > software, and also unclear how safe it is to rely on software to be
> > able
> > to take that action given that it let things get into such a bad
> > state
> > in the first place.

> Actually, bear with me but I am unsure why we have these notifications
> if we don't expect SW to be able to do anything? Wouldn't the panic
> print be all that is needed then? I think that setups which have dual

You'll notice that there aren't any actual users of this stuff in tree
at the minute - people don't generally put much effort into software
recovery as they're not expecting to be anywhere near limiting in normal
operation.  What I'd expect people to do where they do implement
handling is something like shutting down all other supplies on the
device, possibly also trying to shut down the system as a whole.  Things
more about preventing physical damage rather than being part of the
normal operation of the system.

For thermal issues systems generally try to apply software limits well
before an individual component starts flagging things up with an
interrupt, the limits that devices have are generally super high and
often there'll be issues at a system level (eg, a case getting unusably
hot) earlier and it can take a while for responses to have an impact.

> limits (one for initiating potential SW recovery - other for HW to
> forcing protection) actually make sense. So does implementing notifiers
> / error statuses for events where SW recovery is potentially helpful.
> But whether the existing event notifications / error flags are correct
> for these is something I can't decide :) Here I ask guidance for Mark &
> others who know what is the idea behind existing error-flags/events.

It's not that we shouldn't implement support for warnings, it's that
they're not the common case for hardware and so won't line up with
behaviour for other users.

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmASqasACgkQJNaLcl1U
h9AUGQf/SYv+mp40PK5S/9ba3hjppNcVtO5NzzSsCEGHicALnTmMNBIiruYaOtEF
oJMyC/SSxR2usFAUhiu1C3L3vUJm08t5Izg9cCv22BpinWTy8DjhUhFFFA5H7mMi
/B29ZHlDgZI8bvGGABDqq43ZgX8H/0Nj2FGsrqudUnHoJ0q+yQf5EhKXfVtBiRjE
zzOnExp5Muw99fGFmItQQCO+1LB8Rp/yEJFjnORaWhCD6dFMpLgk1f6lEBr37HG7
dU67XghSEk60t5Zxw1FTpUVovf2UNrgB93AaNPpoyakyF8FTqo7uvdMcwURq5Abc
/xxopA8+wjHB4fge+d+5MElX+9gk2g==
=jgri
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--

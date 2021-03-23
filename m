Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE76934660B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCWRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhCWRLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:11:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 388FB619B2;
        Tue, 23 Mar 2021 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616519510;
        bh=vr8Zrjh5X8xKchIvhLrqFt7VBZxgn+vtnETIR7vBu2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZ5IJVZX5kslDQlfbmlFovIs1FysrmFkgfD0GjdD1FyqGSUxcfOcHduOww83SN19d
         tP7a+zclqVpvzH1sejQ2t0DiJBkDUtPQsDJXKBRjlGN+nlScv0l2GoVU2Lrvr61aAX
         YUXCzR08JC/zEZ1B5nXPjSgESZ0Z5FcHoFbh0vCLN28SM4tA2yAsR/TrLkAaBMdmt5
         CZzxrcKfw9AzhWTCb3I6bujmvrSW4RFKJ/8qrmz/kZYsfGt3sSJ9UsGn8aqtTSoWPM
         4mm4d3lNqbsByW0nXMH197QwgEGgLkwgHI34Sm1wdMJ7wRelvgLx2P1rCRIKwHAWia
         nrVe0AGVF3maA==
Date:   Tue, 23 Mar 2021 17:11:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: ntxec: Support for EC in Tolino Shine 2 HD
Message-ID: <20210323171143.GA5490@sirena.org.uk>
References: <20210308212952.20774-1-andreas@kemnade.info>
 <20210310094821.GB701493@dell>
 <20210311184033.GJ4962@sirena.org.uk>
 <20210322145925.GY2916463@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20210322145925.GY2916463@dell>
X-Cookie: Formatted to fit your screen.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 22, 2021 at 02:59:25PM +0000, Lee Jones wrote:
> On Thu, 11 Mar 2021, Mark Brown wrote:

> > If there were more users it'd be better to have this in the core so that
> > problems we can detect like cache stuff if that's used but if it's just
> > one broken device it's probably not worth it, this seems like something
> > you'd have to try to end up with and which is going to cause timeout
> > problems with a lot of I2C controllers which would tank performance
> > enough that people would notice.

> So Yoda, is this to go into the core, or stay where it is?

Well, nobody's sent me any patches.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBaIU4ACgkQJNaLcl1U
h9CjwAf+NZzm161+2bC+R2lD9YmHIZP0voMbxPIDObcvA19R5x3auQz6/c2SeJhA
GxjJ6FEm+wPXd68oWh3rajhX/NyOJmDsRNWzyD3JgXARZhMsbmDzIraCCw4bTfRy
PANtOawJ+Yz5D2YcF9whuc1IdnmqXZX64UfXj2uVhgehM9vzVjVooRlFKorZaQbe
lmmhhYRh1i8UoDNoY1fdnMm0SoQAMG8qbVCPKYT/otw1JLNsZFXQfXK7nuspvSVQ
Ke0dbCMfFNYyfDx2NZFn4yTIKNjHL4g467J5FkdJMPzNHa8XUIcDtBdFkko/T6Wh
euR8DRoerw3PxG/MVlIhwZY3oTCJpw==
=r+UB
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

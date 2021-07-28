Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADD3D92D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhG1QKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237424AbhG1QKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:10:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 944C76069E;
        Wed, 28 Jul 2021 16:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627488599;
        bh=kyZ1KJI1rvCVsOwDl/SsgMb6gh5MhG+3LuR4pAcoLeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bctTfQbg6hhb45zejSKPM4EF4dwPXO9LmNNOcrSt74XQvCzmdxv2i57aZcTxZMdxh
         sIM23GgU/BkCtIS4bbsYGhOu/51wLbcRW+jKBuwG5ZICo8rzPiE81875mhGPTe+Q/W
         +r40gkbKslFaM1hy2s6rHv1/MpF++EckGvLxdjHDwYYw93Xd4n6Ko4whhY9yisvLlj
         gl33LtCmHmOfiY+uCEZAz3W8lZKrEm1OgQRUqpcfFByLyyfTgI6MThsO2xrVpvynhH
         IZFRzHeceysjvbed3exCnN7vzzIlK+5PsXnmXHW1NxUr9J4Dg6mQaXXomPqNK8B9Kz
         ViYYughdvLrbA==
Date:   Wed, 28 Jul 2021 17:09:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     pierre-louis.bossart@linux.intel.com, rander.wang@linux.intel.com,
        shumingf@realtek.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Revert "use component prefix when checking
 widget names"
Message-ID: <20210728160948.GE4670@sirena.org.uk>
References: <20210703125034.24655-1-rf@opensource.cirrus.com>
 <20210705165041.GC4574@sirena.org.uk>
 <a882a9e0-db05-2f89-abb9-8b308ccb56c8@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vx/N56bIaYnO6ICL"
Content-Disposition: inline
In-Reply-To: <a882a9e0-db05-2f89-abb9-8b308ccb56c8@opensource.cirrus.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vx/N56bIaYnO6ICL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 22, 2021 at 10:55:23AM +0100, Richard Fitzgerald wrote:

> I don't mind if someone wants to change the core dapm functions if that
> is generally useful, providing that it also updates all callers of those
> functions to still work.

> Changing the behaviour of core code to fix the Realtek driver without
> updating other callers of those functions is a problem.

The thing here is that nobody would have thought that that any caller
would have been open coding this stuff like the component things were,
it's simply the wrong abstraction level to be implementing something
like this so people wouldn't think of auditing the callers to find uses
which might notice that prefixing suddenly worked.

--Vx/N56bIaYnO6ICL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEBgUsACgkQJNaLcl1U
h9BMgQf+PalyhGjExV/oRAmKS31UCcBtye8lKsXrMc+XX4t3uWdkNkEXB/Sw1HDb
vmWb46mGawRE/nQvNCYFCSh2NmSVL7lz0dGvTY72/X7TEhkVx8ceFoq/VL1m8NBM
eXBPu2ww5VI8i02FYPo6s/DLnA9JHhKqFZZZq6PGTZy1fAUeCqYZFoMMSAchNle4
LxDh5tO134EG151LJFTBCFKQFJsYxSW1nhznw/a9MqOnpcxacCsGzDSpGHmZ6/bm
9bLxojsH60Bfw9HhDMvUYLmznpz8uBPgr2CB21dXhQWCioAKwzv8ufol7GMTWBhD
RX/6urs3NmTgXmi0ICbce5MlQFlsgw==
=sHcF
-----END PGP SIGNATURE-----

--Vx/N56bIaYnO6ICL--

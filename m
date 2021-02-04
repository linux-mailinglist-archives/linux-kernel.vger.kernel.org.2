Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CB30F5EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhBDPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:12:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237179AbhBDPKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:10:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B1F664F43;
        Thu,  4 Feb 2021 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612451394;
        bh=7BSaK+ZjIjpF5DSdO5dB49yuTQ484kyKnlv7VuEFaec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=laHm4bRmvrJPYpkgTiWfZ/xHuz8b/6RAlI/QbuAn8MH9IrrGeM/CQSX8Q3wceniXw
         FRvkTjp3kg+0uwyvSeFOpCGPJC0hTh5wkjhc+kxFLZVkRXz10vptQ7oBOjKgzFgh3J
         9NLmdWdsqJY3dB04c1JOPPtqwnj3AqxRB6zpX1zdKpwcfxgGAuU2aan84JPMpWfDVE
         tII+z0gKG3+mPI/vlH1yKbKFf5A2WWk8y5As6mPS6D4cNti+61He5S7qqkr+DY39Qv
         UJzxkOLuwLZd7u8TXDiJQAV0LWp1AneJ+eRxmRLbU/VPGHg6LJaKvtUH0nlttdIjhh
         2DIII7KjpLb4A==
Date:   Thu, 4 Feb 2021 15:09:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204150904.GD4288@sirena.org.uk>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
 <20210204134606.GH2789116@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
In-Reply-To: <20210204134606.GH2789116@dell>
X-Cookie: Truth can wait
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 01:46:06PM +0000, Lee Jones wrote:
> On Thu, 04 Feb 2021, Mark Brown wrote:

> > The usual pattern here is that the MFD patches get merged and then I
> > pull a shared branch in for any dependencies - at this point the series
> > is now on the backlog of serieses where I'm waiting for the MFD to sort
> > itself out before I really look at it again.

> I tend to push patches awaiting Acks to the back of the queue.

> Stalemate.

I'm only going to ack things if I expect to see them applied via another
tree, that's generally what an ack means from a maintainer.  Especially
with ASoC where we keep on having subsystem wide changes quite often I'm
not likely to do that for things like new drivers unless it's very clear
what the timelines are.

It would be enormously helpful to get the bits of the core MFDs that
create dependencies committed while the rest of the series is still in
process, as well as allowing things to be applied it also helps with
knowing if the dependencies are stable.

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAcDg8ACgkQJNaLcl1U
h9DAUAf9HROtNJ38LsxGRnoLdtz5m9eyu/zq4B961taC1T6LQlGBOqTIF1MlCVyf
8M5rdGI3N3kYlBTOvMspE0E34KWOA9IWE5CreCl9xxcZiNm0kLQtJtN3dmVBVESX
90LWORwSt7+ezT4SvMZCL7wBe13BCjQJORYfGKJxsm+rA2qNIiyijfnVOa52tyVQ
s/LbwZduYcSQXQxv24xgYhwOujAARjOxBlxhp+MedmeDWOzSWwflGyD9urxhjKiE
0+oP8NRzbv+/LCyCPKKoqbWGGQx05ce5VUCgHLIehczCfX7p/kR0QekpUBYx2rCL
1OWHZgvIArbJD/MpWfiqfcPUEgZVvA==
=prQV
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--

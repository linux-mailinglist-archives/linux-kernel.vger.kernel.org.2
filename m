Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CC3170D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhBJT7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhBJT7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:59:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01A2464EE8;
        Wed, 10 Feb 2021 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612987151;
        bh=yotLEcGqG4o9p/LhknZqAEAAlocilxMM2VuWnnlXcAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VY3Fx8Axy6qYPDQfoT/+5uPBVEJ7OfzNGjWHVLDrFeQ+Lrsf9tog5NgVBnEj3v2zS
         3O9mYB2GZI4YzS1P/C79LyAWNDHqKvXEGB9M6HpwY719sNi0U5t6RJTBTnz2hbGfvX
         VoVe8bWmXxa0kNtLH6n0VLi6TxJiKg9FWbpGxkPCuog5D8y9EjcZcIjzlkmnDPjFII
         uyRPi/f9QfXFduhgkOb+SxbHQ68v4xZfkJ2hfAc0rVIwqc16c8RFpXVSSGACMcfqf8
         V2ViuRebMBtoqZESRIcpdXGufdLZgyNQGVsXOH3vVxizHL+k/beTrdt3rylI841shn
         0fIBW1eqFq8TA==
Date:   Wed, 10 Feb 2021 19:58:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210210195818.GH4748@sirena.org.uk>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
 <20210206102644.GN2656@vkoul-mobl.Dlink>
 <20210208125032.GF8645@sirena.org.uk>
 <20210208150449.GF879029@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <20210208150449.GF879029@vkoul-mobl.Dlink>
X-Cookie: Are we live or on tape?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 08:34:49PM +0530, Vinod Koul wrote:
> On 08-02-21, 12:50, Mark Brown wrote:

> > Is there a tag I can pull the new APIs from?

> Yes, please pull from below:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.12-rc1

Ah, that's the entire Soundwire pull request including driver updates -
that's a bit more than is ideal.  Instead if you want to pull in the
regmap bits that might be easier:

Acked-by: Mark Brown <broonie@kernel.org>

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAkOtkACgkQJNaLcl1U
h9Ch7gf+J3prwtpV3pK+bGdjWYr84An0eWZC4w6aGqSBDE81NkRyrG/sebd9QTNg
KBL484vGu14FNBahCz6dq0G71yaHKw4bjZS5FqG/FX/zEYhKj5iscF7NUUbOeY5N
DPsi9vNxsPH4NHztjSa+vd9/U0liZcvch2rtMa71V3sjmyCQ1xs9OQXZ4GUqTv3L
5ng+TqKTMKHTbpL2ZJEtVFE+sxpi6NxrqSdj2sWdVoSi1oIviorn8P7nvcesboVJ
PS3mx7KrkOiB4Yuwu70YjSeGb5GVuOcOW2M4NaGmLrbOGYbiiFzcxbEvz+Wmjbq8
tv6VwcGIsoPZ1kTtWESzzI4K0eCjRA==
=LVnK
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--

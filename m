Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC65E419D00
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbhI0Rg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238301AbhI0RcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:32:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1077460FC2;
        Mon, 27 Sep 2021 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632763828;
        bh=sWthEd8thvF+XGkVYUkeFMxlWcXd1BhPEpZoeT80pWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yj9QDrwhkQBZSYAsOsJBGq9Bs62/LBNlL9bIz12/+OpRqNgkiDGQddJVl34MckGmw
         hetcjddDSGIMNkUTFPku0iGvxUApsEkE0V3M9lJ6WsGiRc5qo3b0GPHJKl64xZjc77
         Q6QbQzt8/j7qLWs7gF7CLXfGsObT0BCH2dJpjcy2BQbNQ4f3F7s2bDYAoVC1FP8t6K
         sWsI32VaGlnB23kxsY/ODXVkEyGTbOob1WGekA+v4+KpsA0IMnb/SBp1Mtx5L6OCrm
         MRONKGJ9ANY8FQ9hbtnyXxMY+wO+w+P63c2JDPkIWG095BvGfWMDpoX/Fu2kcM3l4t
         9/wHzy6aCAysw==
Date:   Mon, 27 Sep 2021 18:29:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>
Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
Message-ID: <20210927172940.GH4199@sirena.org.uk>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
 <20210927171033.GF4199@sirena.org.uk>
 <0af258d4-e33c-15ec-5dcc-a1c9961c0740@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
Content-Disposition: inline
In-Reply-To: <0af258d4-e33c-15ec-5dcc-a1c9961c0740@linux.intel.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2021 at 12:23:06PM -0500, Pierre-Louis Bossart wrote:
> On 9/27/21 12:10 PM, Mark Brown wrote:

> > A quick survey of other drivers suggests that this pattern should be
> > factored out into some helpers as it looks like there's several ways of
> > implementing it that look very similar but not quite the same...

> No disagreement here, we tried really hard to enforce a common pattern
> for suspend-resume, but i just noticed that the maxim amp driver is
> different on suspend (resume is consistent with the rest).

There seem to be several slightly different ways of writing what I think
is supposed to be the same thing in _io_init() too.

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFR/4MACgkQJNaLcl1U
h9CnLQf+I7rNZH7/UAxm+ygPqR5wyC07ln6SF8HTbd4RVPRcbgoUpr/zRLV0AdET
WF6koeLuHvqZ4HyJhvBcPNacTCBldtRTa/cWQzhV85mVLHWIeHfTBk6ySO860z4o
S9cjLuFi9upjkRBL7L1P40vl1Ti9gq7vUltipE4AVNfea697+lSy9C/H3Dyvlgig
8hKLejhr3ZcM5l8eQSZ1E878xyCNGRP3M4K5OoHydJeKBBAO3OiOyaNjlhgetsb/
8dELrjAtM9NsedKLfNBm6jAqcJ3zFJsjoMKfVB54FOBOdfMFoYPC1PoNWnj8vZQQ
Dw/6qpGr4yVYpZNqUqVNCtzlsHm5VQ==
=Q6Xg
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--

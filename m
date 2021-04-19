Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAB3646B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbhDSPIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238693AbhDSPIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:08:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7952861007;
        Mon, 19 Apr 2021 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618844851;
        bh=YUbe1J3aXgVRuK8O1Z/Qzwwks4IuxqFizF46Zio5gZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFBHTdtVNwS80fy5MGVLrHzah4IqMBfmX37OOFTAOfX4kTLIuUpzomcDWOiyOmrIE
         q9EfpuezbMFWgOWCmyWS3ITR70b9rp3H1vtWS6KDyenqO6FuDia7napOuh1QJ2n33i
         Ok1zCTl+H6Y9wgsBt1rbXgn/xNaD7OBpr7Pc/BFnZAjJXqfWFHmS+0G5ePvEdbMFZn
         zyWMn23xUdJwjGu9lJrdR8xAld3IUJWYIIxIsCfGyn7T9WmdCoLAEXH0G+MEQSydxK
         JFEyKnktef1O1bsBVjFNnfHVngrKOhoojWGKAKvMyJcAnFNKMqucmehBAidLHGRqSf
         rDWpru33Dtlqg==
Date:   Mon, 19 Apr 2021 16:07:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Codrin.Ciubotariu@microchip.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        gustavoars@kernel.org, mirq-linux@rere.qmqm.pl
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Message-ID: <20210419150705.GB5645@sirena.org.uk>
References: <5e1fb981-48c1-7d5a-79a6-ba54bac26165@microchip.com>
 <4f401536-5a66-0d65-30cb-7ecf6b235539@microchip.com>
 <20210415161743.GH5514@sirena.org.uk>
 <1aff49d4-5691-67cb-3fe7-979d476f1edb@microchip.com>
 <20210415172554.GI5514@sirena.org.uk>
 <ad5d556b-601f-c6f6-347e-86a235237c02@microchip.com>
 <20210416163131.GI5560@sirena.org.uk>
 <79161044-26b2-729a-b831-b79cc238e239@linux.intel.com>
 <20210416185538.GK5560@sirena.org.uk>
 <dfcf8b69-6ede-7344-79c0-cb572e03359c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <dfcf8b69-6ede-7344-79c0-cb572e03359c@linux.intel.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 16, 2021 at 02:39:25PM -0500, Pierre-Louis Bossart wrote:
> On 4/16/21 1:55 PM, Mark Brown wrote:

> > to the maximum supported bit width for internal operation so bit width
> > only matters on external interfaces) but I think for a first pass we can
> > get away with forcing everything other than what DPCM has as front ends
> > into static configurations.

> You lost me on the last sentence. did you mean "forcing everything into
> static configurations except for what DPCM has as front-ends"?

Yes...

> It may already be too late for static configurations, Intel, NXP and others
> have started to enable cases where the dailink configuration varies.

Well, they won't be able to use any new stuff until someone implements
support for dynamic configurations in the new stuff.

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB9nJkACgkQJNaLcl1U
h9AjtQf/YjGD5sr+aOXRfydBHJwcAvkfXdxmoMabMzf9FRfzTWoyRi4oYu5l67Ha
dTKFT/VRaUHA9GZsb543N8j/aXhD+TIHZCZW3uxaLx62GXeGF4YKVrIg/8g0Oiyi
+jOcUJzH/1x2ZXWL+9KG44xT4GSdoAR1kAsh5izyofvrBkeqmT/WqRJb6JCrN3sb
2okmBkrNCTYWkvq65nnjyjbdHDkhEeuiA8zayG1IMceTc7NeVgDr4OuY8vmvtMkA
5BXOU2iWfi41nkBTd7ux+Gv60Fz7JsCFd+KVUOO6dr5FoqAokPrrG03mD0K8sCfq
OsxqdxDTUzXqYKYY+m95P6u5vRIDGg==
=3kYe
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6B3D7A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhG0QLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:11:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhG0QLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:11:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FEDA61B08;
        Tue, 27 Jul 2021 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627402302;
        bh=8NvfuJawLzbM/fVF1eKVBvd0OVlOV+tspw22b+4ukNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xqa+fbPNxfGShpPstJU7hTPpS3PVcEgDtgCMvkg0BH2ldKXISaEIuuJK2xGDoztZb
         lGx7h1ngNiVBeO2zLX29X8HT3B3huMBnmgWaiuJv5JtQZK+15cuk3R0gM2AuvH1p7/
         ZhnUgn8CvUhn3d+axvNcSGywgjh/6W8D4JG87QvFYcQDhfP9hhVbc6miQPy5Bum5Vl
         qFXX97qDhzC+GKdZX9XWe8GgwMrZm/0BfVPKtGPXYybN1Cis/ubAGhp9hNqLiQGVB4
         lvFrSmDqc0CjrgfIcYrnCIsW0y5M7z2BGpSSjoGX1aHxoLORf+i8HeD+TXfdHTUd3B
         piTwYs3JCQObw==
Date:   Tue, 27 Jul 2021 17:11:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 0/6] soundwire/ASoC: abstract platform-dependent bases
Message-ID: <20210727161133.GY4670@sirena.org.uk>
References: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ECAkxgSy0pGoHfdA"
Content-Disposition: inline
In-Reply-To: <20210723115451.7245-1-yung-chuan.liao@linux.intel.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ECAkxgSy0pGoHfdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 23, 2021 at 07:54:45PM +0800, Bard Liao wrote:
> shim base and alh base are platform-dependent. This series suggests
> to use variables for those bases. It allows us to use different bases
> for new platforms.

The ASoC bits look fine to me, what't eh plan for merging this?  I can
apply to ASoC if people like, or should the Soundwire bits go via the
Soundwire tree?

--ECAkxgSy0pGoHfdA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEAMDQACgkQJNaLcl1U
h9CdKAf6AtOXcvqOdSyUtr2jdrGRPbpwr3waPLn4GDw04ZKgYdJrho0PBzAxlxaB
d0EQAW4ObIVUvo6T7TdeLXmm4fmG2Vw1g3tWpBlRQCEy0LW0vr+SlIvRWf3HrUnd
49125Ol3XCBcQOFtIY4EDnUsSeV77MZiY4O+vwHqMC16p4fYS17CMPfuw9dTrOEc
rSm7F6KG7umoXFKegbHqEIp2x7eSPmYNI6EcfaIo6dMDVcHB5auiUo89pMZM3T/b
c47Pgb3iDAiYXk8+qL+6A2Pd0p5CVmLVFG+JSP8GnJw3okpHw4IMdclRtRrEQj9G
flvy6V2bpUwCWiHrGTI7U5X1SAw37w==
=Wttv
-----END PGP SIGNATURE-----

--ECAkxgSy0pGoHfdA--

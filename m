Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2D41D94F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 14:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbhI3MHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 08:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350490AbhI3MHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 08:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70345619E9;
        Thu, 30 Sep 2021 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633003561;
        bh=WUXfDUc//JyjnG/jAFLzYhzrcKKxnKio8LRuz/Sa4SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc3KonpSQ9wIu8cbERb6KVjpU6LDGCPs80PSGa/jbjpkFYlKB8EBessNIIDdMPlZb
         mdOf3r6qDaOiloFsel5NQFH3syLotorSV9/I78onpGZBBaHVJCl9L4vPLz/wf/0B0X
         MigPNDhw6MAbsNwoOFmlyBA64VHiQxxhEOmmTpR5yvZGfkzKdSt8hwBIBchkgo6p2D
         Ud6vVQ8s/VLgdsAI936Z9lJVThvdHNORnb1q9dT20/+MoEYv+s1WYysiDGDspTmQt8
         M1VHpHnhCPa64p8SOr36dNqfZ9XR4xSJnqmJoXTc+l6XPyxypm90eVSrFcEYoWvhG/
         202AMiuiTRmJQ==
Date:   Thu, 30 Sep 2021 13:05:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] regulator: Add Unisoc's SC2730 regulator driver
Message-ID: <20210930120510.GW4199@sirena.org.uk>
References: <20210928073609.198975-1-zhang.lyra@gmail.com>
 <20210928113057.GJ4199@sirena.org.uk>
 <CAAfSe-vM8iG1OtQeVR1CxQtpvA8kqSs3pJ78RQQOL7GcWcTwSw@mail.gmail.com>
 <20210929122912.GO4199@sirena.org.uk>
 <CAAfSe-tJMvYyvtOArsAW9Y980y_qzUgHoaQsyqnO6W47f9jMNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mz5eWKkhz39mMVQV"
Content-Disposition: inline
In-Reply-To: <CAAfSe-tJMvYyvtOArsAW9Y980y_qzUgHoaQsyqnO6W47f9jMNA@mail.gmail.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mz5eWKkhz39mMVQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 30, 2021 at 11:12:28AM +0800, Chunyan Zhang wrote:

> On different platforms, sc27xx_spi consists of different sub-devices
> with different compatible string, to avoid adding mfd_cells to
> sc27xx_spi driver each time we add a new platform support, we changed
> to use devm_of_platform_populate() which can automatically register
> sun-devices listed in devicetree.

> The above is my understand, please correct me if I'm missing something
> @Lee Jones

Right, so my pushback here is that it's not clear to me that avoiding
adding compatibles to the MFD is a strong enough goal to justify
creating ABI - it's hard to see the upsides.  This is particularly the
case here where the subdevice is really a random collection of devices
that's particularly likely to change between variants and more likely
that other OSs would want something different so it's even harder to
achieve reuse.

--mz5eWKkhz39mMVQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFVp/UACgkQJNaLcl1U
h9A0NQf+MVIV20djUxEYTyRsu5XcsUBXOCjUH8C6aiUvI1f+91mdMR5EjZGsWxOP
Qxind1nfGXf7+41sboK/15s4xWsWpFDHq/4wBUkHdgiqoywBuYisngyieNGhVNeB
3FSJSdW0aNHNNNAjOSG0YXQRxog5XSBRSQ3s2614QFVXGFHh0DQoin2ud2rgPeZ0
H7A6BV2E0LR+w3YNs/twWw7j4aM/wkrVTCc9OfPNdX5gNC1SoK6KC6ApfZYUyT0G
k2jcq3qnQyGuadQPkpgo9X3tW7enbWzyGAL3aEN/jbaugSPsiS3pJsPizR00n5Jz
VIb/B5YtJxgs+XIw4I6aELxDkaDdhw==
=OZXI
-----END PGP SIGNATURE-----

--mz5eWKkhz39mMVQV--

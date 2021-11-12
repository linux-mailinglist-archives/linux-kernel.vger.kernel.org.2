Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E082344E7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhKLNth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235021AbhKLNtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:49:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9FA261054;
        Fri, 12 Nov 2021 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636724805;
        bh=TuruUUrvaK1PlbT0DO7/rZVvUO3uIxHO0WyVV0YwPCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYkOKu5lyiDVntszhjQGbrn8UkLQjGuPSBu6SGiGsPFTwsEAg4VMGQbPOfQPH/K5Y
         AlVQcjsYsPjkamfb01KcbZ4O+Jj/FKv+mVhQ2l3nPpC22dOqjgRoxJ/089NZ4DP9DA
         nahVnmsBUcGD98Apzg2FobhazahZc5/HTTq2zOtIjHYQj1OgS5Hwi9BML2PkEW3Bv2
         T4qdEQbOrQSY4b5/fjffkY8nHTeQraQMXLRmLLaKcOtVYfTVQ1Xry8MhJhgKYagsCf
         HfHcN5TPUO5TwJll1iLZXFPUSPQhDoPUXkX1wgZN7Lu+WGlJI01eyyt5ewGJNNOo9M
         ATfRQkrS+bCpQ==
Date:   Fri, 12 Nov 2021 13:46:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: regulator: Add bindings for Unisoc's
 SC2730 regulator
Message-ID: <YY5wPh0rwRvFjSRG@sirena.org.uk>
References: <20211008031953.339461-1-zhang.lyra@gmail.com>
 <20211008031953.339461-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BXpsF9fcILSz6uPG"
Content-Disposition: inline
In-Reply-To: <20211008031953.339461-3-zhang.lyra@gmail.com>
X-Cookie: While supplies last.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXpsF9fcILSz6uPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 08, 2021 at 11:19:53AM +0800, Chunyan Zhang wrote:

> +properties:
> +  compatible:
> +    const: sprd,sc2730-regulator

I still don't understand why this MFD subfunction for a specific device
is a separate binding with a separate compatible string, the issues I
mentioned previously with this just encoding current Linux internals
into the DT rather than describing the device still apply.

--BXpsF9fcILSz6uPG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGOcD4ACgkQJNaLcl1U
h9DNPwf9FzYXDmsgF2KZJNeBv/iF2rCDy8hHO87Dv4BvJmDmiCLBQ1JwutQIzVPq
jQrjyg7VvKqQ5ETgH8nwqQqCzkPjG/hdNSZPRQmSiUVwx+ZhuiiwUPr/gObaV161
812O3TL8HdEI46C1tKEteoDhze5w3Oxy/jCTcQfjkSO5BA+V7DYu55ZzXVkWgCBD
8xQv9nKDyr0cY0ZoO6iJkm0tiHTZuTSHCICdizBXyg1FhPwTI9XrpJZQvePg6okD
q7ztUS//QZz+vMG65Sz7E0l8cfbpOR6hgLP/PVpLXgF1nXdBsQinPdU0IfQp73Nh
yVh3RTySxjb9b+GdTbEZ5n6RQ5v5Ow==
=NMca
-----END PGP SIGNATURE-----

--BXpsF9fcILSz6uPG--

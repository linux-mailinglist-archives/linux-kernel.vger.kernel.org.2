Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C133912C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCLPXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhCLPW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:22:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F4EF64FEE;
        Fri, 12 Mar 2021 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615562576;
        bh=AMf6zMSzhPREXhU/v6XQo1ZUt0g8P00iHzAJO7Byljg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faezP91fqurYft+SrFRsjkHWj6RCo+ZPtBfbVj8KWXo/7O65fhiWMB0++W1DMIahc
         YJhzxpVvB0c/QHY3nQGKVPb6GLdz5Km0En5Wc3C2N1HCFMY8E2FXM69j1muZoMgn87
         O5fg8wBcw35BYogj7XrNlZZcebJtBLHQLrRY1XR2mUXpIFV9vmJiubv6mzslwXhUcA
         ofF8ewXHmCeafcy4HVQuGwjtGFb73MW6uO+/stRsFXGy21H7pMC0O9s44CJX8Prljx
         3WXvCeGPtjkhjkVLnbl0mOVYrh9tkgx5eZFua4m/f47pa79V9ULslPOYtv04eSKJG0
         4edz0+rZ5+QXQ==
Date:   Fri, 12 Mar 2021 15:21:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH 1/7] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
Message-ID: <20210312152143.GH5348@sirena.org.uk>
References: <20210311173416.25219-1-srinivas.kandagatla@linaro.org>
 <20210311173416.25219-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <20210311173416.25219-2-srinivas.kandagatla@linaro.org>
X-Cookie: Lake Erie died for your sins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 11, 2021 at 05:34:10PM +0000, Srinivas Kandagatla wrote:

> +  qcom,mbhc-hphl-switch:
> +    description: Indicates that HPHL switch type is normally closed!
> +    type: boolean
> +
> +  qcom,mbhc-ground-switch:
> +    description: Indicates that Headset Gound switch type is normally closed!
> +    type: boolean

Why do these descriptions have exclamation marks?

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLhwYACgkQJNaLcl1U
h9AYyAf/a+HKOx2YyKI9UX8A/9i8G3AdZdyJCOvJrDKwriB9VXplLK03qknmy6f0
3cwUy0x8cIfzCHZK569wSDUKCms2D8JSbDzLw9MDTlhxHChK7LMS/w92b6LiPwsN
6/4oQwEmnk9Uk9ln3tFf/+1r2aqq3Gpk1Y1ZUzeG92QWw2c7IcoVGAWzO8GDa29B
6oU/ufn6DWt3DWFhWMljZoE4phnBTWyfjxzd5Np6EkH2CgCZ6hBY7FwNjGOkyH9H
xvghPGfsi3MV37f9jRWLkgkGrM8ArwUQYSFunqICsCKbesG/PcfWhIrgT1LLmzMl
4ozsGGApVF0FAlwsbRPjQUp77isR6g==
=UBpv
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--

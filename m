Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFFF4318C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhJRMSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231707AbhJRMSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBDD461354;
        Mon, 18 Oct 2021 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559386;
        bh=fWptUGJ5IdZINQwiH3OSf5m8VgEC4zat/KLzZgCXdPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1fLYdAClZhRT5EhGhdrU7lPaPpeBd+CtICtTvdTO2ubspRYKyF5hCM/KWKPYfKPJ
         p1auVklicywWlVXMlhFKswUQARvrTdU8DA8sY81YfCk2Za0hP8243DJu3dqiRdgdvZ
         oDNtRLHjMZc0a1ICqwjFGVTl3g5MiERfg+clxedXqiB7uA60y3706v4hOOcNopPAP3
         JR5U9BED0boSC6Ssn/NuOhpumHanUs/mqYjr8Z8jUdNlQrJTondM80SsiFkVtoO/So
         7uRaTcj5CApcPs3hOygcWlPiSiBVtDQo9w5OBHnsbgIYLMWwjXahUpKXVXjyfzqEJB
         7cn01/MV7j1ZA==
Date:   Mon, 18 Oct 2021 13:16:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: uniphier: Add binding for
 NX1 SoC
Message-ID: <YW1ll5pvNXnwYRjc@sirena.org.uk>
References: <1634520605-16583-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1634520605-16583-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nq99JZ2FCgi5bIAG"
Content-Disposition: inline
In-Reply-To: <1634520605-16583-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Cookie: Here there be tygers.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nq99JZ2FCgi5bIAG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 18, 2021 at 10:30:04AM +0900, Kunihiko Hayashi wrote:
> Update USB-VBUS binding document for UniPhier NX1 SoC.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--nq99JZ2FCgi5bIAG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFtZZYACgkQJNaLcl1U
h9Aabgf/Yln07AvE4RekBaJh/ZK/d/jpt9zpGBDxNwp3tZmqIbYNE6pnem+7M3K1
MnHPJaCocVURqQsAaR0Y+sEGbge+PqDcpO4GlD+WxfCUp2wmAGzKuNOmUQPHHqe9
9KQGU99VaeJRBzalLNk0fkLULLSvODfbcob1V5x4sA6lh7D7Oh1t4JFs+C3yGs7c
6EpKVBgpb8IyO/Ka4KLDR4NYg2yy9h48RtyFO8FqzKgl8rwNW5ipEXC9DOTv3BPp
o/VOn17uGc/ddFvC2rtAaJ0Fonw6b884lDrTUAZbSx/wJmemlQxQ/RnT+FnquX3j
uQryHyI+YElF29JQqKkjKCPFefrrkA==
=ToDZ
-----END PGP SIGNATURE-----

--nq99JZ2FCgi5bIAG--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555A141929D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhI0K54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 06:57:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233883AbhI0K5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 06:57:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5547E60F12;
        Mon, 27 Sep 2021 10:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632740176;
        bh=569bQ7c6Vwx6IhvJnt4HJUX/13dRdmPK54xWgiiKyHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SU3MSbD7xEgFslYt6r6oVVuTcBROQBzvhCLxNLEXK6Qh1YHCgyBWhvG9x74W7O5T7
         Wgb9BxJxZpzdUfInuA9K/yJ5ZmG1l53wCCmguB1ORneYRyo6XkC8UeToagV7X4QgXZ
         eqhy7N/530resmpPYSRP+cwfaHgnfir4JBeJGevvy9DpBhOTiXnI9fyR6gvHuY3rmU
         1vsrDYG12Q86SsQVQu0QOmXWaLLU9Kv8CI4APD+fGjwNS48+CxBY5ruegYwRR20HYP
         cBqjh4cS+/lhRnimUvUjdCQTRr/YfCaNXbV5eiPOFrHcVihrMgeR+KVluOkwRYVM02
         1NEubIvCxMHHA==
Date:   Mon, 27 Sep 2021 11:55:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v1 2/4] mfd: arizona: Add missing entries SPI to device
 ID table
Message-ID: <20210927105528.GA4199@sirena.org.uk>
References: <20210923194645.53046-1-broonie@kernel.org>
 <20210923194645.53046-3-broonie@kernel.org>
 <538c0c79-d568-be03-e524-01f5c6429554@opensource.cirrus.com>
 <20210924112000.GB4840@sirena.org.uk>
 <20210927102754.GE9223@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20210927102754.GE9223@ediswmail.ad.cirrus.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2021 at 10:27:54AM +0000, Charles Keepax wrote:

> Yeah we should really be having different lists for SPI and I2C
> here I guess. I am happy to have a quick look at doing a patch
> for that, unless you particularly want to fix it up?

I dropped the patch so please feel free to go ahead.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFRox8ACgkQJNaLcl1U
h9Ab8Af9Gt50mRQv+yGTV65TFJai6mVyY/MrDX2UaU+xaGpb60Mz6WeQFPckOU7h
7TkCHkir6yVQe5gV3eyjoekiYw2Xn9Fm30n7CKvDYwEws36QMlVLC+MeUtb/iN6n
mNfSxjd48/jwWsNwPaIzLwAHVN0Wrf9fnpQBg5b5AF6zS6Gr6fEw/ISrXyUoZI7/
HGYzh8xTfq3zPf9t0H57WN+6Skn/Z0YMQr9UU+zgZ1dn34Mvb5LHRr/BfCz+1yMO
+HpZ8QEpou3GWQQXQU+539+s7YutyGkNvJ9QcB2pt/RLnM/0MovPvLCPq5GLFHnY
lgIIJr/ogKVdKGfaSCg/fCD1AyMJfQ==
=AR/f
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

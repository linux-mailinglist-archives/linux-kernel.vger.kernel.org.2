Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828CF3B66E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 18:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhF1Qiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 12:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhF1Qir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 12:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28BCE6144F;
        Mon, 28 Jun 2021 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624898181;
        bh=fM2UYPrxJnpjJzQAfwhDN/Dv4U8bjUg8ETAvFWC4mxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UuaXR6cXmyMxOTx7grxZ24uIGOf6jgvD8ysUu96av3wk89rlbRPaKiJDI0cmE0QAb
         pM4YS+ZLr/+CDUl5W0J5EF8o6tRDijdh+prAwYToHd5bu5EH0ixh9Tbo0wmXl/OgF3
         oHg4IJ/gq+2ikxlLPqb3xh+q643IGLcP+CmgFMiz5lrnOgSKRIwYmN/3l2e4jBcRT8
         llt+fsOjc3rDiM10+ds3IWilKARbJlkBrYW804L9Q46nzfcSYxdl4hYDoMln95i4DD
         ZUsSkZUsKS1Ex1jFK6nNPGGWbOFBcT3rNxb1qQNzaLTo4uGamDys6hG2cweh4FifRu
         d57SPXviKUlDA==
Date:   Mon, 28 Jun 2021 17:35:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Bo Shen <voice.shen@atmel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel: ATMEL drivers depend on HAS_DMA
Message-ID: <20210628163553.GD4492@sirena.org.uk>
References: <20210530204851.3372-1-rdunlap@infradead.org>
 <9ba0da3b-dbdb-c91d-2def-f3dcd30cbde3@infradead.org>
 <20210628130214.GB4492@sirena.org.uk>
 <6734cd67-ae14-74f4-a78e-b6a810c1cdec@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <6734cd67-ae14-74f4-a78e-b6a810c1cdec@infradead.org>
X-Cookie: Someone is speaking well of you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2021 at 09:03:25AM -0700, Randy Dunlap wrote:
> On 6/28/21 6:02 AM, Mark Brown wrote:

> > Please don't send content free pings and please allow a reasonable time
> > for review.  People get busy, go on holiday, attend conferences and so=
=20

> a. The entire email/patch was there. Should I put the ping _after_ the pa=
tch?
> Would that help?

Never send content free pings of any kind.  There's an "and" there.
Quoted patches can't be applied.

> b. What do you consider a reasonable time?  The patch was sent 28 days
> prior to this gentle ping.

As the mail you are replying to suggests this depends on the patch, some
things are more urgent than others, and in any case like I say content
free pings no matter how content free are just nose.

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDZ+mkACgkQJNaLcl1U
h9DblggAhwS5IQqddFnWasPd9h6yF5OEbnQV1e2IYp81mj/NjDG7RNdMlWkXl7B7
2Cap8Kax2DtjMNHdykf0pbs4jJzgYxMcuuobtGXFWpTs6+gPm9LcP8R7DYg7c+ok
b54DvQ085VHJc2yYMGn6HFq5vBKTJMav4SxMRUjfBzvb9wIqXnn9JQQVRAa8XluV
qFJ7+R4VbHILOaRWZqkeVtMGrxlbjQhegTDBmKZhESVSWffUL+I0J1TCrEgQXllq
qVrtMGoDVMb7606DbkkKJ8IK8RtWmlwJjXDVnDkZIqphiZ4KVa32CsMK2dXMDz5e
AF7qY99WHxYObQaNO9pfnoBaKNVItg==
=X13a
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--

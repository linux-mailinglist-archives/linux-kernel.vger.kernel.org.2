Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307C9459045
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhKVOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 09:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhKVOgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:36:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C771A60249;
        Mon, 22 Nov 2021 14:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637591596;
        bh=HQ/rBtmshuw/WiM8hjphmiy6FIeophJG9i6cPEOi804=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/HpMvWYEpjtGsN1Av5DUevXs3i6X9x1C+k8KKFVfrN81LQrd3pCbmuawx9aQ44Ab
         joW26hfLnlIc1AO9gfbU/MAEGu1QCVZfNgOnWlTji3u3Qd71tMp4oFHUmqnDYoL5kj
         my45BtSYWYsaJXzhD7AgrsCz7REdbPbkQxvXj4ilC0aZGCDcavb2O3H//IJxQ9Hi3y
         s+yWkr2fgbS5fJAbZjZO6UaH0iP0TF5mICfk1XzoCW3LkHK4yf8vnsE1KNpYa5UVN8
         p/Poe211EAor7LspS77bzWR1eOnNilutb45uyp1FVCrVgRntbjTNTf8yGvgnvSCKYV
         AJn68i0LNIZeg==
Date:   Mon, 22 Nov 2021 14:33:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bkylerussell@gmail.com, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, shengjiu.wang@gmail.com,
        tiwai@suse.com
Subject: Re: [RFC patch 2/5] ASoC: tlv320aic31xx: Add support for pll_r
 coefficient
Message-ID: <YZuqJiZznMfqmWR7@sirena.org.uk>
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <20211119153248.419802-3-ariel.dalessandro@collabora.com>
 <YZunmnHqemZRJ6JK@sirena.org.uk>
 <CAOf5uwnrUdF4fOVGvp8GmuUL6SpsyjPq46WBP7hcY7bYbw7RHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1RMo0WyMSz1lb9Z2"
Content-Disposition: inline
In-Reply-To: <CAOf5uwnrUdF4fOVGvp8GmuUL6SpsyjPq46WBP7hcY7bYbw7RHA@mail.gmail.com>
X-Cookie: Lake Erie died for your sins.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1RMo0WyMSz1lb9Z2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 22, 2021 at 03:24:42PM +0100, Michael Nazzareno Trimarchi wrote:
> On Mon, Nov 22, 2021 at 3:22 PM Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Nov 19, 2021 at 12:32:45PM -0300, Ariel D'Alessandro wrote:

> > > When the clock used by the codec is BCLK, the operation parameters need
> > > to be calculated from input sample rate and format. Low frequency rates
> > > required different r multipliers, in order to achieve a higher PLL
> > > output frequency.

> > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

> > Did Michael write this code (in which case there should be a From: from
> > him) or did he work on the code with you?  The signoffs are a little
> > confusing.

> It's fine. We are working together

In such situations it's best to include a Co-developed-by tag to say
what's going on, that makes it clear what's going on.

--1RMo0WyMSz1lb9Z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGbqiUACgkQJNaLcl1U
h9AvtAf/cw+AV+VDF/3zHrh077dmoGB7oWdCofQf+EMfotDjQb7ln2ohOl5iIL8N
v/VZcOXCABOS0IS8UxhyNAtoa6T8hc2d+vKmxYBjmBAuq4LJ9UaYxIYVYschC4z3
Y/F6cvzPdQG62JFzxh6sOWuPI8u33jDIBhcnjG2i9j5RyxWhZ4bDsDE/qHmxfGnb
UaDdgcb7I/ImZnzxOAoEKq/piUZc3jBTPEpUlw671U/9qxm2ZIu0HuRwutYukUZn
dQKjU3uzK7tTdisZOQjl4XgxgtBJc4Do0D9ZOQ8DLIGyH4x+5ZNKo0S/w6V7x3x8
mBw/kmOkXQEx9gMIuPq2XgmaZ4g1LQ==
=ufg+
-----END PGP SIGNATURE-----

--1RMo0WyMSz1lb9Z2--

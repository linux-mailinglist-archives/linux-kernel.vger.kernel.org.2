Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2253F7793
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbhHYOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhHYOmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:42:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D225E610CE;
        Wed, 25 Aug 2021 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629902521;
        bh=ql8zOf6SWyHcPUHzLv8yiojTzRm97Kk+Xup2MMUoHd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALkrXQh6kxQEO8lynHf/jpPmLCwpfLgxOMK1gN3YCDlxeK+H6w/5OB+rQEr6/ixPO
         c5/eUQTb5/+37iD6QOBG+Dmlafm3tcx/x7RmnxzDsP17jtD8XzQR50L3EvxwUDPbDh
         U8AiXnGlKO8CLluIVSjfndDAUU5UO63RkoJST+uJHQYk3smLIp8cwThd7WxwQP1jSm
         e6ADECyz5WD1WyGc0aGInv6QS0eEhBH+wfV+oHD+4HM1nYiE7AWJlcd9sh/Qf3yOaY
         s+u5zLHm3WziE4j5xl065f3lgmg1DJGqpIa7hZzCZzbvvFmfWJRs2MFomS/hnfqIfP
         Ngzz+1fFr3otg==
Date:   Wed, 25 Aug 2021 15:41:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        sailues@pendragon.ideasonboard.com
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
Message-ID: <20210825144133.GH5186@sirena.org.uk>
References: <20210824230620.1003828-1-djrscally@gmail.com>
 <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
 <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
 <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
 <20210825131139.GG5186@sirena.org.uk>
 <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 25, 2021 at 04:59:35PM +0300, Laurent Pinchart wrote:

> From a camera sensor point of view, we want to avoid code duplication.
> Having to look for regulators using OF lookups *and* platform data in
> every single sensor driver is not a good solution. This means that, from
> a camera sensor driver point of view, we want to call regulator_get()
> (or the devm_ version) with a name, without caring about who establishes
> the mapping and how the lookup is performed. I don't care much
> personally if this would be implemented through swnode or a different
> mechanism, as long as the implementation can be centralized.

That's all orthogonal to this discussion, it's about how we configure
the regulators not how clients use the regulators - as you say anything
to do with how the regulator is configured should be totally transparent
there.

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmVp0ACgkQJNaLcl1U
h9COmwf6AuRM1KNBdP2rhbsFwYapLGNLyNAdZT8vknC6v8R+9H8ugllh252UUD3J
8oQiPuzB6m5ZmoSEKLYRVGRGewUPe5AV98iQBW6e1xlbnsOkARxBxyi7NonnqtUC
X+pg5jvl63VE6WXrNlO3n4HHLr48hoc/jpCJloXAdlPASvqrkNoz0Dv3B0/kVDxZ
FTcqHDCl9l99ZDk/rUI3zQnRFTJKxZWxSeQB2nePQNWmGtRUiGfhSgG1GKkyFec9
I5Lo0V8KJZDSxnCLXC5KP9VvDnwubM0ad7HM2WghAuIeaKDhVIxUAfZMSwx83dsp
4ZSZ066rqThyuwcOw/G8SwPC3B9/Og==
=5Wq4
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--

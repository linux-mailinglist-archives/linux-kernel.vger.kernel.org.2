Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CE63C5D57
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhGLNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229978AbhGLNhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A50761006;
        Mon, 12 Jul 2021 13:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626096903;
        bh=8+esMQqnE0CL3nASFe5BnFES+LIy0VlT7a2RxHBxaow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgzhBgj+FRgfBSprppihomOBveQ1UMnY4bAgqjN6iscSFyqIvM0vRnIu0sQjDiQta
         DJOECXZtgVNM3IqSLRXlwNyFZi82KyUqBodBC13uR86m2m3CkteWf6j1hsFw6H6iKB
         Q3O/7T3X+6BRoEPBzFIH42hDwg9w/BmdqKd90EoIy69iqBOAx1EnfdqwJoTUFVag+G
         2ZNopAfWFL4J4F/yHta5HTiLXs2YVDwamDVr3LR4l03AGVI6YWCCwKzjxhVRIkjgOQ
         cjvjkQppIFwa4KDUW3cFAXSj8V9J7qpeiTkUbYSP+A1cBHFW7CPBtBaTOLK5gCUtq3
         0iLf5wwUJFC1w==
Date:   Mon, 12 Jul 2021 14:34:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
Message-ID: <20210712133428.GD4435@sirena.org.uk>
References: <20210708224226.457224-1-djrscally@gmail.com>
 <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com>
 <20210712124223.GB4435@sirena.org.uk>
 <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 12, 2021 at 04:01:05PM +0300, Andy Shevchenko wrote:

> The software nodes shouldn't appear on its own in the generic code.
> When we use software nodes API in it, it means that we have tried
> other providers _explicitly_ and haven't found what we are looking for
> and hence we have to check if software nodes are providing the same.
> For example, here it's done that way:
> https://elixir.bootlin.com/linux/v5.14-rc1/source/kernel/irq/irqdomain.c#L178.

> In all other cases it shouldn't be called explicitly.

But why?  I'm not seeing the advantage over providing platform data
based on DMI quirks here, it seems like a bunch of work for no reason.

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsROMACgkQJNaLcl1U
h9Ci7gf7Bq4RfJTjQvA0kVJ3gcUEpuRBbspc0k+EHEKRg9YoJEQMLewMBvPvJS4c
HQuPAicrFWCrmwIuOI52IIh4OevuWpRsnbSpsrbIibluHkxJyx833iETmUPx/EmF
76lLFJxldKGFXNTLkIyOb+Zc0UyX5+zhKc2inx81+v88pRu6C6R+L9YzKUxVssNf
gPqUocq2gg5FgmplyncbJOw27QiPP+PcMMlFIqtSh8kMBuHB31lt4B9gPOWhQkNZ
oyhz9OH+f1M3JSL0vnGsrDjRBLXN2IHei2qrAsIUAyaFaOXEwPlotkTupRxuwqKs
8LDZA9AYRLeeLQ0cQOsn6c+s623Ogw==
=+lVA
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

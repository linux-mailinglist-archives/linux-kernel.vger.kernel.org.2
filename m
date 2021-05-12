Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED737D22B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbhELSGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 14:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241544AbhELQ1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BF0E61A14;
        Wed, 12 May 2021 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620834838;
        bh=N016NWgkukjszQxuR/Ofv+KdWercgaEVuGtmzHviWyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5Cdg4r8O9CTyFW0SZFaL9lRd52w/VAOm0W3w/7gomx1x4zSjmFLNuzS0E38Jlu3J
         WlfuucToIrQZqnZjO0y19g+ZpkE7oUZd4xpaE1d2RtY/oIzqZ56PFaLhCPPabKlXr/
         JldbdFvCB2K22Ts1uWzkH0uhmY5x9M2nmQQJk46JPa/XHd/nNoyifhVUp/csJEfLo4
         Vo0Xzjyb0CjdiWc9TjxZ8gB0KZXorXV5278qf7x0QnTc15exOoEjFKd61jVLNyx49M
         vKzG0dtFp491CtiKZMq8it5xQaw+9YRc5OQsTB6zmZsFFMEkpQ5q70rdJXkhxbHHC0
         MJJ673GPmnxhg==
Date:   Wed, 12 May 2021 16:53:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Zou Wei <zou_wei@huawei.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        kai.vehmanen@linux.intel.com, brent.lu@intel.com,
        ranjani.sridharan@linux.intel.com, yong.zhi@intel.com,
        dharageswari.r@intel.com, sathyanarayana.nujella@intel.com,
        fred.oh@linux.intel.com, tzungbi@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: intel/boards: add missing MODULE_DEVICE_TABLE
Message-ID: <20210512155318.GA54562@sirena.org.uk>
References: <1620791647-16024-1-git-send-email-zou_wei@huawei.com>
 <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <50fa973b-aa9f-ccb4-8020-9d38a63e2c30@linux.intel.com>
X-Cookie: They just buzzed and buzzed...buzzed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 12, 2021 at 08:41:43AM -0500, Pierre-Louis Bossart wrote:

> I wonder if this MODULE_DEVICE_TABLE generates the alias automatically,
> which would make the existing ones added manually at the end of the files
> unnecessary? If that was the case, then we should remove those MODULE_ALIAS
> as well, no?

Yes, you shouldn't need the MODULE_ALIAS stuff there.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCb+e0ACgkQJNaLcl1U
h9C94Qf/R8x4USWufxkjE/vfZi6GbULEc2gbk+fdtzu/4PUfiZ/ZLBWQalz/259s
VFG4tL+IaGU0dgVPODTSMazVCHHXdd3hxXGK5JYtzRv1NGPfi7IHLZmKkzw9yQv+
bAELKl0QB7JXnYXWp8xeKQPZXoUBng5TNESh4qL/vBbEzHNgEA9mvmYP/Uh1cXFc
oosiFoCLmhxxHGFhQwE5mDapqqF4RhRzDaq6paFvGzuGYIrhd6I4YHccJ1cOaRhP
QbikYG9KjKDZUqz8iPfTvVKV+uRuhvXaEfwLPkXPrLs1oQ8syyn/eEAgTw8/kzNL
Izn00HcKd3k0Pdq19CJGrDDzdhIJjg==
=WJu8
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

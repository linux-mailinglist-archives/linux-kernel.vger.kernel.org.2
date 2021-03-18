Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698F1340745
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCRNxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231558AbhCRNw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:52:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81FE564F1C;
        Thu, 18 Mar 2021 13:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616075576;
        bh=Ve2/nk1F/T+GCGAKVkxI6siAwFKoql1OZeOANplilpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbGrPpjFvFY5bgXjGUkYQIlDF+JgGSMwDGGHs05lcoP6in3NJG8CApMpKgA1/PUxx
         fk+Icf+AQYzstcVrJyr1uuOvGgcY4ZGfddBSc8fkCBsiPGHClKrF3AnhLP6ZeMek54
         QROl2zHAGh2ZCZOomoCaQ10+sC6/oiE9g/Iwy2rv5I03ofndoHgwtDjKdtXRGlCb9v
         ureFi8aJUXKFqrely86AaiR90u/XdtZUlQPP8w+Dd4AjF7SPbV6Xhu4zJ208VBmIDg
         QLNMqw9C5MWnuFrexJ1U1Fow5YQJp662M69fD6qfAkZo8LgG3v64cQ54iQtNej1nFR
         Bv7vo5RuU8lnQ==
Date:   Thu, 18 Mar 2021 13:52:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <nick.desaulniers@gmail.com>
Cc:     guennadi.liakhovetski@linux.intel.com, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, mateusz.gorski@linux.intel.com,
        yang.jie@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Julia.Lawall@inria.fr,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        amadeuszx.slawinski@linux.intel.com, tiwai@suse.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v3] ASoC: Intel: Skylake: skl-topology: fix
 -frame-larger-than
Message-ID: <20210318135252.GA15895@sirena.org.uk>
References: <CAHp75Vdy083+5K=4sViwg8uNJ1_6agECYbjMSFEGXX9VTO85WQ@mail.gmail.com>
 <20210315013908.217219-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20210315013908.217219-1-nick.desaulniers@gmail.com>
X-Cookie: do {
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 14, 2021 at 06:39:08PM -0700, Nick Desaulniers wrote:
> Fixes:
> sound/soc/intel/skylake/skl-topology.c:3613:13: warning: stack frame
> size of 1304 bytes in function 'skl_tplg_complete'
> [-Wframe-larger-than=]

Changelogs like this look like Fixes: tags and confuse tools which
attempt to parse them, please don't just put a Fixes: at the start of
the line.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTWzMACgkQJNaLcl1U
h9DNPQf/Ub0XFEPo2B9Zb6vwJ2ekYiSV9f5fi6blCU8XvdPmKPbarXfrB9bmnotr
QOIiIeGxmzDtZ9oBncTT7isXsVeXsZE84KvUK+KNR9NZCsUIreZNz0zC6wFHwJAQ
uwRp4XlbZaTySmrf0dwLtv6N0KMNXBk1i5t0P9Ra1tAb5m4MDAJ/sH45AIq6oryz
bv1JEL2HrzmMUvxVX5z0PHl15b6tGH0l/XTIzoBATjvHvQzvuZLL80qA7u3ZTPRH
Ed/gMjwCl2v7TGcWCeAtCqV+/ainIE49hg3JFti4MYMi46Yymr27w/IkQ4MU1Rkx
jwJrd6gzeSoZp7WYDaYS+GVnkTJgHA==
=8dZ2
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689DF37A4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhEKKqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229892AbhEKKqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A4086192C;
        Tue, 11 May 2021 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620729897;
        bh=i1DOv+Mhp1oNF7Zq3P1l8wWaBsd1kPSHQTK219dAcnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E0GsHKLLlQx+/HUuLdFc1RvnZeibnrPhC7WcsWBOq2nQwnNyLzhWY+2dSbvJf70gC
         hsKVPZeASAf3QEDwkCHcwxbeTymtUD/fZUinN5Ds4syAuN5cBkT017W4RugxvrEfPi
         DGfvrwm4OkOb69nuOxzw8dtYY/ka1iVzVyM52/8HXWmf1C+CWxYRowp5XqqRr9J2fu
         z1MXCvU8uKASM+gzSPPZwE2aqM6BxlnqvPcC4a4OE1/u/RM0x1GbgOmKH5JSbRRWYy
         +YJcS90HBtI42oRM9ADZ+aFHNvLe5TA5nBXkjE7SRR/rTimzyPhgyhdT0xkRZ/kNrD
         YMM3YvEiTNHAw==
Date:   Tue, 11 May 2021 11:44:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire/ASoC: add leading zeroes in peripheral device
 name
Message-ID: <20210511104418.GG4496@sirena.org.uk>
References: <20210511060137.29856-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline
In-Reply-To: <20210511060137.29856-1-yung-chuan.liao@linux.intel.com>
X-Cookie: Beam me up, Scotty!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 11, 2021 at 02:01:37PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> We recently added leading zeroes in dev_dbg() messages but forgot to
> do the same for the peripheral device name. Adding leading zeroes
> makes it easier to read manufacturer ID and part ID, e.g.:

Acked-by: Mark Brown <broonie@kernel.org>

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCaYAEACgkQJNaLcl1U
h9A9PQf9GxmcPe+vgFlr6JcfKL+2qC5EWADMO0W7l0JTdMEuY58BRW3fwbqm2bFu
XuGRzHr1ChlW6Ths1ZbKq3xxJur8/qxXUIIS3CzNSNc5H1QeJmILZppQL7DipvHo
bFnituIXXR4Aa2imqG6Zcogp5eDurHVjF8vTfPZNaJySnkUJLasVDsivh3YhZPP3
7cJVoAC/tV7jRaVZvljyX7QTH9lO+3ymSnAqCyp8lUORuVPbzYU90YGYwkbPBTAw
99f8ddtC2Ih22bKl/XOJI5EHykwrW2/TWpfH9PpRQ3oWILTlF5+5GaI4N5rIaBrm
4Fs1DWR5MScqBVNZQAzy2zxR/wjqiw==
=2b/5
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--

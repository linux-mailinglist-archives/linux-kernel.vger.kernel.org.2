Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1B35009F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhCaMrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235625AbhCaMqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D00861959;
        Wed, 31 Mar 2021 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617194804;
        bh=5dsan0ndrXUIqy53+oo57Q3YAilOJBB0JkfIOMsN35Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvD7Ur3aG34dAIIV3x8Ep36vwkt/PVipw5fzhcrVagpmzfdHtQ5KPdiRpnXTXa5Ee
         N5HeHEcnaATBhnNfgGxMWUCZ70xxa/KdLbUFjYitonL9zuz/uVGMOSqlelQ9JDjFrC
         x1p8JELeQoinINo/caQyDTmEwpFu3tV2MfWy4e8U7/CbXFG9vqmfulRtsQo4vAR1Qh
         9lh3OdN5jNUTdB9DevHlGLf8pchl9vlJokB5uQRh/YJc7yukmRhRUZeyY1k8g33jmy
         nmmqwNVchp1S37LWivGJ25psBmGv5mjOCsj0Z7J5jcZ8HQVmhp+8ZiILsJseIqfxHE
         ocSrHbIR5GNAQ==
Date:   Wed, 31 Mar 2021 13:46:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: cs35l35: Remove unused including
 <linux/version.h>
Message-ID: <20210331124632.GA13402@sirena.org.uk>
References: <20210326061331.3234485-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20210326061331.3234485-1-zhengyongjun3@huawei.com>
X-Cookie: Never trust an operating system.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 26, 2021 at 02:13:31PM +0800, Zheng Yongjun wrote:
> Remove including <linux/version.h> that don't need it.

This doesn't apply against current code, please check and resend:

Applying: ASoC: cs35l35: Remove unused including <linux/version.h>
Using index info to reconstruct a base tree...
error: patch failed: sound/soc/codecs/cs35l35.c:9
error: sound/soc/codecs/cs35l35.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0006 ASoC: cs35l35: Remove unused including <linux/version.h>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkbycACgkQJNaLcl1U
h9BQPAf2LsQP1f+PG5zYRfgPSGavlopGgeKfjprn3O75A5oiJlzvm6qtBoDQfd36
3Ie6NJeYqSbZxPeoparIMdoehrOPqfLiZloLHr1kubQqxSzIuesasZv5vsoGMh3F
NQkJ96QANzEC3TxzldAoZ+hjoISN1K9rLjk+Wo/fNIVhV3gHadQ3Sfc/aUO+aFuk
Yhl4JpCOLjv5C9im4PIsc2LtTZRnMIXxDUb77gldP++BpWbwE2TGP3yApoxEIUnP
yowqZe/4ISSFsto4+zLw2PudWRRhCNyFb6IbZxi/qYGswR+0XvtuCWAB7WDxd38U
eo6yb5SZPwIDWiPka5SyHKJGLLcX
=RbL7
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A623F1C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbhHSPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240213AbhHSPYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:24:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79A9961075;
        Thu, 19 Aug 2021 15:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629386658;
        bh=TbppuiKfS5RzFZDe5IM1WjypWyaTiBt6AKpbU01/Vjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Li1FSwq9F5gEd2Ze4i6TyeATB5E6EALmBYJkB3hp6/FbRFZnlIDu4QQxy7DSOa7zp
         mGzAicpMuTnHyzL0tACFTBFfaRx71Mn1icTmxAkyHQVMDpUg7PcTVZYp8ic78/6TEn
         m9TfXqrLWDIBpGJ1+zG2cdenoIpnp8wYsYapEku7NnlJXCflgY2Vu8VypSPYZKILjF
         IVk1jBnwHu62qovVBjmH6g8ALcv7XkcLLrA7hHFuR5IXPchyC6KkqVzzRxwaAAY6Xj
         PpWumi0ETi95Qq1vYSTbkcofl9zbaIFhrYH7LE25WHuuJwb4axLFOkR8Yg02tAIhdL
         liOwL49KhITrQ==
Date:   Thu, 19 Aug 2021 16:23:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild] drivers/regulator/bd718x7-regulator.c:531:8: warning:
 Excessive padding in 'struct bd718xx_regulator_data' (8 padding bytes, where
 0 is optimal).
Message-ID: <20210819152353.GN4177@sirena.org.uk>
References: <202108172206.9cbgvI53-lkp@intel.com>
 <4dabc78a-f9ee-4e7d-8bf3-ea1c6cef8530@intel.com>
 <CANhJrGOh+9PoMmsv-Q9petTV-hv9rv9nOitg0NCQHqXVXzJvvw@mail.gmail.com>
 <422ade1b-8e88-d6dc-ae4e-799e729932b7@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Content-Disposition: inline
In-Reply-To: <422ade1b-8e88-d6dc-ae4e-799e729932b7@intel.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 19, 2021 at 10:49:13PM +0800, kernel test robot wrote:

> Sorry for bothering, we'll ignore struct padding warnings next time.

I think the warnings are useful, it's just that they're not important
for all structs.  If the struct was getting allocated a lot it could be
pointing out an issue that makes a real difference.  I'm not sure it s
realistic for automation to figure it out for itself so it's better to
send them even if they get ignored a lot.

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEed4kACgkQJNaLcl1U
h9AhvAf/X8iA7lw+gQGPtcpDfsRnpdm/eSdg5czGHcPoYCB0EXpC78C9Ryea+yEm
ZZpBB4cm+ZjOGpj/bV0vMFD7JKDofjXSN8E1GWyICUrOBj8wi6KVdYOOSdXzkwSj
btley9wci3zSIAmsdTHj4sEY8YOc/iwg+ZXtAYCNh/ypLgiI5LVh65hjxLAqd+p3
3JmAvYEnMA9jU6ji2USYOhA/McjfQN0DM+exKww/KTlSToG6F766zFHz12ygmytV
P7P+soQf1dpIQhmWH+goz1KxxzCsdWkTC0Rjyuo0EsO6MCJOg3feTgiQEOih2w96
nyHjnhDOBCW575mQv5lDw3zeyYV0Kw==
=UtaG
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--

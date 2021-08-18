Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520053F03AE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbhHRM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233833AbhHRM2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:28:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DE960EBC;
        Wed, 18 Aug 2021 12:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629289658;
        bh=bpEUVzaX1eNK3ZnCQo/tvZNBYugUCMLTE0xjd3B+BfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9DKN5Vw4hllELVywPduB8a27ZK71eSf9iyNYN56BAZh5OsqHUTct0wjuThrv6WOC
         eCU7r5hMfveTIL6BEkmM8R1yDE9r6UwhoVMRGEfeYQmhqmNWZSIKTYty47vvCyFKSq
         MpZzW8o5MhrNwp1xl9El0nH3r2qCqD2NvuA2u6B5TNgtnfAev08RqIVbfDJ/52DCvL
         TBq5qHRcSGC8q6mr/yYCraxYjn5hW+cshWmGTPUKMCfJtZGVsgaNeL63/WJfDefD+B
         qtGdmj/BGqBRzPqay9rjbGXjotm3t3X20I+jeFxhRnHGWbSVsh7Z/g674yu35tBN+V
         UzKGSNbJ9Zarw==
Date:   Wed, 18 Aug 2021 13:27:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     lgirdwood@gmail.com, ulf.hansson@linaro.org, lee.jones@linaro.org,
        zhangchangzhong@huawei.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] soc: rockchip: io-domain: set 3.3V before regulator
 disable
Message-ID: <20210818122715.GE4177@sirena.org.uk>
References: <20210818010956.1446770-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <20210818010956.1446770-1-jay.xu@rock-chips.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 18, 2021 at 09:09:56AM +0800, Jianqun Xu wrote:

> +	} else if (event & REGULATOR_EVENT_ENABLE) {
> +		uV = regulator_get_voltage(supply->reg);

I'm still not clear that the locking is safe here - the notifier is
called with the regulator lock held but regulator_get_voltage() wants to
take that lock.  Have you tried this with the various lock debugging
stuff turned on?

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEc/KIACgkQJNaLcl1U
h9B1Nwf/fjojVbQdJG3zjebyo27uuMcgr3TN0758aw+pPa5/axCIVbS/Q7VGopBU
vGGdmpNZevaK1tvb7KDT8vy2jHFiy6pCRmBfqwcG/HEP2bD4qron4FJlYVHBt8cI
L3E+D8aei3AjCn+UG/VOQJAyMMwopTSokmIMUe7rM36tuD7WJ4ccrGdGvHVHoKi7
l0zf4MzjbWQ1AGpAuGJ66x5liZWep/WAtfpSYFtbBcvlT6pZEX5ppAAMS1vs6l7n
CtXgqPme2Phpa0ras73Uc3vxMPETK1FYvfBn+Eho5qD1MmaUNGZkVwM1mDu64NM1
C8l2v/1Y4oEEZqQ8wnXZMlLDL5Cusg==
=Hehq
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

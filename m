Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAFD3ED39E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhHPMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 08:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhHPMBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 08:01:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9744361CA7;
        Mon, 16 Aug 2021 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629115281;
        bh=oFhyqYhu/cnaPtB7Ouj9mKCaRNEd2PP0TOXALGyaCoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3ZV2Y9TOtzj/FOVEi0b79qKUyfuhOnBvQvd3IUhorRuCoO5REDadgLL83+mjmWWY
         FhewmYHn/C1tNkLkEQNL5Qc5VIXzuulETHmo9ZbM7AsqIZaebQFye6pOqxHSOpvEex
         fxqG9krozeYu8SJK9xmArkljfkTRzmYLDXjfxoFcGeDdaCAmH4Mg8nJfXh79uuT9lc
         kwTC1ES9pqcLvtamSs8Dj2em+qWftE2s8rwkavXzzZXTgCUWwHbiFM5hUvweVn5lmp
         cEYlfy2fY343H62H7aACSp/8zgt8K61GZLPqM1ike4N7jnTqLa3MvcvD3tr3/QChFq
         UH64sLb23pMyQ==
Date:   Mon, 16 Aug 2021 13:00:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     lgirdwood@gmail.com, ulf.hansson@linaro.org, lee.jones@linaro.org,
        zhangchangzhong@huawei.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] regulator: core: notify regulator enable with the
 voltage value
Message-ID: <20210816120059.GA4253@sirena.org.uk>
References: <20210816032003.1162779-1-jay.xu@rock-chips.com>
 <20210816032003.1162779-3-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20210816032003.1162779-3-jay.xu@rock-chips.com>
X-Cookie: Allow 6 to 8 weeks for delivery.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 16, 2021 at 11:20:01AM +0800, Jianqun Xu wrote:

> +			ret = _regulator_get_voltage(rdev);
> +			if (ret < 0)
> +				ret = 0;
> +
>  			_notifier_call_chain(rdev, REGULATOR_EVENT_ENABLE,
> -					     NULL);
> +					     &ret);

This is going to be really expensive for devices without a cache and
it's going to be *very* rarely used if ever.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEaU3oACgkQJNaLcl1U
h9Ammgf/elam/sdPO7wekIt2w26E2ss+XgyM4ZNWpaZK7SutyRMXd3715wC2W7FK
zlCZtzHBG2wfbtOxAMG+pZ9JzuO+dEstWnj8tn+QhSkfJxixKc12tSwMuAChQjQH
ODoULsO2FhjUcAByLnfWe2sHSIMxn48t0LQ7QsIyFM05nDSHZfPfX7KQ0rZW+6y/
8QnknnvLfnn0pvPMYbg/Iy71DVu/SPwYncBhFF5aIl7+8axSA0/QxVxdECEd9AkW
yXcquGNF3728F/MVNo2voyk/G96rUf4nXv+0ibROJYsPPo1gu97VnQ7gpk+qv5pC
u/7b35pBWnb6lKBINnO2InBGJdJ8dA==
=6JaO
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800763FDFF4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbhIAQct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhIAQcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:32:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64B0E61058;
        Wed,  1 Sep 2021 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630513911;
        bh=y1c/D5zmMC7JOawbBXs6fSznzulN2NVBOiAlLNEuXjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJfILASUEEvPpkbVT3jXOHbnpOLmaCtRY+zj8Hkk/381At+HqeYDbjdk6jg4zpBGf
         oisPk9SEFbfgBc/f34pmOy0jFLgSzl2B5C5jmLA/UTGh7QrocNq0PV8gw7dge9B39S
         XMahVwAjFGVzfAnoOO5FMROUS+hpQLG4cKmPOED4hCsV0/Cwq72QeCYp4gKm8lXsbE
         R1nb2xuERJUBkpc0trcENT9pTJi5KsKV9MTLMPogur073v23ZFW72HnxQw8csxlE6I
         Ni19M9xpCn/tlBM6UL+6+P5xdiO8D39XPgLo5beT2/rjM92oiEo3VQy+SQbJjz/xNV
         10AFAhYiDS3QQ==
Date:   Wed, 1 Sep 2021 17:31:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: rockchip: i2s: Fix concurrency between tx/rx
Message-ID: <20210901163119.GA39417@sirena.org.uk>
References: <1630305525-65759-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1630305525-65759-1-git-send-email-sugar.zhang@rock-chips.com>
X-Cookie: Walk softly and carry a BFG-9000.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 30, 2021 at 02:38:45PM +0800, Sugar Zhang wrote:
> This patch adds lock to fix comcurrency between tx/rx
> to fix 'rockchip-i2s ff070000.i2s; fail to clear'

This doesn't apply against current code, please check and resend.

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEvqtYACgkQJNaLcl1U
h9BxBgf/RAh8wv4l2S8GAWfb2mR6GABSQYH7DftN+pPbe66GT0X+/FYi45mTxL/D
9i3Ya1ynoYCArBhICLM6UCKgYLLRE2pgT6EYyGK8u6aBrpT6XzHDx/cB1oBsZY18
avB/Jl7c6nbNRcF3njxkB2WmefKJ9HW3aNh6QyDxz2s0u78vzj8yWzkjBsAKETHC
kHD8dEAI9pTx6lX35vqzUv0chFU1xgBa4BrWjZRAiMu1W7HCrJeIIoe+K5LbZh6/
Wo2x+YRGdtbaq6vQ0pZCGcPFL25u+JSnEI0o5aMyhNtUh4n8IFnuhI0fzMSpDkFK
JA35vTg1ULgBhuAvLtJW28lVK1J0Iw==
=4hGe
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--

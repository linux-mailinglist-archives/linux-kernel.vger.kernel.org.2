Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB932A05B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhCBEQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:16:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346155AbhCAXiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:38:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE0560C3E;
        Mon,  1 Mar 2021 23:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641807;
        bh=mwsay5s5eqahx5ekc52x1LsK1xRv62c49/5yZJhJD1Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=utsnrD+uYaKXVnROaqQ2X+dMagsOxB/5oBHugEZimKr6ZBxwBLSOTjfcHrAMWpu5G
         gY0tDIRe3DHLcLSvWgHsMDTZ32vhyxSFc+JXAMMOtRQPl9zf8A1dZE2FoGV/KQqcZk
         xvlM/Di+sq0l4BYTHSWCqGYDJCVTKPs8txGE52qYxpLKywtz/6+U3LxfKsnGljdbtv
         /9PcXFmL0+D6/+mm3ShrFKeBBxFpz6Yf2zqMdeNN0MBRirPm6erklg6HtO9cbDq2OA
         vBiiPHoq7/gSFlh7V7F/07FIa0mKCrKTVvyG8gaxrwyJAPze9LtILDwR8l4n7+d7C4
         6gMasxszOtWew==
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
References: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
Subject: Re: [PATCH 0/4] drop unneeded snd_soc_dai_set_drvdata
Message-Id: <161464168096.31144.9397377400950127725.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Feb 2021 11:19:03 +0100, Julia Lawall wrote:
> snd_soc_dai_set_drvdata is not needed when the set data comes from
> snd_soc_dai_get_drvdata or dev_get_drvdata.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mmp-sspa: drop unneeded snd_soc_dai_set_drvdata
      commit: 131036ffae211a9cc3bfb053fadce87484e13fc5
[2/4] ASoC: mxs-saif: drop unneeded snd_soc_dai_set_drvdata
      commit: 7150186f1edb2fa94554be1bec26aa65a7df3388
[3/4] ASoC: sun4i-i2s: drop unneeded snd_soc_dai_set_drvdata
      commit: 0c34af2d5c9ba5103637c33c4f52d658172b991d
[4/4] ASoC: fsl: drop unneeded snd_soc_dai_set_drvdata
      commit: eb9db3066cdb57dbfd1fb3d85ca143ad5d719bfb

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

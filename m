Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA6F43FED7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJ2PBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhJ2PBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E69261184;
        Fri, 29 Oct 2021 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635519543;
        bh=mEBIcswgw9632dRuDbJzbqAYM5AZU2vSGumheCQp2Ro=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=KmcYAvjHh68pAorsLxOts9w9lIiC0cES+aC7xR+/bdRa2d1oxoZSbQL6skMh0lVX+
         wqSgXHyc32CziuAP4T9p/VStKo7ceiO9K4Sy+6qvnlcr0ThbfZ6wpZBaGbqzw/aR37
         Z2IBMEACAUyCoeO9w/xdoT7i+wbTqOMq9aRJs0g4TvuKZcYYm0ishvWJkKX2UopdLV
         b8kfvvHMrvIrwf0Ip8R+01By2OH7eRhE38q2acOlU0vUdhzgtTA9RezwN+YTfWjjpR
         LU0omWqDbZzY7qgLEBR9T6HUgkH6tQPdOmpuq4esqxcn5169G4u6fmVqXWngCdmc2T
         ZGbG2AoMyIslQ==
From:   Mark Brown <broonie@kernel.org>
To:     trevor.wu@mediatek.com, arnd@arndb.de, perex@perex.cz,
        matthias.bgg@gmail.com, tzungbi@google.com, tiwai@suse.com,
        jiaxin.yu@mediatek.com, Julian Braha <julianbraha@gmail.com>,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, fazilyildiran@gmail.com,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211029001225.27218-1-julianbraha@gmail.com>
References: <20211029001225.27218-1-julianbraha@gmail.com>
Subject: Re: [PATCH] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_RT1015P
Message-Id: <163551954099.3555751.4265484307853649135.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 15:59:00 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2021 20:12:25 -0400, Julian Braha wrote:
> When SND_SOC_MT8192_MT6359_RT1015_RT5682,
> SND_SOC_MT8192_MT6359_RT1015_RT5682,
> SND_SOC_MT8183_DA7219_MAX98357A, or
> SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A is selected,
> and GPIOLIB is not selected, Kbuild gives the following
> warnings, respectively:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_RT1015P
      commit: 2554877e4b08d258c2def27e3a0fd49d60a9a2c0

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

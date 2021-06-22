Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1543B086B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhFVPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232107AbhFVPQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864BE600D3;
        Tue, 22 Jun 2021 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624374879;
        bh=tq5W3HglBF9jy+mJvlAU7lrMCvmo4pvk0yjiPuf4/xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XL3S/7xbkKgf1TrgRLc11BaBRHJ1nsarxcrvBseoyoZN6FtUM90Eh4mD2gCbdS+th
         SfLvRws8xd8LydAe0yOkyrcNYseRW460yO5xSpUfFu2Jz01guOeNeO1UD61L8aayBi
         n1OQY97sXsY/1Zc7hHDcTAS6m/IS7QjaElauE/L/JuCo/a+H3pWMa45yc2XYAu2P+v
         ztDpx+p4aktwtT/LARiSyQTIlVs40j/+lORZzl9ZAHXtJ1QO2Yml4nxAuD1xRwIZPB
         SoZN5nouq5Su4diURilLDobNThZCwARFE7hz11rgqBssLqmLi3QFrBdjno1Iu6HJ3o
         16CBVm8czFFog==
From:   Mark Brown <broonie@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Fill in driver name
Date:   Tue, 22 Jun 2021 16:14:04 +0100
Message-Id: <162437355278.1773.13469789646711861169.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
References: <YNGe3akAntQi8qJD@qwark.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 10:27:09 +0200, Guido Günther wrote:
> alsa-ucm groups by driver name so fill that in as well. Otherwise the
> presented information is redundant and doesn't reflect the used
> driver. We can't just use 'asoc-simple-card' since the driver name is
> restricted to 15 characters.
> 
> Before:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: simple-card: Fill in driver name
      commit: 907f0a3051869a61499905377212500155bd28ec

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

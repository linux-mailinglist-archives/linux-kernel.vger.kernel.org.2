Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B33FE238
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344749AbhIASQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344979AbhIASQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:16:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B48B5610E6;
        Wed,  1 Sep 2021 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630520125;
        bh=SLkHUaFmZYSRvVymSMsqlnBse9OBxXfESd4/wbzi5iY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2EjjjxMxvPAvYhygtAMSkK/FfvwiA5wB4CsLesD6hTUBiEDIMoXefWv0cm4n2vj6
         83fj1v4yRJu2tDuhZPjtI5bOaCYBPJ8bmfXCAmKL7v2XpiZoiYnzjsS6co7xygAHcb
         mJc/dRTQkTQ48/2a/v1hSMU3DZ5SYuwAcJMHY05vwRV9Uoeus4KIMwwx1EeGu00dNb
         4YI8EHBpJwTk90Rle5Rc/1u5eo3iWg93vGFztS57KiLo6nX3tfHp+kyY4AQ481Z094
         VrlEB+0FxLNOE3X4KH5Y+pogtFBr9IZ2K9cSxmzyGsRsjf84XQhXSlyaX+gFfGWEY6
         NSSEsRDgmZM5g==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        linux-mediatek@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK
Date:   Wed,  1 Sep 2021 19:14:43 +0100
Message-Id: <163051912509.21630.17446670283577790838.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <7e628e359bde04ceb9ddd74a45931059b4a4623c.1630415860.git.geert+renesas@glider.be>
References: <7e628e359bde04ceb9ddd74a45931059b4a4623c.1630415860.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 15:18:54 +0200, Geert Uytterhoeven wrote:
> The Mediatek MT8195 sound hardware is only present on Mediatek MT8195
> SoCs.  Hence add a dependency on ARCH_MEDIATEK, to prevent asking the
> user about this driver when configuring a kernel without Mediatek SoC
> support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: SND_SOC_MT8195 should depend on ARCH_MEDIATEK
      commit: 940ffa19454704ca2ecd23b0d8dd604c93421bfa

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

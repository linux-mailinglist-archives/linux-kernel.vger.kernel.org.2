Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6F346BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbhCWWNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233741AbhCWWMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:12:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE245619C3;
        Tue, 23 Mar 2021 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616537551;
        bh=xJqjy+7weTlzSdZIQvB4cKpexVA+CmBfz/5tmXRjPCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tceejv7McpSNYJf1CFHE+FPQOuP/4eL8tqYhMg8FI1eBVsyhY0MP0IyAsSxbQJrWs
         1f5bHr81ChfTi3n3YlpROvkaWqJiBquopCiZqi7rb2ln4Azzoth4Pk/gLARA5tgG2u
         Bxwz4YqJ6RfiTh2gBmTFs2n8/MrP6KgRRX6tPaEPpBi99vTP+bfdkqs/MaBiT/nJ4L
         /mPP2c/dK0JKOvRU7sdOsX//3oSBFsocwUp42GZLsEEtKlvIEPJmJAZGKWr0iqUJb+
         s8rUQrpJmA+8jk01LRDk5QJy4Y3zgGakTX99a3oq0rTfXsTs2//OQs42CU3n5wcJ8s
         Dtsk8+Xwc9SDg==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com,
        kuninori.morimoto.gx@renesas.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, patches@opensource.cirrus.com,
        daniel.baluta@nxp.com, gustavoars@kernel.org,
        ckeepax@opensource.cirrus.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for some chips
Date:   Tue, 23 Mar 2021 22:12:14 +0000
Message-Id: <161653747938.32729.14710605922324529557.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616150926-22892-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616150926-22892-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 18:48:46 +0800, Shengjiu Wang wrote:
> The input MCLK is 12.288MHz, the desired output sysclk is 11.2896MHz
> and sample rate is 44100Hz, with the configuration pllprescale=2,
> postscale=sysclkdiv=1, some chip may have wrong bclk
> and lrclk output with pll enabled in master mode, but with the
> configuration pllprescale=1, postscale=2, the output clock is correct.
> 
> >From Datasheet, the PLL performs best when f2 is between
> 90MHz and 100MHz when the desired sysclk output is 11.2896MHz
> or 12.288MHz, so sysclkdiv = 2 (f2/8) is the best choice.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8960: Fix wrong bclk and lrclk with pll enabled for some chips
      commit: 16b82e75c15a7dbd564ea3654f3feb61df9e1e6f

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

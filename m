Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51C9311227
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBESf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhBESdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:33:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBC2D64FBA;
        Fri,  5 Feb 2021 20:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612556127;
        bh=yZA214pP9uEmxnlYovW4a/vibfl67RdvPHHROfP6O8k=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=KRNgmLlGoZ/Komwtz3wcBd0HAOvRePsOzlH4bw+vBB82jfBucMtmFsqWRbMG8HLiy
         EhmccZT0slTc0iAbO7Fh3XvOsOyCD+wCLgsd50a1Q0d7Q7FyRAgFHqZZd0Q/d8bBSP
         QT3HkMxyQnOpzVN7YstdHZL/mlhKWFF0/n8LzHm/PW/D6REaUqsEQWknJxhkpgys3j
         zkeWb5pSr41qvkD5gFgZa1OdtyhXmno73VuLV0utN+D9S7uV2EopUJpURT7FkTfh6d
         g2gDqaxG+uVD0jgf9bNUTbTW5LiOLiRCi2HCl6miNvdyfJ3xLPe4QNfsXnU3g+qpKh
         vIc3uNp0sdBmQ==
From:   Mark Brown <broonie@kernel.org>
To:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz
In-Reply-To: <1612509985-11063-1-git-send-email-shengjiu.wang@nxp.com>
References: <1612509985-11063-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATH] ASoC: dmaengine_pcm: add peripheral configuration
Message-Id: <161255607746.56562.2848342434481411880.b4-ty@kernel.org>
Date:   Fri, 05 Feb 2021 20:14:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 15:26:25 +0800, Shengjiu Wang wrote:
> The commit e7bbb7acabf4 ("dmaengine: add peripheral configuration")
> adds peripheral configuration for dma_slave_config.
> 
> This configuration is useful for some audio peripherals, for
> example, the peripheral supports multi fifos, we can
> let the DMA know which fifos are selected. So also add
> this configuration for snd_dmaengine_dai_dma_data.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dmaengine_pcm: add peripheral configuration
      commit: 500c9f8c58a7c8cd5d9c1483569c046cfcfc47a4

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B73B1E59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFWQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230122AbhFWQL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8DEA611CB;
        Wed, 23 Jun 2021 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464582;
        bh=XycGzb/Or5rXgqXxq5Pfdilk0APC+bbYpOpd9WsN+44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6+OULooCZkRCYLOck+FarGNR1whZWAjnNUqxQP+vHnmdm9fIh8d320I+xsj5N7R9
         B94VqkbW6XVZRajonlkGv2gaOJT8p/mFoMKw0UM1+nD8531vDy5t/AfsKWaAQievpK
         bbrrlwuL5/nzDJpjMeOBJyGoEng62Brx74mqbVxtsWbmXshGc8KpN69HQJMK3usTbo
         Zm0+HCgd9a7RzYPhWA/6/prSSUxjFi8xWVuiTLgZpGwoFIltvsMIzqPDoPclGZAza2
         MwQPtefUA28lMu9KE4QlL6FuY10IqCifknf6HM6fFcFzSC04WfjTNwoMQ+MSB72/qy
         5X7yZnzfXkHcA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, nicoleotsuka@gmail.com,
        festevam@gmail.com, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        Xiubo.Lee@gmail.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unexpected interrupt after suspend
Date:   Wed, 23 Jun 2021 17:08:56 +0100
Message-Id: <162446397756.55213.7915054235058479880.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1624365084-7934-1-git-send-email-shengjiu.wang@nxp.com>
References: <1624365084-7934-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 20:31:24 +0800, Shengjiu Wang wrote:
> When system enter suspend, the machine driver suspend callback
> function will be called, then the cpu driver trigger callback
> (SNDRV_PCM_TRIGGER_SUSPEND) be called, it would disable the
> interrupt.
> 
> But the machine driver suspend and cpu dai driver suspend order
> maybe changed, the cpu dai driver's suspend callback is called before
> machine driver's suppend callback, then the interrupt is not cleared
> successfully in trigger callback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Fix unexpected interrupt after suspend
      commit: a7a0a2feb957e446b2bcf732f245ba04fc8b6314

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

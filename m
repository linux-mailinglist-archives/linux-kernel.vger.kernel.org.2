Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F192397947
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbhFARlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234716AbhFARkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79E7A61042;
        Tue,  1 Jun 2021 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569138;
        bh=+nPjaSYf2jAkLUxPL/kyjKJJSVXdCLkfPNaKAIs/mdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzMx62HNQLZme4iBjeeNaEbpRg12XN8fLoWrjqdL7sc2+ulm0seM749m+u1a9awXx
         3MwOqYkC5iyAhVIGcN6TQOnNp3iVVQERzYRl7Zy62CuTPc7NHOiGBmQytmTQ2lVxan
         w67MavJV7o3E5vmbWGh9KCvcAUUJudnL/PQnJJax1JMi7Lcmixx/Wgi6D0s+XjHxQd
         /lJX9PmsdKQljvzB/rZb0dCqCt5cdDfMdQhsPuG/h7J95Zl97Qjr++4XWwgwHLE2/Z
         Vp59mHpBQKj3qzqc/KKM4d7mkmEc8kRtlkiUApYWYhJtXovFnGc6udVcG7N1dxWXko
         dAGGdf2OuVqOw==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Timur Tabi <timur@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Set .owner attribute when registering card.
Date:   Tue,  1 Jun 2021 18:38:12 +0100
Message-Id: <162256892744.19919.16538295874685762857.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
References: <20210527163409.22049-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 18:34:09 +0200, Nicolas Cavallari wrote:
> Otherwise, when compiled as module, a WARN_ON is triggered:
> 
> WARNING: CPU: 0 PID: 5 at sound/core/init.c:208 snd_card_new+0x310/0x39c [snd]
> [...]
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.10.39 #1
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Workqueue: events deferred_probe_work_func
> [<c0111988>] (unwind_backtrace) from [<c010c8ac>] (show_stack+0x10/0x14)
> [<c010c8ac>] (show_stack) from [<c092784c>] (dump_stack+0xdc/0x104)
> [<c092784c>] (dump_stack) from [<c0129710>] (__warn+0xd8/0x114)
> [<c0129710>] (__warn) from [<c0922a48>] (warn_slowpath_fmt+0x5c/0xc4)
> [<c0922a48>] (warn_slowpath_fmt) from [<bf0496f8>] (snd_card_new+0x310/0x39c [snd])
> [<bf0496f8>] (snd_card_new [snd]) from [<bf1d7df8>] (snd_soc_bind_card+0x334/0x9c4 [snd_soc_core])
> [<bf1d7df8>] (snd_soc_bind_card [snd_soc_core]) from [<bf1e9cd8>] (devm_snd_soc_register_card+0x30/0x6c [snd_soc_core])
> [<bf1e9cd8>] (devm_snd_soc_register_card [snd_soc_core]) from [<bf22d964>] (fsl_asoc_card_probe+0x550/0xcc8 [snd_soc_fsl_asoc_card])
> [<bf22d964>] (fsl_asoc_card_probe [snd_soc_fsl_asoc_card]) from [<c060c930>] (platform_drv_probe+0x48/0x98)
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Set .owner attribute when registering card.
      commit: a8437f05384cb472518ec21bf4fffbe8f0a47378

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF58B39FC0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhFHQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233939AbhFHQJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:09:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A46BB61078;
        Tue,  8 Jun 2021 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168431;
        bh=RLYClvzf+9zh8zPCA1AZ11On8MN7nXwqdgFy13xhXyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KQS6ecLeAgLlnZNbkCA7n22fN+y9GGAl2b/zvkSTdodMboq4PbvxDyZYUEPuOHOGN
         w28Jb08XSl0n50MnGPVdWm3R6T4BqY1iDgVFA881ALKcWN4l7QMsbDrh8nD7othG3y
         Mra1Q8FcUj99OydSA8hZs5WJufbcnfxrPMDaVMG5w160NpG7/UqMyXeNAauQnoMTAi
         Txti6e35BGe+NEx8V0QlUPEcz+aHKcsbp58X7BhLym3kpg5KbqHZ0X1AGVA3FfdDyf
         5FtVJxlcxkYCHYgdlyfZH1xjXuAKQCAjgUhW59cQYZowYdpUYuyIBvwMm2bCMwlPU1
         8ONjgJs3efp9w==
From:   Mark Brown <broonie@kernel.org>
To:     kaichieh.chuang@mediatek.com, perex@perex.cz, lgirdwood@gmail.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tiwai@suse.com, lumi.lee@mediatek.com, matthias.bgg@gmail.com,
        pierre-louis.bossart@linux.intel.com
Cc:     Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: mediatek: mtk-btcvsd: Fix an error handling path in 'mtk_btcvsd_snd_probe()'
Date:   Tue,  8 Jun 2021 17:06:37 +0100
Message-Id: <162316808974.49749.9800374437345817638.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <0c2ba562c3364e61bfbd5b3013a99dfa0d9045d7.1622989685.git.christophe.jaillet@wanadoo.fr>
References: <0c2ba562c3364e61bfbd5b3013a99dfa0d9045d7.1622989685.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2021 16:31:09 +0200, Christophe JAILLET wrote:
> If an error occurs after a successful 'of_iomap()' call, it must be undone
> by a corresponding 'iounmap()' call, as already done in the remove
> function.
> 
> While at it, remove the useless initialization of 'ret' at the beginning of
> the function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mtk-btcvsd: Fix an error handling path in 'mtk_btcvsd_snd_probe()'
      commit: b6052c3c7a78f5e2b9756c92ef77c0b56435f107

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

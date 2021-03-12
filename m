Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6B833982E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhCLUZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:25:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234758AbhCLUZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:25:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF6E64F86;
        Fri, 12 Mar 2021 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615580721;
        bh=XM03Gt6hwnAQA+iUKmdY5gbRmhZPWBo/y7O/aK8RnLI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=AASoTXXQed8pOwRYePS/BplyEU4iF/DWiw9dztQ9fY77nPOvMd3JqW88ovkxaHKSS
         QWYdBSJIWrVWP2IfUUPcXhKpRi0JtDjvIR6hy92HzXiwH/sRvK4/C47DWXOSXRrwJE
         +s3XoTTFqZaw3vJKsgciSSUmzY7CVDgi/oWN18rqMjCwCo+YcK/4tx3uxususyvgSi
         9WofbZ7sEC5BiEn6uASFFbIW2krlkSo8KUC7iBuFyklxyHaoVRSEF0L/mu2oiz6j6e
         Ze1+vrAlbAQzNNj/GY1ssut9EeH1VwRITv0oPMD6LDaog5gdhgnFObsoTTcj8eNVSP
         8/JRPfCjEXFVA==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-kernel@vger.kernel.org,
        tiwai@suse.de, Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
References: <20210311004904.121205-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: mediatek: remove cppcheck warnings
Message-Id: <161558062957.11113.1173652950898922023.b4-ty@kernel.org>
Date:   Fri, 12 Mar 2021 20:23:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 18:49:00 -0600, Pierre-Louis Bossart wrote:
> There should be no functionality change, this patchset only fixes
> shadowed variables, prototypes and removes a useless assignment.
> 
> Pierre-Louis Bossart (4):
>   ASoC: mediatek: mtk-btcvsd: remove useless assignment
>   ASoC: mediatek: mt2701: align function prototype
>   ASoC: mediatek: mt2701: rename shadowed array
>   ASoC: mediatek: mt8173: rename local irq variable
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: mediatek: mtk-btcvsd: remove useless assignment
      commit: 2e5e57f085a3243aae7e4af88dc2c40e5ff4d3be
[2/4] ASoC: mediatek: mt2701: align function prototype
      commit: 57f1379e77a7432759e2f35b720c71863e2d83bc
[3/4] ASoC: mediatek: mt2701: rename shadowed array
      commit: d9cdc1335622866c52a463325b3aaea9844cff1b
[4/4] ASoC: mediatek: mt8173: rename local irq variable
      commit: 14667403a5631ce2fd2935d90c6d36f7975f61f3

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

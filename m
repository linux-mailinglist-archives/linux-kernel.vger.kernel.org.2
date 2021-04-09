Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBA335A328
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhDIQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhDIQYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1F78610A8;
        Fri,  9 Apr 2021 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985448;
        bh=v3Zqc/3dsZP8D8F+VP4VtmHrJNK58dXKx2K3a3/TSzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYueY1PD40MhKLT5JZec4XfAUfEgLY5xLGXOKcbIjGVUnxuCaw1vJWIZwiQnXxDS8
         W4qI9U9lKrnBXgnHLRwfwz8ElzPwmNbF2P/X7GFQsOSQrwi/7m3IQcgud52hyMahpH
         jhPMgwLVIWa4OePL3raO5EUZwze9ZufeIkyL97RTi2DiDJ4qcG3HtBpb94Uzde2rX8
         E/aG8s/zbhqqGOIZ4nRnHjwBmxbuTeHsSzNQ0SK9WMlpfLUpksSVOM/Tg9sDvv/A+m
         REhH9jrfb5mvgfOxwaM8d9QEPznMi8q/UAOszOc6vqW9wi3mq33N/4kbTKRAawgql8
         c0Gn8JrilnhXw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ye Bin <yebin10@huawei.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: amd: raven: acp3x-i2s: Constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:57 +0100
Message-Id: <161798344183.47643.9676736315193814010.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062651.803413-1-yebin10@huawei.com>
References: <20210408062651.803413-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:51 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: raven: acp3x-i2s: Constify static struct snd_soc_dai_ops
      commit: 3e075e842899779bd321520a3524a278442467d0

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

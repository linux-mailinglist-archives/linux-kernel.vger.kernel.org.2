Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E478335A321
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhDIQYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:24:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbhDIQYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38A1A6108B;
        Fri,  9 Apr 2021 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985431;
        bh=mr6lFHIFIMXmguReaLtcYOFBsfMpP7iZFQC+ilCWZio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4899Qp6CSHL4vvl8vqeXC7p0wal7hBqXlI4Ti+5lOiZuV00J2Q7hP9cIZmGqwYA/
         0TIMN/puf6MO5CyzQDky5NSe4g5DrtZDVSnHa09jc62puURHw1Gqxlp1mApq91lj4B
         TLcmnG6tN9J4cY8ZMep3rC2E/2SQkSri34yvQm8BxlOyJelVpkyWWPZo2NPGp4pzJ6
         v5QPMt1WxVmI10BzQdaAq1RZ1QXF3I5HfDHfVnfd6Lwq/p8YonMi8XeC2FzDEAROSx
         5hQmMUfsvnhwTBClTf+B3/kGyARw0QzszzYobcsTY4mR0VMjY95Cr608gRy5poMvSD
         x6iSK6LV4hZKA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Hui Wang <hui.wang@canonical.com>, Ye Bin <yebin10@huawei.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: amd: renoir: acp3x-pdm-dma: constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:51 +0100
Message-Id: <161798344184.47643.3848198984728589699.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062658.803724-1-yebin10@huawei.com>
References: <20210408062658.803724-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:58 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: renoir: acp3x-pdm-dma: constify static struct snd_soc_dai_ops
      commit: 4150cc7306fa84577dd0c33f158949b0f085aea0

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

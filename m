Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8A358A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhDHQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231752AbhDHQzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1870F6113A;
        Thu,  8 Apr 2021 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900936;
        bh=htlRiJ3+W5yCVRkjQ85b0eszxfKwlo/CNzzLketzYTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmBy6b20oW2rFEaDuRn0qGKuUvtdaQhBhwTM6wrUFb9JqTVTyqVRfna5v/SQGI6Lq
         v6Agsvy6ZnKc/k3rf2irLJiEr/sVBhv+LiefbLH9rxOhmkx/RWNFIZ/tw11+ot01A2
         LJEJYXKZAU1Z9WhG/U59IbQt70pt5gtjmKOHDArwvCk4DhCZArwXftTD3xQhIYzC6E
         thuMwK5G7Rm3PUnFNnBXvR959caxIGB7oLeF5FRmVffNdjlUlEGRAnGxT0iRwJgVkj
         rDCd2inJ+M2tvII4ZJZJj9e8ZS2z7v/wUuYDmUttCp2FAmRIeRG3t6Z1mqwgWYi7vY
         5vCNjl1dEYK9w==
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>, Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: tas2764: constify static struct snd_soc_dai_ops
Date:   Thu,  8 Apr 2021 17:54:40 +0100
Message-Id: <161790012551.16915.4640106834409822350.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062643.802908-1-yebin10@huawei.com>
References: <20210408062643.802908-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:43 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2764: constify static struct snd_soc_dai_ops
      commit: b186e7c17d9f2c2bc9cd0bd362402eddbea7749b

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

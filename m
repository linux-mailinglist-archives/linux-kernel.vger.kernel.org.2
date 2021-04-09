Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29C635A323
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhDIQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234193AbhDIQYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F09A9610C7;
        Fri,  9 Apr 2021 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985434;
        bh=4ZmVfJ5ykqH5Uf8odNUAdm91J9+g4LRpPY6KYKiFzCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxVgRwFF3WQnS1uzeS+3wcypONI0f8Fqwiro1lvv9kvv7nKDfi0xweW5xkHuuvxc7
         BK9kJDwKadr7PgV13wu6Q2IFPd1gCmDPeXpDAuED0PX4cesJOh0lk2t9PRdqA93h4N
         VKWvaDyHh8W0bb1bjgxIEqJeJRbBTQx0bg4VBX7ChcqfqIRAQxkV0g5Rigtm0E2atq
         U7YeCoRJB561XTkxg2FkKt2cW99wMVTmyuj26KjDxG7xpqcfxvrGkZB0O92OBIAIuJ
         7Lef1zmon34ViPYTECM21YRVNdoUeuJgHpPL2uciw11eC0FMzKWnQc5qwRRH7lnb41
         HJ7CIWqUWqt5w==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ye Bin <yebin10@huawei.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: Intel: KMB: Constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:52 +0100
Message-Id: <161798344184.47643.15716261435220368367.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062653.803478-1-yebin10@huawei.com>
References: <20210408062653.803478-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:53 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: KMB: Constify static struct snd_soc_dai_ops
      commit: a457dd92d14acdf3dd64285f04ed9225d14d195a

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

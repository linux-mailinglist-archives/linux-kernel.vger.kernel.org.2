Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE535A324
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhDIQY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234206AbhDIQYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF5706103E;
        Fri,  9 Apr 2021 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985437;
        bh=jcbldu1ul/VSB6rFr22ct4ta75KZy0CatcE5UZRDVNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwCY2e7jrzOrOj0FmSBD7ue82mDVIioekQ+M+OsspYTSXtzB/pzt2S/xwfPSz8LsY
         FUkxc/1vvPOhs6KZUs8QUVzSLdIo0d2K7fjjS/WlrzkmkH5xwKRBVxsMh+c5vZ0LnF
         InVGuJ/emFvUhfLyjv9bugjrEaure40WnQlBb0FTN/fD/4Pb9MfBO/nq8hc0pQwxda
         2hBOcCDCW8We/yr4VwKaGHc7NwjleFZIsjFfF4DHk9MQpGt7SYDl7nuIlI5D1mcREj
         C8noYCQiiez5SXAzUST2+Gqzi7gyc1e2g4y3XpGBjUxbvAISnaL8BGov9bXtEH7mIQ
         V0PNgACml9lqg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: codecs: lpass-tx-macro: constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:53 +0100
Message-Id: <161798344184.47643.3287951626356572940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062657.803668-1-yebin10@huawei.com>
References: <20210408062657.803668-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:57 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-tx-macro: constify static struct snd_soc_dai_ops
      commit: 81df40a0807fed36f0f1f1eaeef2a780773934c2

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4AD3575FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356340AbhDGU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356203AbhDGU1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:27:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACE3A6120E;
        Wed,  7 Apr 2021 20:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827214;
        bh=Ij6ZUSk87LHtlya9NtJcg/cBO4fTPWuZWYabbRGBlaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMnOe9US2i44gARrRrNjw8DCv9yqyqhT8fnNzMtwTvdsS0RS7kedGfcjX8SZ5/qOF
         1ZXE2iGQ95eThSpGG0IhVVULAd7fE++OoT14R57xo9zsn4KwY1zh2RgVk17xXzQMYA
         ifUbOhHUSJfc3oQ8dtKWAR1uZYtN6IL8XROfjMTM2RjcPPOKS6yhSmI6uLvbhrE611
         3ZZANeoNKtN1HeL7VHmkhGqprI9OZFMy7MTKz3hMLE/PLzbQT0pDK0QDsvMAG1PrZG
         ILrWt9/yzUwSDBF/KxkA7qUSho+UYIkIgBq5wg+dD0GFIshrmrEsKhejsjrjeWd6yh
         ZW7ndKiU7Xu2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Banajit Goswami <bgoswami@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>, Ye Bin <yebin10@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: codecs: lpass-va-macro: constify static struct snd_soc_dai_ops
Date:   Wed,  7 Apr 2021 21:26:22 +0100
Message-Id: <161782703230.42756.14460019912472316913.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407074218.3051979-1-yebin10@huawei.com>
References: <20210407074218.3051979-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 15:42:18 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-va-macro: constify static struct snd_soc_dai_ops
      commit: af4b54127b2b8a69f0f50e54cf099f26b82c9244

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

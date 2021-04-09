Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BE35A325
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhDIQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234209AbhDIQYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8690961105;
        Fri,  9 Apr 2021 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985440;
        bh=w+nXh2oIb5hqSWOu4tiw3dzfprfvGxaBt69rGr9Q1nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RR3U+UZjV5gSNpDog2Gi8Z0yHSEqRLYlja1j410PVpsAiWXU4xlMATHJn+o1s0BZ+
         wbblBgZYLWzTwHMIWrLzHFlmbIHH6UNLfYvO1pbopPOKNN94NnaJa+YUnJta0m4DUq
         zaHb6T3deeXoZsuXv/CeauII8jX+Kmq/dATfMJx6spN3GyiM5wfO2zJN11DHQFY6lc
         XAlvW+jv4XcUNGN1GU2dq3P64BQRyml7mwMiPHfJ1qbsnKLelntih+7pGJm+G2nSHr
         5ARrR+86GMO5ja7WlEA6reT96G00P+N2rGdvOx/5FuMwOyIRkb9+cUNGPhY7dhNSDD
         on/SPGtJIz7Mg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Colin Ian King <colin.king@canonical.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: codecs: lpass-rx-macro: constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:54 +0100
Message-Id: <161798344183.47643.18319707456149836234.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062650.803309-1-yebin10@huawei.com>
References: <20210408062650.803309-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:50 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: constify static struct snd_soc_dai_ops
      commit: 857b602a3424a7d9ef875f8f137ddcb68de41c6f

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

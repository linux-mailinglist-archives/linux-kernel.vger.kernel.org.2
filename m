Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002E33ACA9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhFRMK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhFRMK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:10:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F075613D5;
        Fri, 18 Jun 2021 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624018097;
        bh=W1o+CtHQ3nflhXuylff+5ooBPcB3nszbMcr8gK1ECAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9iObKIw/Y3iPA306gh7V3nqI+vPDwJ/Ehrti6IOl+5YqSETUEe0V1uzCG2FJC8ZO
         iGLQanQpsvwCxcYdZFjJsF9LxwCmuSOLQLmVCQwXJz8eG0jk1Og0jqA4s2+1wX1Q8l
         w3GlU+3fZmx9cxLccxxHTyliM4KTEZ9FV2YTTFanX6cMGAlJJuCnPgaWLhhZ3JwS9B
         Rh7hMkK6wEhA5ZSuC6IGL1GZDx7P7RtO4aQ2vrg+Ku+r6fm0QcDfiEb0tAsI9h3XiI
         6xuf34xU7Qn2RTYAeL4YRxVZvBIm9YUuyUmHb2fAedIECFk+ZY/NBA8jB+k6WHN602
         d0ufjkLi0ynTA==
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Chris Morgan <macromorgan@hotmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: rk817: Constify static struct snd_soc_dai_ops
Date:   Fri, 18 Jun 2021 13:07:53 +0100
Message-Id: <162401758813.52682.3182841658896977708.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210602113643.3037374-1-weiyongjun1@huawei.com>
References: <20210602113643.3037374-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 11:36:43 +0000, Wei Yongjun wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rk817: Constify static struct snd_soc_dai_ops
      commit: 45ce213392df07b9e2443666c0910e1617882cf3

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

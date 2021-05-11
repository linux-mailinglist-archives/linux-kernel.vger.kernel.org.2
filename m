Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5037A1E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhEKI3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230487AbhEKI3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25F4B61622;
        Tue, 11 May 2021 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721676;
        bh=eBWDJluRsgCeGLDxW3y4rXxNqKj35vzOmjiWuK+aSzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JpIaOKhCczlAl6rHb4epjZIWhn5KIZPAnA6vaFt2vznxIlKgA48nC7lQG7dqj3KHV
         AMU/bqvwla4tIXNYRMc81eCdYICHZ0pLVxRtYnHIIPuJA9O3Gwa0lWSpYFGaJWvy75
         C53CPUVnntNbEpfc6WUVBo47L3CbM1W9OlQXYlBDnS05LNQBZrRJAUvqqGg0xv6jyo
         aT21nOJUG7BUyEDzGeTGx6pQiOmyxgrvRqXUJJUAogSE69rIiQYHNmfIw05YXyazGy
         wmKt+pnmCIV1nkva3eI6YpO6ogqTQc70p0ml5PaHfrwu1Q6JC8NQpo6chRY4EqQ6Y8
         48H00vcwKOqbg==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: codecs: lpass-tx-macro: add missing MODULE_DEVICE_TABLE
Date:   Tue, 11 May 2021 09:25:54 +0100
Message-Id: <162072058170.33157.14915696599003634030.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210508031512.53783-1-cuibixuan@huawei.com>
References: <20210508031512.53783-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 11:15:12 +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-tx-macro: add missing MODULE_DEVICE_TABLE
      commit: 14c0c423746fe7232a093a68809a4bc6233eed60

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

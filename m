Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224F358A48
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhDHQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231954AbhDHQ4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:56:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B304D6113A;
        Thu,  8 Apr 2021 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900953;
        bh=WTipuoMATU6NrlSmPh5KhqY+0RI8kWx8hWcOv257h1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ml5N2Ih6e3hu4pqS3lIlqIBcMBhX6p2/Rnr6/wJGlakpAHlga+4QjbJTYTA6l2Zqz
         wmJa5OZcid2s+ZYtCEjFJ5sLdabMts+SK6zb3JPaTYB9SL/c3I0CI+SnjtH227PJPx
         Vt6AKCmwWqCm/HpoadBArCk3vEzjxLyxN2/oHVyZCCZ2cS/8S9VJmStSe3ZpwF963/
         ID6JTAaD2k6mcuXfqgb62k5XaUztcq8fruVouEx0vhxZc3cKkpHt3u7Kf5mSOSSqhj
         S69gmdBiqNW8t3APxNv+su+Kz90GU75Vszajam62uTYARPHqekjqsEQAJ71zFSo4xu
         k+EJKWM2x+w6g==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>, Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: rt1019: constify static struct snd_soc_dai_ops
Date:   Thu,  8 Apr 2021 17:54:46 +0100
Message-Id: <161790012552.16915.5460504766785424651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062701.803865-1-yebin10@huawei.com>
References: <20210408062701.803865-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:27:01 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1019: constify static struct snd_soc_dai_ops
      commit: 5e71e9c14db4e49cca56354c95ce10e0e00214d1

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

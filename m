Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2941443633F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJUNpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUNpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:45:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B3D96112D;
        Thu, 21 Oct 2021 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634823783;
        bh=M4F6Y2fqa1ub/BkynSNuVBd769HCJAtvmYbRbnkScfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/19NMdZz/wsZwLgxnIDyM7mqX3zHWSn/Ah1Dff7zME8n0ZiyyAKEeLREFSIogMBk
         M/z9g7jN81wDuYuPWUU9kDpQR/AFIDKKU9/Ro0SYqxY1EOs1/PjwuR7FVEZjbvFqSA
         MVxxo2Umg2YuVlpi5AUt1zsTT46zFNhFx8/fzveT28ZzU6GmG4ItxN8rqFSeMsiaSg
         nRO+Tjf8+Ev2DZDSvXZKMVT3xArcid4+f0M2QLCcD/1AC2IQ/Gs9f92irKkavSj3SB
         8hH+BLkxYihs8bZPYvHu+BoABwofxabldFXjS1cfkF0JZRirUoqRuA7Hm9P1vjP8Kr
         454YRBABYg7Pw==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] Revert "ASoC: rockchip: add config for rockchip dmaengine pcm register"
Date:   Thu, 21 Oct 2021 14:42:58 +0100
Message-Id: <163482376624.1547375.15550615168301470105.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1632792957-80428-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1632792957-80428-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 09:35:57 +0800, Sugar Zhang wrote:
> This reverts commit 75b31192fe6ad20b42276b20ee3bdf1493216d63.
> 
> The original purpose of customized pcm was to config prealloc buffer size
> flexibly. but, we can do the same thing by soc-generic-dmaengine-pcm.
> 
> And the generic one can generated the better config by querying DMA
> capabilities from dmaengine driver rather than the Hard-Coded one.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: rockchip: add config for rockchip dmaengine pcm register"
      commit: 5ba8ecf2272d34de9cd2271a0ac12f5f615ef7aa

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

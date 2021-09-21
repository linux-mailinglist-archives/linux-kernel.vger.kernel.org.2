Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B991B41362A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhIUP1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234045AbhIUP1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:27:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 471E5611C6;
        Tue, 21 Sep 2021 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632237961;
        bh=5mGV+nCp9l2zmcCGt8WiEpj+RJfDrXbHM11DF0P27xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zx7FtSy5mQEQnDq1Rg2VU1fb65Y1ouLG0i+J4T7X2VyjI9BxhPv2FbKA5OUItp81S
         3CF4NMi3X0/suvLs1T1paaR/Zsb/qi/IPItXNXjHZvrUyQwtWqwbLhnVv9VNuinh9O
         LZesLwzTETwFBUEmUlXnfJA4e6cjgfijMMAS7x7YcQwuzXe8kG91Avlkfsq6MYe10Y
         dFfVRrHquZg65TgGBFKVrYoqYQVvevbJoKeFagJFdnshKfFfzd22LP3xTC3dWr9pEi
         r77GUxIoWjAGjbIrOZO8kfhABqPJPekxvfl6cLBliFnLh6BQgrv+E8z/jVxdngDCdQ
         pPe2GYCCFFwZA==
From:   Mark Brown <broonie@kernel.org>
To:     Peter Rosin <peda@axentia.se>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kirill Marinushkin <kmarinushkin@birdec.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2 registers
Date:   Tue, 21 Sep 2021 16:25:09 +0100
Message-Id: <163223651319.32236.308889133436007639.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
References: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 16:49:39 +0200, Peter Rosin wrote:
> From 625f858894af2b7e547cc723b97361081438b123 Mon Sep 17 00:00:00 2001
> From: Peter Rosin <peda@axentia.se>
> 
> Commit 25d27c4f68d2 ("ASoC: pcm512x: Add support for more data formats")
> breaks the TSE-850 device, which is using a pcm5142 in I2S and
> CBM_CFS mode (maybe not relevant). Without this fix, the result
> is:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2 registers
      commit: 3f4b57ad07d9237acf1b8cff3f8bf530cacef87a

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

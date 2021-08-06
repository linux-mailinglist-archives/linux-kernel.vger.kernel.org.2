Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1D3E204E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 02:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhHFA4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 20:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhHFA4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 20:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F27561154;
        Fri,  6 Aug 2021 00:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628211383;
        bh=NGc/aeWRHl0yXsX3NxaKS5bqshbtpwJWMjuZn+arrpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=is155Ob5rt7FOkC4H6GZiOYklWUEZThFILyWLiWcwqMM9lopduau78x8fecSw2s9d
         r4zLNzUyQuZJWib0+D8OZbdj4dPDnooep7uBARzBcTNNllQzEui6GB/iaTVL+k4FSv
         MYKJvmFh5dP7eul87j4zMqM4MtwJZR+6VhklKLcl1OHLTHXbl3vYzK5HXX7wO5ushd
         Brwq6X/0J2ajcpy3C+m9aJzrTFSwl08BYGEsS6fm7R4vu6nw61qlhorU30C++JW1yH
         4LfaB2qb/SeN2yD2y5jzrnxlAQkmzvsc1mw973mzcMiPO6PVrmAxpFQrbnlz+WQwm7
         JndlM/M6TfrXQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] ASoC: cs42l42: PLL must be running when changing MCLK_SRC_SEL
Date:   Fri,  6 Aug 2021 01:56:07 +0100
Message-Id: <162821106646.20290.11625697110600114933.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2021 17:11:04 +0100, Richard Fitzgerald wrote:
> Both SCLK and PLL clocks must be running to drive the glitch-free mux
> behind MCLK_SRC_SEL and complete the switchover.
> 
> This patch moves the writing of MCLK_SRC_SEL to when the PLL is started
> and stopped, so that it only transitions while the PLL is running.
> The unconditional write MCLK_SRC_SEL=0 in cs42l42_mute_stream() is safe
> because if the PLL is not running MCLK_SRC_SEL is already 0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: cs42l42: PLL must be running when changing MCLK_SRC_SEL
      commit: f1040e86f83b0f7d5f45724500a6a441731ff4b7
[2/8] ASoC: cs42l42: Fix LRCLK frame start edge
      commit: 0c2f2ad4f16a58879463d0979a54293f8f296d6f
[3/8] ASoC: cs42l42: Constrain sample rate to prevent illegal SCLK
      commit: 3a5d89a9c6fe306d35dce4496abbb464c1454da0
[4/8] ASoC: cs42l42: Fix mono playback
      commit: e5ada3f6787a4d6234adc6f2f3ae35c6d5b71ba0
[5/8] ASoC: cs42l42: Add PLL configuration for 44.1kHz/16-bit
      commit: b962bae81fa40fcce7662edcb1e426fa37d32abb
[6/8] ASoC: cs42l42: Validate dai_set_sysclk() frequency
      commit: 24cdbb79bbfe690f7fe87507dd0489670eddb5b0
[7/8] ASoC: cs42l42: Assume 24-bit samples are in 32-bit slots
      commit: c76d572c1ec82e305c97219e28952966958bc31a
[8/8] ASoC: cs42l42: Update module authors
      commit: e2f6867299ac85ce227eee18be11ce2c4a568447

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17882332EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhCITIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231283AbhCITIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4B7F6523D;
        Tue,  9 Mar 2021 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316884;
        bh=4/ckH8xZoXSICajXB+7g+u4ZkL+N5xAUWPghH9G2ul8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q70v7PtOqj//DVDBeRJ9Q1n2HZsu981F7gXcvAoCcKgaoEmR2kapvcta+npqEOqvl
         KRT08jcUlAvkwCFiKmpHE04XpvUGnlGIv6MaTsiyA2rVOz/vTPamIV+k05P17uhTM6
         w2Sr0pZFuY+k7XhOOu9FYiP8bxAbpndmC5qb0zlq0LNLAd3/XavXlKNgSRNT68FOV4
         C/xhU44pbGN3wF7xfjB25/Ai4IWS4TTBrUUilRpTQLbhoWa4nC0m4cqcduKPCTYBWG
         LWKy6DjsXABhwJWthQEeb8laSwqYBG2TOzsVrZHMF2FfhDji2wiVjLq/x1+YrTNaOq
         Ffw1NJjJGGzDw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        James Schulman <james.schulman@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        David Rhodes <david.rhodes@cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
References: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v3 00/15] Report jack and button detection + Capture Support
Message-Id: <161531678409.49117.4460920508176091644.b4-ty@kernel.org>
Date:   Tue, 09 Mar 2021 19:06:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Mar 2021 18:55:38 +0000, Lucas Tanure wrote:
> Here is a patch series for reporting to user space jack and button events and
> add the support for Capture. With some cleanups and fixes along the way.
> 
> Regards,
> 
> Lucas Tanure
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[06/15] ASoC: cs42l42: Remove power if the driver is being removed
        commit: 0e992635233c909652b87f1a84775746e2780306
[07/15] ASoC: cs42l42: Disable regulators if probe fails
        commit: 384c0c11be3f4c4bd28196f97507788cc84dd5e1
[08/15] ASoC: cs42l42: Provide finer control on playback path
        commit: 48a679742612308b320f1ca89366ee7fde04f547
[09/15] ASoC: cs42l42: Set clock source for both ways of stream
        commit: f1fe73ce62864cb48e603d61a3936b475ba5bbef
[10/15] ASoC: cs42l42: Add Capture Support
        commit: a6ea36692a4846d9470bdeeb90081e1dc5144b95
[11/15] ASoC: cs42l42: Report jack and button detection
        commit: f3f6f77beaee1b955ea835358e4c3ab1bbb56927
[12/15] ASoC: cs42l42: Use bclk from hw_params if set_sysclk was not called
        commit: 8ecb782355f30cfb207bffd5d04c4c5f2ac98ae3
[13/15] ASoC: cs42l42: Wait at least 150us after writing SCLK_PRESENT
        commit: 43cb98d6ba84d8917f377b5720fb1451ce86de13
[14/15] ASoC: cs42l42: Only start PLL if it is needed
        commit: b5019672a0526a2e0de6843734d1b7687f138b02
[15/15] ASoC: cs42l42: Wait for PLL to lock before switching to it
        commit: 5974fb2911b92b1921ab4aa35aede7454d72052a

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B174598BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhKWAD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:03:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232460AbhKWADT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CC0A61002;
        Tue, 23 Nov 2021 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637625612;
        bh=OYnq4wrpACbNs7esyB7jfrW82zCFu1z13PhYloNHXac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JrjNEwl1LFCJDouVJWi/9E8aYBoMOy4OEIgefhQYYWtIQ2W6bc9aGVH8UoumkaDAp
         TyAEZ5K4iHetNaFOZDgAZl74vOYri4HA6lZFyvHqz4BzIaYKF/3Wunf0K5c+MhMwaZ
         7YxJq/prnq1ouOmbojfbwlu0Hi+clgdWyucBKBSFtNtr1OV2uGiYfdSiSTUEcAarDu
         6RV50PgabC8Lav8vzN4Nxkmc9LgkzzucpsgU5A/8OkMjWKaWzJ0o/7f/1serncIRl8
         EEpoNkYZx85uUagifg3Up7b+mJZtDI2diXWoxDrprZcVIDWn9gAs4Yg3vLUkrxWDZ9
         5POHuGg1O88VQ==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20211119124854.58939-1-rf@opensource.cirrus.com>
References: <20211119124854.58939-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Report initial jack state
Message-Id: <163762561074.2471742.11078502974656470664.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 00:00:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 12:48:54 +0000, Richard Fitzgerald wrote:
> When a jack handler is registered in cs42l42_set_jack() the
> initial state should be reported if an attached headphone/headset
> has already been detected.
> 
> The jack detect sequence takes around 1 second: typically long
> enough for the machine driver to probe and register the jack handler
> in time to receive the first report from the interrupt handler. So
> it is possible on some systems that the correct initial state was seen
> simply because of lucky timing. Modular builds were more likely to
> miss the reporting of the initial state.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Report initial jack state
      commit: fdd535283779ec9f9c35fda352585c629121214f

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4937A1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhEKI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhEKI3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EACA61184;
        Tue, 11 May 2021 08:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721679;
        bh=BK/eR3DMt5sJhPvChlL7VaAZjoGBISoyWz7S+2nPcuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifkXq+LGLV87NVybNWJDIyPk64lCKe8k+YdFFnMILVVqUUrKVJQnsMqyu66x3yUOk
         WTGXnrxIHuzaP4a18ybKzPg/vd9sCPI9AWfrSNzqmJWQ2VpjwiymD1Fml4eJ6PI1jT
         tIrUm6k+y0gZLE/27XGib4UG4XuuOuCd2Z9RgUhszz+yNdHkgYQ5r7gEd0Cx+raLyV
         S1/kDGvdJz4lGtdnPm7OZQxMw/YeTbzXrOrvqoj/yMEGzbVsokoMhb4XIb3jNp5orf
         b/bIf5CK20TQW4KYeDubrwZVX66DE7P8E/rCzwcMLFrZJShFmDxFxnFa54luiw/IQ0
         tupgmOW3cBPQg==
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Jairaj Arava <jairaj.arava@intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Shuming Fan <shumingf@realtek.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: rt5682: Disable irq on shutdown
Date:   Tue, 11 May 2021 09:25:55 +0100
Message-Id: <162072058170.33157.8040502886621667235.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210508075151.1626903-1-swboyd@chromium.org>
References: <20210508075151.1626903-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 00:51:50 -0700, Stephen Boyd wrote:
> We cancel the work queues, and reset the device on shutdown, but the irq
> isn't disabled so the work queues could be queued again. Let's disable
> the irq during shutdown so that we don't have to worry about this device
> trying to do anything anymore. This fixes a problem seen where the i2c
> bus is shutdown at reboot but this device irq still comes in and tries
> to make another i2c transaction when the bus doesn't work.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt5682: Disable irq on shutdown
      commit: 47bcb1c7108363418cd578283333d72e310dfeaa
[2/2] ASoC: rt5682: Implement remove callback
      commit: 87b42abae99d3d851aec64cd4d0f7def8113950e

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

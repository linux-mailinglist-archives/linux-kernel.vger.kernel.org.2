Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D151F43BA52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238549AbhJZTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:09:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238380AbhJZTJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84351610A4;
        Tue, 26 Oct 2021 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635275216;
        bh=Gk/E5pK7kTnAy9ngQOvmnvKRnxHL1Xj2ImsmZMQXr68=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=e54RXcWYoR6i1K/7TOTYwCjIjFo7TIBtXnUsM4ATboPpJBNNnr+VaBVYoJECPnkwg
         epNzwH5IMIVq9F/zSv620iGNRuqZ89TSbDYSG28IrO8OaDKU0F8IpzBVhny4OinQnP
         aAIv09q4WVDYMwGH39Rxhy+keJ0sSGB3hETkn8sIdKKTi1YGPp7kzAYIPNY+gKFL4a
         Pb0DR3Us5GfrofDfkFYS47sYzJEU8n92XqDH5wIkNIasXuXYafD7kmqHUfZcEO2ay9
         XS/Ics2mjOq06Ur0WJbCEgNtsIxdGAJCR/kuvEegpe+Uf43vSYhhP8JTKdxuVRCpz5
         n17A8c4KVzF9g==
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
In-Reply-To: <20211026125722.10220-1-rf@opensource.cirrus.com>
References: <20211026125722.10220-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs42l42: Fixes to power-down
Message-Id: <163527521527.2033755.16584543049697234503.b4-ty@kernel.org>
Date:   Tue, 26 Oct 2021 20:06:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 13:57:20 +0100, Richard Fitzgerald wrote:
> Driver probe and remove were inconsistent in what they did to power-down
> and neither did all steps. In addition to that, neither function
> prevented the interrupt handler from running during and after power-down.
> 
> Richard Fitzgerald (2):
>   ASoC: cs42l42: Reset and power-down on remove() and failed probe()
>   ASoC: cs42l42: free_irq() before powering-down on probe() fail
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs42l42: Reset and power-down on remove() and failed probe()
      commit: 6cb725b8a5cc7b9106d5d6dd5d2ca78c76913775
[2/2] ASoC: cs42l42: free_irq() before powering-down on probe() fail
      commit: a10148a8cf561d728c0f57994330b2da1df35577

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

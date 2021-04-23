Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BC3698D2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbhDWSHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWSHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 146D361207;
        Fri, 23 Apr 2021 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619201214;
        bh=YbpNM4K31aRIxPFNPRngdp3JX6jWNS9uIk3mzuvOktY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0BZfldW30deqp3hGXg+7p9+Yh8a6YdO/1DU8oLuxXyWgo+Ow8JjoFJPqrubfoxAc
         NGnk77goO6zxn3GXVep8RsuKtB5X1EdKMz6OvpuB/iCtJZjvz9h5JNpniKLcETtfPu
         p9Gaxj7hs76PgsZ/wDY7AKdTGipH6dInzCAKFS0zLoTfmMSmHAVl9hA4om3SuiEhng
         sZ0o9Fi6GwO1R9k8WG/Uo4B79daggxHsvycOpEDO/CE4tVqdBO/NwbKdsV/Bu6k1OV
         h7o7zeAs6z4jiv5e+OJFyZzWVMjX6lKRNPTRSjRvgVrppjyNLII22iDSYGFxjM9H1t
         OshMkoS6TG8IA==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ASoC: clock provider clean-up
Date:   Fri, 23 Apr 2021 19:06:18 +0100
Message-Id: <161920094855.15254.10977006167383713745.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 14:05:07 +0200, Jerome Brunet wrote:
> The purpose of this patchset it remove the use the clk member of
> 'struct clk_hw' in ASoC. 'struct clk' is a per-user reference to an actual
> clock. In the future, the clk member in 'struct clk_hw' may go away.
> 
> The usage of this member by a clock provider usually falls into either of
> following categories:
> * Mis-usage of the clock consumer API by a clock provider.
> * Clock provider also being a user of its own clocks. In this case the
> provider should request a 'struct clk' through the appropriate API
> instead of poking in 'struct clk_hw' internals.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: stm32: properly get clk from the provider
      commit: 65d1cce726d4912793d0a84c55ecdb0ef5832130
[2/5] ASoC: wcd934x: use the clock provider API
      commit: 104c3a9ed07411288efcd34f08a577df318aafc0
[3/5] ASoC: rt5682: clock driver must use the clock provider API
      commit: 8691743c511d6f92d7647d78ea1e5f5ef69937b1
[4/5] ASoC: lpass: use the clock provider API
      commit: 27dc72b44e85997dfd5f3b120e5ec847c43c272a
[5/5] ASoC: da7219: properly get clk from the provider
      commit: 12f8127fe9e6154dd4197df97e44f3fd67583071

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

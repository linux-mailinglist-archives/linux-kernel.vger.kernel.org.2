Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B276B40047D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbhICSF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229929AbhICSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54E91610A1;
        Fri,  3 Sep 2021 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630692295;
        bh=AYCTypw36ptHgabLcJlokFD5oklyEoCNON6TkiELR0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lk9RGXY9AVswYmZWtt1rE1/CavCQsvnNbMv2JGR71HazCSpK4RiR0+haWbqts9/D1
         LO7x2ocAa8NFCqGVcy8WNXRs4q+vF4tB6DOzUhT7e1pPRKCnmdDhNo44WgYPyGowvA
         md5bT1JflLrXWSLUOBJ1vGD/21QUtrd7Cc2hKdet7pTvzhT7Hu87DBjaIgFOk9YKU+
         tslioRp3Kd/ws5LH/SvYxfcWmH2I5k6EMLDNz5YwHlVs0vn4bQelO8W5FKuKzCS/8j
         ki7168sdJs86xPhj/sWdICaLo7VSDwqupNWXrNknBvJawC3UnXqufthq4KV6HeY73X
         ybTNrX1qPjUZg==
From:   Mark Brown <broonie@kernel.org>
To:     Sugar Zhang <sugar.zhang@rock-chips.com>, heiko@sntech.de
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3] ASoC: rockchip: i2s: Fix concurrency between tx/rx
Date:   Fri,  3 Sep 2021 19:04:19 +0100
Message-Id: <163069197835.35101.4150427867250097515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630674434-650-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1630674434-650-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2021 21:07:14 +0800, Sugar Zhang wrote:
> This patch adds lock to fix comcurrency between tx/rx
> to fix 'rockchip-i2s ff070000.i2s; fail to clear'
> 
> Considering the situation;
> 
>        tx stream              rx stream
>            |                      |
>            |                   disable
>          enable                   |
>            |                    reset
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s: Fix concurrency between tx/rx
      commit: fcb958ee8e832e9cdf43408535207e15f14af755

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

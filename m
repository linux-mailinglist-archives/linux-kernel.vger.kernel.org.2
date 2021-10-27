Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC343CFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhJ0Rbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243248AbhJ0Rbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:31:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77B9E60E78;
        Wed, 27 Oct 2021 17:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635355751;
        bh=ktlPmVCSuV7Ef/nALqcRLnbx6/f5ml2xH/fYWgAsxJc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pL0ARhvIuTDpnZzTHvC37mnkGGdIh6TCsLk9wndwACPfzHaIB2ZwjWFPuOZdQeW7S
         K2bSQzhP+yF/71gLYN3IYgJ0Un1DU4U5F3sx3Bzafrm8YuXEUyuTkZdXQa0Sll8AYk
         NuzSIJlpZqQFUo3R8ES7+wNZGlMvKJhhXMZxBX2ICwqkcMi8RJP1bSYn+PEfitmcCW
         Q71efwCnNZzfO8vL8tH34Fkt1Pvx2sWc7rNKaeOlNcNjtFBymz6CNbVaaBK3y8TwYK
         p+WSJ0rNsiCaE5UHvmQQg5ovJLgn8OZhfgTOuWMJsYgs7vD+exLf+r36YK70xsX8vG
         pWMq+MWdzp+JA==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, oder_chiou@realtek.com
Cc:     perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211026081030.422481-1-angelogioacchino.delregno@collabora.com>
References: <20211026081030.422481-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: rt5682-i2c: Use devm_clk_get_optional for optional clock
Message-Id: <163535575023.4012075.17015997876203514512.b4-ty@kernel.org>
Date:   Wed, 27 Oct 2021 18:29:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 10:10:30 +0200, AngeloGioacchino Del Regno wrote:
> The mclk clock is optional, but it's currently using devm_clk_get:
> simplify the handling by using devm_clk_get_optional instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682-i2c: Use devm_clk_get_optional for optional clock
      commit: 709d297503e64ec3804b3b8150628656db164d4b

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

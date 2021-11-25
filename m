Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505E345DB4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355471AbhKYNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348335AbhKYNkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6CD6109D;
        Thu, 25 Nov 2021 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637847423;
        bh=B1iBf1QPUALSQQKiuuX3NST4yrrSJuif87J5949d9G0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NHKMBCqhpUQzYWt6Yk+i5Yatrz8lrc1N6FV9SoJPRtOz1NlFG59UFGMMvGrd5RXvo
         XMnFnOfypyogSMUpLxvW2uTQQr/xMK5oc1+TmUdY5brHhhT3+GQ7S42tmAnZbCBZO9
         9PDHxyQV+clYZQUy40CsOy5sYiSgYaS9RdilQn8kIqxjvDAiys5XXxYf8FlEzue4qB
         Ke5ZamvTqBoGvvB8wHdb+s2Di8xbDc0ew35t/f6h1qtVU2OBkHaa4N3XqwrYMg5ME6
         zR6BiJPPo12GqFYZczjAwe61ya381hNf4YY0AZ2xp+RS050EFa76rJkTP0V2lJwe0k
         nfg7hh0eBWqgw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
References: <20211125095158.8394-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 0/2] Kconfig symbol clean-up for sound
Message-Id: <163784742137.3101847.1051508589113120656.b4-ty@kernel.org>
Date:   Thu, 25 Nov 2021 13:37:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 10:51:56 +0100, Lukas Bulwahn wrote:
> The script ./scripts/checkkconfigsymbols.py warns on invalid references to
> Kconfig symbols (often, minor typos, name confusions or outdated references).
> This is a patch series addressing the issues reported by
> ./scripts/checkkconfigsymbols.py in the ./sound/ directory for Kconfig files,
> quickly filtered down with:
> 
>   ./scripts/checkkconfigsymbols.py | grep "sound.*Kconfig" -B 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: uniphier: drop selecting non-existing SND_SOC_UNIPHIER_AIO_DMA
      commit: 49f893253ab43566e34332a969324531fea463f6
[2/2] ASoC: codecs: wcd938x: add SND_SOC_WCD938_SDW to codec list instead
      commit: 2039cc1da4bee1fd0df644e26b28ed769cd32a81

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

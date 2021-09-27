Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0816D419D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhI0RtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237645AbhI0Rst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE73560F44;
        Mon, 27 Sep 2021 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764831;
        bh=i7blgZyfS+mFt4Ld57udc69/YXBlJ3xJDR6msSxUss0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvEZzOqgxcVKBWCu+ZsDamv8nRi+d3PdzasFCR5Fo3wyJWYJheVfUXyL2KQT/9mCY
         lRVdJPkfOdW0GgNVnG68B3kxp8DULCEqhdCH9SBwwsEf3+0/JilAK+mF4aBV7mElzY
         Gsp0EffL0o0xGoU0sUfaKdvHN5hURWuHe/RVqi2LlBT+652j331D28NY2EPfuppSam
         Tf37q2rJZ3OVldRK0j8GTsBs01Ds6v2SgSX5bvZBSvNyhpGAV7NCz+ECJoffrVKsmb
         NO4v9uUyvYnfaaSoMWEK8HjjNdjc11o0BtIBTmDSuNOUiZqfaF51BCJ+0bULL5cNcY
         gKN6qgL+IBi+g==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: samsung: add missing "fallthrough;"
Date:   Mon, 27 Sep 2021 18:45:26 +0100
Message-Id: <163276442024.18200.3747071344382107374.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927095449.1070639-1-arnd@kernel.org>
References: <20210927095449.1070639-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 11:54:34 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc, we get a warning in this file:
> 
> In file included from include/linux/io.h:13,
>                  from sound/soc/samsung/s3c-i2s-v2.c:16:
> sound/soc/samsung/s3c-i2s-v2.c: In function 's3c2412_i2s_trigger':
> arch/arm/include/asm/io.h:92:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>  #define __raw_writel __raw_writel
>                       ^
> arch/arm/include/asm/io.h:299:29: note: in expansion of macro '__raw_writel'
>  #define writel_relaxed(v,c) __raw_writel((__force u32) cpu_to_le32(v),c)
>                              ^~~~~~~~~~~~
> arch/arm/include/asm/io.h:307:36: note: in expansion of macro 'writel_relaxed'
>  #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
>                                     ^~~~~~~~~~~~~~
> sound/soc/samsung/s3c-i2s-v2.c:398:3: note: in expansion of macro 'writel'
>    writel(0x0, i2s->regs + S3C2412_IISFIC);
>    ^~~~~~
> sound/soc/samsung/s3c-i2s-v2.c:400:2: note: here
>   case SNDRV_PCM_TRIGGER_RESUME:
>   ^~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: add missing "fallthrough;"
      commit: 501849d97e532ca77371498e5a1b1881aab2e6d2

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

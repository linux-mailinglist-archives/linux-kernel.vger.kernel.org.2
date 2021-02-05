Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2945A31124B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhBESjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232758AbhBEPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:08:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33D8064E41;
        Fri,  5 Feb 2021 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612543490;
        bh=PXiONkiHLFyycY0uLa3iLGkOkJkNgYGXd95uCU3KPkw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=d/emirZYV79/LFZ3gcUyV5l56jL3WETg3Tl0W4quAHJh6baGjqwHdUigr3RvkssZH
         7rRo6FTU+6yosPVjiSmbpm8FL8oBmgElYdmGmuZFRgnPXm6i8//rWwVhypXA3JKmcO
         O7ZS5z7EfOOO0QGYylkGCv4xQDyvsz1hylOMW1XSc1sf2r6Q8+NAMLGKWrOiAoEt/Z
         En8YP9+vOpYDBoye/bsuuNPQHN/wGrGCM3JfqhN7+SSXu9Wn5BVTBwyt2h20lJ+YMw
         fwRyeHwERI/4RHORm7R4JYB5loFa+XrnhHiOv7/2chbT1vJm9SmJSaDVLc292zgxH9
         V72ed8/lbTvpA==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20210205104404.18786-1-olivier.moysan@foss.st.com>
References: <20210205104404.18786-1-olivier.moysan@foss.st.com>
Subject: Re: [RESEND PATCH 0/2] ASoC: stm32: i2s: add master clock provider
Message-Id: <161254344059.9495.3602816971823494322.b4-ty@kernel.org>
Date:   Fri, 05 Feb 2021 16:44:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 11:44:02 +0100, Olivier Moysan wrote:
> Add master clock generation support in STM32 I2S driver.
> Resend of patch https://lkml.org/lkml/2020/9/11/264
> 
> Olivier Moysan (2):
>   ASoC: dt-bindings: add mclk provider support to stm32 i2s
>   ASoC: stm32: i2s: add master clock provider
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: add mclk provider support to stm32 i2s
      commit: df91785a22e2505d2ac668f1d3e6b6e6d8ba627a
[2/2] ASoC: stm32: i2s: add master clock provider
      commit: 8a262e614ef8675cfde924c6ddf873a95db0be6a

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

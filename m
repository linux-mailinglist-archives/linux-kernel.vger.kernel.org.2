Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59404598BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhKWAD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhKWADR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:03:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E448660E08;
        Tue, 23 Nov 2021 00:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637625610;
        bh=vxGV5wzjy0QQFIApAyOfWagXPSDG+s+TC+Gf6T38UHo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iMHjChp/FsrwxsNjV9fA8FujPkuw61bjwbP/rc44PNuYuui1XSmiKtVsKiVnsrBPF
         LN/mxz0WRpIYj74g2imnUlPHoQ0wE9dq3+6d2YOXIBnKFIn8Cur8YXC/kxlQY4C4zH
         Hp/QuS1cBdPCIMZ+YcNZ3gR1FZEtdwSH/UDMbjDBFanJZn6Ur0DYre3zxJbp733zyJ
         LYNHT4jKe/+VZzdagCP98b5kXeyAgQdWLzk/W3L9PftwuQQeGcljwJf/blP2EMpZ20
         FXMBFN75M0TcSST6ldN1PBc7z3JG0GQbEAZdPz3Sqc9YeDYdmjdPmgUUTR3Xm50mmr
         jVSCuWGlwrLHQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211119104752.13564-1-olivier.moysan@foss.st.com>
References: <20211119104752.13564-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 0/3] ASoC: stm32: add pm runtime support
Message-Id: <163762560655.2471742.5896666264679935449.b4-ty@kernel.org>
Date:   Tue, 23 Nov 2021 00:00:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 11:47:49 +0100, Olivier Moysan wrote:
> Enable support of pm runtime on STM32 SPDIFRX, I2S and DFSDM drivers
> to allow power state monitoring.
> 
> Changes in v2:
> - Move pm runtime enabling before component registration
> 
> Olivier Moysan (3):
>   ASoC: stm32: i2s: add pm_runtime support
>   ASoC: stm32: dfsdm: add pm_runtime support for audio
>   ASoC: stm32: spdifrx: add pm_runtime support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: stm32: i2s: add pm_runtime support
      commit: 32a956a1fadfd7d3924ab8ada2b7754054375903
[2/3] ASoC: stm32: dfsdm: add pm_runtime support for audio
      commit: 98e500a12f934531b0d44eac6bc53c3d4b66aa74
[3/3] ASoC: stm32: spdifrx: add pm_runtime support
      commit: ac5e3efd55868d8c12a178123b24616a22db274d

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DEF43CFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbhJ0RcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243281AbhJ0Rbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15776610C7;
        Wed, 27 Oct 2021 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635355763;
        bh=Dmy2eSxMesrXx3Kt54NoJu+ASFtTZgXO7s9XqZs9lFc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=utolcpQ85h/f5oh9Q/bK6syRgpbaiVM1k/d8JoOYChk/iV5EtxKi/VoTkyQHVofY7
         zUGNW4xjtV3/NOI4OLZZP8tc6YGrPPhNevb7Bxj2bCBa8FHwVjpjRHItgc6hMuI0pZ
         HPT1EVUZi7W8AJ3E3d0g2CU+2QXZfLBO3teKKd2FMWf1aAn18DcjeOD2gzKD4f9Oz5
         JvwdyhUuzb4nmuc2arTmGhtz/j7FvxyzSxWrV0K2imoqDj3Xw+try+HoLD5gfUI4UW
         TLCjCGpKlKUARHf0IOpHlaCEegIFHLfoXecoeH4PQuaDRQPACRpi1a95MWtedMlPTy
         kuit7R26ABYDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20211027082359.52248-1-arnd@kernel.org>
References: <20211027082359.52248-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: fix Kconfig dependencies
Message-Id: <163535576182.4012075.12901832843673816206.b4-ty@kernel.org>
Date:   Wed, 27 Oct 2021 18:29:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 10:23:46 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The CONFIG_SND_SOC_AMD_MACH_COMMON has some dependencies that
> are not checked by the symbols that select it:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_AMD_MACH_COMMON
>   Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && X86 && PCI [=y] && I2C [=n]
>   Selected by [m]:
>   - SND_SOC_AMD_LEGACY_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]
>   - SND_SOC_AMD_SOF_MACH [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: fix Kconfig dependencies
      commit: 1dcc81d95b910dc404c40ff6101bfa2520a3528e

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

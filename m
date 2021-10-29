Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F0C43FED8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJ2PBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 11:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhJ2PBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 11:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AFE2611C0;
        Fri, 29 Oct 2021 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635519547;
        bh=aqiYC5SqrqytOj3AgJ9i+2U0QKUjvkgIjN3Y+G2zp3A=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lOiso3Mc4EaInjABzt9DG0g8lR9/E26BTzW8oRPXFOFQ1beEYsiAJjrk/hvbdc0yB
         u588CF2o4dOTAVaCktSPKPgJD3Y8R6vpIkc+L+F7kznK5/erS2m/esDqihHE/Q81wg
         56HE97RUgltKGpjCKWrTeyU0vKqaEfSL58voMbKEoC9ZS0agJhOO23hoXu4v5cmgCT
         HH4Zn56gfF9a0Z8I1E0ZGpC/mS9tFSErkq/TVCMtjOU2nRV0KvE7AJ/IwPCqsUvMe/
         sa0zOtiuxelFGe8/t8v8db79ooRc/PR1FrAdN2cRE2kQdWclwdr1wFjBJTuOxLfWsf
         DgbCpwUKoz5ug==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211029113714.966823-1-arnd@kernel.org>
References: <20211029113714.966823-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: select CONFIG_SND_SOC_ACPI
Message-Id: <163551954530.3555751.17998419560489976285.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 15:59:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 13:36:57 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The acp-platform driver now needs the ACPI helpers:
> 
> ld.lld: error: undefined symbol: snd_soc_acpi_find_machine
> >>> referenced by acp-platform.c
> >>>               soc/amd/acp/acp-platform.o:(acp_machine_select) in archive sound/built-in.a
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: select CONFIG_SND_SOC_ACPI
      commit: 62a30322607f120e10ea1a7d07895b5af8049baa

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

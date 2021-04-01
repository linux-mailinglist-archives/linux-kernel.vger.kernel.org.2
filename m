Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC3735133B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhDAKSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 06:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234118AbhDAKRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0854760FDB;
        Thu,  1 Apr 2021 10:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617272256;
        bh=ZQB78LoEvtSJ6bAk5tLTTxBT61Bb1G/Pcw/GzzVtKvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HND/C+0U9HFYenqxV4m+Yz3KZ1wtQR3UYIOQJ5k3Rdt4y8flfxttd/CUegJeYW3Ib
         2VOglQ+6BEMaWNFef6UiE+5WAu0jI/K50JOoxqzr4/TAnQq3Zw9QRB4ZJ4zfwJzxgu
         Ewqdvyb9DrtKOcmCWpC70tjvhYTk+rskcwpd/uOUwxhnr2uOpEP8ad8vyoK3+OFhFV
         P9WeXMn3c9lArYrO9fLdGucReh+9E/hTuZvb1QMpxux384i+WCvbRSyRviwzC0MFdc
         sZHpMoS3bCBh+BVYWlS0mNf7EwBhKgAs8XjMfCK355oG2JqWAKl6ztbQtxKdwGPIF+
         +nXxY7tlB4Elg==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, tiwai@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] ASoC: remove cppcheck warnings for multiple SOCs
Date:   Thu,  1 Apr 2021 11:16:30 +0100
Message-Id: <161726938995.2219.14402744690794554116.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 16:59:10 -0500, Pierre-Louis Bossart wrote:
> Trivial cleanups to make cppcheck less verbose.
> 
> There should be no functionality change, except for the 'sti_uniperif'
> patch where an error check was added.
> 
> Pierre-Louis Bossart (17):
>   ASoC: amd: renoir: acp3x-pdm-dma: remove unnecessary assignments
>   ASoC: atmel: fix shadowed variable
>   ASoC: atmel: atmel-i2s: remove useless initialization
>   ASoC: bcm: cygnus_ssp: remove useless initialization
>   ASoC: meson: axg-tdmin: remove useless assignment
>   ASoC: meson: axg-tdmout: remove useless assignment
>   ASoC: pxa: remove useless assignment
>   ASoC: sti: sti_uniperif: add missing error check
>   ASoC: sti: uniperif: align function prototypes
>   ASoC: stm: stm32_adfsdm: fix snprintf format string
>   ASoC: sunxi: sun8i-codec: clarify expression
>   ASoC: tegra: tegra20_das: clarify expression
>   ASoC: tegra: tegra20_das: align function prototypes
>   ASoC: ti: omap-abe-twl6040: remove useless assignment
>   ASoC: ti: omap-mcsp: remove duplicate test
>   ASoC: ux500: mop500: rename shadowing variable
>   ASoC: ux500: mop500: align function prototype
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/17] ASoC: amd: renoir: acp3x-pdm-dma: remove unnecessary assignments
        commit: 2711a2d993036f26837e459ffb7b0d45c36b92a2
[02/17] ASoC: atmel: fix shadowed variable
        commit: 86f3c05534bed54342ef6912b9da1d75f6b8d902
[03/17] ASoC: atmel: atmel-i2s: remove useless initialization
        commit: 6692dc07fa113939fc2c15d58dc3b27e28fc767c
[04/17] ASoC: bcm: cygnus_ssp: remove useless initialization
        commit: ce36242046f272c7656f7b4c91ff7b4387f514b0
[05/17] ASoC: meson: axg-tdmin: remove useless assignment
        commit: 84d0493f67b856e5909c18e15b7ce78391565057
[06/17] ASoC: meson: axg-tdmout: remove useless assignment
        commit: 18efddee4f0a8820a4ba0215655bbafd479025bf
[07/17] ASoC: pxa: remove useless assignment
        commit: 00a25480cca4a094765084964c753c8f28e0f6fd
[08/17] ASoC: sti: sti_uniperif: add missing error check
        commit: bf2a6b44d5e56a12dde6438a2d092475e54d1923
[09/17] ASoC: sti: uniperif: align function prototypes
        commit: 00a820086ddd8c6f3eeeca3a034d234cebf084ba
[10/17] ASoC: stm: stm32_adfsdm: fix snprintf format string
        commit: 11033e51b31696fd7949f1abb558cba171ecf0f5
[11/17] ASoC: sunxi: sun8i-codec: clarify expression
        commit: 54f78aebe803b12e06d49988be88d87823ca16ab
[12/17] ASoC: tegra: tegra20_das: clarify expression
        commit: 1bc6d7a90b01e30123578761f5e70548ad894445
[13/17] ASoC: tegra: tegra20_das: align function prototypes
        commit: 53567ebce407639e3657b5c232bd60970a66f82c
[14/17] ASoC: ti: omap-abe-twl6040: remove useless assignment
        commit: 248d4dc9c3b8ced2cb274581d1c306e7ec617aec
[15/17] ASoC: ti: omap-mcsp: remove duplicate test
        commit: 3d37b27fffb311c521d61144e57ea4d40e31ab9b
[16/17] ASoC: ux500: mop500: rename shadowing variable
        commit: 5b920abeea03302e561b036181a6a5be4e53a584
[17/17] ASoC: ux500: mop500: align function prototype
        commit: b4d09a01666fdcab8866f44b72f79e106f14a48d

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

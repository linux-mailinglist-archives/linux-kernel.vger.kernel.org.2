Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF71345508A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241337AbhKQWei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:34:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241348AbhKQWea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FC9C61B5F;
        Wed, 17 Nov 2021 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188291;
        bh=0EBn4iFas/lVt0Plr8qx6oSNvIZ4IcS+xI8hMFa4Mu8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i93whKvlivBz1M3F37Lm2fKtFcC/L3usl/3SoZR5qIISZp0IZLXlSVwKP5U69V7vt
         9Fnrim3Io2Ri3J8PgEAaGY+kz1egw3swHcvZ29vzLK39OrA6mMvEPUS+8M2/aoU5KD
         SbQD1kCbxMJ75FxITmFrng+GoxCslLNJmKooNzN65+xIIetVPA8bIh3jCGZbX9MKfV
         Sc0Oa3PLP0Fb112VxoTS+vNhhhq0MPTlsSR8bSKme7h+XLMyk1LcN7mXngoLaWeAXb
         FHOktjxeBs162nyB1EqA0UvMnm7v9WD3NUDqn69c/bZV2r7Ewla0ZJE+TJlHkmLl+T
         rnzIbUfAiwtgA==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        daniel.baluta@gmail.com, lgirdwood@gmail.com, yc.hung@mediatek.com,
        AjitKumar.Pandey@amd.com, daniel.baluta@nxp.com,
        pierre-louis.bossart@linux.intel.com, Balakishore.pati@amd.com,
        vishnuvardhanrao.ravulapati@amd.com, vsreddy@amd.com,
        Julian.Schroeder@amd.com
In-Reply-To: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 00/21] ASoC: SOF: Platform updates for AMD and Mediatek
Message-Id: <163718828906.136850.1487051712790530066.b4-ty@kernel.org>
Date:   Wed, 17 Nov 2021 22:31:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 11:37:13 +0200, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> This patchseries adds Renoir ACP HW support and Mediatek MT8195
> platform.
> 
> Notes:
> - I first send the meditatek support in a previous emails but it failed
>   to apply because there are some dependencies on AMD patches related to
>   DAI ids.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/21] ASoC: SOF: amd: Add Renoir ACP HW support
        commit: 846aef1d7cc05651e27c17c3b4e2b5ce5cdec97b
[02/21] ASoC: SOF: amd: Add helper callbacks for ACP's DMA configuration
        commit: 0e44572a28a49109eae23af1545c658b86c4bf00
[03/21] ASoC: SOF: amd: Add fw loader and renoir dsp ops to load firmware
        commit: 7e51a9e38ab204eba2844b8773486392d7444435
[04/21] ASoC: SOF: amd: Add IPC support for ACP IP block
        commit: 738a2b5e2cc9fd63d48faac11c8d60a5a2313a9d
[05/21] ASoC: SOF: amd: Add dai driver dsp ops callback for Renoir
        commit: bda93076d184ad80a8cab09bf29ace7692de18f7
[06/21] ASoC: SOF: amd: Add PCM stream callback for Renoir dai's
        commit: e8afccf8fb75bae9c3292a0e51593af92839415e
[07/21] ASoC: amd: Add module to determine ACP configuration
        commit: f1bdd8d385a803565024c8feeedc17bf86aac4f5
[08/21] ASoC: SOF: amd: Add machine driver dsp ops for Renoir platform
        commit: 11ddd4e371810017faf7ff7cb2349f321e50d1d3
[09/21] ASoC: SOF: amd: Add Renoir PCI driver interface
        commit: ec25a3b14261fcb05568a1fec15ca68152e9d208
[10/21] ASoC: amd: acp-config: Remove legacy acpi based machine struct
        commit: 63fba90fc88b6cee9f8bead761a419169ecda6cc
[11/21] ASoC: SOF: topology: Add support for AMD ACP DAIs
        commit: efb931cdc4b94a0f7ed17a76844f08cef1bdffe5
[12/21] ASoC: SOF: amd: Add trace logger support
        commit: 4627421fb883928af5220c66a304bed1f9b77e8d
[13/21] ASoC: SOF: amd: Add support for SOF firmware authentication
        commit: f063eba3e7a6aeec8e2abb00469e70c51432453b
[14/21] ASoC: SOF: mediatek: Add mt8195 hardware support
        (no commit info)
[15/21] ASoC: SOF: tokens: add token for Mediatek AFE
        (no commit info)
[16/21] ASoC: SOF: topology: Add support for Mediatek AFE DAI
        (no commit info)
[17/21] ASoC: SOF: mediatek: Add fw loader and mt8195 dsp ops to load firmware
        (no commit info)
[18/21] ASoC: SOF: Add mt8195 device descriptor
        (no commit info)
[19/21] ASoC: SOF: mediatek: Add dai driver dsp ops callback for mt8195
        (no commit info)
[20/21] ASoC: SOF: mediatek: Add mt8195 dsp clock support
        (no commit info)
[21/21] ASoC: SOF: mediatek: Add DSP system PM callback for mt8195
        (no commit info)

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

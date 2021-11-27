Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1338545FAFF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 02:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350441AbhK0Bfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 20:35:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55740 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351060AbhK0BdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 20:33:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53C0DB8299A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 01:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B005C53FC1;
        Sat, 27 Nov 2021 01:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637976590;
        bh=XJhSZlLuBETGQP56bfuntv9zCxe4SskI6kt8Sv9zIz4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GwxpOKUBOO74xMaGt/gvl4xWEfi8AEIsd4DBNQ1e2sFoTmFzprNsXZzE9t7+cJGoY
         kyq05Eew08WhVnE33IpSraXD2OjMZPL8YL066elgXldvyV/8x05yIsL1GUj7oCSvnk
         YfwOSl+mqhJPvHeco6gVG1GqK06s5PVAnHMX1HzvI8Fwlpjw+vc9hYBlRooOS22BqX
         LHzd3Jbm95KGZ2FxkCjPRy10uFhzFGa8WUT+eREkIGK2/+qFntpNmPk/6+OxuM8D+1
         xPipAkCNym9G2wHVIguMrNu7yGhZvNrmD5xxDI8mcZjx7w0Lz6mYUMTpWYojngPXpl
         0HwlBoTc9PS4w==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        YC Hung <yc.hung@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211123103013.73645-1-geert@linux-m68k.org>
References: <20211123103013.73645-1-geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: SOF: mediatek: Use %pR/%pa to print resources/physical addresses
Message-Id: <163797658773.2987942.13053830278646799334.b4-ty@kernel.org>
Date:   Sat, 27 Nov 2021 01:29:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 11:30:13 +0100, Geert Uytterhoeven wrote:
> On 32-bit with CONFIG_ARCH_DMA_ADDR_T_64BIT=n:
> 
>     sound/soc/sof/mediatek/mt8195/mt8195.c: In function ‘platform_parse_resource’:
>     sound/soc/sof/mediatek/mt8195/mt8195.c:51:15: error: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 4 has type ‘unsigned int’ [-Werror=format=]
>        51 |  dev_dbg(dev, "DMA pbase=0x%llx, size=0x%llx\n",
> 	  |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Use %pR/%pa to print resources/physical addresses
      commit: 4dcddadf5530a0da00e6b2eb8194297b49d33506

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

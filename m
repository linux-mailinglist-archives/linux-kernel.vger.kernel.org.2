Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81EB446977
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhKEUQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhKEUQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:16:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95DD56108F;
        Fri,  5 Nov 2021 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636143253;
        bh=BfJkmp/zQUz58AjoefSLkKZ/YEytniomZ7ATR4zR/dk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=neJH8bauoAdPDOcCsijwl4LUlljFlHGa6hlx/RGRvD81oLSiHUFYAYb8vR1GLk3oa
         gCI2fpW3IGK0SWqCXJQCRkBzlCLrWA3aERn39UuttW4lrbF4CTYtknU0hepaXmpT7O
         G40+YRqq6hbCO2fs49deGTimDZThoqK8b8Besbj5hIT4XTsvXUGA4yuOR0+d8iY+Gs
         c/UozEcRJK4ywA6hxN9yOdUmeLCsca924RYw9Y9Ip2jZsKsXoesK3ndna+tbdap32t
         90PjjJOhw2VwMP7M/mveTlZpdwTkKkQdoiR6MLiIGVsQe4JdsRmTGbnWwgJnRQe7s3
         x3wFHU6rYk7iw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, tiwai@suse.com,
        matthias.bgg@gmail.com, perex@perex.cz, kernel@collabora.com,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211105152013.75252-1-angelogioacchino.delregno@collabora.com>
References: <20211105152013.75252-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8173-rt5650: Rename Speaker control to Ext Spk
Message-Id: <163614325129.3446536.8434137401670448140.b4-ty@kernel.org>
Date:   Fri, 05 Nov 2021 20:14:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2021 16:20:13 +0100, AngeloGioacchino Del Regno wrote:
> Some RT5645 and RT5650 powered platforms are using "Ext Spk"
> instead of "Speaker", and this is also reflected in alsa-lib
> configurations for the generic RT5645 usecase manager configs.
> 
> Rename the "Speaker" control to "Ext Spk" in order to be able
> to make the userspace reuse/inherit the same configurations also
> for this machine, along with the others.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: mediatek: mt8173-rt5650: Rename Speaker control to Ext Spk
      commit: 0a8facac0d1e38dc8b86ade6d3f0d8b33dae7c58

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

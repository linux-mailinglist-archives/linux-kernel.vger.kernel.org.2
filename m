Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F48349848
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCYRho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhCYRh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B2E461A2C;
        Thu, 25 Mar 2021 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693847;
        bh=vhqgbXFhmrKfVpYNbmWIy+MRLeOTkYKmncyMmmdH2rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/TRij5Jd0h8R+vSJAunZT2jaPanu4ijRSgqrH6fCJHnLlKsdzTskNfi/a3LcQZZT
         nkvIoeTl5DVjddGsjY/oWvSMLdc45EKQdHcqaBjPmKRxaJqctAVXyKESjDC6oNbl0s
         ISfvtcUoPskRBGfkc4r+KuBfkAU+gJ10dEHUsMtq38o0/8lUFSTMESPYEiRhr+pRSx
         vY1tK1RW8u6CWGwYvoimRVWHC8quGXCg8nRv9YaahQlvi0cOY6QmkttQfG3ERqvsmM
         N5lJWAxPSzFei81xhlr5antnI4APUqEEMHWohFpkSjUyVvK7+Fi9PrHaJplSnyn+Sm
         VQzNdYmQuGmkQ==
From:   Mark Brown <broonie@kernel.org>
To:     ckeepax@opensource.cirrus.com, gustavoars@kernel.org,
        tiwai@suse.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, peter.ujfalusi@ti.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, daniel.baluta@nxp.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8960: Remove bitclk relax condition in wm8960_configure_sysclk
Date:   Thu, 25 Mar 2021 17:37:03 +0000
Message-Id: <161669370550.41585.9109635585401644966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614740862-30196-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614740862-30196-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021 11:07:42 +0800, Shengjiu Wang wrote:
> The call sequence in wm8960_configure_clocking is
> 
>    ret = wm8960_configure_sysclk();
>    if (ret >= 0)
>         goto configure_clock;
> 
>    ....
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8960: Remove bitclk relax condition in wm8960_configure_sysclk
      commit: 99067c07e8d877035f6249d194a317c78b7d052d

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

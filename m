Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CB3FE23D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 20:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbhIASQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 14:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344701AbhIASQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 14:16:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 139AE610CA;
        Wed,  1 Sep 2021 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630520135;
        bh=F3PsqF8kI1YopDkw1jrsG80A5fXXJVkd7n6uEtryW9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZgKgvjQxxELJfFRNv8ApXFEG4ksWKr9Tfr1mg9T5x3awqaB/7OTXIneqIer7IJrt
         BYg6f0CJAbffLI1fhSMN5dFH6YNjSnqrhPBetHlUjpqXls383MYDIMauBtnhMcz2YB
         V8iOEe1Tib8zZYZIvGJBTl6UYEpaKOgrB6L1dZaWFx9ukY2zz9XZOWhwP83Ygyni5x
         sLYnix6tC1keHVU/UKCj3ZZ1OWowQpbJHI+/M/RVmkGBTXGddFV+JpiMIbzP4J3kwI
         ZTgdisv9fetcQiNr39m4ZBVXn0uTTy+/LoP3LHQzwD3y9C18Tt4kCpuPvjismuEk+V
         ywQwwkHU6WOVQ==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, matthias.bgg@gmail.com,
        Trevor Wu <trevor.wu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: add MTK_PMIC_WRAP dependency
Date:   Wed,  1 Sep 2021 19:14:47 +0100
Message-Id: <163051912509.21630.1658074283329712845.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210831021303.5230-1-trevor.wu@mediatek.com>
References: <20210831021303.5230-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 10:13:03 +0800, Trevor Wu wrote:
> randconfig builds show the warning below,
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MT6359
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
>    Selected by [y]:
>    - SND_SOC_MT8195_MT6359_RT1019_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8195 [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: add MTK_PMIC_WRAP dependency
      commit: cd5e4efde23ad8050921672ed777ec3f7aa310ec

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

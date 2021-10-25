Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A716D439BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhJYQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234052AbhJYQmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:42:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C07660EB9;
        Mon, 25 Oct 2021 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635179993;
        bh=UVa8mcC1T1uq8wTq8Zf9Ga1vu6jyFkHWhopPaZoEcUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s02xi/8A6AwRVsntBYMQe1zS/U5Hkuap5wxkL1IlxU3PTlnK2rzVjWQMiFzK073nw
         GMIzZvQHcZZIqvO+0okNAig8sQHsYIGjlPCdUEsbp191/jGkiNqC1tlAuCuC5Co5p6
         CzXV3hKI2l8CPASfVAad6ylnoOHbP+9UxR+VHNDNAyiQBhGU9cClldHl27Ajzb3/E/
         9betUhY9j+5rBWixzoH5gqEzu8Psc4U33olRP1zCqpxGG3kR7Ag6+ngEsbEJXcVOUy
         yX5bfoGXje9boU6xNCH4LLfH/2gHXvYgTDyGQ5h3ONpXXLevNMIKY3a5fcdpLfFT0k
         YU6xPH647asrQ==
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        Julian Braha <julianbraha@gmail.com>, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        cezary.rojewski@intel.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: fix unmet dependency on GPIOLIB for SND_SOC_MAX98357A
Date:   Mon, 25 Oct 2021 17:39:27 +0100
Message-Id: <163517996155.3558038.1204649439375343197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211025010615.10070-1-julianbraha@gmail.com>
References: <20211025010615.10070-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2021 21:06:15 -0400, Julian Braha wrote:
> When SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is selected,
> and GPIOLIB is not selected, Kbuild gives the
> following warnings:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_INTEL_DA7219_MAX98357A_GENERIC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix unmet dependency on GPIOLIB for SND_SOC_MAX98357A
      commit: 3e701151feefc58c5194e1d9eb5af98568574f2d

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

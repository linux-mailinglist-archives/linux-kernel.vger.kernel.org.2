Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE243837A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 13:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJWLpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 07:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhJWLp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 07:45:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 173E860F46;
        Sat, 23 Oct 2021 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634989390;
        bh=Yvlt04UMZo9r9G03SEhseVvENp7wes7fQwwecv9UEPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtqYuzB10yjdrgBHxR1eky3iUFsvQBe5VmO0YSh6VagOql//MHx0LVaal0QdroL92
         mJ706Sv0mFheW9Kq/mkpbHGbMjdbcuh4rmp8N6XT+I7s4n457sRRYZZ8wA7n5Txovf
         Yn6rd0E7mW73K/xTDu7IWglpHDG7nMJvKfPizMXA2AbLjuI+X8znvVzsraDSjsAcy7
         9Ja7noE0ofJPwxpOSbZcT8fQKBinraa66fDhFTE37tmHNu123+H5EfV3N7Lmm0Nd2k
         K/76y+TG7vsbaashcBELDvx/Jk5mP9SdBaqJvErxlWA8VKTLtkRl6XhTgOwauPIxIS
         ef6AvYSTnzyBQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, ajitp@codeaurora.org,
        tiwai@suse.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz
Subject: Re: [PATCH] ASoC: fix unmet dependency on GPIOLIB
Date:   Sat, 23 Oct 2021 12:43:07 +0100
Message-Id: <163498938018.2020965.6267176645734620337.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010215627.17869-1-julianbraha@gmail.com>
References: <20211010215627.17869-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2021 17:56:27 -0400, Julian Braha wrote:
> When SND_SOC_SC7180 or SND_SOC_STORM is selected,
> and GPIOLIB is not selected, Kbuild gives the following
> warning:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_STORM [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y]
>   - SND_SOC_SC7180 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && I2C [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix unmet dependency on GPIOLIB
      commit: 6cace797f1a8d54ecb42a3d327cbc0b231114ed0

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

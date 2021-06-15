Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A563A8788
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhFORb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:31:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhFORbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:31:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C47E66140B;
        Tue, 15 Jun 2021 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778191;
        bh=38JelWkBVrb1iUB2+ACoZ3vPaIr4XdmxQrI+4XMqupc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJt1n0ls189Ad/QEKwY8yffRNrbFNvA299X0mCuS0dchWw3DEmzx4Tn5o8Vd1KZEV
         7AonNI8LZf4voHiR2PmQ5jaFHX6yc6Ger1stDvkPoDdi5iHFlt/uGKCyniGR084MgE
         IzFd5d6zpuqmXeG3iloKzWfmP1XOcvKjtxQQ7kvIEj+dx/MLO2o6i5bV3Y88NsNhio
         yRmny0UtHQRaPswoDSURxQxC6j+9KhWGnNmKXdPNJ+QSueKcQXugGP1OedZzzowFh4
         B7TcRCVgEE304oR4nvHRidUG/Uvu9xeB01t3oIk5EbrjNB3zjsjyKE59GfTJDU6D6O
         01p08OkPBBXEA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v2] ASoC: codecs: wcd938x: remove incorrect module interdependency
Date:   Tue, 15 Jun 2021 18:29:19 +0100
Message-Id: <162377763944.21612.1027421204392314156.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615132829.23067-1-srinivas.kandagatla@linaro.org>
References: <20210615132829.23067-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 14:28:29 +0100, Srinivas Kandagatla wrote:
> For some reason we ended up with cyclic dependency between snd_soc_wcd938x
> and snd_soc_wcd938x_sdw modules.
> 
> Remove this cyclic dependency by handling them in respective modules.
> Without this below error is reported during make modules_install
> 
> depmod: ERROR: Cycle detected: snd_soc_wcd938x -> snd_soc_wcd938x_sdw -> snd_soc_wcd938x
> depmod: ERROR: Found 2 modules in dependency cycles!

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: remove incorrect module interdependency
      commit: b90d9398d6ff6f518f352c39176450dbaf99e276

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

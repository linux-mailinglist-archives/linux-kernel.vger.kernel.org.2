Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CC3CB95C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhGPPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 11:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240478AbhGPPJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 11:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88528613F5;
        Fri, 16 Jul 2021 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626447973;
        bh=pP9BUA31T61wWw+G1Au+42OC05x0XKfLSbUqrMo7N2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AhDqSwbmZjBTJuBCh23mH4wu5DYeAU40mNh/94PoHaU3ek1MOxNQdQAvFtvc7eV16
         ikpEoJBllPUubZLm6ZQmXsibxOs0q4rsFrjoXxK4mbC3nUxWTZ4tHHrObcBoKqt4HV
         gQuKnmzpEq5e/UyGk2c6t6G0Wb1FZ2up1VerY5sQ5Baqag3OdZZVJKNWseNpFn0oaU
         ZN8KNW6FVp2dvHeESkwqOpbMueWOqxDvAhSa9SduotqiC8jWDguLcrGPEzkGv2mKft
         Z1qASaHAr3FmWHPjrsh1jGTAZPOBcBPfAehJiJv8J19Kbuj1bzL7J64Vk4vf2ZSeEt
         X9a4S3V9cGWJw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: codecs: wcd938x: remove unused port-map reference
Date:   Fri, 16 Jul 2021 16:05:29 +0100
Message-Id: <162644746764.25983.3659127858981239733.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210716105612.5284-1-srinivas.kandagatla@linaro.org>
References: <20210716105612.5284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:56:12 +0100, Srinivas Kandagatla wrote:
> port_map field was added prior to adding static port map support in soundwire.
> This makes port_map array in struct wcd938x_sdw_priv redundant and unused,
> so remove this.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: remove unused port-map reference
      commit: d9dbe1f9ae4b3463093fcf027d79f20bb9a337c8

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

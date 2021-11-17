Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B6A455086
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhKQWeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241339AbhKQWeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:34:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27DC861B51;
        Wed, 17 Nov 2021 22:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637188281;
        bh=uU2qHnUEljTCEgcQnVLhefzFnphaBzkPX4DWASgLNyg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ijHAK4jp/W3+yP3SjYIwyudnH1gsROgiOIUR6o3QBOWhju89RKd1Nf+EzfqVJ3y5G
         D8aXK9pihpRlXkeH0IzZydkb/bpVeLKzxye4sWYcMLTfA0psDu9HFDc4Hw+oVfhapc
         ZhTthq0YfMMAIdzXhZ44ZMjKWO5PhEIg6kz8ql7L6npP+CosNDQIPdqPfUDAOjIVVE
         xx1uJ4aUU3/35gP2rNnUlDBknO10Q7Wf3CqG5aptbx1I1IrtpOoBkXHnK7EJkp8esd
         aoIsottl3SoS4aYhuL6HOepm20J6JVlkg3G29pDprOFW8l0o3oBhnkazG89fTUjoUp
         6ur/vZ+GudlnA==
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211117104404.3832-1-olivier.moysan@foss.st.com>
References: <20211117104404.3832-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: stm32: i2s: fix 32 bits channel length without mclk
Message-Id: <163718827890.136789.10813827893934217729.b4-ty@kernel.org>
Date:   Wed, 17 Nov 2021 22:31:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 11:44:04 +0100, Olivier Moysan wrote:
> Fix divider calculation in the case of 32 bits channel
> configuration, when no master clock is used.
> 
> Fixes: e4e6ec7b127c ("ASoC: stm32: Add I2S driver")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: stm32: i2s: fix 32 bits channel length without mclk
      commit: 424fe7edbed18d47f7b97f7e1322a6f8969b77ae

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

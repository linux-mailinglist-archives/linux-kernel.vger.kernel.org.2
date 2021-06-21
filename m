Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5946E3AF570
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhFUSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhFUSt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E5D261107;
        Mon, 21 Jun 2021 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301232;
        bh=GNyIa4fa2uI8VR7bS9Ty1jjFSGpmNLNuoPJXPMaZs7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX8fa7lyBY/ap9StCFLsika0Ms80+tOYIQGxMCkmW4+FWNR3OxCUj0OnWor7kdi32
         2clQrlEnSnilQPJIGJZwvq8Aex0HJjdulXnCrNaSNOUja0aS8BVM3K9rfmkXKFkT+L
         5tAxWGeR7q93wzIEd+pasyNAzSWoGeF3FcNKRTCWtZvv2VUW7x+/inBNFY4uLCsdZz
         Uu+qHcwFXNRVuvm6l5/CSJJhq/yGt84u1J6FGSrM1LWoHfTH7x5zcvgY5vG4KC5ubd
         Tjzq9vLowZBRgow6ULj/eIbhVkZIESBM2xygcIZcoNGuc85mHwk3Ie098I4JY5hf+x
         23jI0rqb63jVQ==
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jack Yu <jack.yu@realtek.com>, Bard Liao <bard.liao@intel.com>,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        Jaroslav Kysela <perex@perex.cz>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Shuming Fan <shumingf@realtek.com>, vkoul@kernel.org,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/5] soundwire: export sdw_update() and sdw_update_no_pm()
Date:   Mon, 21 Jun 2021 19:46:04 +0100
Message-Id: <162430055264.9224.8953420856630209073.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
References: <20210614180815.153711-1-pierre-louis.bossart@linux.intel.com> <20210614180815.153711-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2021 13:08:11 -0500, Pierre-Louis Bossart wrote:
> We currently export sdw_read() and sdw_write() but the sdw_update()
> and sdw_update_no_pm() are currently available only to the bus
> code. This was missed in an earlier contribution.
> 
> Export both functions so that codec drivers can perform
> read-modify-write operations without duplicating the code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] soundwire: export sdw_update() and sdw_update_no_pm()
      commit: d38ebaf2c88442a830d402fa7805ddbb60c4cd0c
[2/5] ASoC: rt700-sdw: fix race condition on system suspend
      commit: 60888ef827e354d7a3611288d86629e5f1824613
[3/5] ASoC: rt711-sdw: fix race condition on system suspend
      commit: 18236370a098428d7639686daa36584d0d363c9e
[4/5] ASoC: rt5682-sdw: fix race condition on system suspend
      commit: 14f4946d55d335692462f6fa4eb4ace0bf6ad1d9
[5/5] ASoC: rt711-sdca-sdw: fix race condition on system suspend
      commit: d2bf75f4f6b277c35eb887859139df7c2d390b87

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

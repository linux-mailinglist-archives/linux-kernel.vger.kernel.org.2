Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DBB3F89EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbhHZORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242840AbhHZORK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:17:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4D4260E78;
        Thu, 26 Aug 2021 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629987383;
        bh=Id9hdMS4ZVRLE8sX6tHUAZFHZyYA74j1rQP2S76OPIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3hLyQPwalKZygt/4rARZPh/L7wWvt3/aLK27jxsyYNxuZ3pe/n4X0J3cF4UWEEMW
         Pu7M3vDvPlvzJEwXitSWmyUJfECA7ej52IPb8x2XXL2+4GAEM2t7H5md29y4lFz5uu
         kik/jTyhhV3+nHwQULaNcssBhRN7DaDHbrJ3wv8gno7FUicqk1D3N5un125cStujUj
         F/cseX3ayQDm2fKaz+WY1PFapnBPus01BocUdoAtTD1g3wyc61wC9yzMtoBANnpkX+
         6qwQBeTiVoArdogg0Iu0JnV+/sIKUiig9bb1q9Jl+FkeAlHn+UnCULPNNJnfGDnRoJ
         Aoqfzfw+EDUHQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-mediatek@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: mediatek: mt8195: Fix spelling mistake "bitwiedh" -> "bitwidth"
Date:   Thu, 26 Aug 2021 15:15:45 +0100
Message-Id: <162998707936.5647.1881702741528479360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210826112611.10356-1-colin.king@canonical.com>
References: <20210826112611.10356-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 12:26:11 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Fix spelling mistake "bitwiedh" -> "bitwidth"
      commit: 11a08e05079a9328023d236b82bd7981bcde0852

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

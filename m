Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135913575FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356179AbhDGU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356257AbhDGU1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:27:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF06D611C1;
        Wed,  7 Apr 2021 20:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617827211;
        bh=hhSwEIiRpS2DqdUTQ61WIoCRvLh6PsG+8huacQb3mew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MfUNOg/DryAKcb+XuiDNOZsFxcFaABotIU+7EjRUqKSJTyXyzcnwwOuCccSFOOx01
         P+rD4vL6w0EkcMp8RKLN4eRDB2zkqkK/RPOPAy8JwAUyaUYXKB1L8VsY5KZ+loNM7H
         pTuJlSzA40pVLY6mu9sCczApMz1FkZZ0DL8uoN07qwaaVdlfO3W9wtGL8OBiFE7UaR
         6CbD1FTd/tlE4bmQTLA4CAyltFIpwp1ROhlS/Ny6yyuCkjnR1MrMHPBD3veGp8+NvA
         VwZV32xBRnGp3fLpIOeX6s2udf9NyNA1ATfx4DcBlShP6ZiEdoMshrXoWYqFteZVbu
         O+mZk72Pg0UvA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: meson: axg-frddr: set fifo depth according to the period
Date:   Wed,  7 Apr 2021 21:26:21 +0100
Message-Id: <161782703231.42756.1997457817107247439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407145714.311138-1-jbrunet@baylibre.com>
References: <20210407145714.311138-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 16:57:14 +0200, Jerome Brunet wrote:
> When the period is small, using all the FRDDR fifo depth increases the
> latency of the playback because the following device won't start pulling
> data until the fifo reaches the depth set. We can adjust this depth so trim
> it down for small periods.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-frddr: set fifo depth according to the period
      commit: 6f68accaa8641b70b698da659216f82f87537869

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

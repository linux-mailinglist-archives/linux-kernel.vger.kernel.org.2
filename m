Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0532A057
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhCBEQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:16:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346154AbhCAXiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:38:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 023B5600CD;
        Mon,  1 Mar 2021 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641801;
        bh=dg6BeBGISWGF0gV3iR/jlBIXrHb5RFxCFDTOZcWhzpQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=feHCcUT4vETo/jlSM0CULkHV1p6YmCQqv2co759EbmZjUppRf62tip3GnWKaSpSak
         ju/LHU8rFlEqHJWAo8kLNr+vMKiibKHLVLbp/XFZ3/hjoIe1TyK70Feiwnw1ngZ1QX
         6BRDdf/7O6y7m12tqVokxAP73uanIX1MymcXYBqOUWVdZcMiPF5DrbUYTzF47hJRcW
         l59bckpzuMQ10OeW/dI9FUNGtLG7lel2fg7ZUToOXRagI8FfEsLJofvwYQYR+OHYe2
         ECVloriWDG/jEAdZyzdKnvYXoV4b4TE4JBvd23t3FgGm1hpbMzqdVxLvfuJYmhUSxI
         BSC8AWLB2Bqgw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Colin King <colin.king@canonical.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20210226185653.1071321-1-colin.king@canonical.com>
References: <20210226185653.1071321-1-colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: Intel: boards: sof-wm8804: add check for PLL setting
Message-Id: <161464168097.31144.7451844470598305958.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 18:56:53 +0000, Colin King wrote:
> Currently the return from snd_soc_dai_set_pll is not checking for
> failure, this is the only driver in the kernel that ignores this,
> so it probably should be added for sake of completeness.  Fix this
> by adding an error return check.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: boards: sof-wm8804: add check for PLL setting
      commit: e067855b814600248234a2a7283a7a9006e5aadc

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

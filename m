Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA0A4001E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349627AbhICPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349579AbhICPUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:20:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCDCC610E5;
        Fri,  3 Sep 2021 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630682361;
        bh=HtASRRWKkNhLAcnhps8RwSDCZ3wFyaPgsokSOt8bdEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrzVlW/4sIbliM2WppPgTAw3Kod8WVGtqY18Yl//1HyvpIS/uRH2uVyoj3F10mZBA
         Aq6TmaUWuEnwPR2UApspQSFv9MOealNshBmNFZLSXQ2fy6C2znQC/D4xk2mJXDndlR
         /EFScGCvwGUZqGIq/UyNhsb/yhrQP73HgqS0U49BwZwE0b96HpgSxRbTel2RQhMReb
         rzNiyhIZY0WzaZbwToBWSvfFAJJzxzpwl12aZ6mIlE3FHYmAo75eFlI4Z/yVkDjbhk
         S2n/S62UfzSsQa9omsarbthCmg/MCSWx6TEppf98ePP1UGvpet3zl7oLGJbTVPht7j
         r+U1REJaWp/2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Subject: Re: [PATCH for-5.15 v3] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
Date:   Fri,  3 Sep 2021 16:18:44 +0100
Message-Id: <163068203907.50844.10461290358793917859.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902181217.2958966-1-nathan@kernel.org>
References: <20210802212409.3207648-1-nathan@kernel.org> <20210902181217.2958966-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2021 11:12:18 -0700, Nathan Chancellor wrote:
> When CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH is enabled without
> CONFIG_EXPERT, there is a Kconfig warning about unmet dependencies:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_SDW_MOCKUP
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> EXPERT [=n] && SOUNDWIRE [=y]
>   Selected by [y]:
>   - SND_SOC_INTEL_SOUNDWIRE_SOF_MACH [=y] && ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: boards: Fix CONFIG_SND_SOC_SDW_MOCKUP select
      commit: b3dded7e2f98e2672deb9606514c0e13e3094640

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5A41C565
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344122AbhI2NTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344107AbhI2NTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:19:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07DFC613A7;
        Wed, 29 Sep 2021 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632921458;
        bh=xtLbCRh5xCE2yUqi9k04cLpvo/QHop+ckgKyYeoYq+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eob3QP+uHfk3A+Jw8yHyVsOYzF+aKRaJg1nmwZoY4CUmfe9/LVP/XcTYxqqkBVGzJ
         SZ+NYhmsl3Ok2VHV93g4Cz1SNsHrogp4XGZH39DjhAIvBK7B4Jmdm/JKWZWX6fS35b
         B9qM/MDxH2hUFsRUqwCPLB1IzhVnlMtDmHU7k99T4cFiE0Z3q7XMCSg7MEXHb/Rbn8
         RcIB2AWuWcAlYUdy+J5T6XCvtJOo+LSfYGpKDbuHvYtTVotNn+VRa+HUJxIfoJYV7l
         +wTnsrm+8Xq0NFfYL/BX9BCeDUoJgerBMyEWB51Huezm9+r1G3V62A6s3kqRQZdwqr
         WkVM7y1fylMUw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: ux500: mop500: Constify static snd_soc_ops
Date:   Wed, 29 Sep 2021 14:16:45 +0100
Message-Id: <163292102842.46827.6744851030638549550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929094401.28086-1-rikard.falkeborn@gmail.com>
References: <20210929094401.28086-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 11:44:01 +0200, Rikard Falkeborn wrote:
> The struct mop500_ab8500_ops is only assigned to the ops field in the
> snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
> Make it const to allow the compiler to put it in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ux500: mop500: Constify static snd_soc_ops
      commit: 2831b71917264d7000855657acb1953003d3fd2d

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

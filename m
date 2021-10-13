Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C256F42CA89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhJMUCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239107AbhJMUCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D99D611CB;
        Wed, 13 Oct 2021 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155214;
        bh=ywp+O16zxyBQI01Bzx+Q5zw0Ksa0nuT8E8DGdvjOEAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGJhvT4i7Rkz1UcTvHCsGIsOR2YiqEeZsZjPQI0SIKeDQP7Xu/iO4Atz4ifrhkX+a
         34TZpzZB6cSHSHdR4k/O+js8XKeuljy+v7dmkpzsX3t6t2lfRD50eENQ0ZDlhWShU+
         THNhMSHFlcb6+NOc/I+BN6qaSok8VAuZDFu3Fp/ovrAQJY4Zq9o7jNpXZwxxZFqx4A
         pppASbbtzeq7UswC0ZIiDDlMVPBqHrO7WC212f/0GzHsXKSJ/x3oTPhNEScBovO3SJ
         /7JlN9vfUTh+SCVh2BwcIjjpwfhLDmSqfOndKZgX1jG7QWvJuuUc830VAyt64GNd+J
         VfXFPuKl8XyAA==
From:   Mark Brown <broonie@kernel.org>
To:     kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com, patches@opensource.cirrus.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        ckeepax@opensource.cirrus.com, perex@perex.cz,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8960: Fix clock configuration on slave mode
Date:   Wed, 13 Oct 2021 20:59:50 +0100
Message-Id: <163415517074.1358186.2537803193300280145.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1634102224-3922-1-git-send-email-shengjiu.wang@nxp.com>
References: <1634102224-3922-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 13:17:04 +0800, Shengjiu Wang wrote:
> There is a noise issue for 8kHz sample rate on slave mode.
> Compared with master mode, the difference is the DACDIV
> setting, after correcting the DACDIV, the noise is gone.
> 
> There is no noise issue for 48kHz sample rate, because
> the default value of DACDIV is correct for 48kHz.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8960: Fix clock configuration on slave mode
      commit: 6b9b546dc00797c74bef491668ce5431ff54e1e2

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

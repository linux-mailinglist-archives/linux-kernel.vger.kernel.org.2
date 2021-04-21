Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61141367321
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbhDUTFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245439AbhDUTFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:05:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B86A261455;
        Wed, 21 Apr 2021 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031877;
        bh=mJwW6C9lEThN5XEVxVHuEHYAlKqbu5QrhmeC8iM1ubg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E14WpmCcT1SxOx5cChjTJhtQMhF+QKgXuR7AYeUDhzCei8KokOvOGdSbKwI3lDveV
         Yc/c4V0ullBNsgdDy6IAW5tUVfNHt/q8i70vkoFXa8ho+eT4XVxwHiRKKksKGZyI9O
         lkhOa6/2xu7Xtu4C4i7VJvD39Fyd8JE3mkVLPAsVseCrjajjkHIa3pYAM7nrEI5r5Q
         LokzlKtnlnHF3JMREu6JlIlEulBGZKE7uXIgfWbHSGPHQ2fJqyR6lGSeKNPco4Ilam
         gje80K/g3mCjrqBe/TPvU38Y+3dldlqjPkc+VsUMERWe2B8OsC4HHfOSSfAx09B5a3
         0zmShK8rvNI4g==
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Sunil-kumar.Dommati@amd.com,
        Ye Bin <yebin10@huawei.com>, Alexander.Deucher@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Basavaraj.Hiregoudar@amd.com,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: drop S24_LE format support
Date:   Wed, 21 Apr 2021 20:03:35 +0100
Message-Id: <161903027032.13397.4454772541226435361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618993402-10354-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1618993402-10354-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 13:53:11 +0530, Vijendar Mukunda wrote:
> AMD I2S Controller doesn't support S24_LE format.
> Remove S24_LE format support from ACP DMA driver
> and CPU DAI Driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: drop S24_LE format support
      commit: 1300c7037f0f08692008053e4b12a2fb6fbd185a

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

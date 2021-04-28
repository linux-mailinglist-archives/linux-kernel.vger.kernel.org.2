Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0257136DD99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbhD1QzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241394AbhD1QzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:55:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCEA6143B;
        Wed, 28 Apr 2021 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619628862;
        bh=lIC/pqsoxsAM0Fy/QGQnTVj7ZtLt54LhbkZ0xAPSS9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/tlTFLO3kzIvoEubr+aHX0eeke0Gbkrmy9wxc3BXM9RUxd9ab5lWkV7vSMJoCSUX
         YNqY6bsoKJ0x3m9rhacs9HCg4WubaFN8FE3zo6m4w2zeAalaIZ92K+QQ6YmWbHk8bJ
         TK4+1GfcjJNXseB2l3SlFbWjEmpdDFiIG5riZCpb3gU2+4rrMcx+Kq5R7Iqu16Kg41
         C46gn7iEgz2ucClbpQ2mB0iMgVfhxJSnDIWRkbHFqSBS7AoUyDDWt9pW4znSIG2leD
         ZOw5RjzT4CVM6lPClS8kyoSP/q6a0Xqrp8Gu0tvnWZD9neAxfinWdTuwstRx34A6tt
         Pol1Qe6mJaBuw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        yuhsuan@google.com,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>, Sunil-kumar.Dommati@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Basavaraj.Hiregoudar@amd.com, Alexander.Deucher@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Prike Liang <Prike.Liang@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix for pcm_read() error
Date:   Wed, 28 Apr 2021 17:53:43 +0100
Message-Id: <161962856273.49583.9768251008066165285.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619555017-29858-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1619555017-29858-1-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 01:53:31 +0530, Vijendar Mukunda wrote:
> Below phython script throwing pcm_read() error.
> 
> import subprocess
> 
> p = subprocess.Popen(["aplay -t raw -D plughw:1,0 /dev/zero"], shell=True)
> subprocess.call(["arecord -Dhw:1,0 --dump-hw-params"], shell=True)
> subprocess.call(["arecord -Dhw:1,0 -fdat -d1 /dev/null"], shell=True)
> p.kill()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix for pcm_read() error
      commit: 6879e8e759bf9e05eaee85e32ca1a936e6b46da1

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

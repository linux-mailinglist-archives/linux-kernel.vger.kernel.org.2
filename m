Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163FB314009
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhBHUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235537AbhBHSj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:39:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D49964E6B;
        Mon,  8 Feb 2021 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612809556;
        bh=xgfXFXjxKi9MNGtKtz9Ymxo6K71+ooCHg7rZVVUShK8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ce9O3Y4eN/3AFIMoDMSQNp5IJmirdGXjxOzxsX8HI2R2EEuFZZwh4EYeudaHrOt5J
         tgLvLfbYs9wjnsiO3hAqCEp2tnc4U2Q5/DlgQjPigUSo4KUOr0VU4TMqGWXaDJi4sj
         26THtsD/Qh/paOPbYPAEfXyETlzac6jt/8YicP84D35XRiBODs/Wqa7ms7l3npNnMH
         a6DD9fAbtSeaFybrCGb3UW1Ql/dt9dZf250MFOXqIZHo3UjPmpSl7pNxOnfJSwZqQB
         e9Reqimn24mtQ+DVIqsS3JPB9R8nlVvryK5ZRwR9bLJfkbP9JThCcW8JoXsVn7/1D+
         gOkG1WyhyP+Lw==
From:   Mark Brown <broonie@kernel.org>
To:     Timur Tabi <timur@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@gmail.com>
In-Reply-To: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
References: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: constify static snd_soc_dai_ops structs
Message-Id: <161280948304.10741.2031202191928010331.b4-ty@kernel.org>
Date:   Mon, 08 Feb 2021 18:38:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Feb 2021 23:58:49 +0100, Rikard Falkeborn wrote:
> The only usage of these is to assign their address to the 'ops' field in
> the snd_soc_dai_driver struct, which is a pointer to const. Make them
> const to allow the compiler to put them in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: constify static snd_soc_dai_ops structs
      commit: 38d89a564847048c0f6fe53a829d15edb4f21da3

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

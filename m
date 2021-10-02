Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DC41F8A2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 02:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhJBASs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 20:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232404AbhJBASk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 20:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE26061A02;
        Sat,  2 Oct 2021 00:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633133815;
        bh=nsc2fpMzsGtZeukbSHUUyuCKpxx+JA+JABw8eC1Wmg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFt15lP34RVnJFmjDkn7gD/T3yx7WhE/u9AZT6sYCeAoZKAu929L7+Oe1NeNNO5/m
         wGmuZFWRJKFDoHSe6CQR2F2U8xyhhyN7cDDK8RfPO6W+MlMkSV5JxISZYRRmm5K/B/
         jy9+hTweIqEeWHnWxoaJs8+x1GBQc5qg2csRsn179YK2RWhH+CHbblsphE76dStjXf
         0Ky6H0V9gBpMJJVi6G2SmwFxn+BHaehoLSvheZz9KjezeaC/AaLtmtWQdCXbrllG1W
         UoiRjlyXZumCBsZQMUrnwHWYLnI2S7ao6YPE2jQ2KwRK1ac4buZXjz6kLBXtJ27n8Q
         7Ty48dyEqdW9Q==
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: qcom: apq8096: Constify static snd_soc_ops
Date:   Sat,  2 Oct 2021 01:16:28 +0100
Message-Id: <163313339131.45396.15118766100261477417.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001115030.10402-1-rikard.falkeborn@gmail.com>
References: <20211001115030.10402-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 13:50:30 +0200, Rikard Falkeborn wrote:
> The struct iapq8096_ops is only assigned to the ops field in the
> snd_soc_dai_link struct which is a pointer to const struct snd_soc_ops.
> Make it const to allow the compiler to put it in read-only memory.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: apq8096: Constify static snd_soc_ops
      commit: cd96663bc27e1c94210b5b737de4d7cf233d90f8

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B605358A46
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhDHQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232454AbhDHQz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:55:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 216D2610A7;
        Thu,  8 Apr 2021 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617900947;
        bh=X2WX2rqMp54q3uV8HKSEG4rJybPBHqwMj67KHKa5gIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oom6Ms/6L80z+2U9D4BHFI44lHaTAQCKGiLZfbrUFK09iylAs1nz+rJ7y2w5AXcVm
         QE7FWn3/YQ8trUHpHdqKK+S6oG6TP2gq38C5p4FLeYYX6V7ImTpdp2OP6sdeY7YAEy
         2Sv0SUlChkU6c3wgUKJCUHnMhPDunHlrSEva164mscpwaXu0g4mtuGxFS0tklWQ7Kq
         1kXK/iZcXbj77ZYFumwydNeo8EKiHMFLr1x6XgIEdlZR8YPACLDMrv727Pa2AJGjlZ
         jrSc/m4W8IivMpBr6mq58k8ckODq9ib3gt//wj+2xt/oNzJPDkpTUyBx0MzBtkCKIP
         I63LJIrT5AMRw==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: codecs: wsa881x: constify static struct snd_soc_dai_ops
Date:   Thu,  8 Apr 2021 17:54:44 +0100
Message-Id: <161790012551.16915.13044898778864145563.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062700.803792-1-yebin10@huawei.com>
References: <20210408062700.803792-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:27:00 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa881x: constify static struct snd_soc_dai_ops
      commit: f985838003ee618daba7a38da3efe27c639575e2

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

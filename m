Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82D935A326
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDIQZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234229AbhDIQYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:24:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 570BC61186;
        Fri,  9 Apr 2021 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985442;
        bh=5zOvE47fmEDQV2SXKU3sAafuQqU0Z49Z3t5ZBvY9pJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1+bBMgcEGmc/4xKUqCMjVMrl8UvobP0H81N11HFk561sMzJBOatszls5ueI04WqP
         HQtsurZT7P+kxeJ1ZBPB81p63zb8lrh0qZIni+lYrWrApiCOrpTMD6DSU1xatZQUgg
         u0mvlRw0c2Xo+kiKmjhywtiCUbgz5d86Xmt+V7V6B+hdlmoBLlFhqUqNfTXF6xom2s
         Yf/jhRHaw3wvjpqVOaQPPgSHNNBLs5FlEJfdE1E+jIODbgiPGfw0HSLq2c46pM1zfQ
         yQYS7FdDWPdVXuh+K240whB6A4yBO16hEEC5ikamndrAqLBqmZiZcMhX2lIMaLa06S
         S5ZjmUF64UvAg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ye Bin <yebin10@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Hulk Robot <hulkci@huawei.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: codecs: lpass-wsa-macro: constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:55 +0100
Message-Id: <161798344182.47643.13407660780241104204.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062642.802846-1-yebin10@huawei.com>
References: <20210408062642.802846-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:42 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-wsa-macro: constify static struct snd_soc_dai_ops
      commit: a893a666b5b9a8c9d331df4afa72f23f4d4f83fd

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

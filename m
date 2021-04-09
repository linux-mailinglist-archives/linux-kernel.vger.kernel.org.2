Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D2335A31D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhDIQYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234179AbhDIQX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA58661074;
        Fri,  9 Apr 2021 16:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617985426;
        bh=7iRrAEPNgrTfj1x4u9c9nUYjf3WD+FYlX1nj7nYuuHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOggGnc7K5JgxbfkHbkPtwewYUtZjaDEPSJNzTGhTr4i8T1P75busXhkA0/gv1cyc
         Fbp6783ZfDKvxvaYNEpb/v62RNTZSnfqBcfXKNbXMBZ2fYDMCx+uLz5d13XSqcchQ3
         wacH6JoOfRjaJMrBHP2uzVshG5ujW6iPjaoo+LgbeTTJ77JjW2l1eReTQUmN8DcEQq
         i2yojpJ/XkuebVdgG/TvB8EBNJ05sKsfgKr6Q4KVLPgx5+G0PkNLhQU6bGB1ULZXTF
         Oh7/RygOfz+00D0REEXoLuJaGNiHio/Ll113j8WXk0uaREmOFKekRD4tKdAdPZUNoJ
         Yw5UKKdX/7tQw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Ye Bin <yebin10@huawei.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt711-sdca: Constify static struct snd_soc_dai_ops
Date:   Fri,  9 Apr 2021 17:22:49 +0100
Message-Id: <161798344183.47643.10123249955725724471.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408062647.803141-1-yebin10@huawei.com>
References: <20210408062647.803141-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2021 14:26:47 +0800, Ye Bin wrote:
> The snd_soc_dai_ops structures is only stored in the ops field of a
> snd_soc_dai_driver structure, so make the snd_soc_dai_ops structure
> const to allow the compiler to put it in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt711-sdca: Constify static struct snd_soc_dai_ops
      commit: 3cab801e8b94280264ba23ab0683cd3a9c13ca9f

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14048419D68
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhI0RuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238046AbhI0Rti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:49:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5DDA60F9B;
        Mon, 27 Sep 2021 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764880;
        bh=fo8UtX1qyDCUjoGqUbYWVlsvzl89Asms03FvPG0QBhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QF8cOCMzsi2AMYyy+h5gbgELrmdrEf0RHShbnEusBbThEX2IOu4PYuVtSm/Rp4fyQ
         I7JR5DYZYOy6std6liN79mx9+BsBqWrD5XyCI5Sy1nzCX6bxoe50pNrUR0TlVz2spo
         bQ5A3z7AWXyVSY7bQHS94teMUmc5IGqu9FEjalN6217ut/mah6wo63f7AZd/lxtbr3
         IZplnbwqLXzf2f+BJL8NS/RT1mLIG02hX0rMHfmNszaO0o0D0aaLMr385eTix1aBTB
         XipA4KzyMbOiNkzwRk44kuY28OU0Epou96nbdPdrLK77rq3Jo+Qd6EkXaTfk8gmbaW
         T+7m2jD9JYI7A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Banajit Goswami <bgoswami@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: wcd9335: Use correct version to initialize Class H
Date:   Mon, 27 Sep 2021 18:45:45 +0100
Message-Id: <163276442024.18200.12102853821778377525.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210925022339.786296-1-y.oudjana@protonmail.com>
References: <20210925022339.786296-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 02:24:19 +0000, Yassine Oudjana wrote:
> The versioning scheme was changed in an earlier patch, which caused the version
> being used to initialize WCD9335 to be interpreted as if it was WCD937X, which
> changed code paths causing broken headphones output. Pass WCD9335 instead of
> WCD9335_VERSION_2_0 to wcd_clsh_ctrl_alloc to fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wcd9335: Use correct version to initialize Class H
      commit: a270bd9abdc3cd04ec194f1f3164823cbb5a905c

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

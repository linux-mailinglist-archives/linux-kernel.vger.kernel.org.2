Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7039FC06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhFHQKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhFHQJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:09:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 167526128E;
        Tue,  8 Jun 2021 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623168428;
        bh=IE90yMmSiIO5UaTrZFRNwPp96wF1YEO0nCwugAP0epY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fqPMKPPeW/P0hexZl0gL22JgSpzyOrJNl8xzuPKwFmToc9DLOE33WmVJPFqhJc25O
         K9z3lZWgMkmlWH/BzWmKg1E1lf1NHJwglEwGs4Kq2QXEc77ZDmSpPRR839jf8LDhF2
         /pp/adr2F8HEg2fYuTimT/q33IKUaAqeXCyh//7mcwhzO4MHVU99Fw3L6KQmxu8f5k
         HS+9zMdEYNj4o3cBVfrVRi8Ew1ICl5U+FFl5lRKqvmOu3GAhVhFSrFV1pXp5ufg/fW
         lyXRWhGISncdQvDACKpgrr8xk8suG76qPaG9nvsaBHDDcXgMZ/1zHUSn8nrNF47PXj
         Y2EKMbHcTBKwg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wan Jiabing <wanjiabing@vivo.com>, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: remove unneeded semicolons in wcd934x.c
Date:   Tue,  8 Jun 2021 17:06:36 +0100
Message-Id: <162316808975.49749.566650719258018902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608030656.24052-1-wanjiabing@vivo.com>
References: <20210608030656.24052-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2021 11:06:55 +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./sound/soc/codecs/wcd934x.c:5136:2-3: Unneeded semicolon
> ./sound/soc/codecs/wcd934x.c:2466:2-3: Unneeded semicolon
> ./sound/soc/codecs/wcd934x.c:2527:2-3: Unneeded semicolon

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: remove unneeded semicolons in wcd934x.c
      commit: 3ea8a7459861def90bbb184396651d47a4cf4f20

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

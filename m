Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5733441362C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhIUP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234066AbhIUP1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A64F61178;
        Tue, 21 Sep 2021 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632237964;
        bh=kC2meo6Fvlk2b3uZGSxQXxf1+PcarHHiV4qO9lBt04Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3thaoIjIv0L09oIwvxTwjsDNb2wN0uyjH7zdzAYBohmfDCJ5vOsgD3BPQsOrIMjk
         ysYO8m5cpD2MokPtN3IWfqcAmRfHnXSZAjgBYPC6xzv6fT8QG7HuaNoTemsovPA8Td
         2CeFHvHh+rrCaz8SyJs4km5D8KTrevbyrfPMXLb274JRQ9lCmW2zcJ3+9od1ZWijYg
         2+w54f1VMEP22hS13mG1zxcADMRrdAka3e1qPPUfvt8rYqG3AIZe5xVOIruvectJOg
         iapVJtEXwQiy49Mum50GyFRVQC6PWV7caoissk3k1CtFhKTd6F88uzhcfE49AY7L0Z
         F5uGM6fGbiP1A==
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6afe-dai: Fix spelling mistake "Fronend" -> "Frontend"
Date:   Tue, 21 Sep 2021 16:25:10 +0100
Message-Id: <163223651319.32236.12537335411732111582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210920184152.18109-1-colin.king@canonical.com>
References: <20210920184152.18109-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 19:41:52 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the module description. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: q6afe-dai: Fix spelling mistake "Fronend" -> "Frontend"
      commit: b5377a76782797fec63c4461ef961d8d4abe9cbe

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

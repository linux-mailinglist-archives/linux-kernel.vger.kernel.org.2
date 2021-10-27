Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7743CFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbhJ0Rb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243248AbhJ0Rbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:31:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 536A1610A0;
        Wed, 27 Oct 2021 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635355754;
        bh=5dv0HGz4bWpWJPI+ZLbq2SON0N8XFp8vjVzsWv6u1gI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UFX8KAyigPYakyshO2cMNU6BMxeiz+hrBvd2joCBB42KXMt0ODkOJ5+cQTrYxEYMd
         pCGX0Pd2XFlFkaetWP611YM5kX7Yh7qdpehaNOPXAhjTK9uZG2IsOjLUgz0IAUFgV2
         ArXrvB1F1h9KMZTCzw8fZ1hWCp+iWsDiIC4LOfQtirvuwg5ix5SQEqJp0RhZCczeEU
         URjewVIhoEJv/KCD1fUkzEBYe6GAIL48g0jP3oRJ4AOFuZ7HSrkoSHlTfGWyJ56EwN
         wIjgqdSSTlpDDePF+MtDutLmsOI5x9qQNFvPkN9fYccuw3DS72DesuqHlc7zWikKxE
         OxAsURSDXfRjg==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz
In-Reply-To: <20211027065228.833825-1-yangyingliang@huawei.com>
References: <20211027065228.833825-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: amd: acp: Fix return value check in acp_machine_select()
Message-Id: <163535575308.4012075.1966286577719870369.b4-ty@kernel.org>
Date:   Wed, 27 Oct 2021 18:29:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 14:52:28 +0800, Yang Yingliang wrote:
> In case of error, platform_device_register_data() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Fix return value check in acp_machine_select()
      commit: fdde18b9773636cc5866ccd8f2093e1cf0022dea

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

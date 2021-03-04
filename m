Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7513532C963
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453425AbhCDBHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451635AbhCDA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:57:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89E9064E7C;
        Thu,  4 Mar 2021 00:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614819380;
        bh=W6uJ0LRqqdSu0y1TNFM4Cx4MwH09KexgWtJhcfuKeUc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jxHEpJbasDjsC7LnOAP+1N8JfdQfyInxClGESqtIUUxSeoBErDdFdTmiOYOZqESrI
         hSp/2bJVM2zkUD5Rxns26ejmWpPhhObNGiUHFHgOVRaRaaptceLYnAxbeBfPbn+QtU
         kmwO0aHYGZFOJgxpP8Qvg/+xEm7mDCKRSzbVLPAW1nQ+u9azQxqSu6EOtLyYN8smyS
         v72YAv7mIiglLDKohcNXEwkeyc43Ii3slzCJrxMmRme0ARmiGVYYAW5++0eq+KFJDw
         KTQsavmBJ0M1ViV+sUGC+CR27GbSxutO2eOigQJuIfhnfEz0V6Wl6JbxAYqYFlkVXb
         Ags9Vdv61g8Ow==
From:   Mark Brown <broonie@kernel.org>
To:     paul@crapouillou.net, perex@perex.cz, lgirdwood@gmail.com,
        tiwai@suse.com, Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
References: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH v2] ASoC: codec: Omit superfluous error message in jz4760_codec_probe()
Message-Id: <161481924070.9553.9652910375356726257.b4-ty@kernel.org>
Date:   Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 21:56:30 +0800, Tang Bin wrote:
> The function devm_platform_ioremap_resource has already contained
> error message, so remove the redundant dev_err here.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: Omit superfluous error message in jz4760_codec_probe()
      commit: 046c4e329066c50ff3ffd174ab95a0ac638807b4

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

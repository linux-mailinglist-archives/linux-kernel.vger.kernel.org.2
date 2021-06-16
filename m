Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A8D3AA1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFPQoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhFPQn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:43:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C6C861245;
        Wed, 16 Jun 2021 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861710;
        bh=2onQOibA4CQc7noe+2STOIXu78f3FAxW2qGwNCOGv8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5H4Xi3DGBblbdIIqDBF/+JtxWem19ECMx4PAC6q4Do0j8SqCtxGUuMkJgFZpjZHD
         L3HM5Mvfw+eM4HATWyqg6u0zOuySxvHQyZV2Sxqmx0TTEyONqaQJPcQ/AKCugJMbMK
         5O9wcghRSoOcQmOP24QEvHJsxpQ79AGoTtamtxQ5ZYZp5OgGWy+RZnCRdQdRWY6efj
         tDWLa0S7dbzxuBSDyrJsaTFxDmv3mW5UM49aZYndc6lymQAN4M63kfWfMTof1xAIyU
         IGDLmSluePjlV4h94I24Clz55oF9QzNfCqLsOTz0ogD/Ur6gEkb3UzNgqhpQLi0SBM
         MF/yRCsLe5xJQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com
Subject: Re: [PATCH] ASoC: codecs: Fix duplicate included sound/soc.h
Date:   Wed, 16 Jun 2021 17:41:15 +0100
Message-Id: <162386001971.25644.6040330182836931770.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623822667-130511-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1623822667-130511-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jun 2021 13:51:07 +0800, Jiapeng Chong wrote:
> Clean up the following includecheck warnings:
> 
> ./sound/soc/codecs/wcd938x.c: sound/soc.h is included more than once.
> ./sound/soc/codecs/wcd938x-sdw.c: sound/soc.h is included more than
> once.
> 
> No functional change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix duplicate included sound/soc.h
      commit: 06cc52329cb098ba0858032998e382311dcd9743

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

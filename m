Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB236122C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhDOSes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234565AbhDOSep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:34:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39FDB610FC;
        Thu, 15 Apr 2021 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618511661;
        bh=Kbob7OMphmt3u9UFU9U2QWIuSQbjN9slDC+F+dIJdWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emAwkXVzBesOHhCYumFy0reWg57jyFGL0yppj5k2T3gFJ5r0Xl39a4+7ww0K+aKwX
         5xOK/+HQg4sj4YGKqjJ7EDqySKKcpMf6ZzC1nejla4lAPPS9E5zwr7ifevthZkL7uh
         2eVIVx08axFE2BgFfcUaB4k/4RYvlq2Lesty/DvkyFm4uo5RAO8FWHhyKaL0J7s+7B
         3Qs5ydKFgaOZHudeCC8yynOCQvVxwIhlf55DuAVbkVkEWu2GYaxW2H9ZteENV0vbP2
         fUPeooIpzMv9qmi8brYnNO/du4YbexMGyxROc4XAcH0irRjACdMrZ24tADmcPSGZFr
         +73s2EsOk87jQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, zhuguangqing83@gmail.com,
        Takashi Iwai <tiwai@suse.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: wcd934x: Fix missing IRQF_ONESHOT as only threaded handler
Date:   Thu, 15 Apr 2021 19:33:44 +0100
Message-Id: <161851148784.23061.9027207380997094789.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210415073829.22750-1-zhuguangqing83@gmail.com>
References: <20210415073829.22750-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 15:38:29 +0800, zhuguangqing83@gmail.com wrote:
> Coccinelle noticed:
>   sound/soc/codecs/wcd934x.c:5041:7-32: ERROR: Threaded IRQ with no primary
> handler requested without IRQF_ONESHOT

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd934x: Fix missing IRQF_ONESHOT as only threaded handler
      commit: 22ff9c4230bd09ade8971c05463b90ec1d513245

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

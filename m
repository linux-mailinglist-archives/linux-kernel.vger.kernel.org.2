Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9E405A43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 17:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhIIPko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 11:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232707AbhIIPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 11:40:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAB4761101;
        Thu,  9 Sep 2021 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631201968;
        bh=tkOzf4SWBI/A4DwsroAtEgpaaPJWTwSJSjBkhkWXmMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJhV9fvfNFeICwBDTUrqTTlfXKOrQ7ggctzbNDG8N1pai6ZW3kD0BiudT68fNafJ0
         nw+xWdmdXcE/rZOTItwmQZFMTEAuN9XPe0Ckvo5A1kA/s1H1yJS9SntciWBfQkscju
         t+Ejk5J2dwsBrLywTaXg5yjTdnM3se9sNUk6vX0QMpFtj9LuqT6D/JOkNsTOOOrUyK
         Sgk4A1T23zChKVB/1ZRKW5/L3v8q3gxB2jedgFRX6/huZlSRKVo1crlbFfTECMegYv
         d0oo1//1Mk4qEJf3d3ZXyEXrb1pynXGWlAzm0P+cnBgUQtezcL/sKMsGN5U5FJzbnA
         a27MmWQhZkD2A==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Trevor Wu <trevor.wu@mediatek.com>,
        matthias.bgg@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, wenst@chromium.org,
        linux-mediatek@lists.infradead.org, rdunlap@infradead.org,
        jiaxin.yu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        shane.chien@mediatek.com, alsa-devel@alsa-project.org,
        bicycle.tsai@mediatek.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: add required config dependency
Date:   Thu,  9 Sep 2021 16:38:49 +0100
Message-Id: <163120168199.50116.8060254144301490373.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210909065533.2114-1-trevor.wu@mediatek.com>
References: <20210909065533.2114-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2021 14:55:33 +0800, Trevor Wu wrote:
> Because SND_SOC_MT8195 depends on COMPILE_TEST, it's possible to build
> MT8195 driver in many different config combinations.
> Add all dependent config for SND_SOC_MT8195 in case some errors happen
> when COMPILE_TEST is enabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: add required config dependency
      commit: 5a80dea93191d55840f42252ed3e4565a125a514

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

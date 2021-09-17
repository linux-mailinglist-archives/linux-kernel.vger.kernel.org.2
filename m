Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B130A40F9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242920AbhIQOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhIQOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D8E26103B;
        Fri, 17 Sep 2021 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631887478;
        bh=CoUVYEo7fgOBwEFTIbSZgJaRRDgozeRszombXxCWMOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUc41prob34WTGXolgchVNz23eEN8sbz/GWDGzoVA6tKHXQNHFhWihNRYBwR9ooGB
         /bHzwjgDJH/oNuBV2uCKzFVx6H9urHsFNYVrTm7d14lwsjYBH7uj1jPlKEau3B/5Fs
         VIlKsHjhyYimb4qtTj27d7hFYGVQuLsOdE7oVpWu69xg0dPJyTps0g6AJMGGiUARt+
         1wJYSj7jkLa7VqtZgK9TuqVNSFqcaNHn9DCxLLRSZ/ZuSNm1rdwl+vqjdqjCDjLKxa
         5Se3NXvnRmKObKxZU4Xb9nsZXrBq+FU5Hu4lyX11cdOgJyezWIvBuFaOtuFBVxVj0F
         IwkDX0bq6n4+g==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Trevor Wu <trevor.wu@mediatek.com>,
        matthias.bgg@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195: remove wrong fixup assignment on HDMITX
Date:   Fri, 17 Sep 2021 15:03:44 +0100
Message-Id: <163188719815.50326.5771604177613195769.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917082805.30898-1-trevor.wu@mediatek.com>
References: <20210917082805.30898-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 16:28:05 +0800, Trevor Wu wrote:
> S24_LE params fixup is only required for DPTX.
> Remove fixup ops assignment for HDMITX.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: remove wrong fixup assignment on HDMITX
      commit: 3abe2eec87059260bf31033a8863c67c5d45b9d0

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

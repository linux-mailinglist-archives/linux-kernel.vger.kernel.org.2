Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C744EE93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbhKLVaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235702AbhKLVaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:30:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25BF0610FF;
        Fri, 12 Nov 2021 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636752446;
        bh=eoAl5B/8h3ZtzbA9rB3nBcwncqWuJUxuT/UFumATqZQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PyDHCooH3k3+HIQuMCsauOX0epOaMV29t1rOZWKdBiawNsX7KVbHe0BZDf+VJwlvD
         3nCRB1RWAkUvTKWfOjJQ7k+Gic5ysfd64D7RTx1Iotg8FUvzvEKiKXxZiaI9OODWFk
         rJQXpWhFujB8vhG+H46Vpwcioq5p1II9amfUdXHq+yqiicVTulezO69s8llcFmmQIo
         tqQjP8G40R9SwbuQPcLVEMNoYRCAYEkPKmrJyk3O4TkHR0xk3SIA4EtHKJ84k/zW8G
         XZ8phQJ+dNfrJ6b37g79SH3cxZg+lTAQ7jS+sCr41cmfZ+YXLMSMJqdkHbCRKJOPKh
         mgpxORkd/4lUw==
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lgirdwood@gmail.com
Cc:     linux-mediatek@lists.infradead.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        dafna.hirschfeld@collabora.com, perex@perex.cz,
        matthias.bgg@gmail.com, kuninori.morimoto.gx@renesas.com,
        kernel@collabora.com
In-Reply-To: <20211111161108.502344-1-angelogioacchino.delregno@collabora.com>
References: <20211111161108.502344-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Fix debugfs registration for components
Message-Id: <163675244389.742274.1874559646597511024.b4-ty@kernel.org>
Date:   Fri, 12 Nov 2021 21:27:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021 17:11:08 +0100, AngeloGioacchino Del Regno wrote:
> When registering the mt8173-afe-pcm driver, we are also adding two
> components: one is for the PCM DAIs and one is for the HDMI DAIs, but
> when debugfs is enabled, we're getting the following issue:
> 
> [   17.279176] debugfs: Directory '11220000.audio-controller' with parent 'mtk-rt5650' already present!
> [   17.288345] debugfs: Directory '11220000.audio-controller' with parent 'mtk-rt5650' already present!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: mediatek: mt8173: Fix debugfs registration for components
      commit: 8c32984bc7da29828260ac514d5d4967f7e8f62d

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

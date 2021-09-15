Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04CC40C83A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhIOPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238178AbhIOPYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:24:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7458B60F5B;
        Wed, 15 Sep 2021 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631719375;
        bh=CFcne7+7qHsHstFKZ8q27i5a1vH58yXKDRbZpKDT3Og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh5j1qiGe4lhnNE63fc22HRgRVHmcrVUV4F+dgUD/xmJIWo+wee3Z1YvAqYdPMn+O
         43DpfimIewbGTUOWTGWZSBdm/u1LQhzknpmgvLwr7BQWCORbN7Ll7fISiK1VFpdjkR
         khYfusxqh9SbOWWhu8mpPt98br62xOkNTF3zjBqxa6m5z41AI/akCFqAmb070LSX6J
         YAVlE+rVhG6ERzVGGZ9UlqAbwEsFbJirULhQNeHxRt0g5io7jT55Y4GINmWrIumZIW
         OYZoUNq+4ywDdjQzF1TarRoSX4uzA1PZ2QJHZd+5nS+8AxkhozNfRXUwdQCsP3/GSU
         +qAeubGItaN3Q==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Trevor Wu <trevor.wu@mediatek.com>,
        matthias.bgg@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, tzungbi@google.com,
        alsa-devel@alsa-project.org, chipeng.chang@mediatek.com,
        linux-mediatek@lists.infradead.org, shane.chien@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiaxin.yu@mediatek.com
Subject: Re: [PATCH] ASoC: mediatek: mt6359: Fix unexpected error in bind/unbind flow
Date:   Wed, 15 Sep 2021 16:21:50 +0100
Message-Id: <163171901944.9674.15745923942801327979.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210915034659.25044-1-trevor.wu@mediatek.com>
References: <20210915034659.25044-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021 11:46:59 +0800, Trevor Wu wrote:
> mt6359-sound is a MFD driver. Because its regmap is retrieved from its
> parent, it shouldn't be freed in mt6359-sound driver.
> 
> snd_soc_component_exit_regmap() will do regmap_exit(), this results in
> unexpected results if sound card unregister flow is invoked when users
> try to bind/unbind audio codec.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt6359: Fix unexpected error in bind/unbind flow
      commit: 6d66c5ccf5cb8af866fe2bb014098a3dd7bfa3cc

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

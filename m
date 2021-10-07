Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973A3425F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 23:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241742AbhJGVkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 17:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242066AbhJGVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 17:39:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF81610C8;
        Thu,  7 Oct 2021 21:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633642683;
        bh=m4HJANNOPPFV57mqo5iLQB7fhTk2U2/wpkQ5dIfb3Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB+mq8je9u+SYMX7yuDyZRztJ1+TEQHdhGPN+qrZWD+uCtA4BBZw1ndVfDo5reiGw
         ihje9A2hvtw0CFRlF+uuNO/yr9Kw7FPthacZASuLW/5ZFPtD7YrUZ0eXT99XBLojie
         GZ6XjCHzrPc9ovJPMeb9bNkSCO13fZIoYxFH9m1VyCRcBw8BIi+mW+4OxYce997O75
         R76c7ED/WcP02i3fm8rzNjbFWDsMWT+DYYO1KGLtgZ7cx2KBP0weNWmksNUGFhkWET
         AoYsQQSEWd4RaIoCvSdwQZmFHyz+DGOErTFq2zIohPvr01w0t9q7NiQJuMuT6BzQel
         ifWG83F3NhB9A==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v5 0/4] Rockchip I2S/TDM controller
Date:   Thu,  7 Oct 2021 22:37:31 +0100
Message-Id: <163364264608.649699.437992626098307061.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
References: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Oct 2021 19:15:27 +0200, Nicolas Frattaroli wrote:
> this is version 5 of the I2S/TDM driver patchset. A big thanks
> to everyone who has provided their valuable feedback so far.
> 
> Changes in v5:
>  driver:
>  - change comment style of the first comment to C++ style
>  - make refcount non-atomic, as it's only ever used inside
>    a spinlock
>  - use newer SND_SOC_DAIFMT_CB* defines
>  - change ternary statements to if/else conditions
>  - make _clk_compensation_put return 1 if clock changed
>  - implement set_bclk_ratio callback
>  - always set half frame sync mode in TDM mode
>  - automatically enable mclk-calibrate mode when the clocks for
>    it are specified in the device tree
>  bindings:
>  - add Reviewed-by: Rob Herring
>  - drop rockchip,frame-width property (done by set_bclk_ratio)
>  - drop rockchip,fsync-half-frame property
>  - drop rockchip,mclk-calibrate property
>  dts:
>  - drop empty codec block from Quartz64 device tree
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rockchip: add support for i2s-tdm controller
      commit: 081068fd641403994f0505e6b91e021d3925f348
[2/4] ASoC: dt-bindings: rockchip: add i2s-tdm bindings
      commit: 510f1c133aedcf69847786c14681e7f7bf4db778

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

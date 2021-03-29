Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A125234D8B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhC2T6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:58:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231892AbhC2T60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:58:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D7C361494;
        Mon, 29 Mar 2021 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617047906;
        bh=VMff+Qv6NeIX9a1HoADYuLB7R+Md++1sW41s5i4v3l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LO1Okk5EyAoTa+OR2sEzi7g/DU4llvPF4CAXEDM8pXNgXUXlY70DGfmmd23gLflnh
         0Dx8S9/6YqUmDOLwhjWBd0Gs91cD8N2x1K/jVzeKes8G9lZTURmooMKyBeB3sVMPe1
         dj6nJbUQUzDSpKP9MBaUfCFz/wnU1vEfCUtCIRP/1XGxEyaiymoScdmonhx7zNrujq
         KwYZXhqnIcGsVB90RLb+Q/iIS/7UMQsLFTjZaLzOyHKbLPzGhaoiEQUwvu4Xba67S1
         afamk2iHurB04AXA57AGj8CJ5Iv1dUXvhdynRyOSbZ/vXNO2V9CEfMIy+kr6L3KrQ3
         hiB2p299e14Sg==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, YueHaibing <yuehaibing@huawei.com>,
        lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: dwc: Fix -Wmissing-prototypes warnings
Date:   Mon, 29 Mar 2021 20:58:07 +0100
Message-Id: <161704724765.10039.16753813852849832832.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329150524.18184-1-yuehaibing@huawei.com>
References: <20210329150524.18184-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 23:05:24 +0800, YueHaibing wrote:
> while CONFIG_SND_DESIGNWARE_PCM is not set, building with W=1 shows this:
> 
> sound/soc/dwc/local.h:127:6: warning: no previous prototype for ‘dw_pcm_push_tx’ [-Wmissing-prototypes]
>  void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
>       ^~~~~~~~~~~~~~
> sound/soc/dwc/local.h:128:6: warning: no previous prototype for ‘dw_pcm_pop_rx’ [-Wmissing-prototypes]
>  void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
>       ^~~~~~~~~~~~~
> sound/soc/dwc/local.h:129:5: warning: no previous prototype for ‘dw_pcm_register’ [-Wmissing-prototypes]
>  int dw_pcm_register(struct platform_device *pdev)
>      ^~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: Fix -Wmissing-prototypes warnings
      commit: 0803a5cb5b7cf369c3e2af4108ee44d0b6e1c197

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

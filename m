Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5A344543
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhCVNPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232743AbhCVNAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9AC6601FF;
        Mon, 22 Mar 2021 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616418041;
        bh=I1rM7cd8e3ihOuidStsjXpCvxgU1JeiBWj6CfWBrf9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFdk6ckm9eiho+qzdSEVj3R7AXpWUyPH5xzgSXVyLnutLIrf0qAWBmBGGzPx+gTwZ
         je3PB2ZElXSDsJKiViOINfQcTlZSEPfYTW9FdmdbwPb6ceDYXPVMsMayHCJ5DqlE2x
         9eqvzFkZ/7UedCS9HC1SSndw/e/KNW886NoG1msvllmra12pcQusywpjEkSuiKrLWb
         u8Zn3+aDwGiomWJT5m9SZISSiOo2fxR/wWumCfSHn+r6IeVRg31HcSWYKCmSdKnRmI
         NfYXc8MeFDS+HeEDkny1SQEnfWLM7yY521nel4kyjn38Nxp5rXABNm/7MyZfohtL4W
         1m+8ik2SwURSg==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        festevam@gmail.com, timur@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org,
        nicoleotsuka@gmail.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk
Date:   Mon, 22 Mar 2021 13:00:30 +0000
Message-Id: <161641797252.25992.12180615467371169455.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616141203-13344-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616141203-13344-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 16:06:43 +0800, Shengjiu Wang wrote:
> When there is power domain bind with bus clock,
> 
> The call flow:
> devm_regmap_init_mmio_clk
>    - clk_prepare()
>       - clk_pm_runtime_get()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk
      commit: 2277e7e36b4b8c27eb8d2fb33a20440bc800c2d7

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

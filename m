Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD4934856C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbhCXXkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239047AbhCXXj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:39:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88BE461A25;
        Wed, 24 Mar 2021 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629196;
        bh=sE82qgo6DjUJmVvzp7IsDmSwvXE5yvUHIUem2fZuhbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQ+wU+lyP9CR7fqVu3PRXeHIlED38cpAQz38kOSLpgcmSZxOTXq0cAFXPgz82hONa
         1hRlLEgKcO3OMOeNUyCz8IDWRl/gsJ3iznsk0KxBA85nFIj0zfcAYCgSupxKqMOsGq
         V2t7JuobEhiwHPYN1eCaCvzUOsNwJxUku+o7/pWgQteUlwd805X773V2ysioR/i6jO
         5eSwVxEef54bTvJFElMBW84edC49K5OaPq12XZ2oGYedWIij7C8Xir5Q7pZ569onc7
         b8H/aP9aJt/16R52j4p2tPB2/pUBME7ppKZzuImbcROWQanU/wbQlclKOZ7D9aelN9
         rNDuZolLpyEaA==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, festevam@gmail.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, nicoleotsuka@gmail.com,
        tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] ASoC: fsl: Don't use devm_regmap_init_mmio_clk
Date:   Wed, 24 Mar 2021 23:39:36 +0000
Message-Id: <161662872375.51441.3639448957854720448.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 17:58:42 +0800, Shengjiu Wang wrote:
> When there is power domain bind with ipg clock,
> 
> The call flow:
> devm_regmap_init_mmio_clk
>     - clk_prepare()
>         - clk_pm_runtime_get()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk
      commit: 203773e39347922b3923df6094324d430664466e
[2/6] ASoC: fsl_spdif: Don't use devm_regmap_init_mmio_clk
      commit: c2562572467a74fd637d2d22fb773b052512528c
[3/6] ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk
      commit: cab04ab5900fea6655f2a49d1f94c37200b63a59
[4/6] ASoC: fsl_easrc: Don't use devm_regmap_init_mmio_clk
      commit: 069b24f22eb9dba2e0886b40ea3feaa98e3f4f9b
[5/6] ASoC: fsl_audmix: Don't use devm_regmap_init_mmio_clk
      commit: 3feaba79d8f701a774815483aa0e7f4edb15c880
[6/6] ASoC: fsl_micfil: Don't use devm_regmap_init_mmio_clk
      commit: b5cf28f7a890f3554ca15a43edbbb86dd1b9663c

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

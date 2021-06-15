Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63F93A8789
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFORcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhFORb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:31:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57694610A3;
        Tue, 15 Jun 2021 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778193;
        bh=y/udLKFYHLJaB0XXSTV3/plG0EFz9UjFo4yY54gp2DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iKbe5gtHeI1ioWirQJv2hdt5aroFC7VAq/EzTP+bv2jLRdhbT9GOaBVf71yFrjha8
         2P72WTy73lhUAnX158rxBGOF2g2+KBfWc2qmGuhcFUi7R3PHncaAhwH4i/mppOruNi
         fqQUBk44I5tABAa2HYoqe2WFz4srpeEffk4G3jqzV15xf6SLew3ALpehsZB7TUYM5X
         disxMy9aiPN21Z3MNsFmAqNEI0GfiXO9LnMEtLQrUFDCdNEAtMTFYicS9NWsHTOnI+
         ozR7X2O+m2IRRCUrLgHMhnaVtXbbf0OiiUY6r0b/057iI85gvt83PWaCUZD/woaoro
         XVbL5N2Q29gwA==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next 1/5] ASoC: img-i2s-in: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 15 Jun 2021 18:29:20 +0100
Message-Id: <162377763944.21612.10913621772984918294.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615135200.1661695-1-yangyingliang@huawei.com>
References: <20210615135200.1661695-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:51:56 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: img-i2s-in: Use devm_platform_get_and_ioremap_resource()
      commit: e43805c28df6394254d1f49a388a1c70cae208a1
[2/5] ASoC: img-i2s-out: Use devm_platform_get_and_ioremap_resource()
      commit: ef43f463ddb3dc0acaf1447db22db85df5100380
[3/5] ASoC: img-parallel-out: Use devm_platform_get_and_ioremap_resource()
      commit: a444a902b06a361d646e608136efb35119922445
[4/5] ASoC: img-spdif-in: Use devm_platform_get_and_ioremap_resource()
      commit: c481f3838acc3e1b28fc228f9fbb2f569e3d8d0c
[5/5] ASoC: img-spdif-out: Use devm_platform_get_and_ioremap_resource()
      commit: 942f2671c573904066ddbc699ff8812b3df70a9c

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

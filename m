Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9533A878A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFORcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230500AbhFORcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:32:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B51361403;
        Tue, 15 Jun 2021 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778198;
        bh=SdONMFRJs7Ih+OqCLHPKOjGOo6+vcLRW40A4/iSbxzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=My/AzXudtPgjPxNE3pkwlv9Ni3jGESjXpfpUicUM+TTyr6QUmlyQbJMUovaMqjNGo
         NqffrS1qp+WcqS9ooEUfC+2OMFs04OUiSGjQETRx4uV8qRc4nCTiPx8PdYHWImf2ES
         RUhVnweyAUkQjuo8xrTI+vxxQGeLkaqgJpwC034c9fXHSIf1TquswOBWf68BrDKdYh
         Z6mhmujHUCDketUjhexzn9ejGpT0t5RHne9+ejIr6yfsQp1Muzdp5mPZB2s4dXgiBl
         0HAkdvL8CvE7FtJyPB4bZLVHYjq+Ygaz80FkgdCtztu1WYXRrb6LCSfJNa1G2p63uL
         zkti5omBNs7sw==
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, paul@crapouillou.net,
        lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: jz4740-i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Tue, 15 Jun 2021 18:29:22 +0100
Message-Id: <162377763945.21612.3642505677079279664.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615135627.1665168-1-yangyingliang@huawei.com>
References: <20210615135627.1665168-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:56:27 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: jz4740-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 50484d14ac3c9d93de0da5b8c546b1cb86df3d31

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

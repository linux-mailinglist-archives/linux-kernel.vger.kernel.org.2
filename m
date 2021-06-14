Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA593A6F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhFNT4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235489AbhFNT4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EBF36124B;
        Mon, 14 Jun 2021 19:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700485;
        bh=HlsVAzqQjfkYgEn5Uwml8vyPXW7gRkMvnO5wAcmT3sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cLz9DXFFqQk4W21hI+v0aFHln9fjlY4TKBmAxrUtvqOQbeoU1/3nLm7eaNTqHdfu9
         l6/iWlIz2hci7NRsjO6kv9qjHnjvShdImpsFkeDU2GveEKv/tg1LHKrbaLdZrV1Vwt
         qkZXLtKFOmw2GKQTdIpZ+2tyezH0QW6HteKFgJ9GC5F2C3a0g4kYPIfkBLMzkb2x2y
         PJKpHlSbYyhUP9ZcGPWBcdylcVB6RhHauGC0kCblNXpgmNLDfv3tcBy3HiYhOliV77
         CLuzqQl4PXuWXQbM5MYauCptZu2avb5UyRadhzxU38Kh6mpPuq4yQUQ8aR/16zNEoT
         Fl/S2zkHUiVkQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: axi-i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Jun 2021 20:53:41 +0100
Message-Id: <162369994009.34524.14636427113168434063.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610132705.138706-1-yangyingliang@huawei.com>
References: <20210610132705.138706-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:27:05 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: axi-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 1b7f94dd20fc9eb63c8470f9f20544b0f6742440

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

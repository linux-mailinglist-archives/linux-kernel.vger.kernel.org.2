Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353313AA1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFPQoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhFPQoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:44:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61D6A61019;
        Wed, 16 Jun 2021 16:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861715;
        bh=0Mnrn59mHPvGQI0AIZ/aQUlxSoDlnuliHsET8yMkHxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/2S8uCzHS2QWAd7s3Wly9w7Wujm9rMqp8X78fRCXgFC9j7Ej0ZfAZLKP6YNa6MdN
         Vyc98UEUO4ZaojB83B1rVOhjrDvG2rbVtMivFJtFm5sXZZ9Vl/dtSvakPjVuO2RkL0
         FmhG6aAtbOnw/Iooxr35sPZ0Ecg2wTK+gDHpJCuxxKI2I/rDmn3cWu7I+Kpjjqmtq1
         0AGKH+NWuY7uUYDnlZtwQJ+Kh+nd8OP3DKrIANF+mNaPbb7n7EzS6BN5bF589zOUue
         CNFEwEBj4FtkPw24xjF5rHzeq5bYtK6CR23G3ZYGNEMc0Vwex+/oQVcD3Bc3XuR2D1
         w9rvN74sUQewQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next 1/3] ASoC: rockchip: i2s: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 16 Jun 2021 17:41:17 +0100
Message-Id: <162386001971.25644.14560050609437971056.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615141502.1683686-1-yangyingliang@huawei.com>
References: <20210615141502.1683686-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 22:15:00 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: rockchip: i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 4ffbcd4ab0b6f77d29acde69dc25bd95318fae5e
[2/3] ASoC: rockchip: pdm: Use devm_platform_get_and_ioremap_resource()
      commit: db4d6d2e6472a5a49801bb5f2c1bd96ed6ffa3d1
[3/3] ASoC: rockchip: spdif: Use devm_platform_get_and_ioremap_resource()
      commit: 3325b1515a92fc07ec16b4d33c8bccc0a83f12ca

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF63A6FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhFNT5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235667AbhFNT5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CE9361350;
        Mon, 14 Jun 2021 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700532;
        bh=XUs/RkVRsS2DQDgtBGGjpYSxuKspJssz3WM2g5+NX30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkLVUUCv936N695noEQhWEoB4DK78vl7uecaP45/ucPL0Fj0IHfG+Cjem4rPSTMTL
         3qghGLUkK7UjjXpElI9/xxuBGBz1y7bm6dtjVbSPrvuvGqP7ovnDwoiwyKVgBo88wD
         LtuKAkKXZTYfuuJNZMVzypD6rrzyZeMI7capRDKopJJJ+U7GIPqeUXnThJ87ZAsE/M
         p6jk/8dbS0izYlUmizuOx3pqu/lfIYrDH9nRk5TX2Q8g200WrCIr4HLyJjmHwnq4UF
         dp3jTShtlYj/OWhiNn5nItHdftOAZedftG53JcZi3geVade/gOTSR58YLb7VLYdEFH
         fYlyAPtvOO5Jg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, tiwai@suse.com,
        lgirdwood@gmail.com
Subject: Re: [PATCH -next] ASoC: axi-spdif: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Jun 2021 20:53:57 +0100
Message-Id: <162369994009.34524.11852681325461893856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610133120.141405-1-yangyingliang@huawei.com>
References: <20210610133120.141405-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 21:31:20 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: axi-spdif: Use devm_platform_get_and_ioremap_resource()
      commit: 68912ebf4d4e50ac4fd41fb9879de9a6b832f7c7

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

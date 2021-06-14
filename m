Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5A3A6F91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhFNT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235500AbhFNT4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:56:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC0E4611CA;
        Mon, 14 Jun 2021 19:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700491;
        bh=YkjBzaYQqVslcwFlFmdUZmUuJIrU93d/ciBUzYyyyz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8RPq4WeGUCKsqhc15G349HkYbxWxvMReLKrkk4aV84zFI9hQpQJMIW7w/Pcd3iTL
         vogvUEoVQEXVz77lCaDzV83BUGltnZSpdUAYSWjVV+kg+N4+Z16WmMcCh2uUG48/nx
         DfrqpuM9zNBf1Df+T4UZD2ux4kIiN6Rc2oZt2hU7VM3V2VioquySVlXTKM5w2x/6yP
         Btn04SdjZj6IwPoADpfwfZ6PBnYZfz6fMg32Rm4r2GP2VucUZnTiGZ2aJ/uTPUh7N4
         i3+ilXgqbtvjmU0zDjt2rWvo3GAwNXfE/Fh29hPcBvjhYg9Lmo2qI4f9SxCBiuo8W3
         oXzSF6Do2HpWQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        codrin.ciubotariu@microchip.com
Subject: Re: [PATCH -next] ASoC: atmel-pdmic: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 14 Jun 2021 20:53:43 +0100
Message-Id: <162369994010.34524.16386719671018487251.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210611035351.3878091-1-yangyingliang@huawei.com>
References: <20210611035351.3878091-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 11:53:51 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-pdmic: Use devm_platform_get_and_ioremap_resource()
      commit: 92570939c8b952272f630f807f8ddfac58411869

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36313AF56B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhFUStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhFUStM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 340C261107;
        Mon, 21 Jun 2021 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301217;
        bh=VT8jjUiO3DASVpwIemns7UpacAV+opD53af/FKpn/Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3z4XWyBxOm/dlbGHRS3F+pNprVp1oFTb2un2UstPuDejQdlAL0PxO5uspdKS6Fsf
         T2M3UUut19kemJI9IMiak79ELrnm7c15IYEg7vZKt4at/HTAe/kjkmjRG52jAdXMT7
         dmR9KB35tkU4pJDaZ+nNG3hdNKq0Y86xNOdraNh7JtJxYCGp4THAXayUsnluG+FuCG
         pnsNbAREKpfmJKYZyiEnb3Rd6YBxq+3/enAgn9VfXy5lO6O3GkYf6qNZy7K4vtr19/
         QYMnAMQX/wei61w0KzcYMhDb6HY9SbbIaHl/R7l/SiJL48fYJNDkGEfU0Yi1ottBuz
         FU4nNlNjUhN1A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-sunxi@lists.linux.dev,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH -next 0/3] ASoC: sunxi: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 21 Jun 2021 19:45:59 +0100
Message-Id: <162430055263.9224.277778628672275964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210617045012.1119650-1-yangyingliang@huawei.com>
References: <20210617045012.1119650-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 12:50:09 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Yang Yingliang (3):
>   ASoC: sunxi: sun4i-codec: Use devm_platform_get_and_ioremap_resource()
>   ASoC: sun4i-i2s: Use devm_platform_get_and_ioremap_resource()
>   ASoC: sunxi: sun4i-spdif: Use devm_platform_get_and_ioremap_resource()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: sunxi: sun4i-codec: Use devm_platform_get_and_ioremap_resource()
      commit: 37c617f1cf062b56141a06e2ae355e3ecc8b8451
[2/3] ASoC: sun4i-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: cc384f05c05618dfcf1990054c1f40bedbb01cca
[3/3] ASoC: sunxi: sun4i-spdif: Use devm_platform_get_and_ioremap_resource()
      commit: bb17379cf278c15574b0c1c94a76531f637970c7

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

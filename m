Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762BD3312F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhCHQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhCHQIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:08:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E82C265227;
        Mon,  8 Mar 2021 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219718;
        bh=/XCkUwvD3uSx0tUge8GRpyBkUWc+6WbOCiH17QZEkLE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EWdGtKQCXleYF8OiUA4tuOsg4wHFg342IOMNqUybg8Du+k8vCHHI1S8rtELzykktW
         tV3N60cI/fjtuKDDo2SB3L/VmufTlWeNwV5hzMdPPgTVvpOe/R3YNtsJ9R3IIps9iz
         ybyQCgWbBQ7GANfSaDjCYOoM3uDBmdxcu6nAOF1kh7nQPaNAvBCxcsX6Q2qkFthYiU
         8LYlYA8upDstnNBBwvDoqdqfWEmLlbIcSOLB/YIrl2dBwX8zwWf45Lf/cclKFxE90w
         Vj/MTQ3XX7CiPtkdtJzDpoeaTceVtZkg7b6ifRHDhDMcc4LreR/ZnU7zJzuSsilU/1
         n5M3PE82hfbYA==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, Tang Bin <tangbin@cmss.chinamobile.com>,
        paul@crapouillou.net, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
In-Reply-To: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
References: <20210307072133.10832-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: codecs/jz4770: Remove superfluous error message
Message-Id: <161521960849.9621.2430171026353883713.b4-ty@kernel.org>
Date:   Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2021 15:21:33 +0800, Tang Bin wrote:
> The function devm_platform_ioremap_resource has already contained
> error message if failed, so remove superfluous dev_err here.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs/jz4770: Remove superfluous error message
      commit: 0f76a915201916dd3a21cebd7d528ca4b3112eb5

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

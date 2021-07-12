Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A03C5B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhGLKvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhGLKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6D99610FA;
        Mon, 12 Jul 2021 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086865;
        bh=p+qLz+HhOqEFcAKXAJHCu8puLmOSYZop39X5dZG07EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rU49web7RUua2IMfaM//7+M8yiIKwUXhdv/e9Lsl0tVAtN/EQj9BVMhbCL8YKua1j
         8nqoKs2sXd54M4LPlV1bq1W1VKT9dKMeRyT0E2wMNN/7JA24+0XwLvO9tTEnOJHP+c
         oBVojxFrYQ9Un5iayEwV6932dPiboBqfLQJc+3K3fEr4K+/hh8ofXz9kz/Ofx8ENti
         Mvz9XizXA8pcuNqnrWLaP0P/gSaNyMNfrGgRBKdMQC6dvc51jb7Sib1xtw3NkH9dfw
         2MS6M/Rx4rAAmiyXXO7OUf2KCWmSJzYSKe256pA3Ntsct+etX7uKAi16h0mq5WeZjw
         ZE7Nhg7tdikPQ==
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, nicoleotsuka@gmail.com,
        Tang Bin <tangbin@cmss.chinamobile.com>, Xiubo.Lee@gmail.com,
        tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_xcvr: Omit superfluous error message in fsl_xcvr_probe()
Date:   Mon, 12 Jul 2021 11:45:59 +0100
Message-Id: <162608623153.3192.455683453441836535.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624104505.13680-1-tangbin@cmss.chinamobile.com>
References: <20210624104505.13680-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 18:45:05 +0800, Tang Bin wrote:
> In the function fsl_xcvr__probe(), when get irq failed,
> the function platform_get_irq() logs an error message, so remove
> redundant message here.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Omit superfluous error message in fsl_xcvr_probe()
      commit: 8620c40002db9679279546cc3be2aceb8c5e5e76

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5307B3242CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbhBXRAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:47068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236047AbhBXQ7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:59:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF47F64F09;
        Wed, 24 Feb 2021 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614185900;
        bh=CSaPMxW/R+nasgbjStE4LdLhn39/QCJMGRLQdV56Nrw=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=SngYABIABaKgySWl0y6v5midbjvyKPKQZMjOjV4CQAJujTlTKNW9wkbBw1t6RVH/E
         IMVSI5tW5o5TjH4lVu1h6hr/iX/NsF0tOExmvNMt+kmIk3Y33m5UBY5A4mbTZ/puPG
         uPITQtVtffSM07SY58q9LlzjpdTr2oqnsULaDf4ofXJCM8ez1Ylj0a5y2usJ3Q7Pkr
         iEakPLOhJMWglBI+nUxP9JvPtAcQhw05uHn/7AphMcHAPTDoJUiKPuT/db3LymsTKx
         hWiID/tA53yZP8wj/+G9AyOquTQPFSAelcuYVqrlqUJe/+nBkNvG8E7KUlHGMKu5hk
         Eij45/68mvmWw==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com
In-Reply-To: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
References: <1614149872-25510-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: ak4458: Add MODULE_DEVICE_TABLE
Message-Id: <161418583680.1249.97940912482795422.b4-ty@kernel.org>
Date:   Wed, 24 Feb 2021 16:57:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 14:57:51 +0800, Shengjiu Wang wrote:
> Add missed MODULE_DEVICE_TABLE for the driver can be loaded
> automatically at boot.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ak4458: Add MODULE_DEVICE_TABLE
      commit: f84b4524005238fc9fd5cf615bb426fa40a99494
[2/2] ASoC: ak5558: Add MODULE_DEVICE_TABLE
      commit: 741c8397e5d0b339fb3e614a9ff5cb4bf7ae1a65

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

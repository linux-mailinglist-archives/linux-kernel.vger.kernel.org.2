Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1303F8808
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242600AbhHZMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242583AbhHZMwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:52:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5752A60184;
        Thu, 26 Aug 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982307;
        bh=VBPfc2RDjlOwkjJSe36MD49TIeYbo9Zp0QSp+FSIjTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bmr+ugHDbTZG0ASGgPyRtOStFm5RZWDjXWIsESIPJFXGsK/cNFmIkJyAB4cKXrQT7
         S2KFvEZKP6ZMQYPFW3yjVI2QNXecHzG52TITcMBFFZJ3H90O8aoNoW+Hjh81vvqJjF
         MczwVftp+HpTtoKsDntNgIUpBLPLn2fuq5zVedmOByvwfGUkJuKxChP15RBM2fFg1D
         WTM61UHIgeFFFWsC4CNQ47VJlM8QJDftQoK1Ray+l0ZuJSJK8z+SRBwobewnzGQdvg
         uwQhnjt0YRi39JK1Dw4wUff1soOB+1ZQtBjxxlReWSpdeQN2lqEOTkpofmgI92o87N
         k7NVWGvbdQQ/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dwc: Get IRQ optionally
Date:   Thu, 26 Aug 2021 13:51:10 +0100
Message-Id: <162998203955.33400.11543058130859225898.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <c857f334e3c9e651e088b675b3938cb5f798b133.1629906123.git.robin.murphy@arm.com>
References: <c857f334e3c9e651e088b675b3938cb5f798b133.1629906123.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 16:42:03 +0100, Robin Murphy wrote:
> The IRQ is explicitly optional, so use platform_get_irq_optional() and
> avoid platform_get_irq() logging a spurious error when trying to use the
> thing in DMA mode.
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: Get IRQ optionally
      commit: 2fd276c3ee4bd42eb034f8954964a5ae74187c6b

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

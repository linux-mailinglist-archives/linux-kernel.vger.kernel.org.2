Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CEE3F7840
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhHYP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241676AbhHYP2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:28:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 967A261052;
        Wed, 25 Aug 2021 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629905241;
        bh=Zr59DmCS8mnXVbmuH6P2mt8dhP1q69YOuESSZTdi8ew=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RvI2UKfCzTpcL8Veen/YUy+bD4HnitN/kC9Arbl3mBkwKtbwAUqKSbkOFUkS6wEeJ
         PhrthLy0N/BNLjMs46dzupu8RjlLivXghRvFoUFxW/F9D9qRfESPRd7Ssh9oxzOcJH
         1chm1C05jLBed6wN47MHAYYDnYDTJMxuaIHiQgHvoxIIivM/ORb8VY975Om/o7VUbf
         dwPiBjGaE80KgmDkIZ5lA1tOhDk4CeTyPgk5qgcfcSSs0DtJPFbBa+RUoxLk+2LVBL
         kcgP9skWu2SfL9Sg2NCIlT3pmGMH1pLYu24oKb0nI4memDzQ5YawzXAxSZ4Cdccvpr
         b/bwPNQNoQtyA==
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210825033704.3307263-1-wenst@chromium.org>
References: <20210825033704.3307263-1-wenst@chromium.org>
Subject: Re: [PATCH 0/2] regulator: vctrl: Avoid lockdep warning in enable/disable ops
Message-Id: <162990416261.56667.17765131822739903662.b4-ty@kernel.org>
Date:   Wed, 25 Aug 2021 16:09:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 11:37:02 +0800, Chen-Yu Tsai wrote:
> Here are a couple fixes for vctrl-regulator. This driver is only used
> RK3399-based Chromebooks.
> 
> Patch one fixes a misuse of the regulator API, which was found while
> tracing the code to fix the lockdep warning.
> 
> Patch two fixes a lockdep warning and actual (not easy to reproduce)
> deadlock.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: vctrl: Use locked regulator_get_voltage in probe path
      commit: 98e47570ba985f2310586c80409238200fa3170f
[2/2] regulator: vctrl: Avoid lockdep warning in enable/disable ops
      commit: 21e39809fd7c4b8ff3662f23e0168e87594c8ca8

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

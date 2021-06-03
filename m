Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA42239AA47
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhFCSob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhFCSo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1550613EE;
        Thu,  3 Jun 2021 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745763;
        bh=JwFRxF3tjqLO/dwyb7DD5T+R8yZHfTgHpugrWAycjDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTlmD4WVnchLPSfNnpVyM9RjtQ3rRNqwlh5zXs7b6d10Il0vwfvVVoTYEdiONVpIR
         JqJ93Dai//RKRUVadhoAaF04rib/FQwnLjr1yhRMoodXnDBz394h3/VOBQXRusqzcd
         wVI5T5Z+HB1uf6wI8GYgEpy1JOdsYy0NrCJUZD7vegWsy0PAq+MOyEELD7B86v13Rm
         gk4BtuYXr3x3O33X0AtiHKFwkaDBi5/fYp/XCe+JLJDOUqcBDF+ZmoZvMdE/eMmHpT
         ln2JoVJBSiTwla6n9dTbOrNKLXaA1PP/5zmIRvYBTWJdU3V826vzEABqJlLcTRvIO6
         wp5zrxHjnO+Lg==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Yunfan Zhang <yfzhang@marvell.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: fan53555: Fix missing slew_reg/mask/shift settings for FAN53526
Date:   Thu,  3 Jun 2021 19:41:54 +0100
Message-Id: <162274566700.14958.13292264422709732742.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525124017.2550029-1-axel.lin@ingics.com>
References: <20210525124017.2550029-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 20:40:16 +0800, Axel Lin wrote:
> The di->slew_reg/di->slew_mask/di->slew_shift was not set in current code,
> fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: fan53555: Fix missing slew_reg/mask/shift settings for FAN53526
      commit: 30b38b805b36c03db3703ef62397111c783b5f3b
[2/2] regulator: fan53555: Convert to use regulator_set_ramp_delay_regmap
      commit: b61ac767db4d62540732cdac9f1820e56b9a5008

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

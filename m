Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC7E31906D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhBKQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:54:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhBKPlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:41:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 694CC64E92;
        Thu, 11 Feb 2021 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613058022;
        bh=I/iKB8S0skjhpFTPY5lvQWB3Nkdrg7bAnMTh1c21qAI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XdwyEO0XQcKQ3AtWNWPHIM1TZWJ/xcNiuN4phr8fBVQZQYztF9WxA/8Cc/pQt5gqY
         wtuqXS379/YiWyfsaEekXXLK8c3H0bMxYaFBrleqvkQPWFQ/j4RBr/Loa1/DvskAbD
         +PsOJ91powdi+On/NlD5iS0Uk8nOoHAxRJ6wmjKf29QOCV0BYBgCKvUQLNEdzf1bPS
         dukrQlN+ItbGSEdRbuxilT1kjz1CvAEvf9SC5LRSflEqzK0tYvrqm36242uTtNi4OB
         byIdpdg4I5Z4ZgLHLaAUNvs54Bauzhw+h9s/XGqzlFnbebdP/TruQ+I+Qd0ft2mFDw
         S9SUm8OBfh59w==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
In-Reply-To: <20210211105534.38972-1-frieder.schrempf@kontron.de>
References: <20210211105534.38972-1-frieder.schrempf@kontron.de>
Subject: Re: [PATCH 1/3] regulator: pca9450: Add SD_VSEL GPIO for LDO5
Message-Id: <161305796963.12598.9966627960730091352.b4-ty@kernel.org>
Date:   Thu, 11 Feb 2021 15:39:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 11:55:28 +0100, Schrempf Frieder wrote:
> LDO5 has two separate control registers. LDO5CTRL_L is used if the
> input signal SD_VSEL is low and LDO5CTRL_H if it is high.
> The current driver implementation only uses LDO5CTRL_H. To make this
> work on boards that have SD_VSEL connected to a GPIO, we add support
> for specifying an optional GPIO and setting it to high at probe time.
> 
> In the future we might also want to add support for boards that have
> SD_VSEL set to a fixed low level. In this case we need to change the
> driver to be able to use the LDO5CTRL_L register.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: pca9450: Add SD_VSEL GPIO for LDO5
      commit: 8c67a11bae889f51fe5054364c3c789dfae3ad73
[2/3] dt-bindings: regulator: pca9450: Add sd-vsel GPIO
      commit: 27866e3e8a7e93494f8374f48061aa73ee46ceb2
[3/3] regulator: pca9450: Enable system reset on WDOG_B assertion
      commit: f7684f5a048febd2a7bc98ee81d6dce52f7268b8

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

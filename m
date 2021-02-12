Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE0A31A041
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhBLODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:03:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBLODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:03:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C682061490;
        Fri, 12 Feb 2021 14:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613138547;
        bh=F20AnwF+TvS+zwwsrCtysPu9GrbudAMXhAJTidO7JcY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=G0R0I5VhUovNUFJSeTOkGtp1jsVvKKXbjJijJk+VVfWcNG+MdqegI0enpsLvqART8
         5nGIkfHla3mvWn+2JQyASrPYZg4PA/EAQrjLam73gSZFnWfbcXA/eB4dKXrTF5gDIk
         5NBiOvqw/c3NVIdlc0v+HjsqJ5H6EsXV08qFpAAoaKP/aeBSP42u68tmQjZbGq/etf
         AnyoxMxluYmRsRpiSr0WLBhZwewpPdptn5iEVtrHfSlMCz6kYU+8y7km3G+jWbknjF
         5WECXyltwcFB2/dKnbdmu9eorLnyN1vwc+8xZ094dVPlBAfGr7+AfLQREBSh8+a1H+
         oFCZ+8KzM51PA==
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-power@fi.rohmeurope.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210212080023.GA880728@localhost.localdomain>
References: <20210212080023.GA880728@localhost.localdomain>
Subject: Re: [PATCH RESEND] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-Id: <161313849261.18228.6540214535407961769.b4-ty@kernel.org>
Date:   Fri, 12 Feb 2021 14:01:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 10:00:23 +0200, Matti Vaittinen wrote:
> The ROHM BD718x7 and BD71828 drivers support setting HW state
> specific voltages from device-tree. This is used also by various
> in-tree DTS files.
> 
> These drivers do incorrectly try to compose bit-map using enum
> values. By a chance this works for first two valid levels having
> values 1 and 2 - but setting values for the rest of the levels
> do indicate capability of setting values for first levels as
> well. Luckily the regulators which support setting values for
> SUSPEND/LPSR do usually also support setting values for RUN
> and IDLE too - thus this has not been such a fatal issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7, bd71828, Fix dvs voltage levels
      commit: c294554111a835598b557db789d9ad2379b512a2

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

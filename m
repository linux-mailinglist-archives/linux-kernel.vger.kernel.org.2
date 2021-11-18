Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9794F456327
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhKRTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 14:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233406AbhKRTJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 14:09:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5ADC611F2;
        Thu, 18 Nov 2021 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637262381;
        bh=rNZifMDEF0JahX/dp8msj9TUp+FDQHZfIPbz/FrHK+o=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RjHtOsdG882YaW8Ko2LMGvZ87oduP8Y4q1LZ3ZQcMXlke6E27Gba9Tzg21yjI4ozo
         CTLqZ4cNVmnI40ZOheAY3fMm12pxqwX2lcjzWI+qN/L71XKqmbPHRPfnMvfqUXkfy1
         NBbB7m6pVI/p+wqlVqfgKvjywSqjX4nfq+a3HlMuANhYtuCa7YxRfsSm8vdHYveLuW
         +oownVrqKewmXvc3jcwvX9y1Y4ocN5aXZYn1EJV3BU0s3SYOGkCVJ9jmxyX/xTXrh4
         TFTIROhGmX7YbT0GNF7Ebbr5HGYso1nq+7gO2BKQGuvu97+/QXK7qNQjQmc8PL3p1o
         FdbH49ciDv3WA==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-power@fi.rohmeurope.com, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637233864.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: (subset) [PATCH 0/5] Few miscellaneous regulator improvements
Message-Id: <163726238042.96440.10857054540797519740.b4-ty@kernel.org>
Date:   Thu, 18 Nov 2021 19:06:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2021 13:47:59 +0200, Matti Vaittinen wrote:
> Minor regulator improvemnts / fixes.
> 
> This is a collection of minor improvemnts done while developing drivers
> for yet another ROHM PMIC. Please note that the new generic function
> added in Patch 2 does currently have only one in-tree driver using it.
> (call added in patch 3). I intended to post this with the set of patches
> bringing support to a new PMIC - but it appears this new PMIC requires
> one more HW-iteration - meaning it will be delayed probably by months.
> It'd be easier for me to add this upstream now in order to avoid
> rebasing/conflicts with other changes introduced meanwhile. Please let
> me know if you don't think that's Ok.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-linus

Thanks!

[2/5] regulator: rohm-regulator: add helper for restricted voltage setting
      (no commit info)
[3/5] regulator: bd718x7: Use rohm generic restricted voltage setting
      (no commit info)
[4/5] regulator: Add units to limit documentation
      (no commit info)
[5/5] regulator: Update protection IRQ helper docs
      commit: 6966df483d7b5b218aeb0e13e7e334a8fc3c1744

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

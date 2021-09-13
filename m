Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD1408975
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbhIMKzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239244AbhIMKzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:55:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99EA161029;
        Mon, 13 Sep 2021 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530461;
        bh=7SoHMau3vdtXBlUYBVGtLEzivVVAF8EKZvzEie7Av2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHrvamLEodjxM89TVKCGRxoIuNa5bbcW7fjmK/+VGzsiNXHBuMJRViM/3dDG0H/jy
         rS6dk4wVsCKFa3OvcUxM2nv18iAktGn6nF23d67orSE6sOGxLkgU7CEQHpjd05anqN
         Cdm+W+fUBckSA8/BdGOjm8dW5Qq/UXIgxOhnz/o/ZIoKExMsF+Yv/meJfFT3BZqho4
         9GfTmPuZAa8W4v/ofO2uwSV50Qfkd+sYrRhR959h7Ri+lXfpNWdetIxglXyj7JABM3
         OyIO0I1wrfdHMGq6xipiIWozIF9faNT3xVNoy10eb4zYe5RaKde7ii/YmDQgHTIbQD
         OlyQHYlLtfhfg==
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
Date:   Mon, 13 Sep 2021 11:53:09 +0100
Message-Id: <163153010299.45871.7351397840665144574.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 12:40:17 -0700, Brian Norris wrote:
> Voltage-controlled regulators depend on their supply regulator for
> retrieving their voltage, and so they might return -EPROBE_DEFER at this
> stage. Our caller already attempts to resolve supplies and retry, so we
> shouldn't be printing this error to logs.
> 
> Quiets log messages like this, on Rockchip RK3399 Gru/Kevin boards:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: resolve supply voltage deferral silently
      commit: adea283117225281ecf537171a06dd6e430bd8db

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

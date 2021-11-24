Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC72445CB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbhKXRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236655AbhKXRkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1735B60FD8;
        Wed, 24 Nov 2021 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637775419;
        bh=SRaOQ74XtrFJSFTX7eYvSNlU270N9TLo0m1cvaZc9ig=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fTpqGd0Q5pm4nXrQgz6G4LwwUiXDRah2JHlGu8ZgJyKK2f53+bSCeKaQquPxOP+S2
         BhYaJWLPcXTKlDzsdyJWzobvFVaHlTjbCNTsR/OHn0LA8qU+HqF4MQVqvNg1lGAd0q
         v8gotESvNQSidjSx9DQHFlKYJdiV2oMsf6CsBFPQl7n7j2BNwKI+IJyGJsqLo0BpJz
         LgRmiJDtsypKAAdEzMnEMRZlJHRaWzgukt3H09qbSNMqJPkhyrFdT3BDIbA/prxmXu
         iwZYAvpUYt0jhgcH7B9c3ir+fAtNbfqya5/2G3bNjCcrSSQLmoEaIPHfqxo0R1k7Fk
         sjlJxlPVXftXA==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
In-Reply-To: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1637736436.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2 0/3] Provide event map helper for regulator drivers
Message-Id: <163777541783.2712255.18211260273223103314.b4-ty@kernel.org>
Date:   Wed, 24 Nov 2021 17:36:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 09:16:18 +0200, Matti Vaittinen wrote:
> This series provides an event map helper for regulator drivers and few
> other minor things.
> 
> Regulators which provide trivial notification IRQs can use generic IRQ
> mapper. Trivial in this context means the IRQ only informs one type of
> event, for one regulator.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulators: Add regulator_err2notif() helper
      commit: 6fadec4c5561e2fbe1dfa8a7da9bc58d094a8f04
[2/3] regulators: irq_helper: Provide helper for trivial IRQ notifications
      commit: a764ff77d697a4a13e69b3379cc613f7409c6b9a
[3/3] regulator: Drop unnecessary struct member
      commit: 1b6ed6bf32fb22ef8e3572fc9c0f6454adf1ca40

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

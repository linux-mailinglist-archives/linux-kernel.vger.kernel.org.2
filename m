Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529533242D5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 18:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhBXRCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 12:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235993AbhBXQ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:59:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFF0864F08;
        Wed, 24 Feb 2021 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614185956;
        bh=hzvrMSLO1q+hRIWUDxqlPY6OHL+sFjjcTVa7JnpG7ac=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lU+RoSHRxmMXZrMykr2Yk9Oy0ylpatWanVCYRfaybJH9S8F0g+eNCdu/ClsAlh3Be
         mfII8+WdMREtbVpGh0ex0Zg/eNxjPzkPLx8pGaM/KKr5nCqLKg7A9uEOF7Xwpfsc+G
         T2QDXCIeg2Ab7mCe4fmwP/i49PiBVvWD2ajhkaMjvn/x4KWXWeAQpdaUNyksKVJnuA
         WC6dsTGMmGyyVsYOrcFaJfWpzd6D8fJitTP+MoyzrdzFSmHaMeCQGdqaZYqu6DG1fO
         GQc6jDZvB7swzKV1RosDoKsiz+Y8oHdD2gO8oLYMoAyfW4HxbbL6fC0BtKyrBc2oHP
         /doYak0g3/xhQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Axel Lin <axel.lin@ingics.com>
In-Reply-To: <20210222150809.208942-1-frieder.schrempf@kontron.de>
References: <20210222150809.208942-1-frieder.schrempf@kontron.de>
Subject: Re: [PATCH] regulator: pca9450: Fix return value when failing to get sd-vsel GPIO
Message-Id: <161418588690.2546.14072185578047048603.b4-ty@kernel.org>
Date:   Wed, 24 Feb 2021 16:58:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Feb 2021 16:08:04 +0100, Schrempf Frieder wrote:
> This fixes the return value of pca9450_i2c_probe() to use the correct
> error code when getting the sd-vsel GPIO fails.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Fix return value when failing to get sd-vsel GPIO
      commit: ef4848a6532ba0b241d3b6cad70378ff2c5615ca

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

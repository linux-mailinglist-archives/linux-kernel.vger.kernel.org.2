Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442FB39793D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhFARkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233397AbhFARkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85DA8613D0;
        Tue,  1 Jun 2021 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569121;
        bh=XfUMjWuffX45+qjURFka3P5oHNGcgYqbkz4oq89yWwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1PAv+QbixO1aNTn7YIm3W3aER+xy+Ak2P2JhDK9/5ZPVTsgaSCC6N2Eidt8FrJVG
         3ZYVQ3BH/93WaSqgfvmV6FB5KvPWSLmDG79xkLUmQ13kTjtfGpS+VX7qbqLxGHrvEs
         Xuw1oBorKis3+mYZ3QAzazF154FeQa27zqRDHUvX81kqGJnNNJkIw4NNf2Kt2sSuyZ
         vyJ0KaL3/ZMmU44hKc4pDqZXqtLTiG4xn+WGSsX6xhJuTGblpDYI2yPPVT2OYCF/lT
         67DxTrQxXhLjgDZpfW7c0F9gHbMCtSJP7EFfxkthV6mUmkdYO9Pd1FdbS0B3PutYhp
         LB1fEHZar+G5g==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-power@fi.rohmeurope.com
Subject: Re: [PATCH] regulator: bd70528: Drop BD70528 support
Date:   Tue,  1 Jun 2021 18:38:04 +0100
Message-Id: <162256901745.20048.17375939757195771137.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <d7271362129edceebc512b49efed9ee7c3efcb6a.1622116622.git.matti.vaittinen@fi.rohmeurope.com>
References: <d7271362129edceebc512b49efed9ee7c3efcb6a.1622116622.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 14:59:29 +0300, Matti Vaittinen wrote:
> The only known BD70528 use-cases are such that the PMIC is controlled
> from separate MCU which is not running Linux. I am not aware of
> any Linux driver users. Furthermore, it seems there is no demand for
> this IC. Let's ease the maintenance burden and drop the driver. We can
> always add it back if there is sudden need for it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd70528: Drop BD70528 support
      commit: 71de5d6e63c992abe037c43bc581cff432a5a1c4

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

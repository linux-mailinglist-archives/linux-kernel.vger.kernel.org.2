Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73F138E60C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhEXMCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232790AbhEXMBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:01:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBD7761360;
        Mon, 24 May 2021 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621857627;
        bh=t0YSFRPLDmCngvuQZkTNqXNtzWvSfCH7Pm0CGDz72aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pexfz0N9d3wjVj4fgQSfledxyhOeG3qw3XRVUNCCAFzP7ckBkJcCT0gqVplb79Y8M
         6jvEOawtirNAZ43xV39tIDYMEJkoLTg8Vowqqev9rq80toSBUY92YRowE3LtXz9+M/
         ymaU9MxhSxqAEL3LPEMWTRMYBpzwO2akbaK/Xf4PkVu2zlVzQgJcxWemVAZkELTqXn
         q7VMKM5aUjyk90NHP5YadcyCar2qgxEezC1YcOT2V+xViu3DJI5VTNSO3F3PV0enlj
         li6KXUyVQktaKLaVgNMLNO76XPzYrUwgaDE6N4hhaD0DVFGZAm/N062QvdUU29Om0v
         LsOnTwcAkb8yA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: bd71815: add select to fix build
Date:   Mon, 24 May 2021 12:59:55 +0100
Message-Id: <162185754506.49496.1608353322431738492.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523001427.13500-1-rdunlap@infradead.org>
References: <20210523001427.13500-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 17:14:27 -0700, Randy Dunlap wrote:
> Mend the Kconfig for REGULATOR_BD71815 to prevent build errors:
> 
> riscv32-linux-ld: drivers/regulator/bd71815-regulator.o: in function `.L0 ':
> regulator.c:289: undefined reference to `rohm_regulator_set_dvs_levels'
> riscv32-linux-ld: drivers/regulator/bd71815-regulator.c:370: undefined reference to `rohm_regulator_set_dvs_levels'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd71815: add select to fix build
      commit: 5ba3747dbc9ade2d22a8f5bff3c928cb41d35030

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

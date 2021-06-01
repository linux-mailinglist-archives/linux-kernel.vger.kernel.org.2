Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FAF397937
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbhFARkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232225AbhFARkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CCD2613CE;
        Tue,  1 Jun 2021 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569107;
        bh=ScUxWz5hCqoO9AKm3rUh27NPEa9gF3fBAarGu4pokMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufjO36smTlA5CHC2jW6G6INmwUVXN+h9mdEQyLuH5ltdJ2XGJBlesi1WA0SMz2/a2
         OodG9CYR2lQZ0aSMSEaSwAqJeN2DzwwY4hClSM7DeclMQRw8FSXgG+QkeOafGaMFDX
         gdw7pjX6LAz0dffkMFYJ7VhfNOZWVQq/I4EFAJEC3zrNdtLAdvRYkuZ5VxOgOKQAWf
         9H6Ii4AomHr95cbUd/Y98hq/ZnnrB6KNqjE10Vjp3F5liw7e3QmVHOkhdVl67raCkh
         /rAvoxSG9upL/ZBe28PSs8uBuiGNB1Btjlv8A51i3rDtorLaOSOuBR0mtWvEltOcvm
         8xadOBrbp0Ztw==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>
Subject: Re: [PATCH] regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap
Date:   Tue,  1 Jun 2021 18:37:58 +0100
Message-Id: <162256901746.20048.8698175112467539750.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526122408.78156-1-axel.lin@ingics.com>
References: <20210526122408.78156-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021 20:24:08 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pca9450: Convert to use regulator_set_ramp_delay_regmap
      commit: 4c4fce171c4ca08cd98be7db350e6950630b046a

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

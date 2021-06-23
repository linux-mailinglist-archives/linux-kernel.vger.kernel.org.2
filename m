Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD23B1E57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFWQMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhFWQLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71143611CB;
        Wed, 23 Jun 2021 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464577;
        bh=ndUQ3TYporJmT1LvwXbbjxKXfjQvidrtfBX+LWqpbcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnXyq/fdrKkwRtwrcDwVhE/MXeqT+5wI76qD6FVtPDA0U1ZlZmgaZNhrjeqbKzEVG
         tsiBFAxiVi0UpvwgU+mDMJ/IRq7Mo7t4e6IyOGEJzVYMW2lZ1Fu2eT2upduF4dN9Ne
         nk6YXxh8ka+ZjC1w0oOx80YwsdNwyjHmj6B11xtnmVoiaqWQliUliyB/9QBeQCV5ff
         j/lrK/K7bNyXLfXqfbtgKOiK1s3Cmf1raCuzPbqBEiDTLVqc86NRufIZMyf4QhN/aL
         uuJZY4j11K/EJo7wV5pgAXkFTOwEkJcNFY4g1MyTPbU1Mj8uGA9sv65oDB1U0S9jLe
         q6Wwdfu7K9dUg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-power@fi.rohmeurope.com,
        Colin King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][next] regulator: bd9576: Fix uninitializes variable may_have_irqs
Date:   Wed, 23 Jun 2021 17:08:54 +0100
Message-Id: <162446430310.55481.3940596483000012413.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210622144730.22821-1-colin.king@canonical.com>
References: <20210622144730.22821-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2021 15:47:30 +0100, Colin King wrote:
> The boolean variable may_have_irqs is not ininitialized and is
> only being set to true in the case where chip is ROHM_CHIP_TYPE_BD9576.
> Fix this by ininitialized may_have_irqs to false.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd9576: Fix uninitializes variable may_have_irqs
      commit: ddf275b219ab22bc07c14ac88c290694089dced0

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

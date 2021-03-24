Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469534856B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhCXXkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239046AbhCXXjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:39:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9144761A1E;
        Wed, 24 Mar 2021 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629193;
        bh=9lwrwwc9qJrB0wTRE+czgDoYiVYuRYxt5dOIbqbFoSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRn9ALkDuR8tUvyUPZN/iR3wI4Ajh49CzxoCYqplQHhqRxNue8foyow+8f2XSgyKM
         naL4FrjqqOVybVbnXYFg3L6UOhMo/mRVVbCCt6RphuJOayoj9aYiIzGOPOnVHi+S1h
         pe0w3N+kLcqb8JJafCdLTVnGzfu3ZTGfu+W0TN9SWqKPdvrwlbYf38M4Ns90Zem5Oz
         j8sbNeMdg82fLgV00i8joZDi2T/0m/stAKjKWSs07fWC0vdCVXu7zzlt8wBFcsHuG6
         EIvxGZpE07J+hqG94e3XU2+qn0F1i2RmJK7nqI2TxRBcowBvKoMs1Sa8p+CJvcG96L
         f5fa15HHIrwDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jian Dong <dj0227@163.com>, matthias.bgg@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Jian Dong <dongjian@yulong.com>,
        linux-arm-kernel@lists.infradead.org, huyue2@yulong.com,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] regulator: mt6360: remove redundant error print
Date:   Wed, 24 Mar 2021 23:39:35 +0000
Message-Id: <161662879863.51682.14978085151752352194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616502161-125407-1-git-send-email-dj0227@163.com>
References: <1616502161-125407-1-git-send-email-dj0227@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 20:22:41 +0800, Jian Dong wrote:
> fixes coccicheck warning:
> 
> drivers/regulator/mt6360-regulator.c:384:3-10: line 384 is
> redundant because platform_get_irq() already prints an error
> 
> in fact, it is not platform_get_irq but platform_get_irq_byname print error

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6360: remove redundant error print
      commit: f56f2b953bccabb9bd283a734c7e35a1bb1c1ff8

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

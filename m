Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660A43F4958
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhHWLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233170AbhHWLHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA659611AF;
        Mon, 23 Aug 2021 11:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629716798;
        bh=B8qTbjCGrX+R5ZOpMgqJtdu3LoWeHvIMX/w68CI+clo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ckf0ZC8Ws9wwC1kk6rNfsKijoilw0g2CG7VPsR+eNyw/g2SoVZ39FJOKcpcgGhWeO
         jojc14UN/X+dQj9XH10hmo8nH09yuzLgBZ3AaZ2Z8gXM0E8xvx6x5bGMdRndGy/QZp
         DdHaKA1QcoC/yEoNFZbYElO55l0XNuY70vCMPboW7Oj+7uV/RScYY5MSdKhq61SWQ2
         0Jg/atinr1E/OrJlv7MHxDUaT6v5UKPn5c9NtpQr2iUPuVeqE3HmK3WcBfz24DFNAh
         ttNVyFa4nrm96XTsmmLzKfzhUTaH9LCtXSbTm2nhzojplEfML53ewAth7wLq3bMl/l
         npslB7wXAhrxQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: Documentation fix for regulator error notification helper
Date:   Mon, 23 Aug 2021 12:06:12 +0100
Message-Id: <162971664758.27145.14089229701843613260.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210823075651.GA3717293@localhost.localdomain>
References: <20210823075651.GA3717293@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 10:56:51 +0300, Matti Vaittinen wrote:
> The helper to send IRQ notification for regulator errors had still
> old description mentioning calling BUG() as a last resort when
> error status reading has kept failing for more times than a given
> threshold.
> 
> The impementation calling BUG() did never end-up in-tree but was
> replaced by hopefully more sophisticated handler trying to power-off
> the system.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Documentation fix for regulator error notification helper
      commit: ad3ead1efe057029bf112e13d7ef5901915d6abd

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

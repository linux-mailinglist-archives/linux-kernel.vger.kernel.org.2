Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11A3C5AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhGLKua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234154AbhGLKty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:49:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7381661154;
        Mon, 12 Jul 2021 10:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086826;
        bh=Q1xKdMk3/jt+0xiQ8XGvMm8d0oLgksR31bGoJlP8nwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nck2F6ZV8EYCMtEhEwpRMA780g2E85pULzFMMx2iPSakB59pdv4ebi+7gSmbvy7Sr
         9rGRckHZnCtW3sR6KnGPatTbzD8q9u14YZjxorBapUnsrP//0dJlUPLK4ItCqXLAdI
         TZo4QuKr8v6jxkbg51XeNzxAmxNtoaZz7Mmc1+z7DkGVoobploB3Tj1tPzS247ZvB/
         FVBExhYeXj1gOohWMcxnc1UzZhqDDuoTmoKRrzGuOa8pdMz+91ReaxBX5HFOR4MpFr
         5bi9EncrpgtmpQFVx9TT912Q2VbLJBKGKyDaT7YtBxZCfPwgt4+pqO80V5A2a0sRmI
         hVqK7wcza95Eg==
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH 0/4] regulator: devres: remove unused device-managed unregister APIs
Date:   Mon, 12 Jul 2021 11:45:45 +0100
Message-Id: <162608654077.4419.15973416226245111161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625122324.327585-1-aardelean@deviqon.com>
References: <20210625122324.327585-1-aardelean@deviqon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 15:23:20 +0300, Alexandru Ardelean wrote:
> These APIs aren't used anywhere and most-likely exist because of the
> general principle of C APIs, where if an API function does an
> allocation/registration, it must also have an equivalent
> deallocation/deregistration counterpart.
> 
> For devm_ functions this isn't all that true (for all cases), as the idea
> of these function is to provide an auto-cleanup logic on drivers/system
> de-init.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator: devres: remove devm_regulator_unregister_notifier() function
      (no commit info)
[2/4] regulator: devres: remove devm_regulator_unregister() function
      commit: 4ff75a29976590bc7afe3ed75d547c1f2a924c75
[3/4] regulator: devres: remove devm_regulator_bulk_unregister_supply_alias()
      commit: eed43b96ede9c3f018ad24149de83f24b86ad729
[4/4] regulator: devres: unexport devm_regulator_unregister_supply_alias()
      commit: 4d9f4d1de3ceb84fa6ce68177a26b8fac6a71290

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

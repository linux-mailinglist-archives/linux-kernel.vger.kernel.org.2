Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61613AF569
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhFUStI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231877AbhFUStA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:49:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 587F761107;
        Mon, 21 Jun 2021 18:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301205;
        bh=QGgbjyIX4p3N5D6KwhnngWMdMLpJ203ItJ/RVvow5yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yio1NTXkMjmYBXi99CcMnznOQOXwPOtQfFl15IdS9VzekLOdthbwuPDvA0y9KKq8t
         ZJbtUxMCApjuPPWbtOLqvU8sUU/ToCAn8M+LmrzkXsyZffr9MLGoA6SrFd0qtOZNq5
         eF2Jfsg3C0l/LBJZ1qdd4Y++bYCeySr0ldJjlHVOIweoDedkT8iBujGWEecvKDRVh8
         zBh9HudSHzvre40h2kfD/n+34aIVO9yO5sSMMvs+g1ABFMHo/rW4hfQ9zMGvoz1Q9U
         eNS+pAHB5oaoPpUExatcZeFpNfw2b+bnK5ZNVfhrRydYmRx09GAOiR7718e9zScsDH
         RBVkHNBG1f8ig==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Hao Fang <fanghao11@huawei.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: hi655x: Fix pass wrong pointer to config.driver_data
Date:   Mon, 21 Jun 2021 19:45:55 +0100
Message-Id: <162430087047.9551.8291897675416686404.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210620132715.60215-1-axel.lin@ingics.com>
References: <20210620132715.60215-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jun 2021 21:27:15 +0800, Axel Lin wrote:
> Current code sets config.driver_data to a zero initialized regulator
> which is obviously wrong. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi655x: Fix pass wrong pointer to config.driver_data
      commit: 61eb1b24f9e4f4e0725aa5f8164a932c933f3339

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

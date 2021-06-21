Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C523AF558
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUSsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 14:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhFUSsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 14:48:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E44BE61107;
        Mon, 21 Jun 2021 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624301190;
        bh=Z71y+SBq3KMuZ39iEoJG5bILoscerM41HzpRFtX8OTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjJHQU6j1u/LdayzRIMOu0sHi0PjFxq5KH6jRz9DeipD/Le/idkeNXGQqShj3tyMG
         Dn7Wg5PDZnkCg9ICE2qMFarhaO4PW1gm12tyVDJAW1eKNeziEM0uYeYptJDXgvhTuu
         pg9gRmaLjwxcBZ1zwLBx0YjFliO4cyZFNUoLdjum4rDUGvJBPrJSqElZr8X8YP+C3B
         EYOh1KyDj/0vpzmyG5s1Z1qplleNOPKPvt6lR2P8JmcoR8TApEpJAaXNhOdrqpw4/Z
         /JYZzdVSWzhaJ4ZFxls3vv48inrmTl6iAOJGZ+xuX8FvtbGec5ibnRIqJcDzSkYmr+
         yo19XlLZJicBA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: hi6421v600: Fix setting idle mode
Date:   Mon, 21 Jun 2021 19:45:49 +0100
Message-Id: <162430087047.9551.3163979267051992655.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619123423.4091429-1-axel.lin@ingics.com>
References: <20210619123423.4091429-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2021 20:34:23 +0800, Axel Lin wrote:
> commit db27f8294cd7 changed eco_mode << (ffs(sreg->eco_mode_mask) - 1)
> to sreg->eco_mode_mask << (ffs(sreg->eco_mode_mask) - 1) which is wrong.
> Fix it by simply set val = sreg->eco_mode_mask.
> 
> In additional, sreg->eco_mode_mask can be 0 (LDO3, LDO33, LDO34).
> Return -EINVAL if idle mode is not supported when sreg->eco_mode_mask is 0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421v600: Fix setting idle mode
      commit: 57c045bc727001c43b6a65adb0418aa7b3e6dbd0

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

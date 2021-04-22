Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6E368530
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbhDVQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238023AbhDVQuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:50:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8503F613AF;
        Thu, 22 Apr 2021 16:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619110166;
        bh=1BBf7dzaGT5zN0sedP/7pTfU3lCJHSangI/oKj4i2HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPHj0bOLLoEohnBziFDXXa/s/h593E2gdgJZacQ8BYHMRHvMFJND/Rd4N/nkQCV+Q
         ZpHVvB+QR3B8Aox08SwNji1yysjuaNL2iymWi5TEURqJk737InMGO9xmRnX8IhB4Ct
         xRoRqVAhc1FcmBd8N+4Ep656zHYOxkTNh4ig+JThHKjIrE16d6mDi/uoDcB8vPgu8z
         r9c9RbysiycgaTxFbFf4Vj6JWxTGGZtpnzh20v7Lo373YVHGiUdrPhJwhZ1yB0G0yO
         WuVRk39F/lmGe51qApxuYAraOb5DROs2GZir4aqBxjAtEr56iQSYBoAQYztl5iIIk8
         t7alyMaJFHHCw==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH] regulator: core: Respect off_on_delay at startup
Date:   Thu, 22 Apr 2021 17:48:47 +0100
Message-Id: <161911001187.37672.7744154179151628309.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210422083044.11479-1-vincent.whitchurch@axis.com>
References: <20210422083044.11479-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 10:30:44 +0200, Vincent Whitchurch wrote:
> We currently do not respect off_on_delay the first time we turn on a
> regulator.  This is problematic since the regulator could have been
> turned off by the bootloader, or it could it have been turned off during
> the probe of the regulator driver (such as when regulator-fixed requests
> the enable GPIO), either of which could potentially have happened less
> than off_on_delay microseconds ago before the first time a client
> requests for the regulator to be turned on.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Respect off_on_delay at startup
      commit: a5ccccb3ec0b052804d03df90c0d08689be54170

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

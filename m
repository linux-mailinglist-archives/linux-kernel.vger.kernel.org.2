Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6019E36731C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245428AbhDUTFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245411AbhDUTE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:04:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7AC6140D;
        Wed, 21 Apr 2021 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619031865;
        bh=uio1e+II3w+40s9NsEFcPCafRMZXIll2w56hbRzU3Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTNFSZTnSEuv9KB71uf2I4Gan2wkj5g2zHmEI1+92oJuRz6y45fbV9nBE/dsE4x7/
         8xGKsBCjGyPawYRkvrILdk9mVTnaajAs1CefJr7QpgD6tBB0/aBObwdYGHZXA5SbkF
         biu2jtHvA2tFpTElAT4K3S+o7f59AVoONfVFpiQSCtPyJTBibHVgq15MtAoxl2Akp9
         u9klHclh817KjT3qxFy6t3GMJZKDwZMAI2AyNTPYvs9ZkDyS7SBnl2aComBAzEjAd4
         Ww41/3hkJWqeVn2GbfprOcy4WK6hd9Yc0lmiyMZINwp7VYRW4+Ddx5GtSuKm6lPvDr
         ZzMQN+fAxJVuQ==
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH] regulator: da9121: automotive variants identity fix
Date:   Wed, 21 Apr 2021 20:03:31 +0100
Message-Id: <161903035952.13561.192782028802996654.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210421113208.D9E6E80007F@slsrvapps-01.diasemi.com>
References: <20210421113208.D9E6E80007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 11:32:08 +0000, Adam Ward wrote:
> This patch fixes identification of DA913x parts by the DA9121 driver,
> where a lack of clarity lead to implementation on the basis that variant
> IDs were to be identical to the equivalent rated non-automotive parts.
> 
> There is a new emphasis on the DT identity to cope with overlap in these
> ID's - this is not considered to be problematic, because projects would
> be exclusively using automotive or consumer grade parts.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9121: automotive variants identity fix
      commit: 013592be146a10d3567c0062cd1416faab060704

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

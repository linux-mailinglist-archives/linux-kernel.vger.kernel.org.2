Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124DB40C831
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhIOPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234219AbhIOPXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:23:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26CAD60F5B;
        Wed, 15 Sep 2021 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631719351;
        bh=F3ASv+ivFn0BG/FrDDGTf0+GaMjatRkasFWdSFs3LyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EedCa8zq4yZEckjjTyjk3UlbaWER/en/Rccv27lMQmpTft6g5WgcPQLKA55jXT9Ch
         EfvDHhNuHQ73Bq+xCGIDRn5vrMf91W6naeK12ce+Qv0KFuYSPhWdVhJ5meQ6fvPlRg
         HKLNWyAgOLdccmIT08tg2Z/vaAD1WCpcvx99ShyviLAIIElPW4rq7Oi7SdgUqxlwF3
         kr+jH6ElPOne8CI0Z1SmnOeQgf4rk+f9EqisENdn4YCsZ7VFKiDJABxhaRDvjELxMF
         HvizrQDndpoxZ2W1FyGuE+DBxbPmSsSkFHRahojkgTuVlWWkRIXjYgdVOz8G7G0RXU
         UY+SnXes6ngYw==
From:   Mark Brown <broonie@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        cy_huang@richtek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: rtq6752: Enclose 'enable' gpio control by enable flag
Date:   Wed, 15 Sep 2021 16:21:41 +0100
Message-Id: <163171917481.10120.6058854376664686447.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631629249-9998-1-git-send-email-u0084500@gmail.com>
References: <1631629249-9998-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 22:20:49 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix 'enable' gpio control logic from the below cases if it's specified.
> 
> 1. All off and both are sequentially controlled to be on.
> The 'enable' gpio control block to be called twice including the delay time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq6752: Enclose 'enable' gpio control by enable flag
      commit: 6f3a9b100379320d27f4a64fa90f58101c95c5a8

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

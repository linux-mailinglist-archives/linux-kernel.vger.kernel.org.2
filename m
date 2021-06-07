Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9739E701
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFGTDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbhFGTDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:03:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5779A61159;
        Mon,  7 Jun 2021 19:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623092469;
        bh=Px4a8Ey4xNcoqQq2qb7z9TOl+XWb9kwf7eXkD4IPwlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tw8x89xPSrvGHaXGN6v/GHbRzyMLWuTUeU8wqNGm310aXz8447Q6Kq17V1FJGdbsr
         O1pkrMKH1yGqEd8Hc24pcuo63IzO8wRPQah1P1pnnMY7amNPsJ/ulrmsYWBu+YU9ki
         SzHqgm67hfp0pmWVkcd917nSAEkQuTJp5AKLzh+WgiPAgH5svEggbEThU/NECs1i/z
         knwWqWmU4jT3AE3ACGakUS33nKYWhSNuK8gvM2VK21mmN3XTVUA11vy8PyFYyGGwMa
         fJVbLmoftiKL9u3MICsVmb1E8lFKgIjwaUFfhedWKz1t9/3OysenDINtnPKGspL05r
         025wcM/g3JGTg==
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v3 1/1] regmap-irq: Introduce inverted status registers support
Date:   Mon,  7 Jun 2021 20:00:43 +0100
Message-Id: <162309227827.30673.11346303919506617668.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525034204.5272-1-fido_max@inbox.ru>
References: <20210525034204.5272-1-fido_max@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 06:42:03 +0300, Maxim Kochetkov wrote:
> Some interrupt controllers have inverted status register:
> cleared bits is active interrupts and set bits is inactive interrupts,
> so add inverted status support to the framework.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-irq: Introduce inverted status registers support
      commit: bcd23f93d3984a94d64ce0b6bbfa3789c0e8ebaf

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

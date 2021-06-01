Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74139793F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhFARkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234633AbhFARkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0D2161378;
        Tue,  1 Jun 2021 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569123;
        bh=FBu28wz+nr8vx7czp/1X9z6q34O3c+xbVoMywBNsw34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDqh8quYB54zo+sIM4+n49xIzE1k9Zn1lAYS3LspUMw8z9+5yQSYJhp/xHq2EQ4U4
         P2+s2BH3Yo0EREwBNAgbLKjYNn/vhD8rt6uwCic5Nx2cyzeTwa1rQ36BEFe0l6sfXo
         jmZVSgP5ezzP8xDOiZUM8I3jA4W2Ba5n9cdb6f9XJ+YA5n/PnsKuHtPdryyQgiNrK0
         d840/03V1g0I+gpqHoaJoaULaIZlylRT+NhkhudQ9Z3FXJa4EaGPK5mPlLgXH4zOjq
         /NLUH68kG/Wy6bvlHEI4yIeGa9hRb+PA5jQrWTlGDNlpr0h+ysbi8vooMQMBHQKpaO
         VDkkY8OtcwX0Q==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cy_huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: Re: [PATCH] regulator: rtmv20: Fix to make regcache value first reading back from HW
Date:   Tue,  1 Jun 2021 18:38:05 +0100
Message-Id: <162256901746.20048.6373382563782761366.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1622542155-6373-1-git-send-email-u0084500@gmail.com>
References: <1622542155-6373-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2021 18:09:15 +0800, cy_huang wrote:
> - Fix to make regcache value first reading back from HW.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtmv20: Fix to make regcache value first reading back from HW
      commit: 46639a5e684edd0b80ae9dff220f193feb356277

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

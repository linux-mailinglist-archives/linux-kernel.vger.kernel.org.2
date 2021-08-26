Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64563F8807
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbhHZMwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242551AbhHZMwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C4196103E;
        Thu, 26 Aug 2021 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982305;
        bh=yl6Q4PT2hwmFvxlCQJtB/8ICwpoMGDhQhxIEcB4UTMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm+TOzSDy8dgKN1oLULEGtxQ1UzplZXCTKdvEFzLrYrp/IvgRfnCLA2tVJw+zAU4A
         qTjhZi0fVaSSOmUjcxApY0xj+k/y8+2U/B1vcejswAdcj+KoWatuSYdQBONat60cH5
         YG6ZF3GFgDsAsd1WIp/ihqhB8d1p7Q54cZySpDjl8tAYZ+SV92S1f5L/SExXx2+Rqu
         NJCogjCVsQlbHuVxPIBJUrqrw5jel6PGH3mz9ZwHhhkXMpIh4i7ez30jYdaW88A804
         9Ua1dht+gh3OhlYlds9DGsCcay/78Os60OPx1W5HkEu+nFg1/1KuwhoVB2QXlpE51E
         Ki/JUtvCUt8Tw==
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>, Biwen Li <biwen.li@nxp.com>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: (subset) [PATCH 0/2] Use raw spinlocks in the ls-extirq driver
Date:   Thu, 26 Aug 2021 13:51:09 +0100
Message-Id: <162998211486.33598.9715111275111133802.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210825205041.927788-1-vladimir.oltean@nxp.com>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 23:50:39 +0300, Vladimir Oltean wrote:
> The ls-extirq irqchip driver accesses regmap inside its implementation
> of the struct irq_chip :: irq_set_type method, and currently regmap
> only knows to lock using normal spinlocks. But the method above wants
> raw spinlock context, so this isn't going to work and triggers a
> "[ BUG: Invalid wait context ]" splat.
> 
> The best we can do given the arrangement of the code is to patch regmap
> and the syscon driver: regmap to support raw spinlocks, and syscon to
> request them on behalf of its ls-extirq consumer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: teach regmap to use raw spinlocks if requested in the config
      commit: 67021f25d95292d285dd213c58401642b98eaf24

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

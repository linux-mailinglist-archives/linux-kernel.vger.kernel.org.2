Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9432B3DF7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhHCWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 18:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233436AbhHCWgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:36:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A6E960EBB;
        Tue,  3 Aug 2021 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628030172;
        bh=X1fuFgxnvVGtPapS5GYxcNvNkoATguR27/2Nwf0s+is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWdUpIBxCBp+X9O1K6y83Z5E6TMzdoB/BRAr03/S1iuE8pBq1eEm/ZM5PjybKx5+6
         NL80ONA4Frbp7mxBjdUycg+VOKMMgvDwGYA6WNHr2xQ7ABTGNKbKGAyVeHbSlVqP3i
         2GBaO7t4+Zz68x8QpzkmWuS5C48rcXLVtteF+WWQvXV/hOhHOo2UOa28mnDUTtvPO9
         NEgD17Ufyk+oTlOoR+75a6gn6SF7l5zJTdANKZi6bY0yzpWVlP/8yK7aYCbeOpiUMp
         d7V9Y+gAl0vCQWRW1F/GzgaL883ny/CM6hslVsOyW4VMi7+7g9VkJSur3oFCD8TIVT
         oFyD4S2L5Oc9g==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: sy8824x: Enable REGCACHE_FLAT
Date:   Tue,  3 Aug 2021 23:35:35 +0100
Message-Id: <162803004554.42325.12081867166532878940.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803165043.042ec24d@xhacker.debian>
References: <20210803165043.042ec24d@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 16:50:43 +0800, Jisheng Zhang wrote:
> Enable regmap cache to reduce i2c transactions and corresponding
> interrupts if regulator is accessed frequently. Since the register map
> is small -- there's only one register in sy8824c and sy8824e, there
> are only two registers in sy20276 and sy20278, so we use a FLAT regmap
> cache.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: sy8824x: Enable REGCACHE_FLAT
      commit: 784ed36958390c511cd48db061401f9ba20ba67a

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

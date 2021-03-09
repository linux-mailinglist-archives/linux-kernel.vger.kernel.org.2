Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE355332EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhCITIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhCITId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:08:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 036D1651D1;
        Tue,  9 Mar 2021 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615316912;
        bh=msLZKxQQPzVjg65ZEJ6TIYwfcCyD6r9QluS05hY8Ts8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=n+nF6n4yvuLcCxxL8ECgdWpZzjx7jDIN/KFP5JIgfGQB3jfIarAj7MGtO269o/BvD
         o8TjGr9VVxWmET4hvQ3GRqihXSwQj4ITwnb+BrdTVcO2Di3poJ6Ir5NPZceVVzAWrr
         HENGSzt+sbAI8Yu16rlB++1bx5z3b00i8JHd/cnJihPVHPP5avrSu7vBxExpTKwK1e
         P5L5QtxzvIQ4PwIY8g2o+E50mW7gbC5PwmXy079iiXPakcCeHlYX2GeiuL9OS/6nsY
         PXI5T/Ib0gQeng5yIRQd9g2+D12z9TsAKbOzsl+ERodkxNUHA4rVjARsS89WGPXok0
         yzXA0PrbkBnlA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Meng.Li@windriver.com,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     meng.li@windriver.com
In-Reply-To: <20210226021737.7690-1-Meng.Li@windriver.com>
References: <20210226021737.7690-1-Meng.Li@windriver.com>
Subject: Re: [PATCH] driver: regmap: set debugfs_name to NULL after it is freed
Message-Id: <161531684151.49333.12973462040505596359.b4-ty@kernel.org>
Date:   Tue, 09 Mar 2021 19:07:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 10:17:37 +0800, Meng.Li@windriver.com wrote:
> There is a upstream commit cffa4b2122f5("regmap:debugfs:
> Fix a memory leak when calling regmap_attach_dev") that
> adds a if condition when create name for debugfs_name.
> With below function invoking logical, debugfs_name is
> freed in regmap_debugfs_exit(), but it is not created again
> because of the if condition introduced by above commit.
> regmap_reinit_cache()
> 	regmap_debugfs_exit()
> 	...
> 	regmap_debugfs_init()
> So, set debugfs_name to NULL after it is freed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] driver: regmap: set debugfs_name to NULL after it is freed
      commit: ffe96a97642021e96ff27b29710401590ec19a5d

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

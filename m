Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7273CAD6B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245190AbhGOUBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345186AbhGOT5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:57:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EF73613BB;
        Thu, 15 Jul 2021 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626378888;
        bh=xLfV2Xzoq8UnSTpc2A9kdDwCb0yJZGzCeCFP8zdZ6T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nW7X3pvKpKyyKQ+wqSHdjqnHi72GKi9DcurDSCnhQj74uZ9NBbhh0zz2BKD2D9XrK
         LkGZH/vx4VNtZK4rKc2oICzbMwduM7KoNuTHgHPUDGu/AYpZpV7DuqyQqip82ugH3e
         GupWaSkha67CQj/AzXRt7vU9IDv+NSkflIyBWiJ2Ak4Wo0MrwG1I4LOBW/BN1STTMu
         Im25sblKJ37F0E6S67Tkp7s9qTfP7f+xJH6MCS/OANa+359hEez/xbGn1iSPc0ZwJ1
         KIvGkYBjT0Twy/wUQYvJpvi8dxn8paO/AeYV20SHK+G3sDDDfa2d4JVC702135yP27
         /FFQXBIjFsYbA==
From:   Mark Brown <broonie@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rt6245: make a const array func_base static, makes object smaller
Date:   Thu, 15 Jul 2021 20:54:00 +0100
Message-Id: <162637868448.27563.16170731868799436759.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210715141531.27672-1-colin.king@canonical.com>
References: <20210715141531.27672-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 15:15:31 +0100, Colin King wrote:
> Don't populate the const array func_base on the stack but instead it
> static. Makes the object code smaller by 55 bytes:
> 
> Before:
>    text    data     bss     dec    hex filename
>    6422    3216      64    9702   25e6 drivers/regulator/rt6245-regulator.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt6245: make a const array func_base static, makes object smaller
      commit: 508f8ccd993d1ff5c9a3092f179f33bd7a825bac

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

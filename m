Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4D42CA85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhJMUCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJMUCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:02:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73408611CE;
        Wed, 13 Oct 2021 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634155203;
        bh=jmVwh+T/mutRZz2FVI0rl1qHyvtCc3KRdOQRY4odTIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEkYq9OoSjf2rSukpc2hBpQBFiVMjK1+CXOVWSQdi6YKjcDGx7eODGQLm6Zj6KkNu
         iOkX9rif4sgrUiWvbEp29ow2famwKmngOw1qUzOIRAXAPnRqQYElLV+o8kqyqKsAZz
         E5df+Lqn7OdH97l5mZK4P2gajdm5W9agELvTw8OmeuhOjrNgumorxGr95GQv2fRzgj
         i7nlhbovQEmdTBthXxCL44Y4COcLqE6v0lO4WhYAFNULGZOUc/mExw+70VWL9P6QTx
         mIoJ9jZc+LUHqd7Xxu7vRTbgYqYZHMdvxlX0aMfCqwpk3U4XpNLJGuWrRKqN1c6sI8
         LeZBdPQbAcT+A==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     Mark Brown <broonie@kernel.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Subject: Re: [PATCH v2] regmap: Fix possible double-free in regcache_rbtree_exit()
Date:   Wed, 13 Oct 2021 20:59:47 +0100
Message-Id: <163415517144.1358368.8910883040162576428.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012023735.1632786-1-yangyingliang@huawei.com>
References: <20211012023735.1632786-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 10:37:35 +0800, Yang Yingliang wrote:
> In regcache_rbtree_insert_to_block(), when 'present' realloc failed,
> the 'blk' which is supposed to assign to 'rbnode->block' will be freed,
> so 'rbnode->block' points a freed memory, in the error handling path of
> regcache_rbtree_init(), 'rbnode->block' will be freed again in
> regcache_rbtree_exit(), KASAN will report double-free as follows:
> 
> BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
> Call Trace:
>  slab_free_freelist_hook+0x10d/0x240
>  kfree+0xce/0x390
>  regcache_rbtree_exit+0x15d/0x1a0
>  regcache_rbtree_init+0x224/0x2c0
>  regcache_init+0x88d/0x1310
>  __regmap_init+0x3151/0x4a80
>  __devm_regmap_init+0x7d/0x100
>  madera_spi_probe+0x10f/0x333 [madera_spi]
>  spi_probe+0x183/0x210
>  really_probe+0x285/0xc30
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Fix possible double-free in regcache_rbtree_exit()
      commit: 55e6d8037805b3400096d621091dfbf713f97e83

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

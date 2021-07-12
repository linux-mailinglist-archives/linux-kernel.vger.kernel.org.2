Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC903C5B07
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhGLKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234481AbhGLKuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D82A61130;
        Mon, 12 Jul 2021 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086852;
        bh=uw5FvFAGbIOeruuWJS/sat4AI84RsjA0ZHhyyZYhRiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAYVhqYJBqe8AY36y5RXyk4DRBxVbUZbq9Qxxlm1xL+bEYpkJPZ6/gcCHMYntPkTm
         k+iKeuDS/kKvV7WwFoypOf5UFGNDAkHukdBIb6ONt1vNO1vJn9d6CNgTyFD/yx8In4
         DMVfcpaZfa3ufLnh8P+VYw8DHEyphqsQmek3x7xdh9iNuGFOyQXJt8MQdbDheqfGCk
         wcD5PvAostY7YHqSujmUnEhjdcnxyuXtVOgK/m9M5a2VBZhrshxzzcmds5bHI5Nwiw
         ALbHls2ucCgEXIkO8ciXEgSsrTKj2rwPbLHf50HczimbC/db/6z/DgAtxH919FYz5Y
         SH0S548S5T1VQ==
From:   Mark Brown <broonie@kernel.org>
To:     Jeongtae Park <jeongtae.park@gmail.com>, ldewangan@nvidia.com
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        jtp.park@samsung.com
Subject: Re: [PATCH] regmap: fix the offset of register error log
Date:   Mon, 12 Jul 2021 11:45:54 +0100
Message-Id: <162608639129.3337.5236075765354129697.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210701142630.44936-1-jeongtae.park@gmail.com>
References: <20210701142630.44936-1-jeongtae.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 23:26:30 +0900, Jeongtae Park wrote:
> This patch fixes the offset of register error log
> by using regmap_get_offset().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix the offset of register error log
      commit: 1852f5ed358147095297a09cc3c6f160208a676d

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

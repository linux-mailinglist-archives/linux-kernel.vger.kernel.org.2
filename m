Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8353636DD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhD1QzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241421AbhD1QzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B2DC6143D;
        Wed, 28 Apr 2021 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619628866;
        bh=afX80eTKphvREzmJ06cN4lmgX/5HQyII66qLFz6W0oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3oXKMUwn0BOGXkc+2ozbwCm4gi3vyc+KhLLAP31nBUf93FrhqIVvuYih2QLF/HD4
         ioczWWCOvpvDdbz3kIzhrfXb8eiMFHpmqHAvS8oBpODYHU4IYt4x7WQsB+ImG9//yH
         mUyje1nBjNpa89A2Xsh1GGhGDwRWWF4dVleLNcWzlyZ0Wg0oU+7UlIxE7M23E16VxH
         ia8hxwPz8ZY66PflpcL0/RSxTYNzovFPu1RsidmTUsFufyvVfUQPaR5H4EsC0/U52v
         KgjZC9oMXAQXqXW+I5JehnP7eKK/15lm3BgQqaPHMR/uXcOPSDRjgzZ8ZdqLWoaQxZ
         NHJyc0d64kiHg==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ASoC: Revert clk_hw_get_clk() cleanup
Date:   Wed, 28 Apr 2021 17:53:44 +0100
Message-Id: <161962856274.49583.8078596005578732734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210428122632.46244-1-jbrunet@baylibre.com>
References: <20210428122632.46244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 14:26:30 +0200, Jerome Brunet wrote:
> There is problem with clk_hw_get_hw(). Using it pins the clock provider to
> itself, making it impossible to remove the related module.
> 
> Revert the two commits using this function until this gets sorted out.
> 
> Jerome Brunet (2):
>   ASoC: stm32: do not request a new clock consummer reference
>   ASoC: da7219: do not request a new clock consummer reference
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: stm32: do not request a new clock consummer reference
      commit: a0695853e5906a9558eef9f79856e07659b7a1e6
[2/2] ASoC: da7219: do not request a new clock consummer reference
      commit: 97c733654ab4a5ac910216b4b74e605acf3e1cce

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

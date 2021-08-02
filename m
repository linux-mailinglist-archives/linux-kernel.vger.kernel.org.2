Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7DA3DDBC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhHBPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:03:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234313AbhHBPDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A397F61057;
        Mon,  2 Aug 2021 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627916579;
        bh=nS6WPDPr88n8oDDSgoEL5dgbm9vIRBu7xdEtK4TWgt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQ5e9oz43I9pYmR1Ika1qyA/pz9x1re6Y8/ajUu1oIBvdDX7tHYTyB2KOwmo/PrGO
         GJK4UmJ60B+ccFMLJrxh/8QUy6k1eXVpyI09DGuUAdVvKJKRcQnM4hKGYepsN5wE0v
         Za5fqSHMBAhqcUoZFjBN3s9FIzAzR6ZLzDBhPrZA+f19O5CJ0vvqqSfL1zB37udae3
         tvl0aoDhvWYwD/F3ETLK+rdnBzncSlQX9QJHZOjmidDw/xE0Uq1dsRsn7TNhIWZgun
         jDptCLMST7rlvi+Wl8t6zhAY+ItlgyJ/eSOw5NXAu7CbpvfRWo0elZzb9VRoFhNo33
         9oKvDF7rBkvGg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Colin King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: rsnd: make some arrays static const, makes object smaller
Date:   Mon,  2 Aug 2021 16:02:35 +0100
Message-Id: <162791613030.1468.1113702427634488424.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210801063237.137998-1-colin.king@canonical.com>
References: <20210801063237.137998-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2021 07:32:37 +0100, Colin King wrote:
> Don't populate arrays on the stack but instead them static const.
> Makes the object code smaller by 242 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   23827    8764       0   32591    7f4f ./sound/soc/sh/rcar/ssi.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: make some arrays static const, makes object smaller
      commit: 6dfeb70276def839aa605edd274f8e9f6189dba3

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

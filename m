Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9A53C5B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhGLKvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhGLKuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A376101E;
        Mon, 12 Jul 2021 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086878;
        bh=DKsfMZFlN5pc+yOjXB1oKGtg1J499cWV8uFXsYRz1+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuTead5G3ZgcJ/4i+7U6Ud+JcZ7JBtsXwr7X2NRHqV4k6YySgACdgDeVTGGYLy4lv
         vuuK9vcrXeqmvzpe5s3N7F8PtwmHfne87AHFN6s+AYwTzqwRCsx3Q2cPvb3WmO1c1g
         s5sb1xLFlQUHQw1c7bSZ6fY/4QA+stCqqkAOw8I9HHzr/qJG3KDA5knltmhYK80Blm
         A+UFq11075/4g2TPHKAL5tZjFmQDdgSs1m0Z9Jc65sXaYATZLfmmqmvzR5fsHOVBPx
         8gTiW6TI45RbBYlRh7OIlZnGkDh5okuDhqc//4lUEqPKChkpZxzd/070SF1n7y+/4K
         mJmLtLbyWp0RA==
From:   Mark Brown <broonie@kernel.org>
To:     Gu Shengxian <gushengxian507419@gmail.com>,
        codrin.ciubotariu@microchip.com, ludovic.desroches@microchip.com,
        peda@axentia.se, alexandre.belloni@bootlin.com, tiwai@suse.com,
        nicolas.ferre@microchip.com, lgirdwood@gmail.com, perex@perex.cz
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Gu Shengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] ASoC: atmel: fix spelling mistakes
Date:   Mon, 12 Jul 2021 11:46:04 +0100
Message-Id: <162608623153.3192.14407924145407645450.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210706100230.32633-1-gushengxian507419@gmail.com>
References: <20210706100230.32633-1-gushengxian507419@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2021 18:02:30 +0800, Gu Shengxian wrote:
> Fix some spelling mistakes as follows:
> regaedles ==> regardless
> prezent ==> present
> underrrun ==> underrun
> controlls ==> controls

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: fix spelling mistakes
      commit: 55233b22502151e0b2d9cc599e1ddf1f5584c87a

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

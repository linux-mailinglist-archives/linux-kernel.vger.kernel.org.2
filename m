Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D0A434A09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJTLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhJTLbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:31:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 753266135E;
        Wed, 20 Oct 2021 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634729332;
        bh=wTQloiZs/BuLYX5Yg3LlKrHdopyQzbSJH5f/Y/+nJdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3eSBergbHy5zgvxaAoAveP9Bi9qIaMsR9UsAb7OpUkOA5hNNoSinHCgLxT3M6j3x
         isbmgUQZ9O0VU6enRGoJxUljlqlw0SjVggMHohwmveeRlkJ4ibOHJZQqQPLa60kFCZ
         u1S+2++oPJFnW3vNsj7KjThnXZgvH4HPP2thzFxgGXzSZm9X4Z5DgMKedL2D7YE7cy
         ZlCzUgzTlExFHjswmLq1BARGvnKnb7ktgC3HXLjqqOkS8UU75rDxmPdvcqDf9V6/+5
         poapQeOXKQu8/5K5oAiVBjjqw99M7cebid3jn3Dc3IPXh3FjZnU7J3Ff0Zl/SM4k4U
         JkqiFwVKKLXaQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: rockchip: i2s-tdm: Fix refcount test
Date:   Wed, 20 Oct 2021 12:28:37 +0100
Message-Id: <163472931363.2896549.8558505612147911310.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015210730.308946-1-frattaroli.nicolas@gmail.com>
References: <20211015210730.308946-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 23:07:29 +0200, Nicolas Frattaroli wrote:
> During development of V5 of the i2s-tdm patch series, I replaced
> the atomic refcount with a regular integer, as it was only ever
> accessed within a spinlock.
> 
> Foolishly, I got the semantics of atomic_dec_and_test wrong, which
> resulted in a test for 0 actually becoming a test for >0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s-tdm: Fix refcount test
      commit: 0ea15e98cfbe56147e227360282ccd311e824b61

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

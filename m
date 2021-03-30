Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23AC34ED2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhC3QGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhC3QGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:06:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7104619C5;
        Tue, 30 Mar 2021 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617120372;
        bh=LcfNiuaHxShmpOMM7bIh9+cRZVxKyNwsRLx+S7WkUrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4w0e/X4HD6ZFXJaJbwQbxqRZisLjH28suTfoGysW+F4DGQxOhLGtW2oFkAmJLRnq
         7U4GoiKEwMNXPRduc8MtfuwTZxtKE15qyJo9et2Q5Mvss7RX4o9+zfuzREKMkQAbjs
         8Ob2qYi2YQqfVtCUpWmUDMxJ6OGI+StPD90E/ifgllS7BQAdTDiKtiwBB7o57Omxte
         n8Jdg4HE5d3uxIqMO1e6nl3qPUf5YfBMsPvI4l3WFFTMTPvcgdSX0uBTeIZtn1XIYE
         L+Z4mX/w3bFO8mh3JUOvpBP52Bh4YjtWRQDtZzsxtE4tXh8qbxpcRVUtLvudggygbr
         BmfMozp054VAQ==
From:   Mark Brown <broonie@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Colin King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc:     Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: mediatek: mt6359: Fix spelling mistake "reate" -> "create"
Date:   Tue, 30 Mar 2021 17:05:50 +0100
Message-Id: <161711993559.12915.3840156650478962312.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330084710.997731-1-colin.king@canonical.com>
References: <20210330084710.997731-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 09:47:10 +0100, Colin King wrote:
> There is a spelling mistake in a dev_err error message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt6359: Fix spelling mistake "reate" -> "create"
      commit: f556de6087f0d19825ffcdddc4816f83ddfd35e3

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

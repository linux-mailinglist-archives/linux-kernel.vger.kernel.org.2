Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A782419D60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbhI0RtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236615AbhI0Rs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E648460FBF;
        Mon, 27 Sep 2021 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764841;
        bh=i6C1j/rVSaKCT6VZs7hNmd9rfXiX+ZOqCInscH6GliU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r8Yw6DrkQMNMNhrFVCWdQ65qa1RCnrKgcfptX/h+Im3mqomdgenGb0QWw+wzQ3yhY
         pQKKEEC0rFogz1yPHog1X2HYowB6w+xEBSD06zRuUN/xKv9/XiIozNZNcNr85sHC6n
         nuIGrLGYvmXYsXaWNcCE3tSreT7ivGQtfQr93jS9jz1WhnmSveFF8cAZclqTvAmXzd
         f5MhYvk/4BrAiz10yL68i9+DQ9BMAW1TT7Q6xPA/YE7wHvydDoQICSdsPo/SG8QDz5
         xYKu363L1BzMHFHeuVG0G0TDpXuTKbUpp0bu6Cs+Cgfx7vCD/PwicJbrdxmpFlmeaS
         rzfN4o7Iroo3A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Colin King <colin.king@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: Fix spelling mistake "Unsupport" -> "Unsupported"
Date:   Mon, 27 Sep 2021 18:45:30 +0100
Message-Id: <163276442024.18200.2988591432282232659.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924231003.144502-1-colin.king@canonical.com>
References: <20210924231003.144502-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 00:10:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in dev_err error messages. Fix them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix spelling mistake "Unsupport" -> "Unsupported"
      commit: a4db95b2824157bdf0394da429ea49280bfad6b9

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

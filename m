Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8FA368532
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbhDVQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236287AbhDVQuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:50:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AE90613AF;
        Thu, 22 Apr 2021 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619110172;
        bh=zkr5DtGu2wFjDznQb02gU//n2iu4KCADiJe/Qwy1yFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuvbZNAVATSkzq0bJULF5Uhy3ZqFK2KkGwv+nXqHI3A9a65kKUiCJYagikq5Lz8nO
         /y/ifWnV9nHVSIeN+Zx/PX3hBva6dJPTJm6i8ILd5ujLSCdNpFbeyJ60eR7U59Yn5s
         zbeoES7J6CHqD6hXiV9b1ctJ+tt6HUfxHrmPm3ZlNSAxBXtOuK+D1OAY5YdZsOtxv8
         2l53IXY1Roqq66OGWCA1Udog5fxYMMNgf8fYac0LdSBU0wXZ3by4d/B+eYP9hj0rG2
         06GMK7chPQQGv+lk8fbUSZOJMte8ydcXvo9iYAiacmAkElrxEvDqOtGPDqxqLzaSi9
         xH6GMCkX01WKw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Niklas Carlsson <Niklas.Carlsson@axis.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Niklas Carlsson <niklasc@axis.com>,
        alsa-devel@alsa-project.org, kernel@axis.com
Subject: Re: [PATCH] ASoC: adau17x1: Avoid overwriting CHPF
Date:   Thu, 22 Apr 2021 17:48:49 +0100
Message-Id: <161910991990.37460.17699154038867347176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210422130226.15201-1-Niklas.Carlsson@axis.com>
References: <20210422130226.15201-1-Niklas.Carlsson@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2021 15:02:26 +0200, Niklas Carlsson wrote:
> Configuring number of channels per LRCLK frame by using e.g.
> snd_soc_dai_set_tdm_slot before configuring DAI format was being
> overwritten by the latter due to a regmap_write which would write over
> the whole register.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau17x1: Avoid overwriting CHPF
      commit: a89f3a93cd20f77ac1f84089297258d4b409e280

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

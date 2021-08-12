Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECC3EA442
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhHLMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234949AbhHLMHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:07:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BDF260FD7;
        Thu, 12 Aug 2021 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628770039;
        bh=5ADPpdHccujvZQXPlEKxF5syhlR8SQp8WXqrMYPJmfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXcBuBlb176dtDabI0bDUbinjkmt1fCYpG1zBI2xQv18Cj+zggQYEt+X7Dx5qzei2
         Xb0Uq54jZzr+rGejQp234gIERb2r1ynDSpH4/NIgz4C9bBnaCfrwsGhESZ/qgda5Yw
         wtYPrMvUUl0u7F4PkDQOJhPo+dWSpdD2owjEhZ6ChVofBB7zdJVqcjio7kEj6FFNip
         UFB9mA/K6Znprgs8X1+QlC/M7iPgX8Lh3RDf9nPCHp7auAjL3PqW03XbpMdz/8A9Sy
         2tPXo60bbwyF4gZQkxK3AU/16Z7URLIwo2YRAOiJjpeV8WQ4OriPRRf3sJLAFiPr57
         FX/QNGTfyAJug==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Stephen Boyd <swboyd@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <bardliao@realtek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: rt5682: Properly turn off regulators if wrong device ID
Date:   Thu, 12 Aug 2021 13:06:58 +0100
Message-Id: <162876970126.42668.8724722824512964124.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
References: <20210810165850.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2021 16:59:15 -0700, Douglas Anderson wrote:
> When I booted up on a board that had a slightly different codec
> stuffed on it, I got this message at bootup:
> 
>   rt5682 9-001a: Device with ID register 6749 is not rt5682
> 
> That's normal/expected, but what wasn't normal was the splat that I
> got after:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Properly turn off regulators if wrong device ID
      commit: 772d44526e203c062171786e514373f129616278

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

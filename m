Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6613EBB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhHMR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 13:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhHMR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 13:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 604FF60F57;
        Fri, 13 Aug 2021 17:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628875585;
        bh=VThyJvP43YmAmnkp3rqr1CPohIuzoclnjntpTJXxW7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPUZgdaswye7wTBsjEWm4y/fB50R9EeVpV2SFWjaLX1ikmwuogbyrNeaMeziZoEbA
         eh+2+lgPmteJ5DrpEMViPUyqFaJQMW/Su5GEtDqH+yHLon0/XnZQDddnovHOaWo6TS
         u0lGmkoxE7Z3yanYENgcnrqv+zaAhWG1i8j60khqBZyrMsc1tj1H1gBuAZgO7wXV5f
         3Dx+NOSIb0Q//zPDt0lv2M8WpyH7y8MSRaeqVSCTHc5IcS+ffoISur6fx0KM0YUuRk
         PqWfO6YZEwmcyE0iefMiU7er9Ld3BVIy88Lu0rIWpL9tANjmykJyAc/gYiuIlMzwUu
         ImOLbKFM7vowQ==
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ASoC: rt5682: Remove unused variable in rt5682_i2c_remove()
Date:   Fri, 13 Aug 2021 18:26:00 +0100
Message-Id: <162887455325.19744.837395939498410454.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
References: <20210813073402.1.Iaa9425cfab80f5233afa78b32d02b6dc23256eb3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2021 07:34:05 -0700, Douglas Anderson wrote:
> In commit 772d44526e20 ("ASoC: rt5682: Properly turn off regulators if
> wrong device ID") I deleted code but forgot to delete a variable
> that's now unused. Delete it.
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Remove unused variable in rt5682_i2c_remove()
      commit: a1ea05723c27a6f77894a60038a7b2b12fcec9a7

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8863EA443
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhHLMHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:07:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234949AbhHLMHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDB776104F;
        Thu, 12 Aug 2021 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628770042;
        bh=fu4ur+beZ0q1SwKzI6UwIh8hDnNHsHmUrehjdJC1COk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eG+fHFw/vDlEPf80WDOc1A/5OIrwUO5pAHmwy8MevtDxY9I3moktxkrXnVRRSFcCM
         o8rUbAQd/dwwz6D5AMBVAUxbtG09VS0uTOrTMAnq1fNXWRMh2I6ngL3SNGGng/m3JB
         rhNJc/rbT2vf3/5MQN1CQsEFlNzr1wSiI4o3xH4mmCf8A1muECLZZl+vJewrkMxNEt
         qTxLgctXIWXlQ/TpAw0ubs36dIDC0827RC1yBaIrTKbzqzXAk5CUN5yn7gk/p3JxuT
         AX0BuK6K3U+r1KFGOmHjKLxrk2k3N3xwulEIlpcbzjpOPu9XUTvxcR4pHJVEY4GRhW
         ZyNabSn41TiDA==
From:   Mark Brown <broonie@kernel.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        Stephen Boyd <swboyd@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <bardliao@realtek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: rt5682: Properly turn off regulators if wrong device ID
Date:   Thu, 12 Aug 2021 13:06:59 +0100
Message-Id: <162876970127.42668.2574394243785887563.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811081751.v2.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
References: <20210811081751.v2.1.I4a1d9aa5d99e05aeee15c2768db600158d76cab8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2021 08:17:56 -0700, Douglas Anderson wrote:
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

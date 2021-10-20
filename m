Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C90434A07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJTLbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230139AbhJTLbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:31:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B39FA61359;
        Wed, 20 Oct 2021 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634729329;
        bh=Hc5cuk9glDaRbaSAq4FdX0qHDgJuvg1tQjkipEezNvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZF5Rfu3GUprtBYrB0BU2YZ4eiM3rLK3Jig8bOQm5cQ3FghfMbGuEB0HiI3mjDEL7
         HcI92HqOvIYR+xyeSL+cWhNkp3RjFLDOowqPlkUO3yWnehhLcwcU9KykqucYUPLXm8
         t37If7zQ/usbfxpBS+fK1PU2bjFJ9Dju4VQX6u0DnmtyiP/kzXYER6BTYInbKQCqWI
         Kp6FzguBtH7sH/PW9v75AiutVwbLb4GQefEqmsUQ8NMVvICf+mOSRai/GDSxoCSB4A
         4ixMHcXIa6D+V67GUnqNFJCeBCAooaizOZZUT6UXeokfbMx6+j6kBjbjDs7ZF6aVtT
         pEXW/S7NDTcKw==
From:   Mark Brown <broonie@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Matthias Reichl <hias@horus.com>
Subject: Re: [PATCH] ASoC: meson: implement driver_name for snd_soc_card in meson-card-utils
Date:   Wed, 20 Oct 2021 12:28:36 +0100
Message-Id: <163472931364.2896549.2043578112545946668.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211017160028.23318-1-christianshewitt@gmail.com>
References: <20211017160028.23318-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 16:00:28 +0000, Christian Hewitt wrote:
> Implement driver_name to provide an alternative to card_name for userspace
> configuration of Amlogic audio cards.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: implement driver_name for snd_soc_card in meson-card-utils
      commit: bc387887ae22d6ed6439e83968b5be3443a8e57d

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

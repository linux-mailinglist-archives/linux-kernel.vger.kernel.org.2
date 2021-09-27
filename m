Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C4419D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbhI0RtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237703AbhI0Rsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E3D560F4F;
        Mon, 27 Sep 2021 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764833;
        bh=vaAGDWdMM7DnyyWXxtxSddAQ5DUocd9iZv+90xzItsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiFQVEkTlYZsjWIqN83tvpAeQS66u7BaiLdsgKY23NVT37ltIo5A/J757P2ckRcXX
         LAby4ZotutVpi4NN8g8T7JJupJPfdmbQRlQJMwukYoW3LsYvF7lWlwmMljrK914qym
         lE3moP1tt0iBiich7SPzrlbeKgclai6zoN456Gq7/Ow1QJJe/CB9ihDPOArQJZAeWa
         DE7aIz+zwTRqQatXZ7erRpkshQbFmDbj56SCyRFc5wUA1/boF0adClXp86FQOmbRtH
         mnDhlauYAFfkrHwA91ENcqwbk2yZq+dL4RUnNcG0yLYwpq/eggvl3sL+Nl2gUwaz/0
         9iwf+2T1zRDRA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Takashi Iwai <tiwai@suse.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Colin King <colin.king@canonical.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: aiu: Fix spelling mistake "Unsupport" -> "Unsupported"
Date:   Mon, 27 Sep 2021 18:45:27 +0100
Message-Id: <163276442024.18200.9710161748366724709.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210924231242.144692-1-colin.king@canonical.com>
References: <20210924231242.144692-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 00:12:42 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: aiu: Fix spelling mistake "Unsupport" -> "Unsupported"
      commit: 9929265f2a7b5fa15d460dbbaa7f388c303411da

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

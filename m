Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A834856F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbhCXXkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239082AbhCXXkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:40:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E19DE61974;
        Wed, 24 Mar 2021 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616629204;
        bh=Nl01SowQJwZ86qcGJ3uYdr0vyyXeyCErJGFWOz8KNR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r57I8UJwzmA9Oft1VHqsob3vk/5rGVDMZ7U2fQK81RS5wINVAiNJzUpRDOFLugkRx
         Pkjg6KGkuzuGB0uuNcm6H8n9/kjnnbknM8nwoX2HksPF99t9dgSJv7BNSjuuUSV4Cn
         sTE1QSKpwPWWJNeivm4sZzC4XupytzwqIfi8UmBRu7BBMPLMxKpPbLoRlXFDF+XpQ1
         sML2TqlnYuuRju/q3s0ybr+j7OtakfgP93Laeh4PoQ4aCvsVQcnDn3G6ho01FuAqGT
         uKVWoWrIN4ccPYOo58jyBVHB3fTWShY8CZdVb3cDSRdN/AbcUw24yYF9c5jNqlhE38
         3sUzQv+pvgG7g==
From:   Mark Brown <broonie@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org
Subject: Re: (subset) [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support
Date:   Wed, 24 Mar 2021 23:39:39 +0000
Message-Id: <161662872374.51441.14272118872485811868.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210307151807.35201-1-hdegoede@redhat.com>
References: <20210307151807.35201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Mar 2021 16:17:54 +0100, Hans de Goede wrote:
> Here is v4 of my series to rework the arizona codec jack-detect support
> to use the snd_soc_jack helpers instead of direct extcon reporting.
> 
> As discussed before here is a resend rebased on 5.12-rc2, making sure that
> all patches this depends on are in place.
> 
> Lee, can you pick-up patches 1-6 through the MFD tree and then send a
> pull-req to Mark so that Mark can merge the Asoc parts throught the ASoC
> tree ?
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[07/13] ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
        commit: bcda8cc4b868782c1a39d722d24f7d2598978389
[08/13] ASoC: arizona-jack: Use arizona->dev for runtime-pm
        commit: 688c8461a425623ca6f679e6ba8965719a98def5
[09/13] ASoC: arizona-jack: convert into a helper library for codec drivers
        commit: ffcc84b9e814c8654e15e08816d0078d521a2724
[10/13] ASoC: arizona-jack: Use snd_soc_jack to report jack events
        commit: 236b7285e95af5cb5a8b63283e573f433fb9b305
[11/13] ASoC: arizona-jack: Cleanup logging
        commit: 69c58eb61e9b649096a0ab8cbc3c6f8521efd303
[12/13] ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use the new jack library
        commit: 37dbabf14ff65510fa5aeecc1707ca390e608e00
[13/13] ASoC: Intel: bytcr_wm5102: Add jack detect support
        commit: ecd77d494ec995fb07102b408954c94f38374084

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

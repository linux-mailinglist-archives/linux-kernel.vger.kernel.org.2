Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6737EB78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380545AbhELTb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241558AbhELRIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:08:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D7F86134F;
        Wed, 12 May 2021 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620839150;
        bh=McpoRHLvMNh7o2t4R0tgVJ81OfdHjOJvOW40DSLsONA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7xcXoM8zOMHdtaZmk5zK+SKwdtBjgQ0F6jnyeEf6kePqhGPY1iPVwo4oz6VDm70w
         Hg5y0IpuzkqyakYgb1VAyZxGUF+txoilBGAWQvPokMl+e3ntgbot/FBFbQyW3t+Bmo
         a5Y0WIph0a+V25+nHhnTdbH6u0SFvBsUsFI5pUZjuH+uKQgg0WxodP0XISJqyfSAmz
         DzCj+ARha8iOsJXBjqjlJayBMDSgsnUwSXePS2btIR7ku5bJuBvi1694rsy7UY7JZb
         +/hb3GAM+xkaa19uz/ZnH4cu7b4ZWEGQfkxxuYbV4jqrZuZ5OYNCF04AXT4oU7edHF
         UEgtBfMPhXpRw==
From:   Mark Brown <broonie@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
Date:   Wed, 12 May 2021 18:04:45 +0100
Message-Id: <162083892845.44734.6387839662389398582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511145220.125760-1-vitalyr@opensource.cirrus.com>
References: <20210511145220.125760-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 15:52:20 +0100, Vitaly Rodionov wrote:
> HSBIAS_SENSE_EN configures HSBIAS output current sense through
> the external 2.21-k resistor. HSBIAS_SENSE is hardware feature to reduce
> the potential pop noise during the headset plug out slowly. But on some
> platforms ESD voltage will affect it causing test to fail, especially
> with CTIA headset type. For different hardware setups, a designer might
> want to tweak default behavior.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
      commit: c9f2e3c3ddab87d93cde99f6da10dd00c1d1edb9

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

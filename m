Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C75408989
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 12:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhIMK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 06:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239325AbhIMK41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 06:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81DE161056;
        Mon, 13 Sep 2021 10:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530512;
        bh=/acizGQpjVbb5W1sMXX4iA7exId4RJz4UuLDmCHSWzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6TvK4B4I+8fhHkwCXw2nwKMzALK/t98a7hcdi3nBHhqo2rAU+fopM70wRIFncoEz
         EDb6uxC2Ln6u7zoDo5bMmvBiSyEsV/krsHSylK1WrC3QlvZ/EOJ5IKtYCnNp0m+ybC
         vwZBkFBItqnRxsBeICBVHsVDpmetRPSm7JqUZLwCYZMeMpVE85iAKVQo7pmS1mN5o0
         bwe+0WWOqbV8A7CIwbNvzhPt3ciCXn4W+K95uxO2fMLNLy+EX5t2lDbLZ+T1mmPa4e
         wujxw70KU/CXuIZpF2L1gBcDUAY5bVDucCcEryAhZBwNxeL/9DjYkMLx/pq5sbeS+X
         aeXqlBbq77g8g==
From:   Mark Brown <broonie@kernel.org>
To:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?P=EF=BF=BD=EF=BF=BD=EF=BF=BDter=20Ujfalusi?= 
        <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] ASoC: ti: rename CONFIG_SND_SOC_DM365_VOICE_CODEC_MODULE
Date:   Mon, 13 Sep 2021 11:53:27 +0100
Message-Id: <163152996582.45703.13424902578308324245.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210901164009.1546967-1-masahiroy@kernel.org>
References: <20210901164009.1546967-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2021 01:40:09 +0900, Masahiro Yamada wrote:
> Kconfig generates include/generated/autoconf.h to make CONFIG options
> available to the pre-processor. Symbols with the value 'm' are suffixed
> with '_MODULE'
> 
> Here is a conflict; CONFIG_FOO=m results in '#define CONFIG_FOO_MODULE 1',
> but CONFIG_FOO_MODULE=y also results in the same define.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: rename CONFIG_SND_SOC_DM365_VOICE_CODEC_MODULE
      commit: 0f3dd4e09addc00d5b87761793b08927e7903181

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

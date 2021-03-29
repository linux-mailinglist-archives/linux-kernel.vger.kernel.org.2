Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8534D8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 21:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhC2T6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 15:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231905AbhC2T63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 15:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D93B61554;
        Mon, 29 Mar 2021 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617047908;
        bh=33BYQBr/4s8xc5+GccSIv0XFr7Cs0xd2pSG0T9cY22E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5fZj4fa3wTwxBVGVv7q1JKBJm1UWhEvTvaF+2bYcnBgMDkShzw2MgG8NsOTrRLuP
         vQPGU4D+FLGTn9YK4trNp/AD91mkKtF9M8zS4Wc00OkShzwkYi0KjMKAhiz0ePEobD
         IAzie5hN9XALsPgN+KSuBGzNxsZpxwd/8KZ2/pWdf+NnRWqdRCDA5AZ8HcloD8nm7j
         ljEB4eKJINcXF7b/jF0VLQbCpGbEH6icy/BBzwtnUt0LL7yolsVx9UUrIps7KUpURM
         UwDlhs5hpPeSZBXp6e47zMhrZtL/o9XEhpw9FeiMIEc5tHGj8LrJR1ajAmOpL5+4WG
         N4BhJo1/+Bptw==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Argus Lin <argus.lin@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        devicetree@vger.kernel.org,
        Chipeng Chang <chipeng.chang@mediatek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-mediatek@lists.infradead.org,
        Tzung-Bi Shih <tzungbi@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Shuming Fan <shumingf@realtek.com>,
        "Shane.Chien" <shane.chien@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, Dan Murphy <dmurphy@ti.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH V2 0/2] Add mediatek MT6359 ASoC accdet jack driver
Date:   Mon, 29 Mar 2021 20:58:08 +0100
Message-Id: <161704724764.10039.3415916166435567719.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615383186-18500-1-git-send-email-argus.lin@mediatek.com>
References: <1615383186-18500-1-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 21:33:04 +0800, Argus Lin wrote:
> All of 3-pole and 4-pole jack are supported.
> 
> change since v2:
>   - fixs missing blank at Kconfig.
>   - fixs comment format and spelling mistake.
>   - changes private structure mt6359_accdet to mt6359-accdet.h and uses this
>     data as function parameter.
>   - removes compatible string declaration.
>   - uses regmap_read_poll_timeout as polling timer.
>   - simplify jack detection and key detection report function.
>   - adds mt6359_accdet_enable_jack_detect for sound card jack initialization.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: mediatek: mt6359: add ASoC mt6359 ASoC accdet jack document
      commit: e61c589587c772c5f672b22683c3e0b38be20702
[2/2] ASoC: mediatek: mt6359: add MT6359 accdet jack driver
      commit: eef07b9e0925e16457ab9444b56a7f93b541aee3

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

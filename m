Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36333A6F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbhFNT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235660AbhFNT5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B6A6128C;
        Mon, 14 Jun 2021 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623700506;
        bh=gOtV2H3G16EwP1AcvCKrNDEsDikEYklsor3HqzolUsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrkjePLzQ+cJwc8EkPKIaStwEFI+/x7mjolZ1lsOrRcSEWERVzfnUzXLPDKH1xppv
         8KTtgNxjN7YrSf/YTvdTS4rilZWBD5V66QMsw9zA++j9jEjbvnaOjBMf8WoA74cYLx
         tI91H17vGDRRyKEM21O7gI3FOQhQ25GJNBj3nutqpQ165wWmfGCcN7NjrQIL4ycM85
         PB/AhQjYH4ZLRv6SxguOzNt2s1E1UFOiazt0wYgNBUFwfQ4jbNLRitRoTeXcTAnpEJ
         Uo1KU+mxaSPhPPjn7iBMeE7Uax+9vCst+/xotHo1lfPYmcxFNlx+bjzyfKMz8rzT5q
         UspZER+O1LmrQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, perex@perex.cz
Subject: Re: [PATCH v9 0/9] ASoC: codecs: add wcd938x support
Date:   Mon, 14 Jun 2021 20:53:47 +0100
Message-Id: <162369994008.34524.18038515036369844950.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
References: <20210609090943.7896-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jun 2021 10:09:34 +0100, Srinivas Kandagatla wrote:
> This patchset adds support for Qualcomm WCD938X codec.
> 
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices, RX and
> TX respectively supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs and MBHC.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: dt-bindings: wcd938x: add bindings for wcd938x
      commit: 10ee3e07d32bede6cd007fb76150a1ccd0628852
[2/9] ASoC: codecs: wcd-clsh: add new version support
      commit: 19c5d1f6a0c39cf910c8d211ea40ff758bcb3f49
[3/9] ASoC: codecs: wcd938x: add basic driver
      commit: 8d78602aa87a3805902bed83157526fdc5b837d4
[4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for wcd938x-sdw
      commit: e02c65f3a7ce11ce522e805c78ed2f1da5d96975
[5/9] ASoC: codecs: wcd938x-sdw: add SoundWire driver
      commit: 16572522aece6a142d303a25f32544643f52c383
[6/9] ASoC: codecs: wcd938x: add basic controls
      commit: e8ba1e05bdc016700c85fad559a812c2e795442f
[7/9] ASoC: codecs: wcd938x: add playback dapm widgets
      commit: 8da9db0cd6694c98f64b6ec413337ac834e05bb0
[8/9] ASoC: codecs: wcd938x: add capture dapm widgets
      commit: d5add08fcbce35faeeffa62d7e8f21fd979d8420
[9/9] ASoC: codecs: wcd938x: add audio routing and Kconfig
      commit: 04544222886881cb0865040dcdf747fe7e025947

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

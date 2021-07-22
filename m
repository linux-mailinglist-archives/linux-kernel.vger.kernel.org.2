Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD13D2AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhGVQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233724AbhGVQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:30:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B20496120D;
        Thu, 22 Jul 2021 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626973838;
        bh=DeA3CYXsFlcMIQmyqXm6khDeOW5lwK6vbztR5SBgTkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQA11bcSMILqSjdJnIPBRdmGs7GdG7f0QT+9x7hY6uuzqgntCvPPTRZ1cdeEl8LjV
         imFmfhUcy984y5wReMOCLviUXxiX9EGsN9l0O4PqFDBJr5LDA4VfVb+PvEE/Jsa326
         7AGd1XxvoT5oBaukShY8FJ0dgAoNpoqw04N24CmCjGfyzQiDgDUYhZ3D3MFiUccdqt
         OSj/gd63ZwISkwu/nhGiF3cwDSULacIq9LOUn/HmUrYo2nSu0SLQLxaSwergy0Dg+E
         FJ5pnEulsMjicoZNKnz8nzyE/mhIHTEh2VFPKF96cE1NnKo+p07NX6c3zOaLuot6rt
         sQHF2WBP76ZZA==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix wcd module dependency
Date:   Thu, 22 Jul 2021 18:10:05 +0100
Message-Id: <162697068326.1747.12876707572437877614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210721150510.1837221-1-arnd@kernel.org>
References: <20210721150510.1837221-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 17:04:45 +0200, Arnd Bergmann wrote:
> With SND_SOC_ALL_CODECS=y and SND_SOC_WCD938X_SDW=m, there is a link
> error from a reverse dependency, since the built-in codec driver calls
> into the modular soundwire back-end:
> 
> x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_free':
> wcd938x.c:(.text+0x2c0): undefined reference to `wcd938x_sdw_free'
> x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_hw_params':
> wcd938x.c:(.text+0x2f6): undefined reference to `wcd938x_sdw_hw_params'
> x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_codec_set_sdw_stream':
> wcd938x.c:(.text+0x332): undefined reference to `wcd938x_sdw_set_sdw_stream'
> x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_tx_swr_ctrl':
> wcd938x.c:(.text+0x23de): undefined reference to `wcd938x_swr_get_current_bank'
> x86_64-linux-ld: sound/soc/codecs/wcd938x.o: in function `wcd938x_bind':
> wcd938x.c:(.text+0x2579): undefined reference to `wcd938x_sdw_device_get'
> x86_64-linux-ld: wcd938x.c:(.text+0x25a1): undefined reference to `wcd938x_sdw_device_get'
> x86_64-linux-ld: wcd938x.c:(.text+0x262a): undefined reference to `__devm_regmap_init_sdw'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd938x: fix wcd module dependency
      commit: b9a4b57f423ff8ff9ab9b68a238bdc3e7678f723

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD304538C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhKPRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhKPRvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:51:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C730C61BD4;
        Tue, 16 Nov 2021 17:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637084892;
        bh=oHVUnmKqtUJ2idIe0wC+rujhKnApVnF0GkfvoERh4/E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=brSUvganuGB5+w6GsN5VLg5wKkcdaqU7h5e8Gk9ijauHYXAxaK+M7EzjhiLTzx91p
         C1N0aO0ADKp8Pi51+aWXxCruFNjNrB0iT7DhX0xsqRg55e42zytGqhUou+MXrxvAbI
         XBSTrWAjCVkqH0a60RncnwvyeShrFKPQHVFL1DfI5KKoW4Q/fiLorexWtuaKTK6SUl
         UGme7o/al8vEbuJrjZXF77hOtLKF/JEisTruZnIp0aoJfBHg4bqo0ZditbpsRDMLNu
         9dmCOcSIlo/OCiro8a7QFhUZd6f5Oh7cAv2Oy16gfHBDmoKvDf1hL8W0WrGOpqA0PK
         v31f90kBUmcmA==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com
In-Reply-To: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
References: <20211116114623.11891-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/3] ASoC: codecs: Qualcomm codecs fixes
Message-Id: <163708489055.808719.15130642292756226191.b4-ty@kernel.org>
Date:   Tue, 16 Nov 2021 17:48:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 11:46:20 +0000, Srinivas Kandagatla wrote:
> We found few issues during runtime pm testing on this codecs.
> These 3 patches for wcd938x, wcd934x and lpass-rx-macro should address them.
> 
> Thanks,
> srini
> 
> Srinivas Kandagatla (3):
>   ASoC: codecs: wcd938x: fix volatile register range
>   ASoC: codecs: wcd934x: return error code correctly from hw_params
>   ASoC: codecs: lpass-rx-macro: fix HPHR setting CLSH mask
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/3] ASoC: codecs: wcd938x: fix volatile register range
      commit: ea157c2ba821dab789a544cd9fbe44dc07036ff8
[2/3] ASoC: codecs: wcd934x: return error code correctly from hw_params
      commit: 006ea27c4e7037369085755c7b5389effa508c04
[3/3] ASoC: codecs: lpass-rx-macro: fix HPHR setting CLSH mask
      commit: cb04d8cd0bb0b82acc34cc73cb33ae77cbfb020d

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

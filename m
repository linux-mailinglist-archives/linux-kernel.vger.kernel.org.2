Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39C319064
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhBKQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhBKPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:40:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 081C364E8B;
        Thu, 11 Feb 2021 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613057974;
        bh=LsU6IY0XMvB35GCkDSTyQJjmM/Iv44ftFdEgZbsQGzo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=I7qwTeL246KJjiI9qrbAo9OfDiaTLtBfHqWRmF2UDaKuNvQEw9HVa7/O/o3V6hDUg
         hZnsF92tW2J10kdBGkX2roF1PUo6he4vxFVy0TeCfor8ebJmn8eWLFvkYEEw6Iyp11
         kZv7qNqcPx+x/J/KohqG00KEIgN4MVZQFTurAfapkryRBv+fby5VEQ/dr//X4gUMAR
         +I4g3c7ur4ZR6BED1N9Ht9LmD1FjeCbUWf46mT2mq6i4c9Dto5xSXqMX/+yvE7LyW4
         ph80WGB4yrsLIAzmlHXdNcmmni9ZDFI8eOisSrysMlFQen4l5lwNiWp3xYvlEKc+ZF
         MrMeiGpGY9YKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
References: <20210211122735.5691-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 0/7] ASoC: codecs: add support for LPASS Codec TX and RX macros
Message-Id: <161305792123.12370.16328158570413320155.b4-ty@kernel.org>
Date:   Thu, 11 Feb 2021 15:38:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 12:27:28 +0000, Srinivas Kandagatla wrote:
> This patchset adds support for two Codec Macro blocks(TX and RX) available in
> Qualcomm LPASS (Low Power Audio SubSystem).
> 
> There are WSA, VA, TX and RX Macros on LPASS IP, each of the Macro block
> has specific connectivity like WSA Macros are intended to connect
> to WSA Smart speaker codecs via SoundWire. VA Macro is intended for DMICs,
> and TX/RX for Analog codecs via SoundWire like other WCD938x Codecs to provide
> headphone/ear/lineout/amic/dmic etc ..
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: qcom: dt-bindings: add bindings for lpass rx macro codec
      commit: f133de9e32374841c5ed1ad5cf18ed14098a0f4c
[2/7] ASoC: codecs: lpass-rx-macro: add support for lpass rx macro
      commit: af3d54b99764f0bdd83fcbd1895d23b83f8276be
[3/7] ASoC: codecs: lpass-rx-macro: add dapm widgets and route
      commit: 4f692926f562ff48abfcca6b16f36ff8d57473b6
[4/7] ASoC: codecs: lpass-rx-macro: add iir widgets
      commit: f3ce6f3c9a994d3fa5057cadfaa1d883e0d938fa
[5/7] ASoC: qcom: dt-bindings: add bindings for lpass tx macro codec
      commit: ca955cc980afc066a380567e371480634e48eb7e
[6/7] ASoC: codecs: lpass-tx-macro: add support for lpass tx macro
      commit: c39667ddcfc516fee084e449179d54430a558298
[7/7] ASoC: codecs: lpass-tx-macro: add dapm widgets and route
      commit: d207bdea0ca9efde321ff142e9b9f2ef73f9cdf5

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

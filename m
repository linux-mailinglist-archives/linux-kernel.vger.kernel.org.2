Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288EB32A04D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhCBEMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344615AbhCAXgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:36:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BE5060240;
        Mon,  1 Mar 2021 23:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614641763;
        bh=X3zQMo928GW1qVxc5UjuLGk4bT1FV3lRMqtNQ5gZEHQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=s1P7a/mjPGC7cZDiw1TfVmHhV0R72JCZggtix7XvoqHKtV3+2Fwj7gNdwveotxJSo
         Ns08mHLd6d4I0ATAfU5c7q+CHXFWUg8Mp1eFs6Y5mQrIPuxn3goxofVqAziZQTkcZF
         HOTb8a6fnL61+In1rc16SLanz4mCK4shbNUmoGBPnWObU8K5exmkrDivVHtT6g1YBI
         aNfRNtO77UHIwhR/FeqXzrJ5i9smW5lMqmZ/+5LSrpX0LfjT/hNvF/nMEQzBvXAj7a
         CA+FMKRSYJuJyWVDppqtP1eWAxmJrTuUAHCqXzKUsH3TGbk5/2IzgbknebgTdJ85lX
         vohvxTS4hHU/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20210221153024.453583-1-krzk@kernel.org>
References: <20210221153024.453583-1-krzk@kernel.org>
Subject: Re: [PATCH] ASoC: constify of_phandle_args in snd_soc_get_dai_name()
Message-Id: <161464168095.31144.11030304529781910068.b4-ty@kernel.org>
Date:   Mon, 01 Mar 2021 23:34:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Feb 2021 16:30:24 +0100, Krzysztof Kozlowski wrote:
> The pointer to of_phandle_args passed to snd_soc_get_dai_name() and
> of_xlate_dai_name() implementations is not modified.  Since it is being
> used only to translate passed OF node to a DAI name, it should not be
> modified, so mark it as const for correctness and safer code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: constify of_phandle_args in snd_soc_get_dai_name()
      commit: 54928c5c63c83afd5a1c2a91802a9c37e9a4ff88

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

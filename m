Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C439AA4A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFCSoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230203AbhFCSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:44:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53EEB613F6;
        Thu,  3 Jun 2021 18:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622745770;
        bh=QX2fUiCiUmkxlGVHfxkr10DT8U2SkzWtLEr1gPbhSJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/yoLykbA2nbCiCPzNXK5wuNLtsWUWwzswOFPDtigEoGBh919yhCp5x/Fxn86U0KU
         C2Om9LQzx6vdrWoHWCcVcxLKIjfuOhrscbhTrwKJIILodx9mLI4x7ZR41lMjrlmGAo
         xGwur70iBcThRy4us3by+zZ7UkI0tWISZq6ivvVYnCvYBsSZeUCuDkIk99VS3FKXiI
         E3DoWJYF2dLclCqPv+A6qGo3v5+jt0yvuXEl7TJeOLwW1+5/aqBIYCyayajqTP8f/W
         OAqdC+w9OnUmge4auSIjBj66YZjpMuB/qhWovoHfSA5kDRfxAPQk7UQWVftM/Lxnxm
         tzhICfRiwbsig==
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: meson: gx-card: fix sound-dai dt schema
Date:   Thu,  3 Jun 2021 19:41:57 +0100
Message-Id: <162274557551.14795.13902548000738010349.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524093448.357140-1-jbrunet@baylibre.com>
References: <20210524093448.357140-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 11:34:48 +0200, Jerome Brunet wrote:
> There is a fair amount of warnings when running 'make dtbs_check' with
> amlogic,gx-sound-card.yaml.
> 
> Ex:
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:1: missing phandle tag in 0
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0:2: missing phandle tag in 0
> arch/arm64/boot/dts/amlogic/meson-gxm-q200.dt.yaml: sound: dai-link-0:sound-dai:0: [66, 0, 0] is too long
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: gx-card: fix sound-dai dt schema
      commit: d031d99b02eaf7363c33f5b27b38086cc8104082

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

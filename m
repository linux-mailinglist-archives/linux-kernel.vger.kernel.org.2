Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182103F89EC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhHZORF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHZORE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:17:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9776660698;
        Thu, 26 Aug 2021 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629987377;
        bh=19+SFriioNrfn3fwOrICbeSKe/bS5e7OWPAEUGfvvhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiooJBf9vLHfA09AxSvssoyn5b3Bc2xmYjYaAxykMO2iKnb2iN9ekqCwAlZxQHzEK
         uLLysvFtjaJz84LAO+B2tysgq/eWeVtlYPJQWV5FmVRl2hcavEa2U9T8t+r3DD20BY
         mGbPAbnc2UoF6ISLRcF5HDPi4g8AYCPTOyQgUjDG0vULCorsXNgbJsMoNBliliFYPg
         gkREbGYP1VB/nBgfTH3RRipsuUJ/+qM72Ar8Nu2v0LV97tN/2u/6vtTsAsDtg+GgVI
         m5VSOy9qqqn8E42UYKYiXKQ7QqozvBfuN6QmgNHqc47ozhekbZwfIXUN8CUTyNMCbN
         iKagMWY1z60Jw==
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, Sugar Zhang <sugar.zhang@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        linux-rockchip@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Patches to update for rockchip spdif
Date:   Thu, 26 Aug 2021 15:15:43 +0100
Message-Id: <162998707937.5647.10936208575135633257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 18:15:58 +0800, Sugar Zhang wrote:
> These patches fixup or update for rockchip spdif.
> 
> 
> Sugar Zhang (4):
>   ASoC: rockchip: spdif: Mark SPDIF_SMPDR as volatile
>   ASoC: rockchip: spdif: Fix some coding style
>   ASoC: rockchip: spdif: Add support for rk3568 spdif
>   ASoC: dt-bindings: rockchip: Add compatible for rk3568 spdif
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rockchip: spdif: Mark SPDIF_SMPDR as volatile
      commit: 023a3f3a1c4f9be9cc1ae92579ba816120fb5807
[2/4] ASoC: rockchip: spdif: Fix some coding style
      commit: acc8b9d117912c2d5952868fba0d4fca49cde3c8
[3/4] ASoC: rockchip: spdif: Add support for rk3568 spdif
      commit: c5d4f09feb9f74e704d87a304f0c20001488fe10
[4/4] ASoC: dt-bindings: rockchip: Add compatible for rk3568 spdif
      commit: e79ef3c2cfe0b39878496eac87450698a2e84e3f

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

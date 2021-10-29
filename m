Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F0744046A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhJ2U5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229873AbhJ2U5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:57:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C58861040;
        Fri, 29 Oct 2021 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635540893;
        bh=qt4og9Fk7MtpFFfEOnHKFzZTdGtwK1yfX8BOnwu7CqM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fX1QFv7/QAAsW97/KCa5wDhm8WTFalr/iCJWWYJ0pjCll+Ky2CeOdXDARLGi/sa1L
         459epb3y2pxuNLu54AVIle9ZWWv8evknCLiVqXRuAcHWcDeKyWnjsoD92WUJ4WPOz9
         UzG8pkcPteVm5mnXbGsnkYGRFEg6khMG3sixGm3tLL+vHr1WyASVngxmta3bpYA75G
         C2D5YwEA3eFUt7Hvs+tUczXLYJYAmiMnQaMb2u4HbZnSDprXkExwVDK+HLv7vqG0bp
         Gf0WoQbBG/bJHTXvpxae1wb9U6a1tYqSR54bERK2sRQlHi/E+gsLRas+9y8QtQhpDd
         JQDD/2IH/4e6Q==
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaronyu@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20210910104405.11420-1-trevor.wu@mediatek.com>
References: <20210910104405.11420-1-trevor.wu@mediatek.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: Add support for MT8195 sound card with rt1011 and rt5682
Message-Id: <163554089106.1997146.15357204802778257361.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 21:54:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 18:44:03 +0800, Trevor Wu wrote:
> This series of patches adds support for mt8195 board with mt6359, rt1011
> and rt5682.
> Patches are based on broonie tree "for-next" branch.
> 
> Trevor Wu (2):
>   ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and
>     rt5682
>   dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682
>     document
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and rt5682
      commit: 0261e36477cfa2608468c1300e30cb667c5e1269
[2/2] dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682 document
      (no commit info)

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

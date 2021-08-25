Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECC43F72E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbhHYKYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238993AbhHYKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 988186120A;
        Wed, 25 Aug 2021 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629886996;
        bh=aSw0cYg8pm1YpmSlIfShp0oFUe+o66pjQZD/ue8nx7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6pCHwq+W37Vca+6PO7MFagSCJAHN1FyCXp2CbRoMMSY2CFXOwiPxIPsXTiPXKXpC
         9qTnfQ6cknl3Sn4UfcAeMTCwEvzkwrWMDQ/QKCCUzoc56NIzdJghGyfUzxSXEy5NMv
         JZ1G/81gDBZfh5MKewFvY82vbD1on2dOeBfAxwawW3GbpI68GRUCPhgi2WRqaCo4O9
         XUpOkT+rFAOKA1ja7mMji9/vtQQsT8WvkbPI1Jk5yFzCfLpeyXmOPbcl9AH+sny/pH
         WdvjU1HHWi/loFwSoxwPZGaxdd3oTCr4ErPGsKeR08YxfEt7jb8REj7Kw0pBPjnEct
         sqFBCsg7K6i1g==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, matthias.bgg@gmail.com,
        Trevor Wu <trevor.wu@mediatek.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, jiaxin.yu@mediatek.com,
        linux-mediatek@lists.infradead.org, bicycle.tsai@mediatek.com,
        aaronyu@google.com, alsa-devel@alsa-project.org,
        cychiang@google.com, wenst@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/11] ASoC: mediatek: Add support for MT8195 SoC
Date:   Wed, 25 Aug 2021 11:22:39 +0100
Message-Id: <162988521424.7213.9083414971201440076.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819084144.18483-1-trevor.wu@mediatek.com>
References: <20210819084144.18483-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 16:41:33 +0800, Trevor Wu wrote:
> This series of patches adds support for Mediatek AFE of MT8195 SoC.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v4:
>   - removed sof related code
> 
> Changes since v3:
>   - fixed warnings found by kernel test robot
>   - removed unused critical section
>   - corrected the lock protected sections on etdm driver
>   - added DPTX and HDMITX audio support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/11] ASoC: mediatek: mt8195: update mediatek common driver
        commit: cab2b9e5fc0e868ed8453ef4f433c795bda8bf84
[02/11] ASoC: mediatek: mt8195: support audsys clock control
        commit: d62ad762f67585acfb5e03f71b28a52dc4604cf2
[03/11] ASoC: mediatek: mt8195: support etdm in platform driver
        commit: 1de9a54acafba2f0e3ea2856ad0b22556d59ec45
[04/11] ASoC: mediatek: mt8195: support adda in platform driver
        commit: 3de3eba588bb7f6c39bf12de5761ff75c53b9961
[05/11] ASoC: mediatek: mt8195: support pcm in platform driver
        commit: 1f95c019115cc503c4c47fd7108675a56cdb29b4
[06/11] ASoC: mediatek: mt8195: add platform driver
        commit: 6746cc858259985a945a07075a19ec4d24352407
[07/11] dt-bindings: mediatek: mt8195: add audio afe document
        commit: b5bac34fcfb444e33f532e291ad1394ca05887e8
[08/11] ASoC: mediatek: mt8195: add machine driver with mt6359, rt1019 and rt5682
        commit: 40d605df0a7bf7723ed690f502f364c5320de440
[09/11] ASoC: mediatek: mt8195: add DPTX audio support
        commit: e581e3014cc4acee9025aa5704cf85a36a572b95
[10/11] ASoC: mediatek: mt8195: add HDMITX audio support
        commit: ef46cd42ecf00f0468df3ad1bf0f30db9634a04a
[11/11] dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1019-rt5682 document
        commit: 5f8c991e8950971cd1f81b61f79c83a511ad9fc8

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

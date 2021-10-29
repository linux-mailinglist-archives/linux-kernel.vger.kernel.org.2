Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F069544046B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhJ2U5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230253AbhJ2U5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8172A61075;
        Fri, 29 Oct 2021 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635540895;
        bh=pOJQpgaSJK6t2EtQjZhIopjYqTh/FOv6CfFCmJ6dhqE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uS4HqaU85jBAkWVmi6fs6wzFG4WpNMC6VW447pGwOE+NKlvNBnhPvm4cdRS9InG/b
         bu11Ky4Ccr3F9Uxf3o0vtuSd8WdKyd1/a3UHaV0bGxVu06yq/MDsME2H3tBuy57bv1
         vA9X1746ZihdPiJJ2FbJZBAqTnotLaPRDkY+Ev2nE9shgUngx7bk2bQ7R5f/yGDWop
         yY7j2BGx55uz5QNVZagVJsUqtBoUojgqvBzcLAw5OwpeMHaK1POpmF4WM280kHuCmV
         cmwcZBniKmeo2aWcem3Q3sYFU63/sRXLGjFNS+BMC8BeTLzbDjyZrG63CPi5u/A6bW
         /Su2O7yYK4MCQ==
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaronyu@google.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20211020071428.14297-1-trevor.wu@mediatek.com>
References: <20211020071428.14297-1-trevor.wu@mediatek.com>
Subject: Re: [RESEND,v2 0/2] ASoC: mediatek: Add support for MT8195 sound card with rt1011 and rt5682
Message-Id: <163554089329.1997146.2620727675711869109.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 21:54:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 15:14:26 +0800, Trevor Wu wrote:
> This series of patches adds support for mt8195 board with mt6359, rt1011
> and rt5682.
> Patches are based on broonie tree "for-next" branch.
> 
> Changes since v1:
>   - refined code based on Pierre-Louis's suggestions
>   - added missing of_node_put
>   - fixed wrong fixup assignment on HDMITX
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt8195: add machine driver with mt6359, rt1011 and rt5682
      commit: 0261e36477cfa2608468c1300e30cb667c5e1269
[2/2] dt-bindings: mediatek: mt8195: add mt8195-mt6359-rt1011-rt5682 document
      commit: 6c8552ebba7742e7128134859846e17edbfdf222

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

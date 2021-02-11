Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACBE319065
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhBKQwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230399AbhBKPkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:40:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D53A864E8A;
        Thu, 11 Feb 2021 15:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613057980;
        bh=WkhNi8ol3f1VI1S+4Gsf371AiJwJ79gqlKtzjzdXMUA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JkknHSnZybPCBxcOILruAYK5wW9P5YV3XE/aWCQ3Wtd0GrsNhk9pRgH8ZUksmoAdC
         MCV7CJtO4USAGKEqO7pfZNvjRsoh4amQYycd6fpLhsLrv84ORSbOt711/oEYtOUDv/
         P89h8UE53rLYviDDI1WxHviiQHWH8mnusX15/aIhnjd1uY7Jt7uL/lWLr1GWGla+OW
         F2s0Vw0tL9MKeFnQP6NqGs1cOhoaSf3jYcox6fxY6tscTJkyZ1szjlxNhuavfKV9MH
         DiYPqTD+q50y8xyQtvLkAnmIKNeGIFLKabwknGXHYOyc4n8zhIaTc1aiFD2jAOeJU0
         FGqHwT1DXsOnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, sharadg@nvidia.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com
In-Reply-To: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
References: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH 0/3] Use clocks property in a device node
Message-Id: <161305792123.12370.8611418623618908867.b4-ty@kernel.org>
Date:   Thu, 11 Feb 2021 15:38:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021 12:13:38 +0530, Sameer Pujar wrote:
> It is recommended to not specifiy clocks property in an endpoint subnode.
> This series moves clocks to device node.
> 
> However after moving the clocks to device node, the audio playback or
> capture fails. The specified clock is not actually getting enabled and
> hence the failure is seen. There seems to be a bug in simple-card-utils.c
> where clock handle is not assigned when parsing clocks from device node.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: simple-card-utils: Fix device module clock
      commit: 1e30f642cf2939bbdac82ea0dd3071232670b5ab
[2/3] Revert "ASoC: audio-graph-card: Add clocks property to endpoint node"
      commit: 0be0f142b8323378df6358c36dd15494134f5b94
[3/3] arm64: tegra: Move clocks from RT5658 endpoint to device node
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

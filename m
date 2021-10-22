Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D550436F22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhJVAzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhJVAzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:55:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18B166135E;
        Fri, 22 Oct 2021 00:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634863978;
        bh=mH7GdbWGt4HKolhZrvahIHWGiMTWStm6bmleErRylaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PI307ggATI6Lj3AJra27XvUoy0evLCnu9VFMnrrvZ/N0TcDzGov5xbxIWA8ZUyZ5G
         SMyRiBm+fD758cSxCHoWNM1tESAShCWYEd34eDbLSThU8luIZJpgDeDKCDiauH/Tpf
         5AaiTVZSgeNAwcrnQ1PDiZ4tJ/HguyDcb2YFZjkkQb1M44MevtzRKs0VM/6mvFE9mi
         tXfpFAUeKJYNHeZ/fBh56JCuyDGNjB7Bc9JTiQkh6mt8j3mn5w3GFNhAauWBDUKnBe
         5GIvdGOY6qVfmtD4NyeOLByrczShpuodyG0gQPNP5IzKXEkmVLU0eRqZuPvlwJ8/5B
         JUtGQdDrnszng==
From:   Mark Brown <broonie@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] regulator: Introduce UniPhier NX1 SoC support
Date:   Fri, 22 Oct 2021 01:52:47 +0100
Message-Id: <163486395941.2610269.5320640167922930528.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1634520605-16583-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1634520605-16583-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 10:30:03 +0900, Kunihiko Hayashi wrote:
> This series includes the patches to add basic support for new UniPhier NX1
> SoC. NX1 SoC also has the same kinds of controls as the other UniPhier
> SoCs.
> 
> Kunihiko Hayashi (2):
>   dt-bindings: regulator: uniphier: Add binding for NX1 SoC
>   regulator: uniphier: Add USB-VBUS compatible string for NX1 SoC
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: uniphier: Add binding for NX1 SoC
      commit: 4c1ef56bd9c7a60efdeac9f1478b5467fb47c093
[2/2] regulator: uniphier: Add USB-VBUS compatible string for NX1 SoC
      commit: 32e84faa825e8bc6431186a41b68e0fcff857b72

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

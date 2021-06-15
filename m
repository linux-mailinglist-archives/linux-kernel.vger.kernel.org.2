Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964873A8784
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFORbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhFORbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:31:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F374461403;
        Tue, 15 Jun 2021 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623778183;
        bh=yy7t97BHnyF+ap84e5HtZL+6un7GoYrR+F8hjw5yABc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7HXUO549VJ3Tsz/hR9q8bcJQF8Ge9Gi+UueSiPeSmrykkxs4Xsfx6C5CMgCatbHi
         Qe7fK8btYs6XrGvPiVUf4bBLpXGCev66x3BCDnwPOBKRvgwbLrg7AbKzoyD/u6gI4/
         CNi7BZQAxzoVC+9/k8HyrRNSdu2ezRETKNv3QhzIYIf17nQId+YElF1dA/L3/is5YZ
         Afjt/jgAvqXcRIo2RG8F3moUqEUjqSo4r3gfwd5nhwxh9P5bQcGix8QdHq8LssEjH5
         ayCOMYhCh/00Gs4MXciqNema2rdt5LG+1xtWvVdRRSInJhKR6DvpOrrd7kNInSpqZZ
         YlzGY+7iHScvQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: mt6315: Fix checking return value of devm_regmap_init_spmi_ext
Date:   Tue, 15 Jun 2021 18:29:16 +0100
Message-Id: <162377794810.21860.5044307208593941220.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210615132934.3453965-1-axel.lin@ingics.com>
References: <20210615132934.3453965-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 21:29:34 +0800, Axel Lin wrote:
> devm_regmap_init_spmi_ext() returns ERR_PTR() on error.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6315: Fix checking return value of devm_regmap_init_spmi_ext
      commit: 70d654ea3de937d7754c107bb8eeb20e30262c89

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

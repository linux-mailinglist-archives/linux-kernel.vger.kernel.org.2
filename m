Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9BE3C5AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhGLKul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234288AbhGLKuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:50:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBB8A61154;
        Mon, 12 Jul 2021 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626086835;
        bh=ONWe2l21GigqNp5iTgFw6yypYHKVqWp4IvDTNnU3EHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q2Tb5rfHjuxz0RpXe2zHIxYZgxK7Bza7hdeGhCSNf1aAkDCfBuSzRyb6ATkZNF7Ku
         ckrox5yp4nHa3fUFszT/nGHxdnoXiYeQNhPQsrqp8PPqqoyZ1X8HuHxHpnbQur3ZTQ
         U2cdDFnpulewVQNHzJVCwzdXbTGZwT8utnwrW+E4K8wzEpoc+b7cfkMzAoyIX8tbey
         fkAoveq+aeVdRiJA9gReiZfDgrW2+lFZaKjHblxW4bC04I3QRSdGan1836ntZln6bS
         oWOQw2mp3FPx3MkkKyrXV7+JgC9xaG0ipErt1pwBdKhK7GPzHiyOonQTAqkjJM75fw
         i4yw0pogdnKKQ==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Guodong Xu <guodong.xu@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH RFT] regulator: hi6421: Fix getting wrong drvdata
Date:   Mon, 12 Jul 2021 11:45:48 +0100
Message-Id: <162608654079.4419.14681068957546195673.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210630095959.2411543-1-axel.lin@ingics.com>
References: <20210630095959.2411543-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021 17:59:59 +0800, Axel Lin wrote:
> Since config.dev = pdev->dev.parent in current code, so
> dev_get_drvdata(rdev->dev.parent) call in hi6421_regulator_enable
> returns the drvdata of the mfd device rather than the regulator. Fix it.
> 
> This was broken while converting to use simplified DT parsing because the
> config.dev changed from pdev->dev to pdev->dev.parent for parsing the
> parent's of_node.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: hi6421: Fix getting wrong drvdata
      commit: 1c73daee4bf30ccdff5e86dc400daa6f74735da5

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

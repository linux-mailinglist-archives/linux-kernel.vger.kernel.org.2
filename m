Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCEE3B1E53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFWQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhFWQLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:11:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 062F6611C9;
        Wed, 23 Jun 2021 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624464571;
        bh=T2HXfNyzx3AS/mZLCTF/VYpLDzx4pOUOAoKS+LJ5qdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWJZknoaZIRW6MAgdOre9B/EVXthhXWtEZu9QzQjo+OxsDYbJQKqQD7mowC1sebEJ
         F4O36J72t0Uvn1e0PhPOpsmQSXUtwUU0EckbKU+Hhq1CV3571kyGZlHYNVIDAjkwZw
         pRnfJvwava/E56U+iCBWe35LFpTHWgoFTJX59B2e8LWWEpJM4dmwP65Jx7VWgj6gRa
         Fqm6ZOUrZYfV8hD6iji6Qt8qP48cYMp1KM3szmsZTZb9PSdiW8rmrFVxVkTf3nXNpR
         6byoQlkTM0HKaDERegiJV/VUvTjtROuNzw1XS4QnOHO7Lge+bX/gdYht4ZATL7dY1/
         VxQ9MIof0CmCg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, axel.lin@ingics.com,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] regulator: mt6358: Fix vdram2 .vsel_mask
Date:   Wed, 23 Jun 2021 17:08:52 +0100
Message-Id: <162446430311.55481.15380134833994033517.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1624424169-510-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1624424169-510-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021 12:56:09 +0800, Hsin-Hsiung Wang wrote:
> The valid vsel value are 0 and 12, so the .vsel_mask should be 0xf.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6358: Fix vdram2 .vsel_mask
      commit: 50c9462edcbf900f3d5097ca3ad60171346124de

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

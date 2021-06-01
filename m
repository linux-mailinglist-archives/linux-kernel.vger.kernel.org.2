Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F53397942
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhFARku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234663AbhFARk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:40:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47EC6613CE;
        Tue,  1 Jun 2021 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622569127;
        bh=TaBf9jspzUZLFgy5rji7/O6yO0u7Pna6QH03dvSF3Ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPGKTRJWi8T4uNTmk+XuSxN7niA6DMTX7rLLjdUWD9mps2UIFb1XNm1fw02fIZMLM
         aSo8wL5MlE5tM2GApYNVI52oMJN6G47Gi6m51Sc+3lOzKxWDBYW+FXytnYI1JBwJm3
         24LeAddrim0fzhA083mILk0pGi0RNJNpToJmGV45BNe1/DQD+HLhh8OOxraWf2cgfE
         SRztJ/tGFODeiqL4+/paWUkqnSqoJ+fqmkLUrPpXN7MeZlA8V1EdAus6uT4nFYI9Hw
         xsBJ9Bxc6b1OGdan/+3vWW5wnqMPIV9c3FfaB/mD3SLJY8zKb28PuSvxoYbHGOTF4Q
         MhyYx8OyCGPGA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH] regulator: mt6315: Fix function prototype for mt6315_map_mode
Date:   Tue,  1 Jun 2021 18:38:07 +0100
Message-Id: <162256901745.20048.12172166349641530596.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210530022109.425054-1-axel.lin@ingics.com>
References: <20210530022109.425054-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 May 2021 10:21:09 +0800, Axel Lin wrote:
> The .of_map_mode should has below function prototype:
> 	unsigned int (*of_map_mode)(unsigned int mode);

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6315: Fix function prototype for mt6315_map_mode
      commit: 89082179ec5028bcd58c87171e08ada035689542

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

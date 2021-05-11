Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CE037A1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEKIaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhEKI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19751613C3;
        Tue, 11 May 2021 08:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721705;
        bh=RSHOPfuP6d2uabLkKal2d2xhCS9VMtr0Me6iKlfK9QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6lgLnQ7iUAGp4hTfiKvleNPFOX6SocVgNfLcLUhfnKbdy8bEc1KDawBabJrpzs5F
         mNONJjUMthoW4CVcg7NAs1Y9slD2NfyjsXeUA6aIfw4cbVBWU3/y7Mdz7MwsFyjXc0
         5J1HPLdk9Cl9WugljW6ohDoOlYrTbA//1Gfr+HqGGycKynIqIuWCDzlPcFPbI9ImuZ
         PAElxqQkfkq+te1/dj2YzlHIpU1jq62etl9FTR9F5NTniGg5MqIu6DDQtD162ONkPs
         sMLsWTH8dAaCp8AALjCSP1/YDFMly088umRvdAOcUrwaZHIrfFgGl/NwDPFSyZdsXI
         rG2QAeocThQYQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        perex@perex.cz, tiwai@suse.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ak5558: Correct the dai name for ak5552
Date:   Tue, 11 May 2021 09:26:04 +0100
Message-Id: <162072058170.33157.387118407952488972.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620470807-12056-1-git-send-email-shengjiu.wang@nxp.com>
References: <1620470807-12056-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 18:46:47 +0800, Shengjiu Wang wrote:
> Correct the dai name for ak5552. The name should be "ak5552-aif".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak5558: Correct the dai name for ak5552
      commit: b23584d6ce0212b9ad6cb7be19a7123461ed9e09

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

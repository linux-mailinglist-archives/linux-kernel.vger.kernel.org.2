Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72742389348
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355100AbhESQMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240705AbhESQMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05992611BF;
        Wed, 19 May 2021 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621440663;
        bh=+hzflIl7NNcJ2gbpJkhKu/53r/LpXiCYKTLYsUN5KNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZgrLRsJLWqgVBb6AIy0McbTl8ajcZ6vkhyXw+fL6eDSvlD3BcHmeeNpXNJKcLKGf
         xLe3GLU+xe1UnWnBfWC2wjG2P4DPtdTcgNkNyiCsGGkD4rCDExE1iYOdcRrdA4B0HH
         yHdoUHHuSIqB64/78RrlmbJXq1A+YNjKRtNz1VhxJ/VRkh8awMUilWoIbvOrNurwjZ
         WUxM+7yv5PrKBF3Z57eXrCDZg13VHLTPvsGDiEASRqcUgN1SXjyQMyAtJjz39QlJVn
         jgrQN/AGNx+jclQjFPcIpcalSdOItGKYcXzht3EQiGjLFRTyO1prlevfM7qQg8Fhnc
         yotaFBGel+HnA==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v2] regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
Date:   Wed, 19 May 2021 17:10:10 +0100
Message-Id: <162144038078.37201.13842625439726984662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210519132255.1683863-1-axel.lin@ingics.com>
References: <20210519132255.1683863-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 21:22:55 +0800, Axel Lin wrote:
> Return -EINVAL if ramp_delay_table is NULL.
> Also add WARN_ON since the driver code needs fix if this happened.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
      commit: 687c9e3b1a81d43b233482f781bd4e20561bc390

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
